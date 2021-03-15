class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def show?
    true
  end

  def instructions?
    # to change when we can attribute the recipe to the user :
    true
  end
end
