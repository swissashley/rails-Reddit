class VotesController < ApplicationController

  def upvote
    @post = Post.find_by(id: params[:post_id])
    @vote = Vote.new(value: 1)
    #FIXME Buggy!!
    # @vote.user = current_user
    @vote.post_id = @post.id

    @vote.save!

  end

  def downvote

  end
end
