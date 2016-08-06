# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  value         :integer
#  voteable_id   :integer
#  voteable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
end
