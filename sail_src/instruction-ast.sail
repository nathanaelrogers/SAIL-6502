scattered union ast

val execute : ast -> bool
scattered function execute

union clause ast = ADC_IMM   : (word)
union clause ast = ADC_ZP    : (word)
union clause ast = ADC_ZP_X  : (word)
union clause ast = ADC_ABS   : (address)
union clause ast = ADC_ABS_X : (address)
union clause ast = ADC_ABS_Y : (address)
union clause ast = ADC_IND_X : (word)
union clause ast = ADC_IND_Y : (word)
$include "./instructions/arithmetic/ADC.sail"

union clause ast = AND_IMM   : (word)
union clause ast = AND_ZP    : (word)
union clause ast = AND_ZP_X  : (word)
union clause ast = AND_ABS   : (address)
union clause ast = AND_ABS_X : (address)
union clause ast = AND_ABS_Y : (address)
union clause ast = AND_IND_X : (word)
union clause ast = AND_IND_Y : (word)
union clause ast = EOR_IMM   : (word)
union clause ast = EOR_ZP    : (word)
union clause ast = EOR_ZP_X  : (word)
union clause ast = EOR_ABS   : (address)
union clause ast = EOR_ABS_X : (address)
union clause ast = EOR_ABS_Y : (address)
union clause ast = EOR_IND_X : (word)
union clause ast = EOR_IND_Y : (word)
union clause ast = ORA_IMM   : (word)
union clause ast = ORA_ZP    : (word)
union clause ast = ORA_ZP_X  : (word)
union clause ast = ORA_ABS   : (address)
union clause ast = ORA_ABS_X : (address)
union clause ast = ORA_ABS_Y : (address)
union clause ast = ORA_IND_X : (word)
union clause ast = ORA_IND_Y : (word)
$include "./instructions/logical.sail"

union clause ast = ASL   : (unit)
union clause ast = ASL_ZP    : (word)
union clause ast = ASL_ZP_X  : (word)
union clause ast = ASL_ABS   : (address)
union clause ast = ASL_ABS_X : (address)
$include "./instructions/shift/ASL.sail"

union clause ast = BCC_REL   : (word)
union clause ast = BCS_REL   : (word)
union clause ast = BEQ_REL   : (word)
union clause ast = BMI_REL   : (word)
union clause ast = BNE_REL   : (word)
union clause ast = BPL_REL   : (word)
union clause ast = BVC_REL   : (word)
union clause ast = BVS_REL   : (word)
$include "./instructions/branch.sail"

union clause ast = BIT_ZP    : (word)
union clause ast = BIT_ABS   : (address)
$include "./instructions/misc/BIT.sail"

union clause ast = BRK       : (unit)
$include "./instructions/interrupt/BRK.sail"

union clause ast = CLC       : (unit)
union clause ast = CLD       : (unit)
union clause ast = CLI       : (unit)
union clause ast = CLV       : (unit)
union clause ast = SEC       : (unit)
union clause ast = SED       : (unit)
union clause ast = SEI       : (unit)
$include "./instructions/flag.sail"

union clause ast = CMP_IMM   : (word)
union clause ast = CMP_ZP    : (word)
union clause ast = CMP_ZP_X  : (word)
union clause ast = CMP_ABS   : (address)
union clause ast = CMP_ABS_X : (address)
union clause ast = CMP_ABS_Y : (address)
union clause ast = CMP_IND_X : (word)
union clause ast = CMP_IND_Y : (word)
$include "./instructions/comparison/CMP.sail"

union clause ast = CPY_IMM   : (word)
union clause ast = CPY_ZP    : (word)
union clause ast = CPY_ABS   : (address)
$include "./instructions/comparison/CPY.sail"

union clause ast = CPX_IMM   : (word)
union clause ast = CPX_ZP    : (word)
union clause ast = CPX_ABS   : (address)
$include "./instructions/comparison/CPX.sail"

union clause ast = DEC_ZP    : (word)
union clause ast = DEC_ZP_X  : (word)
union clause ast = DEC_ABS   : (address)
union clause ast = DEC_ABS_X : (address)
union clause ast = DEX       : (unit)
union clause ast = DEY       : (unit)
union clause ast = INC_ZP    : (word)
union clause ast = INC_ZP_X  : (word)
union clause ast = INC_ABS   : (address)
union clause ast = INC_ABS_X : (address)
union clause ast = INX   : (unit)
union clause ast = INY   : (unit)
$include "./instructions/increment.sail"

union clause ast = JMP_ABS   : (address)
union clause ast = JMP_IND   : (address)
$include "./instructions/subroutine/JMP.sail"

union clause ast = JSR_ABS   : (address)
$include "./instructions/subroutine/JSR.sail"

union clause ast = LDA_IMM   : (word)
union clause ast = LDA_ZP    : (word)
union clause ast = LDA_ZP_X  : (word)
union clause ast = LDA_ABS   : (address)
union clause ast = LDA_ABS_X : (address)
union clause ast = LDA_ABS_Y : (address)
union clause ast = LDA_IND_X : (word)
union clause ast = LDA_IND_Y : (word)
union clause ast = LDX_IMM   : (word)
union clause ast = LDX_ZP    : (word)
union clause ast = LDX_ZP_Y  : (word)
union clause ast = LDX_ABS   : (address)
union clause ast = LDX_ABS_Y : (address)
union clause ast = LDY_IMM   : (word)
union clause ast = LDY_ZP    : (word)
union clause ast = LDY_ZP_X  : (word)
union clause ast = LDY_ABS   : (address)
union clause ast = LDY_ABS_X : (address)
union clause ast = STA_ZP    : (word)
union clause ast = STA_ZP_X  : (word)
union clause ast = STA_ABS   : (address)
union clause ast = STA_ABS_X : (address)
union clause ast = STA_ABS_Y : (address)
union clause ast = STA_IND_X : (word)
union clause ast = STA_IND_Y : (word)
union clause ast = STX_ZP    : (word)
union clause ast = STX_ZP_Y  : (word)
union clause ast = STX_ABS   : (address)
union clause ast = STY_ZP    : (word)
union clause ast = STY_ZP_X  : (word)
union clause ast = STY_ABS   : (address)
union clause ast = TAX       : (unit)
union clause ast = TAY       : (unit)
union clause ast = TSX       : (unit)
union clause ast = TXA       : (unit)
union clause ast = TXS       : (unit)
union clause ast = TYA       : (unit)
$include "./instructions/transfer.sail"

union clause ast = LSR   : (unit)
union clause ast = LSR_ZP    : (word)
union clause ast = LSR_ZP_X  : (word)
union clause ast = LSR_ABS   : (address)
union clause ast = LSR_ABS_X : (address)
$include "./instructions/shift/LSR.sail"

union clause ast = NOP       : (unit)
$include "./instructions/misc/NOP.sail"

union clause ast = PHA       : (unit)
union clause ast = PHP       : (unit)
union clause ast = PLA       : (unit)
union clause ast = PLP       : (unit)
$include "./instructions/stack/PHA.sail"
$include "./instructions/stack/PHP.sail"
$include "./instructions/stack/PLA.sail"
$include "./instructions/stack/PLP.sail"

union clause ast = ROL       : (unit)
union clause ast = ROL_ZP    : (word)
union clause ast = ROL_ZP_X  : (word)
union clause ast = ROL_ABS   : (address)
union clause ast = ROL_ABS_X : (address)
$include "./instructions/shift/ROL.sail"

union clause ast = ROR       : (unit)
union clause ast = ROR_ZP    : (word)
union clause ast = ROR_ZP_X  : (word)
union clause ast = ROR_ABS   : (address)
union clause ast = ROR_ABS_X : (address)
$include "./instructions/shift/ROR.sail"

union clause ast = RTI   : (unit)
$include "./instructions/interrupt/RTI.sail"

union clause ast = RTS   : (unit)
$include "./instructions/subroutine/RTS.sail"

union clause ast = SBC_IMM   : (word)
union clause ast = SBC_ZP    : (word)
union clause ast = SBC_ZP_X  : (word)
union clause ast = SBC_ABS   : (address)
union clause ast = SBC_ABS_X : (address)
union clause ast = SBC_ABS_Y : (address)
union clause ast = SBC_IND_X : (word)
union clause ast = SBC_IND_Y : (word)
$include "./instructions/arithmetic/SBC.sail"

union clause ast = INVALID : (bits(24))
$include "./instructions/invalid.sail"
