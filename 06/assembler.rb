require_relative 'parser'
require_relative 'symbol_table'

symbols = SymbolTable.new()
assemblyIn = File.read("test.asm")
parser = Parser.new(assemblyIn)
parser.parse_input
