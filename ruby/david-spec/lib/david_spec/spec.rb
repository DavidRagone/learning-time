require 'find'

module DavidSpec
  class Spec
    # Default pattern for spec files.
    DEFAULT_PATTERN = 'spec/**{,/*/**}/*_spec.rb'

    def self.run(pattern=nil)
      current_directory = Dir.pwd
      spec_files = Find.find(current_directory).grep(/#{current_directory}\/(test|spec).+\.rb/)
      spec_files.each { |file| Execute.(file) }
    end
  end

  class Execute
    def self.call(file)
      puts "executing #{file}"
    end
  end
end
