require 'david_spec'

class SomeClass
end

DavidSpec.test SomeClass do
  contexts do
    context :baz_is_true do
      baz = true
    end
  end

  instance_method :bar do
    @when.('baz is true') do
      baz = true
      expect { baz == true }
    end

    @when.(-> { baz = true }) do
      expect { baz == true }
    end

    @when.(:baz_is_true) do
      expect { baz == true }
    end
  end

  class_method :foo do
  end
end
