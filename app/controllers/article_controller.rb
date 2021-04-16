class ArticleController < ApplicationController
    def index
      @article = Article.all
      render json: @article
    end
  end