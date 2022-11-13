class NodeGroup < ApplicationRecord
  # enums
  enum :kind, %i[year state]

  # relations
  has_ancestry

  # validations
  validate :check_if_invalid_ancestry, on: :create

  # methods
  def self.states_allowed
    [	"AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA",
      "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO" ]
  end
  def check_if_invalid_ancestry
    return if ancestry.nil?

    errors.add(:ancestry, "Invalid Ancestry Tree") unless parent.is_root?
  end
end
