module LintRoller
  About = Struct.new(
    :name, # "standard-performance"
    :version, # "1.2.3"
    :homepage, # "https://github.com/testdouble/standard-performance"
    :description, # "A configuration of rubocop-performance rules to make Ruby go faster"
    keyword_init: true
  ) do
    include Comparable

    def <=>(other)
      values <=> [other.name, other.version, other.homepage, other.description]
    end
  end
end
