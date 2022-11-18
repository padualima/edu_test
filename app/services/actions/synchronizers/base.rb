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
          @group =
            NodeGroup.find_or_create_by!(slug: row[:numano], kind: NodeGroup.kinds['year'])

          group_child = NodeGroup.find_or_create_by!(
            slug: row[:sguf].upcase,
            kind: NodeGroup.kinds['state'],
            ancestry: @group.id
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

      def expenses_incrementer # TODO: Refactor this method
        portfolios = Portfolio
          .joins(:node_group)
          .where(node_groups: { slug: @filter, ancestry: @group.id })

        @log.info("Calculating the total value of each Expense of this Portfolio")
        Expense.where(portfolio: portfolios).find_each do |expense|
          expense.update!(
            amount_cents: expense.expense_companies.pluck("sum(value_cents)").first
          )

          expense.portfolio.expenses.order(amount_cents: :desc).each_with_index do |e, i|
            position = i.next
            e.update!(position: position) if position != e.position
          end
        end
        @log.info("Finish update amount to Expenses")

        @log.info("Calculating the value of all expenses for the Portfolio")
        portfolios.find_each do |portfolio|
          portfolio.update!(
            expenses_amount_cents: portfolio.expenses.pluck("sum(amount_cents)").first
          )

          portfolio
            .node_group
            .portfolios
            .order(expenses_amount_cents: :desc)
            .each_with_index do |port, i|
              position = i.next
              port.update!(position: position) if position != port.position
            end
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

