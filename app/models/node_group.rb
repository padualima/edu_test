class NodeGroup < ApplicationRecord
  # enums
  enum :kind, %i[year state]

  # relations
  has_ancestry
  has_many :portfolios

  # validations
  validates :slug, presence: true
  validates :ancestry, presence: true, if: -> { kind == NodeGroup.kinds.keys[1] }
  validate :check_if_valid_year_slug
  validate :check_if_valid_state_slug
  validate :check_if_have_identical_siblings
  validate :check_if_invalid_ancestry

  # scopes
  scope :by_states, -> { where(kind: NodeGroup.kinds['state']) }
  scope :by_years, -> { where(kind: NodeGroup.kinds['year']) }
  scope :states_by_year, -> (y_group_id) { by_states.where(ancestry: y_group_id) }

  # class methods

  def self.oldest_year
    by_years.order(:slug).first
  end

  def self.states_allowed
    [	"AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA",
      "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO" ].sort.freeze
  end

  def self.start_year_allowed; 2008 end

  # objects methods

  def check_if_valid_state_slug
    return if kind == NodeGroup.kinds.keys[0]

    unless NodeGroup.states_allowed.include?(slug)
      errors.add(:slug, "Invalid Slug State")
    end
  end

  def check_if_valid_year_slug
    return if kind == NodeGroup.kinds.keys[1]

    unless (NodeGroup.start_year_allowed..Date.current.year).include?(slug.to_i)
      errors.add(:slug, "Invalid Slug Year")
    end
  end

  def check_if_have_identical_siblings
    if siblings.where.not(id: id).exists?(slug: slug)
      errors.add(:slug, "Already exists a NodeGroup with same slug")
    end
  end

  def check_if_invalid_ancestry
    return if ancestry.nil?

    errors.add(:ancestry, "Invalid Ancestry Tree") unless parent.is_root?
  end
end
