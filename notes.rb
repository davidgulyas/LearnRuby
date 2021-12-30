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

#Arrays donn't have type restrictions.
a = [1,"aa", 1.0]
#First index is 0.
x = a[0]
#Arrays are objects defined by the Array class
x = a[100] #returns nil if index out of bounds

#Arrays execute the functions passed into their literals
def funcA
    return 'result'
end
a = [funcA, funcA] #now holds ['result', 'result']
#Q: How do you pass a refrence to a function into a aray literal??? Normally you could not put the ()

a = [`ls`] # array holds the results of the ls command run in the console
#Q: How do you store that one without executing it? Possibly using the weird % literal notation?

#Array literals can be defined by the %w and %W systax, but it's dumb.

a = Array.new #new empty array Q: How do you add elements to this?
a = Array.new(2) #empty array with 2 spaces
a = Array.new(2, 'a') # creates ['a','a']

#Q: What data structure underlies the array? Contiguous memory, or linked list? Must be linked list if an aray deosnt' have to be created with a defined size?

#Multidimensional arrays are just created by assigning an array to another arays slots. Can you do circular dependancies??
a = Array.new(1)
a[0] = a
puts(a)
puts(a)
#Q: This apparently works? It just stores a refrence to the array in the slot?
#Q: Why does puts(a) print [...]?

a = [[1,8],[7,2]] #Multidim array literal

#Arrays can be looped through
for i in a
    for j in i
        print(j)
    end
    puts()
end

a = [0,1,2,3,4,5,6]
#Array indexes can also take ranges
print(a[3,3])
puts()
print(a[0..4])

#You can assign to any place in an array. Arrays never seem to care about capacity.
#Q: If you assign to index 1000, are 1000 empty places created from 0-999? Arrays don't care what size things are in the slots so they're probably just pointers? Does a[99999999999] break ruby?
a = []
a[2] = 1
puts(a[2])
puts(a[1]) #prints empty line

#You can also put spans and ranges in the assignment brackets. That's sort of weird.
a = []
a[0,2] = 'a','b'
a[2..4] = 'c','d'
puts(a)

b = a #copies the refrence.
b = a.clone #makes a duplicate array

#Weird array comparison operator <=> called the spaceship operator.
a <=> b #if a < b then return -1
        #if a = b then return  0
        #if a > b then return  1
        #if a and b are not comparable then return nil

#Sorting uses <=>. A lot of classes implement it.
#<=> can't handle nil. So sometimes people write a 'block' (lambda) to handle it.

#<=> is defined in the Comparable module. It can be included in a class. This lets it be optionally overridden.

class Thing < Array #inherit form Array
    include Comparable 

    def <=> (anotherArray)
        self.length <=> anotherArray.length
    end
end

a = Thing.new([1,2,3])
b = Thing.new([3,2,1])
puts(a <=> b) #returns 0

#implementing <=> gives you <. ==, and > for free
puts(a == b)

#Most array methods don't modify the array. Many do.
#Methods ending in !
# << concates an array onto another array
# clear, delete, delete_at do what they say.

#Arrays have set operations defined
a & b #intersection
a - b #difference
a + b #concatenation. Merge into one array
a << b #append. Puts the entire second array into an entry in the first array.
(a << b).flatten #append and then flatten into one array.

#Hashes

h = Hash.new("default value") # hashes return something when the key doesn't exist. (wtf??) It can be set in the constructor.
h = Hash.new() #returns nil as the default
#The default can be set and get with .default

#a key can be any type of object
x = SetGet.new #x is a valid key

#Hash literal
h = {
    'k1' => "v1",
    9 => "v2",
    'k3' => "v3"
}
puts(h[9])
puts(h['k3'])

#Like arrrays, using = creates a shallow copy. Using .clone creates a deep copy.
#Q: Does the deep copy only go one level deep?

#The .sort method expects every key to be the same data type. You can write your own comparison function
#Uh who sorts a hash?
def sorted_hash( aHash)
    return aHash.sort{
        |a,b|
            a.to_s <=> b.to_s
    }
end

puts("Prints out key then value. 9 is now the last key")
x = sorted_hash(h)
puts(x)

#h.delete(somekey) #deletes an item
#h.has_key?(someKey) #boolean saying if the key is in the hash
#h.has_value?(someValue) #boolean saying if the value is in the hash
#h.invert #Returns a new hash where values are keys and keys are values
#h.keys and h.values #returns array with the chosen items

#OO terminology
#The object to which amethod belong is called a *reciever*. *Messages* are sent to objects, which receive them. Objects try and find ways to respond
#to the messages they receive. A string instance has a reverse method, so it's able to respond to the reverse method. An integer wouldn't be able to respond.

#A set class exists that enforces uniqueness. It's not included by default.
require 'set' #Q: Why is set lowercase?
s1 = Set.new([1, 2, 1, 1])
puts(s1)
s2 = Set.new([1, 2, 3])
puts(s1.merge(s2))

#Chapter 5
#Loops

#Instead of for, use .each
[1,2,3].each do |i|
    print(i)
end
puts()

#(1..4).each also works

#Blocks (mentioned before) are lambdas. They can be preceded by ||'s with 'block parameters' in them. The paremeters are passed into the blocks scope.
#Loops pass the iteration's loop(s) index as a block parameter into the block that makes up the loops body.
#Blocks are mentioned in ch 10.

#Loops can poass in more than one loop index
a = [[1,2],[3,4]]
a.each do |i,j|
    print("#{i} #{j}")
    puts{}
end

#Can also use {} instead of do/end
a.each{
  |i,j|
    print("#{i} #{j}")
    puts{}
}

# while loops
x = true
while x
    x = false
end

x = true
x = false while x #while can be put on the same line at the end. This is called a 'while modifier'
#Q: are there other kinds of modifiers?

x = true
while x do x = false end #required 'do/end' since it's on the same line, before the interior of the loop

#multi line loop interiors need begin/end if while is a the end

x = false
begin
    x = true
    x = false
end while x

#This is a bad design pattern. Behaviour shouldn't change when adding begin/end
x = 100
puts('thingA') while(x < 100) #doesn't execute interior
begin puts('thingB') end while(x < 100) #does execute interior

#until is a while loop that execurtes until the condition is true. Exactly the same as while.
a = [1,2,3]
i = 0
until i == a.length
    puts(a[i])
    i += 1
end

#loop is a loop that doesn't test for a condition to break. Should include 'break' to end the loop. This probably usually leads to spaghetti code.
#Can use {} or do/end
i = 0
loop do
    puts(a[i])
    i += 1
    if i == a.length
        break 
    end
end

#collect lets you run a block on each element and returns an array with the altered elements
a = [2,3]
a = a.collect{|i| i*i} 
puts(a)

#Overriding the max/min comparison functions
h = {'one'=>'for sorrow', 'two'=>'for joy'}
#a hash passes items into blocks as arrays which contain the key,value pair.
min = h.min{|a,b| a[1].length <=> b[1].length} #so a is ['one','for sorrow']. Here we're finding the min value (not key) in the hash
puts(min)

#Chapter 6 Conditionals

a = 'Monday'
if a == 'Sat' or a == 'Sun'
    x = 'weekend'
else
    x = 'weekday'

if a == 'Monday' then puts('xxx') end #then is mandatory if consequence is on the same line
#if a == 'sdfsa' : puts('xxx') end #can also use a :
#Q: The above seems to be broken. Did this syntax get removed?

# There are two sets of boolean operators
# && || !
# and or not
# The symbols have higher precedence than the words. (This is stupid)

# elsif combines "else if"
#The trinary operator works
1 == 2 ? puts("nope") : puts("This should always be printed") end

#The === operator tests for membership
if (1..4) === 3 then puts("it's included") end
#Q: Does the order of the operands matter?
#equivalent to (1..4).include?(3)

#unless is the same as
#if !(conditional)
unless 1 == 2
    puts('unless')
end

#if and unless modifiers exist that can be put at the end of code blocks
puts("modifier1") if 1 == 1
puts("modifier2") if 1 == 2

#Ruby lets you override constants, like the one that specifies which version of ruby is being used. Sort of dumb?
#That makes constants behave like variables? A warning is generated if a constant changes.

#Q: Book says that 'then' can be replaced with :. That throws an error. Why?
#Multiple tests in one case.
#=== is used to test if the case and argument matches
i = 3
case(i)
    when (1..2) then puts("x") 
    when 3,6,'test' then puts("case")
    else
        puts("xx")
end

#There is an alternate case syntax where the matching caes can also return a value.
#I guess it's useful for knowing which case was executed.
#It looks dumb, like an antipattern of doing to many things at once.

# != exists

#There are dumb syntax rules for some reason
puts((not(1==1))) #works
puts(not(1==1)) #Q: Also works?? Book says it doesn't
#puts(true and true) #Causes error Q: Why??
puts(((true) and (true))) #Works
#WTF

#There are catch and throw keywords that act like goto's a little bit.
#The book doesn't give a good description of them. Apparently they're often used to skip execution of code
#if something is off
#Q: do people use catch/throw?

#Chapter 7 Methods





#Q: You can have a class within a class? 
