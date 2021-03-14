class MenusController < ApplicationController

  before_action :set_user, only: [:show, :new, :create]
  # before_action :set_menu, only: [:show]

  def show
    @menu = Menu.new
    authorize @menu
  end

  def new
    @menu = Menu.new
    authorize @menu
  end

  def create
    # create there ?
  end



 private
  def menu_params
    params.require(:menu).permit()
  end

  def set_user
    @user = current_user
  end

  def set_menu
    @menu = Menu.find(params[:id])
    authorize @menu
  end
end
