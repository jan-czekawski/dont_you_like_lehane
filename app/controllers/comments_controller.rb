class CommentsController < ApplicationController
  
  before_action :set_user
  before_action :set_book, only: [:new, :create, :destroy]
  before_action :set_comment, only: [:destroy]
  before_action only: [:destroy] do
    same_user(@comment)
  end

  def new
    @comment = @book.comments.new
  end

  def create
    @comment = @book.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment was added"
      redirect_to @book
    else
      render "new"
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment was deleted"
    redirect_to @book
  end

  private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

end
