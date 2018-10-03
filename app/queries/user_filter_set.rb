class UserFilterSet
  include Enumerable
  delegate :each, to: :all

  def initialize(options = {})
    @options = options || {}
  end

  def all
    @all ||= UserFilterQuery.new(@options).results
  end
end
