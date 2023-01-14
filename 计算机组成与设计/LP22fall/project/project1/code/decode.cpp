// Copyright 2020 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <cfenv>
#include <cmath>
#include "Hart.hpp"
#include "instforms.hpp"
#include "DecodedInst.hpp"


using namespace WdRiscv;


template <typename URV>
void
Hart<URV>::decode(URV addr, uint32_t inst, DecodedInst& di)
{
  uint32_t op0 = 0, op1 = 0, op2 = 0, op3 = 0;

  const InstEntry& entry = decode(inst, op0, op1, op2, op3);

  di.reset(addr, inst, &entry, op0, op1, op2, op3);

  // Set the mask bit for vector instructions.
  if (di.instEntry() and di.instEntry()->isVector())
    {
      bool masked = ((inst >> 25) & 1) == 0;  // Bit 25 of instruction
      di.setMasked(masked);
    }
}


template <typename URV>
const InstEntry&
Hart<URV>::decodeFp(uint32_t inst, uint32_t& op0, uint32_t& op1, uint32_t& op2,
		    uint32_t& op3)
{
  RFormInst rform(inst);

  op0 = rform.bits.rd, op1 = rform.bits.rs1, op2 = rform.bits.rs2;

  unsigned f7 = rform.bits.funct7, f3 = rform.bits.funct3;

  op3 = f7 >> 2;  // For 4-operand instructions.

  if (f7 & 1)
    {
      if (f7 == 1)              return instTable_.getEntry(InstId::fadd_d);
      if (f7 == 5)              return instTable_.getEntry(InstId::fsub_d);
      if (f7 == 9)              return instTable_.getEntry(InstId::fmul_d);
      if (f7 == 0xd)            return instTable_.getEntry(InstId::fdiv_d);
      if (f7 == 0x11)
	{
	  if (f3 == 0)          return instTable_.getEntry(InstId::fsgnj_d);
	  if (f3 == 1)          return instTable_.getEntry(InstId::fsgnjn_d);
	  if (f3 == 2)          return instTable_.getEntry(InstId::fsgnjx_d);
	}
      if (f7 == 0x15)
	{
	  if (f3 == 0)          return instTable_.getEntry(InstId::fmin_d);
	  if (f3 == 1)          return instTable_.getEntry(InstId::fmax_d);
	}
      if (f7==0x21 and op2==0)  return instTable_.getEntry(InstId::fcvt_d_s);
      if (f7 == 0x2d)           return instTable_.getEntry(InstId::fsqrt_d);
      if (f7 == 0x51)
	{
	  if (f3 == 0)          return instTable_.getEntry(InstId::fle_d);
	  if (f3 == 1)          return instTable_.getEntry(InstId::flt_d);
	  if (f3 == 2)          return instTable_.getEntry(InstId::feq_d);
	}
      if (f7 == 0x61)
	{
	  if (op2 == 0)         return instTable_.getEntry(InstId::fcvt_w_d);
	  if (op2 == 1)         return instTable_.getEntry(InstId::fcvt_wu_d);
	  if (op2 == 2)         return instTable_.getEntry(InstId::fcvt_l_d);
	  if (op2 == 3)         return instTable_.getEntry(InstId::fcvt_lu_d);
	}
      if (f7 == 0x69)
	{
	  if (op2 == 0)         return instTable_.getEntry(InstId::fcvt_d_w);
	  if (op2 == 1)         return instTable_.getEntry(InstId::fcvt_d_wu);
	  if (op2 == 2)         return instTable_.getEntry(InstId::fcvt_d_l);
	  if (op2 == 3)         return instTable_.getEntry(InstId::fcvt_d_lu);
	}
      if (f7 == 0x71)
	{
	  if (op2==0 and f3==0) return instTable_.getEntry(InstId::fmv_x_d);
	  if (op2==0 and f3==1) return instTable_.getEntry(InstId::fclass_d);
	}
      if (f7 == 0x79)
	if (op2==0 and f3==0)   return instTable_.getEntry(InstId::fmv_d_x);

      return instTable_.getEntry(InstId::illegal);
    }

  if (f7 == 0)      return instTable_.getEntry(InstId::fadd_s);
  if (f7 == 4)      return instTable_.getEntry(InstId::fsub_s);
  if (f7 == 8)      return instTable_.getEntry(InstId::fmul_s);
  if (f7 == 0xc)    return instTable_.getEntry(InstId::fdiv_s);
  if (f7 == 0x2c)   return instTable_.getEntry(InstId::fsqrt_s);
  if (f7 == 0x10)
    {
      if (f3 == 0)  return instTable_.getEntry(InstId::fsgnj_s);
      if (f3 == 1)  return instTable_.getEntry(InstId::fsgnjn_s);
      if (f3 == 2)  return instTable_.getEntry(InstId::fsgnjx_s);
    }
  if (f7 == 0x14)
    {
      if (f3 == 0)  return instTable_.getEntry(InstId::fmin_s);
      if (f3 == 1)  return instTable_.getEntry(InstId::fmax_s);
    }
  if (f7 == 0x20)
    {
      if (op2 == 1) return instTable_.getEntry(InstId::fcvt_s_d);
      return instTable_.getEntry(InstId::illegal);
    }
  if (f7 == 0x50)
    {
      if (f3 == 0)  return instTable_.getEntry(InstId::fle_s);
      if (f3 == 1)  return instTable_.getEntry(InstId::flt_s);
      if (f3 == 2)  return instTable_.getEntry(InstId::feq_s);
      return instTable_.getEntry(InstId::illegal);
    }
  if (f7 == 0x60)
    {
      if (op2 == 0) return instTable_.getEntry(InstId::fcvt_w_s);
      if (op2 == 1) return instTable_.getEntry(InstId::fcvt_wu_s);
      if (op2 == 2) return instTable_.getEntry(InstId::fcvt_l_s);
      if (op2 == 3) return instTable_.getEntry(InstId::fcvt_lu_s);
      return instTable_.getEntry(InstId::illegal);
    }
  if (f7 == 0x68)
    {
      if (op2 == 0) return instTable_.getEntry(InstId::fcvt_s_w);
      if (op2 == 1) return instTable_.getEntry(InstId::fcvt_s_wu);
      if (op2 == 2) return instTable_.getEntry(InstId::fcvt_s_l);
      if (op2 == 3) return instTable_.getEntry(InstId::fcvt_s_lu);
      return instTable_.getEntry(InstId::illegal);
    }
  if (f7 == 0x70)
    {
      if (op2 == 0)
	{
	  if (f3 == 0) return instTable_.getEntry(InstId::fmv_x_w);
	  if (f3 == 1) return instTable_.getEntry(InstId::fclass_s);
	}
    }
  if (f7 == 0x78)
    {
      if (op2 == 0)
	if (f3 == 0) return instTable_.getEntry(InstId::fmv_w_x);
    }
  return instTable_.getEntry(InstId::illegal);
}


// Least sig 7 bits already determined to be: 1010111
template <typename URV>
const InstEntry&
Hart<URV>::decodeVec(uint32_t inst, uint32_t& op0, uint32_t& op1, uint32_t& op2,
                     uint32_t& op3)
{
  if (not isRvv())
    return instTable_.getEntry(InstId::illegal);  

  RFormInst rform(inst);
  unsigned f3 = rform.bits.funct3, f6 = rform.top6();
  unsigned vm = (inst >> 25) & 1;


  op3 = 0;

  if (f3 == 0)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs2; // operand order reversed
      op2 = rform.bits.rs1;

      switch (f6)
        {
        case 0:    return instTable_.getEntry(InstId::vadd_vv);
        case 2:    return instTable_.getEntry(InstId::vsub_vv);
        case 4:    return instTable_.getEntry(InstId::vminu_vv);
        case 5:    return instTable_.getEntry(InstId::vmin_vv);
        case 6:    return instTable_.getEntry(InstId::vmaxu_vv);
        case 7:    return instTable_.getEntry(InstId::vmax_vv);
        case 9:    return instTable_.getEntry(InstId::vand_vv);
        case 0xa:  return instTable_.getEntry(InstId::vor_vv);
        case 0xb:  return instTable_.getEntry(InstId::vxor_vv);
        case 0xc:  return instTable_.getEntry(InstId::vrgather_vv);
        case 0xe:  return instTable_.getEntry(InstId::vrgatherei16_vv);
        case 0x10: return instTable_.getEntry(InstId::vadc_vvm);
        case 0x11: return instTable_.getEntry(InstId::vmadc_vvm);
        case 0x12: return instTable_.getEntry(InstId::vsbc_vvm);
        case 0x13: return instTable_.getEntry(InstId::vmsbc_vvm);
        case 0x17:
          if (vm == 0) return instTable_.getEntry(InstId::vmerge_vv);
          if (vm == 1)
            {
              std::swap(op1, op2);  // Per spec !
              if (op2 == 0) return instTable_.getEntry(InstId::vmv_v_v);
            }
          break;
        case 0x20: return instTable_.getEntry(InstId::vsaddu_vv);
        case 0x21: return instTable_.getEntry(InstId::vsadd_vv);
        case 0x22: return instTable_.getEntry(InstId::vssubu_vv);
        case 0x23: return instTable_.getEntry(InstId::vssub_vv);
        case 0x27: return instTable_.getEntry(InstId::vsmul_vv);
        case 0x2a: return instTable_.getEntry(InstId::vssrl_vv);
        case 0x2b: return instTable_.getEntry(InstId::vssra_vv);
        case 0x2e: return instTable_.getEntry(InstId::vnclipu_wv);
        case 0x2f: return instTable_.getEntry(InstId::vnclip_wv);
        }
      return instTable_.getEntry(InstId::illegal);  
    }

  if (f3 == 2)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs2; // operand order reversed
      op2 = rform.bits.rs1;

      switch(f6)
        {
        case 0:    return instTable_.getEntry(InstId::vredsum_vs);
        case 1:    return instTable_.getEntry(InstId::vredand_vs);
        case 2:    return instTable_.getEntry(InstId::vredor_vs);
        case 3:    return instTable_.getEntry(InstId::vredxor_vs);
        case 4:    return instTable_.getEntry(InstId::vredminu_vs);
        case 5:    return instTable_.getEntry(InstId::vredmin_vs);
        case 6:    return instTable_.getEntry(InstId::vredmaxu_vs);
        case 7:    return instTable_.getEntry(InstId::vredmax_vs);
        case 8:    return instTable_.getEntry(InstId::vaaddu_vv);
        case 9:    return instTable_.getEntry(InstId::vaadd_vv);
        case 0xa:  return instTable_.getEntry(InstId::vasubu_vv);
        case 0xb:  return instTable_.getEntry(InstId::vasub_vv);
        case 0x10:
          if (op2 == 0)    return instTable_.getEntry(InstId::vmv_x_s);
          if (op2 == 0x10) return instTable_.getEntry(InstId::vpopc_m);
          if (op2 == 0x11) return instTable_.getEntry(InstId::vfirst_m);
          return instTable_.getEntry(InstId::illegal);
        case 0x12:
          if (op2 == 2)  return instTable_.getEntry(InstId::vzext_vf8);
          if (op2 == 4)  return instTable_.getEntry(InstId::vzext_vf4);
          if (op2 == 6)  return instTable_.getEntry(InstId::vzext_vf2);
          if (op2 == 3)  return instTable_.getEntry(InstId::vsext_vf8);
          if (op2 == 5)  return instTable_.getEntry(InstId::vsext_vf4);
          if (op2 == 7)  return instTable_.getEntry(InstId::vsext_vf2);
          return instTable_.getEntry(InstId::illegal);
        case 0x14:
          if (op2 == 1)    return instTable_.getEntry(InstId::vmsbf_m);
          if (op2 == 2)    return instTable_.getEntry(InstId::vmsof_m);
          if (op2 == 3)    return instTable_.getEntry(InstId::vmsif_m);
          if (op2 == 0x10) return instTable_.getEntry(InstId::viota_m);
          if (op2 == 0x11) return instTable_.getEntry(InstId::vid_v);
          return instTable_.getEntry(InstId::illegal);
        case 0x17: return instTable_.getEntry(InstId::vcompress_vm);
        case 0x19: return instTable_.getEntry(InstId::vmand_mm);
        case 0x1d: return instTable_.getEntry(InstId::vmnand_mm);
        case 0x18: return instTable_.getEntry(InstId::vmandnot_mm);
        case 0x1b: return instTable_.getEntry(InstId::vmxor_mm);
        case 0x1a: return instTable_.getEntry(InstId::vmor_mm);
        case 0x1e: return instTable_.getEntry(InstId::vmnor_mm);
        case 0x1c: return instTable_.getEntry(InstId::vmornot_mm);
        case 0x1f: return instTable_.getEntry(InstId::vmxnor_mm);
        case 0x20: return instTable_.getEntry(InstId::vdivu_vv);
        case 0x21: return instTable_.getEntry(InstId::vdiv_vv);
        case 0x22: return instTable_.getEntry(InstId::vremu_vv);
        case 0x23: return instTable_.getEntry(InstId::vrem_vv);
        case 0x24: return instTable_.getEntry(InstId::vmulhu_vv);
        case 0x25: return instTable_.getEntry(InstId::vmul_vv);
        case 0x26: return instTable_.getEntry(InstId::vmulhsu_vv);
        case 0x27: return instTable_.getEntry(InstId::vmulh_vv);
        case 0x30: return instTable_.getEntry(InstId::vwaddu_vv);
        case 0x31: return instTable_.getEntry(InstId::vwadd_vv);
        case 0x32: return instTable_.getEntry(InstId::vwsubu_vv);
        case 0x33: return instTable_.getEntry(InstId::vwsub_vv);
        case 0x34: return instTable_.getEntry(InstId::vwaddu_wv);
        case 0x35: return instTable_.getEntry(InstId::vwadd_wv);
        case 0x36: return instTable_.getEntry(InstId::vwsubu_wv);
        case 0x37: return instTable_.getEntry(InstId::vwsub_wv);
        case 0x38: return instTable_.getEntry(InstId::vwmulu_vv);
        case 0x3a: return instTable_.getEntry(InstId::vwmulsu_vv);
        case 0x3b: return instTable_.getEntry(InstId::vwmul_vv);
        case 0x3c:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmaccu_vv);
        case 0x3d:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmacc_vv);
        case 0x3f:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmaccsu_vv);
        }
      return instTable_.getEntry(InstId::illegal);  
    }

  if (f3 == 3)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs2; // operand order reversed
      int32_t imm = (int32_t(rform.bits.rs1) << 27) >> 27;
      op2 = imm;

      switch (f6)
        {
        case 0:    return instTable_.getEntry(InstId::vadd_vi);
        case 3:    return instTable_.getEntry(InstId::vrsub_vi);
        case 9:    return instTable_.getEntry(InstId::vand_vi);
        case 0xa:  return instTable_.getEntry(InstId::vor_vi);
        case 0xb:  return instTable_.getEntry(InstId::vxor_vi);
        case 0xc:  return instTable_.getEntry(InstId::vrgather_vi);
        case 0xe:  return instTable_.getEntry(InstId::vslideup_vi);
        case 0xf:  return instTable_.getEntry(InstId::vslidedown_vi);
        case 0x10: return instTable_.getEntry(InstId::vadc_vim);
        case 0x11: return instTable_.getEntry(InstId::vmadc_vim);
        case 0x17:
          if (vm == 0) return instTable_.getEntry(InstId::vmerge_vi);
          if (vm == 1)
            {
              op1 = (int32_t(rform.bits.rs1) << 27) >> 27;
              op2 = rform.bits.rs2;
              if (op2 == 0) return instTable_.getEntry(InstId::vmv_v_i);
            }
          break;
        case 0x20: return instTable_.getEntry(InstId::vsaddu_vi);
        case 0x21: return instTable_.getEntry(InstId::vsadd_vi);
        case 0x27:
          if (imm == 0) return instTable_.getEntry(InstId::vmv1r_v);
          if (imm == 1) return instTable_.getEntry(InstId::vmv2r_v);
          if (imm == 3) return instTable_.getEntry(InstId::vmv4r_v);
          if (imm == 7) return instTable_.getEntry(InstId::vmv8r_v);
          break;
        case 0x2a: return instTable_.getEntry(InstId::vssrl_vi);
        case 0x2b: return instTable_.getEntry(InstId::vssra_vi);
        case 0x2e: return instTable_.getEntry(InstId::vnclipu_wi);
        case 0x2f: return instTable_.getEntry(InstId::vnclip_wi);
        }
      return instTable_.getEntry(InstId::illegal);  
    }

  if (f3 == 4)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs2; // operand order reversed
      op2 = rform.bits.rs1;

      switch (f6)
        {
        case 0:    return instTable_.getEntry(InstId::vadd_vx);
        case 2:    return instTable_.getEntry(InstId::vsub_vx);
        case 3:    return instTable_.getEntry(InstId::vrsub_vx);
        case 4:    return instTable_.getEntry(InstId::vminu_vx);
        case 5:    return instTable_.getEntry(InstId::vmin_vx);
        case 6:    return instTable_.getEntry(InstId::vmaxu_vx);
        case 7:    return instTable_.getEntry(InstId::vmax_vx);
        case 9:    return instTable_.getEntry(InstId::vand_vx);
        case 0xa:  return instTable_.getEntry(InstId::vor_vx);
        case 0xb:  return instTable_.getEntry(InstId::vxor_vx);
        case 0xc:  return instTable_.getEntry(InstId::vrgather_vx);
        case 0xe:  return instTable_.getEntry(InstId::vslideup_vx);
        case 0xf:  return instTable_.getEntry(InstId::vslidedown_vx);
        case 0x10: return instTable_.getEntry(InstId::vadc_vxm);
        case 0x11: return instTable_.getEntry(InstId::vmadc_vxm);
        case 0x12: return instTable_.getEntry(InstId::vsbc_vxm);
        case 0x13: return instTable_.getEntry(InstId::vmsbc_vxm);
        case 0x17:
          if (vm == 0) return instTable_.getEntry(InstId::vmerge_vx);
          if (vm == 1)
            {
              std::swap(op1, op2);  // Per spec!
              if (op2 == 0) return instTable_.getEntry(InstId::vmv_v_x);
            }
          break;
        case 0x20: return instTable_.getEntry(InstId::vsaddu_vx);
        case 0x21: return instTable_.getEntry(InstId::vsaddu_vx);
        case 0x22: return instTable_.getEntry(InstId::vssubu_vx);
        case 0x23: return instTable_.getEntry(InstId::vssub_vx);
        case 0x27: return instTable_.getEntry(InstId::vsmul_vx);
        case 0x2a: return instTable_.getEntry(InstId::vssrl_vx);
        case 0x2b: return instTable_.getEntry(InstId::vssra_vx);
        case 0x2e: return instTable_.getEntry(InstId::vnclipu_wx);
        case 0x2f: return instTable_.getEntry(InstId::vnclip_wx);
        }
      return instTable_.getEntry(InstId::illegal);  
    }

  if (f3 == 6)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs2; // operand order reversed
      op2 = rform.bits.rs1;

      switch (f6)
        {
        case 8:    return instTable_.getEntry(InstId::vaaddu_vx);
        case 9:    return instTable_.getEntry(InstId::vaadd_vx);
        case 0xa:  return instTable_.getEntry(InstId::vasubu_vx);
        case 0xb:  return instTable_.getEntry(InstId::vasub_vx);
        case 0xe:   return instTable_.getEntry(InstId::vslide1up_vx);
        case 0x10:  std::swap(op1, op2); // per spec !
                    return instTable_.getEntry(InstId::vmv_s_x);
        case 0x20:  return instTable_.getEntry(InstId::vdivu_vx);
        case 0x21:  return instTable_.getEntry(InstId::vdiv_vx);
        case 0x22:  return instTable_.getEntry(InstId::vremu_vx);
        case 0x23:  return instTable_.getEntry(InstId::vrem_vx);
        case 0x24:  return instTable_.getEntry(InstId::vmulhu_vx);
        case 0x25:  return instTable_.getEntry(InstId::vmul_vx);
        case 0x26:  return instTable_.getEntry(InstId::vmulhsu_vx);
        case 0x27:  return instTable_.getEntry(InstId::vmulh_vx);
        case 0x30:  return instTable_.getEntry(InstId::vwaddu_vx);
        case 0x31:  return instTable_.getEntry(InstId::vwadd_vx);
        case 0x32:  return instTable_.getEntry(InstId::vwsubu_vx);
        case 0x33:  return instTable_.getEntry(InstId::vwsub_vx);
        case 0x34:  return instTable_.getEntry(InstId::vwaddu_wx);
        case 0x35:  return instTable_.getEntry(InstId::vwadd_wx);
        case 0x36:  return instTable_.getEntry(InstId::vwsubu_wx);
        case 0x37:  return instTable_.getEntry(InstId::vwsub_wx);
        case 0x38:  return instTable_.getEntry(InstId::vwmulu_vx);
        case 0x3a:  return instTable_.getEntry(InstId::vwmulsu_vx);
        case 0x3b:  return instTable_.getEntry(InstId::vwmul_vx);
        case 0x3c:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmaccu_vx);
        case 0x3d:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmacc_vx);
        case 0x3e:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmaccus_vx);
        case 0x3f:
          std::swap(op1, op2);  // Spec is baffling.
          return instTable_.getEntry(InstId::vwmaccsu_vx);
        }
      return instTable_.getEntry(InstId::illegal);  
    }

  if (f3 == 7)
    {
      op0 = rform.bits.rd;
      op1 = rform.bits.rs1;
      op2 = rform.bits.rs2;

      if ((f6 >> 5) == 0)
        {
          op2 = ((rform.bits.funct7 & 0x3f) << 5 | op2);
          return instTable_.getEntry(InstId::vsetvli);
        }
      if (f6 == 0x20)  return instTable_.getEntry(InstId::vsetvl);
    }

  return instTable_.getEntry(InstId::illegal);  
}


template <typename URV>
const InstEntry&
Hart<URV>::decodeVecLoad(uint32_t f3, uint32_t imm12, uint32_t& op3)
{
  unsigned lumop = imm12 & 0x1f;       // Bits 0 to 4 of imm12
  // unsigned vm = (imm12 >> 5) & 1;      // Bit 5 of imm12
  unsigned mop = (imm12 >> 6) & 3;     // Bits 6 & 7 of imm12
  unsigned mew = (imm12 >> 8) & 1;     // Bit 8 of imm12
  unsigned nf = (imm12 >> 9) & 7;      // Bit 9, 10, and 11 of imm12

  if (mop == 0)
    {      // Unit stride
      if (lumop == 0)
        {
          if (mew == 0)
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vle8_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vle16_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vle32_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vle64_v);
            }
          else
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vle128_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vle256_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vle512_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vle1024_v);
            }
        }
      else if (lumop == 0x8)
        {   // whole registers
          op3 = nf;

          if (mew == 0)
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vlre8_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vlre16_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vlre32_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vlre64_v);
            }
          else
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vlre128_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vlre256_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vlre512_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vlre1024_v);
            }
        }
      else if (lumop == 0x10)
        {   // fault only on first
          if (mew == 0)
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vle8ff_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vle16ff_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vle32ff_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vle64ff_v);
            }
          else
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vle128ff_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vle256ff_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vle512ff_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vle1024ff_v);
            }
        }
    }

  if (mop == 1)
    return instTable_.getEntry(InstId::illegal);

  if (mop == 2)
    {      // Strided
      if (mew == 0)
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vlse8_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vlse16_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vlse32_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vlse64_v);
        }
      else
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vlse128_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vlse256_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vlse512_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vlse1024_v);
        }
    }

  if (mop == 3)
    {      // Indexed
      if (mew == 0)
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vlxei8_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vlxei16_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vlxei32_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vlxei64_v);
        }
    }

  return instTable_.getEntry(InstId::illegal);
}


template <typename URV>
const InstEntry&
Hart<URV>::decodeVecStore(uint32_t f3, uint32_t imm12, uint32_t& op3)
{
  unsigned lumop = imm12 & 0x1f;       // Bits 0 to 4 of imm12
  // unsigned vm = (imm12 >> 5) & 1;      // Bit 5 of imm12
  unsigned mop = (imm12 >> 6) & 3;     // Bits 6 & 7 of imm12
  unsigned mew = (imm12 >> 8) & 1;     // Bit 8 of imm12
  unsigned nf = (imm12 >> 9) & 7;      // Bit 9, 10, and 11 of imm12

  if (mop == 0)
    {      // Unit stride
      if (lumop == 0)
        {
          if (mew == 0)
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vse8_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vse16_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vse32_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vse64_v);
            }
          else
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vse128_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vse256_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vse512_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vse1024_v);
            }
        }
      else if (lumop == 8)
        {
          op3 = nf;
          if (mew == 0)
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vsre8_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vsre16_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vsre32_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vsre64_v);
            }
          else
            {
              if (f3 == 0) return instTable_.getEntry(InstId::vsre128_v);
              if (f3 == 5) return instTable_.getEntry(InstId::vsre256_v);
              if (f3 == 6) return instTable_.getEntry(InstId::vsre512_v);
              if (f3 == 7) return instTable_.getEntry(InstId::vsre1024_v);
            }
        }
    }

  if (mop == 1)
    {      // indexed ordered
    }

  if (mop == 2)
    {      // Strided
      if (mew == 0)
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vsse8_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vsse16_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vsse32_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vsse64_v);
        }
      else
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vsse128_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vsse256_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vsse512_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vsse1024_v);
        }
    }

  if (mop == 3)
    {      // Indexed
      if (mew == 0)
        {
          if (f3 == 0) return instTable_.getEntry(InstId::vsxei8_v);
          if (f3 == 5) return instTable_.getEntry(InstId::vsxei16_v);
          if (f3 == 6) return instTable_.getEntry(InstId::vsxei32_v);
          if (f3 == 7) return instTable_.getEntry(InstId::vsxei64_v);
        }
    }
  return instTable_.getEntry(InstId::illegal);
}


template <typename URV>
const InstEntry&
Hart<URV>::decode16(uint16_t inst, uint32_t& op0, uint32_t& op1, uint32_t& op2)
{
  uint16_t quadrant = inst & 0x3;
  uint16_t funct3 =  uint16_t(inst >> 13);    // Bits 15 14 and 13

  op0 = 0; op1 = 0; op2 = 0;

  if (quadrant == 0)
    {
      if (funct3 == 0)    // illegal, c.addi4spn
	{
	  if (inst == 0)
	    return instTable_.getEntry(InstId::illegal);
	  CiwFormInst ciwf(inst);
	  unsigned immed = ciwf.immed();
	  if (immed == 0)
	    return instTable_.getEntry(InstId::illegal);
	  op0 = 8 + ciwf.bits.rdp; op1 = RegSp; op2 = immed;
	  return instTable_.getEntry(InstId::c_addi4spn);
	}

      if (funct3 == 1) // c.fld c.lq
	{
	  if (not isRvd())
	    return instTable_.getEntry(InstId::illegal);
	  ClFormInst clf(inst);
	  op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.ldImmed();
	  return instTable_.getEntry(InstId::c_fld);
	}

      if (funct3 == 2) // c.lw
	{
	  ClFormInst clf(inst);
	  op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.lwImmed();
	  return instTable_.getEntry(InstId::c_lw);
	}

      if (funct3 == 3) // c.flw, c.ld
	{
	  ClFormInst clf(inst);
	  if (isRv64())
	    {
	      op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.ldImmed();
	      return instTable_.getEntry(InstId::c_ld);
	    }

	  // c.flw
	  if (isRvf())
	    {
	      op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p;
	      op2 = clf.lwImmed();
	      return instTable_.getEntry(InstId::c_flw);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 5)  // c.fsd
	{
	  CsFormInst cs(inst);  // Double check this
	  if (isRvd())
	    {
	      op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.sdImmed();
	      return instTable_.getEntry(InstId::c_fsd);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 6)  // c.sw
	{
	  CsFormInst cs(inst);
	  op1 = 8+cs.bits.rs1p; op0 = 8+cs.bits.rs2p; op2 = cs.swImmed();
	  return instTable_.getEntry(InstId::c_sw);
	}

      if (funct3 == 7) // c.fsw, c.sd
	{
	  CsFormInst cs(inst);  // Double check this
	  if (not isRv64())
	    {
	      if (isRvf())
		{
		  op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.swImmed();
		  return instTable_.getEntry(InstId::c_fsw);
		}
	      return instTable_.getEntry(InstId::illegal);
	    }
	  op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.sdImmed();
	  return instTable_.getEntry(InstId::c_sd);
	}

      // funct3 is 1 (c.fld c.lq), or 4 (reserved), or 5 (c.fsd c.sq)
      return instTable_.getEntry(InstId::illegal);
    }

  if (quadrant == 1)
    {
      if (funct3 == 0)  // c.nop, c.addi
	{
	  CiFormInst cif(inst);
	  op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = cif.addiImmed();
	  return instTable_.getEntry(InstId::c_addi);
	}
	  
      if (funct3 == 1)  // c.jal,  in rv64 and rv128 this is c.addiw
	{
	  if (isRv64())
	    {
	      CiFormInst cif(inst);
	      op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = cif.addiImmed();
	      if (op0 == 0)
		return instTable_.getEntry(InstId::illegal);
	      return instTable_.getEntry(InstId::c_addiw);
	    }
	  else
	    {
	      CjFormInst cjf(inst);
	      op0 = RegRa; op1 = cjf.immed(); op2 = 0;
	      return instTable_.getEntry(InstId::c_jal);
	    }
	}

      if (funct3 == 2)  // c.li
	{
	  CiFormInst cif(inst);
	  op0 = cif.bits.rd; op1 = RegX0; op2 = cif.addiImmed();
	  return instTable_.getEntry(InstId::c_li);
	}

      if (funct3 == 3)  // c.addi16sp, c.lui
	{
	  CiFormInst cif(inst);
	  int immed16 = cif.addi16spImmed();
	  if (immed16 == 0)
	    return instTable_.getEntry(InstId::illegal);
	  if (cif.bits.rd == RegSp)  // c.addi16sp
	    {
	      op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = immed16;
	      return instTable_.getEntry(InstId::c_addi16sp);
	    }
	  op0 = cif.bits.rd; op1 = cif.luiImmed(); op2 = 0;
	  return instTable_.getEntry(InstId::c_lui);
	}

      // c.srli c.srli64 c.srai c.srai64 c.andi c.sub c.xor c.and
      // c.subw c.addw
      if (funct3 == 4)
	{
	  CaiFormInst caf(inst);  // compressed and immediate form
	  int immed = caf.andiImmed();
	  unsigned rd = 8 + caf.bits.rdp;
	  unsigned f2 = caf.bits.funct2;
	  if (f2 == 0) // srli64, srli
	    {
	      if (caf.bits.ic5 != 0 and not isRv64())
		return instTable_.getEntry(InstId::illegal);
	      op0 = rd; op1 = rd; op2 = caf.shiftImmed();
	      return instTable_.getEntry(InstId::c_srli);
	    }
	  if (f2 == 1)  // srai64, srai
	    {
	      if (caf.bits.ic5 != 0 and not isRv64())
		return instTable_.getEntry(InstId::illegal);
	      op0 = rd; op1 = rd; op2 = caf.shiftImmed();
	      return instTable_.getEntry(InstId::c_srai);
	    }
	  if (f2 == 2)  // c.andi
	    {
	      op0 = rd; op1 = rd; op2 = immed;
	      return instTable_.getEntry(InstId::c_andi);
	    }

	  // f2 == 3: c.sub c.xor c.or c.subw c.addw
	  unsigned rs2p = (immed & 0x7); // Lowest 3 bits of immed
	  unsigned rs2 = 8 + rs2p;
	  unsigned imm34 = (immed >> 3) & 3; // Bits 3 and 4 of immed
	  op0 = rd; op1 = rd; op2 = rs2;
	  if ((immed & 0x20) == 0)  // Bit 5 of immed
	    {
	      if (imm34 == 0) return instTable_.getEntry(InstId::c_sub);
	      if (imm34 == 1) return instTable_.getEntry(InstId::c_xor);
	      if (imm34 == 2) return instTable_.getEntry(InstId::c_or);
	      return instTable_.getEntry(InstId::c_and);
	    }
	  // Bit 5 of immed is 1
	  if (not isRv64())
	    return instTable_.getEntry(InstId::illegal);
	  if (imm34 == 0) return instTable_.getEntry(InstId::c_subw);
	  if (imm34 == 1) return instTable_.getEntry(InstId::c_addw);
	  if (imm34 == 2) return instTable_.getEntry(InstId::illegal);
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 5)  // c.j
	{
	  CjFormInst cjf(inst);
	  op0 = RegX0; op1 = cjf.immed(); op2 = 0;
	  return instTable_.getEntry(InstId::c_j);
	}
	  
      if (funct3 == 6) // c.beqz
	{
	  CbFormInst cbf(inst);
	  op0=8+cbf.bits.rs1p; op1=RegX0; op2=cbf.immed();
	  return instTable_.getEntry(InstId::c_beqz);
	}
      
      // funct3 == 7: c.bnez
      CbFormInst cbf(inst);
      op0 = 8+cbf.bits.rs1p; op1=RegX0; op2=cbf.immed();
      return instTable_.getEntry(InstId::c_bnez);
    }

  if (quadrant == 2)
    {
      if (funct3 == 0)  // c.slli, c.slli64
	{
	  CiFormInst cif(inst);
	  unsigned immed = unsigned(cif.slliImmed());
	  if (cif.bits.ic5 != 0 and not isRv64())
	    return instTable_.getEntry(InstId::illegal);
	  op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = immed;
	  return instTable_.getEntry(InstId::c_slli);
	}

      if (funct3 == 1)  // c.fldsp c.lqsp
	{
	  if (isRvd())
	    {
	      CiFormInst cif(inst);
	      op0 = cif.bits.rd; op1 = RegSp, op2 = cif.ldspImmed();
	      return instTable_.getEntry(InstId::c_fldsp);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 2) // c.lwsp
	{
	  CiFormInst cif(inst);
	  unsigned rd = cif.bits.rd;
	  // rd == 0 is legal per Andrew Watterman
	  op0 = rd; op1 = RegSp; op2 = cif.lwspImmed();
	  return instTable_.getEntry(InstId::c_lwsp);
	}

      else if (funct3 == 3)  // c.ldsp  c.flwsp
	{
	  CiFormInst cif(inst);
	  unsigned rd = cif.bits.rd;
	  if (isRv64())
	    {
	      op0 = rd; op1 = RegSp; op2 = cif.ldspImmed();
	      return instTable_.getEntry(InstId::c_ldsp);
	    }
	  if (isRvf())
	    {
	      op0 = rd; op1 = RegSp; op2 = cif.lwspImmed();
	      return instTable_.getEntry(InstId::c_flwsp);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 4) // c.jr c.mv c.ebreak c.jalr c.add
	{
	  CiFormInst cif(inst);
	  unsigned immed = cif.addiImmed();
	  unsigned rd = cif.bits.rd;
	  unsigned rs2 = immed & 0x1f;
	  if ((immed & 0x20) == 0)  // c.jr or c.mv
	    {
	      if (rs2 == RegX0)
		{
		  if (rd == RegX0)
		    return instTable_.getEntry(InstId::illegal);
		  op0 = RegX0; op1 = rd; op2 = 0;
		  return instTable_.getEntry(InstId::c_jr);
		}
	      op0 = rd; op1 = RegX0; op2 = rs2;
	      return instTable_.getEntry(InstId::c_mv);
	    }
	  else  // c.ebreak, c.jalr or c.add 
	    {
	      if (rs2 == RegX0)
		{
		  if (rd == RegX0)
		    return instTable_.getEntry(InstId::c_ebreak);
		  op0 = RegRa; op1 = rd; op2 = 0;
		  return instTable_.getEntry(InstId::c_jalr);
		}
	      op0 = rd; op1 = rd; op2 = rs2;
	      return instTable_.getEntry(InstId::c_add);
	    }
	}

      if (funct3 == 5)  // c.fsdsp c.sqsp
	{
	  if (isRvd())
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.sdImmed();
	      return instTable_.getEntry(InstId::c_fsdsp);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      if (funct3 == 6) // c.swsp
	{
	  CswspFormInst csw(inst);
	  op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.swImmed();
	  return instTable_.getEntry(InstId::c_swsp);
	}

      if (funct3 == 7)  // c.sdsp  c.fswsp
	{
	  if (isRv64())  // c.sdsp
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.sdImmed();
	      return instTable_.getEntry(InstId::c_sdsp);
	    }
	  if (isRvf())   // c.fswsp
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.swImmed();
	      return instTable_.getEntry(InstId::c_fswsp);
	    }
	  return instTable_.getEntry(InstId::illegal);
	}

      return instTable_.getEntry(InstId::illegal);
    }

  return instTable_.getEntry(InstId::illegal); // quadrant 3
}


template <typename URV>
uint32_t
Hart<URV>::expandCompressedInst(uint16_t inst) const
{
  uint16_t quadrant = inst & 0x3;
  uint16_t funct3 =  uint16_t(inst >> 13);    // Bits 15 14 and 13

  uint32_t op0 = 0, op1 = 0, op2 = 0;

  uint32_t expanded = 0;  // Illegal

  if (quadrant == 0)
    {
      if (funct3 == 0)    // illegal, c.addi4spn
	{
	  if (inst == 0)
            return expanded;  // Illegal
	  CiwFormInst ciwf(inst);
	  unsigned immed = ciwf.immed();
	  if (immed == 0)
	    return expanded; // Illegal
	  op0 = 8 + ciwf.bits.rdp; op1 = RegSp; op2 = immed;
          encodeAddi(op0, op1, op2, expanded);
          return expanded;
	}

      if (funct3 == 1) // c.fld c.lq
	{
	  if (not isRvd())
	    return expanded; // Illegal
	  ClFormInst clf(inst);
	  op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.ldImmed();
          encodeFld(op0, op1, op2, expanded);
          return expanded;
	}

      if (funct3 == 2) // c.lw
	{
	  ClFormInst clf(inst);
	  op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.lwImmed();
          encodeLw(op0, op1, op2, expanded);
	  return expanded;
	}

      if (funct3 == 3) // c.flw, c.ld
	{
	  ClFormInst clf(inst);
	  if (isRv64())
	    {
	      op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p; op2 = clf.ldImmed();
              encodeLd(op0, op1, op2, expanded);
	      return expanded;
	    }

	  // c.flw
	  if (isRvf())
	    {
	      op0 = 8+clf.bits.rdp; op1 = 8+clf.bits.rs1p;
	      op2 = clf.lwImmed();
              encodeFlw(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      if (funct3 == 5)  // c.fsd
	{
	  CsFormInst cs(inst);  // Double check this
	  if (isRvd())
	    {
	      op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.sdImmed();
	      encodeFsd(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      if (funct3 == 6)  // c.sw
	{
	  CsFormInst cs(inst);
	  op1 = 8+cs.bits.rs1p; op0 = 8+cs.bits.rs2p; op2 = cs.swImmed();
          encodeSw(op1, op0, op2, expanded);
          return expanded;
	}

      if (funct3 == 7) // c.fsw, c.sd
	{
	  CsFormInst cs(inst);  // Double check this
	  if (not isRv64())
	    {
	      if (isRvf())
		{
		  op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.swImmed();
                  encodeFsw(op0, op1, op2, expanded);
                  return expanded;
		}
	      return expanded; // Illegal
	    }
	  op1=8+cs.bits.rs1p; op0=8+cs.bits.rs2p; op2 = cs.sdImmed();
          encodeSd(op0, op1, op2, expanded);
          return expanded;
	}

      // funct3 is 1 (c.fld c.lq), or 4 (reserved), or 5 (c.fsd c.sq)
      return expanded; // Illegal
    }

  if (quadrant == 1)
    {
      if (funct3 == 0)  // c.nop, c.addi
	{
	  CiFormInst cif(inst);
	  op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = cif.addiImmed();
          encodeAddi(op0, op1, op2, expanded);
          return expanded;
	}
	  
      if (funct3 == 1)  // c.jal,  in rv64 and rv128 this is c.addiw
	{
	  if (isRv64())
	    {
	      CiFormInst cif(inst);
	      op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = cif.addiImmed();
	      if (op0 == 0)
		return expanded; // Illegal
              encodeAddiw(op0, op1, op2, expanded);
              return expanded;
	    }
	  else
	    {
	      CjFormInst cjf(inst);
	      op0 = RegRa; op1 = cjf.immed(); op2 = 0;
              encodeJal(op0, op1, op2, expanded);
              return expanded;
	    }
	}

      if (funct3 == 2)  // c.li
	{
	  CiFormInst cif(inst);
	  op0 = cif.bits.rd; op1 = RegX0; op2 = cif.addiImmed();
	  encodeAddi(op0, op1, op2, expanded);
          return expanded;
	}

      if (funct3 == 3)  // c.addi16sp, c.lui
	{
	  CiFormInst cif(inst);
	  int immed16 = cif.addi16spImmed();
	  if (immed16 == 0)
	    return expanded; // Illegal
	  if (cif.bits.rd == RegSp)  // c.addi16sp
	    {
	      op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = immed16;
	      encodeAddi(op0, op1, op2, expanded);
              return expanded;
	    }
	  op0 = cif.bits.rd; op1 = cif.luiImmed(); op2 = 0;
	  encodeLui(op0, op1, op2, expanded);
          return expanded;
	}

      // c.srli c.srli64 c.srai c.srai64 c.andi c.sub c.xor c.and
      // c.subw c.addw
      if (funct3 == 4)
	{
	  CaiFormInst caf(inst);  // compressed and immediate form
	  int immed = caf.andiImmed();
	  unsigned rd = 8 + caf.bits.rdp;
	  unsigned f2 = caf.bits.funct2;
	  if (f2 == 0) // srli64, srli
	    {
	      if (caf.bits.ic5 != 0 and not isRv64())
		return expanded; // Illegal
	      op0 = rd; op1 = rd; op2 = caf.shiftImmed();
	      encodeSrli(op0, op1, op2, expanded);
              return expanded;
	    }
	  if (f2 == 1)  // srai64, srai
	    {
	      if (caf.bits.ic5 != 0 and not isRv64())
		return expanded; // Illegal
	      op0 = rd; op1 = rd; op2 = caf.shiftImmed();
	      encodeSrai(op0, op1, op2, expanded);
              return expanded;
	    }
	  if (f2 == 2)  // c.andi
	    {
	      op0 = rd; op1 = rd; op2 = immed;
	      encodeAndi(op0, op1, op2, expanded);
              return expanded;
	    }

	  // f2 == 3: c.sub c.xor c.or c.subw c.addw
	  unsigned rs2p = (immed & 0x7); // Lowest 3 bits of immed
	  unsigned rs2 = 8 + rs2p;
	  unsigned imm34 = (immed >> 3) & 3; // Bits 3 and 4 of immed
	  op0 = rd; op1 = rd; op2 = rs2;
	  if ((immed & 0x20) == 0)  // Bit 5 of immed
	    {
	      if      (imm34 == 0)   encodeSub(op0, op1, op2, expanded);
	      else if (imm34 == 1)   encodeXor(op0, op1, op2, expanded);
	      else if (imm34 == 2)   encodeOr(op0, op1, op2, expanded);
              else if (imm34 == 3)   encodeAnd(op0, op1, op2, expanded);
              return expanded;
	    }
	  // Bit 5 of immed is 1
	  if (not isRv64())
	    return expanded; // Illegal
	  if      (imm34 == 0)     encodeSubw(op0, op1, op2, expanded);
	  else if (imm34 == 1)     encodeAddw(op0, op1, op2, expanded);
	  return expanded; // Illegal
	}

      if (funct3 == 5)  // c.j
	{
	  CjFormInst cjf(inst);
	  op0 = RegX0; op1 = cjf.immed(); op2 = 0;
	  encodeJal(op0, op1, op2, expanded);
          return expanded;
	}
	  
      if (funct3 == 6) // c.beqz
	{
	  CbFormInst cbf(inst);
	  op0=8+cbf.bits.rs1p; op1=RegX0; op2=cbf.immed();
	  encodeBeq(op0, op1, op2, expanded);
          return expanded;
	}
      
      // funct3 == 7: c.bnez
      CbFormInst cbf(inst);
      op0 = 8+cbf.bits.rs1p; op1=RegX0; op2=cbf.immed();
      encodeBne(op0, op1, op2, expanded);
      return expanded;
    }

  if (quadrant == 2)
    {
      if (funct3 == 0)  // c.slli, c.slli64
	{
	  CiFormInst cif(inst);
	  unsigned immed = unsigned(cif.slliImmed());
	  if (cif.bits.ic5 != 0 and not isRv64())
	    return expanded; // Illegal
	  op0 = cif.bits.rd; op1 = cif.bits.rd; op2 = immed;
	  encodeSlli(op0, op1, op2, expanded);
          return expanded;
	}

      if (funct3 == 1)  // c.fldsp c.lqsp
	{
	  if (isRvd())
	    {
	      CiFormInst cif(inst);
	      op0 = cif.bits.rd; op1 = RegSp, op2 = cif.ldspImmed();
	      encodeFld(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      if (funct3 == 2) // c.lwsp
	{
	  CiFormInst cif(inst);
	  unsigned rd = cif.bits.rd;
	  // rd == 0 is legal per Andrew Watterman
	  op0 = rd; op1 = RegSp; op2 = cif.lwspImmed();
	  encodeLw(op0, op1, op2, expanded);
          return expanded;
	}

      else  if (funct3 == 3)  // c.ldsp  c.flwsp
	{
	  CiFormInst cif(inst);
	  unsigned rd = cif.bits.rd;
	  if (isRv64())
	    {
	      op0 = rd; op1 = RegSp; op2 = cif.ldspImmed();
	      encodeLd(op0, op1, op2, expanded);
              return expanded;
	    }
	  if (isRvf())
	    {
	      op0 = rd; op1 = RegSp; op2 = cif.lwspImmed();
	      encodeFlw(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      if (funct3 == 4) // c.jr c.mv c.ebreak c.jalr c.add
	{
	  CiFormInst cif(inst);
	  unsigned immed = cif.addiImmed();
	  unsigned rd = cif.bits.rd;
	  unsigned rs2 = immed & 0x1f;
	  if ((immed & 0x20) == 0)  // c.jr or c.mv
	    {
	      if (rs2 == RegX0)
		{
		  if (rd == RegX0)
		    return expanded; // Illegal
		  op0 = RegX0; op1 = rd; op2 = 0;
		  encodeJalr(op0, op1, op2, expanded);
                  return expanded;
		}
	      op0 = rd; op1 = RegX0; op2 = rs2;
	      encodeAdd(op0, op1, op2, expanded);
              return expanded;
	    }
	  else  // c.ebreak, c.jalr or c.add 
	    {
	      if (rs2 == RegX0)
		{
		  if (rd == RegX0)
                    {
                      encodeEbreak(op0, op1, op2, expanded);
                      return expanded;
                    }
		  op0 = RegRa; op1 = rd; op2 = 0;
		  encodeJalr(op0, op1, op2, expanded);
                  return expanded;
		}
	      op0 = rd; op1 = rd; op2 = rs2;
	      encodeAdd(op0, op1, op2, expanded);
              return expanded;
	    }
	}

      if (funct3 == 5)  // c.fsdsp c.sqsp
	{
	  if (isRvd())
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.sdImmed();
	      encodeFsd(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      if (funct3 == 6) // c.swsp
	{
	  CswspFormInst csw(inst);
	  op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.swImmed();
	  encodeSw(op1, op0, op2, expanded);
          return expanded;
	}

      if (funct3 == 7)  // c.sdsp  c.fswsp
	{
	  if (isRv64())  // c.sdsp
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.sdImmed();
	      encodeSd(op0, op1, op2, expanded);
              return expanded;
	    }
	  if (isRvf())   // c.fswsp
	    {
	      CswspFormInst csw(inst);
	      op1 = RegSp; op0 = csw.bits.rs2; op2 = csw.swImmed();
	      encodeFsw(op0, op1, op2, expanded);
              return expanded;
	    }
	  return expanded; // Illegal
	}

      return expanded; // Illegal
    }

  return expanded;  // Illegal
}


template <typename URV>
const InstEntry&
Hart<URV>::decode(uint32_t inst, uint32_t& op0, uint32_t& op1, uint32_t& op2,
		  uint32_t& op3)
{
#pragma GCC diagnostic ignored "-Wpedantic"

  static void *opcodeLabels[] = { &&l0, &&l1, &&l2, &&l3, &&l4, &&l5,
				  &&l6, &&l7, &&l8, &&l9, &&l10, &&l11,
				  &&l12, &&l13, &&l14, &&l15, &&l16, &&l17,
				  &&l18, &&l19, &&l20, &&l21, &&l22, &&l23,
				  &&l24, &&l25, &&l26, &&l27, &&l28, &&l29,
				  &&l30, &&l31 };

  if (isCompressedInst(inst))
    {
      // return decode16(inst, op0, op1, op2);
      if (not isRvc())
	inst = 0; // All zeros: illegal 16-bit instruction.
      return decode16(uint16_t(inst), op0, op1, op2);
    }

  op0 = 0; op1 = 0; op2 = 0; op3 = 0;

  bool quad3 = (inst & 0x3) == 0x3;
  if (quad3)
    {
      unsigned opcode = (inst & 0x7f) >> 2;  // Upper 5 bits of opcode.

      goto *opcodeLabels[opcode];


    l0:  // 00000   I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.immed(); 
	switch (iform.fields.funct3)
	  {
	  case 0:  return instTable_.getEntry(InstId::lb);
	  case 1:  return instTable_.getEntry(InstId::lh);
	  case 2:  return instTable_.getEntry(InstId::lw);
	  case 3:  return instTable_.getEntry(InstId::ld);
	  case 4:  return instTable_.getEntry(InstId::lbu);
	  case 5:  return instTable_.getEntry(InstId::lhu);
	  case 6:  return instTable_.getEntry(InstId::lwu);
	  default: return instTable_.getEntry(InstId::illegal);
	  }
      }
      return instTable_.getEntry(InstId::illegal);

    l1:        // 00001
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	uint32_t f3 = iform.fields.funct3;
        if (f3 == 2 or f3 == 3)
          op2 = iform.immed();  // flw or fld
        else
          op2 = iform.rs2();  // vector load

        if (f3 == 0)  return decodeVecLoad(f3, iform.uimmed(), op3);
	if (f3 == 2)  return instTable_.getEntry(InstId::flw);
	if (f3 == 3)  return instTable_.getEntry(InstId::fld);
        if (f3 == 5)  return decodeVecLoad(f3, iform.uimmed(), op3);
        if (f3 == 6)  return decodeVecLoad(f3, iform.uimmed(), op3);
        if (f3 == 7)  return decodeVecLoad(f3, iform.uimmed(), op3);
      }
      return instTable_.getEntry(InstId::illegal);

    l2:       // 00010  I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.immed(); 
        unsigned f3 = iform.fields.funct3;
        if (f3 == 3)
          return instTable_.getEntry(InstId::load64);
        if (f3 == 0 and op2 == 0x0ff)
          return instTable_.getEntry(InstId::bbarrier);
        return instTable_.getEntry(InstId::illegal);
      }

    l7:
      return instTable_.getEntry(InstId::illegal);

    l9:       // 01001
      {
	// For store instructions: op0 is the stored register.
	SFormInst sform(inst);
	op0 = sform.bits.rs2;
	op1 = sform.bits.rs1;
	op2 = sform.immed();
	unsigned f3 = sform.bits.funct3;
        if (f3 != 2 and f3 != 3)
          {     // vector instructions.
            op0 = sform.vbits.rd;
            op1 = sform.vbits.rs1;
            op2 = sform.rs2();
          }

        if (f3 == 0)  return decodeVecStore(f3, sform.vbits.imm12, op3);
	if (f3 == 2)  return instTable_.getEntry(InstId::fsw);
	if (f3 == 3)  return instTable_.getEntry(InstId::fsd);
        if (f3 == 5)  return decodeVecStore(f3, sform.vbits.imm12, op3);
        if (f3 == 6)  return decodeVecStore(f3, sform.vbits.imm12, op3);
        if (f3 == 7)  return decodeVecStore(f3, sform.vbits.imm12, op3);
      }
      return instTable_.getEntry(InstId::illegal);

    l10:      // 01010  S-form
      {
	// For the store instructions, the stored register is op0, the
	// base-address register is op1 and the offset is op2.
	SFormInst sform(inst);
	op0 = sform.bits.rs2;
	op1 = sform.bits.rs1;
	op2 = sform.immed();
	uint32_t f3 = sform.bits.funct3;

        if (f3 == 3)  return instTable_.getEntry(InstId::store64);
      }
      return instTable_.getEntry(InstId::illegal);

    l15:
      return instTable_.getEntry(InstId::illegal);

    l16:
      {
	RFormInst rform(inst);
	op0 = rform.bits.rd, op1 = rform.bits.rs1, op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7;
	op3 = funct7 >> 2;
	if ((funct7 & 3) == 0)
	  return instTable_.getEntry(InstId::fmadd_s);
	if ((funct7 & 3) == 1)
	  return instTable_.getEntry(InstId::fmadd_d);
      }
      return instTable_.getEntry(InstId::illegal);

    l17:
      {
	RFormInst rform(inst);
	op0 = rform.bits.rd, op1 = rform.bits.rs1, op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7;
	op3 = funct7 >> 2;
	if ((funct7 & 3) == 0)
	  return instTable_.getEntry(InstId::fmsub_s);
	if ((funct7 & 3) == 1)
	  return instTable_.getEntry(InstId::fmsub_d);
      }
      return instTable_.getEntry(InstId::illegal);

    l18:
      {
	RFormInst rform(inst);
	op0 = rform.bits.rd, op1 = rform.bits.rs1, op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7;
	op3 = funct7 >> 2;
	if ((funct7 & 3) == 0)
	  return instTable_.getEntry(InstId::fnmsub_s);
	if ((funct7 & 3) == 1)
	  return instTable_.getEntry(InstId::fnmsub_d);
      }
      return instTable_.getEntry(InstId::illegal);

    l19:
      {
	RFormInst rform(inst);
	op0 = rform.bits.rd, op1 = rform.bits.rs1, op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7;
	op3 = funct7 >> 2;
	if ((funct7 & 3) == 0)
	  return instTable_.getEntry(InstId::fnmadd_s);
	if ((funct7 & 3) == 1)
	  return instTable_.getEntry(InstId::fnmadd_d);
      }
      return instTable_.getEntry(InstId::illegal);

    l20: // 10100
      return decodeFp(inst, op0, op1, op2, op3);

    l21: // 10101
      return decodeVec(inst, op0, op1, op2, op3);

    l22:
    l23:
    l26:
    l29:
    l30:
    l31:
      return instTable_.getEntry(InstId::illegal);

    l3: // 00011  I-form
      {
	IFormInst iform(inst);
	unsigned funct3 = iform.fields.funct3;
	if (iform.fields.rd == 0 and iform.fields.rs1 == 0)
	  {
	    if (funct3 == 0)
	      {
		if (iform.top4() == 0)
		  {
		    op0 = iform.pred();
		    op1 = iform.succ();
		    return instTable_.getEntry(InstId::fence);
		  }
	      }
	    else if (funct3 == 1)
	      {
		if (iform.uimmed() == 0)
		  return instTable_.getEntry(InstId::fencei);
	      }
	  }
      }
      return instTable_.getEntry(InstId::illegal);

    l4:  // 00100  I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.immed();
	unsigned funct3 = iform.fields.funct3;

	if      (funct3 == 0)  return instTable_.getEntry(InstId::addi);
	else if (funct3 == 1)
	  {
	    unsigned top5 = iform.uimmed() >> 7;
	    unsigned amt = iform.uimmed() & 0x7f;
	    if (top5 == 0)
	      {
		op2 = amt;
		return instTable_.getEntry(InstId::slli);
	      }
            else if (top5 == 1)
              {
                unsigned top6 = iform.uimmed() >> 6;
                if (top6 == 2)
                  {
                    op2 = amt & 0x3f;
                    return instTable_.getEntry(InstId::shfli);
                  }
              }
	    else if (top5 == 5)
	      {
		op2 = amt;
		return instTable_.getEntry(InstId::bseti);
	      }
	    else if (top5 == 8)
	      {
		if (amt == 0x18)
		  return instTable_.getEntry(InstId::rev8);
	      }
	    else if (top5 == 9)
	      {
		op2 = amt;
		return instTable_.getEntry(InstId::bclri);
	      }
	    else if (top5 == 0x0c)
	      {
		if (amt == 0)    return instTable_.getEntry(InstId::clz);
		if (amt == 1)    return instTable_.getEntry(InstId::ctz);
		if (amt == 2)    return instTable_.getEntry(InstId::cpop);
                if (amt == 0x04) return instTable_.getEntry(InstId::sext_b);
                if (amt == 0x05) return instTable_.getEntry(InstId::sext_h);
                if (amt == 0x10) return instTable_.getEntry(InstId::crc32_b);
                if (amt == 0x11) return instTable_.getEntry(InstId::crc32_h);
                if (amt == 0x12) return instTable_.getEntry(InstId::crc32_w);
                if (amt == 0x13) return instTable_.getEntry(InstId::crc32_d);
                if (amt == 0x18) return instTable_.getEntry(InstId::crc32c_b);
                if (amt == 0x19) return instTable_.getEntry(InstId::crc32c_h);
                if (amt == 0x1a) return instTable_.getEntry(InstId::crc32c_w);
                if (amt == 0x1b) return instTable_.getEntry(InstId::crc32c_d);
	      }
	    else if (top5 == 0x0d)
	      {
		op2 = amt;
                if (funct3 == 1)
                  return instTable_.getEntry(InstId::binvi);
	      }
	  }
	else if (funct3 == 2)  return instTable_.getEntry(InstId::slti);
	else if (funct3 == 3)  return instTable_.getEntry(InstId::sltiu);
	else if (funct3 == 4)  return instTable_.getEntry(InstId::xori);
	else if (funct3 == 5)
	  {
	    unsigned imm = iform.uimmed();  // 12-bit immediate
	    unsigned top5 = imm >> 7;
	    unsigned shamt = imm & 0x7f;    // Shift amount (low 7 bits of imm)
            if (shamt & 0x40)   // Bit 6 of shamt set.
              {
                op2 = top5;            // rs3 in op2
                op3 = shamt & 0x3f;    // least sig 6-bits of immediate in op3
                return instTable_.getEntry(InstId::fsri);
              }
                
	    op2 = shamt;
	    if (top5 == 0)
	      return instTable_.getEntry(InstId::srli);
            if (top5 == 1)
              {
                unsigned top6 = iform.uimmed() >> 6;
                if (top6 == 2)
                  {
                    op2 = shamt & 0x3f;
                    return instTable_.getEntry(InstId::unshfli);
                  }
              }
            if (top5 == 5)    return instTable_.getEntry(InstId::gorci);
	    if (top5 == 0x8)  return instTable_.getEntry(InstId::srai);
	    if (top5 == 0x9)  return instTable_.getEntry(InstId::bexti);
	    if (top5 == 0xc)  return instTable_.getEntry(InstId::rori);
            if (top5 == 0xd)  return instTable_.getEntry(InstId::grevi);
	  }
	else if (funct3 == 6)  return instTable_.getEntry(InstId::ori);
	else if (funct3 == 7)  return instTable_.getEntry(InstId::andi);
      }
      return instTable_.getEntry(InstId::illegal);

    l5:  // 00101   U-form
      {
	UFormInst uform(inst);
	op0 = uform.bits.rd;
	op1 = uform.immed();
	return instTable_.getEntry(InstId::auipc);
      }
      return instTable_.getEntry(InstId::illegal);

    l6:  // 00110  I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.immed();
	unsigned funct3 = iform.fields.funct3;
	if (funct3 == 0)
	  return instTable_.getEntry(InstId::addiw);
	else if (funct3 == 1)
	  {
	    if (iform.top7() == 0)
	      {
		op2 = iform.fields2.shamt;
		return instTable_.getEntry(InstId::slliw);
	      }
            if (iform.top5() == 1)
              {
                op2 = op2 & 0x7f;
                return instTable_.getEntry(InstId::slli_uw);
              }
            if (iform.top5() == 0x0c)
              {
                unsigned amt = iform.uimmed() & 0x7f;
		if (amt == 0)
		  return instTable_.getEntry(InstId::clzw);
		else if (amt == 1)
		  return instTable_.getEntry(InstId::ctzw);
		else if (amt == 2)
		  return instTable_.getEntry(InstId::cpopw);
              }
          }
	else if (funct3 == 5)
	  {
            if ((iform.top7() & 3) == 2)
              {
                op3 = iform.immed() >> 7;
                op2 = iform.immed() & 0x1f;
                return instTable_.getEntry(InstId::fsriw);
              }

	    op2 = iform.fields2.shamt;
	    if (iform.top7() == 0)    return instTable_.getEntry(InstId::srliw);
            if (iform.top7() == 0x14) return instTable_.getEntry(InstId::gorciw);
	    if (iform.top7() == 0x20) return instTable_.getEntry(InstId::sraiw);
            if (iform.top7() == 0x30) return instTable_.getEntry(InstId::roriw);
            if (iform.top7() == 0x34) return instTable_.getEntry(InstId::greviw);
	  }
      }
      return instTable_.getEntry(InstId::illegal);

    l8:  // 01000  S-form
      {
	// For the store instructions, the stored register is op0, the
	// base-address register is op1 and the offset is op2.
	SFormInst sform(inst);
	op0 = sform.bits.rs2;
	op1 = sform.bits.rs1;
	op2 = sform.immed();
	uint32_t funct3 = sform.bits.funct3;

	if (funct3 == 0) return instTable_.getEntry(InstId::sb);
	if (funct3 == 1) return instTable_.getEntry(InstId::sh);
	if (funct3 == 2) return instTable_.getEntry(InstId::sw);
	if (funct3 == 3 and isRv64()) return instTable_.getEntry(InstId::sd);
      }
      return instTable_.getEntry(InstId::illegal);

    l11:  // 01011  R-form atomics
      {
        RFormInst rf(inst);
        uint32_t top5 = rf.top5(), f3 = rf.bits.funct3;
        op0 = rf.bits.rd; op1 = rf.bits.rs1; op2 = rf.bits.rs2;

        if (f3 == 2)
          {
            if (top5 == 0)    return instTable_.getEntry(InstId::amoadd_w);
            if (top5 == 1)    return instTable_.getEntry(InstId::amoswap_w);
            if (top5 == 2)    return instTable_.getEntry(InstId::lr_w);
            if (top5 == 3)    return instTable_.getEntry(InstId::sc_w);
            if (top5 == 4)    return instTable_.getEntry(InstId::amoxor_w);
            if (top5 == 8)    return instTable_.getEntry(InstId::amoor_w);
            if (top5 == 0x0c) return instTable_.getEntry(InstId::amoand_w);
            if (top5 == 0x10) return instTable_.getEntry(InstId::amomin_w);
            if (top5 == 0x14) return instTable_.getEntry(InstId::amomax_w);
            if (top5 == 0x18) return instTable_.getEntry(InstId::amominu_w);
            if (top5 == 0x1c) return instTable_.getEntry(InstId::amomaxu_w);
          }
        else if (f3 == 3)
          {
            if (top5 == 0)    return instTable_.getEntry(InstId::amoadd_d);
            if (top5 == 1)    return instTable_.getEntry(InstId::amoswap_d);
            if (top5 == 2)    return instTable_.getEntry(InstId::lr_d);
            if (top5 == 3)    return instTable_.getEntry(InstId::sc_d);
            if (top5 == 4)    return instTable_.getEntry(InstId::amoxor_d);
            if (top5 == 8)    return instTable_.getEntry(InstId::amoor_d);
            if (top5 == 0xc)  return instTable_.getEntry(InstId::amoand_d);
            if (top5 == 0x10) return instTable_.getEntry(InstId::amomin_d);
            if (top5 == 0x14) return instTable_.getEntry(InstId::amomax_d);
            if (top5 == 0x18) return instTable_.getEntry(InstId::amominu_d);
            if (top5 == 0x1c) return instTable_.getEntry(InstId::amomaxu_d);
          }
      }
      return instTable_.getEntry(InstId::illegal);

    l12:  // 01100  R-form
      {
	RFormInst rform(inst);
	op0 = rform.bits.rd;
	op1 = rform.bits.rs1;
	op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7, funct3 = rform.bits.funct3;
	if (funct7 == 0)
	  {
	    if (funct3 == 0) return instTable_.getEntry(InstId::add);
	    if (funct3 == 1) return instTable_.getEntry(InstId::sll);
	    if (funct3 == 2) return instTable_.getEntry(InstId::slt);
	    if (funct3 == 3) return instTable_.getEntry(InstId::sltu);
	    if (funct3 == 4) return instTable_.getEntry(InstId::xor_);
	    if (funct3 == 5) return instTable_.getEntry(InstId::srl);
	    if (funct3 == 6) return instTable_.getEntry(InstId::or_);
	    if (funct3 == 7) return instTable_.getEntry(InstId::and_);
	  }
	else if (funct7 == 1)
	  {
	    if (not isRvm()) return instTable_.getEntry(InstId::illegal);
	    if (funct3 == 0) return instTable_.getEntry(InstId::mul);
	    if (funct3 == 1) return instTable_.getEntry(InstId::mulh);
	    if (funct3 == 2) return instTable_.getEntry(InstId::mulhsu);
	    if (funct3 == 3) return instTable_.getEntry(InstId::mulhu);
	    if (funct3 == 4) return instTable_.getEntry(InstId::div);
	    if (funct3 == 5) return instTable_.getEntry(InstId::divu);
	    if (funct3 == 6) return instTable_.getEntry(InstId::rem);
	    if (funct3 == 7) return instTable_.getEntry(InstId::remu);
	  }
/* INSERT YOUR CODE FROM HERE */  
  else if(funct7 == 2)
    {
      // cube
      if (funct3 == 0) return instTable_.getEntry(InstId::cube);
      // rotleft
      if (funct3 == 1) return instTable_.getEntry(InstId::rotleft);
      // rotright
      if (funct3 == 2) return instTable_.getEntry(InstId::rotright);
      // reverse
      if (funct3 == 3) return instTable_.getEntry(InstId::reverse);
      // notand
      if (funct3 == 4) return instTable_.getEntry(InstId::notand);
      // xoradd
      if (funct3 == 5) return instTable_.getEntry(InstId::xoradd);
    }
/* INSERT YOUR CODE END HERE */
	else if (funct7 == 4)
	  {
            if (funct3 == 1) return instTable_.getEntry(InstId::shfl);
	    if (funct3 == 3) return instTable_.getEntry(InstId::bmator);
	    if (funct3 == 4) return instTable_.getEntry(InstId::pack);
            if (funct3 == 5) return instTable_.getEntry(InstId::unshfl);
            if (funct3 == 6) return instTable_.getEntry(InstId::bcompress);
            if (funct3 == 7) return instTable_.getEntry(InstId::packh);
	  }
	else if (funct7 == 5)
	  {
	    if (funct3 == 1) return instTable_.getEntry(InstId::clmul);
	    if (funct3 == 2) return instTable_.getEntry(InstId::clmulr);
	    if (funct3 == 3) return instTable_.getEntry(InstId::clmulh);
	    if (funct3 == 4) return instTable_.getEntry(InstId::min);
	    if (funct3 == 6) return instTable_.getEntry(InstId::max);
	    if (funct3 == 5) return instTable_.getEntry(InstId::minu);
	    if (funct3 == 7) return instTable_.getEntry(InstId::maxu);
	  }
	else if (funct7 == 0x10)
	  {
            if (funct3 == 2) return instTable_.getEntry(InstId::sh1add);
            if (funct3 == 4) return instTable_.getEntry(InstId::sh2add);
            if (funct3 == 6) return instTable_.getEntry(InstId::sh3add);
	  }
	else if (funct7 == 0x14)
	  {
	    if (funct3 == 0) return instTable_.getEntry(InstId::xperm_w);
	    if (funct3 == 1) return instTable_.getEntry(InstId::bset);
	    if (funct3 == 2) return instTable_.getEntry(InstId::xperm_n);
	    if (funct3 == 4) return instTable_.getEntry(InstId::xperm_b);
	    if (funct3 == 6) return instTable_.getEntry(InstId::xperm_h);
            if (funct3 == 5) return instTable_.getEntry(InstId::gorc);
	  }
	else if (funct7 == 0x20)
	  {
	    if (funct3 == 0) return instTable_.getEntry(InstId::sub);
	    if (funct3 == 4) return instTable_.getEntry(InstId::xnor);
	    if (funct3 == 5) return instTable_.getEntry(InstId::sra);
	    if (funct3 == 6) return instTable_.getEntry(InstId::orn);
	    if (funct3 == 7) return instTable_.getEntry(InstId::andn);
	  }
	else if (funct7 == 0x24)
	  {
	    if (funct3 == 1) return instTable_.getEntry(InstId::bclr);
            if (funct3 == 3) return instTable_.getEntry(InstId::bmatxor);
            if (funct3 == 4) return instTable_.getEntry(InstId::packu);
            if (funct3 == 6) return instTable_.getEntry(InstId::bdecompress);
	    if (funct3 == 5) return instTable_.getEntry(InstId::bext);
            if (funct3 == 7) return instTable_.getEntry(InstId::bfp);
	  }
	else if (funct7 == 0x30)
	  {
	    if (funct3 == 1) return instTable_.getEntry(InstId::rol);
	    if (funct3 == 5) return instTable_.getEntry(InstId::ror);
	  }
	else if (funct7 == 0x34)
	  {
	    if (funct3 == 1) return instTable_.getEntry(InstId::binv);
            if (funct3 == 5) return instTable_.getEntry(InstId::grev);
	  }
        else if (funct7 & 2)
          {
            op3 = funct7 >> 2;
            if ((funct7 & 3) == 3)
              {
                if (funct3 == 1)  return instTable_.getEntry(InstId::cmix);
                if (funct3 == 5)  return instTable_.getEntry(InstId::cmov);
              }
            else if ((funct7 & 3) == 2)
              {
                if (funct3 == 1)  return instTable_.getEntry(InstId::fsl);
                if (funct3 == 5)  return instTable_.getEntry(InstId::fsr);
              }
          }
      }
      return instTable_.getEntry(InstId::illegal);

    l13:  // 01101  U-form
      {
	UFormInst uform(inst);
	op0 = uform.bits.rd;
	op1 = uform.immed();
	return instTable_.getEntry(InstId::lui);
      }

    l14: // 01110  R-Form
      {
	const RFormInst rform(inst);
	op0 = rform.bits.rd;
	op1 = rform.bits.rs1;
	op2 = rform.bits.rs2;
	unsigned funct7 = rform.bits.funct7, funct3 = rform.bits.funct3;
        if ((funct7 & 3) == 2)
          {
	    if (funct3 == 1) return instTable_.getEntry(InstId::fslw);
	    if (funct3 == 5) return instTable_.getEntry(InstId::fsrw);
          }
        else if (funct7 == 0)
	  {
	    if (funct3 == 0) return instTable_.getEntry(InstId::addw);
	    if (funct3 == 1) return instTable_.getEntry(InstId::sllw);
	    if (funct3 == 5) return instTable_.getEntry(InstId::srlw);
	  }
	else if (funct7 == 1)
	  {
	    if (funct3 == 0) return instTable_.getEntry(InstId::mulw);
	    if (funct3 == 4) return instTable_.getEntry(InstId::divw);
	    if (funct3 == 5) return instTable_.getEntry(InstId::divuw);
	    if (funct3 == 6) return instTable_.getEntry(InstId::remw);
	    if (funct3 == 7) return instTable_.getEntry(InstId::remuw);
	  }
        else if (funct7 == 4)
          {
            if (funct3 == 0) return instTable_.getEntry(InstId::add_uw);
            if (funct3 == 1) return instTable_.getEntry(InstId::shflw);
            if (funct3 == 4) return instTable_.getEntry(InstId::packw);
            if (funct3 == 5) return instTable_.getEntry(InstId::unshflw);
            if (funct3 == 6) return instTable_.getEntry(InstId::bcompressw);
          }
	else if (funct7 == 0x10)
          {
            if (funct3 == 2) return instTable_.getEntry(InstId::sh1add_uw);
            if (funct3 == 4) return instTable_.getEntry(InstId::sh2add_uw);
            if (funct3 == 6) return instTable_.getEntry(InstId::sh3add_uw);
          }
	else if (funct7 == 0x14)
          {
            if (funct3 == 5) return instTable_.getEntry(InstId::gorcw);
          }
	else if (funct7 == 0x20)
	  {
	    if (funct3 == 0)  return instTable_.getEntry(InstId::subw);
	    if (funct3 == 5)  return instTable_.getEntry(InstId::sraw);
	  }
	else if (funct7 == 0x24)
	  {
            if (funct3 == 4) return instTable_.getEntry(InstId::packuw);
            if (funct3 == 6) return instTable_.getEntry(InstId::bdecompressw);
            if (funct3 == 7) return instTable_.getEntry(InstId::bfpw);
	  }
        else if (funct7 == 0x30)
          {
            if (funct3 == 1) return instTable_.getEntry(InstId::rolw);
            if (funct3 == 5) return instTable_.getEntry(InstId::rorw);
          }
	else if (funct7 == 0x34)
          {
            if (funct3 == 5) return instTable_.getEntry(InstId::grevw);
          }
      }
      return instTable_.getEntry(InstId::illegal);

    l24: // 11000   B-form
      {
	BFormInst bform(inst);
	op0 = bform.bits.rs1;
	op1 = bform.bits.rs2;
	op2 = bform.immed();
	uint32_t funct3 = bform.bits.funct3;
	if (funct3 == 0)  return instTable_.getEntry(InstId::beq);
	if (funct3 == 1)  return instTable_.getEntry(InstId::bne);
	if (funct3 == 4)  return instTable_.getEntry(InstId::blt);
	if (funct3 == 5)  return instTable_.getEntry(InstId::bge);
	if (funct3 == 6)  return instTable_.getEntry(InstId::bltu);
	if (funct3 == 7)  return instTable_.getEntry(InstId::bgeu);
      }
      return instTable_.getEntry(InstId::illegal);

    l25:  // 11001  I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.immed();
	if (iform.fields.funct3 == 0)
	  return instTable_.getEntry(InstId::jalr);
      }
      return instTable_.getEntry(InstId::illegal);

    l27:  // 11011  J-form
      {
	JFormInst jform(inst);
	op0 = jform.bits.rd;
	op1 = jform.immed();
	return instTable_.getEntry(InstId::jal);
      }

    l28:  // 11100  I-form
      {
	IFormInst iform(inst);
	op0 = iform.fields.rd;
	op1 = iform.fields.rs1;
	op2 = iform.uimmed(); // csr
	switch (iform.fields.funct3)
	  {
	  case 0:
	    {
	      uint32_t funct7 = op2 >> 5;
	      if (funct7 == 0) // ecall ebreak uret
		{
		  if (op1 != 0 or op0 != 0)
		    return instTable_.getEntry(InstId::illegal);
		  else if (op2 == 0)
		    return instTable_.getEntry(InstId::ecall);
		  else if (op2 == 1)
		    return instTable_.getEntry(InstId::ebreak);
		  else if (op2 == 2)
		    return instTable_.getEntry(InstId::uret);
		}
	      else if (funct7 == 9)
		{
		  if (op0 != 0)
		    return instTable_.getEntry(InstId::illegal);
		  else // sfence.vma
                    {
                      op2 = iform.rs2();
                      return instTable_.getEntry(InstId::sfence_vma);
                    }
		}
	      else if (op2 == 0x102)
		return instTable_.getEntry(InstId::sret);
	      else if (op2 == 0x302)
		return instTable_.getEntry(InstId::mret);
	      else if (op2 == 0x105)
		return instTable_.getEntry(InstId::wfi);
	    }
	    break;
	  case 1:  return instTable_.getEntry(InstId::csrrw);
	  case 2:  return instTable_.getEntry(InstId::csrrs);
	  case 3:  return instTable_.getEntry(InstId::csrrc);
	  case 5:  return instTable_.getEntry(InstId::csrrwi);
	  case 6:  return instTable_.getEntry(InstId::csrrsi);
	  case 7:  return instTable_.getEntry(InstId::csrrci);
	  default: return instTable_.getEntry(InstId::illegal);
	  }
	return instTable_.getEntry(InstId::illegal);
      }
    }
  else
    return instTable_.getEntry(InstId::illegal);
}


template class WdRiscv::Hart<uint32_t>;
template class WdRiscv::Hart<uint64_t>;
