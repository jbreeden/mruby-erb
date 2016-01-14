mruby-erb
---------

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
# Accepts an object, rather than a binding.
template.result(obj[=nil])

# Define `methodname` as instance method of `mod` from compiled ruby source.
template.def_method(mod, methodname, fname[='(ERB)'])

# Define module with methodname as an instance method from compiled ruby source.
template.def_module(methodname[='erb'])

# Define class with methodname as an instance method from compiled ruby source.
template.def_class(superclass[=Object], methodname[='result'])
## Example:
# tmp = "<%= a %> <%= b %>"
# erb = ERB.new(tmp)
# Renderer = erb.def_class(Object, 'render(a, b)')
# renderer = Renderer.new
# renderer.render(1, 2)
#  => "1 2"
```
