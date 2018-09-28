class CampaignFilePolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
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
