require 'csv'

module Actions
  module Synchronizers
    class Csv < Base
      def parse_data
        @log.info("Start parser data")
        csv_parse = CSV.foreach(
          @data.path,
          headers: true,
          col_sep: ';',
          header_converters: :symbol,
          liberal_parsing: true
        )

        @data = csv_parse.map do |row|
          return false unless row.headers == required_headers

          %i[txnomeparlamentar sguf txtdescricao txtdescricaoespecificacao txtfornecedor]
            .each do |h|
              row[h]&.upcase!
              row[h].delete!("/[.]$/") if row[h].match?(/[.]$/)
            end

          row.to_h
        end

        @log.info("filtering the data")

        if @filter.any?
          @data.delete_if { |row| !@filter.include?(row[:sguf]) }
        else
          @data.delete_if { |row| row[:sguf] == 'NA' }
        end

        @log.info("Parser data finished")
      end

      def required_headers
        [
          :txnomeparlamentar, :cpf, :idecadastro, :nucarteiraparlamentar, :nulegislatura, :sguf,
          :sgpartido, :codlegislatura, :numsubcota, :txtdescricao, :numespecificacaosubcota,
          :txtdescricaoespecificacao,:txtfornecedor,:txtcnpjcpf,:txtnumero, :indtipodocumento,
          :datemissao, :vlrdocumento, :vlrglosa, :vlrliquido, :nummes, :numano, :numparcela,
          :txtpassageiro, :txttrecho, :numlote, :numressarcimento, :vlrrestituicao, :nudeputadoid,
          :idedocumento, :urldocumento
        ]
      end
    end
  end
end
