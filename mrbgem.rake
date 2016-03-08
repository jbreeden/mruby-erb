MRuby::Gem::Specification.new('mruby-erb') do |spec|
  spec.author = "Jared Breeden"
  spec.license = "You can redistribute it and/or modify it under the same terms as Ruby"
  spec.summary = "Direct ERB port from CRuby"

  spec.add_dependency "mruby-eval"
  spec.add_dependency "mruby-regexp-pcre"
end
