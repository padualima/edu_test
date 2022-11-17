module ApplicationHelper

  def fiscal_document_url(document)
    "https://www.camara.leg.br/cota-parlamentar/nota-fiscal-eletronica?ideDocumentoFiscal=#{document}"
  end

  def image_portfolio_url(ide)
    "http://www.camara.leg.br/internet/deputado/bandep/#{ide}.jpg"
  end

  def static_file_url
    "https://dadosabertos.camara.leg.br/swagger/api.html#staticfile"
  end
end
