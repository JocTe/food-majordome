class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit? # a t'on besoin de l'index ici ? est-ce qu'on peut filtrer ici l'index des recipes pour un user (afin d'afiner la week menu)
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit? # a t'on besoin de l'index ici ?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
