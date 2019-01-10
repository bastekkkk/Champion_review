class ChampionsController < ApplicationController

  before_action :find_champion , only: [:show, :destroy, :update, :edit]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:lane].blank?
      #@champions = Champion.all.order(created_at: :desc)
      @champions = Champion.all.last_created
    else
      @category_id = Category.find_by(name: params[:lane])
      #@champions = Champion.where(category_id: @category_id).order("created_at DESC") #without scope
      @champions = Champion.where(category_id: @category_id).last_created #with scopre
    end

  end

  def new
    @champion = current_user.champions.build
    @categories = Category.all.map{|c| [c.name, c.id]} #this was used in champions/_form
  end

  def show
  end

  def edit
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  def destroy
    @champion.destroy
    redirect_to root_path
  end

  def update
    if @champion.update(champion_params)
      redirect_to champion_path(@champion)
    else
      render 'edit'
    end
  end


  def create
    @champion = current_user.champions.build(champion_params)
    @champion.category_id = params[:category_id]
    if @champion.save!
      redirect_to root_path
    else
      render 'new'
    end
  end



  private

  def champion_params
    params.require(:champion).permit(:name, :role, :attack, :armor, :health, :category_id, :champion_img)
  end

  def find_champion
    @champion = Champion.find(params[:id])
  end


end
