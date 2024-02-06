def assembler(insn):
    # file = open(filename)

    operands = insn.split(' ')

    # PARSE OPCODES
    opcode_switch = {
        'Add': '000',
        'Addi': '001',
        'AND': '010',
        'XOR': '011',
        'Store': '100',
        'Load': '101',
        'Lt': '11000',
        'Neq': '11001',
        'Eq': '11010',
        'Jump': '11011',
        '>>': '1110',
        '<<': '1111',
        'Ack': '111111111'
    }
    opcode = opcode_switch.get(operands[0])

    ### PARSE FIRST OPERAND ###
    # CASE 1: FIRST OPERAND IS REGISTER
    op1 = ''
    if ((operands[1])[0] == 'r'):
        decimal = int((operands[1])[1])
        binary = []
        while (decimal > 0):
            divided = decimal % 2
            binary.append(divided)
            decimal = decimal // 2

        while len(opcode) + len(binary) < 7 and len(binary) < 3:
            binary.append(0)
        binary.reverse()
        binaryString = ''
        for i in binary:
            binaryString += str(i)

        op1 = binaryString

    # CASE 2: FIRST OPERAND IS LUT VALUE
    else:
        op1 = operands[1]



    ### PARSE SECOND OPERAND ###
    op2 = ''
    if (opcode != '11011'):
        # CASE 1: SECOND OPERAND IS REGISTER
        if ((operands[2])[0] == 'r'):
            decimal = int((operands[2])[1])
            binary = []
            while (decimal > 0):
                divided = decimal % 2
                binary.append(divided)
                decimal = decimal // 2

            while len(opcode) + len(binary) < 7 and len(binary) < 3:
                binary.append(0)
            binary.reverse()
            binaryString = ''
            for i in binary:
                binaryString += str(i)

            op2 = binaryString

        # CASE 2: SECOND OPERAND IS LUT VALUE
        else:
            op2 = operands[2]


    ### CONCATENATE MACHINE CODE TRANSLATION ###
    machine_code = opcode + op1
    if (op2 != ''):
        machine_code += op2
    
    # Add extra 0's if not filled
    while len(machine_code) < 9:
        machine_code += '0'
    
    return machine_code


### TESTING ###
test_insn = 'Jump 0010'
translation = assembler(test_insn)
print(test_insn + ": " + translation)

test_insn = 'XOR r2, r1'
translation = assembler(test_insn)
print(test_insn + ": " + translation)

test_insn = 'Lt r1 00'
translation = assembler(test_insn)
print(test_insn + ": " + translation)

test_insn = 'Neq r1 r3'
translation = assembler(test_insn)
print(test_insn + ": " + translation)