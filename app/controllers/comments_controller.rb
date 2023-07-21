# frozen_string_literal: true

class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'haidang', password: '123456', only: %i[destroy edit update]
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to article_path(@article), status: :see_other
  end

  def +(amount)
    Money.new(@amount + amount.amount, @currency)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
