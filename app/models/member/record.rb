class Member::Record < ApplicationRecord
  self.table_name = 'members'

  # associations
  has_many :portfolios

  # validations
  validates :name, :ide, presence: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :cpf, :ide, uniqueness: true
  validate :cpf_has_number_format

  def cpf_has_number_format
    errors.add(:cpf, "Invalid CPF Format") if cpf&.match?(/\W/)
  end
end
