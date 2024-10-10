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
enum kind_zast { Kind_zAND_ABS, Kind_zAND_ABS_X, Kind_zAND_ABS_Y, Kind_zAND_IMM, Kind_zAND_IND_X, Kind_zAND_IND_Y, Kind_zAND_ZP, Kind_zAND_ZP_X, Kind_zINVALID };

struct zast {
  enum kind_zast kind;
  union {
    struct { uint64_t zAND_ABS; };
    struct { uint64_t zAND_ABS_X; };
    struct { uint64_t zAND_ABS_Y; };
    struct { uint64_t zAND_IMM; };
    struct { uint64_t zAND_IND_X; };
    struct { uint64_t zAND_IND_Y; };
    struct { uint64_t zAND_ZP; };
    struct { uint64_t zAND_ZP_X; };
    struct { uint64_t zINVALID; };
  };
};

static void CREATE(zast)(struct zast *op) {
  op->kind = Kind_zAND_ABS;
}

static void RECREATE(zast)(struct zast *op) {

}

static void KILL(zast)(struct zast *op) {
  {}
}

static void COPY(zast)(struct zast *rop, struct zast op) {
  {};
  rop->kind = op.kind;
  if (op.kind == Kind_zAND_ABS) {
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
  } else if (op.kind == Kind_zINVALID) {
    rop->zINVALID = op.zINVALID;
  }
}

static bool EQUAL(zast)(struct zast op1, struct zast op2) {
  if (op1.kind == Kind_zAND_ABS && op2.kind == Kind_zAND_ABS) {
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
  } else if (op1.kind == Kind_zINVALID && op2.kind == Kind_zINVALID) {
    return EQUAL(fbits)(op1.zINVALID, op2.zINVALID);
  } else return false;
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

static void zINVALID(struct zast *rop, uint64_t op) {
  {}
  rop->kind = Kind_zINVALID;
  rop->zINVALID = op;
}









bool zneq_bits(lbits zx, lbits zy)
{
  __label__ end_function_1, end_block_exception_2;

  bool zcbz30;
  bool zgaz30;
  zgaz30 = eq_bits(zx, zy);
  zcbz30 = not(zgaz30);

end_function_1: ;
  return zcbz30;
end_block_exception_2: ;

  return false;
}

struct zz5vecz8z5bv8z9 {
  size_t len;
  uint64_t *data;
};
typedef struct zz5vecz8z5bv8z9 zz5vecz8z5bv8z9;

static void CREATE(zz5vecz8z5bv8z9)(zz5vecz8z5bv8z9 *rop) {
  rop->len = 0;
  rop->data = NULL;
}

static void KILL(zz5vecz8z5bv8z9)(zz5vecz8z5bv8z9 *rop) {
  if (rop->data != NULL) sail_free(rop->data);
}

static void vector_init_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 *vec, sail_int n, uint64_t elem) {
  KILL(zz5vecz8z5bv8z9)(vec);
  size_t m = (size_t)sail_int_get_ui(n);
  vec->len = m;
  vec->data = sail_new_array(uint64_t, m);
  for (size_t i = 0; i < m; i++) {
    (vec->data)[i] = elem;
  }
}

static void RECREATE(zz5vecz8z5bv8z9)(zz5vecz8z5bv8z9 *rop) {
  KILL(zz5vecz8z5bv8z9)(rop);
  CREATE(zz5vecz8z5bv8z9)(rop);
}

static void undefined_vector_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 *rop, sail_int len, uint64_t elem) {
  rop->len = sail_int_get_ui(len);
  rop->data = sail_new_array(uint64_t, rop->len);
  for (int i = 0; i < (rop->len); i++) {
    (rop->data)[i] = elem;
  }
}

static uint64_t vector_access_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 op, sail_int n) {
  int m = sail_int_get_ui(n);
  return op.data[m];
}

static void COPY(zz5vecz8z5bv8z9)(zz5vecz8z5bv8z9 *rop, zz5vecz8z5bv8z9 op) {
  KILL(zz5vecz8z5bv8z9)(rop);
  rop->len = op.len;
  rop->data = sail_new_array(uint64_t, rop->len);
  for (int i = 0; i < op.len; i++) {
    (rop->data)[i] = op.data[i];
  }
}

static void vector_update_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 *rop, zz5vecz8z5bv8z9 op, sail_int n, uint64_t elem) {
  int m = sail_int_get_ui(n);
  if (rop->data == op.data) {
    rop->data[m] = elem;
  } else {
    COPY(zz5vecz8z5bv8z9)(rop, op);
    rop->data[m] = elem;
  }
}

static bool EQUAL(zz5vecz8z5bv8z9)(const zz5vecz8z5bv8z9 op1, const zz5vecz8z5bv8z9 op2) {
  if (op1.len != op2.len) return false;
  bool result = true;
  for (int i = 0; i < op1.len; i++) {
    result &= EQUAL(fbits)(op1.data[i], op2.data[i]);
  }
  return result;
}

static void length_zz5vecz8z5bv8z9(sail_int *rop, zz5vecz8z5bv8z9 op) {
  mpz_set_ui(*rop, (unsigned long int)(op.len));
}

static void internal_vector_update_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 *rop, zz5vecz8z5bv8z9 op, const int64_t n, uint64_t elem) {
  rop->data[n] = elem;
}

static void internal_vector_init_zz5vecz8z5bv8z9(zz5vecz8z5bv8z9 *rop, const int64_t len) {
  rop->len = len;
  rop->data = sail_new_array(uint64_t, len);
}




struct zz5vecz8z5vecz8z5bv8z9z9 {
  size_t len;
  zz5vecz8z5bv8z9 *data;
};
typedef struct zz5vecz8z5vecz8z5bv8z9z9 zz5vecz8z5vecz8z5bv8z9z9;

static void CREATE(zz5vecz8z5vecz8z5bv8z9z9)(zz5vecz8z5vecz8z5bv8z9z9 *rop) {
  rop->len = 0;
  rop->data = NULL;
}

static void KILL(zz5vecz8z5vecz8z5bv8z9z9)(zz5vecz8z5vecz8z5bv8z9z9 *rop) {
  for (int i = 0; i < (rop->len); i++) {
    KILL(zz5vecz8z5bv8z9)((rop->data) + i);
  }
  if (rop->data != NULL) sail_free(rop->data);
}

static void vector_init_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5vecz8z5bv8z9z9 *vec, sail_int n, zz5vecz8z5bv8z9 elem) {
  KILL(zz5vecz8z5vecz8z5bv8z9z9)(vec);
  size_t m = (size_t)sail_int_get_ui(n);
  vec->len = m;
  vec->data = sail_new_array(zz5vecz8z5bv8z9, m);
  for (size_t i = 0; i < m; i++) {
    CREATE(zz5vecz8z5bv8z9)((vec->data) + i);
    COPY(zz5vecz8z5bv8z9)((vec->data) + i, elem);
  }
}

static void RECREATE(zz5vecz8z5vecz8z5bv8z9z9)(zz5vecz8z5vecz8z5bv8z9z9 *rop) {
  KILL(zz5vecz8z5vecz8z5bv8z9z9)(rop);
  CREATE(zz5vecz8z5vecz8z5bv8z9z9)(rop);
}

static void undefined_vector_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5vecz8z5bv8z9z9 *rop, sail_int len, zz5vecz8z5bv8z9 elem) {
  rop->len = sail_int_get_ui(len);
  rop->data = sail_new_array(zz5vecz8z5bv8z9, rop->len);
  for (int i = 0; i < (rop->len); i++) {
    CREATE(zz5vecz8z5bv8z9)((rop->data) + i);
    COPY(zz5vecz8z5bv8z9)((rop->data) + i, elem);
  }
}

static void vector_access_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5bv8z9 *rop, zz5vecz8z5vecz8z5bv8z9z9 op, sail_int n) {
  int m = sail_int_get_ui(n);
  COPY(zz5vecz8z5bv8z9)(rop, op.data[m]);
}

static void COPY(zz5vecz8z5vecz8z5bv8z9z9)(zz5vecz8z5vecz8z5bv8z9z9 *rop, zz5vecz8z5vecz8z5bv8z9z9 op) {
  KILL(zz5vecz8z5vecz8z5bv8z9z9)(rop);
  rop->len = op.len;
  rop->data = sail_new_array(zz5vecz8z5bv8z9, rop->len);
  for (int i = 0; i < op.len; i++) {
    CREATE(zz5vecz8z5bv8z9)((rop->data) + i);
    COPY(zz5vecz8z5bv8z9)((rop->data) + i, op.data[i]);
  }
}

static void vector_update_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5vecz8z5bv8z9z9 *rop, zz5vecz8z5vecz8z5bv8z9z9 op, sail_int n, zz5vecz8z5bv8z9 elem) {
  int m = sail_int_get_ui(n);
  if (rop->data == op.data) {
    COPY(zz5vecz8z5bv8z9)((rop->data) + m, elem);
  } else {
    COPY(zz5vecz8z5vecz8z5bv8z9z9)(rop, op);
    COPY(zz5vecz8z5bv8z9)((rop->data) + m, elem);
  }
}

static bool EQUAL(zz5vecz8z5vecz8z5bv8z9z9)(const zz5vecz8z5vecz8z5bv8z9z9 op1, const zz5vecz8z5vecz8z5bv8z9z9 op2) {
  if (op1.len != op2.len) return false;
  bool result = true;
  for (int i = 0; i < op1.len; i++) {
    result &= EQUAL(zz5vecz8z5bv8z9)(op1.data[i], op2.data[i]);
  }
  return result;
}

static void length_zz5vecz8z5vecz8z5bv8z9z9(sail_int *rop, zz5vecz8z5vecz8z5bv8z9z9 op) {
  mpz_set_ui(*rop, (unsigned long int)(op.len));
}

static void internal_vector_update_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5vecz8z5bv8z9z9 *rop, zz5vecz8z5vecz8z5bv8z9z9 op, const int64_t n, zz5vecz8z5bv8z9 elem) {
  COPY(zz5vecz8z5bv8z9)((rop->data) + n, elem);
}

static void internal_vector_init_zz5vecz8z5vecz8z5bv8z9z9(zz5vecz8z5vecz8z5bv8z9z9 *rop, const int64_t len) {
  rop->len = len;
  rop->data = sail_new_array(zz5vecz8z5bv8z9, len);
  for (int i = 0; i < len; i++) {
    CREATE(zz5vecz8z5bv8z9)((rop->data) + i);
  }
}






























void zEXTZ(lbits *rop, sail_int, lbits);

void zEXTZ(lbits *zcbz31, sail_int zm, lbits zv)
{
  __label__ end_function_4, end_block_exception_5, end_function_73;

  zero_extend((*(&zcbz31)), zv, zm);
end_function_4: ;
  goto end_function_73;
end_block_exception_5: ;
  goto end_function_73;
end_function_73: ;
}

struct zflags zundefined_flags(unit);

struct zflags zundefined_flags(unit zgsz30)
{
  __label__ end_function_7, end_block_exception_8;

  struct zflags zcbz32;
  uint64_t zgaz31;
  {
    sail_int zgsz358;
    CREATE(sail_int)(&zgsz358);
    CONVERT_OF(sail_int, mach_int)(&zgsz358, INT64_C(8));
    lbits zgsz359;
    CREATE(lbits)(&zgsz359);
    UNDEFINED(lbits)(&zgsz359, zgsz358);
    zgaz31 = CONVERT_OF(fbits, lbits)(zgsz359, true);
    KILL(lbits)(&zgsz359);
    KILL(sail_int)(&zgsz358);
  }
  struct zflags zgsz31;
  zgsz31.zbits = zgaz31;
  zcbz32 = zgsz31;


end_function_7: ;
  return zcbz32;
end_block_exception_8: ;
  struct zflags zcbz312 = { .zbits = UINT64_C(0xdeadc0de) };
  return zcbz312;
}

uint64_t z_get_flags_all(struct zflags);

uint64_t z_get_flags_all(struct zflags zv)
{
  __label__ end_function_10, end_block_exception_11;

  uint64_t zcbz33;
  uint64_t zgaz32;
  zgaz32 = zv.zbits;
  {
    lbits zgsz360;
    CREATE(lbits)(&zgsz360);
    CONVERT_OF(lbits, fbits)(&zgsz360, zgaz32, UINT64_C(8) , true);
    sail_int zgsz361;
    CREATE(sail_int)(&zgsz361);
    CONVERT_OF(sail_int, mach_int)(&zgsz361, INT64_C(7));
    sail_int zgsz362;
    CREATE(sail_int)(&zgsz362);
    CONVERT_OF(sail_int, mach_int)(&zgsz362, INT64_C(0));
    lbits zgsz363;
    CREATE(lbits)(&zgsz363);
    vector_subrange_lbits(&zgsz363, zgsz360, zgsz361, zgsz362);
    zcbz33 = CONVERT_OF(fbits, lbits)(zgsz363, true);
    KILL(lbits)(&zgsz363);
    KILL(sail_int)(&zgsz362);
    KILL(sail_int)(&zgsz361);
    KILL(lbits)(&zgsz360);
  }

end_function_10: ;
  return zcbz33;
end_block_exception_11: ;

  return UINT64_C(0xdeadc0de);
}

uint64_t zNMI_vec;
static void create_letbind_0(void) {


  uint64_t zgsz32;
  zgsz32 = UINT64_C(0xFFFA);
  zNMI_vec = zgsz32;

let_end_12: ;
}
static void kill_letbind_0(void) {
}

uint64_t zRES_vec;
static void create_letbind_1(void) {


  uint64_t zgsz33;
  zgsz33 = UINT64_C(0xFFFC);
  zRES_vec = zgsz33;

let_end_13: ;
}
static void kill_letbind_1(void) {
}

uint64_t zIRQ_vec;
static void create_letbind_2(void) {


  uint64_t zgsz34;
  zgsz34 = UINT64_C(0xFFFE);
  zIRQ_vec = zgsz34;

let_end_14: ;
}
static void kill_letbind_2(void) {
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

uint64_t zname_forwards(enum zreg_enum);

uint64_t zname_forwards(enum zreg_enum zargz3)
{
  __label__ case_17, case_18, case_19, case_20, case_21, case_22, case_23, finish_match_16, end_function_24, end_block_exception_25;

  uint64_t zcbz34;
  /* Case with num_cases: 7 */
  uint64_t zgsz35;
  {
    if ((zPC_H != zargz3)) goto case_17;
    zgsz35 = UINT64_C(0b000);
    goto finish_match_16;
  }
case_17: ;
  {
    if ((zPC_L != zargz3)) goto case_18;
    zgsz35 = UINT64_C(0b001);
    goto finish_match_16;
  }
case_18: ;
  {
    if ((zA != zargz3)) goto case_19;
    zgsz35 = UINT64_C(0b010);
    goto finish_match_16;
  }
case_19: ;
  {
    if ((zX != zargz3)) goto case_20;
    zgsz35 = UINT64_C(0b011);
    goto finish_match_16;
  }
case_20: ;
  {
    if ((zY != zargz3)) goto case_21;
    zgsz35 = UINT64_C(0b100);
    goto finish_match_16;
  }
case_21: ;
  {
    if ((zSR != zargz3)) goto case_22;
    zgsz35 = UINT64_C(0b101);
    goto finish_match_16;
  }
case_22: ;
  {
    if ((zSP != zargz3)) goto case_23;
    zgsz35 = UINT64_C(0b110);
    goto finish_match_16;
  }
case_23: ;
  sail_match_failure("name_forwards");
finish_match_16: ;
  zcbz34 = zgsz35;

end_function_24: ;
  return zcbz34;
end_block_exception_25: ;

  return UINT64_C(0xdeadc0de);
}

uint64_t zread_register(uint64_t);

uint64_t zread_register(uint64_t zr)
{
  __label__ case_28, case_29, case_30, case_31, case_32, case_33, case_34, finish_match_27, end_function_35, end_block_exception_36;

  uint64_t zcbz35;
  /* Case with num_cases: 7 */
  uint64_t zgsz313;
  {
    uint64_t zb__0;
    zb__0 = zr;
    bool zgsz314;
    {
      lbits zgsz368;
      CREATE(lbits)(&zgsz368);
      CONVERT_OF(lbits, fbits)(&zgsz368, zb__0, UINT64_C(3) , true);
      lbits zgsz369;
      CREATE(lbits)(&zgsz369);
      CONVERT_OF(lbits, fbits)(&zgsz369, UINT64_C(0b000), UINT64_C(3) , true);
      zgsz314 = eq_bits(zgsz368, zgsz369);
      KILL(lbits)(&zgsz369);
      KILL(lbits)(&zgsz368);
    }
    if (!(zgsz314)) {

      goto case_28;
    }
    {
      lbits zgsz364;
      CREATE(lbits)(&zgsz364);
      CONVERT_OF(lbits, fbits)(&zgsz364, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz365;
      CREATE(sail_int)(&zgsz365);
      CONVERT_OF(sail_int, mach_int)(&zgsz365, INT64_C(15));
      sail_int zgsz366;
      CREATE(sail_int)(&zgsz366);
      CONVERT_OF(sail_int, mach_int)(&zgsz366, INT64_C(8));
      lbits zgsz367;
      CREATE(lbits)(&zgsz367);
      vector_subrange_lbits(&zgsz367, zgsz364, zgsz365, zgsz366);
      zgsz313 = CONVERT_OF(fbits, lbits)(zgsz367, true);
      KILL(lbits)(&zgsz367);
      KILL(sail_int)(&zgsz366);
      KILL(sail_int)(&zgsz365);
      KILL(lbits)(&zgsz364);
    }
    goto finish_match_27;
  }
case_28: ;
  {
    uint64_t zb__1;
    zb__1 = zr;
    bool zgsz315;
    {
      lbits zgsz374;
      CREATE(lbits)(&zgsz374);
      CONVERT_OF(lbits, fbits)(&zgsz374, zb__1, UINT64_C(3) , true);
      lbits zgsz375;
      CREATE(lbits)(&zgsz375);
      CONVERT_OF(lbits, fbits)(&zgsz375, UINT64_C(0b001), UINT64_C(3) , true);
      zgsz315 = eq_bits(zgsz374, zgsz375);
      KILL(lbits)(&zgsz375);
      KILL(lbits)(&zgsz374);
    }
    if (!(zgsz315)) {

      goto case_29;
    }
    {
      lbits zgsz370;
      CREATE(lbits)(&zgsz370);
      CONVERT_OF(lbits, fbits)(&zgsz370, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz371;
      CREATE(sail_int)(&zgsz371);
      CONVERT_OF(sail_int, mach_int)(&zgsz371, INT64_C(7));
      sail_int zgsz372;
      CREATE(sail_int)(&zgsz372);
      CONVERT_OF(sail_int, mach_int)(&zgsz372, INT64_C(0));
      lbits zgsz373;
      CREATE(lbits)(&zgsz373);
      vector_subrange_lbits(&zgsz373, zgsz370, zgsz371, zgsz372);
      zgsz313 = CONVERT_OF(fbits, lbits)(zgsz373, true);
      KILL(lbits)(&zgsz373);
      KILL(sail_int)(&zgsz372);
      KILL(sail_int)(&zgsz371);
      KILL(lbits)(&zgsz370);
    }
    goto finish_match_27;
  }
case_29: ;
  {
    uint64_t zb__2;
    zb__2 = zr;
    bool zgsz316;
    {
      lbits zgsz376;
      CREATE(lbits)(&zgsz376);
      CONVERT_OF(lbits, fbits)(&zgsz376, zb__2, UINT64_C(3) , true);
      lbits zgsz377;
      CREATE(lbits)(&zgsz377);
      CONVERT_OF(lbits, fbits)(&zgsz377, UINT64_C(0b010), UINT64_C(3) , true);
      zgsz316 = eq_bits(zgsz376, zgsz377);
      KILL(lbits)(&zgsz377);
      KILL(lbits)(&zgsz376);
    }
    if (!(zgsz316)) {

      goto case_30;
    }
    zgsz313 = zreg_A;
    goto finish_match_27;
  }
case_30: ;
  {
    uint64_t zb__3;
    zb__3 = zr;
    bool zgsz317;
    {
      lbits zgsz378;
      CREATE(lbits)(&zgsz378);
      CONVERT_OF(lbits, fbits)(&zgsz378, zb__3, UINT64_C(3) , true);
      lbits zgsz379;
      CREATE(lbits)(&zgsz379);
      CONVERT_OF(lbits, fbits)(&zgsz379, UINT64_C(0b011), UINT64_C(3) , true);
      zgsz317 = eq_bits(zgsz378, zgsz379);
      KILL(lbits)(&zgsz379);
      KILL(lbits)(&zgsz378);
    }
    if (!(zgsz317)) {

      goto case_31;
    }
    zgsz313 = zreg_X;
    goto finish_match_27;
  }
case_31: ;
  {
    uint64_t zb__4;
    zb__4 = zr;
    bool zgsz318;
    {
      lbits zgsz380;
      CREATE(lbits)(&zgsz380);
      CONVERT_OF(lbits, fbits)(&zgsz380, zb__4, UINT64_C(3) , true);
      lbits zgsz381;
      CREATE(lbits)(&zgsz381);
      CONVERT_OF(lbits, fbits)(&zgsz381, UINT64_C(0b100), UINT64_C(3) , true);
      zgsz318 = eq_bits(zgsz380, zgsz381);
      KILL(lbits)(&zgsz381);
      KILL(lbits)(&zgsz380);
    }
    if (!(zgsz318)) {

      goto case_32;
    }
    zgsz313 = zreg_Y;
    goto finish_match_27;
  }
case_32: ;
  {
    uint64_t zb__5;
    zb__5 = zr;
    bool zgsz319;
    {
      lbits zgsz382;
      CREATE(lbits)(&zgsz382);
      CONVERT_OF(lbits, fbits)(&zgsz382, zb__5, UINT64_C(3) , true);
      lbits zgsz383;
      CREATE(lbits)(&zgsz383);
      CONVERT_OF(lbits, fbits)(&zgsz383, UINT64_C(0b101), UINT64_C(3) , true);
      zgsz319 = eq_bits(zgsz382, zgsz383);
      KILL(lbits)(&zgsz383);
      KILL(lbits)(&zgsz382);
    }
    if (!(zgsz319)) {

      goto case_33;
    }
    zgsz313 = z_get_flags_all(zreg_SR);
    goto finish_match_27;
  }
case_33: ;
  {
    uint64_t zb__6;
    zb__6 = zr;
    bool zgsz320;
    {
      lbits zgsz384;
      CREATE(lbits)(&zgsz384);
      CONVERT_OF(lbits, fbits)(&zgsz384, zb__6, UINT64_C(3) , true);
      lbits zgsz385;
      CREATE(lbits)(&zgsz385);
      CONVERT_OF(lbits, fbits)(&zgsz385, UINT64_C(0b110), UINT64_C(3) , true);
      zgsz320 = eq_bits(zgsz384, zgsz385);
      KILL(lbits)(&zgsz385);
      KILL(lbits)(&zgsz384);
    }
    if (!(zgsz320)) {

      goto case_34;
    }
    zgsz313 = zreg_SP;
    goto finish_match_27;
  }
case_34: ;
  sail_match_failure("read_register");
finish_match_27: ;
  zcbz35 = zgsz313;

end_function_35: ;
  return zcbz35;
end_block_exception_36: ;

  return UINT64_C(0xdeadc0de);
}

unit zwrite_register(uint64_t, uint64_t);

unit zwrite_register(uint64_t zr, uint64_t zword)
{
  __label__ case_39, case_40, case_41, case_42, case_43, case_44, case_45, finish_match_38, end_function_46, end_block_exception_47;

  unit zcbz36;
  /* Case with num_cases: 7 */
  unit zgsz321;
  {
    uint64_t zb__0;
    zb__0 = zr;
    bool zgsz322;
    {
      lbits zgsz391;
      CREATE(lbits)(&zgsz391);
      CONVERT_OF(lbits, fbits)(&zgsz391, zb__0, UINT64_C(3) , true);
      lbits zgsz392;
      CREATE(lbits)(&zgsz392);
      CONVERT_OF(lbits, fbits)(&zgsz392, UINT64_C(0b000), UINT64_C(3) , true);
      zgsz322 = eq_bits(zgsz391, zgsz392);
      KILL(lbits)(&zgsz392);
      KILL(lbits)(&zgsz391);
    }
    if (!(zgsz322)) {

      goto case_39;
    }
    {
      lbits zgsz386;
      CREATE(lbits)(&zgsz386);
      CONVERT_OF(lbits, fbits)(&zgsz386, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz387;
      CREATE(sail_int)(&zgsz387);
      CONVERT_OF(sail_int, mach_int)(&zgsz387, INT64_C(15));
      sail_int zgsz388;
      CREATE(sail_int)(&zgsz388);
      CONVERT_OF(sail_int, mach_int)(&zgsz388, INT64_C(8));
      lbits zgsz389;
      CREATE(lbits)(&zgsz389);
      CONVERT_OF(lbits, fbits)(&zgsz389, zword, UINT64_C(8) , true);
      lbits zgsz390;
      CREATE(lbits)(&zgsz390);
      vector_update_subrange_lbits(&zgsz390, zgsz386, zgsz387, zgsz388, zgsz389);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz390, true);
      KILL(lbits)(&zgsz390);
      KILL(lbits)(&zgsz389);
      KILL(sail_int)(&zgsz388);
      KILL(sail_int)(&zgsz387);
      KILL(lbits)(&zgsz386);
    }
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_39: ;
  {
    uint64_t zb__1;
    zb__1 = zr;
    bool zgsz323;
    {
      lbits zgsz398;
      CREATE(lbits)(&zgsz398);
      CONVERT_OF(lbits, fbits)(&zgsz398, zb__1, UINT64_C(3) , true);
      lbits zgsz399;
      CREATE(lbits)(&zgsz399);
      CONVERT_OF(lbits, fbits)(&zgsz399, UINT64_C(0b001), UINT64_C(3) , true);
      zgsz323 = eq_bits(zgsz398, zgsz399);
      KILL(lbits)(&zgsz399);
      KILL(lbits)(&zgsz398);
    }
    if (!(zgsz323)) {

      goto case_40;
    }
    {
      lbits zgsz393;
      CREATE(lbits)(&zgsz393);
      CONVERT_OF(lbits, fbits)(&zgsz393, zreg_PC, UINT64_C(16) , true);
      sail_int zgsz394;
      CREATE(sail_int)(&zgsz394);
      CONVERT_OF(sail_int, mach_int)(&zgsz394, INT64_C(7));
      sail_int zgsz395;
      CREATE(sail_int)(&zgsz395);
      CONVERT_OF(sail_int, mach_int)(&zgsz395, INT64_C(0));
      lbits zgsz396;
      CREATE(lbits)(&zgsz396);
      CONVERT_OF(lbits, fbits)(&zgsz396, zword, UINT64_C(8) , true);
      lbits zgsz397;
      CREATE(lbits)(&zgsz397);
      vector_update_subrange_lbits(&zgsz397, zgsz393, zgsz394, zgsz395, zgsz396);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz397, true);
      KILL(lbits)(&zgsz397);
      KILL(lbits)(&zgsz396);
      KILL(sail_int)(&zgsz395);
      KILL(sail_int)(&zgsz394);
      KILL(lbits)(&zgsz393);
    }
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_40: ;
  {
    uint64_t zb__2;
    zb__2 = zr;
    bool zgsz324;
    {
      lbits zgsz3100;
      CREATE(lbits)(&zgsz3100);
      CONVERT_OF(lbits, fbits)(&zgsz3100, zb__2, UINT64_C(3) , true);
      lbits zgsz3101;
      CREATE(lbits)(&zgsz3101);
      CONVERT_OF(lbits, fbits)(&zgsz3101, UINT64_C(0b010), UINT64_C(3) , true);
      zgsz324 = eq_bits(zgsz3100, zgsz3101);
      KILL(lbits)(&zgsz3101);
      KILL(lbits)(&zgsz3100);
    }
    if (!(zgsz324)) {

      goto case_41;
    }
    zreg_A = zword;
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_41: ;
  {
    uint64_t zb__3;
    zb__3 = zr;
    bool zgsz325;
    {
      lbits zgsz3102;
      CREATE(lbits)(&zgsz3102);
      CONVERT_OF(lbits, fbits)(&zgsz3102, zb__3, UINT64_C(3) , true);
      lbits zgsz3103;
      CREATE(lbits)(&zgsz3103);
      CONVERT_OF(lbits, fbits)(&zgsz3103, UINT64_C(0b011), UINT64_C(3) , true);
      zgsz325 = eq_bits(zgsz3102, zgsz3103);
      KILL(lbits)(&zgsz3103);
      KILL(lbits)(&zgsz3102);
    }
    if (!(zgsz325)) {

      goto case_42;
    }
    zreg_X = zword;
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_42: ;
  {
    uint64_t zb__4;
    zb__4 = zr;
    bool zgsz326;
    {
      lbits zgsz3104;
      CREATE(lbits)(&zgsz3104);
      CONVERT_OF(lbits, fbits)(&zgsz3104, zb__4, UINT64_C(3) , true);
      lbits zgsz3105;
      CREATE(lbits)(&zgsz3105);
      CONVERT_OF(lbits, fbits)(&zgsz3105, UINT64_C(0b100), UINT64_C(3) , true);
      zgsz326 = eq_bits(zgsz3104, zgsz3105);
      KILL(lbits)(&zgsz3105);
      KILL(lbits)(&zgsz3104);
    }
    if (!(zgsz326)) {

      goto case_43;
    }
    zreg_Y = zword;
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_43: ;
  {
    uint64_t zb__5;
    zb__5 = zr;
    bool zgsz328;
    {
      lbits zgsz3111;
      CREATE(lbits)(&zgsz3111);
      CONVERT_OF(lbits, fbits)(&zgsz3111, zb__5, UINT64_C(3) , true);
      lbits zgsz3112;
      CREATE(lbits)(&zgsz3112);
      CONVERT_OF(lbits, fbits)(&zgsz3112, UINT64_C(0b101), UINT64_C(3) , true);
      zgsz328 = eq_bits(zgsz3111, zgsz3112);
      KILL(lbits)(&zgsz3112);
      KILL(lbits)(&zgsz3111);
    }
    if (!(zgsz328)) {

      goto case_44;
    }
    uint64_t zgaz34;
    {
      uint64_t zgaz33;
      zgaz33 = zreg_SR.zbits;
      {
        lbits zgsz3106;
        CREATE(lbits)(&zgsz3106);
        CONVERT_OF(lbits, fbits)(&zgsz3106, zgaz33, UINT64_C(8) , true);
        sail_int zgsz3107;
        CREATE(sail_int)(&zgsz3107);
        CONVERT_OF(sail_int, mach_int)(&zgsz3107, INT64_C(7));
        sail_int zgsz3108;
        CREATE(sail_int)(&zgsz3108);
        CONVERT_OF(sail_int, mach_int)(&zgsz3108, INT64_C(0));
        lbits zgsz3109;
        CREATE(lbits)(&zgsz3109);
        CONVERT_OF(lbits, fbits)(&zgsz3109, zword, UINT64_C(8) , true);
        lbits zgsz3110;
        CREATE(lbits)(&zgsz3110);
        vector_update_subrange_lbits(&zgsz3110, zgsz3106, zgsz3107, zgsz3108, zgsz3109);
        zgaz34 = CONVERT_OF(fbits, lbits)(zgsz3110, true);
        KILL(lbits)(&zgsz3110);
        KILL(lbits)(&zgsz3109);
        KILL(sail_int)(&zgsz3108);
        KILL(sail_int)(&zgsz3107);
        KILL(lbits)(&zgsz3106);
      }
    }
    struct zflags zgsz327;
    zgsz327 = zreg_SR;
    zgsz327.zbits = zgaz34;
    zreg_SR = zgsz327;
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_44: ;
  {
    uint64_t zb__6;
    zb__6 = zr;
    bool zgsz329;
    {
      lbits zgsz3113;
      CREATE(lbits)(&zgsz3113);
      CONVERT_OF(lbits, fbits)(&zgsz3113, zb__6, UINT64_C(3) , true);
      lbits zgsz3114;
      CREATE(lbits)(&zgsz3114);
      CONVERT_OF(lbits, fbits)(&zgsz3114, UINT64_C(0b110), UINT64_C(3) , true);
      zgsz329 = eq_bits(zgsz3113, zgsz3114);
      KILL(lbits)(&zgsz3114);
      KILL(lbits)(&zgsz3113);
    }
    if (!(zgsz329)) {

      goto case_45;
    }
    zreg_SP = zword;
    zgsz321 = UNIT;
    goto finish_match_38;
  }
case_45: ;
  sail_match_failure("write_register");
finish_match_38: ;
  zcbz36 = zgsz321;

end_function_46: ;
  return zcbz36;
end_block_exception_47: ;

  return UNIT;
}



// register main_mem
zz5vecz8z5vecz8z5bv8z9z9 zmain_mem;

uint64_t zread_memory(uint64_t);



uint64_t zread_memory(uint64_t zaddr)
{
  __label__ end_function_49, end_block_exception_50;

  uint64_t zcbz37;
  int64_t zpage_index;
  {
    uint64_t zgaz38;
    {
      lbits zgsz3119;
      CREATE(lbits)(&zgsz3119);
      CONVERT_OF(lbits, fbits)(&zgsz3119, zaddr, UINT64_C(16) , true);
      sail_int zgsz3120;
      CREATE(sail_int)(&zgsz3120);
      CONVERT_OF(sail_int, mach_int)(&zgsz3120, INT64_C(15));
      sail_int zgsz3121;
      CREATE(sail_int)(&zgsz3121);
      CONVERT_OF(sail_int, mach_int)(&zgsz3121, INT64_C(8));
      lbits zgsz3122;
      CREATE(lbits)(&zgsz3122);
      vector_subrange_lbits(&zgsz3122, zgsz3119, zgsz3120, zgsz3121);
      zgaz38 = CONVERT_OF(fbits, lbits)(zgsz3122, true);
      KILL(lbits)(&zgsz3122);
      KILL(sail_int)(&zgsz3121);
      KILL(sail_int)(&zgsz3120);
      KILL(lbits)(&zgsz3119);
    }
    {
      lbits zgsz3117;
      CREATE(lbits)(&zgsz3117);
      CONVERT_OF(lbits, fbits)(&zgsz3117, zgaz38, UINT64_C(8) , true);
      sail_int zgsz3118;
      CREATE(sail_int)(&zgsz3118);
      sail_unsigned(&zgsz3118, zgsz3117);
      zpage_index = CONVERT_OF(mach_int, sail_int)(zgsz3118);
      KILL(sail_int)(&zgsz3118);
      KILL(lbits)(&zgsz3117);
    }
  }
  int64_t zword_index;
  {
    uint64_t zgaz37;
    {
      lbits zgsz3125;
      CREATE(lbits)(&zgsz3125);
      CONVERT_OF(lbits, fbits)(&zgsz3125, zaddr, UINT64_C(16) , true);
      sail_int zgsz3126;
      CREATE(sail_int)(&zgsz3126);
      CONVERT_OF(sail_int, mach_int)(&zgsz3126, INT64_C(7));
      sail_int zgsz3127;
      CREATE(sail_int)(&zgsz3127);
      CONVERT_OF(sail_int, mach_int)(&zgsz3127, INT64_C(0));
      lbits zgsz3128;
      CREATE(lbits)(&zgsz3128);
      vector_subrange_lbits(&zgsz3128, zgsz3125, zgsz3126, zgsz3127);
      zgaz37 = CONVERT_OF(fbits, lbits)(zgsz3128, true);
      KILL(lbits)(&zgsz3128);
      KILL(sail_int)(&zgsz3127);
      KILL(sail_int)(&zgsz3126);
      KILL(lbits)(&zgsz3125);
    }
    {
      lbits zgsz3123;
      CREATE(lbits)(&zgsz3123);
      CONVERT_OF(lbits, fbits)(&zgsz3123, zgaz37, UINT64_C(8) , true);
      sail_int zgsz3124;
      CREATE(sail_int)(&zgsz3124);
      sail_unsigned(&zgsz3124, zgsz3123);
      zword_index = CONVERT_OF(mach_int, sail_int)(zgsz3124);
      KILL(sail_int)(&zgsz3124);
      KILL(lbits)(&zgsz3123);
    }
  }
  zz5vecz8z5bv8z9 zgaz36;
  CREATE(zz5vecz8z5bv8z9)(&zgaz36);
  {
    sail_int zgsz3130;
    CREATE(sail_int)(&zgsz3130);
    CONVERT_OF(sail_int, mach_int)(&zgsz3130, zpage_index);
    vector_access_zz5vecz8z5vecz8z5bv8z9z9(&zgaz36, zmain_mem, zgsz3130);
    KILL(sail_int)(&zgsz3130);
  }
  {
    sail_int zgsz3129;
    CREATE(sail_int)(&zgsz3129);
    CONVERT_OF(sail_int, mach_int)(&zgsz3129, zword_index);
    zcbz37 = vector_access_zz5vecz8z5bv8z9(zgaz36, zgsz3129);
    KILL(sail_int)(&zgsz3129);
  }
  KILL(zz5vecz8z5bv8z9)(&zgaz36);


end_function_49: ;
  return zcbz37;
end_block_exception_50: ;

  return UINT64_C(0xdeadc0de);
}

uint64_t zread_memory_zzp(uint64_t);

uint64_t zread_memory_zzp(uint64_t zaddr)
{
  __label__ end_function_52, end_block_exception_53;

  uint64_t zcbz38;
  uint64_t zgaz39;
  {
    lbits zgsz3131;
    CREATE(lbits)(&zgsz3131);
    CONVERT_OF(lbits, fbits)(&zgsz3131, UINT64_C(0x00), UINT64_C(8) , true);
    lbits zgsz3132;
    CREATE(lbits)(&zgsz3132);
    CONVERT_OF(lbits, fbits)(&zgsz3132, zaddr, UINT64_C(8) , true);
    lbits zgsz3133;
    CREATE(lbits)(&zgsz3133);
    append(&zgsz3133, zgsz3131, zgsz3132);
    zgaz39 = CONVERT_OF(fbits, lbits)(zgsz3133, true);
    KILL(lbits)(&zgsz3133);
    KILL(lbits)(&zgsz3132);
    KILL(lbits)(&zgsz3131);
  }
  zcbz38 = zread_memory(zgaz39);

end_function_52: ;
  return zcbz38;
end_block_exception_53: ;

  return UINT64_C(0xdeadc0de);
}

bool zexecute(struct zast);

bool zexecute(struct zast zmergez3var)
{
  __label__ case_56, case_57, case_58, case_59, case_60, case_61, case_62, case_63, case_64, finish_match_55, end_function_65, end_block_exception_66;

  bool zcbz39;
  /* Case with num_cases: 9 */
  bool zgsz330;
  {
    if (zmergez3var.kind != Kind_zINVALID) goto case_56;
    uint64_t zinstruction;
    zinstruction = zmergez3var.zINVALID;
    zgsz330 = false;
    goto finish_match_55;
  }
case_56: ;
  {
    if (zmergez3var.kind != Kind_zAND_IMM) goto case_57;
    uint64_t zop;
    zop = zmergez3var.zAND_IMM;
    uint64_t zresult;
    {
      uint64_t zgaz312;
      {
        uint64_t zgaz311;
        zgaz311 = zname_forwards(zA);
        zgaz312 = zread_register(zgaz311);
      }
      {
        lbits zgsz3134;
        CREATE(lbits)(&zgsz3134);
        CONVERT_OF(lbits, fbits)(&zgsz3134, zgaz312, UINT64_C(8) , true);
        lbits zgsz3135;
        CREATE(lbits)(&zgsz3135);
        CONVERT_OF(lbits, fbits)(&zgsz3135, zop, UINT64_C(8) , true);
        lbits zgsz3136;
        CREATE(lbits)(&zgsz3136);
        and_bits(&zgsz3136, zgsz3134, zgsz3135);
        zresult = CONVERT_OF(fbits, lbits)(zgsz3136, true);
        KILL(lbits)(&zgsz3136);
        KILL(lbits)(&zgsz3135);
        KILL(lbits)(&zgsz3134);
      }
    }
    {
      uint64_t zgaz310;
      zgaz310 = zname_forwards(zA);
      unit zgsz332;
      zgsz332 = zwrite_register(zgaz310, zresult);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_57: ;
  {
    if (zmergez3var.kind != Kind_zAND_ZP) goto case_58;
    uint64_t zuz30;
    zuz30 = zmergez3var.zAND_ZP;
    uint64_t zuz31;
    {
      uint64_t zgaz315;
      {
        uint64_t zgaz314;
        zgaz314 = zname_forwards(zA);
        zgaz315 = zread_register(zgaz314);
      }
      uint64_t zgaz316;
      zgaz316 = zread_memory_zzp(zuz30);
      {
        lbits zgsz3137;
        CREATE(lbits)(&zgsz3137);
        CONVERT_OF(lbits, fbits)(&zgsz3137, zgaz315, UINT64_C(8) , true);
        lbits zgsz3138;
        CREATE(lbits)(&zgsz3138);
        CONVERT_OF(lbits, fbits)(&zgsz3138, zgaz316, UINT64_C(8) , true);
        lbits zgsz3139;
        CREATE(lbits)(&zgsz3139);
        and_bits(&zgsz3139, zgsz3137, zgsz3138);
        zuz31 = CONVERT_OF(fbits, lbits)(zgsz3139, true);
        KILL(lbits)(&zgsz3139);
        KILL(lbits)(&zgsz3138);
        KILL(lbits)(&zgsz3137);
      }
    }
    {
      uint64_t zgaz313;
      zgaz313 = zname_forwards(zA);
      unit zgsz334;
      zgsz334 = zwrite_register(zgaz313, zuz31);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_58: ;
  {
    if (zmergez3var.kind != Kind_zAND_ZP_X) goto case_59;
    uint64_t zuz32;
    zuz32 = zmergez3var.zAND_ZP_X;
    uint64_t zea;
    {
      uint64_t zgaz322;
      {
        uint64_t zgaz321;
        zgaz321 = zname_forwards(zX);
        zgaz322 = zread_register(zgaz321);
      }
      {
        lbits zgsz3140;
        CREATE(lbits)(&zgsz3140);
        CONVERT_OF(lbits, fbits)(&zgsz3140, zuz32, UINT64_C(8) , true);
        lbits zgsz3141;
        CREATE(lbits)(&zgsz3141);
        CONVERT_OF(lbits, fbits)(&zgsz3141, zgaz322, UINT64_C(8) , true);
        lbits zgsz3142;
        CREATE(lbits)(&zgsz3142);
        add_bits(&zgsz3142, zgsz3140, zgsz3141);
        zea = CONVERT_OF(fbits, lbits)(zgsz3142, true);
        KILL(lbits)(&zgsz3142);
        KILL(lbits)(&zgsz3141);
        KILL(lbits)(&zgsz3140);
      }
    }
    uint64_t zuz33;
    {
      uint64_t zgaz319;
      {
        uint64_t zgaz318;
        zgaz318 = zname_forwards(zA);
        zgaz319 = zread_register(zgaz318);
      }
      uint64_t zgaz320;
      zgaz320 = zread_memory_zzp(zea);
      {
        lbits zgsz3143;
        CREATE(lbits)(&zgsz3143);
        CONVERT_OF(lbits, fbits)(&zgsz3143, zgaz319, UINT64_C(8) , true);
        lbits zgsz3144;
        CREATE(lbits)(&zgsz3144);
        CONVERT_OF(lbits, fbits)(&zgsz3144, zgaz320, UINT64_C(8) , true);
        lbits zgsz3145;
        CREATE(lbits)(&zgsz3145);
        and_bits(&zgsz3145, zgsz3143, zgsz3144);
        zuz33 = CONVERT_OF(fbits, lbits)(zgsz3145, true);
        KILL(lbits)(&zgsz3145);
        KILL(lbits)(&zgsz3144);
        KILL(lbits)(&zgsz3143);
      }
    }
    {
      uint64_t zgaz317;
      zgaz317 = zname_forwards(zA);
      unit zgsz336;
      zgsz336 = zwrite_register(zgaz317, zuz33);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_59: ;
  {
    if (zmergez3var.kind != Kind_zAND_ABS) goto case_60;
    uint64_t zuz34;
    zuz34 = zmergez3var.zAND_ABS;
    uint64_t zuz35;
    {
      uint64_t zgaz325;
      {
        uint64_t zgaz324;
        zgaz324 = zname_forwards(zA);
        zgaz325 = zread_register(zgaz324);
      }
      uint64_t zgaz326;
      zgaz326 = zread_memory(zuz34);
      {
        lbits zgsz3146;
        CREATE(lbits)(&zgsz3146);
        CONVERT_OF(lbits, fbits)(&zgsz3146, zgaz325, UINT64_C(8) , true);
        lbits zgsz3147;
        CREATE(lbits)(&zgsz3147);
        CONVERT_OF(lbits, fbits)(&zgsz3147, zgaz326, UINT64_C(8) , true);
        lbits zgsz3148;
        CREATE(lbits)(&zgsz3148);
        and_bits(&zgsz3148, zgsz3146, zgsz3147);
        zuz35 = CONVERT_OF(fbits, lbits)(zgsz3148, true);
        KILL(lbits)(&zgsz3148);
        KILL(lbits)(&zgsz3147);
        KILL(lbits)(&zgsz3146);
      }
    }
    {
      uint64_t zgaz323;
      zgaz323 = zname_forwards(zA);
      unit zgsz338;
      zgsz338 = zwrite_register(zgaz323, zuz35);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_60: ;
  {
    if (zmergez3var.kind != Kind_zAND_ABS_X) goto case_61;
    uint64_t zuz36;
    zuz36 = zmergez3var.zAND_ABS_X;
    uint64_t zuz37;
    {
      uint64_t zgaz337;
      {
        uint64_t zgaz336;
        {
          uint64_t zgaz335;
          zgaz335 = zname_forwards(zX);
          zgaz336 = zread_register(zgaz335);
        }
        {
          sail_int zgsz3149;
          CREATE(sail_int)(&zgsz3149);
          CONVERT_OF(sail_int, mach_int)(&zgsz3149, INT64_C(16));
          lbits zgsz3150;
          CREATE(lbits)(&zgsz3150);
          CONVERT_OF(lbits, fbits)(&zgsz3150, zgaz336, UINT64_C(8) , true);
          lbits zgsz3151;
          CREATE(lbits)(&zgsz3151);
          zEXTZ(&zgsz3151, zgsz3149, zgsz3150);
          zgaz337 = CONVERT_OF(fbits, lbits)(zgsz3151, true);
          KILL(lbits)(&zgsz3151);
          KILL(lbits)(&zgsz3150);
          KILL(sail_int)(&zgsz3149);
        }
      }
      {
        lbits zgsz3152;
        CREATE(lbits)(&zgsz3152);
        CONVERT_OF(lbits, fbits)(&zgsz3152, zuz36, UINT64_C(16) , true);
        lbits zgsz3153;
        CREATE(lbits)(&zgsz3153);
        CONVERT_OF(lbits, fbits)(&zgsz3153, zgaz337, UINT64_C(16) , true);
        lbits zgsz3154;
        CREATE(lbits)(&zgsz3154);
        add_bits(&zgsz3154, zgsz3152, zgsz3153);
        zuz37 = CONVERT_OF(fbits, lbits)(zgsz3154, true);
        KILL(lbits)(&zgsz3154);
        KILL(lbits)(&zgsz3153);
        KILL(lbits)(&zgsz3152);
      }
    }
    uint64_t zuz38;
    {
      uint64_t zgaz333;
      {
        uint64_t zgaz332;
        zgaz332 = zname_forwards(zA);
        zgaz333 = zread_register(zgaz332);
      }
      uint64_t zgaz334;
      zgaz334 = zread_memory(zuz37);
      {
        lbits zgsz3155;
        CREATE(lbits)(&zgsz3155);
        CONVERT_OF(lbits, fbits)(&zgsz3155, zgaz333, UINT64_C(8) , true);
        lbits zgsz3156;
        CREATE(lbits)(&zgsz3156);
        CONVERT_OF(lbits, fbits)(&zgsz3156, zgaz334, UINT64_C(8) , true);
        lbits zgsz3157;
        CREATE(lbits)(&zgsz3157);
        and_bits(&zgsz3157, zgsz3155, zgsz3156);
        zuz38 = CONVERT_OF(fbits, lbits)(zgsz3157, true);
        KILL(lbits)(&zgsz3157);
        KILL(lbits)(&zgsz3156);
        KILL(lbits)(&zgsz3155);
      }
    }
    {
      bool zgaz329;
      {
        uint64_t zgaz327;
        {
          lbits zgsz3164;
          CREATE(lbits)(&zgsz3164);
          CONVERT_OF(lbits, fbits)(&zgsz3164, zuz36, UINT64_C(16) , true);
          sail_int zgsz3165;
          CREATE(sail_int)(&zgsz3165);
          CONVERT_OF(sail_int, mach_int)(&zgsz3165, INT64_C(15));
          sail_int zgsz3166;
          CREATE(sail_int)(&zgsz3166);
          CONVERT_OF(sail_int, mach_int)(&zgsz3166, INT64_C(8));
          lbits zgsz3167;
          CREATE(lbits)(&zgsz3167);
          vector_subrange_lbits(&zgsz3167, zgsz3164, zgsz3165, zgsz3166);
          zgaz327 = CONVERT_OF(fbits, lbits)(zgsz3167, true);
          KILL(lbits)(&zgsz3167);
          KILL(sail_int)(&zgsz3166);
          KILL(sail_int)(&zgsz3165);
          KILL(lbits)(&zgsz3164);
        }
        uint64_t zgaz328;
        {
          lbits zgsz3160;
          CREATE(lbits)(&zgsz3160);
          CONVERT_OF(lbits, fbits)(&zgsz3160, zuz37, UINT64_C(16) , true);
          sail_int zgsz3161;
          CREATE(sail_int)(&zgsz3161);
          CONVERT_OF(sail_int, mach_int)(&zgsz3161, INT64_C(15));
          sail_int zgsz3162;
          CREATE(sail_int)(&zgsz3162);
          CONVERT_OF(sail_int, mach_int)(&zgsz3162, INT64_C(8));
          lbits zgsz3163;
          CREATE(lbits)(&zgsz3163);
          vector_subrange_lbits(&zgsz3163, zgsz3160, zgsz3161, zgsz3162);
          zgaz328 = CONVERT_OF(fbits, lbits)(zgsz3163, true);
          KILL(lbits)(&zgsz3163);
          KILL(sail_int)(&zgsz3162);
          KILL(sail_int)(&zgsz3161);
          KILL(lbits)(&zgsz3160);
        }
        {
          lbits zgsz3158;
          CREATE(lbits)(&zgsz3158);
          CONVERT_OF(lbits, fbits)(&zgsz3158, zgaz327, UINT64_C(8) , true);
          lbits zgsz3159;
          CREATE(lbits)(&zgsz3159);
          CONVERT_OF(lbits, fbits)(&zgsz3159, zgaz328, UINT64_C(8) , true);
          zgaz329 = neq_bits(zgsz3158, zgsz3159);
          KILL(lbits)(&zgsz3159);
          KILL(lbits)(&zgsz3158);
        }
      }
      unit zgsz341;
      if (zgaz329) {
        uint64_t zgaz330;
        {
          lbits zgsz3169;
          CREATE(lbits)(&zgsz3169);
          CONVERT_OF(lbits, fbits)(&zgsz3169, zuz37, UINT64_C(16) , true);
          sail_int zgsz3170;
          CREATE(sail_int)(&zgsz3170);
          CONVERT_OF(sail_int, mach_int)(&zgsz3170, INT64_C(15));
          sail_int zgsz3171;
          CREATE(sail_int)(&zgsz3171);
          CONVERT_OF(sail_int, mach_int)(&zgsz3171, INT64_C(8));
          lbits zgsz3172;
          CREATE(lbits)(&zgsz3172);
          vector_subrange_lbits(&zgsz3172, zgsz3169, zgsz3170, zgsz3171);
          zgaz330 = CONVERT_OF(fbits, lbits)(zgsz3172, true);
          KILL(lbits)(&zgsz3172);
          KILL(sail_int)(&zgsz3171);
          KILL(sail_int)(&zgsz3170);
          KILL(lbits)(&zgsz3169);
        }
        {
          lbits zgsz3168;
          CREATE(lbits)(&zgsz3168);
          CONVERT_OF(lbits, fbits)(&zgsz3168, zgaz330, UINT64_C(8) , true);
          zgsz341 = print_bits("page boundary crossed, now in page: ", zgsz3168);
          KILL(lbits)(&zgsz3168);
        }
      } else {  zgsz341 = UNIT;  }
    }
    {
      uint64_t zgaz331;
      zgaz331 = zname_forwards(zA);
      unit zgsz340;
      zgsz340 = zwrite_register(zgaz331, zuz38);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_61: ;
  {
    if (zmergez3var.kind != Kind_zAND_ABS_Y) goto case_62;
    uint64_t zuz39;
    zuz39 = zmergez3var.zAND_ABS_Y;
    uint64_t zuz310;
    {
      uint64_t zgaz348;
      {
        uint64_t zgaz347;
        {
          uint64_t zgaz346;
          zgaz346 = zname_forwards(zY);
          zgaz347 = zread_register(zgaz346);
        }
        {
          sail_int zgsz3173;
          CREATE(sail_int)(&zgsz3173);
          CONVERT_OF(sail_int, mach_int)(&zgsz3173, INT64_C(16));
          lbits zgsz3174;
          CREATE(lbits)(&zgsz3174);
          CONVERT_OF(lbits, fbits)(&zgsz3174, zgaz347, UINT64_C(8) , true);
          lbits zgsz3175;
          CREATE(lbits)(&zgsz3175);
          zEXTZ(&zgsz3175, zgsz3173, zgsz3174);
          zgaz348 = CONVERT_OF(fbits, lbits)(zgsz3175, true);
          KILL(lbits)(&zgsz3175);
          KILL(lbits)(&zgsz3174);
          KILL(sail_int)(&zgsz3173);
        }
      }
      {
        lbits zgsz3176;
        CREATE(lbits)(&zgsz3176);
        CONVERT_OF(lbits, fbits)(&zgsz3176, zuz39, UINT64_C(16) , true);
        lbits zgsz3177;
        CREATE(lbits)(&zgsz3177);
        CONVERT_OF(lbits, fbits)(&zgsz3177, zgaz348, UINT64_C(16) , true);
        lbits zgsz3178;
        CREATE(lbits)(&zgsz3178);
        add_bits(&zgsz3178, zgsz3176, zgsz3177);
        zuz310 = CONVERT_OF(fbits, lbits)(zgsz3178, true);
        KILL(lbits)(&zgsz3178);
        KILL(lbits)(&zgsz3177);
        KILL(lbits)(&zgsz3176);
      }
    }
    uint64_t zuz311;
    {
      uint64_t zgaz344;
      {
        uint64_t zgaz343;
        zgaz343 = zname_forwards(zA);
        zgaz344 = zread_register(zgaz343);
      }
      uint64_t zgaz345;
      zgaz345 = zread_memory(zuz310);
      {
        lbits zgsz3179;
        CREATE(lbits)(&zgsz3179);
        CONVERT_OF(lbits, fbits)(&zgsz3179, zgaz344, UINT64_C(8) , true);
        lbits zgsz3180;
        CREATE(lbits)(&zgsz3180);
        CONVERT_OF(lbits, fbits)(&zgsz3180, zgaz345, UINT64_C(8) , true);
        lbits zgsz3181;
        CREATE(lbits)(&zgsz3181);
        and_bits(&zgsz3181, zgsz3179, zgsz3180);
        zuz311 = CONVERT_OF(fbits, lbits)(zgsz3181, true);
        KILL(lbits)(&zgsz3181);
        KILL(lbits)(&zgsz3180);
        KILL(lbits)(&zgsz3179);
      }
    }
    {
      bool zgaz340;
      {
        uint64_t zgaz338;
        {
          lbits zgsz3188;
          CREATE(lbits)(&zgsz3188);
          CONVERT_OF(lbits, fbits)(&zgsz3188, zuz39, UINT64_C(16) , true);
          sail_int zgsz3189;
          CREATE(sail_int)(&zgsz3189);
          CONVERT_OF(sail_int, mach_int)(&zgsz3189, INT64_C(15));
          sail_int zgsz3190;
          CREATE(sail_int)(&zgsz3190);
          CONVERT_OF(sail_int, mach_int)(&zgsz3190, INT64_C(8));
          lbits zgsz3191;
          CREATE(lbits)(&zgsz3191);
          vector_subrange_lbits(&zgsz3191, zgsz3188, zgsz3189, zgsz3190);
          zgaz338 = CONVERT_OF(fbits, lbits)(zgsz3191, true);
          KILL(lbits)(&zgsz3191);
          KILL(sail_int)(&zgsz3190);
          KILL(sail_int)(&zgsz3189);
          KILL(lbits)(&zgsz3188);
        }
        uint64_t zgaz339;
        {
          lbits zgsz3184;
          CREATE(lbits)(&zgsz3184);
          CONVERT_OF(lbits, fbits)(&zgsz3184, zuz310, UINT64_C(16) , true);
          sail_int zgsz3185;
          CREATE(sail_int)(&zgsz3185);
          CONVERT_OF(sail_int, mach_int)(&zgsz3185, INT64_C(15));
          sail_int zgsz3186;
          CREATE(sail_int)(&zgsz3186);
          CONVERT_OF(sail_int, mach_int)(&zgsz3186, INT64_C(8));
          lbits zgsz3187;
          CREATE(lbits)(&zgsz3187);
          vector_subrange_lbits(&zgsz3187, zgsz3184, zgsz3185, zgsz3186);
          zgaz339 = CONVERT_OF(fbits, lbits)(zgsz3187, true);
          KILL(lbits)(&zgsz3187);
          KILL(sail_int)(&zgsz3186);
          KILL(sail_int)(&zgsz3185);
          KILL(lbits)(&zgsz3184);
        }
        {
          lbits zgsz3182;
          CREATE(lbits)(&zgsz3182);
          CONVERT_OF(lbits, fbits)(&zgsz3182, zgaz338, UINT64_C(8) , true);
          lbits zgsz3183;
          CREATE(lbits)(&zgsz3183);
          CONVERT_OF(lbits, fbits)(&zgsz3183, zgaz339, UINT64_C(8) , true);
          zgaz340 = neq_bits(zgsz3182, zgsz3183);
          KILL(lbits)(&zgsz3183);
          KILL(lbits)(&zgsz3182);
        }
      }
      unit zgsz344;
      if (zgaz340) {
        uint64_t zgaz341;
        {
          lbits zgsz3193;
          CREATE(lbits)(&zgsz3193);
          CONVERT_OF(lbits, fbits)(&zgsz3193, zuz310, UINT64_C(16) , true);
          sail_int zgsz3194;
          CREATE(sail_int)(&zgsz3194);
          CONVERT_OF(sail_int, mach_int)(&zgsz3194, INT64_C(15));
          sail_int zgsz3195;
          CREATE(sail_int)(&zgsz3195);
          CONVERT_OF(sail_int, mach_int)(&zgsz3195, INT64_C(8));
          lbits zgsz3196;
          CREATE(lbits)(&zgsz3196);
          vector_subrange_lbits(&zgsz3196, zgsz3193, zgsz3194, zgsz3195);
          zgaz341 = CONVERT_OF(fbits, lbits)(zgsz3196, true);
          KILL(lbits)(&zgsz3196);
          KILL(sail_int)(&zgsz3195);
          KILL(sail_int)(&zgsz3194);
          KILL(lbits)(&zgsz3193);
        }
        {
          lbits zgsz3192;
          CREATE(lbits)(&zgsz3192);
          CONVERT_OF(lbits, fbits)(&zgsz3192, zgaz341, UINT64_C(8) , true);
          zgsz344 = print_bits("page boundary crossed, now in page: ", zgsz3192);
          KILL(lbits)(&zgsz3192);
        }
      } else {  zgsz344 = UNIT;  }
    }
    {
      uint64_t zgaz342;
      zgaz342 = zname_forwards(zA);
      unit zgsz343;
      zgsz343 = zwrite_register(zgaz342, zuz311);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_62: ;
  {
    if (zmergez3var.kind != Kind_zAND_IND_X) goto case_63;
    uint64_t zuz312;
    zuz312 = zmergez3var.zAND_IND_X;
    uint64_t zuz313;
    {
      uint64_t zgaz357;
      {
        uint64_t zgaz356;
        zgaz356 = zname_forwards(zX);
        zgaz357 = zread_register(zgaz356);
      }
      {
        lbits zgsz3197;
        CREATE(lbits)(&zgsz3197);
        CONVERT_OF(lbits, fbits)(&zgsz3197, zuz312, UINT64_C(8) , true);
        lbits zgsz3198;
        CREATE(lbits)(&zgsz3198);
        CONVERT_OF(lbits, fbits)(&zgsz3198, zgaz357, UINT64_C(8) , true);
        lbits zgsz3199;
        CREATE(lbits)(&zgsz3199);
        add_bits(&zgsz3199, zgsz3197, zgsz3198);
        zuz313 = CONVERT_OF(fbits, lbits)(zgsz3199, true);
        KILL(lbits)(&zgsz3199);
        KILL(lbits)(&zgsz3198);
        KILL(lbits)(&zgsz3197);
      }
    }
    uint64_t zpointer;
    {
      uint64_t zgaz354;
      {
        uint64_t zgaz353;
        {
          lbits zgsz3200;
          CREATE(lbits)(&zgsz3200);
          CONVERT_OF(lbits, fbits)(&zgsz3200, zuz313, UINT64_C(8) , true);
          sail_int zgsz3201;
          CREATE(sail_int)(&zgsz3201);
          CONVERT_OF(sail_int, mach_int)(&zgsz3201, INT64_C(1));
          lbits zgsz3202;
          CREATE(lbits)(&zgsz3202);
          add_bits_int(&zgsz3202, zgsz3200, zgsz3201);
          zgaz353 = CONVERT_OF(fbits, lbits)(zgsz3202, true);
          KILL(lbits)(&zgsz3202);
          KILL(sail_int)(&zgsz3201);
          KILL(lbits)(&zgsz3200);
        }
        zgaz354 = zread_memory_zzp(zgaz353);
      }
      uint64_t zgaz355;
      zgaz355 = zread_memory_zzp(zuz313);
      {
        lbits zgsz3203;
        CREATE(lbits)(&zgsz3203);
        CONVERT_OF(lbits, fbits)(&zgsz3203, zgaz354, UINT64_C(8) , true);
        lbits zgsz3204;
        CREATE(lbits)(&zgsz3204);
        CONVERT_OF(lbits, fbits)(&zgsz3204, zgaz355, UINT64_C(8) , true);
        lbits zgsz3205;
        CREATE(lbits)(&zgsz3205);
        append(&zgsz3205, zgsz3203, zgsz3204);
        zpointer = CONVERT_OF(fbits, lbits)(zgsz3205, true);
        KILL(lbits)(&zgsz3205);
        KILL(lbits)(&zgsz3204);
        KILL(lbits)(&zgsz3203);
      }
    }
    uint64_t zuz314;
    {
      uint64_t zgaz351;
      {
        uint64_t zgaz350;
        zgaz350 = zname_forwards(zA);
        zgaz351 = zread_register(zgaz350);
      }
      uint64_t zgaz352;
      zgaz352 = zread_memory(zpointer);
      {
        lbits zgsz3206;
        CREATE(lbits)(&zgsz3206);
        CONVERT_OF(lbits, fbits)(&zgsz3206, zgaz351, UINT64_C(8) , true);
        lbits zgsz3207;
        CREATE(lbits)(&zgsz3207);
        CONVERT_OF(lbits, fbits)(&zgsz3207, zgaz352, UINT64_C(8) , true);
        lbits zgsz3208;
        CREATE(lbits)(&zgsz3208);
        and_bits(&zgsz3208, zgsz3206, zgsz3207);
        zuz314 = CONVERT_OF(fbits, lbits)(zgsz3208, true);
        KILL(lbits)(&zgsz3208);
        KILL(lbits)(&zgsz3207);
        KILL(lbits)(&zgsz3206);
      }
    }
    {
      uint64_t zgaz349;
      zgaz349 = zname_forwards(zA);
      unit zgsz346;
      zgsz346 = zwrite_register(zgaz349, zuz314);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_63: ;
  {
    if (zmergez3var.kind != Kind_zAND_IND_Y) goto case_64;
    uint64_t zuz315;
    zuz315 = zmergez3var.zAND_IND_Y;
    uint64_t zuz316;
    {
      uint64_t zgaz370;
      {
        uint64_t zgaz369;
        {
          lbits zgsz3209;
          CREATE(lbits)(&zgsz3209);
          CONVERT_OF(lbits, fbits)(&zgsz3209, zuz315, UINT64_C(8) , true);
          sail_int zgsz3210;
          CREATE(sail_int)(&zgsz3210);
          CONVERT_OF(sail_int, mach_int)(&zgsz3210, INT64_C(1));
          lbits zgsz3211;
          CREATE(lbits)(&zgsz3211);
          add_bits_int(&zgsz3211, zgsz3209, zgsz3210);
          zgaz369 = CONVERT_OF(fbits, lbits)(zgsz3211, true);
          KILL(lbits)(&zgsz3211);
          KILL(sail_int)(&zgsz3210);
          KILL(lbits)(&zgsz3209);
        }
        zgaz370 = zread_memory_zzp(zgaz369);
      }
      uint64_t zgaz371;
      zgaz371 = zread_memory_zzp(zuz315);
      {
        lbits zgsz3212;
        CREATE(lbits)(&zgsz3212);
        CONVERT_OF(lbits, fbits)(&zgsz3212, zgaz370, UINT64_C(8) , true);
        lbits zgsz3213;
        CREATE(lbits)(&zgsz3213);
        CONVERT_OF(lbits, fbits)(&zgsz3213, zgaz371, UINT64_C(8) , true);
        lbits zgsz3214;
        CREATE(lbits)(&zgsz3214);
        append(&zgsz3214, zgsz3212, zgsz3213);
        zuz316 = CONVERT_OF(fbits, lbits)(zgsz3214, true);
        KILL(lbits)(&zgsz3214);
        KILL(lbits)(&zgsz3213);
        KILL(lbits)(&zgsz3212);
      }
    }
    uint64_t zuz317;
    {
      uint64_t zgaz368;
      {
        uint64_t zgaz367;
        {
          uint64_t zgaz366;
          zgaz366 = zname_forwards(zY);
          zgaz367 = zread_register(zgaz366);
        }
        {
          sail_int zgsz3215;
          CREATE(sail_int)(&zgsz3215);
          CONVERT_OF(sail_int, mach_int)(&zgsz3215, INT64_C(16));
          lbits zgsz3216;
          CREATE(lbits)(&zgsz3216);
          CONVERT_OF(lbits, fbits)(&zgsz3216, zgaz367, UINT64_C(8) , true);
          lbits zgsz3217;
          CREATE(lbits)(&zgsz3217);
          zEXTZ(&zgsz3217, zgsz3215, zgsz3216);
          zgaz368 = CONVERT_OF(fbits, lbits)(zgsz3217, true);
          KILL(lbits)(&zgsz3217);
          KILL(lbits)(&zgsz3216);
          KILL(sail_int)(&zgsz3215);
        }
      }
      {
        lbits zgsz3218;
        CREATE(lbits)(&zgsz3218);
        CONVERT_OF(lbits, fbits)(&zgsz3218, zuz316, UINT64_C(16) , true);
        lbits zgsz3219;
        CREATE(lbits)(&zgsz3219);
        CONVERT_OF(lbits, fbits)(&zgsz3219, zgaz368, UINT64_C(16) , true);
        lbits zgsz3220;
        CREATE(lbits)(&zgsz3220);
        add_bits(&zgsz3220, zgsz3218, zgsz3219);
        zuz317 = CONVERT_OF(fbits, lbits)(zgsz3220, true);
        KILL(lbits)(&zgsz3220);
        KILL(lbits)(&zgsz3219);
        KILL(lbits)(&zgsz3218);
      }
    }
    {
      bool zgaz360;
      {
        uint64_t zgaz358;
        {
          lbits zgsz3227;
          CREATE(lbits)(&zgsz3227);
          CONVERT_OF(lbits, fbits)(&zgsz3227, zuz316, UINT64_C(16) , true);
          sail_int zgsz3228;
          CREATE(sail_int)(&zgsz3228);
          CONVERT_OF(sail_int, mach_int)(&zgsz3228, INT64_C(15));
          sail_int zgsz3229;
          CREATE(sail_int)(&zgsz3229);
          CONVERT_OF(sail_int, mach_int)(&zgsz3229, INT64_C(8));
          lbits zgsz3230;
          CREATE(lbits)(&zgsz3230);
          vector_subrange_lbits(&zgsz3230, zgsz3227, zgsz3228, zgsz3229);
          zgaz358 = CONVERT_OF(fbits, lbits)(zgsz3230, true);
          KILL(lbits)(&zgsz3230);
          KILL(sail_int)(&zgsz3229);
          KILL(sail_int)(&zgsz3228);
          KILL(lbits)(&zgsz3227);
        }
        uint64_t zgaz359;
        {
          lbits zgsz3223;
          CREATE(lbits)(&zgsz3223);
          CONVERT_OF(lbits, fbits)(&zgsz3223, zuz317, UINT64_C(16) , true);
          sail_int zgsz3224;
          CREATE(sail_int)(&zgsz3224);
          CONVERT_OF(sail_int, mach_int)(&zgsz3224, INT64_C(15));
          sail_int zgsz3225;
          CREATE(sail_int)(&zgsz3225);
          CONVERT_OF(sail_int, mach_int)(&zgsz3225, INT64_C(8));
          lbits zgsz3226;
          CREATE(lbits)(&zgsz3226);
          vector_subrange_lbits(&zgsz3226, zgsz3223, zgsz3224, zgsz3225);
          zgaz359 = CONVERT_OF(fbits, lbits)(zgsz3226, true);
          KILL(lbits)(&zgsz3226);
          KILL(sail_int)(&zgsz3225);
          KILL(sail_int)(&zgsz3224);
          KILL(lbits)(&zgsz3223);
        }
        {
          lbits zgsz3221;
          CREATE(lbits)(&zgsz3221);
          CONVERT_OF(lbits, fbits)(&zgsz3221, zgaz358, UINT64_C(8) , true);
          lbits zgsz3222;
          CREATE(lbits)(&zgsz3222);
          CONVERT_OF(lbits, fbits)(&zgsz3222, zgaz359, UINT64_C(8) , true);
          zgaz360 = neq_bits(zgsz3221, zgsz3222);
          KILL(lbits)(&zgsz3222);
          KILL(lbits)(&zgsz3221);
        }
      }
      unit zgsz348;
      if (zgaz360) {
        uint64_t zgaz361;
        {
          lbits zgsz3232;
          CREATE(lbits)(&zgsz3232);
          CONVERT_OF(lbits, fbits)(&zgsz3232, zuz317, UINT64_C(16) , true);
          sail_int zgsz3233;
          CREATE(sail_int)(&zgsz3233);
          CONVERT_OF(sail_int, mach_int)(&zgsz3233, INT64_C(15));
          sail_int zgsz3234;
          CREATE(sail_int)(&zgsz3234);
          CONVERT_OF(sail_int, mach_int)(&zgsz3234, INT64_C(8));
          lbits zgsz3235;
          CREATE(lbits)(&zgsz3235);
          vector_subrange_lbits(&zgsz3235, zgsz3232, zgsz3233, zgsz3234);
          zgaz361 = CONVERT_OF(fbits, lbits)(zgsz3235, true);
          KILL(lbits)(&zgsz3235);
          KILL(sail_int)(&zgsz3234);
          KILL(sail_int)(&zgsz3233);
          KILL(lbits)(&zgsz3232);
        }
        {
          lbits zgsz3231;
          CREATE(lbits)(&zgsz3231);
          CONVERT_OF(lbits, fbits)(&zgsz3231, zgaz361, UINT64_C(8) , true);
          zgsz348 = print_bits("page boundary crossed, now in page: ", zgsz3231);
          KILL(lbits)(&zgsz3231);
        }
      } else {  zgsz348 = UNIT;  }
    }
    uint64_t zuz318;
    {
      uint64_t zgaz364;
      {
        uint64_t zgaz363;
        zgaz363 = zname_forwards(zA);
        zgaz364 = zread_register(zgaz363);
      }
      uint64_t zgaz365;
      zgaz365 = zread_memory(zuz317);
      {
        lbits zgsz3236;
        CREATE(lbits)(&zgsz3236);
        CONVERT_OF(lbits, fbits)(&zgsz3236, zgaz364, UINT64_C(8) , true);
        lbits zgsz3237;
        CREATE(lbits)(&zgsz3237);
        CONVERT_OF(lbits, fbits)(&zgsz3237, zgaz365, UINT64_C(8) , true);
        lbits zgsz3238;
        CREATE(lbits)(&zgsz3238);
        and_bits(&zgsz3238, zgsz3236, zgsz3237);
        zuz318 = CONVERT_OF(fbits, lbits)(zgsz3238, true);
        KILL(lbits)(&zgsz3238);
        KILL(lbits)(&zgsz3237);
        KILL(lbits)(&zgsz3236);
      }
    }
    {
      uint64_t zgaz362;
      zgaz362 = zname_forwards(zA);
      unit zgsz349;
      zgsz349 = zwrite_register(zgaz362, zuz318);
    }
    zgsz330 = true;
    goto finish_match_55;
  }
case_64: ;
  sail_match_failure("execute");
finish_match_55: ;
  zcbz39 = zgsz330;

end_function_65: ;
  return zcbz39;
end_block_exception_66: ;

  return false;
}

unit zmain(unit);

unit zmain(unit zgsz351)
{
  __label__ end_function_68, end_block_exception_69;

  unit zcbz310;
  uint64_t zgaz372;
  zgaz372 = zname_forwards(zA);
  zcbz310 = zwrite_register(zgaz372, UINT64_C(0x0A));

end_function_68: ;
  return zcbz310;
end_block_exception_69: ;

  return UNIT;
}

unit zinitializze_registers(unit);

unit zinitializze_registers(unit zgsz352)
{
  __label__ end_function_71, end_block_exception_72;

  unit zcbz311;
  {
    {
      sail_int zgsz3239;
      CREATE(sail_int)(&zgsz3239);
      CONVERT_OF(sail_int, mach_int)(&zgsz3239, INT64_C(16));
      lbits zgsz3240;
      CREATE(lbits)(&zgsz3240);
      UNDEFINED(lbits)(&zgsz3240, zgsz3239);
      zreg_PC = CONVERT_OF(fbits, lbits)(zgsz3240, true);
      KILL(lbits)(&zgsz3240);
      KILL(sail_int)(&zgsz3239);
    }
    unit zgsz357;
    zgsz357 = UNIT;
  }
  {
    {
      sail_int zgsz3241;
      CREATE(sail_int)(&zgsz3241);
      CONVERT_OF(sail_int, mach_int)(&zgsz3241, INT64_C(8));
      lbits zgsz3242;
      CREATE(lbits)(&zgsz3242);
      UNDEFINED(lbits)(&zgsz3242, zgsz3241);
      zreg_A = CONVERT_OF(fbits, lbits)(zgsz3242, true);
      KILL(lbits)(&zgsz3242);
      KILL(sail_int)(&zgsz3241);
    }
    unit zgsz356;
    zgsz356 = UNIT;
  }
  {
    {
      sail_int zgsz3243;
      CREATE(sail_int)(&zgsz3243);
      CONVERT_OF(sail_int, mach_int)(&zgsz3243, INT64_C(8));
      lbits zgsz3244;
      CREATE(lbits)(&zgsz3244);
      UNDEFINED(lbits)(&zgsz3244, zgsz3243);
      zreg_X = CONVERT_OF(fbits, lbits)(zgsz3244, true);
      KILL(lbits)(&zgsz3244);
      KILL(sail_int)(&zgsz3243);
    }
    unit zgsz355;
    zgsz355 = UNIT;
  }
  {
    {
      sail_int zgsz3245;
      CREATE(sail_int)(&zgsz3245);
      CONVERT_OF(sail_int, mach_int)(&zgsz3245, INT64_C(8));
      lbits zgsz3246;
      CREATE(lbits)(&zgsz3246);
      UNDEFINED(lbits)(&zgsz3246, zgsz3245);
      zreg_Y = CONVERT_OF(fbits, lbits)(zgsz3246, true);
      KILL(lbits)(&zgsz3246);
      KILL(sail_int)(&zgsz3245);
    }
    unit zgsz354;
    zgsz354 = UNIT;
  }
  {
    zreg_SR = zundefined_flags(UNIT);
    unit zgsz353;
    zgsz353 = UNIT;
  }
  {
    sail_int zgsz3247;
    CREATE(sail_int)(&zgsz3247);
    CONVERT_OF(sail_int, mach_int)(&zgsz3247, INT64_C(8));
    lbits zgsz3248;
    CREATE(lbits)(&zgsz3248);
    UNDEFINED(lbits)(&zgsz3248, zgsz3247);
    zreg_SP = CONVERT_OF(fbits, lbits)(zgsz3248, true);
    KILL(lbits)(&zgsz3248);
    KILL(sail_int)(&zgsz3247);
  }
  zcbz311 = UNIT;
end_function_71: ;
  return zcbz311;
end_block_exception_72: ;

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
  CREATE(zz5vecz8z5vecz8z5bv8z9z9)(&zmain_mem);
  zz5vecz8z5bv8z9 zgaz35;
  CREATE(zz5vecz8z5bv8z9)(&zgaz35);
  {
    sail_int zgsz3116;
    CREATE(sail_int)(&zgsz3116);
    CONVERT_OF(sail_int, mach_int)(&zgsz3116, INT64_C(256));
    vector_init_zz5vecz8z5bv8z9(&zgaz35, zgsz3116, UINT64_C(0x00));
    KILL(sail_int)(&zgsz3116);
  }
  {
    sail_int zgsz3115;
    CREATE(sail_int)(&zgsz3115);
    CONVERT_OF(sail_int, mach_int)(&zgsz3115, INT64_C(256));
    vector_init_zz5vecz8z5vecz8z5bv8z9z9(&zmain_mem, zgsz3115, zgaz35);
    KILL(sail_int)(&zgsz3115);
  }
  KILL(zz5vecz8z5bv8z9)(&zgaz35);
  zinitializze_registers(UNIT);
}

void model_fini(void)
{
  kill_letbind_2();
  kill_letbind_1();
  kill_letbind_0();
  KILL(zz5vecz8z5vecz8z5bv8z9z9)(&zmain_mem);
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
