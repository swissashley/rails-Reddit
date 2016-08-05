# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :sub_id, :user_id, presence: true

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    foreign_key: :post_id,
    class_name: :PostSub,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

end
