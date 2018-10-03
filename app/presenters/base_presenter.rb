class BasePresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  attr_reader :object

  def initialize(object, template, options = {})
    @object = object
    @template = template
    @options = options || {}
    super(@object)
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def __setobj__(object)
    @object = object
    super
  end

  def h
    @template
  end
end
