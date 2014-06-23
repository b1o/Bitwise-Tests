require "thread"

def generateRandomHardHex 
	hex = []
	rand(4..7).times do 
		hex << rand(5..15).to_s(16)	
	end
	return"0x#{hex.join("")}"
end

def generateRandomEasyHex
	hex = []
	
end

def generateRandomOperator
	operator = ["|", "&", "^"]
	return operator[rand(0..operator.size) - 1]
end

def generateCss
	File.open("style.css", "w") do |file|
		file.write("        @import url(http://fonts.googleapis.com/css?family=Lato:400,700);
    
        div#container {
            width: 1250px;
            height: 750px;
            margin: auto;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
    
            font: 100% 'Lato', sans-serif;
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

def generateHTMLtest(count)
	File.open("answers_#{count}.txt", "w"){}
	i = 1
	File.open("test#{count}.html", "a") do |file|
		3.times do
			file.write("<tr>")
			4.times do 
				number1 = generateRandomHardHex
				number2 = generateRandomHardHex
				operator = generateRandomOperator
				File.open("temp_file.rb", "w") do |file|
					file.write("c = #{number1} #{operator} #{number2}\nputs c.to_s(16)")
				end

				result = `ruby temp_file.rb`

				File.delete("temp_file.rb")
				File.open("answers_#{count}.txt", "a") do |file|
					file.write("#{i}. #{result}")
					i+=1
				end

				file.write("<td>

							int orig = #{number1}<br>
							int insert = #{number2}<br>
							int a = orig #{operator} insert<br>
	                            <br></br>
	                            <br></br>

	                            

	                            <br></br>

	                            

	                            <br></br>

	                            

	                        </td>")
			end
			file.write("</tr>")
		end
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
generateCss

ARGV[0].to_i.times do |i|
	htmlbegin(i+1)
	generateHTMLtest(i+1)
	htmlend(i+1)
end

