require 'guard/compat/plugin'

module ::Guard
  class Mailcatcher < Plugin

    def initialize(options = {})
      opts = options.dup
      super(opts) # important to call + avoid passing options Guard doesn't understand
    end

    def start
      UI.info 'Starting Mailcatcher'
      `mailcatcher > log/mailcatcher.log 2>&1 &`
    end

    def stop
      UI.info 'Stopping Mailcatcher'
      ps = `ps xu`.split("\n")
      mailcatcher = []
      ps.each do |p|
        mailcatcher << p.split(/\s+|\t+/)[1] unless (/mailcatcher/ =~ p).nil?
      end
      mailcatcher.each do |pid|
        `kill -9 #{pid}`
      end
    end

  end
end
