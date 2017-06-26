# TODO - binding.pry anywhere doesn't work b/c of how
#   we're treating reading the files & output
#
# TODO - colorize output

require 'find'
require 'open3'
require 'pry'

module DavidSpec
  def self.test(klass)
    @tester = Spec.new(klass)
    yield
  end
  alias_method :spec, :test

  class Spec
    # Default pattern for spec files.
    DEFAULT_PATTERN = 'spec/**{,/*/**}/*_spec.rb'

    # TODO - move this to Runner or Execute class
    def self.run(pattern=nil)
      current_directory = Dir.pwd
      spec_files = Find.find(current_directory).grep(/#{current_directory}\/(test|spec).+\.rb/)
      spec_files.shuffle.each { |file| Execute.(file) }
    end

    attr_reader :klass
    def initialize(klass)
      @klass = klass
      @specs = []
    end
  end

  class InstanceMethodSpec
    def self.call(method, expectations)
      puts "##{method}"
      expectations.each do |expectation|
        arg = expectation.first
        test_output = ''

        case arg
        when String
          test_output << "when #{arg}"
        when Symbol
          test_output << arg.to_s.gsub('_', ' ')
          send(arg)
        when Proc
          arg.call
        end

        test_output.prepend(
          expectation.last.call ? 'PASS - ' : 'FAIL - '
        )

        puts test_output
      end
    end
  end

  module MainMethods
    def self.extended(mod)
      mod.instance_variable_set(:@when_accumulator, [])
      mod.instance_variable_set(
        :@when,
        -> (arg=nil, &block) {
          mod.instance_variable_get(:@when_accumulator) << [arg, block]
        }
      )
    end

    def contexts
      yield
    end

    def context(context, &block)
      define_method(context, block)
    end

    def instance_method(method)
      yield
      DavidSpec::InstanceMethodSpec.(method, @when_accumulator)
      reset_when
    end

    def class_method(method)
      yield # TODO
    end

    def expect
      yield # TODO
    end

    private

    def reset_when
      @when_accumulator = []
    end
  end

  class Execute
    def self.call(file)
      puts "executing #{file}"
      Open3.popen3("ruby #{file}") do |stdin, stdout, stderr, thread|
        while (line = stdout.gets || stderr.gets) do
          puts line
        end
      end
    end
  end
end

extend DavidSpec::MainMethods
