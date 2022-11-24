class Member::Record < ApplicationRecord
  self.table_name = 'members'

  has_many :portfolios
end
