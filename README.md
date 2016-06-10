Bitwise-Tests

	Ruby script that generates exams with bitwise tasks for a school project.
=============

## Notes on main.rb - 21.06.2014/01:44AM ##
	1. The PDF file generating doesn't work as its supposed to(Adobe error).

## Update - 23.06.2014/08:45PM ##
	1. Added HTML+CSS template that is going to be used.

## Update on main.rb - 24.06.2014/02:51AM ##
	1. Added methods for generating easy and hard HEX numbers.
	2. Added method for generating bitwise operators(excluding shifting operators).
	4. Added answers generating(to be optimized).
	5. Added a more propper way of generating html tests.
	6. Improved file creation time with 65~75% by imporving the generateHTMLtest method.

## Update on main.rb - 24.06.2014/8:38PM ##
	1. Added shift tasks support - generateRandomShifter.
	2. Added the method parseResult for better answers output (Still .txt, no html).
	3. The answers generating now uses C++ instead of Ruby.

## Update on main.rb - 24.06.2014/9:37PM **
	1.Added wkhtmltopdf to convert html files to pdf ones.
