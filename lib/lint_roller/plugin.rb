module LintRoller
  class Plugin
    # `config' is a Hash of options passed to the plugin by the user
    def initialize(config = {})
      @config = config
    end

    def about
      raise Error.new("Please implement `about` and return an instance of LintRoller::About")
    end

    # `context' is an instance of LintRoller::Context provided by the runner
    def supported?(context)
      true
    end

    # `context' is an instance of LintRoller::Context provided by the runner
    def rules(context)
      raise Error.new("Please implement `rules(context)` and return an instance of LintRoller::Rules")
    end

    def to_s
      if about.name && about.version
        "#{about.name} #{about.version}"
      elsif about.name
        about.name
      else
        inspect
      end
    end
  end
end
