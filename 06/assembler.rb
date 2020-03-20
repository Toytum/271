require_relative 'parser'

assemblyIn = File.read("test.asm")
parser = Parser.new(assemblyIn)
parser.parse_input
