class OrganizationPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end
  alias :new? :create?

  def update?
    user.admin?
  end
  alias :edit? :update?

  def destroy?
    user.admin?
  end
end
