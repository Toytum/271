
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
            'JLE'=>'110', 'JMP'=>'111'
    }

    def initialize(input_file = nil)
        @line_num = 0
        @fileIn = input_file
    end

    def parse_input
        @fileIn.gsub(/\r\n+/, "\n")
        @fileIn.each_line do |line|
            if command_type(line) == 'C'
                puts line
                line = strip_whitespace(line)
                puts "Stripped: #{line}"
                line = standardize_line(line)
                line = strip_whitespace(line)
                puts "Standardized: #{line}"
                line = translate_standard(line)
                puts "Binary: #{line}"
                line = line[0] + line[1] + line[2]
                puts line
            elsif command_type(line) == 'A'
                puts "A-Type"
                atlinestart = 0
                line = atlinestart.concat(line)
            end
        end
    end

    def strip_whitespace(command)
        line = command.delete(" ")
        line = line.delete("\n")
        return line
    end

    def command_type(command)
        if command == /^@.+/
            return 'A'
        else 
            return 'C'
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
end