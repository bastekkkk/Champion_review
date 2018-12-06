class ChampionsController < ApplicationController

  before_action :find_champion , only: [:show, :destroy, :update, :edit]

  def index
    @champions = Champion.all.order(created_at: :desc)
  end

  def new
    @champion = Champion.new
  end

  def show

  end

  def edit
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
    @champion = Champion.new(champion_params)
    if @champion.save
      redirect_to root_path
    else
      render 'new'
    end
  end



  private

  def champion_params
    params.require(:champion).permit(:name, :role, :attack, :armor, :health)
  end

  def find_champion
    @champion = Champion.find(params[:id])
  end


end
