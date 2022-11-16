class Member < ApplicationRecord
  has_many :portfolios

  def cpf_formatted
    CPF.new(cpf).formatted
  end
end
