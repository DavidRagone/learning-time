require 'rake'
require 'rake/tasklib'

module DavidSpec
  class RakeTask < ::Rake::TaskLib
    def initialize(name)
      define_rake_task(name)
    end

    private

    def define_rake_task(name)
      desc "Run DavidSpec examples"

      task name do
        DavidSpec::Spec.run
      end
    end
  end
end
