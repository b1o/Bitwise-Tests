def bitwiseOR(a,b)
	@result = (a|b).to_s(16)
	#puts "#{@a}|#{@b} = #{@c}"
	return @result
end

def bitwiseAND(a,b)
	@result = (a&b).to_s(16)
	return @result
end

def bitwiseXOR(a,b)
	@reuslt = (a^b).to_s(16)
	return @result
end

File.open("result.pdf", "w"){}
10.times do |i|
	number1 = rand(1..15)
	number2 = rand(1..15)

	a = bitwiseOR(number2, number1)
	b = bitwiseAND(number2, number1)
	c = bitwiseXOR(number2, number1)
	puts "Numbers: #{number2}, #{number1}"
	puts "Numbers(HEX): #{number2.to_s(16)}, #{number1.to_s(16)}"
	puts "OR = #{a}\nAND = #{b}\nXOR = #{c}"

	File.open("result.txt", "a") do |file| 
		file.write("#{i+1}.\n")
		file.write("a = #{number2}\nb = #{number1}\n")
		file.write("Numbers(HEX): #{number2.to_s(16)}, #{number1.to_s(16)}\n")
		file.write("OR = #{a}\nAND = #{b}\nXOR = #{c}\n")
		file.write("________________________________\n")
	end
end

`notepad result.txt`