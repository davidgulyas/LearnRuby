
name = gets()
puts( "Hello #{name}" )  #string interpolation, runs eval on contents
# only works for double quote string, not single

subtotal = 100.00
taxrate = 0.05
puts "Total #{subtotal * (1+taxrate)}"

=begin
multiline
comment
=end

#coversion functions
"5".to_i       # 5
"55.5".to_i    # 55
"55.5".to_f    # 55.5

if subtotal < 0.0
    subtotal = 0.0
end # end is required

exampleVar = 1 #local variables begin with lowercase
$exampleVar = 1 #global variables start with $

# in ruby everything is an object even ints
puts 5.to_s + 'a'

class Dog
    def set_name( name )
        @dogName = name #instance variables start with @
    end

    def get_name
        return @dogName
    end

    def returnUndefined
        return @newThing
    end
end

#Question: what happens if you create a local variable in a class?
#It would just die when then scope ends?

#initializer is .new
dog1 = Dog.new
dog1.set_name('jonDog')
puts dog1.get_name

#if an instance variable is undefined, 'nil' is returned.
puts dog1.returnUndefined

# Ruby puts the initial script being run in a 'main' class instance
puts self
puts self.class

#Ruby has garbage collection so doesn't need destructors

#class constructors, what's run when calling new. Creating it 'erases' the no arguments constructor
class Treasure
    def initialize( aName, aDescription )
      @name         = aName
      @description  = aDescription
    end
    
    def to_s # override default to_s method
         "The #{@name} Treasure is #{@description}\n"
    end
end

puts dog1.inspect #returns a string summary of the object
p(dog1) #shortcut for the above

class AGem < Treasure  # < indicates inheritance
end

#super function calls a method with the same name as the current method in the base class.
#useful for calling the base constructor.
#'super()' passes no arguments. 'super' passess all arguments

# = at the end of the function name (no spaces) is syntactic sugar to create a setter of a classes value
def thing=(aThing)
    @thing = aThing
end
#now object.thing = 5 will set @thing to 5.

#This creates  getters and setters automatically
class SetGet
    attr_reader :description
    attr_writer :description
    #or
    attr_accessor :description
end

#A symbol is a name preceded by a :. Represents names inside the interpreter

#attr_* can take lists of symbols
#attr_reader(:name, :desc)

#The C# syntax of declaring setters and getters with the property declaration is better

#Standard way of finding the method in the inheritance chain. Go upwards until a match is found.

#'class variables' start with @@
#They're shared by all instances, similar to static variables in C#

#.super returns a class's superclass
