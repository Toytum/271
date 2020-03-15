

class SymbolTable
    attr_accessor :SYMBOLS
    SYMBOLS = { "SP" => 0, "LCL" => 1, "ARG" => 2, "THIS" => 3, "That" => 4,  "R0" => 0, "R1" => 1, "R2" => 2, "R3" => 3,
        "R4" => 4, "R5" => 5, "R6" => 6, "R7" => 7, "R8" => 8, "R9" => 9, "R10" => 10, "R11" => 11, "R12" => 12, "R13" => 13,
        "R14" => 14, "R15" => 15, "SCREEN" => 16834, "KBD" => 24576
    }

    def initialize()
        @newIndex = 16
    end

    def symbol(command)
        command = command.split(/=/)
        return SYMBOLS[command[0]]
    end

    def new_symbol(command)
        unless SYMBOLS.include?(symbol(command))
            SYMBOLS[symbol(command)] = @newIndex
            @newIndex += 1
        end
    end
end