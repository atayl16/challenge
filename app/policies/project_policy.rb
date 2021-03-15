class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    @user.has_role?(:admin) || @record.user_id = @user.id
  end

  def update?
    @user.has_role?(:admin) || @record.user_id = @user.id
  end

  def destroy?
    @user.has_role?(:admin) || @record.user_id = @user.id
  end
end
