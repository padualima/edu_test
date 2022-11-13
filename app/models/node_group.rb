class NodeGroup < ApplicationRecord
  # relations
  has_ancestry

  # validations
  validate :check_if_invalid_ancestry, on: :create

  def check_if_invalid_ancestry
    return if ancestry.nil?

    errors.add(:ancestry, "Invalid Ancestry Tree") unless parent.is_root?
  end
end
