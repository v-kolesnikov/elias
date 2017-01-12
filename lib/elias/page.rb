module Elias
  class Page
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def view_locals
      {
        csrf_token: csrf_token,
        csrf_tag: csrf_tag
      }
    end

    def csrf_token
      self[:csrf_token].()
    end

    def csrf_metatag
      self[:csrf_metatag].()
    end

    def csrf_tag
      self[:csrf_tag].()
    end

    def flash
      self[:flash]
    end

    def flash?
      %i(notice alert).any? { |type| flash[type] }
    end

    def with_flash(flash)
      with(flash: flash)
    end

    def with(new_options)
      self.class.new(options.merge(new_options))
    end

    def [](name)
      options.fetch(name)
    end
  end
end
