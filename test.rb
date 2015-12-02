# load './mrblib/erb.rb'

def test(label, &block)
  puts label
  puts block[] ? '=> PASS' : '=> FAIL'
end

class MyClass
  def initialize(&block)
    self.instance_eval(&block)
  end
end

test "ERB#result(obj=nil)" do
  puts "- Execute a template and return the resulting string."
  puts "- (ERB on MRuby accepts objects instead of bindings throught the API)"
  template = ERB.new <<-EOF
  The value of @x is: <%= @x %>
EOF
  template.result(MyClass.new { @x = 42 }) == "  The value of @x is: 42\n"
end

test "ERB#def_method(mod, methodname, fname='(ERB)')" do
  puts "- Define _methodname_ as instance method of _mod_ from compiled ruby source."
  erb = ERB.new('Do I have a @child? <%= @child ? "Yes." : "No." %>')
  erb.def_method(MyClass, 'render', 'dne.txt')
  MyClass.new { @child = 'Waaah!' }.render == 'Do I have a @child? Yes.'
end

test "ERB#def_module(methodname='erb')" do
    puts "- Create unnamed module, define _methodname_ as instance method of it, and return it."
    erb = ERB.new('<%= @foo %><%= @bar %>')
    RenderModule = erb.def_module('render')
    new_class = Class.new
    new_class.send(:include, RenderModule)
    instance = new_class.new
    instance.instance_variable_set(:@foo, 'foo')
    instance.instance_variable_set(:@bar, 'bar')
    instance.render == 'foobar'
end

test "ERB#def_class(superklass=Object, methodname='result')" do
  puts "- Define unnamed class which has _methodname_ as instance method, and return it."

  erb = ERB.new('<%= foo %><%= bar %>')
  erb.filename = 'dne.txt'
  class SuperClass
    def foo; 'foo'; end
    def bar; 'bar' end
  end
  RenderClass = erb.def_class(SuperClass, 'render')
  RenderClass.new.render == 'foobar'
end
