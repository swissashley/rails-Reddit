# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string           not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :content, :user_id, :post_id, presence: true

  belongs_to :post

  belongs_to :comment,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :comments,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :votes, as: :voteable

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User



end
