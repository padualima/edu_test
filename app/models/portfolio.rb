class Portfolio < ApplicationRecord
  belongs_to :node_group
  belongs_to :member
end
