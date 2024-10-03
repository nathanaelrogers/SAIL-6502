#include "sail.h"
#include "rts.h"
#include "elf.h"
void (*sail_rts_set_coverage_file)(const char *) = NULL;
#ifdef __cplusplus
extern "C" {
#endif

// enum reg_enum
enum zreg_enum { zPC_H, zPC_L, zA, zX, zY, zSR, zSP };

static bool EQUAL(zreg_enum)(enum zreg_enum op1, enum zreg_enum op2) {
  return op1 == op2;
}

static enum zreg_enum UNDEFINED(zreg_enum)(unit u) { return zPC_H; }

// struct flags
struct zflags {uint64_t zbits;};

static void COPY(zflags)(struct zflags *rop, const struct zflags op) {
  rop->zbits = op.zbits;
}

static bool EQUAL(zflags)(struct zflags op1, struct zflags op2) {
  return EQUAL(fbits)(op1.zbits, op2.zbits);
}

// union exception
enum kind_zexception { Kind_z__dummy_exnz3 };

struct zexception {
  enum kind_zexception kind;
  union {struct { unit z__dummy_exnz3; };};
};

static void CREATE(zexception)(struct zexception *op) {
  op->kind = Kind_z__dummy_exnz3;
}

static void RECREATE(zexception)(struct zexception *op) {

}

static void KILL(zexception)(struct zexception *op) {
  {}
}

static void COPY(zexception)(struct zexception *rop, struct zexception op) {
  {};
  rop->kind = op.kind;
  if (op.kind == Kind_z__dummy_exnz3) {
    rop->z__dummy_exnz3 = op.z__dummy_exnz3;
  }
}

static bool EQUAL(zexception)(struct zexception op1, struct zexception op2) {
  if (op1.kind == Kind_z__dummy_exnz3 && op2.kind == Kind_z__dummy_exnz3) {
    return EQUAL(unit)(op1.z__dummy_exnz3, op2.z__dummy_exnz3);
  } else return false;
}

static void z__dummy_exnz3(struct zexception *rop, unit op) {
  {}
  rop->kind = Kind_z__dummy_exnz3;
  rop->z__dummy_exnz3 = op;
}

struct zexception *current_exception = NULL;
bool have_exception = false;
sail_string *throw_location = NULL;

// union ast
enum kind_zast { Kind_zADC_ABS, Kind_zADC_ABS_X, Kind_zADC_ABS_Y, Kind_zADC_IMM, Kind_zADC_IND_X, Kind_zADC_IND_Y, Kind_zADC_ZP, Kind_zADC_ZP_X, Kind_zAND_ABS, Kind_zAND_ABS_X, Kind_zAND_ABS_Y, Kind_zAND_IMM, Kind_zAND_IND_X, Kind_zAND_IND_Y, Kind_zAND_ZP, Kind_zAND_ZP_X, Kind_zASL, Kind_zASL_ABS, Kind_zASL_ABS_X, Kind_zASL_ZP, Kind_zASL_ZP_X, Kind_zBRK, Kind_zCLC, Kind_zCLD, Kind_zCLI, Kind_zCLV, Kind_zDEX, Kind_zDEY, Kind_zINX, Kind_zINY, Kind_zLSR, Kind_zLSR_ABS, Kind_zLSR_ABS_X, Kind_zLSR_ZP, Kind_zLSR_ZP_X, Kind_zNOP, Kind_zPHA, Kind_zPHP, Kind_zPLA, Kind_zPLP, Kind_zROL, Kind_zROL_ABS, Kind_zROL_ABS_X, Kind_zROL_ZP, Kind_zROL_ZP_X, Kind_zROR, Kind_zROR_ABS, Kind_zROR_ABS_X, Kind_zROR_ZP, Kind_zROR_ZP_X, Kind_zRTI, Kind_zRTS, Kind_zSEC, Kind_zSED, Kind_zSEI, Kind_zTAX, Kind_zTAY, Kind_zTSX, Kind_zTXA, Kind_zTXS, Kind_zTYA };

struct zast {
  enum kind_zast kind;
  union {
    struct { uint64_t zADC_ABS; };
    struct { uint64_t zADC_ABS_X; };
    struct { uint64_t zADC_ABS_Y; };
    struct { uint64_t zADC_IMM; };
    struct { uint64_t zADC_IND_X; };
    struct { uint64_t zADC_IND_Y; };
    struct { uint64_t zADC_ZP; };
    struct { uint64_t zADC_ZP_X; };
    struct { uint64_t zAND_ABS; };
    struct { uint64_t zAND_ABS_X; };
    struct { uint64_t zAND_ABS_Y; };
    struct { uint64_t zAND_IMM; };
    struct { uint64_t zAND_IND_X; };
    struct { uint64_t zAND_IND_Y; };
    struct { uint64_t zAND_ZP; };
    struct { uint64_t zAND_ZP_X; };
    struct { unit zASL; };
    struct { uint64_t zASL_ABS; };
    struct { uint64_t zASL_ABS_X; };
    struct { uint64_t zASL_ZP; };
    struct { uint64_t zASL_ZP_X; };
    struct { unit zBRK; };
    struct { unit zCLC; };
    struct { unit zCLD; };
    struct { unit zCLI; };
    struct { unit zCLV; };
    struct { unit zDEX; };
    struct { unit zDEY; };
    struct { unit zINX; };
    struct { unit zINY; };
    struct { unit zLSR; };
    struct { uint64_t zLSR_ABS; };
    struct { uint64_t zLSR_ABS_X; };
    struct { uint64_t zLSR_ZP; };
    struct { uint64_t zLSR_ZP_X; };
    struct { unit zNOP; };
    struct { unit zPHA; };
    struct { unit zPHP; };
    struct { unit zPLA; };
    struct { unit zPLP; };
    struct { unit zROL; };
    struct { uint64_t zROL_ABS; };
    struct { uint64_t zROL_ABS_X; };
    struct { uint64_t zROL_ZP; };
    struct { uint64_t zROL_ZP_X; };
    struct { unit zROR; };
    struct { uint64_t zROR_ABS; };
    struct { uint64_t zROR_ABS_X; };
    struct { uint64_t zROR_ZP; };
    struct { uint64_t zROR_ZP_X; };
    struct { unit zRTI; };
    struct { unit zRTS; };
    struct { unit zSEC; };
    struct { unit zSED; };
    struct { unit zSEI; };
    struct { unit zTAX; };
    struct { unit zTAY; };
    struct { unit zTSX; };
    struct { unit zTXA; };
    struct { unit zTXS; };
    struct { unit zTYA; };
  };
};

static void CREATE(zast)(struct zast *op) {
  op->kind = Kind_zADC_ABS;
}

static void RECREATE(zast)(struct zast *op) {

}

static void KILL(zast)(struct zast *op) {
  {}
}

static void COPY(zast)(struct zast *rop, struct zast op) {
  {};
  rop->kind = op.kind;
  if (op.kind == Kind_zADC_ABS) {
    rop->zADC_ABS = op.zADC_ABS;
  } else if (op.kind == Kind_zADC_ABS_X) {
    rop->zADC_ABS_X = op.zADC_ABS_X;
  } else if (op.kind == Kind_zADC_ABS_Y) {
    rop->zADC_ABS_Y = op.zADC_ABS_Y;
  } else if (op.kind == Kind_zADC_IMM) {
    rop->zADC_IMM = op.zADC_IMM;
  } else if (op.kind == Kind_zADC_IND_X) {
    rop->zADC_IND_X = op.zADC_IND_X;
  } else if (op.kind == Kind_zADC_IND_Y) {
    rop->zADC_IND_Y = op.zADC_IND_Y;
  } else if (op.kind == Kind_zADC_ZP) {
    rop->zADC_ZP = op.zADC_ZP;
  } else if (op.kind == Kind_zADC_ZP_X) {
    rop->zADC_ZP_X = op.zADC_ZP_X;
  } else if (op.kind == Kind_zAND_ABS) {
    rop->zAND_ABS = op.zAND_ABS;
  } else if (op.kind == Kind_zAND_ABS_X) {
    rop->zAND_ABS_X = op.zAND_ABS_X;
  } else if (op.kind == Kind_zAND_ABS_Y) {
    rop->zAND_ABS_Y = op.zAND_ABS_Y;
  } else if (op.kind == Kind_zAND_IMM) {
    rop->zAND_IMM = op.zAND_IMM;
  } else if (op.kind == Kind_zAND_IND_X) {
    rop->zAND_IND_X = op.zAND_IND_X;
  } else if (op.kind == Kind_zAND_IND_Y) {
    rop->zAND_IND_Y = op.zAND_IND_Y;
  } else if (op.kind == Kind_zAND_ZP) {
    rop->zAND_ZP = op.zAND_ZP;
  } else if (op.kind == Kind_zAND_ZP_X) {
    rop->zAND_ZP_X = op.zAND_ZP_X;
  } else if (op.kind == Kind_zASL) {
    rop->zASL = op.zASL;
  } else if (op.kind == Kind_zASL_ABS) {
    rop->zASL_ABS = op.zASL_ABS;
  } else if (op.kind == Kind_zASL_ABS_X) {
    rop->zASL_ABS_X = op.zASL_ABS_X;
  } else if (op.kind == Kind_zASL_ZP) {
    rop->zASL_ZP = op.zASL_ZP;
  } else if (op.kind == Kind_zASL_ZP_X) {
    rop->zASL_ZP_X = op.zASL_ZP_X;
  } else if (op.kind == Kind_zBRK) {
    rop->zBRK = op.zBRK;
  } else if (op.kind == Kind_zCLC) {
    rop->zCLC = op.zCLC;
  } else if (op.kind == Kind_zCLD) {
    rop->zCLD = op.zCLD;
  } else if (op.kind == Kind_zCLI) {
    rop->zCLI = op.zCLI;
  } else if (op.kind == Kind_zCLV) {
    rop->zCLV = op.zCLV;
  } else if (op.kind == Kind_zDEX) {
    rop->zDEX = op.zDEX;
  } else if (op.kind == Kind_zDEY) {
    rop->zDEY = op.zDEY;
  } else if (op.kind == Kind_zINX) {
    rop->zINX = op.zINX;
  } else if (op.kind == Kind_zINY) {
    rop->zINY = op.zINY;
  } else if (op.kind == Kind_zLSR) {
    rop->zLSR = op.zLSR;
  } else if (op.kind == Kind_zLSR_ABS) {
    rop->zLSR_ABS = op.zLSR_ABS;
  } else if (op.kind == Kind_zLSR_ABS_X) {
    rop->zLSR_ABS_X = op.zLSR_ABS_X;
  } else if (op.kind == Kind_zLSR_ZP) {
    rop->zLSR_ZP = op.zLSR_ZP;
  } else if (op.kind == Kind_zLSR_ZP_X) {
    rop->zLSR_ZP_X = op.zLSR_ZP_X;
  } else if (op.kind == Kind_zNOP) {
    rop->zNOP = op.zNOP;
  } else if (op.kind == Kind_zPHA) {
    rop->zPHA = op.zPHA;
  } else if (op.kind == Kind_zPHP) {
    rop->zPHP = op.zPHP;
  } else if (op.kind == Kind_zPLA) {
    rop->zPLA = op.zPLA;
  } else if (op.kind == Kind_zPLP) {
    rop->zPLP = op.zPLP;
  } else if (op.kind == Kind_zROL) {
    rop->zROL = op.zROL;
  } else if (op.kind == Kind_zROL_ABS) {
    rop->zROL_ABS = op.zROL_ABS;
  } else if (op.kind == Kind_zROL_ABS_X) {
    rop->zROL_ABS_X = op.zROL_ABS_X;
  } else if (op.kind == Kind_zROL_ZP) {
    rop->zROL_ZP = op.zROL_ZP;
  } else if (op.kind == Kind_zROL_ZP_X) {
    rop->zROL_ZP_X = op.zROL_ZP_X;
  } else if (op.kind == Kind_zROR) {
    rop->zROR = op.zROR;
  } else if (op.kind == Kind_zROR_ABS) {
    rop->zROR_ABS = op.zROR_ABS;
  } else if (op.kind == Kind_zROR_ABS_X) {
    rop->zROR_ABS_X = op.zROR_ABS_X;
  } else if (op.kind == Kind_zROR_ZP) {
    rop->zROR_ZP = op.zROR_ZP;
  } else if (op.kind == Kind_zROR_ZP_X) {
    rop->zROR_ZP_X = op.zROR_ZP_X;
  } else if (op.kind == Kind_zRTI) {
    rop->zRTI = op.zRTI;
  } else if (op.kind == Kind_zRTS) {
    rop->zRTS = op.zRTS;
  } else if (op.kind == Kind_zSEC) {
    rop->zSEC = op.zSEC;
  } else if (op.kind == Kind_zSED) {
    rop->zSED = op.zSED;
  } else if (op.kind == Kind_zSEI) {
    rop->zSEI = op.zSEI;
  } else if (op.kind == Kind_zTAX) {
    rop->zTAX = op.zTAX;
  } else if (op.kind == Kind_zTAY) {
    rop->zTAY = op.zTAY;
  } else if (op.kind == Kind_zTSX) {
    rop->zTSX = op.zTSX;
  } else if (op.kind == Kind_zTXA) {
    rop->zTXA = op.zTXA;
  } else if (op.kind == Kind_zTXS) {
    rop->zTXS = op.zTXS;
  } else if (op.kind == Kind_zTYA) {
    rop->zTYA = op.zTYA;
  }
}

static bool EQUAL(zast)(struct zast op1, struct zast op2) {
  if (op1.kind == Kind_zADC_ABS && op2.kind == Kind_zADC_ABS) {
    return EQUAL(fbits)(op1.zADC_ABS, op2.zADC_ABS);
  } else if (op1.kind == Kind_zADC_ABS_X && op2.kind == Kind_zADC_ABS_X) {
    return EQUAL(fbits)(op1.zADC_ABS_X, op2.zADC_ABS_X);
  } else if (op1.kind == Kind_zADC_ABS_Y && op2.kind == Kind_zADC_ABS_Y) {
    return EQUAL(fbits)(op1.zADC_ABS_Y, op2.zADC_ABS_Y);
  } else if (op1.kind == Kind_zADC_IMM && op2.kind == Kind_zADC_IMM) {
    return EQUAL(fbits)(op1.zADC_IMM, op2.zADC_IMM);
  } else if (op1.kind == Kind_zADC_IND_X && op2.kind == Kind_zADC_IND_X) {
    return EQUAL(fbits)(op1.zADC_IND_X, op2.zADC_IND_X);
  } else if (op1.kind == Kind_zADC_IND_Y && op2.kind == Kind_zADC_IND_Y) {
    return EQUAL(fbits)(op1.zADC_IND_Y, op2.zADC_IND_Y);
  } else if (op1.kind == Kind_zADC_ZP && op2.kind == Kind_zADC_ZP) {
    return EQUAL(fbits)(op1.zADC_ZP, op2.zADC_ZP);
  } else if (op1.kind == Kind_zADC_ZP_X && op2.kind == Kind_zADC_ZP_X) {
    return EQUAL(fbits)(op1.zADC_ZP_X, op2.zADC_ZP_X);
  } else if (op1.kind == Kind_zAND_ABS && op2.kind == Kind_zAND_ABS) {
    return EQUAL(fbits)(op1.zAND_ABS, op2.zAND_ABS);
  } else if (op1.kind == Kind_zAND_ABS_X && op2.kind == Kind_zAND_ABS_X) {
    return EQUAL(fbits)(op1.zAND_ABS_X, op2.zAND_ABS_X);
  } else if (op1.kind == Kind_zAND_ABS_Y && op2.kind == Kind_zAND_ABS_Y) {
    return EQUAL(fbits)(op1.zAND_ABS_Y, op2.zAND_ABS_Y);
  } else if (op1.kind == Kind_zAND_IMM && op2.kind == Kind_zAND_IMM) {
    return EQUAL(fbits)(op1.zAND_IMM, op2.zAND_IMM);
  } else if (op1.kind == Kind_zAND_IND_X && op2.kind == Kind_zAND_IND_X) {
    return EQUAL(fbits)(op1.zAND_IND_X, op2.zAND_IND_X);
  } else if (op1.kind == Kind_zAND_IND_Y && op2.kind == Kind_zAND_IND_Y) {
    return EQUAL(fbits)(op1.zAND_IND_Y, op2.zAND_IND_Y);
  } else if (op1.kind == Kind_zAND_ZP && op2.kind == Kind_zAND_ZP) {
    return EQUAL(fbits)(op1.zAND_ZP, op2.zAND_ZP);
  } else if (op1.kind == Kind_zAND_ZP_X && op2.kind == Kind_zAND_ZP_X) {
    return EQUAL(fbits)(op1.zAND_ZP_X, op2.zAND_ZP_X);
  } else if (op1.kind == Kind_zASL && op2.kind == Kind_zASL) {
    return EQUAL(unit)(op1.zASL, op2.zASL);
  } else if (op1.kind == Kind_zASL_ABS && op2.kind == Kind_zASL_ABS) {
    return EQUAL(fbits)(op1.zASL_ABS, op2.zASL_ABS);
  } else if (op1.kind == Kind_zASL_ABS_X && op2.kind == Kind_zASL_ABS_X) {
    return EQUAL(fbits)(op1.zASL_ABS_X, op2.zASL_ABS_X);
  } else if (op1.kind == Kind_zASL_ZP && op2.kind == Kind_zASL_ZP) {
    return EQUAL(fbits)(op1.zASL_ZP, op2.zASL_ZP);
  } else if (op1.kind == Kind_zASL_ZP_X && op2.kind == Kind_zASL_ZP_X) {
    return EQUAL(fbits)(op1.zASL_ZP_X, op2.zASL_ZP_X);
  } else if (op1.kind == Kind_zBRK && op2.kind == Kind_zBRK) {
    return EQUAL(unit)(op1.zBRK, op2.zBRK);
  } else if (op1.kind == Kind_zCLC && op2.kind == Kind_zCLC) {
    return EQUAL(unit)(op1.zCLC, op2.zCLC);
  } else if (op1.kind == Kind_zCLD && op2.kind == Kind_zCLD) {
    return EQUAL(unit)(op1.zCLD, op2.zCLD);
  } else if (op1.kind == Kind_zCLI && op2.kind == Kind_zCLI) {
    return EQUAL(unit)(op1.zCLI, op2.zCLI);
  } else if (op1.kind == Kind_zCLV && op2.kind == Kind_zCLV) {
    return EQUAL(unit)(op1.zCLV, op2.zCLV);
  } else if (op1.kind == Kind_zDEX && op2.kind == Kind_zDEX) {
    return EQUAL(unit)(op1.zDEX, op2.zDEX);
  } else if (op1.kind == Kind_zDEY && op2.kind == Kind_zDEY) {
    return EQUAL(unit)(op1.zDEY, op2.zDEY);
  } else if (op1.kind == Kind_zINX && op2.kind == Kind_zINX) {
    return EQUAL(unit)(op1.zINX, op2.zINX);
  } else if (op1.kind == Kind_zINY && op2.kind == Kind_zINY) {
    return EQUAL(unit)(op1.zINY, op2.zINY);
  } else if (op1.kind == Kind_zLSR && op2.kind == Kind_zLSR) {
    return EQUAL(unit)(op1.zLSR, op2.zLSR);
  } else if (op1.kind == Kind_zLSR_ABS && op2.kind == Kind_zLSR_ABS) {
    return EQUAL(fbits)(op1.zLSR_ABS, op2.zLSR_ABS);
  } else if (op1.kind == Kind_zLSR_ABS_X && op2.kind == Kind_zLSR_ABS_X) {
    return EQUAL(fbits)(op1.zLSR_ABS_X, op2.zLSR_ABS_X);
  } else if (op1.kind == Kind_zLSR_ZP && op2.kind == Kind_zLSR_ZP) {
    return EQUAL(fbits)(op1.zLSR_ZP, op2.zLSR_ZP);
  } else if (op1.kind == Kind_zLSR_ZP_X && op2.kind == Kind_zLSR_ZP_X) {
    return EQUAL(fbits)(op1.zLSR_ZP_X, op2.zLSR_ZP_X);
  } else if (op1.kind == Kind_zNOP && op2.kind == Kind_zNOP) {
    return EQUAL(unit)(op1.zNOP, op2.zNOP);
  } else if (op1.kind == Kind_zPHA && op2.kind == Kind_zPHA) {
    return EQUAL(unit)(op1.zPHA, op2.zPHA);
  } else if (op1.kind == Kind_zPHP && op2.kind == Kind_zPHP) {
    return EQUAL(unit)(op1.zPHP, op2.zPHP);
  } else if (op1.kind == Kind_zPLA && op2.kind == Kind_zPLA) {
    return EQUAL(unit)(op1.zPLA, op2.zPLA);
  } else if (op1.kind == Kind_zPLP && op2.kind == Kind_zPLP) {
    return EQUAL(unit)(op1.zPLP, op2.zPLP);
  } else if (op1.kind == Kind_zROL && op2.kind == Kind_zROL) {
    return EQUAL(unit)(op1.zROL, op2.zROL);
  } else if (op1.kind == Kind_zROL_ABS && op2.kind == Kind_zROL_ABS) {
    return EQUAL(fbits)(op1.zROL_ABS, op2.zROL_ABS);
  } else if (op1.kind == Kind_zROL_ABS_X && op2.kind == Kind_zROL_ABS_X) {
    return EQUAL(fbits)(op1.zROL_ABS_X, op2.zROL_ABS_X);
  } else if (op1.kind == Kind_zROL_ZP && op2.kind == Kind_zROL_ZP) {
    return EQUAL(fbits)(op1.zROL_ZP, op2.zROL_ZP);
  } else if (op1.kind == Kind_zROL_ZP_X && op2.kind == Kind_zROL_ZP_X) {
    return EQUAL(fbits)(op1.zROL_ZP_X, op2.zROL_ZP_X);
  } else if (op1.kind == Kind_zROR && op2.kind == Kind_zROR) {
    return EQUAL(unit)(op1.zROR, op2.zROR);
  } else if (op1.kind == Kind_zROR_ABS && op2.kind == Kind_zROR_ABS) {
    return EQUAL(fbits)(op1.zROR_ABS, op2.zROR_ABS);
  } else if (op1.kind == Kind_zROR_ABS_X && op2.kind == Kind_zROR_ABS_X) {
    return EQUAL(fbits)(op1.zROR_ABS_X, op2.zROR_ABS_X);
  } else if (op1.kind == Kind_zROR_ZP && op2.kind == Kind_zROR_ZP) {
    return EQUAL(fbits)(op1.zROR_ZP, op2.zROR_ZP);
  } else if (op1.kind == Kind_zROR_ZP_X && op2.kind == Kind_zROR_ZP_X) {
    return EQUAL(fbits)(op1.zROR_ZP_X, op2.zROR_ZP_X);
  } else if (op1.kind == Kind_zRTI && op2.kind == Kind_zRTI) {
    return EQUAL(unit)(op1.zRTI, op2.zRTI);
  } else if (op1.kind == Kind_zRTS && op2.kind == Kind_zRTS) {
    return EQUAL(unit)(op1.zRTS, op2.zRTS);
  } else if (op1.kind == Kind_zSEC && op2.kind == Kind_zSEC) {
    return EQUAL(unit)(op1.zSEC, op2.zSEC);
  } else if (op1.kind == Kind_zSED && op2.kind == Kind_zSED) {
    return EQUAL(unit)(op1.zSED, op2.zSED);
  } else if (op1.kind == Kind_zSEI && op2.kind == Kind_zSEI) {
    return EQUAL(unit)(op1.zSEI, op2.zSEI);
  } else if (op1.kind == Kind_zTAX && op2.kind == Kind_zTAX) {
    return EQUAL(unit)(op1.zTAX, op2.zTAX);
  } else if (op1.kind == Kind_zTAY && op2.kind == Kind_zTAY) {
    return EQUAL(unit)(op1.zTAY, op2.zTAY);
  } else if (op1.kind == Kind_zTSX && op2.kind == Kind_zTSX) {
    return EQUAL(unit)(op1.zTSX, op2.zTSX);
  } else if (op1.kind == Kind_zTXA && op2.kind == Kind_zTXA) {
    return EQUAL(unit)(op1.zTXA, op2.zTXA);
  } else if (op1.kind == Kind_zTXS && op2.kind == Kind_zTXS) {
    return EQUAL(unit)(op1.zTXS, op2.zTXS);
  } else if (op1.kind == Kind_zTYA && op2.kind == Kind_zTYA) {
    return EQUAL(unit)(op1.zTYA, op2.zTYA);
  } else return false;
}

static void zADC_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_ABS;
  rop->zADC_ABS = op;
}

static void zADC_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_ABS_X;
  rop->zADC_ABS_X = op;
}

static void zADC_ABS_Y(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_ABS_Y;
  rop->zADC_ABS_Y = op;
}

static void zADC_IMM(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_IMM;
  rop->zADC_IMM = op;
}

static void zADC_IND_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_IND_X;
  rop->zADC_IND_X = op;
}

static void zADC_IND_Y(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_IND_Y;
  rop->zADC_IND_Y = op;
}

static void zADC_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_ZP;
  rop->zADC_ZP = op;
}

static void zADC_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zADC_ZP_X;
  rop->zADC_ZP_X = op;
}

static void zAND_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_ABS;
  rop->zAND_ABS = op;
}

static void zAND_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_ABS_X;
  rop->zAND_ABS_X = op;
}

static void zAND_ABS_Y(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_ABS_Y;
  rop->zAND_ABS_Y = op;
}

static void zAND_IMM(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_IMM;
  rop->zAND_IMM = op;
}

static void zAND_IND_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_IND_X;
  rop->zAND_IND_X = op;
}

static void zAND_IND_Y(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_IND_Y;
  rop->zAND_IND_Y = op;
}

static void zAND_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_ZP;
  rop->zAND_ZP = op;
}

static void zAND_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zAND_ZP_X;
  rop->zAND_ZP_X = op;
}

static void zASL(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zASL;
  rop->zASL = op;
}

static void zASL_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zASL_ABS;
  rop->zASL_ABS = op;
}

static void zASL_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zASL_ABS_X;
  rop->zASL_ABS_X = op;
}

static void zASL_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zASL_ZP;
  rop->zASL_ZP = op;
}

static void zASL_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zASL_ZP_X;
  rop->zASL_ZP_X = op;
}

static void zBRK(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zBRK;
  rop->zBRK = op;
}

static void zCLC(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zCLC;
  rop->zCLC = op;
}

static void zCLD(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zCLD;
  rop->zCLD = op;
}

static void zCLI(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zCLI;
  rop->zCLI = op;
}

static void zCLV(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zCLV;
  rop->zCLV = op;
}

static void zDEX(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zDEX;
  rop->zDEX = op;
}

static void zDEY(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zDEY;
  rop->zDEY = op;
}

static void zINX(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zINX;
  rop->zINX = op;
}

static void zINY(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zINY;
  rop->zINY = op;
}

static void zLSR(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zLSR;
  rop->zLSR = op;
}

static void zLSR_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zLSR_ABS;
  rop->zLSR_ABS = op;
}

static void zLSR_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zLSR_ABS_X;
  rop->zLSR_ABS_X = op;
}

static void zLSR_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zLSR_ZP;
  rop->zLSR_ZP = op;
}

static void zLSR_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zLSR_ZP_X;
  rop->zLSR_ZP_X = op;
}

static void zNOP(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zNOP;
  rop->zNOP = op;
}

static void zPHA(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zPHA;
  rop->zPHA = op;
}

static void zPHP(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zPHP;
  rop->zPHP = op;
}

static void zPLA(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zPLA;
  rop->zPLA = op;
}

static void zPLP(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zPLP;
  rop->zPLP = op;
}

static void zROL(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zROL;
  rop->zROL = op;
}

static void zROL_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROL_ABS;
  rop->zROL_ABS = op;
}

static void zROL_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROL_ABS_X;
  rop->zROL_ABS_X = op;
}

static void zROL_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROL_ZP;
  rop->zROL_ZP = op;
}

static void zROL_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROL_ZP_X;
  rop->zROL_ZP_X = op;
}

static void zROR(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zROR;
  rop->zROR = op;
}

static void zROR_ABS(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROR_ABS;
  rop->zROR_ABS = op;
}

static void zROR_ABS_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROR_ABS_X;
  rop->zROR_ABS_X = op;
}

static void zROR_ZP(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROR_ZP;
  rop->zROR_ZP = op;
}

static void zROR_ZP_X(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zROR_ZP_X;
  rop->zROR_ZP_X = op;
}

static void zRTI(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zRTI;
  rop->zRTI = op;
}

static void zRTS(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zRTS;
  rop->zRTS = op;
}

static void zSEC(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zSEC;
  rop->zSEC = op;
}

static void zSED(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zSED;
  rop->zSED = op;
}

static void zSEI(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zSEI;
  rop->zSEI = op;
}

static void zTAX(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTAX;
  rop->zTAX = op;
}

static void zTAY(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTAY;
  rop->zTAY = op;
}

static void zTSX(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTSX;
  rop->zTSX = op;
}

static void zTXA(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTXA;
  rop->zTXA = op;
}

static void zTXS(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTXS;
  rop->zTXS = op;
}

static void zTYA(struct zast *rop, unit op) {
  {}
  rop->kind = Kind_zTYA;
  rop->zTYA = op;
}

















struct zflags zundefined_flags(unit);

struct zflags zundefined_flags(unit zgsz30)
{
  __label__ end_function_1, end_block_exception_2;

  struct zflags zcbz30;
  uint64_t zgaz30;
  {
    sail_int zgsz363;
    CREATE(sail_int)(&zgsz363);
    CONVERT_OF(sail_int, mach_int)(&zgsz363, INT64_C(8));
    lbits zgsz364;
    CREATE(lbits)(&zgsz364);
    UNDEFINED(lbits)(&zgsz364, zgsz363);
    zgaz30 = CONVERT_OF(fbits, lbits)(zgsz364, true);
    KILL(lbits)(&zgsz364);
    KILL(sail_int)(&zgsz363);
  }
  struct zflags zgsz31;
  zgsz31.zbits = zgaz30;
  zcbz30 = zgsz31;


end_function_1: ;
  return zcbz30;
end_block_exception_2: ;
  struct zflags zcbz39 = { .zbits = UINT64_C(0xdeadc0de) };
  return zcbz39;
}

uint64_t z_get_flags_all(struct zflags);

uint64_t z_get_flags_all(struct zflags zv)
{
  __label__ end_function_4, end_block_exception_5;

  uint64_t zcbz31;
  uint64_t zgaz31;
  zgaz31 = zv.zbits;
  {
    lbits zgsz365;
    CREATE(lbits)(&zgsz365);
    CONVERT_OF(lbits, fbits)(&zgsz365, zgaz31, UINT64_C(8) , true);
    sail_int zgsz366;
    CREATE(sail_int)(&zgsz366);
    CONVERT_OF(sail_int, mach_int)(&zgsz366, INT64_C(7));
    sail_int zgsz367;
    CREATE(sail_int)(&zgsz367);
    CONVERT_OF(sail_int, mach_int)(&zgsz367, INT64_C(0));
    lbits zgsz368;
    CREATE(lbits)(&zgsz368);
    vector_subrange_lbits(&zgsz368, zgsz365, zgsz366, zgsz367);
    zcbz31 = CONVERT_OF(fbits, lbits)(zgsz368, true);
    KILL(lbits)(&zgsz368);
    KILL(sail_int)(&zgsz367);
    KILL(sail_int)(&zgsz366);
    KILL(lbits)(&zgsz365);
  }

end_function_4: ;
  return zcbz31;
end_block_exception_5: ;

  return UINT64_C(0xdeadc0de);
}

// register reg_PC
uint64_t zreg_PC;

// register reg_A
uint64_t zreg_A;

// register reg_X
uint64_t zreg_X;

// register reg_Y
uint64_t zreg_Y;

// register reg_SR
struct zflags zreg_SR;

// register reg_SP
uint64_t zreg_SP;

uint64_t zNMI;
static void create_letbind_0(void) {


  uint64_t zgsz32;
  zgsz32 = UINT64_C(0b1);
  zNMI = zgsz32;

let_end_6: ;
}
static void kill_letbind_0(void) {
}

uint64_t zNMI_vec;
static void create_letbind_1(void) {


  uint64_t zgsz33;
  zgsz33 = UINT64_C(0xFFFA);
  zNMI_vec = zgsz33;

let_end_7: ;
}
static void kill_letbind_1(void) {
}

uint64_t zRES;
static void create_letbind_2(void) {


  uint64_t zgsz34;
  zgsz34 = UINT64_C(0b1);
  zRES = zgsz34;

let_end_8: ;
}
static void kill_letbind_2(void) {
}

uint64_t zRES_vec;
static void create_letbind_3(void) {


  uint64_t zgsz35;
  zgsz35 = UINT64_C(0xFFFC);
  zRES_vec = zgsz35;

let_end_9: ;
}
static void kill_letbind_3(void) {
}

uint64_t zIRQ;
static void create_letbind_4(void) {


  uint64_t zgsz36;
  zgsz36 = UINT64_C(0b1);
  zIRQ = zgsz36;

let_end_10: ;
}
static void kill_letbind_4(void) {
}

uint64_t zIRQ_vec;
static void create_letbind_5(void) {


  uint64_t zgsz37;
  zgsz37 = UINT64_C(0xFFFE);
  zIRQ_vec = zgsz37;

let_end_11: ;
}
static void kill_letbind_5(void) {
}

uint64_t zreg_forwards(enum zreg_enum);

uint64_t zreg_forwards(enum zreg_enum zargz3)
{
  __label__ case_14, case_15, case_16, case_17, case_18, case_19, case_20, finish_match_13, end_function_21, end_block_exception_22;

  uint64_t zcbz32;
  /* Case with num_cases: 7 */
  uint64_t zgsz38;
  {
    if ((zPC_H != zargz3)) goto case_14;
    zgsz38 = UINT64_C(0b000);
    goto finish_match_13;
  }
case_14: ;
  {
    if ((zPC_L != zargz3)) goto case_15;
    zgsz38 = UINT64_C(0b001);
    goto finish_match_13;
  }
case_15: ;
  {
    if ((zA != zargz3)) goto case_16;
    zgsz38 = UINT64_C(0b010);
    goto finish_match_13;
  }
case_16: ;
  {
    if ((zX != zargz3)) goto case_17;
    zgsz38 = UINT64_C(0b011);
    goto finish_match_13;
  }
case_17: ;
  {
    if ((zY != zargz3)) goto case_18;
    zgsz38 = UINT64_C(0b100);
    goto finish_match_13;
  }
case_18: ;
  {
    if ((zSR != zargz3)) goto case_19;
    zgsz38 = UINT64_C(0b101);
    goto finish_match_13;
  }
case_19: ;
  {
    if ((zSP != zargz3)) goto case_20;
    zgsz38 = UINT64_C(0b110);
    goto finish_match_13;
  }
case_20: ;
  sail_match_failure("reg_forwards");
finish_match_13: ;
  zcbz32 = zgsz38;

end_function_21: ;
  return zcbz32;
end_block_exception_22: ;

  return UINT64_C(0xdeadc0de);
}

uint64_t zread_reg(uint64_t);

uint64_t zread_reg(uint64_t zr)
{
  __label__ case_25, case_26, case_27, case_28, case_29, case_30, case_31, finish_match_24, end_function_32, end_block_exception_33;

  uint64_t zcbz33;
  /* Case with num_cases: 7 */
  uint64_t zgsz316;
  {
    uint64_t zb__0;
    zb__0 = zr;
    bool zgsz317;
    {
      lbits zgsz373;
      CREATE(lbits)(&zgsz373);
      CONVERT_OF(lbits, fbits)(&zgsz373, zb__0, UINT64_C(3) , true);
      lbits zgsz374;
      CREATE(lbits)(&zgsz374);
      CONVERT_OF(lbits, fbits)(&zgsz374, UINT64_C(0b000), UINT64_C(3) , true);
      zgsz317 = eq_bits(zgsz373, zgsz374);
      KILL(lbits)(&zgsz374);
      KILL(lbits)(&zgsz373);
    }
    if (!(zgsz317)) {

      goto case_25;
    }
    {
      lbits zgsz369;
      CREATE(lbits)(&zgsz369);
      CONVERT_OF(lbits, fbits)(&zgsz369, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz370;
      CREATE(sail_int)(&zgsz370);
      CONVERT_OF(sail_int, mach_int)(&zgsz370, INT64_C(15));
      sail_int zgsz371;
      CREATE(sail_int)(&zgsz371);
      CONVERT_OF(sail_int, mach_int)(&zgsz371, INT64_C(8));
      lbits zgsz372;
      CREATE(lbits)(&zgsz372);
      vector_subrange_lbits(&zgsz372, zgsz369, zgsz370, zgsz371);
      zgsz316 = CONVERT_OF(fbits, lbits)(zgsz372, true);
      KILL(lbits)(&zgsz372);
      KILL(sail_int)(&zgsz371);
      KILL(sail_int)(&zgsz370);
      KILL(lbits)(&zgsz369);
    }
    goto finish_match_24;
  }
case_25: ;
  {
    uint64_t zb__1;
    zb__1 = zr;
    bool zgsz318;
    {
      lbits zgsz379;
      CREATE(lbits)(&zgsz379);
      CONVERT_OF(lbits, fbits)(&zgsz379, zb__1, UINT64_C(3) , true);
      lbits zgsz380;
      CREATE(lbits)(&zgsz380);
      CONVERT_OF(lbits, fbits)(&zgsz380, UINT64_C(0b001), UINT64_C(3) , true);
      zgsz318 = eq_bits(zgsz379, zgsz380);
      KILL(lbits)(&zgsz380);
      KILL(lbits)(&zgsz379);
    }
    if (!(zgsz318)) {

      goto case_26;
    }
    {
      lbits zgsz375;
      CREATE(lbits)(&zgsz375);
      CONVERT_OF(lbits, fbits)(&zgsz375, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz376;
      CREATE(sail_int)(&zgsz376);
      CONVERT_OF(sail_int, mach_int)(&zgsz376, INT64_C(7));
      sail_int zgsz377;
      CREATE(sail_int)(&zgsz377);
      CONVERT_OF(sail_int, mach_int)(&zgsz377, INT64_C(0));
      lbits zgsz378;
      CREATE(lbits)(&zgsz378);
      vector_subrange_lbits(&zgsz378, zgsz375, zgsz376, zgsz377);
      zgsz316 = CONVERT_OF(fbits, lbits)(zgsz378, true);
      KILL(lbits)(&zgsz378);
      KILL(sail_int)(&zgsz377);
      KILL(sail_int)(&zgsz376);
      KILL(lbits)(&zgsz375);
    }
    goto finish_match_24;
  }
case_26: ;
  {
    uint64_t zb__2;
    zb__2 = zr;
    bool zgsz319;
    {
      lbits zgsz381;
      CREATE(lbits)(&zgsz381);
      CONVERT_OF(lbits, fbits)(&zgsz381, zb__2, UINT64_C(3) , true);
      lbits zgsz382;
      CREATE(lbits)(&zgsz382);
      CONVERT_OF(lbits, fbits)(&zgsz382, UINT64_C(0b010), UINT64_C(3) , true);
      zgsz319 = eq_bits(zgsz381, zgsz382);
      KILL(lbits)(&zgsz382);
      KILL(lbits)(&zgsz381);
    }
    if (!(zgsz319)) {

      goto case_27;
    }
    zgsz316 = zreg_A;
    goto finish_match_24;
  }
case_27: ;
  {
    uint64_t zb__3;
    zb__3 = zr;
    bool zgsz320;
    {
      lbits zgsz383;
      CREATE(lbits)(&zgsz383);
      CONVERT_OF(lbits, fbits)(&zgsz383, zb__3, UINT64_C(3) , true);
      lbits zgsz384;
      CREATE(lbits)(&zgsz384);
      CONVERT_OF(lbits, fbits)(&zgsz384, UINT64_C(0b011), UINT64_C(3) , true);
      zgsz320 = eq_bits(zgsz383, zgsz384);
      KILL(lbits)(&zgsz384);
      KILL(lbits)(&zgsz383);
    }
    if (!(zgsz320)) {

      goto case_28;
    }
    zgsz316 = zreg_X;
    goto finish_match_24;
  }
case_28: ;
  {
    uint64_t zb__4;
    zb__4 = zr;
    bool zgsz321;
    {
      lbits zgsz385;
      CREATE(lbits)(&zgsz385);
      CONVERT_OF(lbits, fbits)(&zgsz385, zb__4, UINT64_C(3) , true);
      lbits zgsz386;
      CREATE(lbits)(&zgsz386);
      CONVERT_OF(lbits, fbits)(&zgsz386, UINT64_C(0b100), UINT64_C(3) , true);
      zgsz321 = eq_bits(zgsz385, zgsz386);
      KILL(lbits)(&zgsz386);
      KILL(lbits)(&zgsz385);
    }
    if (!(zgsz321)) {

      goto case_29;
    }
    zgsz316 = zreg_Y;
    goto finish_match_24;
  }
case_29: ;
  {
    uint64_t zb__5;
    zb__5 = zr;
    bool zgsz322;
    {
      lbits zgsz387;
      CREATE(lbits)(&zgsz387);
      CONVERT_OF(lbits, fbits)(&zgsz387, zb__5, UINT64_C(3) , true);
      lbits zgsz388;
      CREATE(lbits)(&zgsz388);
      CONVERT_OF(lbits, fbits)(&zgsz388, UINT64_C(0b101), UINT64_C(3) , true);
      zgsz322 = eq_bits(zgsz387, zgsz388);
      KILL(lbits)(&zgsz388);
      KILL(lbits)(&zgsz387);
    }
    if (!(zgsz322)) {

      goto case_30;
    }
    zgsz316 = z_get_flags_all(zreg_SR);
    goto finish_match_24;
  }
case_30: ;
  {
    uint64_t zb__6;
    zb__6 = zr;
    bool zgsz323;
    {
      lbits zgsz389;
      CREATE(lbits)(&zgsz389);
      CONVERT_OF(lbits, fbits)(&zgsz389, zb__6, UINT64_C(3) , true);
      lbits zgsz390;
      CREATE(lbits)(&zgsz390);
      CONVERT_OF(lbits, fbits)(&zgsz390, UINT64_C(0b110), UINT64_C(3) , true);
      zgsz323 = eq_bits(zgsz389, zgsz390);
      KILL(lbits)(&zgsz390);
      KILL(lbits)(&zgsz389);
    }
    if (!(zgsz323)) {

      goto case_31;
    }
    zgsz316 = zreg_SP;
    goto finish_match_24;
  }
case_31: ;
  sail_match_failure("read_reg");
finish_match_24: ;
  zcbz33 = zgsz316;

end_function_32: ;
  return zcbz33;
end_block_exception_33: ;

  return UINT64_C(0xdeadc0de);
}

unit zwrite_reg(uint64_t, uint64_t);

unit zwrite_reg(uint64_t zr, uint64_t zword)
{
  __label__ case_36, case_37, case_38, case_39, case_40, case_41, case_42, finish_match_35, end_function_43, end_block_exception_44;

  unit zcbz34;
  /* Case with num_cases: 7 */
  unit zgsz324;
  {
    uint64_t zb__0;
    zb__0 = zr;
    bool zgsz325;
    {
      lbits zgsz396;
      CREATE(lbits)(&zgsz396);
      CONVERT_OF(lbits, fbits)(&zgsz396, zb__0, UINT64_C(3) , true);
      lbits zgsz397;
      CREATE(lbits)(&zgsz397);
      CONVERT_OF(lbits, fbits)(&zgsz397, UINT64_C(0b000), UINT64_C(3) , true);
      zgsz325 = eq_bits(zgsz396, zgsz397);
      KILL(lbits)(&zgsz397);
      KILL(lbits)(&zgsz396);
    }
    if (!(zgsz325)) {

      goto case_36;
    }
    {
      lbits zgsz391;
      CREATE(lbits)(&zgsz391);
      CONVERT_OF(lbits, fbits)(&zgsz391, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz392;
      CREATE(sail_int)(&zgsz392);
      CONVERT_OF(sail_int, mach_int)(&zgsz392, INT64_C(15));
      sail_int zgsz393;
      CREATE(sail_int)(&zgsz393);
      CONVERT_OF(sail_int, mach_int)(&zgsz393, INT64_C(8));
      lbits zgsz394;
      CREATE(lbits)(&zgsz394);
      CONVERT_OF(lbits, fbits)(&zgsz394, zword, UINT64_C(8) , true);
      lbits zgsz395;
      CREATE(lbits)(&zgsz395);
      vector_update_subrange_lbits(&zgsz395, zgsz391, zgsz392, zgsz393, zgsz394);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz395, true);
      KILL(lbits)(&zgsz395);
      KILL(lbits)(&zgsz394);
      KILL(sail_int)(&zgsz393);
      KILL(sail_int)(&zgsz392);
      KILL(lbits)(&zgsz391);
    }
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_36: ;
  {
    uint64_t zb__1;
    zb__1 = zr;
    bool zgsz326;
    {
      lbits zgsz3103;
      CREATE(lbits)(&zgsz3103);
      CONVERT_OF(lbits, fbits)(&zgsz3103, zb__1, UINT64_C(3) , true);
      lbits zgsz3104;
      CREATE(lbits)(&zgsz3104);
      CONVERT_OF(lbits, fbits)(&zgsz3104, UINT64_C(0b001), UINT64_C(3) , true);
      zgsz326 = eq_bits(zgsz3103, zgsz3104);
      KILL(lbits)(&zgsz3104);
      KILL(lbits)(&zgsz3103);
    }
    if (!(zgsz326)) {

      goto case_37;
    }
    {
      lbits zgsz398;
      CREATE(lbits)(&zgsz398);
      CONVERT_OF(lbits, fbits)(&zgsz398, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz399;
      CREATE(sail_int)(&zgsz399);
      CONVERT_OF(sail_int, mach_int)(&zgsz399, INT64_C(7));
      sail_int zgsz3100;
      CREATE(sail_int)(&zgsz3100);
      CONVERT_OF(sail_int, mach_int)(&zgsz3100, INT64_C(0));
      lbits zgsz3101;
      CREATE(lbits)(&zgsz3101);
      CONVERT_OF(lbits, fbits)(&zgsz3101, zword, UINT64_C(8) , true);
      lbits zgsz3102;
      CREATE(lbits)(&zgsz3102);
      vector_update_subrange_lbits(&zgsz3102, zgsz398, zgsz399, zgsz3100, zgsz3101);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz3102, true);
      KILL(lbits)(&zgsz3102);
      KILL(lbits)(&zgsz3101);
      KILL(sail_int)(&zgsz3100);
      KILL(sail_int)(&zgsz399);
      KILL(lbits)(&zgsz398);
    }
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_37: ;
  {
    uint64_t zb__2;
    zb__2 = zr;
    bool zgsz327;
    {
      lbits zgsz3105;
      CREATE(lbits)(&zgsz3105);
      CONVERT_OF(lbits, fbits)(&zgsz3105, zb__2, UINT64_C(3) , true);
      lbits zgsz3106;
      CREATE(lbits)(&zgsz3106);
      CONVERT_OF(lbits, fbits)(&zgsz3106, UINT64_C(0b010), UINT64_C(3) , true);
      zgsz327 = eq_bits(zgsz3105, zgsz3106);
      KILL(lbits)(&zgsz3106);
      KILL(lbits)(&zgsz3105);
    }
    if (!(zgsz327)) {

      goto case_38;
    }
    zreg_A = zword;
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_38: ;
  {
    uint64_t zb__3;
    zb__3 = zr;
    bool zgsz328;
    {
      lbits zgsz3107;
      CREATE(lbits)(&zgsz3107);
      CONVERT_OF(lbits, fbits)(&zgsz3107, zb__3, UINT64_C(3) , true);
      lbits zgsz3108;
      CREATE(lbits)(&zgsz3108);
      CONVERT_OF(lbits, fbits)(&zgsz3108, UINT64_C(0b011), UINT64_C(3) , true);
      zgsz328 = eq_bits(zgsz3107, zgsz3108);
      KILL(lbits)(&zgsz3108);
      KILL(lbits)(&zgsz3107);
    }
    if (!(zgsz328)) {

      goto case_39;
    }
    zreg_X = zword;
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_39: ;
  {
    uint64_t zb__4;
    zb__4 = zr;
    bool zgsz329;
    {
      lbits zgsz3109;
      CREATE(lbits)(&zgsz3109);
      CONVERT_OF(lbits, fbits)(&zgsz3109, zb__4, UINT64_C(3) , true);
      lbits zgsz3110;
      CREATE(lbits)(&zgsz3110);
      CONVERT_OF(lbits, fbits)(&zgsz3110, UINT64_C(0b100), UINT64_C(3) , true);
      zgsz329 = eq_bits(zgsz3109, zgsz3110);
      KILL(lbits)(&zgsz3110);
      KILL(lbits)(&zgsz3109);
    }
    if (!(zgsz329)) {

      goto case_40;
    }
    zreg_Y = zword;
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_40: ;
  {
    uint64_t zb__5;
    zb__5 = zr;
    bool zgsz331;
    {
      lbits zgsz3116;
      CREATE(lbits)(&zgsz3116);
      CONVERT_OF(lbits, fbits)(&zgsz3116, zb__5, UINT64_C(3) , true);
      lbits zgsz3117;
      CREATE(lbits)(&zgsz3117);
      CONVERT_OF(lbits, fbits)(&zgsz3117, UINT64_C(0b101), UINT64_C(3) , true);
      zgsz331 = eq_bits(zgsz3116, zgsz3117);
      KILL(lbits)(&zgsz3117);
      KILL(lbits)(&zgsz3116);
    }
    if (!(zgsz331)) {

      goto case_41;
    }
    uint64_t zgaz33;
    {
      uint64_t zgaz32;
      zgaz32 = zreg_SR.zbits;
      {
        lbits zgsz3111;
        CREATE(lbits)(&zgsz3111);
        CONVERT_OF(lbits, fbits)(&zgsz3111, zgaz32, UINT64_C(8) , true);
        sail_int zgsz3112;
        CREATE(sail_int)(&zgsz3112);
        CONVERT_OF(sail_int, mach_int)(&zgsz3112, INT64_C(7));
        sail_int zgsz3113;
        CREATE(sail_int)(&zgsz3113);
        CONVERT_OF(sail_int, mach_int)(&zgsz3113, INT64_C(0));
        lbits zgsz3114;
        CREATE(lbits)(&zgsz3114);
        CONVERT_OF(lbits, fbits)(&zgsz3114, zword, UINT64_C(8) , true);
        lbits zgsz3115;
        CREATE(lbits)(&zgsz3115);
        vector_update_subrange_lbits(&zgsz3115, zgsz3111, zgsz3112, zgsz3113, zgsz3114);
        zgaz33 = CONVERT_OF(fbits, lbits)(zgsz3115, true);
        KILL(lbits)(&zgsz3115);
        KILL(lbits)(&zgsz3114);
        KILL(sail_int)(&zgsz3113);
        KILL(sail_int)(&zgsz3112);
        KILL(lbits)(&zgsz3111);
      }
    }
    struct zflags zgsz330;
    zgsz330 = zreg_SR;
    zgsz330.zbits = zgaz33;
    zreg_SR = zgsz330;
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_41: ;
  {
    uint64_t zb__6;
    zb__6 = zr;
    bool zgsz332;
    {
      lbits zgsz3118;
      CREATE(lbits)(&zgsz3118);
      CONVERT_OF(lbits, fbits)(&zgsz3118, zb__6, UINT64_C(3) , true);
      lbits zgsz3119;
      CREATE(lbits)(&zgsz3119);
      CONVERT_OF(lbits, fbits)(&zgsz3119, UINT64_C(0b110), UINT64_C(3) , true);
      zgsz332 = eq_bits(zgsz3118, zgsz3119);
      KILL(lbits)(&zgsz3119);
      KILL(lbits)(&zgsz3118);
    }
    if (!(zgsz332)) {

      goto case_42;
    }
    zreg_SP = zword;
    zgsz324 = UNIT;
    goto finish_match_35;
  }
case_42: ;
  sail_match_failure("write_reg");
finish_match_35: ;
  zcbz34 = zgsz324;

end_function_43: ;
  return zcbz34;
end_block_exception_44: ;

  return UNIT;
}

void zdecode16(struct zast *rop, uint64_t);

void zdecode16(struct zast *zcbz35, uint64_t zmergez3var)
{
  __label__ case_47, case_48, case_49, case_50, case_51, case_52, case_53, case_54, case_55, case_56, case_57, case_58, case_59, case_60, case_61, case_62, case_63, case_64, finish_match_46, end_function_65, end_block_exception_66, end_function_77;

  /* Case with num_cases: 18 */
  struct zast zgsz333;
  CREATE(zast)(&zgsz333);
  {
    uint64_t zv__0;
    zv__0 = zmergez3var;
    uint64_t zgaz34;
    {
      lbits zgsz3126;
      CREATE(lbits)(&zgsz3126);
      CONVERT_OF(lbits, fbits)(&zgsz3126, zv__0, UINT64_C(16) , true);
      sail_int zgsz3127;
      CREATE(sail_int)(&zgsz3127);
      CONVERT_OF(sail_int, mach_int)(&zgsz3127, INT64_C(15));
      sail_int zgsz3128;
      CREATE(sail_int)(&zgsz3128);
      CONVERT_OF(sail_int, mach_int)(&zgsz3128, INT64_C(8));
      lbits zgsz3129;
      CREATE(lbits)(&zgsz3129);
      vector_subrange_lbits(&zgsz3129, zgsz3126, zgsz3127, zgsz3128);
      zgaz34 = CONVERT_OF(fbits, lbits)(zgsz3129, true);
      KILL(lbits)(&zgsz3129);
      KILL(sail_int)(&zgsz3128);
      KILL(sail_int)(&zgsz3127);
      KILL(lbits)(&zgsz3126);
    }
    bool zgsz334;
    {
      lbits zgsz3124;
      CREATE(lbits)(&zgsz3124);
      CONVERT_OF(lbits, fbits)(&zgsz3124, zgaz34, UINT64_C(8) , true);
      lbits zgsz3125;
      CREATE(lbits)(&zgsz3125);
      CONVERT_OF(lbits, fbits)(&zgsz3125, UINT64_C(0x69), UINT64_C(8) , true);
      zgsz334 = eq_bits(zgsz3124, zgsz3125);
      KILL(lbits)(&zgsz3125);
      KILL(lbits)(&zgsz3124);
    }
    if (!(zgsz334)) {

      goto case_47;
    }
    uint64_t zop;
    {
      lbits zgsz3120;
      CREATE(lbits)(&zgsz3120);
      CONVERT_OF(lbits, fbits)(&zgsz3120, zv__0, UINT64_C(16) , true);
      sail_int zgsz3121;
      CREATE(sail_int)(&zgsz3121);
      CONVERT_OF(sail_int, mach_int)(&zgsz3121, INT64_C(7));
      sail_int zgsz3122;
      CREATE(sail_int)(&zgsz3122);
      CONVERT_OF(sail_int, mach_int)(&zgsz3122, INT64_C(0));
      lbits zgsz3123;
      CREATE(lbits)(&zgsz3123);
      vector_subrange_lbits(&zgsz3123, zgsz3120, zgsz3121, zgsz3122);
      zop = CONVERT_OF(fbits, lbits)(zgsz3123, true);
      KILL(lbits)(&zgsz3123);
      KILL(sail_int)(&zgsz3122);
      KILL(sail_int)(&zgsz3121);
      KILL(lbits)(&zgsz3120);
    }
    zADC_IMM(&zgsz333, zop);
    goto finish_match_46;
  }
case_47: ;
  {
    uint64_t zv__2;
    zv__2 = zmergez3var;
    uint64_t zgaz35;
    {
      lbits zgsz3136;
      CREATE(lbits)(&zgsz3136);
      CONVERT_OF(lbits, fbits)(&zgsz3136, zv__2, UINT64_C(16) , true);
      sail_int zgsz3137;
      CREATE(sail_int)(&zgsz3137);
      CONVERT_OF(sail_int, mach_int)(&zgsz3137, INT64_C(15));
      sail_int zgsz3138;
      CREATE(sail_int)(&zgsz3138);
      CONVERT_OF(sail_int, mach_int)(&zgsz3138, INT64_C(8));
      lbits zgsz3139;
      CREATE(lbits)(&zgsz3139);
      vector_subrange_lbits(&zgsz3139, zgsz3136, zgsz3137, zgsz3138);
      zgaz35 = CONVERT_OF(fbits, lbits)(zgsz3139, true);
      KILL(lbits)(&zgsz3139);
      KILL(sail_int)(&zgsz3138);
      KILL(sail_int)(&zgsz3137);
      KILL(lbits)(&zgsz3136);
    }
    bool zgsz335;
    {
      lbits zgsz3134;
      CREATE(lbits)(&zgsz3134);
      CONVERT_OF(lbits, fbits)(&zgsz3134, zgaz35, UINT64_C(8) , true);
      lbits zgsz3135;
      CREATE(lbits)(&zgsz3135);
      CONVERT_OF(lbits, fbits)(&zgsz3135, UINT64_C(0x65), UINT64_C(8) , true);
      zgsz335 = eq_bits(zgsz3134, zgsz3135);
      KILL(lbits)(&zgsz3135);
      KILL(lbits)(&zgsz3134);
    }
    if (!(zgsz335)) {

      goto case_48;
    }
    uint64_t zuz30;
    {
      lbits zgsz3130;
      CREATE(lbits)(&zgsz3130);
      CONVERT_OF(lbits, fbits)(&zgsz3130, zv__2, UINT64_C(16) , true);
      sail_int zgsz3131;
      CREATE(sail_int)(&zgsz3131);
      CONVERT_OF(sail_int, mach_int)(&zgsz3131, INT64_C(7));
      sail_int zgsz3132;
      CREATE(sail_int)(&zgsz3132);
      CONVERT_OF(sail_int, mach_int)(&zgsz3132, INT64_C(0));
      lbits zgsz3133;
      CREATE(lbits)(&zgsz3133);
      vector_subrange_lbits(&zgsz3133, zgsz3130, zgsz3131, zgsz3132);
      zuz30 = CONVERT_OF(fbits, lbits)(zgsz3133, true);
      KILL(lbits)(&zgsz3133);
      KILL(sail_int)(&zgsz3132);
      KILL(sail_int)(&zgsz3131);
      KILL(lbits)(&zgsz3130);
    }
    zADC_ZP(&zgsz333, zuz30);
    goto finish_match_46;
  }
case_48: ;
  {
    uint64_t zv__4;
    zv__4 = zmergez3var;
    uint64_t zgaz36;
    {
      lbits zgsz3146;
      CREATE(lbits)(&zgsz3146);
      CONVERT_OF(lbits, fbits)(&zgsz3146, zv__4, UINT64_C(16) , true);
      sail_int zgsz3147;
      CREATE(sail_int)(&zgsz3147);
      CONVERT_OF(sail_int, mach_int)(&zgsz3147, INT64_C(15));
      sail_int zgsz3148;
      CREATE(sail_int)(&zgsz3148);
      CONVERT_OF(sail_int, mach_int)(&zgsz3148, INT64_C(8));
      lbits zgsz3149;
      CREATE(lbits)(&zgsz3149);
      vector_subrange_lbits(&zgsz3149, zgsz3146, zgsz3147, zgsz3148);
      zgaz36 = CONVERT_OF(fbits, lbits)(zgsz3149, true);
      KILL(lbits)(&zgsz3149);
      KILL(sail_int)(&zgsz3148);
      KILL(sail_int)(&zgsz3147);
      KILL(lbits)(&zgsz3146);
    }
    bool zgsz336;
    {
      lbits zgsz3144;
      CREATE(lbits)(&zgsz3144);
      CONVERT_OF(lbits, fbits)(&zgsz3144, zgaz36, UINT64_C(8) , true);
      lbits zgsz3145;
      CREATE(lbits)(&zgsz3145);
      CONVERT_OF(lbits, fbits)(&zgsz3145, UINT64_C(0x75), UINT64_C(8) , true);
      zgsz336 = eq_bits(zgsz3144, zgsz3145);
      KILL(lbits)(&zgsz3145);
      KILL(lbits)(&zgsz3144);
    }
    if (!(zgsz336)) {

      goto case_49;
    }
    uint64_t zuz31;
    {
      lbits zgsz3140;
      CREATE(lbits)(&zgsz3140);
      CONVERT_OF(lbits, fbits)(&zgsz3140, zv__4, UINT64_C(16) , true);
      sail_int zgsz3141;
      CREATE(sail_int)(&zgsz3141);
      CONVERT_OF(sail_int, mach_int)(&zgsz3141, INT64_C(7));
      sail_int zgsz3142;
      CREATE(sail_int)(&zgsz3142);
      CONVERT_OF(sail_int, mach_int)(&zgsz3142, INT64_C(0));
      lbits zgsz3143;
      CREATE(lbits)(&zgsz3143);
      vector_subrange_lbits(&zgsz3143, zgsz3140, zgsz3141, zgsz3142);
      zuz31 = CONVERT_OF(fbits, lbits)(zgsz3143, true);
      KILL(lbits)(&zgsz3143);
      KILL(sail_int)(&zgsz3142);
      KILL(sail_int)(&zgsz3141);
      KILL(lbits)(&zgsz3140);
    }
    zADC_ZP_X(&zgsz333, zuz31);
    goto finish_match_46;
  }
case_49: ;
  {
    uint64_t zv__6;
    zv__6 = zmergez3var;
    uint64_t zgaz37;
    {
      lbits zgsz3156;
      CREATE(lbits)(&zgsz3156);
      CONVERT_OF(lbits, fbits)(&zgsz3156, zv__6, UINT64_C(16) , true);
      sail_int zgsz3157;
      CREATE(sail_int)(&zgsz3157);
      CONVERT_OF(sail_int, mach_int)(&zgsz3157, INT64_C(15));
      sail_int zgsz3158;
      CREATE(sail_int)(&zgsz3158);
      CONVERT_OF(sail_int, mach_int)(&zgsz3158, INT64_C(8));
      lbits zgsz3159;
      CREATE(lbits)(&zgsz3159);
      vector_subrange_lbits(&zgsz3159, zgsz3156, zgsz3157, zgsz3158);
      zgaz37 = CONVERT_OF(fbits, lbits)(zgsz3159, true);
      KILL(lbits)(&zgsz3159);
      KILL(sail_int)(&zgsz3158);
      KILL(sail_int)(&zgsz3157);
      KILL(lbits)(&zgsz3156);
    }
    bool zgsz337;
    {
      lbits zgsz3154;
      CREATE(lbits)(&zgsz3154);
      CONVERT_OF(lbits, fbits)(&zgsz3154, zgaz37, UINT64_C(8) , true);
      lbits zgsz3155;
      CREATE(lbits)(&zgsz3155);
      CONVERT_OF(lbits, fbits)(&zgsz3155, UINT64_C(0x61), UINT64_C(8) , true);
      zgsz337 = eq_bits(zgsz3154, zgsz3155);
      KILL(lbits)(&zgsz3155);
      KILL(lbits)(&zgsz3154);
    }
    if (!(zgsz337)) {

      goto case_50;
    }
    uint64_t zuz32;
    {
      lbits zgsz3150;
      CREATE(lbits)(&zgsz3150);
      CONVERT_OF(lbits, fbits)(&zgsz3150, zv__6, UINT64_C(16) , true);
      sail_int zgsz3151;
      CREATE(sail_int)(&zgsz3151);
      CONVERT_OF(sail_int, mach_int)(&zgsz3151, INT64_C(7));
      sail_int zgsz3152;
      CREATE(sail_int)(&zgsz3152);
      CONVERT_OF(sail_int, mach_int)(&zgsz3152, INT64_C(0));
      lbits zgsz3153;
      CREATE(lbits)(&zgsz3153);
      vector_subrange_lbits(&zgsz3153, zgsz3150, zgsz3151, zgsz3152);
      zuz32 = CONVERT_OF(fbits, lbits)(zgsz3153, true);
      KILL(lbits)(&zgsz3153);
      KILL(sail_int)(&zgsz3152);
      KILL(sail_int)(&zgsz3151);
      KILL(lbits)(&zgsz3150);
    }
    zADC_IND_X(&zgsz333, zuz32);
    goto finish_match_46;
  }
case_50: ;
  {
    uint64_t zv__8;
    zv__8 = zmergez3var;
    uint64_t zgaz38;
    {
      lbits zgsz3166;
      CREATE(lbits)(&zgsz3166);
      CONVERT_OF(lbits, fbits)(&zgsz3166, zv__8, UINT64_C(16) , true);
      sail_int zgsz3167;
      CREATE(sail_int)(&zgsz3167);
      CONVERT_OF(sail_int, mach_int)(&zgsz3167, INT64_C(15));
      sail_int zgsz3168;
      CREATE(sail_int)(&zgsz3168);
      CONVERT_OF(sail_int, mach_int)(&zgsz3168, INT64_C(8));
      lbits zgsz3169;
      CREATE(lbits)(&zgsz3169);
      vector_subrange_lbits(&zgsz3169, zgsz3166, zgsz3167, zgsz3168);
      zgaz38 = CONVERT_OF(fbits, lbits)(zgsz3169, true);
      KILL(lbits)(&zgsz3169);
      KILL(sail_int)(&zgsz3168);
      KILL(sail_int)(&zgsz3167);
      KILL(lbits)(&zgsz3166);
    }
    bool zgsz338;
    {
      lbits zgsz3164;
      CREATE(lbits)(&zgsz3164);
      CONVERT_OF(lbits, fbits)(&zgsz3164, zgaz38, UINT64_C(8) , true);
      lbits zgsz3165;
      CREATE(lbits)(&zgsz3165);
      CONVERT_OF(lbits, fbits)(&zgsz3165, UINT64_C(0x71), UINT64_C(8) , true);
      zgsz338 = eq_bits(zgsz3164, zgsz3165);
      KILL(lbits)(&zgsz3165);
      KILL(lbits)(&zgsz3164);
    }
    if (!(zgsz338)) {

      goto case_51;
    }
    uint64_t zuz33;
    {
      lbits zgsz3160;
      CREATE(lbits)(&zgsz3160);
      CONVERT_OF(lbits, fbits)(&zgsz3160, zv__8, UINT64_C(16) , true);
      sail_int zgsz3161;
      CREATE(sail_int)(&zgsz3161);
      CONVERT_OF(sail_int, mach_int)(&zgsz3161, INT64_C(7));
      sail_int zgsz3162;
      CREATE(sail_int)(&zgsz3162);
      CONVERT_OF(sail_int, mach_int)(&zgsz3162, INT64_C(0));
      lbits zgsz3163;
      CREATE(lbits)(&zgsz3163);
      vector_subrange_lbits(&zgsz3163, zgsz3160, zgsz3161, zgsz3162);
      zuz33 = CONVERT_OF(fbits, lbits)(zgsz3163, true);
      KILL(lbits)(&zgsz3163);
      KILL(sail_int)(&zgsz3162);
      KILL(sail_int)(&zgsz3161);
      KILL(lbits)(&zgsz3160);
    }
    zADC_IND_Y(&zgsz333, zuz33);
    goto finish_match_46;
  }
case_51: ;
  {
    uint64_t zv__10;
    zv__10 = zmergez3var;
    uint64_t zgaz39;
    {
      lbits zgsz3176;
      CREATE(lbits)(&zgsz3176);
      CONVERT_OF(lbits, fbits)(&zgsz3176, zv__10, UINT64_C(16) , true);
      sail_int zgsz3177;
      CREATE(sail_int)(&zgsz3177);
      CONVERT_OF(sail_int, mach_int)(&zgsz3177, INT64_C(15));
      sail_int zgsz3178;
      CREATE(sail_int)(&zgsz3178);
      CONVERT_OF(sail_int, mach_int)(&zgsz3178, INT64_C(8));
      lbits zgsz3179;
      CREATE(lbits)(&zgsz3179);
      vector_subrange_lbits(&zgsz3179, zgsz3176, zgsz3177, zgsz3178);
      zgaz39 = CONVERT_OF(fbits, lbits)(zgsz3179, true);
      KILL(lbits)(&zgsz3179);
      KILL(sail_int)(&zgsz3178);
      KILL(sail_int)(&zgsz3177);
      KILL(lbits)(&zgsz3176);
    }
    bool zgsz339;
    {
      lbits zgsz3174;
      CREATE(lbits)(&zgsz3174);
      CONVERT_OF(lbits, fbits)(&zgsz3174, zgaz39, UINT64_C(8) , true);
      lbits zgsz3175;
      CREATE(lbits)(&zgsz3175);
      CONVERT_OF(lbits, fbits)(&zgsz3175, UINT64_C(0x29), UINT64_C(8) , true);
      zgsz339 = eq_bits(zgsz3174, zgsz3175);
      KILL(lbits)(&zgsz3175);
      KILL(lbits)(&zgsz3174);
    }
    if (!(zgsz339)) {

      goto case_52;
    }
    uint64_t zuz34;
    {
      lbits zgsz3170;
      CREATE(lbits)(&zgsz3170);
      CONVERT_OF(lbits, fbits)(&zgsz3170, zv__10, UINT64_C(16) , true);
      sail_int zgsz3171;
      CREATE(sail_int)(&zgsz3171);
      CONVERT_OF(sail_int, mach_int)(&zgsz3171, INT64_C(7));
      sail_int zgsz3172;
      CREATE(sail_int)(&zgsz3172);
      CONVERT_OF(sail_int, mach_int)(&zgsz3172, INT64_C(0));
      lbits zgsz3173;
      CREATE(lbits)(&zgsz3173);
      vector_subrange_lbits(&zgsz3173, zgsz3170, zgsz3171, zgsz3172);
      zuz34 = CONVERT_OF(fbits, lbits)(zgsz3173, true);
      KILL(lbits)(&zgsz3173);
      KILL(sail_int)(&zgsz3172);
      KILL(sail_int)(&zgsz3171);
      KILL(lbits)(&zgsz3170);
    }
    zAND_IMM(&zgsz333, zuz34);
    goto finish_match_46;
  }
case_52: ;
  {
    uint64_t zv__12;
    zv__12 = zmergez3var;
    uint64_t zgaz310;
    {
      lbits zgsz3186;
      CREATE(lbits)(&zgsz3186);
      CONVERT_OF(lbits, fbits)(&zgsz3186, zv__12, UINT64_C(16) , true);
      sail_int zgsz3187;
      CREATE(sail_int)(&zgsz3187);
      CONVERT_OF(sail_int, mach_int)(&zgsz3187, INT64_C(15));
      sail_int zgsz3188;
      CREATE(sail_int)(&zgsz3188);
      CONVERT_OF(sail_int, mach_int)(&zgsz3188, INT64_C(8));
      lbits zgsz3189;
      CREATE(lbits)(&zgsz3189);
      vector_subrange_lbits(&zgsz3189, zgsz3186, zgsz3187, zgsz3188);
      zgaz310 = CONVERT_OF(fbits, lbits)(zgsz3189, true);
      KILL(lbits)(&zgsz3189);
      KILL(sail_int)(&zgsz3188);
      KILL(sail_int)(&zgsz3187);
      KILL(lbits)(&zgsz3186);
    }
    bool zgsz340;
    {
      lbits zgsz3184;
      CREATE(lbits)(&zgsz3184);
      CONVERT_OF(lbits, fbits)(&zgsz3184, zgaz310, UINT64_C(8) , true);
      lbits zgsz3185;
      CREATE(lbits)(&zgsz3185);
      CONVERT_OF(lbits, fbits)(&zgsz3185, UINT64_C(0x25), UINT64_C(8) , true);
      zgsz340 = eq_bits(zgsz3184, zgsz3185);
      KILL(lbits)(&zgsz3185);
      KILL(lbits)(&zgsz3184);
    }
    if (!(zgsz340)) {

      goto case_53;
    }
    uint64_t zuz35;
    {
      lbits zgsz3180;
      CREATE(lbits)(&zgsz3180);
      CONVERT_OF(lbits, fbits)(&zgsz3180, zv__12, UINT64_C(16) , true);
      sail_int zgsz3181;
      CREATE(sail_int)(&zgsz3181);
      CONVERT_OF(sail_int, mach_int)(&zgsz3181, INT64_C(7));
      sail_int zgsz3182;
      CREATE(sail_int)(&zgsz3182);
      CONVERT_OF(sail_int, mach_int)(&zgsz3182, INT64_C(0));
      lbits zgsz3183;
      CREATE(lbits)(&zgsz3183);
      vector_subrange_lbits(&zgsz3183, zgsz3180, zgsz3181, zgsz3182);
      zuz35 = CONVERT_OF(fbits, lbits)(zgsz3183, true);
      KILL(lbits)(&zgsz3183);
      KILL(sail_int)(&zgsz3182);
      KILL(sail_int)(&zgsz3181);
      KILL(lbits)(&zgsz3180);
    }
    zAND_ZP(&zgsz333, zuz35);
    goto finish_match_46;
  }
case_53: ;
  {
    uint64_t zv__14;
    zv__14 = zmergez3var;
    uint64_t zgaz311;
    {
      lbits zgsz3196;
      CREATE(lbits)(&zgsz3196);
      CONVERT_OF(lbits, fbits)(&zgsz3196, zv__14, UINT64_C(16) , true);
      sail_int zgsz3197;
      CREATE(sail_int)(&zgsz3197);
      CONVERT_OF(sail_int, mach_int)(&zgsz3197, INT64_C(15));
      sail_int zgsz3198;
      CREATE(sail_int)(&zgsz3198);
      CONVERT_OF(sail_int, mach_int)(&zgsz3198, INT64_C(8));
      lbits zgsz3199;
      CREATE(lbits)(&zgsz3199);
      vector_subrange_lbits(&zgsz3199, zgsz3196, zgsz3197, zgsz3198);
      zgaz311 = CONVERT_OF(fbits, lbits)(zgsz3199, true);
      KILL(lbits)(&zgsz3199);
      KILL(sail_int)(&zgsz3198);
      KILL(sail_int)(&zgsz3197);
      KILL(lbits)(&zgsz3196);
    }
    bool zgsz341;
    {
      lbits zgsz3194;
      CREATE(lbits)(&zgsz3194);
      CONVERT_OF(lbits, fbits)(&zgsz3194, zgaz311, UINT64_C(8) , true);
      lbits zgsz3195;
      CREATE(lbits)(&zgsz3195);
      CONVERT_OF(lbits, fbits)(&zgsz3195, UINT64_C(0x35), UINT64_C(8) , true);
      zgsz341 = eq_bits(zgsz3194, zgsz3195);
      KILL(lbits)(&zgsz3195);
      KILL(lbits)(&zgsz3194);
    }
    if (!(zgsz341)) {

      goto case_54;
    }
    uint64_t zuz36;
    {
      lbits zgsz3190;
      CREATE(lbits)(&zgsz3190);
      CONVERT_OF(lbits, fbits)(&zgsz3190, zv__14, UINT64_C(16) , true);
      sail_int zgsz3191;
      CREATE(sail_int)(&zgsz3191);
      CONVERT_OF(sail_int, mach_int)(&zgsz3191, INT64_C(7));
      sail_int zgsz3192;
      CREATE(sail_int)(&zgsz3192);
      CONVERT_OF(sail_int, mach_int)(&zgsz3192, INT64_C(0));
      lbits zgsz3193;
      CREATE(lbits)(&zgsz3193);
      vector_subrange_lbits(&zgsz3193, zgsz3190, zgsz3191, zgsz3192);
      zuz36 = CONVERT_OF(fbits, lbits)(zgsz3193, true);
      KILL(lbits)(&zgsz3193);
      KILL(sail_int)(&zgsz3192);
      KILL(sail_int)(&zgsz3191);
      KILL(lbits)(&zgsz3190);
    }
    zAND_ZP_X(&zgsz333, zuz36);
    goto finish_match_46;
  }
case_54: ;
  {
    uint64_t zv__16;
    zv__16 = zmergez3var;
    uint64_t zgaz312;
    {
      lbits zgsz3206;
      CREATE(lbits)(&zgsz3206);
      CONVERT_OF(lbits, fbits)(&zgsz3206, zv__16, UINT64_C(16) , true);
      sail_int zgsz3207;
      CREATE(sail_int)(&zgsz3207);
      CONVERT_OF(sail_int, mach_int)(&zgsz3207, INT64_C(15));
      sail_int zgsz3208;
      CREATE(sail_int)(&zgsz3208);
      CONVERT_OF(sail_int, mach_int)(&zgsz3208, INT64_C(8));
      lbits zgsz3209;
      CREATE(lbits)(&zgsz3209);
      vector_subrange_lbits(&zgsz3209, zgsz3206, zgsz3207, zgsz3208);
      zgaz312 = CONVERT_OF(fbits, lbits)(zgsz3209, true);
      KILL(lbits)(&zgsz3209);
      KILL(sail_int)(&zgsz3208);
      KILL(sail_int)(&zgsz3207);
      KILL(lbits)(&zgsz3206);
    }
    bool zgsz342;
    {
      lbits zgsz3204;
      CREATE(lbits)(&zgsz3204);
      CONVERT_OF(lbits, fbits)(&zgsz3204, zgaz312, UINT64_C(8) , true);
      lbits zgsz3205;
      CREATE(lbits)(&zgsz3205);
      CONVERT_OF(lbits, fbits)(&zgsz3205, UINT64_C(0x21), UINT64_C(8) , true);
      zgsz342 = eq_bits(zgsz3204, zgsz3205);
      KILL(lbits)(&zgsz3205);
      KILL(lbits)(&zgsz3204);
    }
    if (!(zgsz342)) {

      goto case_55;
    }
    uint64_t zuz37;
    {
      lbits zgsz3200;
      CREATE(lbits)(&zgsz3200);
      CONVERT_OF(lbits, fbits)(&zgsz3200, zv__16, UINT64_C(16) , true);
      sail_int zgsz3201;
      CREATE(sail_int)(&zgsz3201);
      CONVERT_OF(sail_int, mach_int)(&zgsz3201, INT64_C(7));
      sail_int zgsz3202;
      CREATE(sail_int)(&zgsz3202);
      CONVERT_OF(sail_int, mach_int)(&zgsz3202, INT64_C(0));
      lbits zgsz3203;
      CREATE(lbits)(&zgsz3203);
      vector_subrange_lbits(&zgsz3203, zgsz3200, zgsz3201, zgsz3202);
      zuz37 = CONVERT_OF(fbits, lbits)(zgsz3203, true);
      KILL(lbits)(&zgsz3203);
      KILL(sail_int)(&zgsz3202);
      KILL(sail_int)(&zgsz3201);
      KILL(lbits)(&zgsz3200);
    }
    zAND_IND_X(&zgsz333, zuz37);
    goto finish_match_46;
  }
case_55: ;
  {
    uint64_t zv__18;
    zv__18 = zmergez3var;
    uint64_t zgaz313;
    {
      lbits zgsz3216;
      CREATE(lbits)(&zgsz3216);
      CONVERT_OF(lbits, fbits)(&zgsz3216, zv__18, UINT64_C(16) , true);
      sail_int zgsz3217;
      CREATE(sail_int)(&zgsz3217);
      CONVERT_OF(sail_int, mach_int)(&zgsz3217, INT64_C(15));
      sail_int zgsz3218;
      CREATE(sail_int)(&zgsz3218);
      CONVERT_OF(sail_int, mach_int)(&zgsz3218, INT64_C(8));
      lbits zgsz3219;
      CREATE(lbits)(&zgsz3219);
      vector_subrange_lbits(&zgsz3219, zgsz3216, zgsz3217, zgsz3218);
      zgaz313 = CONVERT_OF(fbits, lbits)(zgsz3219, true);
      KILL(lbits)(&zgsz3219);
      KILL(sail_int)(&zgsz3218);
      KILL(sail_int)(&zgsz3217);
      KILL(lbits)(&zgsz3216);
    }
    bool zgsz343;
    {
      lbits zgsz3214;
      CREATE(lbits)(&zgsz3214);
      CONVERT_OF(lbits, fbits)(&zgsz3214, zgaz313, UINT64_C(8) , true);
      lbits zgsz3215;
      CREATE(lbits)(&zgsz3215);
      CONVERT_OF(lbits, fbits)(&zgsz3215, UINT64_C(0x31), UINT64_C(8) , true);
      zgsz343 = eq_bits(zgsz3214, zgsz3215);
      KILL(lbits)(&zgsz3215);
      KILL(lbits)(&zgsz3214);
    }
    if (!(zgsz343)) {

      goto case_56;
    }
    uint64_t zuz38;
    {
      lbits zgsz3210;
      CREATE(lbits)(&zgsz3210);
      CONVERT_OF(lbits, fbits)(&zgsz3210, zv__18, UINT64_C(16) , true);
      sail_int zgsz3211;
      CREATE(sail_int)(&zgsz3211);
      CONVERT_OF(sail_int, mach_int)(&zgsz3211, INT64_C(7));
      sail_int zgsz3212;
      CREATE(sail_int)(&zgsz3212);
      CONVERT_OF(sail_int, mach_int)(&zgsz3212, INT64_C(0));
      lbits zgsz3213;
      CREATE(lbits)(&zgsz3213);
      vector_subrange_lbits(&zgsz3213, zgsz3210, zgsz3211, zgsz3212);
      zuz38 = CONVERT_OF(fbits, lbits)(zgsz3213, true);
      KILL(lbits)(&zgsz3213);
      KILL(sail_int)(&zgsz3212);
      KILL(sail_int)(&zgsz3211);
      KILL(lbits)(&zgsz3210);
    }
    zAND_IND_Y(&zgsz333, zuz38);
    goto finish_match_46;
  }
case_56: ;
  {
    uint64_t zv__20;
    zv__20 = zmergez3var;
    uint64_t zgaz314;
    {
      lbits zgsz3226;
      CREATE(lbits)(&zgsz3226);
      CONVERT_OF(lbits, fbits)(&zgsz3226, zv__20, UINT64_C(16) , true);
      sail_int zgsz3227;
      CREATE(sail_int)(&zgsz3227);
      CONVERT_OF(sail_int, mach_int)(&zgsz3227, INT64_C(15));
      sail_int zgsz3228;
      CREATE(sail_int)(&zgsz3228);
      CONVERT_OF(sail_int, mach_int)(&zgsz3228, INT64_C(8));
      lbits zgsz3229;
      CREATE(lbits)(&zgsz3229);
      vector_subrange_lbits(&zgsz3229, zgsz3226, zgsz3227, zgsz3228);
      zgaz314 = CONVERT_OF(fbits, lbits)(zgsz3229, true);
      KILL(lbits)(&zgsz3229);
      KILL(sail_int)(&zgsz3228);
      KILL(sail_int)(&zgsz3227);
      KILL(lbits)(&zgsz3226);
    }
    bool zgsz344;
    {
      lbits zgsz3224;
      CREATE(lbits)(&zgsz3224);
      CONVERT_OF(lbits, fbits)(&zgsz3224, zgaz314, UINT64_C(8) , true);
      lbits zgsz3225;
      CREATE(lbits)(&zgsz3225);
      CONVERT_OF(lbits, fbits)(&zgsz3225, UINT64_C(0x06), UINT64_C(8) , true);
      zgsz344 = eq_bits(zgsz3224, zgsz3225);
      KILL(lbits)(&zgsz3225);
      KILL(lbits)(&zgsz3224);
    }
    if (!(zgsz344)) {

      goto case_57;
    }
    uint64_t zuz39;
    {
      lbits zgsz3220;
      CREATE(lbits)(&zgsz3220);
      CONVERT_OF(lbits, fbits)(&zgsz3220, zv__20, UINT64_C(16) , true);
      sail_int zgsz3221;
      CREATE(sail_int)(&zgsz3221);
      CONVERT_OF(sail_int, mach_int)(&zgsz3221, INT64_C(7));
      sail_int zgsz3222;
      CREATE(sail_int)(&zgsz3222);
      CONVERT_OF(sail_int, mach_int)(&zgsz3222, INT64_C(0));
      lbits zgsz3223;
      CREATE(lbits)(&zgsz3223);
      vector_subrange_lbits(&zgsz3223, zgsz3220, zgsz3221, zgsz3222);
      zuz39 = CONVERT_OF(fbits, lbits)(zgsz3223, true);
      KILL(lbits)(&zgsz3223);
      KILL(sail_int)(&zgsz3222);
      KILL(sail_int)(&zgsz3221);
      KILL(lbits)(&zgsz3220);
    }
    zASL_ZP(&zgsz333, zuz39);
    goto finish_match_46;
  }
case_57: ;
  {
    uint64_t zv__22;
    zv__22 = zmergez3var;
    uint64_t zgaz315;
    {
      lbits zgsz3236;
      CREATE(lbits)(&zgsz3236);
      CONVERT_OF(lbits, fbits)(&zgsz3236, zv__22, UINT64_C(16) , true);
      sail_int zgsz3237;
      CREATE(sail_int)(&zgsz3237);
      CONVERT_OF(sail_int, mach_int)(&zgsz3237, INT64_C(15));
      sail_int zgsz3238;
      CREATE(sail_int)(&zgsz3238);
      CONVERT_OF(sail_int, mach_int)(&zgsz3238, INT64_C(8));
      lbits zgsz3239;
      CREATE(lbits)(&zgsz3239);
      vector_subrange_lbits(&zgsz3239, zgsz3236, zgsz3237, zgsz3238);
      zgaz315 = CONVERT_OF(fbits, lbits)(zgsz3239, true);
      KILL(lbits)(&zgsz3239);
      KILL(sail_int)(&zgsz3238);
      KILL(sail_int)(&zgsz3237);
      KILL(lbits)(&zgsz3236);
    }
    bool zgsz345;
    {
      lbits zgsz3234;
      CREATE(lbits)(&zgsz3234);
      CONVERT_OF(lbits, fbits)(&zgsz3234, zgaz315, UINT64_C(8) , true);
      lbits zgsz3235;
      CREATE(lbits)(&zgsz3235);
      CONVERT_OF(lbits, fbits)(&zgsz3235, UINT64_C(0x16), UINT64_C(8) , true);
      zgsz345 = eq_bits(zgsz3234, zgsz3235);
      KILL(lbits)(&zgsz3235);
      KILL(lbits)(&zgsz3234);
    }
    if (!(zgsz345)) {

      goto case_58;
    }
    uint64_t zuz310;
    {
      lbits zgsz3230;
      CREATE(lbits)(&zgsz3230);
      CONVERT_OF(lbits, fbits)(&zgsz3230, zv__22, UINT64_C(16) , true);
      sail_int zgsz3231;
      CREATE(sail_int)(&zgsz3231);
      CONVERT_OF(sail_int, mach_int)(&zgsz3231, INT64_C(7));
      sail_int zgsz3232;
      CREATE(sail_int)(&zgsz3232);
      CONVERT_OF(sail_int, mach_int)(&zgsz3232, INT64_C(0));
      lbits zgsz3233;
      CREATE(lbits)(&zgsz3233);
      vector_subrange_lbits(&zgsz3233, zgsz3230, zgsz3231, zgsz3232);
      zuz310 = CONVERT_OF(fbits, lbits)(zgsz3233, true);
      KILL(lbits)(&zgsz3233);
      KILL(sail_int)(&zgsz3232);
      KILL(sail_int)(&zgsz3231);
      KILL(lbits)(&zgsz3230);
    }
    zASL_ZP_X(&zgsz333, zuz310);
    goto finish_match_46;
  }
case_58: ;
  {
    uint64_t zv__24;
    zv__24 = zmergez3var;
    uint64_t zgaz316;
    {
      lbits zgsz3246;
      CREATE(lbits)(&zgsz3246);
      CONVERT_OF(lbits, fbits)(&zgsz3246, zv__24, UINT64_C(16) , true);
      sail_int zgsz3247;
      CREATE(sail_int)(&zgsz3247);
      CONVERT_OF(sail_int, mach_int)(&zgsz3247, INT64_C(15));
      sail_int zgsz3248;
      CREATE(sail_int)(&zgsz3248);
      CONVERT_OF(sail_int, mach_int)(&zgsz3248, INT64_C(8));
      lbits zgsz3249;
      CREATE(lbits)(&zgsz3249);
      vector_subrange_lbits(&zgsz3249, zgsz3246, zgsz3247, zgsz3248);
      zgaz316 = CONVERT_OF(fbits, lbits)(zgsz3249, true);
      KILL(lbits)(&zgsz3249);
      KILL(sail_int)(&zgsz3248);
      KILL(sail_int)(&zgsz3247);
      KILL(lbits)(&zgsz3246);
    }
    bool zgsz346;
    {
      lbits zgsz3244;
      CREATE(lbits)(&zgsz3244);
      CONVERT_OF(lbits, fbits)(&zgsz3244, zgaz316, UINT64_C(8) , true);
      lbits zgsz3245;
      CREATE(lbits)(&zgsz3245);
      CONVERT_OF(lbits, fbits)(&zgsz3245, UINT64_C(0x46), UINT64_C(8) , true);
      zgsz346 = eq_bits(zgsz3244, zgsz3245);
      KILL(lbits)(&zgsz3245);
      KILL(lbits)(&zgsz3244);
    }
    if (!(zgsz346)) {

      goto case_59;
    }
    uint64_t zuz311;
    {
      lbits zgsz3240;
      CREATE(lbits)(&zgsz3240);
      CONVERT_OF(lbits, fbits)(&zgsz3240, zv__24, UINT64_C(16) , true);
      sail_int zgsz3241;
      CREATE(sail_int)(&zgsz3241);
      CONVERT_OF(sail_int, mach_int)(&zgsz3241, INT64_C(7));
      sail_int zgsz3242;
      CREATE(sail_int)(&zgsz3242);
      CONVERT_OF(sail_int, mach_int)(&zgsz3242, INT64_C(0));
      lbits zgsz3243;
      CREATE(lbits)(&zgsz3243);
      vector_subrange_lbits(&zgsz3243, zgsz3240, zgsz3241, zgsz3242);
      zuz311 = CONVERT_OF(fbits, lbits)(zgsz3243, true);
      KILL(lbits)(&zgsz3243);
      KILL(sail_int)(&zgsz3242);
      KILL(sail_int)(&zgsz3241);
      KILL(lbits)(&zgsz3240);
    }
    zLSR_ZP(&zgsz333, zuz311);
    goto finish_match_46;
  }
case_59: ;
  {
    uint64_t zv__26;
    zv__26 = zmergez3var;
    uint64_t zgaz317;
    {
      lbits zgsz3256;
      CREATE(lbits)(&zgsz3256);
      CONVERT_OF(lbits, fbits)(&zgsz3256, zv__26, UINT64_C(16) , true);
      sail_int zgsz3257;
      CREATE(sail_int)(&zgsz3257);
      CONVERT_OF(sail_int, mach_int)(&zgsz3257, INT64_C(15));
      sail_int zgsz3258;
      CREATE(sail_int)(&zgsz3258);
      CONVERT_OF(sail_int, mach_int)(&zgsz3258, INT64_C(8));
      lbits zgsz3259;
      CREATE(lbits)(&zgsz3259);
      vector_subrange_lbits(&zgsz3259, zgsz3256, zgsz3257, zgsz3258);
      zgaz317 = CONVERT_OF(fbits, lbits)(zgsz3259, true);
      KILL(lbits)(&zgsz3259);
      KILL(sail_int)(&zgsz3258);
      KILL(sail_int)(&zgsz3257);
      KILL(lbits)(&zgsz3256);
    }
    bool zgsz347;
    {
      lbits zgsz3254;
      CREATE(lbits)(&zgsz3254);
      CONVERT_OF(lbits, fbits)(&zgsz3254, zgaz317, UINT64_C(8) , true);
      lbits zgsz3255;
      CREATE(lbits)(&zgsz3255);
      CONVERT_OF(lbits, fbits)(&zgsz3255, UINT64_C(0x56), UINT64_C(8) , true);
      zgsz347 = eq_bits(zgsz3254, zgsz3255);
      KILL(lbits)(&zgsz3255);
      KILL(lbits)(&zgsz3254);
    }
    if (!(zgsz347)) {

      goto case_60;
    }
    uint64_t zuz312;
    {
      lbits zgsz3250;
      CREATE(lbits)(&zgsz3250);
      CONVERT_OF(lbits, fbits)(&zgsz3250, zv__26, UINT64_C(16) , true);
      sail_int zgsz3251;
      CREATE(sail_int)(&zgsz3251);
      CONVERT_OF(sail_int, mach_int)(&zgsz3251, INT64_C(7));
      sail_int zgsz3252;
      CREATE(sail_int)(&zgsz3252);
      CONVERT_OF(sail_int, mach_int)(&zgsz3252, INT64_C(0));
      lbits zgsz3253;
      CREATE(lbits)(&zgsz3253);
      vector_subrange_lbits(&zgsz3253, zgsz3250, zgsz3251, zgsz3252);
      zuz312 = CONVERT_OF(fbits, lbits)(zgsz3253, true);
      KILL(lbits)(&zgsz3253);
      KILL(sail_int)(&zgsz3252);
      KILL(sail_int)(&zgsz3251);
      KILL(lbits)(&zgsz3250);
    }
    zLSR_ZP_X(&zgsz333, zuz312);
    goto finish_match_46;
  }
case_60: ;
  {
    uint64_t zv__28;
    zv__28 = zmergez3var;
    uint64_t zgaz318;
    {
      lbits zgsz3266;
      CREATE(lbits)(&zgsz3266);
      CONVERT_OF(lbits, fbits)(&zgsz3266, zv__28, UINT64_C(16) , true);
      sail_int zgsz3267;
      CREATE(sail_int)(&zgsz3267);
      CONVERT_OF(sail_int, mach_int)(&zgsz3267, INT64_C(15));
      sail_int zgsz3268;
      CREATE(sail_int)(&zgsz3268);
      CONVERT_OF(sail_int, mach_int)(&zgsz3268, INT64_C(8));
      lbits zgsz3269;
      CREATE(lbits)(&zgsz3269);
      vector_subrange_lbits(&zgsz3269, zgsz3266, zgsz3267, zgsz3268);
      zgaz318 = CONVERT_OF(fbits, lbits)(zgsz3269, true);
      KILL(lbits)(&zgsz3269);
      KILL(sail_int)(&zgsz3268);
      KILL(sail_int)(&zgsz3267);
      KILL(lbits)(&zgsz3266);
    }
    bool zgsz348;
    {
      lbits zgsz3264;
      CREATE(lbits)(&zgsz3264);
      CONVERT_OF(lbits, fbits)(&zgsz3264, zgaz318, UINT64_C(8) , true);
      lbits zgsz3265;
      CREATE(lbits)(&zgsz3265);
      CONVERT_OF(lbits, fbits)(&zgsz3265, UINT64_C(0x26), UINT64_C(8) , true);
      zgsz348 = eq_bits(zgsz3264, zgsz3265);
      KILL(lbits)(&zgsz3265);
      KILL(lbits)(&zgsz3264);
    }
    if (!(zgsz348)) {

      goto case_61;
    }
    uint64_t zuz313;
    {
      lbits zgsz3260;
      CREATE(lbits)(&zgsz3260);
      CONVERT_OF(lbits, fbits)(&zgsz3260, zv__28, UINT64_C(16) , true);
      sail_int zgsz3261;
      CREATE(sail_int)(&zgsz3261);
      CONVERT_OF(sail_int, mach_int)(&zgsz3261, INT64_C(7));
      sail_int zgsz3262;
      CREATE(sail_int)(&zgsz3262);
      CONVERT_OF(sail_int, mach_int)(&zgsz3262, INT64_C(0));
      lbits zgsz3263;
      CREATE(lbits)(&zgsz3263);
      vector_subrange_lbits(&zgsz3263, zgsz3260, zgsz3261, zgsz3262);
      zuz313 = CONVERT_OF(fbits, lbits)(zgsz3263, true);
      KILL(lbits)(&zgsz3263);
      KILL(sail_int)(&zgsz3262);
      KILL(sail_int)(&zgsz3261);
      KILL(lbits)(&zgsz3260);
    }
    zROL_ZP(&zgsz333, zuz313);
    goto finish_match_46;
  }
case_61: ;
  {
    uint64_t zv__30;
    zv__30 = zmergez3var;
    uint64_t zgaz319;
    {
      lbits zgsz3276;
      CREATE(lbits)(&zgsz3276);
      CONVERT_OF(lbits, fbits)(&zgsz3276, zv__30, UINT64_C(16) , true);
      sail_int zgsz3277;
      CREATE(sail_int)(&zgsz3277);
      CONVERT_OF(sail_int, mach_int)(&zgsz3277, INT64_C(15));
      sail_int zgsz3278;
      CREATE(sail_int)(&zgsz3278);
      CONVERT_OF(sail_int, mach_int)(&zgsz3278, INT64_C(8));
      lbits zgsz3279;
      CREATE(lbits)(&zgsz3279);
      vector_subrange_lbits(&zgsz3279, zgsz3276, zgsz3277, zgsz3278);
      zgaz319 = CONVERT_OF(fbits, lbits)(zgsz3279, true);
      KILL(lbits)(&zgsz3279);
      KILL(sail_int)(&zgsz3278);
      KILL(sail_int)(&zgsz3277);
      KILL(lbits)(&zgsz3276);
    }
    bool zgsz349;
    {
      lbits zgsz3274;
      CREATE(lbits)(&zgsz3274);
      CONVERT_OF(lbits, fbits)(&zgsz3274, zgaz319, UINT64_C(8) , true);
      lbits zgsz3275;
      CREATE(lbits)(&zgsz3275);
      CONVERT_OF(lbits, fbits)(&zgsz3275, UINT64_C(0x36), UINT64_C(8) , true);
      zgsz349 = eq_bits(zgsz3274, zgsz3275);
      KILL(lbits)(&zgsz3275);
      KILL(lbits)(&zgsz3274);
    }
    if (!(zgsz349)) {

      goto case_62;
    }
    uint64_t zuz314;
    {
      lbits zgsz3270;
      CREATE(lbits)(&zgsz3270);
      CONVERT_OF(lbits, fbits)(&zgsz3270, zv__30, UINT64_C(16) , true);
      sail_int zgsz3271;
      CREATE(sail_int)(&zgsz3271);
      CONVERT_OF(sail_int, mach_int)(&zgsz3271, INT64_C(7));
      sail_int zgsz3272;
      CREATE(sail_int)(&zgsz3272);
      CONVERT_OF(sail_int, mach_int)(&zgsz3272, INT64_C(0));
      lbits zgsz3273;
      CREATE(lbits)(&zgsz3273);
      vector_subrange_lbits(&zgsz3273, zgsz3270, zgsz3271, zgsz3272);
      zuz314 = CONVERT_OF(fbits, lbits)(zgsz3273, true);
      KILL(lbits)(&zgsz3273);
      KILL(sail_int)(&zgsz3272);
      KILL(sail_int)(&zgsz3271);
      KILL(lbits)(&zgsz3270);
    }
    zROL_ZP_X(&zgsz333, zuz314);
    goto finish_match_46;
  }
case_62: ;
  {
    uint64_t zv__32;
    zv__32 = zmergez3var;
    uint64_t zgaz320;
    {
      lbits zgsz3286;
      CREATE(lbits)(&zgsz3286);
      CONVERT_OF(lbits, fbits)(&zgsz3286, zv__32, UINT64_C(16) , true);
      sail_int zgsz3287;
      CREATE(sail_int)(&zgsz3287);
      CONVERT_OF(sail_int, mach_int)(&zgsz3287, INT64_C(15));
      sail_int zgsz3288;
      CREATE(sail_int)(&zgsz3288);
      CONVERT_OF(sail_int, mach_int)(&zgsz3288, INT64_C(8));
      lbits zgsz3289;
      CREATE(lbits)(&zgsz3289);
      vector_subrange_lbits(&zgsz3289, zgsz3286, zgsz3287, zgsz3288);
      zgaz320 = CONVERT_OF(fbits, lbits)(zgsz3289, true);
      KILL(lbits)(&zgsz3289);
      KILL(sail_int)(&zgsz3288);
      KILL(sail_int)(&zgsz3287);
      KILL(lbits)(&zgsz3286);
    }
    bool zgsz350;
    {
      lbits zgsz3284;
      CREATE(lbits)(&zgsz3284);
      CONVERT_OF(lbits, fbits)(&zgsz3284, zgaz320, UINT64_C(8) , true);
      lbits zgsz3285;
      CREATE(lbits)(&zgsz3285);
      CONVERT_OF(lbits, fbits)(&zgsz3285, UINT64_C(0x66), UINT64_C(8) , true);
      zgsz350 = eq_bits(zgsz3284, zgsz3285);
      KILL(lbits)(&zgsz3285);
      KILL(lbits)(&zgsz3284);
    }
    if (!(zgsz350)) {

      goto case_63;
    }
    uint64_t zuz315;
    {
      lbits zgsz3280;
      CREATE(lbits)(&zgsz3280);
      CONVERT_OF(lbits, fbits)(&zgsz3280, zv__32, UINT64_C(16) , true);
      sail_int zgsz3281;
      CREATE(sail_int)(&zgsz3281);
      CONVERT_OF(sail_int, mach_int)(&zgsz3281, INT64_C(7));
      sail_int zgsz3282;
      CREATE(sail_int)(&zgsz3282);
      CONVERT_OF(sail_int, mach_int)(&zgsz3282, INT64_C(0));
      lbits zgsz3283;
      CREATE(lbits)(&zgsz3283);
      vector_subrange_lbits(&zgsz3283, zgsz3280, zgsz3281, zgsz3282);
      zuz315 = CONVERT_OF(fbits, lbits)(zgsz3283, true);
      KILL(lbits)(&zgsz3283);
      KILL(sail_int)(&zgsz3282);
      KILL(sail_int)(&zgsz3281);
      KILL(lbits)(&zgsz3280);
    }
    zROR_ZP(&zgsz333, zuz315);
    goto finish_match_46;
  }
case_63: ;
  {
    uint64_t zv__34;
    zv__34 = zmergez3var;
    uint64_t zgaz321;
    {
      lbits zgsz3296;
      CREATE(lbits)(&zgsz3296);
      CONVERT_OF(lbits, fbits)(&zgsz3296, zv__34, UINT64_C(16) , true);
      sail_int zgsz3297;
      CREATE(sail_int)(&zgsz3297);
      CONVERT_OF(sail_int, mach_int)(&zgsz3297, INT64_C(15));
      sail_int zgsz3298;
      CREATE(sail_int)(&zgsz3298);
      CONVERT_OF(sail_int, mach_int)(&zgsz3298, INT64_C(8));
      lbits zgsz3299;
      CREATE(lbits)(&zgsz3299);
      vector_subrange_lbits(&zgsz3299, zgsz3296, zgsz3297, zgsz3298);
      zgaz321 = CONVERT_OF(fbits, lbits)(zgsz3299, true);
      KILL(lbits)(&zgsz3299);
      KILL(sail_int)(&zgsz3298);
      KILL(sail_int)(&zgsz3297);
      KILL(lbits)(&zgsz3296);
    }
    bool zgsz351;
    {
      lbits zgsz3294;
      CREATE(lbits)(&zgsz3294);
      CONVERT_OF(lbits, fbits)(&zgsz3294, zgaz321, UINT64_C(8) , true);
      lbits zgsz3295;
      CREATE(lbits)(&zgsz3295);
      CONVERT_OF(lbits, fbits)(&zgsz3295, UINT64_C(0x76), UINT64_C(8) , true);
      zgsz351 = eq_bits(zgsz3294, zgsz3295);
      KILL(lbits)(&zgsz3295);
      KILL(lbits)(&zgsz3294);
    }
    if (!(zgsz351)) {

      goto case_64;
    }
    uint64_t zuz316;
    {
      lbits zgsz3290;
      CREATE(lbits)(&zgsz3290);
      CONVERT_OF(lbits, fbits)(&zgsz3290, zv__34, UINT64_C(16) , true);
      sail_int zgsz3291;
      CREATE(sail_int)(&zgsz3291);
      CONVERT_OF(sail_int, mach_int)(&zgsz3291, INT64_C(7));
      sail_int zgsz3292;
      CREATE(sail_int)(&zgsz3292);
      CONVERT_OF(sail_int, mach_int)(&zgsz3292, INT64_C(0));
      lbits zgsz3293;
      CREATE(lbits)(&zgsz3293);
      vector_subrange_lbits(&zgsz3293, zgsz3290, zgsz3291, zgsz3292);
      zuz316 = CONVERT_OF(fbits, lbits)(zgsz3293, true);
      KILL(lbits)(&zgsz3293);
      KILL(sail_int)(&zgsz3292);
      KILL(sail_int)(&zgsz3291);
      KILL(lbits)(&zgsz3290);
    }
    zROR_ZP_X(&zgsz333, zuz316);
    goto finish_match_46;
  }
case_64: ;
  sail_match_failure("decode16");
finish_match_46: ;
  COPY(zast)((*(&zcbz35)), zgsz333);
  KILL(zast)(&zgsz333);
end_function_65: ;
  goto end_function_77;
end_block_exception_66: ;
  goto end_function_77;
end_function_77: ;
}

bool zexecute(struct zast);

bool zexecute(struct zast zgsz352)
{
  __label__ fundef_fail_67, fundef_body_68, end_function_69, end_block_exception_70;

  bool zcbz36;
  if (zgsz352.kind != Kind_zAND_IMM) goto fundef_fail_67;
  uint64_t zop;
  zop = zgsz352.zAND_IMM;
  goto fundef_body_68;
fundef_fail_67: ;
  sail_match_failure("execute");
fundef_body_68: ;
  uint64_t zresult;
  {
    uint64_t zgaz324;
    {
      uint64_t zgaz323;
      zgaz323 = zreg_forwards(zA);
      zgaz324 = zread_reg(zgaz323);
    }
    {
      lbits zgsz3300;
      CREATE(lbits)(&zgsz3300);
      CONVERT_OF(lbits, fbits)(&zgsz3300, zgaz324, UINT64_C(8) , true);
      lbits zgsz3301;
      CREATE(lbits)(&zgsz3301);
      CONVERT_OF(lbits, fbits)(&zgsz3301, zop, UINT64_C(8) , true);
      lbits zgsz3302;
      CREATE(lbits)(&zgsz3302);
      and_bits(&zgsz3302, zgsz3300, zgsz3301);
      zresult = CONVERT_OF(fbits, lbits)(zgsz3302, true);
      KILL(lbits)(&zgsz3302);
      KILL(lbits)(&zgsz3301);
      KILL(lbits)(&zgsz3300);
    }
  }
  {
    uint64_t zgaz322;
    zgaz322 = zreg_forwards(zA);
    unit zgsz353;
    zgsz353 = zwrite_reg(zgaz322, zresult);
  }
  zcbz36 = true;


end_function_69: ;
  return zcbz36;
end_block_exception_70: ;

  return false;
}

unit zmain(unit);

unit zmain(unit zgsz354)
{
  __label__ end_function_72, end_block_exception_73;

  unit zcbz37;
  {
    uint64_t zgaz325;
    zgaz325 = zreg_forwards(zA);
    unit zgsz356;
    zgsz356 = zwrite_reg(zgaz325, UINT64_C(0x0A));
  }
  {
    uint64_t zgaz327;
    {
      uint64_t zgaz326;
      zgaz326 = zreg_forwards(zA);
      zgaz327 = zread_reg(zgaz326);
    }
    unit zgsz355;
    {
      lbits zgsz3303;
      CREATE(lbits)(&zgsz3303);
      CONVERT_OF(lbits, fbits)(&zgsz3303, zgaz327, UINT64_C(8) , true);
      zgsz355 = print_bits("the bits before are: ", zgsz3303);
      KILL(lbits)(&zgsz3303);
    }
  }
  bool zresult;
  {
    struct zast zgaz331;
    CREATE(zast)(&zgaz331);
    {
      uint64_t zgaz330;
      {
        lbits zgsz3304;
        CREATE(lbits)(&zgsz3304);
        CONVERT_OF(lbits, fbits)(&zgsz3304, UINT64_C(0x29), UINT64_C(8) , true);
        lbits zgsz3305;
        CREATE(lbits)(&zgsz3305);
        CONVERT_OF(lbits, fbits)(&zgsz3305, UINT64_C(0x08), UINT64_C(8) , true);
        lbits zgsz3306;
        CREATE(lbits)(&zgsz3306);
        append(&zgsz3306, zgsz3304, zgsz3305);
        zgaz330 = CONVERT_OF(fbits, lbits)(zgsz3306, true);
        KILL(lbits)(&zgsz3306);
        KILL(lbits)(&zgsz3305);
        KILL(lbits)(&zgsz3304);
      }
      zdecode16(&zgaz331, zgaz330);
    }
    zresult = zexecute(zgaz331);
    KILL(zast)(&zgaz331);
  }
  uint64_t zgaz329;
  {
    uint64_t zgaz328;
    zgaz328 = zreg_forwards(zA);
    zgaz329 = zread_reg(zgaz328);
  }
  {
    lbits zgsz3307;
    CREATE(lbits)(&zgsz3307);
    CONVERT_OF(lbits, fbits)(&zgsz3307, zgaz329, UINT64_C(8) , true);
    zcbz37 = print_bits("the bits after are: ", zgsz3307);
    KILL(lbits)(&zgsz3307);
  }


end_function_72: ;
  return zcbz37;
end_block_exception_73: ;

  return UNIT;
}

unit zinitializze_registers(unit);

unit zinitializze_registers(unit zgsz357)
{
  __label__ end_function_75, end_block_exception_76;

  unit zcbz38;
  {
    {
      sail_int zgsz3308;
      CREATE(sail_int)(&zgsz3308);
      CONVERT_OF(sail_int, mach_int)(&zgsz3308, INT64_C(16));
      lbits zgsz3309;
      CREATE(lbits)(&zgsz3309);
      UNDEFINED(lbits)(&zgsz3309, zgsz3308);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz3309, true);
      KILL(lbits)(&zgsz3309);
      KILL(sail_int)(&zgsz3308);
    }
    unit zgsz362;
    zgsz362 = UNIT;
  }
  {
    {
      sail_int zgsz3310;
      CREATE(sail_int)(&zgsz3310);
      CONVERT_OF(sail_int, mach_int)(&zgsz3310, INT64_C(8));
      lbits zgsz3311;
      CREATE(lbits)(&zgsz3311);
      UNDEFINED(lbits)(&zgsz3311, zgsz3310);
      zreg_A = CONVERT_OF(fbits, lbits)(zgsz3311, true);
      KILL(lbits)(&zgsz3311);
      KILL(sail_int)(&zgsz3310);
    }
    unit zgsz361;
    zgsz361 = UNIT;
  }
  {
    {
      sail_int zgsz3312;
      CREATE(sail_int)(&zgsz3312);
      CONVERT_OF(sail_int, mach_int)(&zgsz3312, INT64_C(8));
      lbits zgsz3313;
      CREATE(lbits)(&zgsz3313);
      UNDEFINED(lbits)(&zgsz3313, zgsz3312);
      zreg_X = CONVERT_OF(fbits, lbits)(zgsz3313, true);
      KILL(lbits)(&zgsz3313);
      KILL(sail_int)(&zgsz3312);
    }
    unit zgsz360;
    zgsz360 = UNIT;
  }
  {
    {
      sail_int zgsz3314;
      CREATE(sail_int)(&zgsz3314);
      CONVERT_OF(sail_int, mach_int)(&zgsz3314, INT64_C(8));
      lbits zgsz3315;
      CREATE(lbits)(&zgsz3315);
      UNDEFINED(lbits)(&zgsz3315, zgsz3314);
      zreg_Y = CONVERT_OF(fbits, lbits)(zgsz3315, true);
      KILL(lbits)(&zgsz3315);
      KILL(sail_int)(&zgsz3314);
    }
    unit zgsz359;
    zgsz359 = UNIT;
  }
  {
    zreg_SR = zundefined_flags(UNIT);
    unit zgsz358;
    zgsz358 = UNIT;
  }
  {
    sail_int zgsz3316;
    CREATE(sail_int)(&zgsz3316);
    CONVERT_OF(sail_int, mach_int)(&zgsz3316, INT64_C(8));
    lbits zgsz3317;
    CREATE(lbits)(&zgsz3317);
    UNDEFINED(lbits)(&zgsz3317, zgsz3316);
    zreg_SP = CONVERT_OF(fbits, lbits)(zgsz3317, true);
    KILL(lbits)(&zgsz3317);
    KILL(sail_int)(&zgsz3316);
  }
  zcbz38 = UNIT;
end_function_75: ;
  return zcbz38;
end_block_exception_76: ;

  return UNIT;
}

void model_init(void)
{
  setup_rts();
  current_exception = sail_new(struct zexception);
  CREATE(zexception)(current_exception);
  throw_location = sail_new(sail_string);
  CREATE(sail_string)(throw_location);
  create_letbind_0();
  create_letbind_1();
  create_letbind_2();
  create_letbind_3();
  create_letbind_4();
  create_letbind_5();
  zinitializze_registers(UNIT);
}

void model_fini(void)
{
  kill_letbind_5();
  kill_letbind_4();
  kill_letbind_3();
  kill_letbind_2();
  kill_letbind_1();
  kill_letbind_0();
  cleanup_rts();
  if (have_exception) {fprintf(stderr, "Exiting due to uncaught exception: %s\n", *throw_location);}
  KILL(zexception)(current_exception);
  sail_free(current_exception);
  KILL(sail_string)(throw_location);
  sail_free(throw_location);
  if (have_exception) {exit(EXIT_FAILURE);}
}

void model_pre_exit()
{
}

int model_main(int argc, char *argv[])
{
  model_init();
  if (process_arguments(argc, argv)) exit(EXIT_FAILURE);
  zmain(UNIT);
  model_fini();
  model_pre_exit();
  return EXIT_SUCCESS;
}

int main(int argc, char *argv[])
{
  return model_main(argc, argv);
}

#ifdef __cplusplus
}
#endif
