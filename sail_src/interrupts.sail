register NMI : bits(1)
register RST : bits(1)
register IRQ : bits(1)

let NMI_vec : address = 0xFFFA
let RST_vec : address = 0xFFFC
let IRQ_vec : address = 0xFFFE

val perform_interrupt : (unit) -> unit
function perform_interrupt() = {
	/*
		By the time this is executed, reg_PC = instruction PC
		So to preserve instruction PC + 2, calculate reg_PC + 2.
	*/
	let stored_pc = reg_PC + 2;
	push(stored_pc[15..8]);
	push(stored_pc[7..0]);

    // set the unused flag but not the B flag on the stack (hardware interrupt)
    let stored_SR = reg_SR[all] | 0x20;
    push(stored_SR);

    // set the interrupt mask flag since we are in an interrupt sequence
	reg_SR[i] = 0b1;

	let PCH = read(IRQ_vec + 1);
	let PCL = read(IRQ_vec);
	reg_PC = PCH @ PCL;
}

val reset_model : (unit) -> unit
function reset_model() = {
	let PCH : word = read(RST_vec + 1);
	let PCL : word = read(RST_vec);

	reg_PC[15..8] = PCH;
	reg_PC[7..0]  = PCL;

	reg_A  = undefined;
	reg_X  = undefined;
	reg_Y  = undefined;
	reg_SP = undefined;
	reg_SR[all] = undefined;

	cycles = 0;
	instructions_done = 0;

	NMI = 0b1;
	RST = 0b1;
	IRQ = 0b1;
}

val check_for_interrupt : (unit) -> unit
function check_for_interrupt() = {
    NMI = get_nmi();
    RST = get_rst();
    IRQ = get_irq();

    if (RST == 0b0) then {
        reset_model();
        print_bits("performed reset, now at pc: ", reg_PC);
        RST = 0b1;
    };

    if (reg_SR[i] == 0b0 & IRQ == 0b0) then {
        perform_interrupt();
        IRQ = 0b1;
    };

    if (NMI == 0b0) then {
        perform_interrupt();
        NMI = 0b1;
    };
}