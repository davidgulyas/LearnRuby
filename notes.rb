print "Enter a name: "
#name = gets()
name = "h"
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

#Scope / variable types
exampleVar = 1 #local variables begin with lowercase or _
                #Scoped to the construct in which they're declared
$exampleVar = 1 #global variables start with $
                #Scoped to anywhere in the program.
                #There are several predefined ones that hold information about the runtime
                #$_ holds the last string read by gets
@exampleVar = 1 #instance variables start with @, unique to each instance
@@exampleVer = 1 #Class variables are shared between all instances of a class. (Static)
EXAMPLECONST = 1 #constants begin with capitals. Shouldn't be changed.
                #scoped to the class or module in which they're declared.
                #if declared outside class or module, have global scope
                #Class names mut be constants


# in ruby everything is an object even ints
puts 5.to_s + 'a'

class Dog #Must start with capital. Makes it a Constant
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


#initializer is .new
dog1 = Dog.new
dog1.set_name('jonDog')
puts dog1.get_name

#if an instance variable is undefined, 'nil' is returned.
print "nil:"
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
#'super()' passes no arguments. 'super' passes all arguments

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
#What all can you do with symbols?

#attr_* can take lists of symbols
#attr_reader(:name, :desc)

#The C# syntax of declaring setters and getters with the property declaration is better

#Standard way of finding the method in the inheritance chain. Go upwards until a match is found.

#.super returns a class's superclass

# :: is the scopre resolution operator.
# from https://stackoverflow.com/a/5033013
module Music
    module Record
      # perhaps a copy of Abbey Road by The Beatles?
    end
end
  
module Record
    # for adding an item to the database
end

::Record #gets the Record at the "top level" of scope
Music::Record #gets the Record inside the Music module


#classes can be extended/patched by redeclaring them.
#The first declaration sets the base class. (No inheritance actually inherits from Object class) The other declarations can set the same base class or set nothing
class Array
    def gribbet
        puts "I'm a new thing"
    end
end

[1].gribbet

class J < Array
    @i = 1
end

#class J < String #Not allowed to change base class

class J #Allowed to not respecify base class
    @ii = 2
end

#Chapter 3 Strings & Ranges

'It\'s here' # \ escapes '
"#{1+2} \t \n" #"" strings can do evaluation

'\t \n' #doesn't work. '' doesn't evluate special characters like that


# You can use custom string deliminators
%Q/This is a "" string/
%/This is a "" string/
%q/This is a '' string/

# The deliminator can be arbitrary. Probably don't do this?
%Q[This is a "" string]

#strings deliminated by `` or %x// are exaluated by the runtime console (passed to te oeprating system)
puts(`ls`)
puts()
puts(%x{ls})

#embed commands in other strings!!
#print("Goodbye #{%x{open -a Calculator}}")

# Concat strings in 3 ways
"Hi " << "x"
"Hi " + "x"
"Hi " "x"

# Ruby had imutable strings in 2.x, but now defaults to immutable strings in 3.x
a = "test"
p(a.object_id)
a.capitalize! #now holds Test #wtf
p(a.object_id)
#a has been changed, but the instance is the same.

#There's no notion of a char?
a[1] = 'x' #sets the second character to x
p = a[1] #sets p to the ascii value of the second character. #wtf
p = a[1,1] #sets p to the 'char' value of the second character. Specify start index and lenght
p = a[1,3] #sets p to the second-forth substring of a.
p = a[1..4] #does the same things as above. Specify start and end index
p = a[-1, 1] #sets p to last character of a
p = a[-5..-1] #sets p to the last 5 characters of a

"test\r\n".chomp #removes the newline characters. chop does something similar but is bullshit
#You can mess around with what the "record seperator" is, but that seems bad.

printf("%1.2f", 10.1283948) #printf exists. Can't find doc on the 1.2 specifier.
puts()

a = ('a'..'d') #ranges can take string args.
puts a.to_a #convert range to an array
('a'...'d') # triple . omits the last element. Useful for looping? (0...a.length) maybe?
('abc' ..'def') #has 2110 elements

for i in (1..3) do #range in for loop
    puts(i)
end

#heredocs are a thing. They let you create a literal that saves formatting and newlines.
#Give it an 'end marker' and it'll stoore everything until it see it again.
#The magic is the  << character, or <<- if you want to indent the end marker
hdocvar = <<EODOCMARKER
Cool
    Formatting
EODOCMARKER
puts(hdocvar)

#Literals
#start with % and then a letter specifying which type of literal.
# %s/dog/   #specifies the :dog symbol
#Q: what is the puropse of this since you can just go :dog? I guess evaluating is useful for arrat literals? But can do it with .add?
puts( %w/4 #{1+2}/ ) #creates a list without evaluating
puts( %W/4 #{1+2}/ ) #creates a list with exaluating.

#Charpter 4 Arrays and Hashes

 