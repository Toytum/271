class Parser
    attr_accessor :COMP, :DEST, :JUMP
    COMP = {'0'=>'101010', '1'=>'111111', '-1'=>'111010', 
            'D'=>'001100', 'A'=>'110000', '!D'=>'001101', 
            '!A'=>'110001', '-D'=>'001111','-A'=>'110011',
            'D+1'=>'011111', 'A+1'=>'110111', 'D-1'=>'001110', 
            'A-1'=>'110010', 'D+A'=>'000010', 'D-A'=>'010011',
            'A-D'=>'000111', 'D&A'=>'000000', 'D|A'=>'010101', 
            'M'=>'110000', '!M'=>'110001', '-M'=>'110011', 
            'M+1'=>'110111','M-1'=>'110010', 'D+M'=>'000010',
            'D-M'=>'010011', 'M-D'=>'000111', 'D&M'=>'000000', 
            'D|M'=>'010101'
        }

    DEST = {'null'=>'000', 'M'=>'001', 'D'=>'010',
            'MD'=>'011', 'A'=>'100', 'AM'=>'101',
            'AD'=>'110', 'AMD'=>'111'
        }

    JUMP = {'null'=>'000', 'JGT'=>'001', 'JEQ'=>'010',
            'JGE'=>'011', 'JLT'=>'100', 'JNE'=>'101',
            'JLE'=>'110', 'JMP'=>'111'}
    SYMBOLS = { "SP" => 0, "LCL" => 1, "ARG" => 2, "THIS" => 3, "That" => 4,  "R0" => 0, "R1" => 1, "R2" => 2, "R3" => 3,
                "R4" => 4, "R5" => 5, "R6" => 6, "R7" => 7, "R8" => 8, "R9" => 9, "R10" => 10, "R11" => 11, "R12" => 12, "R13" => 13,
                "R14" => 14, "R15" => 15, "SCREEN" => 16834, "KBD" => 24576
            }
            
    
    def initialize(input_file = nil)
        @line_num = 0
        @fileIn = input_file
        @newIndex = 16
        @line_uses_memory = false
    end

    def parse_input(output_file)
        @fileIn.gsub(/\r\n+/, "\n")
        @fileIn.each_line do |line|
            if command_type(line) == "comp"
                line = strip_whitespace(line)
                line = standardize_line(line)
                prefix = set_prefix(line)
                line = strip_whitespace(line)
                line = translate_standard(line)
                line = prefix + line[0] + line[1] + line[2] + "\n"
                output_file.write(line)
            elsif command_type(line) == "address"
                strip_whitespace(line)
                line = constant_add(line) + "\n"
                output_file.write(line)
            end
        end
    end

    def strip_whitespace(command)
        line = command.delete(" ")
        line = line.delete("\n")
        return line
    end

    def command_type(command)
        if command.include?("@")
            return "address"
        else 
            return "comp"
        end
    end

    def uses_memory?(command)
        command_list = command.split(/[;-=]/)
        if command_list[0].include?("M")
            @line_uses_memory = true
        end
        if command_list[1].include?("M")
            @line_uses_memory = true
        end
    end

    def set_prefix(command)
        uses_memory?(command)
        if @line_uses_memory == true
            @line_uses_memory = false
            return "1111"
        else
            return "1110"
        end
    end

    def standardize_line(command)
        unless command.include?("=")
            prefix = "null="
            command = prefix.concat(command)
        end
        unless command.include?(";")
            command = command.concat(";null")
        end
        return command
    end

    def translate_standard(command)
        command_list = command.split(/[;-=]/)
        return DEST[command_list[0]], COMP[command_list[1]], JUMP[command_list[2]]
    end

    def contains?(symbol)
        SYMBOLS.key?(symbol)
    end

    def symbol_val(command)
        return SYMBOLS[command]
    end

    def add_symbol(command)
        unless SYMBOLS.include?(symbol_val(command))
            SYMBOLS[symbol_val(command)] = @newIndex
            @newIndex += 1
        end
    end

    def type_of_add?(symbol)
        strip_whitespace(symbol)
        symbol = symbol[1..-1]
        symbol = symbol.to_s
        # puts symbol
        if symbol == (/\d/)
            # puts "Constant Address"
        else
            # puts "Variable Address"
        end
    end

    def constant_add(command)
        return command.split('@')[1].to_i.to_s(2).rjust(16,'0')
    end
end