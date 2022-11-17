module Actions
  module Synchronizers
    class Base
      def self.synchronizer(*args)
        new(*args).synchronizer
      end

      def initialize(args)
        @filter = args[:filter]
        @data = args[:data]
        @log = Rails.logger
      end

      def synchronizer
        parse_data
        ActiveRecord::Base.transaction do
          persit_data
          expenses_incrementer
        end
      end

      def parse_data; end

      def persit_data
        @log.info("Starting data synchronization")

        @data.each do |row|
          group =
            NodeGroup.find_or_create_by!(slug: row[:numano], kind: NodeGroup.kinds['year'])

          group_child = NodeGroup.find_or_create_by!(
            slug: row[:sguf].upcase,
            kind: NodeGroup.kinds['state'],
            ancestry: group.id
          )

          member = Member.find_or_create_by!(
            name: row[:txnomeparlamentar].upcase,
            cpf: row[:cpf],
            ide: row[:idecadastro]
          )

          portfolio = Portfolio.find_or_create_by!(
            node_group_id: group_child.id,
            member_id: member.id,
            uf: row[:sguf],
            parliamentary_number: row[:nucarteiraparlamentar],
            legislature: row[:nulegislatura],
            legislature_code: row[:codlegislatura],
            political_party: row[:sgpartido]
          )

          company = Company.find_or_create_by!(
            name: row[:txtfornecedor].upcase,
            document: format_document(row[:txtcnpjcpf])
          )

          category = ExpenseCategory.find_or_create_by!(
            description: row[:txtdescricao].upcase
          )

          expense = Expense.find_or_create_by!(
            portfolio_id: portfolio.id,
            expense_category_id: category.id
          )

          expense_company = ExpenseCompany.create!(
            expense_id: expense.id,
            company_id: company.id,
            ide_document: row[:idedocumento],
            description: row[:txtdescricao].upcase,
            exact_description: row[:txtdescricaoespecificacao],
            value_cents: row[:vlrliquido]&.to_money.cents,
            issued_at: row[:datemissao]
          )
        end

        @log.info("Data sync finished")
      end

      def expenses_incrementer
        portfolios = Portfolio.joins(:node_group).where(node_groups: { slug: @filter })

        @log.info("Starting update amount to Expenses")
        Expense.where(portfolio: portfolios).find_each do |expense|
          expense.update!(
            amount_cents: ExpenseCompany
            .where(expense_id: expense.id)
            .pluck("sum(value_cents)")
            .first
          )
        end
        @log.info("Finish update amount to Expenses")

        @log.info("Starting update expenses_amount to Portfolios")
        portfolios.find_each do |portfolio|
          portfolio.update!(
            expenses_amount_cents: Expense
              .where(portfolio_id: portfolio)
              .pluck("sum(amount_cents)")
              .first
          )
        end
        @log.info("Finish update expenses_amount to Portfolios")
      end

      protected

      def format_document(document)
        document.gsub(/\W/, '')
      end
    end
  end
end

