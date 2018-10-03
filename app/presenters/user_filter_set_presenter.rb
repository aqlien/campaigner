class UserFilterSetPresenter < BasePresenter
  presents :user_filter_set

  def initialize(*args)
    super
    @presenter = UserFilterSetRecordPresenter.new(nil, h, @options)
  end

  def each_user
    user_filter_set.each do |record|
      @presenter.__setobj__(record)
      yield @presenter
    end
  end

  def options
    @options
  end

end
