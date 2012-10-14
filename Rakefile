# -*-ruby-*-

require 'rake'

task :server do
  sh "bundle exec shotgun -I."
end

task :build_examples, :api_key do |t, args|
  unless args[:api_key]
    raise "Please specify API key"
  end
  sh "mkdir -p public/examples"
  Dir.chdir('examples') do
    Dir.glob('*') do |example_name|
      next unless File.directory?(example_name)
      puts example_name

      Dir.chdir(example_name) do
        sh "zip ../../public/examples/#{example_name}.zip *"
        output = `./convert.sh #{args[:api_key]}`.strip
        sh "mv #{output} ../../public/examples"
      end
    end
  end
end

