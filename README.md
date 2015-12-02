mruby-erb
---------

[ERB](http://ruby-doc.org/stdlib-2.2.3/libdoc/erb/rdoc/ERB.html), modified (slightly) for MRuby.

### Modifications
- Anywhere CRuby used binding arguments, mruby-erb accepts an object.
- The template is `instance_eval`ed on the object, instead of being `eval`ed in the context of a binding.
- No ERB::Util (CGI stuff... you don't need it).
- No encodings support.

\# Execute a template and return the resulting string.
\# (ERB on MRuby accepts objects instead of bindings throught the API)
ERB#result(obj=nil)

\# Define _methodname_ as instance method of _mod_ from compiled ruby source.
ERB#def_method(mod, methodname, fname='(ERB)')

\# Create unnamed module, define _methodname_ as instance method of it, and return it.
ERB#def_module(methodname='erb')

\# Define unnamed class which has _methodname_ as instance method, and return it.
ERB#def_class(superklass=Object, methodname='result')
