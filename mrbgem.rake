MRuby::Gem::Specification.new('mruby-erb') do |spec|
  spec.author = "Jared Breeden"
  spec.license = "You can redistribute it and/or modify it under the same terms as Ruby"
  spec.summary = "Direct ERB port from CRuby"

  spec.add_dependency "mruby-eval"

  # Allow the exect regexp gem to be specified by the client
  # (in build_config.rb, or by exporting environment variables in the shell).
  spec.add_dependency ENV["MRUBY_REGEXP_GEM"] || "mruby-regexp-pcre"
end
