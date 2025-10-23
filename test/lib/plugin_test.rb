require "test_helper"

module LintRoller
  class PluginTest < Minitest::Test
    def setup
      @subject = Plugin.new
    end

    def test_default_methods
      error = assert_raises(Error) { @subject.about }
      assert_equal "Please implement `about` and return an instance of LintRoller::About", error.message

      assert @subject.supported?(:some_context)

      error = assert_raises(Error) { @subject.rules(:some_context) }
      assert_equal "Please implement `rules(context)` and return an instance of LintRoller::Rules", error.message
    end

    class SampleRoller < Plugin
      ABOUT = About.new(
        name: "sample-roller",
        version: "1.2.3",
        homepage: "https://example.com",
        description: "A sample lint roller"
      ).freeze

      def about
        ABOUT
      end

      def supported?(context)
        [:standard, :rubocop].include?(context.runner)
      end

      def rules(context)
        if @config[:💥] == true
          Rules.new(error: Error.new("Unexpected Boom"))
        else
          Rules.new(
            type: :path,
            config_format: :rubocop,
            value: "/some/path/to/a/place"
          )
        end
      end
    end

    class AnotherRoller < Plugin
      ABOUT = About.new(
        name: "another-roller",
        version: "1.2.3",
        homepage: "https://example.com",
        description: "A sample lint roller for sort testing"
      ).freeze

      def about
        ABOUT
      end

      def supported?(context)
        [:standard, :rubocop].include?(context.runner)
      end

      def rules(context)
        if @config[:💥] == true
          Rules.new(error: Error.new("Unexpected Boom"))
        else
          Rules.new(
            type: :path,
            config_format: :rubocop,
            value: "/some/path/to/a/place"
          )
        end
      end
    end

    def test_sample_roller
      sample_roller = SampleRoller.new(:some_config)

      assert_equal About.new(
        name: "sample-roller",
        version: "1.2.3",
        homepage: "https://example.com",
        description: "A sample lint roller"
      ), sample_roller.about

      assert sample_roller.supported?(Context.new(runner: :standard))
      refute sample_roller.supported?(Context.new(runner: :rufo))

      assert_equal Rules.new(
        type: :path,
        config_format: :rubocop,
        value: "/some/path/to/a/place"
      ), SampleRoller.new.rules(Context.new)
      assert_equal Rules.new(
        error: Error.new("Unexpected Boom")
      ), SampleRoller.new({:💥 => true}).rules(Context.new)
    end

    def test_sort_sample_roller_with_another_roller
      sample_roller = SampleRoller.new(:some_config)
      another_roller = AnotherRoller.new(:some_config)

      assert_equal [another_roller, sample_roller], [sample_roller, another_roller].sort
    end
  end
end
