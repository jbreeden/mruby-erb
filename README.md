mruby-erb
---------

[ERB](http://ruby-doc.org/stdlib-2.2.3/libdoc/erb/rdoc/ERB.html), modified (slightly) for MRuby.

### Modifications
- Anywhere CRuby used binding arguments, mruby-erb accepts an object.
- The template is `instance_eval`ed on the object, instead of being `eval`ed in the context of a binding.
- No ERB::Util (CGI stuff... you don't need it).
- No encodings support (MRuby has limited support for this in general).

### API

```
# Compile an ERB template.
# - safe_level is here for API compatability only, and is not used.
# - The rest is exactly what you're used to from CRuby
ERB::new(str, safe_level=nil, trim_mode=nil, eoutvar='_erbout')

# Execute a template and return the resulting string.
# (ERB on MRuby accepts objects instead of bindings throught the API)
ERB#result(obj=nil)

# Define `methodname` as instance method of `mod` from compiled ruby source.
ERB#def_method(mod, methodname, fname='(ERB)')

# Create unnamed module, define `methodname` as instance method of it, and return it.
ERB#def_module(methodname='erb')

# Define unnamed class which has `methodname` as instance method, and return it.
ERB#def_class(superklass=Object, methodname='result')
```
