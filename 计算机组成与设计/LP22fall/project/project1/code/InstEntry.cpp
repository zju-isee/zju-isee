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

#include <cassert>
#include "InstEntry.hpp"

using namespace WdRiscv;

InstEntry::InstEntry(std::string name, InstId id,
		     uint32_t code, uint32_t mask,
		     InstType type,
		     OperandType op0Type, OperandMode op0Mode, uint32_t op0Mask,
		     OperandType op1Type, OperandMode op1Mode, uint32_t op1Mask,
		     OperandType op2Type, OperandMode op2Mode, uint32_t op2Mask,
		     OperandType op3Type, OperandMode op3Mode, uint32_t op3Mask)
  : name_(name), id_(id), code_(code), codeMask_(mask), type_(type),
    op0Mask_(op0Mask), op1Mask_(op1Mask), op2Mask_(op2Mask), op3Mask_(op3Mask),
    op0Type_(op0Type), op1Type_(op1Type), op2Type_(op2Type), op3Type_(op3Type),
    op0Mode_(op0Mode), op1Mode_(op1Mode), op2Mode_(op2Mode), op3Mode_(op3Mode),
    opCount_(0)
{
  unsigned count = 0;

  if (op0Type != OperandType::None) count++;
  if (op1Type != OperandType::None) count++;
  if (op2Type != OperandType::None) count++;
  if (op3Type != OperandType::None) count++;
  opCount_ = count;
  isBitManip_ = type >= InstType::Zba and type <= InstType::Zbt;
}


InstTable::InstTable()
{
  setupInstVec();

  // Sanity check.
  for (unsigned i = 0; InstId(i) <= InstId::maxId; ++i)
    {
      InstId id = InstId(i);
      assert(instVec_.at(i).instId() == id);
    }

  for (const auto& instInfo : instVec_)
    instMap_[instInfo.name()] = instInfo.instId();

  // Mark instructions with unsigned source opreands.
  instVec_.at(size_t(InstId::bltu))     .setIsUnsigned(true);
  instVec_.at(size_t(InstId::bgeu))     .setIsUnsigned(true);
  instVec_.at(size_t(InstId::sltiu))    .setIsUnsigned(true);
  instVec_.at(size_t(InstId::sltu))     .setIsUnsigned(true);
  instVec_.at(size_t(InstId::mulhsu))   .setIsUnsigned(true);
  instVec_.at(size_t(InstId::mulhu))    .setIsUnsigned(true);
  instVec_.at(size_t(InstId::divu))     .setIsUnsigned(true);
  instVec_.at(size_t(InstId::remu))     .setIsUnsigned(true);

  // Set data size of load instructions.
  instVec_.at(size_t(InstId::lb))      .setLoadSize(1);
  instVec_.at(size_t(InstId::lh))      .setLoadSize(2);
  instVec_.at(size_t(InstId::lw))      .setLoadSize(4);
  instVec_.at(size_t(InstId::lbu))     .setLoadSize(1);
  instVec_.at(size_t(InstId::lhu))     .setLoadSize(2);
  instVec_.at(size_t(InstId::lwu))     .setLoadSize(4);
  instVec_.at(size_t(InstId::ld))      .setLoadSize(8);
  instVec_.at(size_t(InstId::lr_w))    .setLoadSize(4);
  instVec_.at(size_t(InstId::lr_d))    .setLoadSize(8);
  instVec_.at(size_t(InstId::flw))     .setLoadSize(4);
  instVec_.at(size_t(InstId::fld))     .setLoadSize(8);
  instVec_.at(size_t(InstId::c_fld))   .setLoadSize(8);
  instVec_.at(size_t(InstId::c_lq))    .setLoadSize(16);
  instVec_.at(size_t(InstId::c_lw))    .setLoadSize(4);
  instVec_.at(size_t(InstId::c_flw))   .setLoadSize(4);
  instVec_.at(size_t(InstId::c_ld))    .setLoadSize(8);
  instVec_.at(size_t(InstId::c_fldsp)) .setLoadSize(8);
  instVec_.at(size_t(InstId::c_lwsp))  .setLoadSize(4);
  instVec_.at(size_t(InstId::c_flwsp)) .setLoadSize(4);
  instVec_.at(size_t(InstId::c_ldsp))  .setLoadSize(8);

  // Set data size of store instructions.
  instVec_.at(size_t(InstId::sb))      .setStoreSize(1);
  instVec_.at(size_t(InstId::sh))      .setStoreSize(2);
  instVec_.at(size_t(InstId::sw))      .setStoreSize(4);
  instVec_.at(size_t(InstId::sd))      .setStoreSize(8);
  instVec_.at(size_t(InstId::sc_w))    .setStoreSize(4);
  instVec_.at(size_t(InstId::sc_d))    .setStoreSize(8);
  instVec_.at(size_t(InstId::fsw))     .setStoreSize(4);
  instVec_.at(size_t(InstId::fsd))     .setStoreSize(8);
  instVec_.at(size_t(InstId::c_fsd))   .setStoreSize(8);
  instVec_.at(size_t(InstId::c_sq))    .setStoreSize(16);
  instVec_.at(size_t(InstId::c_sw))    .setStoreSize(4);
  instVec_.at(size_t(InstId::c_flw))   .setStoreSize(4);
  instVec_.at(size_t(InstId::c_sd))    .setStoreSize(8);
  instVec_.at(size_t(InstId::c_fsdsp)) .setStoreSize(8);
  instVec_.at(size_t(InstId::c_swsp))  .setStoreSize(4);
  instVec_.at(size_t(InstId::c_fswsp)) .setStoreSize(4);
  instVec_.at(size_t(InstId::c_sdsp))  .setStoreSize(8);

  // Mark conditional branch instructions.
  instVec_.at(size_t(InstId::beq))    .setConditionalBranch(true);
  instVec_.at(size_t(InstId::bne))    .setConditionalBranch(true);
  instVec_.at(size_t(InstId::blt))    .setConditionalBranch(true);
  instVec_.at(size_t(InstId::bge))    .setConditionalBranch(true);
  instVec_.at(size_t(InstId::bltu))   .setConditionalBranch(true);
  instVec_.at(size_t(InstId::bgeu))   .setConditionalBranch(true);
  instVec_.at(size_t(InstId::c_beqz)) .setConditionalBranch(true);
  instVec_.at(size_t(InstId::c_bnez)) .setConditionalBranch(true);

  // Mark branch to register instructions.
  instVec_.at(size_t(InstId::jalr))   .setBranchToRegister(true);
  instVec_.at(size_t(InstId::c_jr))   .setBranchToRegister(true);
  instVec_.at(size_t(InstId::c_jalr)) .setBranchToRegister(true);
}


const InstEntry&
InstTable::getEntry(InstId id) const
{
  if (size_t(id) >= instVec_.size())
    return instVec_.front();
  return instVec_.at(size_t(id));
}


const InstEntry&
InstTable::getEntry(const std::string& name) const
{
  const auto iter = instMap_.find(name);
  if (iter == instMap_.end())
    return instVec_.front();
  auto id = iter->second;
  return getEntry(id);
}


void
InstTable::setupInstVec()
{
  uint32_t rdMask = 0x1f << 7;
  uint32_t rs1Mask = 0x1f << 15;
  uint32_t rs2Mask = 0x1f << 20;
  uint32_t rs3Mask = 0x1f << 27;
  uint32_t immTop20 = 0xfffff << 12;  // Immidiate: top 20 bits.
  uint32_t immTop12 = 0xfff << 20;   // Immidiate: top 12 bits.
  uint32_t immBeq = 0xfe000f80;
  uint32_t shamtMask = 0x01f00000;

  uint32_t low7Mask = 0x7f;                 // Opcode mask: lowest 7 bits
  uint32_t funct3Low7Mask = 0x707f;         // Funct3 and lowest 7 bits
  uint32_t fmaddMask = 0x0600007f;          // fmadd-like opcode mask.
  uint32_t faddMask = 0xfe00007f;           // fadd-like opcode mask
  uint32_t fsqrtMask = 0xfff0007f;          // fsqrt-like opcode mask
  uint32_t top7Funct3Low7Mask = 0xfe00707f; // Top7, Funct3 and lowest 7 bits

  instVec_ =
    {
      // Base instructions
      { "illegal", InstId::illegal, 0xffffffff, 0xffffffff },

      { "lui", InstId::lui, 0x37, low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, immTop20 },

      { "auipc", InstId::auipc, 0x17, low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, immTop20 },

      { "jal", InstId::jal, 0x6f, low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, immTop20 },

      { "jalr", InstId::jalr, 0x0067, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "beq", InstId::beq, 0x0063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "bne", InstId::bne, 0x1063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "blt", InstId::blt, 0x4063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "bge", InstId::bge, 0x5063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "bltu", InstId::bltu, 0x6063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "bgeu", InstId::bgeu, 0x7063, funct3Low7Mask,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "lb", InstId::lb, 0x0003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "lh", InstId::lh, 0x1003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "lw", InstId::lw, 0x2003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "lbu", InstId::lbu, 0x4003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "lhu", InstId::lhu, 0x5003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "sb", InstId::sb, 0x0023, funct3Low7Mask,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "sh", InstId::sh, 0x1023, funct3Low7Mask,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      // Stored register is op0.
      { "sw", InstId::sw, 0x2023, funct3Low7Mask,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "addi", InstId::addi, 0x0013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "slti", InstId::slti, 0x2013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "sltiu", InstId::sltiu, 0x3013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "xori", InstId::xori, 0x4013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "ori", InstId::ori, 0x6013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "andi", InstId::andi, 0x7013, funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "slli", InstId::slli, 0x1013, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "srli", InstId::srli, 0x5013, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "srai", InstId::srai, 0x40005013, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "add", InstId::add, 0x0033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sub", InstId::sub, 0x40000033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sll", InstId::sll, 0x1033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "slt", InstId::slt, 0x2033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sltu", InstId::sltu, 0x3033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xor", InstId::xor_, 0x4033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "srl", InstId::srl, 0x5033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sra", InstId::sra, 0x40005033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "or", InstId::or_, 0x6033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "and", InstId::and_, 0x7033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "fence", InstId::fence, 0x000f, 0x0000707f,
	InstType::Int,
	OperandType::Imm, OperandMode::None, 0x0f000000,
	OperandType::Imm, OperandMode::None, 0x00f00000 },

      { "fence.i", InstId::fencei, 0x100f, 0x0000707f },  // FIXME: Check mask.

      { "ecall", InstId::ecall, 0x00000073, 0xffffffff },
      { "ebreak", InstId::ebreak, 0x00100073, 0xffffffff },

      // CSR
      { "csrrw", InstId::csrrw, 0x1073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      { "csrrs", InstId::csrrs, 0x2073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      { "csrrc", InstId::csrrc, 0x3073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      { "csrrwi", InstId::csrrwi,  0x5073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      { "csrrsi", InstId::csrrsi, 0x6073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      { "csrrci", InstId::csrrci, 0x7073, funct3Low7Mask,
	InstType::Csr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::Imm, OperandMode::None, rs1Mask,
	OperandType::CsReg, OperandMode::ReadWrite, immTop12 },

      // rv64i
      { "lwu", InstId::lwu, 0x06003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },
	
      { "ld", InstId::ld, 0x3003, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "sd", InstId::sd, 0x3023, funct3Low7Mask,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "addiw", InstId::addiw, 0x001b, 0x707f,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "slliw", InstId::slliw, 0x101b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "srliw", InstId::srliw, 0x501b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "sraiw", InstId::sraiw, 0x4000501b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "addw", InstId::addw, 0x003b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "subw", InstId::subw, 0x4000003b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sllw", InstId::sllw, 0x103b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "srlw", InstId::srlw, 0x503b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sraw", InstId::sraw, 0x4000503b, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      // Mul/div
      { "mul", InstId::mul, 0x02000033, top7Funct3Low7Mask,
	InstType::Multiply,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "mulh", InstId::mulh, 0x02001033, top7Funct3Low7Mask,
	InstType::Multiply,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "mulhsu", InstId::mulhsu, 0x02002033, top7Funct3Low7Mask,
	InstType::Multiply,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "mulhu", InstId::mulhu, 0x02003033, top7Funct3Low7Mask,
	InstType::Multiply,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "div", InstId::div, 0x02004033, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "divu", InstId::divu, 0x02005033, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "rem", InstId::rem, 0x02006033, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "remu", InstId::remu, 0x02007033, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      // 64-bit mul/div
      { "mulw", InstId::mulw, 0x0200003b, top7Funct3Low7Mask,
	InstType::Multiply,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "divw", InstId::divw, 0x0200403b, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "divuw", InstId::divuw, 0x0200503b, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "remw", InstId::remw, 0x0200603b, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "remuw", InstId::remuw, 0x0200703b, top7Funct3Low7Mask,
	InstType::Divide,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      // Atomic
      { "lr.w", InstId::lr_w, 0x1000202f, 0xf9f0707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "sc.w", InstId::sc_w, 0x1800202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoswap.w", InstId::amoswap_w, 0x0800202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoadd.w", InstId::amoadd_w, 0x0000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoxor.w", InstId::amoxor_w, 0x2000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoand.w", InstId::amoand_w, 0x6000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoor.w", InstId::amoor_w, 0x4000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomin.w", InstId::amomin_w, 0x8000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomax.w", InstId::amomax_w, 0xa000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amominu.w", InstId::amominu_w, 0xc000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomaxu.w", InstId::amomaxu_w, 0xe000202f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      // 64-bit atomic
      { "lr.d", InstId::lr_d, 0x1000302f, 0xf9f0707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "sc.d", InstId::sc_d, 0x1800302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoswap.d", InstId::amoswap_d, 0x0800302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoadd.d", InstId::amoadd_d, 0x0000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoxor.d", InstId::amoxor_d, 0x2000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoand.d", InstId::amoand_d, 0x6000302f, 0xf800070f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amoor.d", InstId::amoor_d, 0x4000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomin.d", InstId::amomin_d, 0x8000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomax.d", InstId::amomax_d, 0xa000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amominu.d", InstId::amominu_d, 0xc000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "amomaxu.d", InstId::amomaxu_d, 0xe000302f, 0xf800707f,
	InstType::Atomic,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      // rv32f
      { "flw", InstId::flw, 0x2007, funct3Low7Mask,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      // Stored register is in op0.
      { "fsw", InstId::fsw, 0x2027, funct3Low7Mask,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "fmadd.s", InstId::fmadd_s, 0x43, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fmsub.s", InstId::fmsub_s, 0x47, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fnmsub.s", InstId::fnmsub_s, 0x4b, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fnmadd.s", InstId::fnmadd_s, 0x4f, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fadd.s", InstId::fadd_s, 0x0053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsub.s", InstId::fsub_s, 0x08000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmul.s", InstId::fmul_s, 0x10000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fdiv.s", InstId::fdiv_s, 0x18000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsqrt.s", InstId::fsqrt_s, 0x58000053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fsgnj.s", InstId::fsgnj_s, 0x20000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsgnjn.s", InstId::fsgnjn_s, 0x20001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsgnjx.s", InstId::fsgnjx_s, 0x20002053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmin.s", InstId::fmin_s, 0x28000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmax.s", InstId::fmax_s, 0x28001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fcvt.w.s", InstId::fcvt_w_s, 0xc0000053, fsqrtMask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.wu.s", InstId::fcvt_wu_s, 0xc0100053, fsqrtMask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fmv.x.w", InstId::fmv_x_w, 0xe0000053, 0xfff0707f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "feq.s", InstId::feq_s, 0xa0002053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "flt.s", InstId::flt_s, 0xa0001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fle.s", InstId::fle_s, 0xa0000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fclass.s", InstId::fclass_s, 0xe0001053, 0xfff0707f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.s.w", InstId::fcvt_s_w, 0xd0000053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fcvt.s.wu", InstId::fcvt_s_wu, 0xd0100053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fmv.w.x", InstId::fmv_w_x, 0xf0000053, 0xfff0707f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      // rv64f
      { "fcvt.l.s", InstId::fcvt_l_s, 0xc0200053, 0xfff0007f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.lu.s", InstId::fcvt_lu_s, 0xc0300053, 0xfff0007f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.s.l", InstId::fcvt_s_l, 0xd0200053, 0xfff0007f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fcvt.s.lu", InstId::fcvt_s_lu, 0xd0300053, 0xfff0007f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      // rv32d
      { "fld", InstId::fld, 0x3007, funct3Low7Mask,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      { "fsd", InstId::fsd, 0x3027, funct3Low7Mask,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      { "fmadd.d", InstId::fmadd_d, 0x02000043, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fmsub.d", InstId::fmsub_d, 0x02000047, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fnmsub.d", InstId::fnmsub_d, 0x0200004b, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fnmadd.d", InstId::fnmadd_d, 0x0200004f, fmaddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask,
	OperandType::FpReg, OperandMode::Read, rs3Mask },

      { "fadd.d", InstId::fadd_d, 0x02000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsub.d", InstId::fsub_d, 0x0a000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmul.d", InstId::fmul_d, 0x12000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fdiv.d", InstId::fdiv_d, 0x1a000053, faddMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsqrt.d", InstId::fsqrt_d, 0x5a000053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fsgnj.d", InstId::fsgnj_d, 0x22000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsgnjn.d", InstId::fsgnjn_d, 0x22001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fsgnjx.d", InstId::fsgnjx_d, 0x22002053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmin.d", InstId::fmin_d, 0x2a000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fmax.d", InstId::fmax_d, 0x2a001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fcvt.s.d", InstId::fcvt_s_d, 0x40100053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.d.s", InstId::fcvt_d_s, 0x42000053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "feq.d", InstId::feq_d, 0xa2002053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "flt.d", InstId::flt_d, 0xa2001053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fle.d", InstId::fle_d, 0xa2000053, top7Funct3Low7Mask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask,
	OperandType::FpReg, OperandMode::Read, rs2Mask },

      { "fclass.d", InstId::fclass_d, 0xe2001053, 0xfff0707f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.w.d", InstId::fcvt_w_d, 0xc2000053, 0xfff1c07f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.wu.d", InstId::fcvt_wu_d, 0xc2100053, fsqrtMask,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.d.w", InstId::fcvt_d_w, 0xd2000053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fcvt.d.wu", InstId::fcvt_d_wu, 0xd2100053, fsqrtMask,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      // rv64f + rv32d
      { "fcvt.l.d", InstId::fcvt_l_d, 0xc2200053, 0xfff0007f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.lu.d", InstId::fcvt_lu_d, 0xc2300053, 0xfff0007f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fmv.x.d", InstId::fmv_x_d, 0xe2000053, 0xfff0707f,
	InstType::Fp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::FpReg, OperandMode::Read, rs1Mask },

      { "fcvt.d.l", InstId::fcvt_d_l, 0xd2200053, 0xfff0007f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fcvt.d.lu", InstId::fcvt_d_lu, 0xd2300053, 0xfff0007f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "fmv.d.x", InstId::fmv_d_x, 0xf2000053, 0xfff0707f,
	InstType::Fp,
	OperandType::FpReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      // Privileged
      { "mret", InstId::mret, 0x30200073, 0xffffffff, InstType::Int },
      { "uret", InstId::uret, 0x00200073, 0xffffffff, InstType::Int },
      { "sret", InstId::sret, 0x10200073, 0xffffffff, InstType::Int },
      { "wfi", InstId::wfi, 0x10500073, 0xffffffff, InstType::Int },

      // Supervisor
      { "sfence.vma", InstId::sfence_vma, 0x12000073, 0xfe00707f,
        InstType::Int,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask
      },

      // Compressed insts. The operand bits are "swizzled" and the
      // operand masks are not used for obtaining operands. We set the
      // operand masks to zero.
      { "c.addi4spn", InstId::c_addi4spn, 0x0000, 0xe003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.fld", InstId::c_fld, 0x2000, 0xe003,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.lq", InstId::c_lq, 0x2000, 0xe003, 
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.lw", InstId::c_lw, 0x4000, 0xe003,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.flw", InstId::c_flw, 0x6000, 0xe003,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.ld", InstId::c_ld, 0x6000, 0xe003,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.fsd", InstId::c_fsd, 0xa000, 0xe003,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.sq", InstId::c_sq, 0xa000, 0xe003,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.sw", InstId::c_sw, 0xc000, 0xe003,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.fsw", InstId::c_fsw, 0xe000, 0xe003,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.sd", InstId::c_sd, 0xe000, 0xe003,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.addi", InstId::c_addi, 0x0001, 0xe003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0xf80,
	OperandType::IntReg, OperandMode::Read, 0xf80,
	OperandType::Imm, OperandMode::None, 0x107c },

      { "c.jal", InstId::c_jal, 0x2001, 0xe003,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.li", InstId::c_li, 0x4001, 0xe003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.addi16sp", InstId::c_addi16sp, 0x6101, 0xef83,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.lui", InstId::c_lui, 0x6001, 0xe003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.srli", InstId::c_srli, 0x8001, 0xfc03,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.srli64", InstId::c_srli64, 0x8001, 0xfc83,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.srai", InstId::c_srai, 0x8401, 0x9c03,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.srai64", InstId::c_srai64, 0x8401, 0xfc83,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.andi", InstId::c_andi, 0x8801, 0xec03,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.sub", InstId::c_sub, 0x8c01, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.xor", InstId::c_xor, 0x8c21, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.or", InstId::c_or, 0x8c41, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.and", InstId::c_and, 0x8c61, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.subw", InstId::c_subw, 0x9c01, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.addw", InstId::c_addw, 0x9c21, 0xfc63,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.j", InstId::c_j, 0xa001, 0xe003,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.beqz", InstId::c_beqz, 0xc001, 0xe003,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.bnez", InstId::c_bnez, 0xe001, 0xe003,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.slli", InstId::c_slli, 0x0002, 0xf003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.slli64", InstId::c_slli64, 0x0002, 0xf083,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.fldsp", InstId::c_fldsp, 0x2002, 0xe003,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.lwsp", InstId::c_lwsp, 0x4002, 0xe003,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.flwsp", InstId::c_flwsp, 0x6002, 0xe003,
	InstType::Load,
	OperandType::FpReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.ldsp", InstId::c_ldsp, 0x6002, 0xe003,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.jr", InstId::c_jr, 0x8002, 0xf07f,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.mv", InstId::c_mv, 0x8002, 0xf003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0 },

      { "c.ebreak", InstId::c_ebreak, 0x9002, 0xffff },

      { "c.jalr", InstId::c_jalr, 0x9002, 0xf07f,
	InstType::Branch,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.add", InstId::c_add, 0x9002, 0xf003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0xf80,
	OperandType::IntReg, OperandMode::Read, 0xf80,
	OperandType::IntReg, OperandMode::Read, 0x07c },

      { "c.fsdsp", InstId::c_fsdsp, 0xa002, 0xe003,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.swsp", InstId::c_swsp, 0xc002, 0xe003,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.fswsp", InstId::c_fswsp, 0xe002, 0xe003,
	InstType::Store,
	OperandType::FpReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.addiw", InstId::c_addiw, 0x2001, 0xe003,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "c.sdsp", InstId::c_sdsp, 0xe002, 0xe003,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::IntReg, OperandMode::Read, 0,
	OperandType::Imm, OperandMode::None, 0 },

      { "clz", InstId::clz, 0x60001013, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "ctz", InstId::ctz, 0x60101013, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "cpop", InstId::cpop, 0x60201013, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "clzw", InstId::clzw, 0x6000101b, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "ctzw", InstId::ctzw, 0x6010101b, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "cpopw", InstId::cpopw, 0x6020101b, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "min", InstId::min, 0x0a004033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "max", InstId::max, 0x0a006033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "minu", InstId::minu, 0x0a005033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "maxu", InstId::maxu, 0x0a007033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sext.b", InstId::sext_b, 0x60401013, 0xfff0707f,
        InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "sext.h", InstId::sext_h, 0x60501013, 0xfff0707f,
        InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "andn", InstId::andn, 0x40007033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "orn", InstId::orn, 0x40006033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xnor", InstId::xnor, 0x40004033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "rol", InstId::rol, 0x60001033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "ror", InstId::ror, 0x60005033, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "rori", InstId::rori, 0x60005013, 0xf800707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "rolw", InstId::rolw, 0x6000103b, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "rorw", InstId::rorw, 0x6000503b, top7Funct3Low7Mask,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "roriw", InstId::roriw, 0x6000501b, 0xfe00707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "rev8", InstId::rev8, 0x69805013, 0xfff0707f,
	InstType::Zbb,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "pack", InstId::pack, 0x08004033, top7Funct3Low7Mask,
	InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "packh", InstId::packh, 0x08007033, top7Funct3Low7Mask,
        InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "packu", InstId::packu, 0x48004033, top7Funct3Low7Mask,
        InstType::Zbm,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "packw", InstId::packw, 0x0800403b, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "packuw", InstId::packuw, 0x4800403b, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "grev", InstId::grev, 0x68005033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "grevi", InstId::grevi, 0x68005013, 0xf800707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "grevw", InstId::grevw, 0x6800503B, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "greviw", InstId::greviw, 0x6800501b, 0xfe00707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "gorc", InstId::gorc, 0x28005033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "gorci", InstId::gorci, 0x28005013, 0xf800707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "gorcw", InstId::gorcw, 0x2800503B, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "gorciw", InstId::gorciw, 0x2800501b, 0xf800707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "shfl", InstId::shfl, 0x8001033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "shflw", InstId::shflw, 0x800103b, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "shfli", InstId::shfli, 0x10001013, 0xf800707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "unshfl", InstId::unshfl, 0x8005033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "unshfli", InstId::unshfli, 0x10005013, 0xf800707f,
	InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "unshflw", InstId::unshflw, 0x0800106b, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xperm.n", InstId::xperm_n, 0x28002033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xperm.b", InstId::xperm_b, 0x28004033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xperm.h", InstId::xperm_h, 0x28006033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xperm.w", InstId::xperm_w, 0x28000033, top7Funct3Low7Mask,
        InstType::Zbp,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bset", InstId::bset, 0x28001033, top7Funct3Low7Mask,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bclr", InstId::bclr, 0x48001033, top7Funct3Low7Mask,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "binv", InstId::binv, 0x68001033, top7Funct3Low7Mask,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bext", InstId::bext, 0x08006033, top7Funct3Low7Mask,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bseti", InstId::bseti, 0x28001013, 0xf800707f,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "bclri", InstId::bclri, 0x48001013, 0xf800707f,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "binvi", InstId::binvi, 0x68001013, 0xf800707f,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "bexti", InstId::bexti, 0x48005013, 0xf800707f,
	InstType::Zbs,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      { "bcompress", InstId::bcompress, 0x08006033, top7Funct3Low7Mask,
	InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bdecompress", InstId::bdecompress, 0x48006033, top7Funct3Low7Mask,
	InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bcompressw", InstId::bcompressw, 0x0800603b, top7Funct3Low7Mask,
	InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bdecompressw", InstId::bdecompressw, 0x4800603b, top7Funct3Low7Mask,
	InstType::Zbe,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bfp", InstId::bfp, 0x08007033, top7Funct3Low7Mask,
	InstType::Zbf,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bfpw", InstId::bfpw, 0x4800703b, top7Funct3Low7Mask,
	InstType::Zbf,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "clmul", InstId::clmul, 0x0a001033, top7Funct3Low7Mask,
	InstType::Zbc,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "clmulh", InstId::clmulh, 0x0a003033, top7Funct3Low7Mask,
	InstType::Zbc,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "clmulr", InstId::clmulr, 0x0a002033, top7Funct3Low7Mask,
	InstType::Zbc,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh1add", InstId::sh1add, 0x20002033, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh2add", InstId::sh2add, 0x20004033, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh3add", InstId::sh3add, 0x20006033, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh1add.uw", InstId::sh1add_uw, 0x2000203B, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh2add.uw", InstId::sh2add_uw, 0x2000403B, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "sh3add.uw", InstId::sh3add_uw, 0x2000603B, top7Funct3Low7Mask,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "add.uw", InstId::add_uw, 0x800003b, top7Funct3Low7Mask,
        InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "slli.uw", InstId::slli_uw, 0x0800101b, 0xf800707f,
	InstType::Zba,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, shamtMask },

      // zbr

      { "crc32_b", InstId::crc32_b, 0x61001013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32_h", InstId::crc32_h, 0x61101013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32_w", InstId::crc32_w, 0x61201013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32_d", InstId::crc32_d, 0x61301013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32c_b", InstId::crc32c_b, 0x61801013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32c_h", InstId::crc32c_h, 0x61901013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32c_w", InstId::crc32c_w, 0x61A01013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "crc32c_d", InstId::crc32c_d, 0x61B01013, 0xfff0707f,
        InstType::Zbr,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "bmator", InstId::bmator, 0x08003033, top7Funct3Low7Mask,
        InstType::Zbm,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bmatxor", InstId::bmatxor, 0x48003033, top7Funct3Low7Mask,
        InstType::Zbm,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "bmatflip", InstId::bmatflip, 0x60301013, 0xfff0707f,
        InstType::Zbm,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask },

      { "cmov", InstId::cmov, 0x6005033, 0x600707F,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "cmix", InstId::cmix, 0x6001033, 0xfff0707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "fsl", InstId::fsl, 0x040001033, 0xfff0707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "fsr", InstId::fsr, 0x04005033, 0xfff0707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "fsri", InstId::fsri, 0x04005013, 0xfff0707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask,
        OperandType::IntReg, OperandMode::Read, 0x03f000000
      },

      { "fslw", InstId::fslw, 0x0400103b, 0x0600707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "fsrw", InstId::fsrw, 0x0400503b, 0x0600707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask
      },

      { "fsriw", InstId::fsriw, 0x0400501b, 0x0600707f,
        InstType::Zbt,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs3Mask,
        OperandType::IntReg, OperandMode::Read, 0x03f000000
      },

      // Custom instruction.
      { "load64", InstId::load64, 0x300b, funct3Low7Mask,
	InstType::Load,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immTop12 },

      // Custom instruction.
      { "store64", InstId::store64, 0x302b, funct3Low7Mask,
	InstType::Store,
	OperandType::IntReg, OperandMode::Read, rs2Mask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::Imm, OperandMode::None, immBeq },

      // Custom instruction.
      { "bbarrier", InstId::bbarrier,
        0b0000'1111'1111'0000'000'00000'0001011,
        0b1111'1111'1111'0000'111'00000'1111111,
	InstType::Int
      },

      { "vsetvli", InstId::vsetvli,
        0b000000'0'00000'00000'111'00000'1010111, // Opcode
        0b100000'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::IntReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, 0x7ff00000,
      },

      { "vsetvl", InstId::vsetvl,
        0b100000'0'00000'00000'111'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::IntReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vadd.vv", InstId::vadd_vv,
        0b000000'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vadd.vx", InstId::vadd_vx,
        0b000000'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vadd.vi", InstId::vadd_vi,
        0b000000'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vsub.vv", InstId::vsub_vv,
        0b000010'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsub.vx", InstId::vsub_vx,
        0b000010'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vrsub.vx", InstId::vrsub_vx,
        0b000011'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vrsub.vi", InstId::vrsub_vi,
        0b000011'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vwaddu.vv", InstId::vwaddu_vv,
	0b110000'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwaddu.vx", InstId::vwaddu_vx,
        0b110000'0'00000'00000'110'00000'0010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwsubu.vv", InstId::vwsubu_vv,
        0b110010'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwsubu.vx", InstId::vwsubu_vx,
        0b110010'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwadd.vv ", InstId::vwadd_vv ,
        0b110001'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwadd.vx ", InstId::vwadd_vx ,
        0b110001'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwsub.vv ", InstId::vwsub_vv ,
        0b110011'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwsub.vx ", InstId::vwsub_vx ,
        0b110011'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwaddu.wv", InstId::vwaddu_wv,
        0b110100'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwaddu.wx", InstId::vwaddu_wx,
        0b110100'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwsubu.wv", InstId::vwsubu_wv,
        0b110110'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwsubu.wx", InstId::vwsubu_wx,
        0b110110'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwadd.wv ", InstId::vwadd_wv ,
        0b110101'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwadd.wx ", InstId::vwadd_wx ,
        0b110101'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwsub.wv ", InstId::vwsub_wv ,
        0b110111'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwsub.wx ", InstId::vwsub_wx ,
        0b110111'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111,
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vminu.vv", InstId::vminu_vv,
        0b000100'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vminu.vx", InstId::vminu_vx,
        0b000100'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmin.vv", InstId::vmin_vv,
        0b000101'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmin.vx", InstId::vmin_vx,
        0b000101'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmaxu.vv", InstId::vmaxu_vv,
        0b000110'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmaxu.vx", InstId::vmaxu_vx,
        0b000110'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmax.vv", InstId::vmax_vv,
        0b000111'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmax.vx", InstId::vmax_vx,
        0b000111'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vand.vv", InstId::vand_vv,
        0b001001'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vand.vx", InstId::vand_vx,
        0b001001'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vand.vi", InstId::vand_vi,
        0b001001'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vor.vv", InstId::vor_vv,
        0b001010'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vor.vx", InstId::vor_vx,
        0b001010'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vor.vi", InstId::vor_vi,
        0b001010'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vxor.vv", InstId::vxor_vv,
        0b001011'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vxor.vx", InstId::vxor_vx,
        0b001011'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vxor.vi", InstId::vxor_vi,
        0b001011'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vrgather.vv", InstId::vrgather_vv,
        0b001100'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vrgather.vx", InstId::vrgather_vx,
        0b001100'0'00000'00000'100'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vrgather.vi", InstId::vrgather_vi,
        0b001100'0'00000'00000'011'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vrgatherei16.vv", InstId::vrgatherei16_vv,
        0b001110'0'00000'00000'000'00000'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vcompress.vm", InstId::vcompress_vm,
        0b010111'0'00000'00011'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredsum.vs", InstId::vredsum_vs,
        0b000000'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredand.vs", InstId::vredand_vs,
        0b000001'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredor.vs", InstId::vredor_vs,
        0b000010'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredxor.vs", InstId::vredxor_vs,
        0b000011'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredminu.vs", InstId::vredminu_vs,
        0b000100'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredmin.vs", InstId::vredmin_vs,
        0b000101'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredmaxu.vs", InstId::vredmaxu_vs,
        0b000110'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vredmax.vs", InstId::vredmax_vs,
        0b000111'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmand.mm", InstId::vmand_mm,
        0b011001'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmnand.mm", InstId::vmnand_mm,
        0b011101'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmandnot.mm", InstId::vmandnot_mm,
        0b011000'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmxor.mm", InstId::vmxor_mm,
        0b011011'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmor.mm", InstId::vmor_mm,
        0b011010'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmnor.mm", InstId::vmnor_mm,
        0b011110'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmornot.mm", InstId::vmornot_mm,
        0b011100'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmxnor.mm", InstId::vmxnor_mm,
        0b011111'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vpopc.m", InstId::vpopc_m,
        0b010000'1'00000'10000'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::IntReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vfirst.m", InstId::vfirst_m,
        0b010000'1'00000'10001'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::IntReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmsbf.m", InstId::vmsbf_m,
        0b010100'1'00000'00001'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmsif.m", InstId::vmsif_m,
        0b010100'1'00000'00011'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmsof.m", InstId::vmsof_m,
        0b010100'1'00000'00010'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "viota.m", InstId::viota_m,
        0b010100'1'00000'10000'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vid.v", InstId::vid_v,
        0b010100'1'00000'10001'010'00000'1010111,
        0b111111'0'00000'11111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vslideup.vx", InstId::vslideup_vx,
        0b001110'0'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vslideup.vi", InstId::vslideup_vi,
        0b011111'0'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vslide1up.vx", InstId::vslide1up_vx,
        0b001110'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vslidedown.vx", InstId::vslidedown_vx,
        0b001111'0'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vslidedown.vi", InstId::vslidedown_vi,
        0b001111'0'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vmul.vv", InstId::vmul_vv,
        0b100101'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmul.vx", InstId::vmul_vx,
        0b100101'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmulh.vv", InstId::vmulh_vv,
        0b100111'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmulh.vx", InstId::vmulh_vx,
        0b100111'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmulhu.vv", InstId::vmulhu_vv,
        0b100100'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmulhu.vx", InstId::vmulhu_vx,
        0b100100'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmulhsu.vv", InstId::vmulhsu_vv,
        0b100110'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmulhsu.vx", InstId::vmulhsu_vx,
        0b100110'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwmulu.vv", InstId::vwmulu_vv,
        0b111000'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmulu.vx", InstId::vwmulu_vx,
        0b111000'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwmul.vv", InstId::vwmul_vv,
        0b111011'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmulu.vx", InstId::vwmul_vx,
        0b111011'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwmulsu.vv", InstId::vwmulsu_vv,
        0b111010'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmulsu.vx", InstId::vwmulsu_vx,
        0b111010'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vwmaccu.vv", InstId::vwmaccu_vv,
        0b111100'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmaccu.vx", InstId::vwmaccu_vx,
        0b111100'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmacc.vv", InstId::vwmacc_vv,
        0b111101'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmacc.vx", InstId::vwmacc_vx,
        0b111101'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmaccsu.vv", InstId::vwmaccsu_vv,
        0b111111'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmaccsu.vx", InstId::vwmaccsu_vx,
        0b111111'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vwmaccus.vx", InstId::vwmaccus_vx,
        0b111111'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vdivu.vv", InstId::vdivu_vv,
        0b100000'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vdivu.vx", InstId::vdivu_vx,
        0b100000'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vdiv.vv", InstId::vdiv_vv,
        0b100001'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vdiv.vx", InstId::vdiv_vx,
        0b100001'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vremu.vv", InstId::vremu_vv,
        0b100010'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vremu.vx", InstId::vremu_vx,
        0b100010'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vrem.vv", InstId::vrem_vv,
        0b100011'0'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vrem.vx", InstId::vrem_vx,
        0b100011'0'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vsext.vf2", InstId::vsext_vf2,
        0b010010'1'00000'00111'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsext.vf4", InstId::vsext_vf4,
        0b010010'1'00000'00101'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsext.vf8", InstId::vsext_vf8,
        0b010010'1'00000'00011'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vzext.vf2", InstId::vzext_vf2,
        0b010010'1'00000'00110'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vzext.vf4", InstId::vzext_vf4,
        0b010010'1'00000'00100'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vzext.vf8", InstId::vzext_vf8,
        0b010010'1'00000'00010'010'00000'1010111,
        0b111111'0'00000'00111'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vadc.vvm", InstId::vadc_vvm,
        0b010000'0'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vadc.vxm", InstId::vadc_vxm,
        0b010000'0'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vadc.vim", InstId::vadc_vim,
        0b010000'0'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vsbc.vvm", InstId::vsbc_vvm,
        0b010010'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsbc.vxm", InstId::vsbc_vxm,
        0b010010'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmadc.vvm", InstId::vmadc_vvm,
        0b010001'0'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmadc.vxm", InstId::vmadc_vxm,
        0b010001'0'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmadc.vim", InstId::vmadc_vim,
        0b010001'0'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vmsbc.vvm", InstId::vmsbc_vvm,
        0b010011'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmsbc.vxm", InstId::vmsbc_vxm,
        0b010011'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmerge.vv", InstId::vmerge_vv,
        0b010111'0'00010'00011'100'00001'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmerge.vx", InstId::vmerge_vx,
        0b010111'0'00000'00000'100'00000'1010111, // Opcode
        0b010111'1'00010'00011'000'00001'1010111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vmerge.vi", InstId::vmerge_vi,
        0b010111'0'00010'00011'011'00001'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vmv.x.s", InstId::vmv_x_s,
        0b010000'1'00010'00000'010'00001'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmv.s.x", InstId::vmv_s_x,
        0b010000'1'00010'00000'110'00001'1010111, // Opcode
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmv.v.v", InstId::vmv_v_v,
        0b010111'1'00010'00011'100'00001'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vmv.v.x", InstId::vmv_v_x,
        0b010111'1'00000'00000'100'00000'1010111, // Opcode
        0b010111'1'00010'00011'000'00001'1010111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vmv.v.i", InstId::vmv_v_i,
        0b010111'1'00010'00011'011'00001'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vmv1r.v", InstId::vmv1r_v,
        0b100111'1'00000'00000'011'00000'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vmv2r.v", InstId::vmv2r_v,
        0b100111'1'00000'00001'011'00000'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vmv4r.v", InstId::vmv4r_v,
        0b100111'1'00000'00011'011'00000'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vmv8r.v", InstId::vmv8r_v,
        0b100111'1'00000'00111'011'00000'1010111, // Opcode
        0b111111'1'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
      },

      { "vsaddu.vv", InstId::vsaddu_vv,
        0b100000'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsaddu.vx", InstId::vsaddu_vx,
        0b100000'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vsaddu.vi", InstId::vsaddu_vi,
        0b100000'0'00000'00011'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vsadd.vv", InstId::vsadd_vv,
        0b100001'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsadd.vx", InstId::vsadd_vx,
        0b100001'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vsadd.vi", InstId::vsadd_vi,
        0b100001'0'00000'00011'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::Imm, OperandMode::None, rs2Mask,
      },

      { "vssubu.vv", InstId::vssubu_vv,
        0b100010'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vssubu.vx", InstId::vssubu_vx,
        0b100010'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vssub.vv", InstId::vssub_vv,
        0b100011'0'00000'00011'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vssub.vx", InstId::vssub_vx,
        0b100011'0'00000'00011'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vaaddu.vv", InstId::vaaddu_vv,
        0b001000'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vaaddu.vx", InstId::vaaddu_vx,
        0b001000'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vaadd.vv", InstId::vaadd_vv,
        0b001001'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vaadd.vx", InstId::vaadd_vx,
        0b001001'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vasubu.vv", InstId::vasubu_vv,
        0b001001'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vasubu.vx", InstId::vasubu_vx,
        0b001001'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vasub.vv", InstId::vasub_vv,
        0b001010'1'00000'00000'010'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vasub.vx", InstId::vasub_vx,
        0b001010'1'00000'00000'110'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vsmul.vv", InstId::vsmul_vv,
        0b100111'1'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vsmul.vx", InstId::vsmul_vx,
        0b100111'1'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vssrl.vv", InstId::vssrl_vv,
        0b101010'1'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vssrl.vx", InstId::vssrl_vx,
        0b101010'1'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vssrl.vi", InstId::vssrl_vi,
        0b101010'1'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vssra.vv", InstId::vssra_vv,
        0b101011'1'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vssra.vx", InstId::vssra_vx,
        0b101011'1'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vssra.vi", InstId::vssra_vi,
        0b101011'1'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vnclipu.wv", InstId::vnclipu_wv,
        0b101110'1'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vnclipu.wx", InstId::vnclipu_wx,
        0b101110'1'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vnclipu.wi", InstId::vnclipu_wi,
        0b101110'1'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vnclip.wv", InstId::vnclip_wv,
        0b101111'1'00000'00000'000'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::VecReg, OperandMode::Read, rs2Mask,
      },

      { "vnclip.wx", InstId::vnclip_wx,
        0b101111'1'00000'00000'100'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vnclip.wi", InstId::vnclip_wi,
        0b101111'1'00000'00000'011'00000'1010111,
        0b111111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::VecReg, OperandMode::Read, rs1Mask,
        OperandType::IntReg, OperandMode::Read, rs2Mask,
      },

      { "vle8.v", InstId::vle8_v,
        0b000000'0'00000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle16.v", InstId::vle16_v,
        0b000000'0'00000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle32.v", InstId::vle32_v,
        0b000000'0'00000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle64.v", InstId::vle64_v,
        0b000000'0'00000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle128.v", InstId::vle128_v,
        0b000100'0'00000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle256.v", InstId::vle256_v,
        0b000100'0'00000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle512.v", InstId::vle512_v,
        0b000100'0'00000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle1024.v", InstId::vle1024_v,
        0b000100'0'00000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse8.v", InstId::vse8_v,
        0b000000'0'00000'00000'000'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse16.v", InstId::vse16_v,
        0b000000'0'00000'00000'101'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse32.v", InstId::vse32_v,
        0b000000'0'00000'00000'110'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse64.v", InstId::vse64_v,
        0b000000'0'00000'00000'111'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse128.v", InstId::vse128_v,
        0b000100'0'00000'00000'000'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse256.v", InstId::vse256_v,
        0b000100'0'00000'00000'101'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse512.v", InstId::vse512_v,
        0b000100'0'00000'00000'110'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vse1024.v", InstId::vse1024_v,
        0b000100'0'00000'00000'111'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre8.v", InstId::vlre8_v,
        0b000000'0'01000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre16.v", InstId::vlre16_v,
        0b000000'0'01000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre32.v", InstId::vlre32_v,
        0b000000'0'01000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre64.v", InstId::vlre64_v,
        0b000000'0'01000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre128.v", InstId::vlre128_v,
        0b000100'0'01000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre256.v", InstId::vlre256_v,
        0b000100'0'01000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre512.v", InstId::vlre512_v,
        0b000100'0'01000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlre1024.v", InstId::vlre1024_v,
        0b000100'0'01000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre8.v", InstId::vsre8_v,
        0b000000'0'01000'00000'000'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre16.v", InstId::vsre16_v,
        0b000000'0'01000'00000'101'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre32.v", InstId::vsre32_v,
        0b000000'0'01000'00000'110'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre64.v", InstId::vsre64_v,
        0b000000'0'01000'00000'111'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre128.v", InstId::vsre128_v,
        0b000100'0'01000'00000'000'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre256.v", InstId::vsre256_v,
        0b000100'0'01000'00000'101'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre512.v", InstId::vsre512_v,
        0b000100'0'01000'00000'110'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsre1024.v", InstId::vsre1024_v,
        0b000100'0'01000'00000'111'00000'0100111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle8ff.v", InstId::vle8ff_v,
        0b000000'0'10000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle16ff.v", InstId::vle16ff_v,
        0b000000'0'10000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle32ff.v", InstId::vle32ff_v,
        0b000000'0'10000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle64ff.v", InstId::vle64ff_v,
        0b000000'0'10000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle128ff.v", InstId::vle128ff_v,
        0b000100'0'10000'00000'000'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle256ff.v", InstId::vle256ff_v,
        0b000100'0'10000'00000'101'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle512ff.v", InstId::vle512ff_v,
        0b000100'0'10000'00000'110'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vle1024ff.v", InstId::vle1024ff_v,
        0b000100'0'10000'00000'111'00000'0000111,
        0b000111'0'11111'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse8.v", InstId::vlse8_v,
        0b000010'0'00000'00000'000'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse16.v", InstId::vlse16_v,
        0b000010'0'00000'00000'101'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse32.v", InstId::vlse32_v,
        0b000010'0'00000'00000'110'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse64.v", InstId::vlse64_v,
        0b000010'0'00000'00000'111'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse128.v", InstId::vlse128_v,
        0b000110'0'00000'00000'000'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse256.v", InstId::vlse256_v,
        0b000110'0'00000'00000'101'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse512.v", InstId::vlse512_v,
        0b000110'0'00000'00000'110'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlse1024.v", InstId::vlse1024_v,
        0b000110'0'00000'00000'111'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse8.v", InstId::vsse8_v,
        0b000010'0'00000'00000'000'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse16.v", InstId::vsse16_v,
        0b000010'0'00000'00000'101'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse32.v", InstId::vsse32_v,
        0b000010'0'00000'00000'110'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse64.v", InstId::vsse64_v,
        0b000010'0'00000'00000'111'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse128.v", InstId::vsse128_v,
        0b000110'0'00000'00000'000'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse256.v", InstId::vsse256_v,
        0b000110'0'00000'00000'101'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse512.v", InstId::vsse512_v,
        0b000110'0'00000'00000'110'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsse1024.v", InstId::vsse1024_v,
        0b000110'0'00000'00000'111'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlxei8.v", InstId::vlxei8_v,
        0b000011'0'00000'00000'000'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlxei16.v", InstId::vlxei16_v,
        0b000011'0'00000'00000'101'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlxei32.v", InstId::vlxei32_v,
        0b000011'0'00000'00000'110'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vlxei64.v", InstId::vlxei64_v,
        0b000011'0'00000'00000'111'00000'0000111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Write, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsxei8.v", InstId::vsxei8_v,
        0b000011'0'00000'00000'000'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsxei16.v", InstId::vsxei16_v,
        0b000011'0'00000'00000'101'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsxei32.v", InstId::vsxei32_v,
        0b000011'0'00000'00000'110'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

      { "vsxei64.v", InstId::vsxei64_v,
        0b000011'0'00000'00000'111'00000'0100111,
        0b000111'0'00000'00000'111'00000'1111111, // Mask of opcode bits
        InstType::Vector,
        OperandType::VecReg, OperandMode::Read, rdMask,
        OperandType::IntReg, OperandMode::Read, rs1Mask,
      },

/* INSERT YOUR CODE FROM HERE */
      { "cube", InstId::cube, 0x4000033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },
      
      { "rotleft", InstId::rotleft, 0x4001033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },
      
      { "rotright", InstId::rotright, 0x4002033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },
      
      { "reverse", InstId::reverse, 0x4003033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },
      
      { "notand", InstId::notand, 0x4004033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

      { "xoradd", InstId::xoradd, 0x4005033, top7Funct3Low7Mask,
	InstType::Int,
	OperandType::IntReg, OperandMode::Write, rdMask,
	OperandType::IntReg, OperandMode::Read, rs1Mask,
	OperandType::IntReg, OperandMode::Read, rs2Mask },

/* INSERT YOUR CODE END HERE */ 
    };
}
