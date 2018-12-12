class ReviewsController < ApplicationController
before_action :find_champion
before_action :find_review,  only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def edit

  end

  def update
    if @review.update(review_params)
      redirect_to champion_path(@champion)
    else
      render 'new'
    end
  end

  def destroy
    @review.destroy!
    redirect_to champion_path(@champion)
  end




  def create
    @review = Review.new(review_params)
    @review.champion_id = @champion.id  #we can used champion_id attribute becouse in find_champion method i set @champion variable
    @review.user_id = current_user.id # and this one i can used becouse used_id attribute i had set on review model

    if @review.save!
      redirect_to champion_path(@champion)
    else
      render 'new'
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_champion
    @champion = Champion.find(params[:champion_id])  # :champion_id instead of just :id cuz in reviews controller and review is associated with a champion_id
  end

  def find_review
    @review = Review.find(params[:id])
  end




end
