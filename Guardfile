
Dir.glob(File.dirname(__FILE__) + '/lib/guards/*').each {|file| require file }

logger level: :info,
       template: "\e[0;37m:time\e[0m [\e[38;5;37mGuard|:severity\e[0m ] :message",
       time_format: '%Y-%m-%d %H:%M:%S    '

guard 'livereload', grace_period: 2 do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/controllers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(s?[ca]ss|js|html|png|jpg|coffee))).*}) { |m| "/assets/#{m[3]}" }
end

guard :bundler do
  watch('Gemfile')
end

guard 'rails', server: :thin, host: '0.0.0.0', port: ENV['RAILS_PORT'] || 3000, timeout: 5 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib|app/live_controllers)/.*})
end
guard 'mailcatcher'
