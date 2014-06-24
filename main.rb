class Test
	attr_reader :number1, :number2, :operator, :shiftoperator, :shifter

	def generateRandomHardHex 
		hex = []
		rand(4..7).times do 
			hex << rand(5..15).to_s(16)	
		end
		return"0x#{hex.join("")}"
	end

	def generateRandomEasyHex
		hex = []
		ran = [rand(1..15),0,0]
		rand(4..7).times do
			hex << ran[rand(0..2)].to_s(16)
		end
		return "0x#{hex.join("")}"
	end

	def generateRandomOperator
		operator = ["|", "&", "^"]
		return operator[rand(0..operator.size) - 1]
	end

	def generateRandomShifter
		operator = ["<<", ">>"]
		return operator[rand(0..operator.size) - 1]
	end

	def parseResult(result)
		a = []
		i = 1
		result = result.split("\n")
		result.each do |count|
			a << "#{i}. #{count}"
			i+=1
		end
		return a
	end

	def generateCss
		File.open("style.css", "w") do |file|
			file.write("
	  
	        div#container {
	            width: 1250px;
	            height: 750px;
	            margin: auto;
	            position: absolute;
	            top: 0;
	            left: 0;
	            bottom: 0;
	            right: 0;
	    
	            font: 100% 'Arial', sans-serif;
	        }
	    
	        div#container table, th, td {
	            border: 1px solid black;
	            border-collapse: collapse;
	        }
	    
	        div#container table {
	            width: inherit;
	            height: inherit;
	        }
	    
	        div#container th {
	            font-weight: normal;
	        }
	    
	        div#container td {
	            margin: 0;
	            position: relative;
	            vertical-align: top;
	        }
	        div#container td span.answer {
	            padding: 0 5px;
	            position: absolute;
	            right: 0;
	            bottom: 0;
	            border-top: 1px solid black;
	            border-left: 1px solid black;
	        }
	    ")
		end
	end

	def generateStartHTML(title)
		return "<!DOCTYPE html>

	<html>

	    <head lang='en'>
	        <meta charset='UTF-8'></meta>
	        <title></title>
	                <link rel='stylesheet' type='text/css' href='style.css'>
	    </head>
	    <body>
	        <div id='container'>
	            <table>
	                <tbody>
	                    <tr>
	                        <th colspan='4'>
	                            <strong>
	                               Test #{title}
	                                

	                            </strong>"
	end	

	def generateEndHTML
		return" </td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </body>

	</html>"
	end

	def generateHTMLtest(count, argv)
		File.open("answers_#{count}.txt", "w"){}
		i = 1
		File.open("test#{count}.html", "a") do |file|
			File.open("temp_file.cc", "w") do |file|
				file.write("#include<iostream>\n
				using namespace std;\n
				int main(){\n")
			end
			3.times do
				file.write("<tr>")
				2.times do 
					if argv == "easy"
						number1 = generateRandomEasyHex
						number2 = generateRandomEasyHex
						operator = generateRandomOperator
					elsif argv == "hard"
						number1 = generateRandomHardHex
						number2 = generateRandomHardHex
						operator = generateRandomOperator
					end
					File.open("temp_file.cc", "a") do |file|
						file.write("int c#{i} = #{number1} #{operator} #{number2};\ncout << hex << c#{i}<< endl;\n")
						i+=1
					end

					file.write("<td>

								int orig = #{number1}<br>
								int insert = #{number2}<br>
								int a = orig #{operator} insert<br>
								a = ............................
		                            <br></br>
		                            <br></br>

		                            

		                            <br></br>

		                            

		                            <br></br>

		                            

		                        </td>")
				end
				2.times do 
					if argv == "easy"
						number1 = generateRandomEasyHex
						number2 = generateRandomEasyHex
						operator = generateRandomOperator
						shiftoperator = generateRandomShifter
						shifter = rand(0..4)
					elsif argv == "hard"
						number1 = generateRandomHardHex
						number2 = generateRandomHardHex
						operator = generateRandomOperator
						shiftoperator = generateRandomShifter
						shifter = rand(3..9)
					end
					File.open("temp_file.cc", "a") do |file|
						file.write("int c#{i} = #{number1} #{operator} (#{number2} #{shiftoperator} #{shifter});\ncout << hex << c#{i}<< endl;\n")
						i+=1
					end

					file.write("<td>

								int orig = #{number1}<br>
								int insert = #{number2}<br>
								int a = orig #{operator} (insert #{shiftoperator} #{shifter})<br>
								a = ............................
		                            <br></br>
		                            <br></br>

		                            

		                            <br></br>

		                            

		                            <br></br>

		                            

		                        </td>")
				end
				file.write("</tr>")
			end
		end
		File.open("temp_file.cc", "a") do |file|
			file.write("}")
		end
		system("g++ temp_file.cc -o tp")
		result = `./tp`
		result = parseResult(result)
		File.open("answers_#{count}.txt", "w") do |file|
			file.write("#{result.join("\n")}")
		end
	end

	def htmlend(count)
		File.open("test#{count}.html", "a") do |file|
			file.write(generateEndHTML)
		end
	end

	def htmlbegin(count)
		File.open("test#{count}.html", "w") do |file|
			file.write(generateStartHTML(count))
		end
	end
end


begining = Time.now
test = Test.new
test.generateCss
ARGV[0].to_i.times do |i|
	test.htmlbegin(i+1)
	test.generateHTMLtest(i+1, ARGV[1])
	test.htmlend(i+1)
end
j=1
while (j<=ARGV[O].to_i)
	`wkhtmltopdf test#{j}.html test#{j}.pdf`
	j=j+1;
end
File.delete("temp_file.cc")
puts "Time elapsed #{Time.now - begining} seconds"

