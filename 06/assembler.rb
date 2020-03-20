require_relative 'parser'
input = "#{ARGV[0]}"
assemblyIn = File.read(input)
parser = Parser.new(assemblyIn)
output = File.open("outputfile.txt", 'w')

parser.parse_input(output)