module Minitest
  class Test
    def setup
      first if self.respond_to? :first
      DatabaseCleaner.start
      before if self.respond_to? :before
    end
    def teardown
      before_clean if self.respond_to? :before_clean
      DatabaseCleaner.clean
      after if self.respond_to? :after
    end
  end
end
