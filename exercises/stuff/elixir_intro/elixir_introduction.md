# Elixir Introduction
by Doug Goldie

###Basic Elixir

####arthimetic

	2.1.2 apollo:~/code/work/elixir
	$ iex
	Erlang/OTP 17 [erts-6.0] [source] [64-bit] [smp:8:8] [async-threads:10] 	[hipe] [kernel-poll:false]

	Interactive Elixir (0.14.0) - press Ctrl+C to exit (type h() ENTER for 	help)
	iex(1)> 1 + 2
	3
	iex(2)> 7 - 3
	4
	iex(3)> 4 * 5
	20
	iex(4)> 10 / 2
	5.0
	iex(5)> div(10, 2)
	5
	iex(6)> div 10, 2
	5
	iex(7)> rem 10, 3
	1

##### binary, octal, hex values
	
	iex(8)> 0b1011
	11
	iex(9)> 0777
	511
	iex(10)> 0x1F
	31

##### :atoms, strings, char lists
	iex(13)> :atom
	:atom
	iex(14)> "string"
	"string"
	iex(15)> 'char'
	'char'
	iex(16)> is_list 'char'
	true
	iex(17)> is_binary "string"
	true

##### booleans
everthing is truthy except ```false``` and ```nil```

	iex(28)> true
	true
	iex(29)> false
	false
	iex(30)> is_boolean(true)
	true
	iex(31)> is_boolean(false)
	true

##### lists
	
	iex(18)> [1,2,3]
	[1, 2, 3]
	iex(38)> [:foo, :bar]
	[:foo, :bar]
	iex(34)> list = [1, 2, 3]
	[1, 2, 3]
	iex(35)> hd list
	1
	iex(36)> hd(list)  
	1
	iex(37)> tl list
	[2, 3]
	

##### tuples

	iex(19)> {:a, :b, :c}
	{:a, :b, :c}
	iex(20)> {:person, "doug", "goldie"}
	{:person, "doug", "goldie"}

##### keyword lists
They keep the keys ordered as given by the developer.
They allow a key to be given more than once.
you can pattern match

	iex(40)> [author: "Doug", title: "Elixir Intro"]      
	[author: "Doug", title: "Elixir Intro"]
	
##### maps
Maps allow any value as key.
Maps' keys do not follow any ordering.
	
	iex(15)> map = %{:a => 1, 2 => :b} 
	%{2 => :b, :a => 1}
	iex(16)> map[:a]                  
	1
	iex(17)> map[2] 
	:b
	
both are dictionaries. It's 

##### pattern matching
    
	iex(18)> [a, b, c] = [1, 2, 3]
	[1, 2, 3]
	iex(19)> a
	1
	iex(20)> b
	2
	iex(21)> c
	3
	iex(25)> [d,_, 4] = [1,2,3]
    ** (MatchError) no match of right hand side value: [1, 2, 3]

	
##### regular expressions
Perl Compatible regexes

	Regex.replace %r/[aeiou]/, "Beginning Elixir", "z"
	
sigil

    iex(1)> regex = ~r/doug|dan/
	~r/doug|dan/
	iex(2)> "doug" =~ regex
	true
	iex(3)> "dan" =~ regex 
	true
	iex(6)> "xyz" =~ regex   
	false
	iex(7)> "Doug" =~ regex
	false
	
##### libraries
Elixir and Erlang libraries

	iex(39)> IO.puts "helo"
	helo
	:ok
	iex(40)> :io.format("hello")
	hello:ok
	iex(41)> 

Enum

	iex(41)> list = [1,2,3,4]
	[1, 2, 3, 4]
	iex(42)> Enum.take(list, 2)
	[1, 2]	
	iex(43)> Enum.map(list, fn(x) -> x * 2 end)
	[2, 4, 6, 8]

### Functions

##### anonymous

	iex(33)> add = fn a,b -> a + b end 
	#Function<12.106461118/2 in :erl_eval.expr/5>
	iex(34)> add.(1,2)
	3

closures	
	
	iex(35)> add_two = fn a -> add.(a, 2) end
	#Function<6.106461118/1 in :erl_eval.expr/5>
	iex(36)> add_two.(4)
	6
	
capture operator	
	
	iex(49)> double = &(&1 * 2)
	#Function<6.106461118/1 in :erl_eval.expr/5>
	iex(50)> double.(4)
	8
	iex> fun = &is_atom(&1)

#####conditionals
case
	
	iex(3)> x = 1
	1
	iex(4)> case 10 do
	...(4)>   ^x -> "is ten"
	...(4)>   _ -> "is anything"
	...(4)> end
	"is anything"
	iex(5)> 
	
cond for different conditions

	iex(5)> cond do
	...(5)>   1 == 5 -> "nope"
	...(5)>   3 == 3 -> "yep"
	...(5)> end
	"yep"
	
##### quoting
	
	iex(6)> quote do: sum(1, 2, 3)
	{:sum, [], [1, 2, 3]}
	iex(7)> quote do: 1 + 2
	{:+, [context: Elixir, import: Kernel], [1, 2]}
	iex(8)> Macro.to_string(quote do: sum(1, 2 + 3, 4))
	"sum(1, 2 + 3, 4)"
	iex(9)> number = 13
	13
	iex(10)>  Macro.to_string(quote do: 11 + unquote(number))
	"11 + 13"
	iex(11)> 











