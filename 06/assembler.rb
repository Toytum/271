require_relative 'parser'

assemblyIn = File.read("test.asm")
parser = Parser.new(assemblyIn)
output = File.open("outputfile.txt", 'w')

parser.parse_input(output)