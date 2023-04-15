require "test_helper"

class LintRollerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::LintRoller::VERSION
  end
end
