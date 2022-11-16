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

        return false unless csv_parse.first.headers == required_headers

        @data = csv_parse.map(&:to_h)

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
