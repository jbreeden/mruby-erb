mruby-erb (incomplete)
----------------------

[ERB](http://ruby-doc.org/stdlib-2.2.3/libdoc/erb/rdoc/ERB.html), modified (slightly) for MRuby.

### Modifications
- Anywhere CRuby used binding arguments, mruby-erb accepts an object.
- The template is `instance_eval`ed on the object, instead of being `eval`ed in the context of a binding.
- No ERB::Util (CGI stuff... you don't need it).
- No encodings support (MRuby has limited support for this in general).

### API

```Ruby
# Compile an ERB template.
# - safe_level is here for API compatability only, and is not used.
# - The rest is exactly what you're used to from CRuby
template = ERB.new(str, safe_level[=nil], trim_mode[=nil], eoutvar[='_erbout'])

# Execute a template and return the resulting string.
# (ERB on MRuby accepts objects instead of bindings throught the API)
# WARNING: This API is very buggy at the moment. Use def_method for now
#          if you absolutely need the obj context
template.result(obj[=nil])

# Define `methodname` as instance method of `mod` from compiled ruby source.
template.def_method(mod, methodname, fname[='(ERB)'])
```
