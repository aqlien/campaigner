class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || user.id == record.id
  end

  def create?
    user.admin?
  end
  alias :new? :create?

  def update?
    user.admin? || user.id == record.id
  end
  alias :edit? :update?

  def destroy?
    user.admin?
  end
end
