namespace :mruby do
  task :setup_mruby_build_variables do
    # When calling mruby rake tasks, use the local build_config.rb
    ENV['MRUBY_CONFIG'] = Dir.pwd + '/build_config.rb'

    # Try to find MRuby on path if no MRUBY_HOME set
    if !ENV['MRUBY_HOME']
      mruby_from_path = `which mruby`.strip
      if mruby_from_path.length > 0
        ENV['MRUBY_HOME'] = File.absolute_path(mruby_from_path + '/../..')
      end

      # Maybe MRuby is next to this gem?
      ENV['MRUBY_HOME'] ||= Dir.pwd + '/../mruby'
    end

    # Still no luck? Raise hell!
    if !ENV['MRUBY_HOME'] || !File.directory?(ENV['MRUBY_HOME'])
      raise 'Unable to find MRuby. Please set $MRUBY_HOME.'
    end
  end

  desc 'Clean the build artifacts'
  task :clean => :setup_mruby_build_variables do
    if File.directory?('build')
      rm_rf 'build'
    end
    cd ENV['MRUBY_HOME'] {
      sh 'rake clean'
    }
  end

  desc 'Build mruby with the local build_config'
  task :build => :setup_mruby_build_variables do
    if File.directory?('build')
      rm_rf 'build'
    end
    mkdir 'build'
    cd ENV['MRUBY_HOME'] {
      sh 'rake default'
    }
    cp_r Dir["#{ENV['MRUBY_HOME']}/build/host/{bin,lib}"], 'build'
  end
end
