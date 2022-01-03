MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :clang
  end

  conf.enable_debug
  conf.enable_test

  conf.cc.flags << '-DMRB_INT64'

  conf.gembox 'full-core'
  conf.gem File.dirname(__FILE__)
end
