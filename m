Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6DA5134
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2019 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfIBIRl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Sep 2019 04:17:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfIBIRl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Sep 2019 04:17:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW9-0008EH-7C; Mon, 02 Sep 2019 10:16:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 661491C0DF4;
        Mon,  2 Sep 2019 10:16:42 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:42 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] objtool: Move x86 insn decoder to a common location
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <55b486b88f6bcd0c9a2a04b34f964860c8390ca8.1567118001.git.jpoimboe@redhat.com>
References: <55b486b88f6bcd0c9a2a04b34f964860c8390ca8.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <156741220225.17389.10854413586850350711.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d046b725487a97a3a3b35a00e84ca093963b8b4e
Gitweb:        https://git.kernel.org/tip/d046b725487a97a3a3b35a00e84ca093963b8b4e
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 29 Aug 2019 17:41:18 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:52 -03:00

objtool: Move x86 insn decoder to a common location

The kernel tree has three identical copies of the x86 instruction
decoder.  Two of them are in the tools subdir.

The tools subdir is supposed to be completely standalone and separate
from the kernel.  So having at least one copy of the kernel decoder in
the tools subdir is unavoidable.  However, we don't need *two* of them.

Move objtool's copy of the decoder to a shared location, so that perf
will also be able to use it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/55b486b88f6bcd0c9a2a04b34f964860c8390ca8.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/inat.h                  |  230 ++-
 tools/arch/x86/include/asm/inat_types.h            |   15 +-
 tools/arch/x86/include/asm/insn.h                  |  216 ++-
 tools/arch/x86/include/asm/orc_types.h             |   97 +-
 tools/arch/x86/lib/inat.c                          |   83 +-
 tools/arch/x86/lib/insn.c                          |  593 ++++++-
 tools/arch/x86/lib/x86-opcode-map.txt              | 1072 +++++++++++-
 tools/arch/x86/tools/gen-insn-attr-x86.awk         |  393 ++++-
 tools/objtool/Makefile                             |    4 +-
 tools/objtool/arch/x86/Build                       |    4 +-
 tools/objtool/arch/x86/decode.c                    |    4 +-
 tools/objtool/arch/x86/include/asm/inat.h          |  230 +--
 tools/objtool/arch/x86/include/asm/inat_types.h    |   15 +-
 tools/objtool/arch/x86/include/asm/insn.h          |  216 +--
 tools/objtool/arch/x86/include/asm/orc_types.h     |   97 +-
 tools/objtool/arch/x86/lib/inat.c                  |   83 +-
 tools/objtool/arch/x86/lib/insn.c                  |  593 +------
 tools/objtool/arch/x86/lib/x86-opcode-map.txt      | 1072 +-----------
 tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk |  393 +----
 tools/objtool/sync-check.sh                        |   12 +-
 20 files changed, 2711 insertions(+), 2711 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/inat.h
 create mode 100644 tools/arch/x86/include/asm/inat_types.h
 create mode 100644 tools/arch/x86/include/asm/insn.h
 create mode 100644 tools/arch/x86/include/asm/orc_types.h
 create mode 100644 tools/arch/x86/lib/inat.c
 create mode 100644 tools/arch/x86/lib/insn.c
 create mode 100644 tools/arch/x86/lib/x86-opcode-map.txt
 create mode 100644 tools/arch/x86/tools/gen-insn-attr-x86.awk
 delete mode 100644 tools/objtool/arch/x86/include/asm/inat.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/inat_types.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/insn.h
 delete mode 100644 tools/objtool/arch/x86/include/asm/orc_types.h
 delete mode 100644 tools/objtool/arch/x86/lib/inat.c
 delete mode 100644 tools/objtool/arch/x86/lib/insn.c
 delete mode 100644 tools/objtool/arch/x86/lib/x86-opcode-map.txt
 delete mode 100644 tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk

diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
new file mode 100644
index 0000000..4cf2ad5
--- /dev/null
+++ b/tools/arch/x86/include/asm/inat.h
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_X86_INAT_H
+#define _ASM_X86_INAT_H
+/*
+ * x86 instruction attributes
+ *
+ * Written by Masami Hiramatsu <mhiramat@redhat.com>
+ */
+#include <asm/inat_types.h>
+
+/*
+ * Internal bits. Don't use bitmasks directly, because these bits are
+ * unstable. You should use checking functions.
+ */
+
+#define INAT_OPCODE_TABLE_SIZE 256
+#define INAT_GROUP_TABLE_SIZE 8
+
+/* Legacy last prefixes */
+#define INAT_PFX_OPNDSZ	1	/* 0x66 */ /* LPFX1 */
+#define INAT_PFX_REPE	2	/* 0xF3 */ /* LPFX2 */
+#define INAT_PFX_REPNE	3	/* 0xF2 */ /* LPFX3 */
+/* Other Legacy prefixes */
+#define INAT_PFX_LOCK	4	/* 0xF0 */
+#define INAT_PFX_CS	5	/* 0x2E */
+#define INAT_PFX_DS	6	/* 0x3E */
+#define INAT_PFX_ES	7	/* 0x26 */
+#define INAT_PFX_FS	8	/* 0x64 */
+#define INAT_PFX_GS	9	/* 0x65 */
+#define INAT_PFX_SS	10	/* 0x36 */
+#define INAT_PFX_ADDRSZ	11	/* 0x67 */
+/* x86-64 REX prefix */
+#define INAT_PFX_REX	12	/* 0x4X */
+/* AVX VEX prefixes */
+#define INAT_PFX_VEX2	13	/* 2-bytes VEX prefix */
+#define INAT_PFX_VEX3	14	/* 3-bytes VEX prefix */
+#define INAT_PFX_EVEX	15	/* EVEX prefix */
+
+#define INAT_LSTPFX_MAX	3
+#define INAT_LGCPFX_MAX	11
+
+/* Immediate size */
+#define INAT_IMM_BYTE		1
+#define INAT_IMM_WORD		2
+#define INAT_IMM_DWORD		3
+#define INAT_IMM_QWORD		4
+#define INAT_IMM_PTR		5
+#define INAT_IMM_VWORD32	6
+#define INAT_IMM_VWORD		7
+
+/* Legacy prefix */
+#define INAT_PFX_OFFS	0
+#define INAT_PFX_BITS	4
+#define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
+#define INAT_PFX_MASK	(INAT_PFX_MAX << INAT_PFX_OFFS)
+/* Escape opcodes */
+#define INAT_ESC_OFFS	(INAT_PFX_OFFS + INAT_PFX_BITS)
+#define INAT_ESC_BITS	2
+#define INAT_ESC_MAX	((1 << INAT_ESC_BITS) - 1)
+#define INAT_ESC_MASK	(INAT_ESC_MAX << INAT_ESC_OFFS)
+/* Group opcodes (1-16) */
+#define INAT_GRP_OFFS	(INAT_ESC_OFFS + INAT_ESC_BITS)
+#define INAT_GRP_BITS	5
+#define INAT_GRP_MAX	((1 << INAT_GRP_BITS) - 1)
+#define INAT_GRP_MASK	(INAT_GRP_MAX << INAT_GRP_OFFS)
+/* Immediates */
+#define INAT_IMM_OFFS	(INAT_GRP_OFFS + INAT_GRP_BITS)
+#define INAT_IMM_BITS	3
+#define INAT_IMM_MASK	(((1 << INAT_IMM_BITS) - 1) << INAT_IMM_OFFS)
+/* Flags */
+#define INAT_FLAG_OFFS	(INAT_IMM_OFFS + INAT_IMM_BITS)
+#define INAT_MODRM	(1 << (INAT_FLAG_OFFS))
+#define INAT_FORCE64	(1 << (INAT_FLAG_OFFS + 1))
+#define INAT_SCNDIMM	(1 << (INAT_FLAG_OFFS + 2))
+#define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
+#define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
+#define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
+#define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
+#define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
+/* Attribute making macros for attribute tables */
+#define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
+#define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
+#define INAT_MAKE_GROUP(grp)	((grp << INAT_GRP_OFFS) | INAT_MODRM)
+#define INAT_MAKE_IMM(imm)	(imm << INAT_IMM_OFFS)
+
+/* Identifiers for segment registers */
+#define INAT_SEG_REG_IGNORE	0
+#define INAT_SEG_REG_DEFAULT	1
+#define INAT_SEG_REG_CS		2
+#define INAT_SEG_REG_SS		3
+#define INAT_SEG_REG_DS		4
+#define INAT_SEG_REG_ES		5
+#define INAT_SEG_REG_FS		6
+#define INAT_SEG_REG_GS		7
+
+/* Attribute search APIs */
+extern insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode);
+extern int inat_get_last_prefix_id(insn_byte_t last_pfx);
+extern insn_attr_t inat_get_escape_attribute(insn_byte_t opcode,
+					     int lpfx_id,
+					     insn_attr_t esc_attr);
+extern insn_attr_t inat_get_group_attribute(insn_byte_t modrm,
+					    int lpfx_id,
+					    insn_attr_t esc_attr);
+extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
+					  insn_byte_t vex_m,
+					  insn_byte_t vex_pp);
+
+/* Attribute checking functions */
+static inline int inat_is_legacy_prefix(insn_attr_t attr)
+{
+	attr &= INAT_PFX_MASK;
+	return attr && attr <= INAT_LGCPFX_MAX;
+}
+
+static inline int inat_is_address_size_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_ADDRSZ;
+}
+
+static inline int inat_is_operand_size_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_OPNDSZ;
+}
+
+static inline int inat_is_rex_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_REX;
+}
+
+static inline int inat_last_prefix_id(insn_attr_t attr)
+{
+	if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
+		return 0;
+	else
+		return attr & INAT_PFX_MASK;
+}
+
+static inline int inat_is_vex_prefix(insn_attr_t attr)
+{
+	attr &= INAT_PFX_MASK;
+	return attr == INAT_PFX_VEX2 || attr == INAT_PFX_VEX3 ||
+	       attr == INAT_PFX_EVEX;
+}
+
+static inline int inat_is_evex_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_EVEX;
+}
+
+static inline int inat_is_vex3_prefix(insn_attr_t attr)
+{
+	return (attr & INAT_PFX_MASK) == INAT_PFX_VEX3;
+}
+
+static inline int inat_is_escape(insn_attr_t attr)
+{
+	return attr & INAT_ESC_MASK;
+}
+
+static inline int inat_escape_id(insn_attr_t attr)
+{
+	return (attr & INAT_ESC_MASK) >> INAT_ESC_OFFS;
+}
+
+static inline int inat_is_group(insn_attr_t attr)
+{
+	return attr & INAT_GRP_MASK;
+}
+
+static inline int inat_group_id(insn_attr_t attr)
+{
+	return (attr & INAT_GRP_MASK) >> INAT_GRP_OFFS;
+}
+
+static inline int inat_group_common_attribute(insn_attr_t attr)
+{
+	return attr & ~INAT_GRP_MASK;
+}
+
+static inline int inat_has_immediate(insn_attr_t attr)
+{
+	return attr & INAT_IMM_MASK;
+}
+
+static inline int inat_immediate_size(insn_attr_t attr)
+{
+	return (attr & INAT_IMM_MASK) >> INAT_IMM_OFFS;
+}
+
+static inline int inat_has_modrm(insn_attr_t attr)
+{
+	return attr & INAT_MODRM;
+}
+
+static inline int inat_is_force64(insn_attr_t attr)
+{
+	return attr & INAT_FORCE64;
+}
+
+static inline int inat_has_second_immediate(insn_attr_t attr)
+{
+	return attr & INAT_SCNDIMM;
+}
+
+static inline int inat_has_moffset(insn_attr_t attr)
+{
+	return attr & INAT_MOFFSET;
+}
+
+static inline int inat_has_variant(insn_attr_t attr)
+{
+	return attr & INAT_VARIANT;
+}
+
+static inline int inat_accept_vex(insn_attr_t attr)
+{
+	return attr & INAT_VEXOK;
+}
+
+static inline int inat_must_vex(insn_attr_t attr)
+{
+	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
+}
+
+static inline int inat_must_evex(insn_attr_t attr)
+{
+	return attr & INAT_EVEXONLY;
+}
+#endif
diff --git a/tools/arch/x86/include/asm/inat_types.h b/tools/arch/x86/include/asm/inat_types.h
new file mode 100644
index 0000000..b047efa
--- /dev/null
+++ b/tools/arch/x86/include/asm/inat_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_X86_INAT_TYPES_H
+#define _ASM_X86_INAT_TYPES_H
+/*
+ * x86 instruction attributes
+ *
+ * Written by Masami Hiramatsu <mhiramat@redhat.com>
+ */
+
+/* Instruction attributes */
+typedef unsigned int insn_attr_t;
+typedef unsigned char insn_byte_t;
+typedef signed int insn_value_t;
+
+#endif
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
new file mode 100644
index 0000000..154f27b
--- /dev/null
+++ b/tools/arch/x86/include/asm/insn.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_X86_INSN_H
+#define _ASM_X86_INSN_H
+/*
+ * x86 instruction analysis
+ *
+ * Copyright (C) IBM Corporation, 2009
+ */
+
+/* insn_attr_t is defined in inat.h */
+#include <asm/inat.h>
+
+struct insn_field {
+	union {
+		insn_value_t value;
+		insn_byte_t bytes[4];
+	};
+	/* !0 if we've run insn_get_xxx() for this field */
+	unsigned char got;
+	unsigned char nbytes;
+};
+
+struct insn {
+	struct insn_field prefixes;	/*
+					 * Prefixes
+					 * prefixes.bytes[3]: last prefix
+					 */
+	struct insn_field rex_prefix;	/* REX prefix */
+	struct insn_field vex_prefix;	/* VEX prefix */
+	struct insn_field opcode;	/*
+					 * opcode.bytes[0]: opcode1
+					 * opcode.bytes[1]: opcode2
+					 * opcode.bytes[2]: opcode3
+					 */
+	struct insn_field modrm;
+	struct insn_field sib;
+	struct insn_field displacement;
+	union {
+		struct insn_field immediate;
+		struct insn_field moffset1;	/* for 64bit MOV */
+		struct insn_field immediate1;	/* for 64bit imm or off16/32 */
+	};
+	union {
+		struct insn_field moffset2;	/* for 64bit MOV */
+		struct insn_field immediate2;	/* for 64bit imm or seg16 */
+	};
+
+	insn_attr_t attr;
+	unsigned char opnd_bytes;
+	unsigned char addr_bytes;
+	unsigned char length;
+	unsigned char x86_64;
+
+	const insn_byte_t *kaddr;	/* kernel address of insn to analyze */
+	const insn_byte_t *end_kaddr;	/* kernel address of last insn in buffer */
+	const insn_byte_t *next_byte;
+};
+
+#define MAX_INSN_SIZE	15
+
+#define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
+#define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
+#define X86_MODRM_RM(modrm) ((modrm) & 0x07)
+
+#define X86_SIB_SCALE(sib) (((sib) & 0xc0) >> 6)
+#define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
+#define X86_SIB_BASE(sib) ((sib) & 0x07)
+
+#define X86_REX_W(rex) ((rex) & 8)
+#define X86_REX_R(rex) ((rex) & 4)
+#define X86_REX_X(rex) ((rex) & 2)
+#define X86_REX_B(rex) ((rex) & 1)
+
+/* VEX bit flags  */
+#define X86_VEX_W(vex)	((vex) & 0x80)	/* VEX3 Byte2 */
+#define X86_VEX_R(vex)	((vex) & 0x80)	/* VEX2/3 Byte1 */
+#define X86_VEX_X(vex)	((vex) & 0x40)	/* VEX3 Byte1 */
+#define X86_VEX_B(vex)	((vex) & 0x20)	/* VEX3 Byte1 */
+#define X86_VEX_L(vex)	((vex) & 0x04)	/* VEX3 Byte2, VEX2 Byte1 */
+/* VEX bit fields */
+#define X86_EVEX_M(vex)	((vex) & 0x03)		/* EVEX Byte1 */
+#define X86_VEX3_M(vex)	((vex) & 0x1f)		/* VEX3 Byte1 */
+#define X86_VEX2_M	1			/* VEX2.M always 1 */
+#define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
+#define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
+#define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+
+extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
+extern void insn_get_prefixes(struct insn *insn);
+extern void insn_get_opcode(struct insn *insn);
+extern void insn_get_modrm(struct insn *insn);
+extern void insn_get_sib(struct insn *insn);
+extern void insn_get_displacement(struct insn *insn);
+extern void insn_get_immediate(struct insn *insn);
+extern void insn_get_length(struct insn *insn);
+
+/* Attribute will be determined after getting ModRM (for opcode groups) */
+static inline void insn_get_attribute(struct insn *insn)
+{
+	insn_get_modrm(insn);
+}
+
+/* Instruction uses RIP-relative addressing */
+extern int insn_rip_relative(struct insn *insn);
+
+/* Init insn for kernel text */
+static inline void kernel_insn_init(struct insn *insn,
+				    const void *kaddr, int buf_len)
+{
+#ifdef CONFIG_X86_64
+	insn_init(insn, kaddr, buf_len, 1);
+#else /* CONFIG_X86_32 */
+	insn_init(insn, kaddr, buf_len, 0);
+#endif
+}
+
+static inline int insn_is_avx(struct insn *insn)
+{
+	if (!insn->prefixes.got)
+		insn_get_prefixes(insn);
+	return (insn->vex_prefix.value != 0);
+}
+
+static inline int insn_is_evex(struct insn *insn)
+{
+	if (!insn->prefixes.got)
+		insn_get_prefixes(insn);
+	return (insn->vex_prefix.nbytes == 4);
+}
+
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
+static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
+		return X86_VEX2_M;
+	else if (insn->vex_prefix.nbytes == 3)	/* 3 bytes VEX */
+		return X86_VEX3_M(insn->vex_prefix.bytes[1]);
+	else					/* EVEX */
+		return X86_EVEX_M(insn->vex_prefix.bytes[1]);
+}
+
+static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
+{
+	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
+		return X86_VEX_P(insn->vex_prefix.bytes[1]);
+	else
+		return X86_VEX_P(insn->vex_prefix.bytes[2]);
+}
+
+/* Get the last prefix id from last prefix or VEX prefix */
+static inline int insn_last_prefix_id(struct insn *insn)
+{
+	if (insn_is_avx(insn))
+		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
+
+	if (insn->prefixes.bytes[3])
+		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
+
+	return 0;
+}
+
+/* Offset of each field from kaddr */
+static inline int insn_offset_rex_prefix(struct insn *insn)
+{
+	return insn->prefixes.nbytes;
+}
+static inline int insn_offset_vex_prefix(struct insn *insn)
+{
+	return insn_offset_rex_prefix(insn) + insn->rex_prefix.nbytes;
+}
+static inline int insn_offset_opcode(struct insn *insn)
+{
+	return insn_offset_vex_prefix(insn) + insn->vex_prefix.nbytes;
+}
+static inline int insn_offset_modrm(struct insn *insn)
+{
+	return insn_offset_opcode(insn) + insn->opcode.nbytes;
+}
+static inline int insn_offset_sib(struct insn *insn)
+{
+	return insn_offset_modrm(insn) + insn->modrm.nbytes;
+}
+static inline int insn_offset_displacement(struct insn *insn)
+{
+	return insn_offset_sib(insn) + insn->sib.nbytes;
+}
+static inline int insn_offset_immediate(struct insn *insn)
+{
+	return insn_offset_displacement(insn) + insn->displacement.nbytes;
+}
+
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
+#endif /* _ASM_X86_INSN_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
new file mode 100644
index 0000000..6e06090
--- /dev/null
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and BP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_DX			2
+#define ORC_REG_DI			3
+#define ORC_REG_BP			4
+#define ORC_REG_SP			5
+#define ORC_REG_R10			6
+#define ORC_REG_R13			7
+#define ORC_REG_BP_INDIRECT		8
+#define ORC_REG_SP_INDIRECT		9
+#define ORC_REG_MAX			15
+
+/*
+ * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
+ * caller's SP right before it made the call).  Used for all callable
+ * functions, i.e. all C code and all callable asm functions.
+ *
+ * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
+ * to a fully populated pt_regs from a syscall, interrupt, or exception.
+ *
+ * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
+ * points to the iret return frame.
+ *
+ * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
+ * aren't used in struct orc_entry due to size and complexity constraints.
+ * Objtool converts them to real types when it converts the hints to orc
+ * entries.
+ */
+#define ORC_TYPE_CALL			0
+#define ORC_TYPE_REGS			1
+#define ORC_TYPE_REGS_IRET		2
+#define UNWIND_HINT_TYPE_SAVE		3
+#define UNWIND_HINT_TYPE_RESTORE	4
+
+#ifndef __ASSEMBLY__
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and BP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		bp_offset;
+	unsigned	sp_reg:4;
+	unsigned	bp_reg:4;
+	unsigned	type:2;
+	unsigned	end:1;
+} __packed;
+
+/*
+ * This struct is used by asm and inline asm code to manually annotate the
+ * location of registers on the stack for the ORC unwinder.
+ *
+ * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
+ */
+struct unwind_hint {
+	u32		ip;
+	s16		sp_offset;
+	u8		sp_reg;
+	u8		type;
+	u8		end;
+};
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
new file mode 100644
index 0000000..12539fc
--- /dev/null
+++ b/tools/arch/x86/lib/inat.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * x86 instruction attribute tables
+ *
+ * Written by Masami Hiramatsu <mhiramat@redhat.com>
+ */
+#include <asm/insn.h>
+
+/* Attribute tables are generated from opcode map */
+#include "inat-tables.c"
+
+/* Attribute search APIs */
+insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode)
+{
+	return inat_primary_table[opcode];
+}
+
+int inat_get_last_prefix_id(insn_byte_t last_pfx)
+{
+	insn_attr_t lpfx_attr;
+
+	lpfx_attr = inat_get_opcode_attribute(last_pfx);
+	return inat_last_prefix_id(lpfx_attr);
+}
+
+insn_attr_t inat_get_escape_attribute(insn_byte_t opcode, int lpfx_id,
+				      insn_attr_t esc_attr)
+{
+	const insn_attr_t *table;
+	int n;
+
+	n = inat_escape_id(esc_attr);
+
+	table = inat_escape_tables[n][0];
+	if (!table)
+		return 0;
+	if (inat_has_variant(table[opcode]) && lpfx_id) {
+		table = inat_escape_tables[n][lpfx_id];
+		if (!table)
+			return 0;
+	}
+	return table[opcode];
+}
+
+insn_attr_t inat_get_group_attribute(insn_byte_t modrm, int lpfx_id,
+				     insn_attr_t grp_attr)
+{
+	const insn_attr_t *table;
+	int n;
+
+	n = inat_group_id(grp_attr);
+
+	table = inat_group_tables[n][0];
+	if (!table)
+		return inat_group_common_attribute(grp_attr);
+	if (inat_has_variant(table[X86_MODRM_REG(modrm)]) && lpfx_id) {
+		table = inat_group_tables[n][lpfx_id];
+		if (!table)
+			return inat_group_common_attribute(grp_attr);
+	}
+	return table[X86_MODRM_REG(modrm)] |
+	       inat_group_common_attribute(grp_attr);
+}
+
+insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, insn_byte_t vex_m,
+				   insn_byte_t vex_p)
+{
+	const insn_attr_t *table;
+	if (vex_m > X86_VEX_M_MAX || vex_p > INAT_LSTPFX_MAX)
+		return 0;
+	/* At first, this checks the master table */
+	table = inat_avx_tables[vex_m][0];
+	if (!table)
+		return 0;
+	if (!inat_is_group(table[opcode]) && vex_p) {
+		/* If this is not a group, get attribute directly */
+		table = inat_avx_tables[vex_m][vex_p];
+		if (!table)
+			return 0;
+	}
+	return table[opcode];
+}
+
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
new file mode 100644
index 0000000..0b5862b
--- /dev/null
+++ b/tools/arch/x86/lib/insn.c
@@ -0,0 +1,593 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * x86 instruction analysis
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004, 2009
+ */
+
+#ifdef __KERNEL__
+#include <linux/string.h>
+#else
+#include <string.h>
+#endif
+#include <asm/inat.h>
+#include <asm/insn.h>
+
+/* Verify next sizeof(t) bytes can be on the same instruction */
+#define validate_next(t, insn, n)	\
+	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
+
+#define __get_next(t, insn)	\
+	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+
+#define __peek_nbyte_next(t, insn, n)	\
+	({ t r = *(t*)((insn)->next_byte + n); r; })
+
+#define get_next(t, insn)	\
+	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
+
+#define peek_nbyte_next(t, insn, n)	\
+	({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
+
+#define peek_next(t, insn)	peek_nbyte_next(t, insn, 0)
+
+/**
+ * insn_init() - initialize struct insn
+ * @insn:	&struct insn to be initialized
+ * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
+ * @x86_64:	!0 for 64-bit kernel or 64-bit app
+ */
+void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
+{
+	/*
+	 * Instructions longer than MAX_INSN_SIZE (15 bytes) are invalid
+	 * even if the input buffer is long enough to hold them.
+	 */
+	if (buf_len > MAX_INSN_SIZE)
+		buf_len = MAX_INSN_SIZE;
+
+	memset(insn, 0, sizeof(*insn));
+	insn->kaddr = kaddr;
+	insn->end_kaddr = kaddr + buf_len;
+	insn->next_byte = kaddr;
+	insn->x86_64 = x86_64 ? 1 : 0;
+	insn->opnd_bytes = 4;
+	if (x86_64)
+		insn->addr_bytes = 8;
+	else
+		insn->addr_bytes = 4;
+}
+
+/**
+ * insn_get_prefixes - scan x86 instruction prefix bytes
+ * @insn:	&struct insn containing instruction
+ *
+ * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
+ * to point to the (first) opcode.  No effect if @insn->prefixes.got
+ * is already set.
+ */
+void insn_get_prefixes(struct insn *insn)
+{
+	struct insn_field *prefixes = &insn->prefixes;
+	insn_attr_t attr;
+	insn_byte_t b, lb;
+	int i, nb;
+
+	if (prefixes->got)
+		return;
+
+	nb = 0;
+	lb = 0;
+	b = peek_next(insn_byte_t, insn);
+	attr = inat_get_opcode_attribute(b);
+	while (inat_is_legacy_prefix(attr)) {
+		/* Skip if same prefix */
+		for (i = 0; i < nb; i++)
+			if (prefixes->bytes[i] == b)
+				goto found;
+		if (nb == 4)
+			/* Invalid instruction */
+			break;
+		prefixes->bytes[nb++] = b;
+		if (inat_is_address_size_prefix(attr)) {
+			/* address size switches 2/4 or 4/8 */
+			if (insn->x86_64)
+				insn->addr_bytes ^= 12;
+			else
+				insn->addr_bytes ^= 6;
+		} else if (inat_is_operand_size_prefix(attr)) {
+			/* oprand size switches 2/4 */
+			insn->opnd_bytes ^= 6;
+		}
+found:
+		prefixes->nbytes++;
+		insn->next_byte++;
+		lb = b;
+		b = peek_next(insn_byte_t, insn);
+		attr = inat_get_opcode_attribute(b);
+	}
+	/* Set the last prefix */
+	if (lb && lb != insn->prefixes.bytes[3]) {
+		if (unlikely(insn->prefixes.bytes[3])) {
+			/* Swap the last prefix */
+			b = insn->prefixes.bytes[3];
+			for (i = 0; i < nb; i++)
+				if (prefixes->bytes[i] == lb)
+					prefixes->bytes[i] = b;
+		}
+		insn->prefixes.bytes[3] = lb;
+	}
+
+	/* Decode REX prefix */
+	if (insn->x86_64) {
+		b = peek_next(insn_byte_t, insn);
+		attr = inat_get_opcode_attribute(b);
+		if (inat_is_rex_prefix(attr)) {
+			insn->rex_prefix.value = b;
+			insn->rex_prefix.nbytes = 1;
+			insn->next_byte++;
+			if (X86_REX_W(b))
+				/* REX.W overrides opnd_size */
+				insn->opnd_bytes = 8;
+		}
+	}
+	insn->rex_prefix.got = 1;
+
+	/* Decode VEX prefix */
+	b = peek_next(insn_byte_t, insn);
+	attr = inat_get_opcode_attribute(b);
+	if (inat_is_vex_prefix(attr)) {
+		insn_byte_t b2 = peek_nbyte_next(insn_byte_t, insn, 1);
+		if (!insn->x86_64) {
+			/*
+			 * In 32-bits mode, if the [7:6] bits (mod bits of
+			 * ModRM) on the second byte are not 11b, it is
+			 * LDS or LES or BOUND.
+			 */
+			if (X86_MODRM_MOD(b2) != 3)
+				goto vex_end;
+		}
+		insn->vex_prefix.bytes[0] = b;
+		insn->vex_prefix.bytes[1] = b2;
+		if (inat_is_evex_prefix(attr)) {
+			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
+			insn->vex_prefix.bytes[2] = b2;
+			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
+			insn->vex_prefix.bytes[3] = b2;
+			insn->vex_prefix.nbytes = 4;
+			insn->next_byte += 4;
+			if (insn->x86_64 && X86_VEX_W(b2))
+				/* VEX.W overrides opnd_size */
+				insn->opnd_bytes = 8;
+		} else if (inat_is_vex3_prefix(attr)) {
+			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
+			insn->vex_prefix.bytes[2] = b2;
+			insn->vex_prefix.nbytes = 3;
+			insn->next_byte += 3;
+			if (insn->x86_64 && X86_VEX_W(b2))
+				/* VEX.W overrides opnd_size */
+				insn->opnd_bytes = 8;
+		} else {
+			/*
+			 * For VEX2, fake VEX3-like byte#2.
+			 * Makes it easier to decode vex.W, vex.vvvv,
+			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
+			 */
+			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn->vex_prefix.nbytes = 2;
+			insn->next_byte += 2;
+		}
+	}
+vex_end:
+	insn->vex_prefix.got = 1;
+
+	prefixes->got = 1;
+
+err_out:
+	return;
+}
+
+/**
+ * insn_get_opcode - collect opcode(s)
+ * @insn:	&struct insn containing instruction
+ *
+ * Populates @insn->opcode, updates @insn->next_byte to point past the
+ * opcode byte(s), and set @insn->attr (except for groups).
+ * If necessary, first collects any preceding (prefix) bytes.
+ * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
+ * is already 1.
+ */
+void insn_get_opcode(struct insn *insn)
+{
+	struct insn_field *opcode = &insn->opcode;
+	insn_byte_t op;
+	int pfx_id;
+	if (opcode->got)
+		return;
+	if (!insn->prefixes.got)
+		insn_get_prefixes(insn);
+
+	/* Get first opcode */
+	op = get_next(insn_byte_t, insn);
+	opcode->bytes[0] = op;
+	opcode->nbytes = 1;
+
+	/* Check if there is VEX prefix or not */
+	if (insn_is_avx(insn)) {
+		insn_byte_t m, p;
+		m = insn_vex_m_bits(insn);
+		p = insn_vex_p_bits(insn);
+		insn->attr = inat_get_avx_attribute(op, m, p);
+		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
+		    (!inat_accept_vex(insn->attr) &&
+		     !inat_is_group(insn->attr)))
+			insn->attr = 0;	/* This instruction is bad */
+		goto end;	/* VEX has only 1 byte for opcode */
+	}
+
+	insn->attr = inat_get_opcode_attribute(op);
+	while (inat_is_escape(insn->attr)) {
+		/* Get escaped opcode */
+		op = get_next(insn_byte_t, insn);
+		opcode->bytes[opcode->nbytes++] = op;
+		pfx_id = insn_last_prefix_id(insn);
+		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
+	}
+	if (inat_must_vex(insn->attr))
+		insn->attr = 0;	/* This instruction is bad */
+end:
+	opcode->got = 1;
+
+err_out:
+	return;
+}
+
+/**
+ * insn_get_modrm - collect ModRM byte, if any
+ * @insn:	&struct insn containing instruction
+ *
+ * Populates @insn->modrm and updates @insn->next_byte to point past the
+ * ModRM byte, if any.  If necessary, first collects the preceding bytes
+ * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
+ */
+void insn_get_modrm(struct insn *insn)
+{
+	struct insn_field *modrm = &insn->modrm;
+	insn_byte_t pfx_id, mod;
+	if (modrm->got)
+		return;
+	if (!insn->opcode.got)
+		insn_get_opcode(insn);
+
+	if (inat_has_modrm(insn->attr)) {
+		mod = get_next(insn_byte_t, insn);
+		modrm->value = mod;
+		modrm->nbytes = 1;
+		if (inat_is_group(insn->attr)) {
+			pfx_id = insn_last_prefix_id(insn);
+			insn->attr = inat_get_group_attribute(mod, pfx_id,
+							      insn->attr);
+			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
+				insn->attr = 0;	/* This is bad */
+		}
+	}
+
+	if (insn->x86_64 && inat_is_force64(insn->attr))
+		insn->opnd_bytes = 8;
+	modrm->got = 1;
+
+err_out:
+	return;
+}
+
+
+/**
+ * insn_rip_relative() - Does instruction use RIP-relative addressing mode?
+ * @insn:	&struct insn containing instruction
+ *
+ * If necessary, first collects the instruction up to and including the
+ * ModRM byte.  No effect if @insn->x86_64 is 0.
+ */
+int insn_rip_relative(struct insn *insn)
+{
+	struct insn_field *modrm = &insn->modrm;
+
+	if (!insn->x86_64)
+		return 0;
+	if (!modrm->got)
+		insn_get_modrm(insn);
+	/*
+	 * For rip-relative instructions, the mod field (top 2 bits)
+	 * is zero and the r/m field (bottom 3 bits) is 0x5.
+	 */
+	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
+}
+
+/**
+ * insn_get_sib() - Get the SIB byte of instruction
+ * @insn:	&struct insn containing instruction
+ *
+ * If necessary, first collects the instruction up to and including the
+ * ModRM byte.
+ */
+void insn_get_sib(struct insn *insn)
+{
+	insn_byte_t modrm;
+
+	if (insn->sib.got)
+		return;
+	if (!insn->modrm.got)
+		insn_get_modrm(insn);
+	if (insn->modrm.nbytes) {
+		modrm = (insn_byte_t)insn->modrm.value;
+		if (insn->addr_bytes != 2 &&
+		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
+			insn->sib.value = get_next(insn_byte_t, insn);
+			insn->sib.nbytes = 1;
+		}
+	}
+	insn->sib.got = 1;
+
+err_out:
+	return;
+}
+
+
+/**
+ * insn_get_displacement() - Get the displacement of instruction
+ * @insn:	&struct insn containing instruction
+ *
+ * If necessary, first collects the instruction up to and including the
+ * SIB byte.
+ * Displacement value is sign-expanded.
+ */
+void insn_get_displacement(struct insn *insn)
+{
+	insn_byte_t mod, rm, base;
+
+	if (insn->displacement.got)
+		return;
+	if (!insn->sib.got)
+		insn_get_sib(insn);
+	if (insn->modrm.nbytes) {
+		/*
+		 * Interpreting the modrm byte:
+		 * mod = 00 - no displacement fields (exceptions below)
+		 * mod = 01 - 1-byte displacement field
+		 * mod = 10 - displacement field is 4 bytes, or 2 bytes if
+		 * 	address size = 2 (0x67 prefix in 32-bit mode)
+		 * mod = 11 - no memory operand
+		 *
+		 * If address size = 2...
+		 * mod = 00, r/m = 110 - displacement field is 2 bytes
+		 *
+		 * If address size != 2...
+		 * mod != 11, r/m = 100 - SIB byte exists
+		 * mod = 00, SIB base = 101 - displacement field is 4 bytes
+		 * mod = 00, r/m = 101 - rip-relative addressing, displacement
+		 * 	field is 4 bytes
+		 */
+		mod = X86_MODRM_MOD(insn->modrm.value);
+		rm = X86_MODRM_RM(insn->modrm.value);
+		base = X86_SIB_BASE(insn->sib.value);
+		if (mod == 3)
+			goto out;
+		if (mod == 1) {
+			insn->displacement.value = get_next(signed char, insn);
+			insn->displacement.nbytes = 1;
+		} else if (insn->addr_bytes == 2) {
+			if ((mod == 0 && rm == 6) || mod == 2) {
+				insn->displacement.value =
+					 get_next(short, insn);
+				insn->displacement.nbytes = 2;
+			}
+		} else {
+			if ((mod == 0 && rm == 5) || mod == 2 ||
+			    (mod == 0 && base == 5)) {
+				insn->displacement.value = get_next(int, insn);
+				insn->displacement.nbytes = 4;
+			}
+		}
+	}
+out:
+	insn->displacement.got = 1;
+
+err_out:
+	return;
+}
+
+/* Decode moffset16/32/64. Return 0 if failed */
+static int __get_moffset(struct insn *insn)
+{
+	switch (insn->addr_bytes) {
+	case 2:
+		insn->moffset1.value = get_next(short, insn);
+		insn->moffset1.nbytes = 2;
+		break;
+	case 4:
+		insn->moffset1.value = get_next(int, insn);
+		insn->moffset1.nbytes = 4;
+		break;
+	case 8:
+		insn->moffset1.value = get_next(int, insn);
+		insn->moffset1.nbytes = 4;
+		insn->moffset2.value = get_next(int, insn);
+		insn->moffset2.nbytes = 4;
+		break;
+	default:	/* opnd_bytes must be modified manually */
+		goto err_out;
+	}
+	insn->moffset1.got = insn->moffset2.got = 1;
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+/* Decode imm v32(Iz). Return 0 if failed */
+static int __get_immv32(struct insn *insn)
+{
+	switch (insn->opnd_bytes) {
+	case 2:
+		insn->immediate.value = get_next(short, insn);
+		insn->immediate.nbytes = 2;
+		break;
+	case 4:
+	case 8:
+		insn->immediate.value = get_next(int, insn);
+		insn->immediate.nbytes = 4;
+		break;
+	default:	/* opnd_bytes must be modified manually */
+		goto err_out;
+	}
+
+	return 1;
+
+err_out:
+	return 0;
+}
+
+/* Decode imm v64(Iv/Ov), Return 0 if failed */
+static int __get_immv(struct insn *insn)
+{
+	switch (insn->opnd_bytes) {
+	case 2:
+		insn->immediate1.value = get_next(short, insn);
+		insn->immediate1.nbytes = 2;
+		break;
+	case 4:
+		insn->immediate1.value = get_next(int, insn);
+		insn->immediate1.nbytes = 4;
+		break;
+	case 8:
+		insn->immediate1.value = get_next(int, insn);
+		insn->immediate1.nbytes = 4;
+		insn->immediate2.value = get_next(int, insn);
+		insn->immediate2.nbytes = 4;
+		break;
+	default:	/* opnd_bytes must be modified manually */
+		goto err_out;
+	}
+	insn->immediate1.got = insn->immediate2.got = 1;
+
+	return 1;
+err_out:
+	return 0;
+}
+
+/* Decode ptr16:16/32(Ap) */
+static int __get_immptr(struct insn *insn)
+{
+	switch (insn->opnd_bytes) {
+	case 2:
+		insn->immediate1.value = get_next(short, insn);
+		insn->immediate1.nbytes = 2;
+		break;
+	case 4:
+		insn->immediate1.value = get_next(int, insn);
+		insn->immediate1.nbytes = 4;
+		break;
+	case 8:
+		/* ptr16:64 is not exist (no segment) */
+		return 0;
+	default:	/* opnd_bytes must be modified manually */
+		goto err_out;
+	}
+	insn->immediate2.value = get_next(unsigned short, insn);
+	insn->immediate2.nbytes = 2;
+	insn->immediate1.got = insn->immediate2.got = 1;
+
+	return 1;
+err_out:
+	return 0;
+}
+
+/**
+ * insn_get_immediate() - Get the immediates of instruction
+ * @insn:	&struct insn containing instruction
+ *
+ * If necessary, first collects the instruction up to and including the
+ * displacement bytes.
+ * Basically, most of immediates are sign-expanded. Unsigned-value can be
+ * get by bit masking with ((1 << (nbytes * 8)) - 1)
+ */
+void insn_get_immediate(struct insn *insn)
+{
+	if (insn->immediate.got)
+		return;
+	if (!insn->displacement.got)
+		insn_get_displacement(insn);
+
+	if (inat_has_moffset(insn->attr)) {
+		if (!__get_moffset(insn))
+			goto err_out;
+		goto done;
+	}
+
+	if (!inat_has_immediate(insn->attr))
+		/* no immediates */
+		goto done;
+
+	switch (inat_immediate_size(insn->attr)) {
+	case INAT_IMM_BYTE:
+		insn->immediate.value = get_next(signed char, insn);
+		insn->immediate.nbytes = 1;
+		break;
+	case INAT_IMM_WORD:
+		insn->immediate.value = get_next(short, insn);
+		insn->immediate.nbytes = 2;
+		break;
+	case INAT_IMM_DWORD:
+		insn->immediate.value = get_next(int, insn);
+		insn->immediate.nbytes = 4;
+		break;
+	case INAT_IMM_QWORD:
+		insn->immediate1.value = get_next(int, insn);
+		insn->immediate1.nbytes = 4;
+		insn->immediate2.value = get_next(int, insn);
+		insn->immediate2.nbytes = 4;
+		break;
+	case INAT_IMM_PTR:
+		if (!__get_immptr(insn))
+			goto err_out;
+		break;
+	case INAT_IMM_VWORD32:
+		if (!__get_immv32(insn))
+			goto err_out;
+		break;
+	case INAT_IMM_VWORD:
+		if (!__get_immv(insn))
+			goto err_out;
+		break;
+	default:
+		/* Here, insn must have an immediate, but failed */
+		goto err_out;
+	}
+	if (inat_has_second_immediate(insn->attr)) {
+		insn->immediate2.value = get_next(signed char, insn);
+		insn->immediate2.nbytes = 1;
+	}
+done:
+	insn->immediate.got = 1;
+
+err_out:
+	return;
+}
+
+/**
+ * insn_get_length() - Get the length of instruction
+ * @insn:	&struct insn containing instruction
+ *
+ * If necessary, first collects the instruction up to and including the
+ * immediates bytes.
+ */
+void insn_get_length(struct insn *insn)
+{
+	if (insn->length)
+		return;
+	if (!insn->immediate.got)
+		insn_get_immediate(insn);
+	insn->length = (unsigned char)((unsigned long)insn->next_byte
+				     - (unsigned long)insn->kaddr);
+}
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
new file mode 100644
index 0000000..e0b8593
--- /dev/null
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -0,0 +1,1072 @@
+# x86 Opcode Maps
+#
+# This is (mostly) based on following documentations.
+# - Intel(R) 64 and IA-32 Architectures Software Developer's Manual Vol.2C
+#   (#326018-047US, June 2013)
+#
+#<Opcode maps>
+# Table: table-name
+# Referrer: escaped-name
+# AVXcode: avx-code
+# opcode: mnemonic|GrpXXX [operand1[,operand2...]] [(extra1)[,(extra2)...] [| 2nd-mnemonic ...]
+# (or)
+# opcode: escape # escaped-name
+# EndTable
+#
+# mnemonics that begin with lowercase 'v' accept a VEX or EVEX prefix
+# mnemonics that begin with lowercase 'k' accept a VEX prefix
+#
+#<group maps>
+# GrpTable: GrpXXX
+# reg:  mnemonic [operand1[,operand2...]] [(extra1)[,(extra2)...] [| 2nd-mnemonic ...]
+# EndTable
+#
+# AVX Superscripts
+#  (ev): this opcode requires EVEX prefix.
+#  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
+#  (v): this opcode requires VEX prefix.
+#  (v1): this opcode only supports 128bit VEX.
+#
+# Last Prefix Superscripts
+#  - (66): the last prefix is 0x66
+#  - (F3): the last prefix is 0xF3
+#  - (F2): the last prefix is 0xF2
+#  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
+#  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
+
+Table: one byte opcode
+Referrer:
+AVXcode:
+# 0x00 - 0x0f
+00: ADD Eb,Gb
+01: ADD Ev,Gv
+02: ADD Gb,Eb
+03: ADD Gv,Ev
+04: ADD AL,Ib
+05: ADD rAX,Iz
+06: PUSH ES (i64)
+07: POP ES (i64)
+08: OR Eb,Gb
+09: OR Ev,Gv
+0a: OR Gb,Eb
+0b: OR Gv,Ev
+0c: OR AL,Ib
+0d: OR rAX,Iz
+0e: PUSH CS (i64)
+0f: escape # 2-byte escape
+# 0x10 - 0x1f
+10: ADC Eb,Gb
+11: ADC Ev,Gv
+12: ADC Gb,Eb
+13: ADC Gv,Ev
+14: ADC AL,Ib
+15: ADC rAX,Iz
+16: PUSH SS (i64)
+17: POP SS (i64)
+18: SBB Eb,Gb
+19: SBB Ev,Gv
+1a: SBB Gb,Eb
+1b: SBB Gv,Ev
+1c: SBB AL,Ib
+1d: SBB rAX,Iz
+1e: PUSH DS (i64)
+1f: POP DS (i64)
+# 0x20 - 0x2f
+20: AND Eb,Gb
+21: AND Ev,Gv
+22: AND Gb,Eb
+23: AND Gv,Ev
+24: AND AL,Ib
+25: AND rAx,Iz
+26: SEG=ES (Prefix)
+27: DAA (i64)
+28: SUB Eb,Gb
+29: SUB Ev,Gv
+2a: SUB Gb,Eb
+2b: SUB Gv,Ev
+2c: SUB AL,Ib
+2d: SUB rAX,Iz
+2e: SEG=CS (Prefix)
+2f: DAS (i64)
+# 0x30 - 0x3f
+30: XOR Eb,Gb
+31: XOR Ev,Gv
+32: XOR Gb,Eb
+33: XOR Gv,Ev
+34: XOR AL,Ib
+35: XOR rAX,Iz
+36: SEG=SS (Prefix)
+37: AAA (i64)
+38: CMP Eb,Gb
+39: CMP Ev,Gv
+3a: CMP Gb,Eb
+3b: CMP Gv,Ev
+3c: CMP AL,Ib
+3d: CMP rAX,Iz
+3e: SEG=DS (Prefix)
+3f: AAS (i64)
+# 0x40 - 0x4f
+40: INC eAX (i64) | REX (o64)
+41: INC eCX (i64) | REX.B (o64)
+42: INC eDX (i64) | REX.X (o64)
+43: INC eBX (i64) | REX.XB (o64)
+44: INC eSP (i64) | REX.R (o64)
+45: INC eBP (i64) | REX.RB (o64)
+46: INC eSI (i64) | REX.RX (o64)
+47: INC eDI (i64) | REX.RXB (o64)
+48: DEC eAX (i64) | REX.W (o64)
+49: DEC eCX (i64) | REX.WB (o64)
+4a: DEC eDX (i64) | REX.WX (o64)
+4b: DEC eBX (i64) | REX.WXB (o64)
+4c: DEC eSP (i64) | REX.WR (o64)
+4d: DEC eBP (i64) | REX.WRB (o64)
+4e: DEC eSI (i64) | REX.WRX (o64)
+4f: DEC eDI (i64) | REX.WRXB (o64)
+# 0x50 - 0x5f
+50: PUSH rAX/r8 (d64)
+51: PUSH rCX/r9 (d64)
+52: PUSH rDX/r10 (d64)
+53: PUSH rBX/r11 (d64)
+54: PUSH rSP/r12 (d64)
+55: PUSH rBP/r13 (d64)
+56: PUSH rSI/r14 (d64)
+57: PUSH rDI/r15 (d64)
+58: POP rAX/r8 (d64)
+59: POP rCX/r9 (d64)
+5a: POP rDX/r10 (d64)
+5b: POP rBX/r11 (d64)
+5c: POP rSP/r12 (d64)
+5d: POP rBP/r13 (d64)
+5e: POP rSI/r14 (d64)
+5f: POP rDI/r15 (d64)
+# 0x60 - 0x6f
+60: PUSHA/PUSHAD (i64)
+61: POPA/POPAD (i64)
+62: BOUND Gv,Ma (i64) | EVEX (Prefix)
+63: ARPL Ew,Gw (i64) | MOVSXD Gv,Ev (o64)
+64: SEG=FS (Prefix)
+65: SEG=GS (Prefix)
+66: Operand-Size (Prefix)
+67: Address-Size (Prefix)
+68: PUSH Iz (d64)
+69: IMUL Gv,Ev,Iz
+6a: PUSH Ib (d64)
+6b: IMUL Gv,Ev,Ib
+6c: INS/INSB Yb,DX
+6d: INS/INSW/INSD Yz,DX
+6e: OUTS/OUTSB DX,Xb
+6f: OUTS/OUTSW/OUTSD DX,Xz
+# 0x70 - 0x7f
+70: JO Jb
+71: JNO Jb
+72: JB/JNAE/JC Jb
+73: JNB/JAE/JNC Jb
+74: JZ/JE Jb
+75: JNZ/JNE Jb
+76: JBE/JNA Jb
+77: JNBE/JA Jb
+78: JS Jb
+79: JNS Jb
+7a: JP/JPE Jb
+7b: JNP/JPO Jb
+7c: JL/JNGE Jb
+7d: JNL/JGE Jb
+7e: JLE/JNG Jb
+7f: JNLE/JG Jb
+# 0x80 - 0x8f
+80: Grp1 Eb,Ib (1A)
+81: Grp1 Ev,Iz (1A)
+82: Grp1 Eb,Ib (1A),(i64)
+83: Grp1 Ev,Ib (1A)
+84: TEST Eb,Gb
+85: TEST Ev,Gv
+86: XCHG Eb,Gb
+87: XCHG Ev,Gv
+88: MOV Eb,Gb
+89: MOV Ev,Gv
+8a: MOV Gb,Eb
+8b: MOV Gv,Ev
+8c: MOV Ev,Sw
+8d: LEA Gv,M
+8e: MOV Sw,Ew
+8f: Grp1A (1A) | POP Ev (d64)
+# 0x90 - 0x9f
+90: NOP | PAUSE (F3) | XCHG r8,rAX
+91: XCHG rCX/r9,rAX
+92: XCHG rDX/r10,rAX
+93: XCHG rBX/r11,rAX
+94: XCHG rSP/r12,rAX
+95: XCHG rBP/r13,rAX
+96: XCHG rSI/r14,rAX
+97: XCHG rDI/r15,rAX
+98: CBW/CWDE/CDQE
+99: CWD/CDQ/CQO
+9a: CALLF Ap (i64)
+9b: FWAIT/WAIT
+9c: PUSHF/D/Q Fv (d64)
+9d: POPF/D/Q Fv (d64)
+9e: SAHF
+9f: LAHF
+# 0xa0 - 0xaf
+a0: MOV AL,Ob
+a1: MOV rAX,Ov
+a2: MOV Ob,AL
+a3: MOV Ov,rAX
+a4: MOVS/B Yb,Xb
+a5: MOVS/W/D/Q Yv,Xv
+a6: CMPS/B Xb,Yb
+a7: CMPS/W/D Xv,Yv
+a8: TEST AL,Ib
+a9: TEST rAX,Iz
+aa: STOS/B Yb,AL
+ab: STOS/W/D/Q Yv,rAX
+ac: LODS/B AL,Xb
+ad: LODS/W/D/Q rAX,Xv
+ae: SCAS/B AL,Yb
+# Note: The May 2011 Intel manual shows Xv for the second parameter of the
+# next instruction but Yv is correct
+af: SCAS/W/D/Q rAX,Yv
+# 0xb0 - 0xbf
+b0: MOV AL/R8L,Ib
+b1: MOV CL/R9L,Ib
+b2: MOV DL/R10L,Ib
+b3: MOV BL/R11L,Ib
+b4: MOV AH/R12L,Ib
+b5: MOV CH/R13L,Ib
+b6: MOV DH/R14L,Ib
+b7: MOV BH/R15L,Ib
+b8: MOV rAX/r8,Iv
+b9: MOV rCX/r9,Iv
+ba: MOV rDX/r10,Iv
+bb: MOV rBX/r11,Iv
+bc: MOV rSP/r12,Iv
+bd: MOV rBP/r13,Iv
+be: MOV rSI/r14,Iv
+bf: MOV rDI/r15,Iv
+# 0xc0 - 0xcf
+c0: Grp2 Eb,Ib (1A)
+c1: Grp2 Ev,Ib (1A)
+c2: RETN Iw (f64)
+c3: RETN
+c4: LES Gz,Mp (i64) | VEX+2byte (Prefix)
+c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix)
+c6: Grp11A Eb,Ib (1A)
+c7: Grp11B Ev,Iz (1A)
+c8: ENTER Iw,Ib
+c9: LEAVE (d64)
+ca: RETF Iw
+cb: RETF
+cc: INT3
+cd: INT Ib
+ce: INTO (i64)
+cf: IRET/D/Q
+# 0xd0 - 0xdf
+d0: Grp2 Eb,1 (1A)
+d1: Grp2 Ev,1 (1A)
+d2: Grp2 Eb,CL (1A)
+d3: Grp2 Ev,CL (1A)
+d4: AAM Ib (i64)
+d5: AAD Ib (i64)
+d6:
+d7: XLAT/XLATB
+d8: ESC
+d9: ESC
+da: ESC
+db: ESC
+dc: ESC
+dd: ESC
+de: ESC
+df: ESC
+# 0xe0 - 0xef
+# Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
+# in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
+# to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
+e0: LOOPNE/LOOPNZ Jb (f64)
+e1: LOOPE/LOOPZ Jb (f64)
+e2: LOOP Jb (f64)
+e3: JrCXZ Jb (f64)
+e4: IN AL,Ib
+e5: IN eAX,Ib
+e6: OUT Ib,AL
+e7: OUT Ib,eAX
+# With 0x66 prefix in 64-bit mode, for AMD CPUs immediate offset
+# in "near" jumps and calls is 16-bit. For CALL,
+# push of return address is 16-bit wide, RSP is decremented by 2
+# but is not truncated to 16 bits, unlike RIP.
+e8: CALL Jz (f64)
+e9: JMP-near Jz (f64)
+ea: JMP-far Ap (i64)
+eb: JMP-short Jb (f64)
+ec: IN AL,DX
+ed: IN eAX,DX
+ee: OUT DX,AL
+ef: OUT DX,eAX
+# 0xf0 - 0xff
+f0: LOCK (Prefix)
+f1:
+f2: REPNE (Prefix) | XACQUIRE (Prefix)
+f3: REP/REPE (Prefix) | XRELEASE (Prefix)
+f4: HLT
+f5: CMC
+f6: Grp3_1 Eb (1A)
+f7: Grp3_2 Ev (1A)
+f8: CLC
+f9: STC
+fa: CLI
+fb: STI
+fc: CLD
+fd: STD
+fe: Grp4 (1A)
+ff: Grp5 (1A)
+EndTable
+
+Table: 2-byte opcode (0x0f)
+Referrer: 2-byte escape
+AVXcode: 1
+# 0x0f 0x00-0x0f
+00: Grp6 (1A)
+01: Grp7 (1A)
+02: LAR Gv,Ew
+03: LSL Gv,Ew
+04:
+05: SYSCALL (o64)
+06: CLTS
+07: SYSRET (o64)
+08: INVD
+09: WBINVD
+0a:
+0b: UD2 (1B)
+0c:
+# AMD's prefetch group. Intel supports prefetchw(/1) only.
+0d: GrpP
+0e: FEMMS
+# 3DNow! uses the last imm byte as opcode extension.
+0f: 3DNow! Pq,Qq,Ib
+# 0x0f 0x10-0x1f
+# NOTE: According to Intel SDM opcode map, vmovups and vmovupd has no operands
+# but it actually has operands. And also, vmovss and vmovsd only accept 128bit.
+# MOVSS/MOVSD has too many forms(3) on SDM. This map just shows a typical form.
+# Many AVX instructions lack v1 superscript, according to Intel AVX-Prgramming
+# Reference A.1
+10: vmovups Vps,Wps | vmovupd Vpd,Wpd (66) | vmovss Vx,Hx,Wss (F3),(v1) | vmovsd Vx,Hx,Wsd (F2),(v1)
+11: vmovups Wps,Vps | vmovupd Wpd,Vpd (66) | vmovss Wss,Hx,Vss (F3),(v1) | vmovsd Wsd,Hx,Vsd (F2),(v1)
+12: vmovlps Vq,Hq,Mq (v1) | vmovhlps Vq,Hq,Uq (v1) | vmovlpd Vq,Hq,Mq (66),(v1) | vmovsldup Vx,Wx (F3) | vmovddup Vx,Wx (F2)
+13: vmovlps Mq,Vq (v1) | vmovlpd Mq,Vq (66),(v1)
+14: vunpcklps Vx,Hx,Wx | vunpcklpd Vx,Hx,Wx (66)
+15: vunpckhps Vx,Hx,Wx | vunpckhpd Vx,Hx,Wx (66)
+16: vmovhps Vdq,Hq,Mq (v1) | vmovlhps Vdq,Hq,Uq (v1) | vmovhpd Vdq,Hq,Mq (66),(v1) | vmovshdup Vx,Wx (F3)
+17: vmovhps Mq,Vq (v1) | vmovhpd Mq,Vq (66),(v1)
+18: Grp16 (1A)
+19:
+# Intel SDM opcode map does not list MPX instructions. For now using Gv for
+# bnd registers and Ev for everything else is OK because the instruction
+# decoder does not use the information except as an indication that there is
+# a ModR/M byte.
+1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
+1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
+1c:
+1d:
+1e:
+1f: NOP Ev
+# 0x0f 0x20-0x2f
+20: MOV Rd,Cd
+21: MOV Rd,Dd
+22: MOV Cd,Rd
+23: MOV Dd,Rd
+24:
+25:
+26:
+27:
+28: vmovaps Vps,Wps | vmovapd Vpd,Wpd (66)
+29: vmovaps Wps,Vps | vmovapd Wpd,Vpd (66)
+2a: cvtpi2ps Vps,Qpi | cvtpi2pd Vpd,Qpi (66) | vcvtsi2ss Vss,Hss,Ey (F3),(v1) | vcvtsi2sd Vsd,Hsd,Ey (F2),(v1)
+2b: vmovntps Mps,Vps | vmovntpd Mpd,Vpd (66)
+2c: cvttps2pi Ppi,Wps | cvttpd2pi Ppi,Wpd (66) | vcvttss2si Gy,Wss (F3),(v1) | vcvttsd2si Gy,Wsd (F2),(v1)
+2d: cvtps2pi Ppi,Wps | cvtpd2pi Qpi,Wpd (66) | vcvtss2si Gy,Wss (F3),(v1) | vcvtsd2si Gy,Wsd (F2),(v1)
+2e: vucomiss Vss,Wss (v1) | vucomisd  Vsd,Wsd (66),(v1)
+2f: vcomiss Vss,Wss (v1) | vcomisd  Vsd,Wsd (66),(v1)
+# 0x0f 0x30-0x3f
+30: WRMSR
+31: RDTSC
+32: RDMSR
+33: RDPMC
+34: SYSENTER
+35: SYSEXIT
+36:
+37: GETSEC
+38: escape # 3-byte escape 1
+39:
+3a: escape # 3-byte escape 2
+3b:
+3c:
+3d:
+3e:
+3f:
+# 0x0f 0x40-0x4f
+40: CMOVO Gv,Ev
+41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk | kandb/d Vk,Hk,Uk (66)
+42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk | kandnb/d Vk,Hk,Uk (66)
+43: CMOVAE/NB/NC Gv,Ev
+44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk | knotb/d Vk,Uk (66)
+45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk | korb/d Vk,Hk,Uk (66)
+46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk | kxnorb/d Vk,Hk,Uk (66)
+47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk | kxorb/d Vk,Hk,Uk (66)
+48: CMOVS Gv,Ev
+49: CMOVNS Gv,Ev
+4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk | kaddb/d Vk,Hk,Uk (66)
+4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66) | kunpckwd/dq Vk,Hk,Uk
+4c: CMOVL/NGE Gv,Ev
+4d: CMOVNL/GE Gv,Ev
+4e: CMOVLE/NG Gv,Ev
+4f: CMOVNLE/G Gv,Ev
+# 0x0f 0x50-0x5f
+50: vmovmskps Gy,Ups | vmovmskpd Gy,Upd (66)
+51: vsqrtps Vps,Wps | vsqrtpd Vpd,Wpd (66) | vsqrtss Vss,Hss,Wss (F3),(v1) | vsqrtsd Vsd,Hsd,Wsd (F2),(v1)
+52: vrsqrtps Vps,Wps | vrsqrtss Vss,Hss,Wss (F3),(v1)
+53: vrcpps Vps,Wps | vrcpss Vss,Hss,Wss (F3),(v1)
+54: vandps Vps,Hps,Wps | vandpd Vpd,Hpd,Wpd (66)
+55: vandnps Vps,Hps,Wps | vandnpd Vpd,Hpd,Wpd (66)
+56: vorps Vps,Hps,Wps | vorpd Vpd,Hpd,Wpd (66)
+57: vxorps Vps,Hps,Wps | vxorpd Vpd,Hpd,Wpd (66)
+58: vaddps Vps,Hps,Wps | vaddpd Vpd,Hpd,Wpd (66) | vaddss Vss,Hss,Wss (F3),(v1) | vaddsd Vsd,Hsd,Wsd (F2),(v1)
+59: vmulps Vps,Hps,Wps | vmulpd Vpd,Hpd,Wpd (66) | vmulss Vss,Hss,Wss (F3),(v1) | vmulsd Vsd,Hsd,Wsd (F2),(v1)
+5a: vcvtps2pd Vpd,Wps | vcvtpd2ps Vps,Wpd (66) | vcvtss2sd Vsd,Hx,Wss (F3),(v1) | vcvtsd2ss Vss,Hx,Wsd (F2),(v1)
+5b: vcvtdq2ps Vps,Wdq | vcvtqq2ps Vps,Wqq (evo) | vcvtps2dq Vdq,Wps (66) | vcvttps2dq Vdq,Wps (F3)
+5c: vsubps Vps,Hps,Wps | vsubpd Vpd,Hpd,Wpd (66) | vsubss Vss,Hss,Wss (F3),(v1) | vsubsd Vsd,Hsd,Wsd (F2),(v1)
+5d: vminps Vps,Hps,Wps | vminpd Vpd,Hpd,Wpd (66) | vminss Vss,Hss,Wss (F3),(v1) | vminsd Vsd,Hsd,Wsd (F2),(v1)
+5e: vdivps Vps,Hps,Wps | vdivpd Vpd,Hpd,Wpd (66) | vdivss Vss,Hss,Wss (F3),(v1) | vdivsd Vsd,Hsd,Wsd (F2),(v1)
+5f: vmaxps Vps,Hps,Wps | vmaxpd Vpd,Hpd,Wpd (66) | vmaxss Vss,Hss,Wss (F3),(v1) | vmaxsd Vsd,Hsd,Wsd (F2),(v1)
+# 0x0f 0x60-0x6f
+60: punpcklbw Pq,Qd | vpunpcklbw Vx,Hx,Wx (66),(v1)
+61: punpcklwd Pq,Qd | vpunpcklwd Vx,Hx,Wx (66),(v1)
+62: punpckldq Pq,Qd | vpunpckldq Vx,Hx,Wx (66),(v1)
+63: packsswb Pq,Qq | vpacksswb Vx,Hx,Wx (66),(v1)
+64: pcmpgtb Pq,Qq | vpcmpgtb Vx,Hx,Wx (66),(v1)
+65: pcmpgtw Pq,Qq | vpcmpgtw Vx,Hx,Wx (66),(v1)
+66: pcmpgtd Pq,Qq | vpcmpgtd Vx,Hx,Wx (66),(v1)
+67: packuswb Pq,Qq | vpackuswb Vx,Hx,Wx (66),(v1)
+68: punpckhbw Pq,Qd | vpunpckhbw Vx,Hx,Wx (66),(v1)
+69: punpckhwd Pq,Qd | vpunpckhwd Vx,Hx,Wx (66),(v1)
+6a: punpckhdq Pq,Qd | vpunpckhdq Vx,Hx,Wx (66),(v1)
+6b: packssdw Pq,Qd | vpackssdw Vx,Hx,Wx (66),(v1)
+6c: vpunpcklqdq Vx,Hx,Wx (66),(v1)
+6d: vpunpckhqdq Vx,Hx,Wx (66),(v1)
+6e: movd/q Pd,Ey | vmovd/q Vy,Ey (66),(v1)
+6f: movq Pq,Qq | vmovdqa Vx,Wx (66) | vmovdqa32/64 Vx,Wx (66),(evo) | vmovdqu Vx,Wx (F3) | vmovdqu32/64 Vx,Wx (F3),(evo) | vmovdqu8/16 Vx,Wx (F2),(ev)
+# 0x0f 0x70-0x7f
+70: pshufw Pq,Qq,Ib | vpshufd Vx,Wx,Ib (66),(v1) | vpshufhw Vx,Wx,Ib (F3),(v1) | vpshuflw Vx,Wx,Ib (F2),(v1)
+71: Grp12 (1A)
+72: Grp13 (1A)
+73: Grp14 (1A)
+74: pcmpeqb Pq,Qq | vpcmpeqb Vx,Hx,Wx (66),(v1)
+75: pcmpeqw Pq,Qq | vpcmpeqw Vx,Hx,Wx (66),(v1)
+76: pcmpeqd Pq,Qq | vpcmpeqd Vx,Hx,Wx (66),(v1)
+# Note: Remove (v), because vzeroall and vzeroupper becomes emms without VEX.
+77: emms | vzeroupper | vzeroall
+78: VMREAD Ey,Gy | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
+79: VMWRITE Gy,Ey | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
+7a: vcvtudq2pd/uqq2pd Vpd,Wx (F3),(ev) | vcvtudq2ps/uqq2ps Vpd,Wx (F2),(ev) | vcvttps2qq/pd2qq Vx,Wx (66),(ev)
+7b: vcvtusi2sd Vpd,Hpd,Ev (F2),(ev) | vcvtusi2ss Vps,Hps,Ev (F3),(ev) | vcvtps2qq/pd2qq Vx,Wx (66),(ev)
+7c: vhaddpd Vpd,Hpd,Wpd (66) | vhaddps Vps,Hps,Wps (F2)
+7d: vhsubpd Vpd,Hpd,Wpd (66) | vhsubps Vps,Hps,Wps (F2)
+7e: movd/q Ey,Pd | vmovd/q Ey,Vy (66),(v1) | vmovq Vq,Wq (F3),(v1)
+7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
+# 0x0f 0x80-0x8f
+# Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
+80: JO Jz (f64)
+81: JNO Jz (f64)
+82: JB/JC/JNAE Jz (f64)
+83: JAE/JNB/JNC Jz (f64)
+84: JE/JZ Jz (f64)
+85: JNE/JNZ Jz (f64)
+86: JBE/JNA Jz (f64)
+87: JA/JNBE Jz (f64)
+88: JS Jz (f64)
+89: JNS Jz (f64)
+8a: JP/JPE Jz (f64)
+8b: JNP/JPO Jz (f64)
+8c: JL/JNGE Jz (f64)
+8d: JNL/JGE Jz (f64)
+8e: JLE/JNG Jz (f64)
+8f: JNLE/JG Jz (f64)
+# 0x0f 0x90-0x9f
+90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
+91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
+92: SETB/C/NAE Eb | kmovw Vk,Rv | kmovb Vk,Rv (66) | kmovq/d Vk,Rv (F2)
+93: SETAE/NB/NC Eb | kmovw Gv,Uk | kmovb Gv,Uk (66) | kmovq/d Gv,Uk (F2)
+94: SETE/Z Eb
+95: SETNE/NZ Eb
+96: SETBE/NA Eb
+97: SETA/NBE Eb
+98: SETS Eb | kortestw/q Vk,Uk | kortestb/d Vk,Uk (66)
+99: SETNS Eb | ktestw/q Vk,Uk | ktestb/d Vk,Uk (66)
+9a: SETP/PE Eb
+9b: SETNP/PO Eb
+9c: SETL/NGE Eb
+9d: SETNL/GE Eb
+9e: SETLE/NG Eb
+9f: SETNLE/G Eb
+# 0x0f 0xa0-0xaf
+a0: PUSH FS (d64)
+a1: POP FS (d64)
+a2: CPUID
+a3: BT Ev,Gv
+a4: SHLD Ev,Gv,Ib
+a5: SHLD Ev,Gv,CL
+a6: GrpPDLK
+a7: GrpRNG
+a8: PUSH GS (d64)
+a9: POP GS (d64)
+aa: RSM
+ab: BTS Ev,Gv
+ac: SHRD Ev,Gv,Ib
+ad: SHRD Ev,Gv,CL
+ae: Grp15 (1A),(1C)
+af: IMUL Gv,Ev
+# 0x0f 0xb0-0xbf
+b0: CMPXCHG Eb,Gb
+b1: CMPXCHG Ev,Gv
+b2: LSS Gv,Mp
+b3: BTR Ev,Gv
+b4: LFS Gv,Mp
+b5: LGS Gv,Mp
+b6: MOVZX Gv,Eb
+b7: MOVZX Gv,Ew
+b8: JMPE (!F3) | POPCNT Gv,Ev (F3)
+b9: Grp10 (1A)
+ba: Grp8 Ev,Ib (1A)
+bb: BTC Ev,Gv
+bc: BSF Gv,Ev (!F3) | TZCNT Gv,Ev (F3)
+bd: BSR Gv,Ev (!F3) | LZCNT Gv,Ev (F3)
+be: MOVSX Gv,Eb
+bf: MOVSX Gv,Ew
+# 0x0f 0xc0-0xcf
+c0: XADD Eb,Gb
+c1: XADD Ev,Gv
+c2: vcmpps Vps,Hps,Wps,Ib | vcmppd Vpd,Hpd,Wpd,Ib (66) | vcmpss Vss,Hss,Wss,Ib (F3),(v1) | vcmpsd Vsd,Hsd,Wsd,Ib (F2),(v1)
+c3: movnti My,Gy
+c4: pinsrw Pq,Ry/Mw,Ib | vpinsrw Vdq,Hdq,Ry/Mw,Ib (66),(v1)
+c5: pextrw Gd,Nq,Ib | vpextrw Gd,Udq,Ib (66),(v1)
+c6: vshufps Vps,Hps,Wps,Ib | vshufpd Vpd,Hpd,Wpd,Ib (66)
+c7: Grp9 (1A)
+c8: BSWAP RAX/EAX/R8/R8D
+c9: BSWAP RCX/ECX/R9/R9D
+ca: BSWAP RDX/EDX/R10/R10D
+cb: BSWAP RBX/EBX/R11/R11D
+cc: BSWAP RSP/ESP/R12/R12D
+cd: BSWAP RBP/EBP/R13/R13D
+ce: BSWAP RSI/ESI/R14/R14D
+cf: BSWAP RDI/EDI/R15/R15D
+# 0x0f 0xd0-0xdf
+d0: vaddsubpd Vpd,Hpd,Wpd (66) | vaddsubps Vps,Hps,Wps (F2)
+d1: psrlw Pq,Qq | vpsrlw Vx,Hx,Wx (66),(v1)
+d2: psrld Pq,Qq | vpsrld Vx,Hx,Wx (66),(v1)
+d3: psrlq Pq,Qq | vpsrlq Vx,Hx,Wx (66),(v1)
+d4: paddq Pq,Qq | vpaddq Vx,Hx,Wx (66),(v1)
+d5: pmullw Pq,Qq | vpmullw Vx,Hx,Wx (66),(v1)
+d6: vmovq Wq,Vq (66),(v1) | movq2dq Vdq,Nq (F3) | movdq2q Pq,Uq (F2)
+d7: pmovmskb Gd,Nq | vpmovmskb Gd,Ux (66),(v1)
+d8: psubusb Pq,Qq | vpsubusb Vx,Hx,Wx (66),(v1)
+d9: psubusw Pq,Qq | vpsubusw Vx,Hx,Wx (66),(v1)
+da: pminub Pq,Qq | vpminub Vx,Hx,Wx (66),(v1)
+db: pand Pq,Qq | vpand Vx,Hx,Wx (66),(v1) | vpandd/q Vx,Hx,Wx (66),(evo)
+dc: paddusb Pq,Qq | vpaddusb Vx,Hx,Wx (66),(v1)
+dd: paddusw Pq,Qq | vpaddusw Vx,Hx,Wx (66),(v1)
+de: pmaxub Pq,Qq | vpmaxub Vx,Hx,Wx (66),(v1)
+df: pandn Pq,Qq | vpandn Vx,Hx,Wx (66),(v1) | vpandnd/q Vx,Hx,Wx (66),(evo)
+# 0x0f 0xe0-0xef
+e0: pavgb Pq,Qq | vpavgb Vx,Hx,Wx (66),(v1)
+e1: psraw Pq,Qq | vpsraw Vx,Hx,Wx (66),(v1)
+e2: psrad Pq,Qq | vpsrad Vx,Hx,Wx (66),(v1)
+e3: pavgw Pq,Qq | vpavgw Vx,Hx,Wx (66),(v1)
+e4: pmulhuw Pq,Qq | vpmulhuw Vx,Hx,Wx (66),(v1)
+e5: pmulhw Pq,Qq | vpmulhw Vx,Hx,Wx (66),(v1)
+e6: vcvttpd2dq Vx,Wpd (66) | vcvtdq2pd Vx,Wdq (F3) | vcvtdq2pd/qq2pd Vx,Wdq (F3),(evo) | vcvtpd2dq Vx,Wpd (F2)
+e7: movntq Mq,Pq | vmovntdq Mx,Vx (66)
+e8: psubsb Pq,Qq | vpsubsb Vx,Hx,Wx (66),(v1)
+e9: psubsw Pq,Qq | vpsubsw Vx,Hx,Wx (66),(v1)
+ea: pminsw Pq,Qq | vpminsw Vx,Hx,Wx (66),(v1)
+eb: por Pq,Qq | vpor Vx,Hx,Wx (66),(v1) | vpord/q Vx,Hx,Wx (66),(evo)
+ec: paddsb Pq,Qq | vpaddsb Vx,Hx,Wx (66),(v1)
+ed: paddsw Pq,Qq | vpaddsw Vx,Hx,Wx (66),(v1)
+ee: pmaxsw Pq,Qq | vpmaxsw Vx,Hx,Wx (66),(v1)
+ef: pxor Pq,Qq | vpxor Vx,Hx,Wx (66),(v1) | vpxord/q Vx,Hx,Wx (66),(evo)
+# 0x0f 0xf0-0xff
+f0: vlddqu Vx,Mx (F2)
+f1: psllw Pq,Qq | vpsllw Vx,Hx,Wx (66),(v1)
+f2: pslld Pq,Qq | vpslld Vx,Hx,Wx (66),(v1)
+f3: psllq Pq,Qq | vpsllq Vx,Hx,Wx (66),(v1)
+f4: pmuludq Pq,Qq | vpmuludq Vx,Hx,Wx (66),(v1)
+f5: pmaddwd Pq,Qq | vpmaddwd Vx,Hx,Wx (66),(v1)
+f6: psadbw Pq,Qq | vpsadbw Vx,Hx,Wx (66),(v1)
+f7: maskmovq Pq,Nq | vmaskmovdqu Vx,Ux (66),(v1)
+f8: psubb Pq,Qq | vpsubb Vx,Hx,Wx (66),(v1)
+f9: psubw Pq,Qq | vpsubw Vx,Hx,Wx (66),(v1)
+fa: psubd Pq,Qq | vpsubd Vx,Hx,Wx (66),(v1)
+fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
+fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
+fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
+fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
+ff: UD0
+EndTable
+
+Table: 3-byte opcode 1 (0x0f 0x38)
+Referrer: 3-byte escape 1
+AVXcode: 2
+# 0x0f 0x38 0x00-0x0f
+00: pshufb Pq,Qq | vpshufb Vx,Hx,Wx (66),(v1)
+01: phaddw Pq,Qq | vphaddw Vx,Hx,Wx (66),(v1)
+02: phaddd Pq,Qq | vphaddd Vx,Hx,Wx (66),(v1)
+03: phaddsw Pq,Qq | vphaddsw Vx,Hx,Wx (66),(v1)
+04: pmaddubsw Pq,Qq | vpmaddubsw Vx,Hx,Wx (66),(v1)
+05: phsubw Pq,Qq | vphsubw Vx,Hx,Wx (66),(v1)
+06: phsubd Pq,Qq | vphsubd Vx,Hx,Wx (66),(v1)
+07: phsubsw Pq,Qq | vphsubsw Vx,Hx,Wx (66),(v1)
+08: psignb Pq,Qq | vpsignb Vx,Hx,Wx (66),(v1)
+09: psignw Pq,Qq | vpsignw Vx,Hx,Wx (66),(v1)
+0a: psignd Pq,Qq | vpsignd Vx,Hx,Wx (66),(v1)
+0b: pmulhrsw Pq,Qq | vpmulhrsw Vx,Hx,Wx (66),(v1)
+0c: vpermilps Vx,Hx,Wx (66),(v)
+0d: vpermilpd Vx,Hx,Wx (66),(v)
+0e: vtestps Vx,Wx (66),(v)
+0f: vtestpd Vx,Wx (66),(v)
+# 0x0f 0x38 0x10-0x1f
+10: pblendvb Vdq,Wdq (66) | vpsrlvw Vx,Hx,Wx (66),(evo) | vpmovuswb Wx,Vx (F3),(ev)
+11: vpmovusdb Wx,Vd (F3),(ev) | vpsravw Vx,Hx,Wx (66),(ev)
+12: vpmovusqb Wx,Vq (F3),(ev) | vpsllvw Vx,Hx,Wx (66),(ev)
+13: vcvtph2ps Vx,Wx (66),(v) | vpmovusdw Wx,Vd (F3),(ev)
+14: blendvps Vdq,Wdq (66) | vpmovusqw Wx,Vq (F3),(ev) | vprorvd/q Vx,Hx,Wx (66),(evo)
+15: blendvpd Vdq,Wdq (66) | vpmovusqd Wx,Vq (F3),(ev) | vprolvd/q Vx,Hx,Wx (66),(evo)
+16: vpermps Vqq,Hqq,Wqq (66),(v) | vpermps/d Vqq,Hqq,Wqq (66),(evo)
+17: vptest Vx,Wx (66)
+18: vbroadcastss Vx,Wd (66),(v)
+19: vbroadcastsd Vqq,Wq (66),(v) | vbroadcastf32x2 Vqq,Wq (66),(evo)
+1a: vbroadcastf128 Vqq,Mdq (66),(v) | vbroadcastf32x4/64x2 Vqq,Wq (66),(evo)
+1b: vbroadcastf32x8/64x4 Vqq,Mdq (66),(ev)
+1c: pabsb Pq,Qq | vpabsb Vx,Wx (66),(v1)
+1d: pabsw Pq,Qq | vpabsw Vx,Wx (66),(v1)
+1e: pabsd Pq,Qq | vpabsd Vx,Wx (66),(v1)
+1f: vpabsq Vx,Wx (66),(ev)
+# 0x0f 0x38 0x20-0x2f
+20: vpmovsxbw Vx,Ux/Mq (66),(v1) | vpmovswb Wx,Vx (F3),(ev)
+21: vpmovsxbd Vx,Ux/Md (66),(v1) | vpmovsdb Wx,Vd (F3),(ev)
+22: vpmovsxbq Vx,Ux/Mw (66),(v1) | vpmovsqb Wx,Vq (F3),(ev)
+23: vpmovsxwd Vx,Ux/Mq (66),(v1) | vpmovsdw Wx,Vd (F3),(ev)
+24: vpmovsxwq Vx,Ux/Md (66),(v1) | vpmovsqw Wx,Vq (F3),(ev)
+25: vpmovsxdq Vx,Ux/Mq (66),(v1) | vpmovsqd Wx,Vq (F3),(ev)
+26: vptestmb/w Vk,Hx,Wx (66),(ev) | vptestnmb/w Vk,Hx,Wx (F3),(ev)
+27: vptestmd/q Vk,Hx,Wx (66),(ev) | vptestnmd/q Vk,Hx,Wx (F3),(ev)
+28: vpmuldq Vx,Hx,Wx (66),(v1) | vpmovm2b/w Vx,Uk (F3),(ev)
+29: vpcmpeqq Vx,Hx,Wx (66),(v1) | vpmovb2m/w2m Vk,Ux (F3),(ev)
+2a: vmovntdqa Vx,Mx (66),(v1) | vpbroadcastmb2q Vx,Uk (F3),(ev)
+2b: vpackusdw Vx,Hx,Wx (66),(v1)
+2c: vmaskmovps Vx,Hx,Mx (66),(v) | vscalefps/d Vx,Hx,Wx (66),(evo)
+2d: vmaskmovpd Vx,Hx,Mx (66),(v) | vscalefss/d Vx,Hx,Wx (66),(evo)
+2e: vmaskmovps Mx,Hx,Vx (66),(v)
+2f: vmaskmovpd Mx,Hx,Vx (66),(v)
+# 0x0f 0x38 0x30-0x3f
+30: vpmovzxbw Vx,Ux/Mq (66),(v1) | vpmovwb Wx,Vx (F3),(ev)
+31: vpmovzxbd Vx,Ux/Md (66),(v1) | vpmovdb Wx,Vd (F3),(ev)
+32: vpmovzxbq Vx,Ux/Mw (66),(v1) | vpmovqb Wx,Vq (F3),(ev)
+33: vpmovzxwd Vx,Ux/Mq (66),(v1) | vpmovdw Wx,Vd (F3),(ev)
+34: vpmovzxwq Vx,Ux/Md (66),(v1) | vpmovqw Wx,Vq (F3),(ev)
+35: vpmovzxdq Vx,Ux/Mq (66),(v1) | vpmovqd Wx,Vq (F3),(ev)
+36: vpermd Vqq,Hqq,Wqq (66),(v) | vpermd/q Vqq,Hqq,Wqq (66),(evo)
+37: vpcmpgtq Vx,Hx,Wx (66),(v1)
+38: vpminsb Vx,Hx,Wx (66),(v1) | vpmovm2d/q Vx,Uk (F3),(ev)
+39: vpminsd Vx,Hx,Wx (66),(v1) | vpminsd/q Vx,Hx,Wx (66),(evo) | vpmovd2m/q2m Vk,Ux (F3),(ev)
+3a: vpminuw Vx,Hx,Wx (66),(v1) | vpbroadcastmw2d Vx,Uk (F3),(ev)
+3b: vpminud Vx,Hx,Wx (66),(v1) | vpminud/q Vx,Hx,Wx (66),(evo)
+3c: vpmaxsb Vx,Hx,Wx (66),(v1)
+3d: vpmaxsd Vx,Hx,Wx (66),(v1) | vpmaxsd/q Vx,Hx,Wx (66),(evo)
+3e: vpmaxuw Vx,Hx,Wx (66),(v1)
+3f: vpmaxud Vx,Hx,Wx (66),(v1) | vpmaxud/q Vx,Hx,Wx (66),(evo)
+# 0x0f 0x38 0x40-0x8f
+40: vpmulld Vx,Hx,Wx (66),(v1) | vpmulld/q Vx,Hx,Wx (66),(evo)
+41: vphminposuw Vdq,Wdq (66),(v1)
+42: vgetexpps/d Vx,Wx (66),(ev)
+43: vgetexpss/d Vx,Hx,Wx (66),(ev)
+44: vplzcntd/q Vx,Wx (66),(ev)
+45: vpsrlvd/q Vx,Hx,Wx (66),(v)
+46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
+47: vpsllvd/q Vx,Hx,Wx (66),(v)
+# Skip 0x48-0x4b
+4c: vrcp14ps/d Vpd,Wpd (66),(ev)
+4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
+4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
+4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
+# Skip 0x50-0x57
+58: vpbroadcastd Vx,Wx (66),(v)
+59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
+5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
+5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
+# Skip 0x5c-0x63
+64: vpblendmd/q Vx,Hx,Wx (66),(ev)
+65: vblendmps/d Vx,Hx,Wx (66),(ev)
+66: vpblendmb/w Vx,Hx,Wx (66),(ev)
+# Skip 0x67-0x74
+75: vpermi2b/w Vx,Hx,Wx (66),(ev)
+76: vpermi2d/q Vx,Hx,Wx (66),(ev)
+77: vpermi2ps/d Vx,Hx,Wx (66),(ev)
+78: vpbroadcastb Vx,Wx (66),(v)
+79: vpbroadcastw Vx,Wx (66),(v)
+7a: vpbroadcastb Vx,Rv (66),(ev)
+7b: vpbroadcastw Vx,Rv (66),(ev)
+7c: vpbroadcastd/q Vx,Rv (66),(ev)
+7d: vpermt2b/w Vx,Hx,Wx (66),(ev)
+7e: vpermt2d/q Vx,Hx,Wx (66),(ev)
+7f: vpermt2ps/d Vx,Hx,Wx (66),(ev)
+80: INVEPT Gy,Mdq (66)
+81: INVVPID Gy,Mdq (66)
+82: INVPCID Gy,Mdq (66)
+83: vpmultishiftqb Vx,Hx,Wx (66),(ev)
+88: vexpandps/d Vpd,Wpd (66),(ev)
+89: vpexpandd/q Vx,Wx (66),(ev)
+8a: vcompressps/d Wx,Vx (66),(ev)
+8b: vpcompressd/q Wx,Vx (66),(ev)
+8c: vpmaskmovd/q Vx,Hx,Mx (66),(v)
+8d: vpermb/w Vx,Hx,Wx (66),(ev)
+8e: vpmaskmovd/q Mx,Vx,Hx (66),(v)
+# 0x0f 0x38 0x90-0xbf (FMA)
+90: vgatherdd/q Vx,Hx,Wx (66),(v) | vpgatherdd/q Vx,Wx (66),(evo)
+91: vgatherqd/q Vx,Hx,Wx (66),(v) | vpgatherqd/q Vx,Wx (66),(evo)
+92: vgatherdps/d Vx,Hx,Wx (66),(v)
+93: vgatherqps/d Vx,Hx,Wx (66),(v)
+94:
+95:
+96: vfmaddsub132ps/d Vx,Hx,Wx (66),(v)
+97: vfmsubadd132ps/d Vx,Hx,Wx (66),(v)
+98: vfmadd132ps/d Vx,Hx,Wx (66),(v)
+99: vfmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
+9a: vfmsub132ps/d Vx,Hx,Wx (66),(v)
+9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
+9c: vfnmadd132ps/d Vx,Hx,Wx (66),(v)
+9d: vfnmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
+9e: vfnmsub132ps/d Vx,Hx,Wx (66),(v)
+9f: vfnmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
+a0: vpscatterdd/q Wx,Vx (66),(ev)
+a1: vpscatterqd/q Wx,Vx (66),(ev)
+a2: vscatterdps/d Wx,Vx (66),(ev)
+a3: vscatterqps/d Wx,Vx (66),(ev)
+a6: vfmaddsub213ps/d Vx,Hx,Wx (66),(v)
+a7: vfmsubadd213ps/d Vx,Hx,Wx (66),(v)
+a8: vfmadd213ps/d Vx,Hx,Wx (66),(v)
+a9: vfmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
+aa: vfmsub213ps/d Vx,Hx,Wx (66),(v)
+ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
+ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
+ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
+ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
+af: vfnmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
+b4: vpmadd52luq Vx,Hx,Wx (66),(ev)
+b5: vpmadd52huq Vx,Hx,Wx (66),(ev)
+b6: vfmaddsub231ps/d Vx,Hx,Wx (66),(v)
+b7: vfmsubadd231ps/d Vx,Hx,Wx (66),(v)
+b8: vfmadd231ps/d Vx,Hx,Wx (66),(v)
+b9: vfmadd231ss/d Vx,Hx,Wx (66),(v),(v1)
+ba: vfmsub231ps/d Vx,Hx,Wx (66),(v)
+bb: vfmsub231ss/d Vx,Hx,Wx (66),(v),(v1)
+bc: vfnmadd231ps/d Vx,Hx,Wx (66),(v)
+bd: vfnmadd231ss/d Vx,Hx,Wx (66),(v),(v1)
+be: vfnmsub231ps/d Vx,Hx,Wx (66),(v)
+bf: vfnmsub231ss/d Vx,Hx,Wx (66),(v),(v1)
+# 0x0f 0x38 0xc0-0xff
+c4: vpconflictd/q Vx,Wx (66),(ev)
+c6: Grp18 (1A)
+c7: Grp19 (1A)
+c8: sha1nexte Vdq,Wdq | vexp2ps/d Vx,Wx (66),(ev)
+c9: sha1msg1 Vdq,Wdq
+ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
+cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
+cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
+cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
+db: VAESIMC Vdq,Wdq (66),(v1)
+dc: VAESENC Vdq,Hdq,Wdq (66),(v1)
+dd: VAESENCLAST Vdq,Hdq,Wdq (66),(v1)
+de: VAESDEC Vdq,Hdq,Wdq (66),(v1)
+df: VAESDECLAST Vdq,Hdq,Wdq (66),(v1)
+f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
+f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
+f2: ANDN Gy,By,Ey (v)
+f3: Grp17 (1A)
+f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
+f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
+f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
+EndTable
+
+Table: 3-byte opcode 2 (0x0f 0x3a)
+Referrer: 3-byte escape 2
+AVXcode: 3
+# 0x0f 0x3a 0x00-0xff
+00: vpermq Vqq,Wqq,Ib (66),(v)
+01: vpermpd Vqq,Wqq,Ib (66),(v)
+02: vpblendd Vx,Hx,Wx,Ib (66),(v)
+03: valignd/q Vx,Hx,Wx,Ib (66),(ev)
+04: vpermilps Vx,Wx,Ib (66),(v)
+05: vpermilpd Vx,Wx,Ib (66),(v)
+06: vperm2f128 Vqq,Hqq,Wqq,Ib (66),(v)
+07:
+08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo)
+09: vroundpd Vx,Wx,Ib (66) | vrndscalepd Vx,Wx,Ib (66),(evo)
+0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo)
+0b: vroundsd Vsd,Wsd,Ib (66),(v1) | vrndscalesd Vx,Hx,Wx,Ib (66),(evo)
+0c: vblendps Vx,Hx,Wx,Ib (66)
+0d: vblendpd Vx,Hx,Wx,Ib (66)
+0e: vpblendw Vx,Hx,Wx,Ib (66),(v1)
+0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1)
+14: vpextrb Rd/Mb,Vdq,Ib (66),(v1)
+15: vpextrw Rd/Mw,Vdq,Ib (66),(v1)
+16: vpextrd/q Ey,Vdq,Ib (66),(v1)
+17: vextractps Ed,Vdq,Ib (66),(v1)
+18: vinsertf128 Vqq,Hqq,Wqq,Ib (66),(v) | vinsertf32x4/64x2 Vqq,Hqq,Wqq,Ib (66),(evo)
+19: vextractf128 Wdq,Vqq,Ib (66),(v) | vextractf32x4/64x2 Wdq,Vqq,Ib (66),(evo)
+1a: vinsertf32x8/64x4 Vqq,Hqq,Wqq,Ib (66),(ev)
+1b: vextractf32x8/64x4 Wdq,Vqq,Ib (66),(ev)
+1d: vcvtps2ph Wx,Vx,Ib (66),(v)
+1e: vpcmpud/q Vk,Hd,Wd,Ib (66),(ev)
+1f: vpcmpd/q Vk,Hd,Wd,Ib (66),(ev)
+20: vpinsrb Vdq,Hdq,Ry/Mb,Ib (66),(v1)
+21: vinsertps Vdq,Hdq,Udq/Md,Ib (66),(v1)
+22: vpinsrd/q Vdq,Hdq,Ey,Ib (66),(v1)
+23: vshuff32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
+25: vpternlogd/q Vx,Hx,Wx,Ib (66),(ev)
+26: vgetmantps/d Vx,Wx,Ib (66),(ev)
+27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev)
+30: kshiftrb/w Vk,Uk,Ib (66),(v)
+31: kshiftrd/q Vk,Uk,Ib (66),(v)
+32: kshiftlb/w Vk,Uk,Ib (66),(v)
+33: kshiftld/q Vk,Uk,Ib (66),(v)
+38: vinserti128 Vqq,Hqq,Wqq,Ib (66),(v) | vinserti32x4/64x2 Vqq,Hqq,Wqq,Ib (66),(evo)
+39: vextracti128 Wdq,Vqq,Ib (66),(v) | vextracti32x4/64x2 Wdq,Vqq,Ib (66),(evo)
+3a: vinserti32x8/64x4 Vqq,Hqq,Wqq,Ib (66),(ev)
+3b: vextracti32x8/64x4 Wdq,Vqq,Ib (66),(ev)
+3e: vpcmpub/w Vk,Hk,Wx,Ib (66),(ev)
+3f: vpcmpb/w Vk,Hk,Wx,Ib (66),(ev)
+40: vdpps Vx,Hx,Wx,Ib (66)
+41: vdppd Vdq,Hdq,Wdq,Ib (66),(v1)
+42: vmpsadbw Vx,Hx,Wx,Ib (66),(v1) | vdbpsadbw Vx,Hx,Wx,Ib (66),(evo)
+43: vshufi32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
+44: vpclmulqdq Vdq,Hdq,Wdq,Ib (66),(v1)
+46: vperm2i128 Vqq,Hqq,Wqq,Ib (66),(v)
+4a: vblendvps Vx,Hx,Wx,Lx (66),(v)
+4b: vblendvpd Vx,Hx,Wx,Lx (66),(v)
+4c: vpblendvb Vx,Hx,Wx,Lx (66),(v1)
+50: vrangeps/d Vx,Hx,Wx,Ib (66),(ev)
+51: vrangess/d Vx,Hx,Wx,Ib (66),(ev)
+54: vfixupimmps/d Vx,Hx,Wx,Ib (66),(ev)
+55: vfixupimmss/d Vx,Hx,Wx,Ib (66),(ev)
+56: vreduceps/d Vx,Wx,Ib (66),(ev)
+57: vreducess/d Vx,Hx,Wx,Ib (66),(ev)
+60: vpcmpestrm Vdq,Wdq,Ib (66),(v1)
+61: vpcmpestri Vdq,Wdq,Ib (66),(v1)
+62: vpcmpistrm Vdq,Wdq,Ib (66),(v1)
+63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
+66: vfpclassps/d Vk,Wx,Ib (66),(ev)
+67: vfpclassss/d Vk,Wx,Ib (66),(ev)
+cc: sha1rnds4 Vdq,Wdq,Ib
+df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
+f0: RORX Gy,Ey,Ib (F2),(v)
+EndTable
+
+GrpTable: Grp1
+0: ADD
+1: OR
+2: ADC
+3: SBB
+4: AND
+5: SUB
+6: XOR
+7: CMP
+EndTable
+
+GrpTable: Grp1A
+0: POP
+EndTable
+
+GrpTable: Grp2
+0: ROL
+1: ROR
+2: RCL
+3: RCR
+4: SHL/SAL
+5: SHR
+6:
+7: SAR
+EndTable
+
+GrpTable: Grp3_1
+0: TEST Eb,Ib
+1: TEST Eb,Ib
+2: NOT Eb
+3: NEG Eb
+4: MUL AL,Eb
+5: IMUL AL,Eb
+6: DIV AL,Eb
+7: IDIV AL,Eb
+EndTable
+
+GrpTable: Grp3_2
+0: TEST Ev,Iz
+1:
+2: NOT Ev
+3: NEG Ev
+4: MUL rAX,Ev
+5: IMUL rAX,Ev
+6: DIV rAX,Ev
+7: IDIV rAX,Ev
+EndTable
+
+GrpTable: Grp4
+0: INC Eb
+1: DEC Eb
+EndTable
+
+GrpTable: Grp5
+0: INC Ev
+1: DEC Ev
+# Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
+2: CALLN Ev (f64)
+3: CALLF Ep
+4: JMPN Ev (f64)
+5: JMPF Mp
+6: PUSH Ev (d64)
+7:
+EndTable
+
+GrpTable: Grp6
+0: SLDT Rv/Mw
+1: STR Rv/Mw
+2: LLDT Ew
+3: LTR Ew
+4: VERR Ew
+5: VERW Ew
+EndTable
+
+GrpTable: Grp7
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
+2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
+3: LIDT Ms
+4: SMSW Mw/Rv
+5: rdpkru (110),(11B) | wrpkru (111),(11B)
+6: LMSW Ew
+7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
+EndTable
+
+GrpTable: Grp8
+4: BT
+5: BTS
+6: BTR
+7: BTC
+EndTable
+
+GrpTable: Grp9
+1: CMPXCHG8B/16B Mq/Mdq
+3: xrstors
+4: xsavec
+5: xsaves
+6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B)
+7: VMPTRST Mq | VMPTRST Mq (F3) | RDSEED Rv (11B)
+EndTable
+
+GrpTable: Grp10
+# all are UD1
+0: UD1
+1: UD1
+2: UD1
+3: UD1
+4: UD1
+5: UD1
+6: UD1
+7: UD1
+EndTable
+
+# Grp11A and Grp11B are expressed as Grp11 in Intel SDM
+GrpTable: Grp11A
+0: MOV Eb,Ib
+7: XABORT Ib (000),(11B)
+EndTable
+
+GrpTable: Grp11B
+0: MOV Eb,Iz
+7: XBEGIN Jz (000),(11B)
+EndTable
+
+GrpTable: Grp12
+2: psrlw Nq,Ib (11B) | vpsrlw Hx,Ux,Ib (66),(11B),(v1)
+4: psraw Nq,Ib (11B) | vpsraw Hx,Ux,Ib (66),(11B),(v1)
+6: psllw Nq,Ib (11B) | vpsllw Hx,Ux,Ib (66),(11B),(v1)
+EndTable
+
+GrpTable: Grp13
+0: vprord/q Hx,Wx,Ib (66),(ev)
+1: vprold/q Hx,Wx,Ib (66),(ev)
+2: psrld Nq,Ib (11B) | vpsrld Hx,Ux,Ib (66),(11B),(v1)
+4: psrad Nq,Ib (11B) | vpsrad Hx,Ux,Ib (66),(11B),(v1) | vpsrad/q Hx,Ux,Ib (66),(evo)
+6: pslld Nq,Ib (11B) | vpslld Hx,Ux,Ib (66),(11B),(v1)
+EndTable
+
+GrpTable: Grp14
+2: psrlq Nq,Ib (11B) | vpsrlq Hx,Ux,Ib (66),(11B),(v1)
+3: vpsrldq Hx,Ux,Ib (66),(11B),(v1)
+6: psllq Nq,Ib (11B) | vpsllq Hx,Ux,Ib (66),(11B),(v1)
+7: vpslldq Hx,Ux,Ib (66),(11B),(v1)
+EndTable
+
+GrpTable: Grp15
+0: fxsave | RDFSBASE Ry (F3),(11B)
+1: fxstor | RDGSBASE Ry (F3),(11B)
+2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
+3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+4: XSAVE | ptwrite Ey (F3),(11B)
+5: XRSTOR | lfence (11B)
+6: XSAVEOPT | clwb (66) | mfence (11B)
+7: clflush | clflushopt (66) | sfence (11B)
+EndTable
+
+GrpTable: Grp16
+0: prefetch NTA
+1: prefetch T0
+2: prefetch T1
+3: prefetch T2
+EndTable
+
+GrpTable: Grp17
+1: BLSR By,Ey (v)
+2: BLSMSK By,Ey (v)
+3: BLSI By,Ey (v)
+EndTable
+
+GrpTable: Grp18
+1: vgatherpf0dps/d Wx (66),(ev)
+2: vgatherpf1dps/d Wx (66),(ev)
+5: vscatterpf0dps/d Wx (66),(ev)
+6: vscatterpf1dps/d Wx (66),(ev)
+EndTable
+
+GrpTable: Grp19
+1: vgatherpf0qps/d Wx (66),(ev)
+2: vgatherpf1qps/d Wx (66),(ev)
+5: vscatterpf0qps/d Wx (66),(ev)
+6: vscatterpf1qps/d Wx (66),(ev)
+EndTable
+
+# AMD's Prefetch Group
+GrpTable: GrpP
+0: PREFETCH
+1: PREFETCHW
+EndTable
+
+GrpTable: GrpPDLK
+0: MONTMUL
+1: XSHA1
+2: XSHA2
+EndTable
+
+GrpTable: GrpRNG
+0: xstore-rng
+1: xcrypt-ecb
+2: xcrypt-cbc
+4: xcrypt-cfb
+5: xcrypt-ofb
+EndTable
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
new file mode 100644
index 0000000..b02a36b
--- /dev/null
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -0,0 +1,393 @@
+#!/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+# gen-insn-attr-x86.awk: Instruction attribute table generator
+# Written by Masami Hiramatsu <mhiramat@redhat.com>
+#
+# Usage: awk -f gen-insn-attr-x86.awk x86-opcode-map.txt > inat-tables.c
+
+# Awk implementation sanity check
+function check_awk_implement() {
+	if (sprintf("%x", 0) != "0")
+		return "Your awk has a printf-format problem."
+	return ""
+}
+
+# Clear working vars
+function clear_vars() {
+	delete table
+	delete lptable2
+	delete lptable1
+	delete lptable3
+	eid = -1 # escape id
+	gid = -1 # group id
+	aid = -1 # AVX id
+	tname = ""
+}
+
+BEGIN {
+	# Implementation error checking
+	awkchecked = check_awk_implement()
+	if (awkchecked != "") {
+		print "Error: " awkchecked > "/dev/stderr"
+		print "Please try to use gawk." > "/dev/stderr"
+		exit 1
+	}
+
+	# Setup generating tables
+	print "/* x86 opcode map generated from x86-opcode-map.txt */"
+	print "/* Do not change this code. */\n"
+	ggid = 1
+	geid = 1
+	gaid = 0
+	delete etable
+	delete gtable
+	delete atable
+
+	opnd_expr = "^[A-Za-z/]"
+	ext_expr = "^\\("
+	sep_expr = "^\\|$"
+	group_expr = "^Grp[0-9A-Za-z]+"
+
+	imm_expr = "^[IJAOL][a-z]"
+	imm_flag["Ib"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Jb"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+	imm_flag["Iw"] = "INAT_MAKE_IMM(INAT_IMM_WORD)"
+	imm_flag["Id"] = "INAT_MAKE_IMM(INAT_IMM_DWORD)"
+	imm_flag["Iq"] = "INAT_MAKE_IMM(INAT_IMM_QWORD)"
+	imm_flag["Ap"] = "INAT_MAKE_IMM(INAT_IMM_PTR)"
+	imm_flag["Iz"] = "INAT_MAKE_IMM(INAT_IMM_VWORD32)"
+	imm_flag["Jz"] = "INAT_MAKE_IMM(INAT_IMM_VWORD32)"
+	imm_flag["Iv"] = "INAT_MAKE_IMM(INAT_IMM_VWORD)"
+	imm_flag["Ob"] = "INAT_MOFFSET"
+	imm_flag["Ov"] = "INAT_MOFFSET"
+	imm_flag["Lx"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
+
+	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
+	force64_expr = "\\([df]64\\)"
+	rex_expr = "^REX(\\.[XRWB]+)*"
+	fpu_expr = "^ESC" # TODO
+
+	lprefix1_expr = "\\((66|!F3)\\)"
+	lprefix2_expr = "\\(F3\\)"
+	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix_expr = "\\((66|F2|F3)\\)"
+	max_lprefix = 4
+
+	# All opcodes starting with lower-case 'v', 'k' or with (v1) superscript
+	# accepts VEX prefix
+	vexok_opcode_expr = "^[vk].*"
+	vexok_expr = "\\(v1\\)"
+	# All opcodes with (v) superscript supports *only* VEX prefix
+	vexonly_expr = "\\(v\\)"
+	# All opcodes with (ev) superscript supports *only* EVEX prefix
+	evexonly_expr = "\\(ev\\)"
+
+	prefix_expr = "\\(Prefix\\)"
+	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
+	prefix_num["REPNE"] = "INAT_PFX_REPNE"
+	prefix_num["REP/REPE"] = "INAT_PFX_REPE"
+	prefix_num["XACQUIRE"] = "INAT_PFX_REPNE"
+	prefix_num["XRELEASE"] = "INAT_PFX_REPE"
+	prefix_num["LOCK"] = "INAT_PFX_LOCK"
+	prefix_num["SEG=CS"] = "INAT_PFX_CS"
+	prefix_num["SEG=DS"] = "INAT_PFX_DS"
+	prefix_num["SEG=ES"] = "INAT_PFX_ES"
+	prefix_num["SEG=FS"] = "INAT_PFX_FS"
+	prefix_num["SEG=GS"] = "INAT_PFX_GS"
+	prefix_num["SEG=SS"] = "INAT_PFX_SS"
+	prefix_num["Address-Size"] = "INAT_PFX_ADDRSZ"
+	prefix_num["VEX+1byte"] = "INAT_PFX_VEX2"
+	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
+	prefix_num["EVEX"] = "INAT_PFX_EVEX"
+
+	clear_vars()
+}
+
+function semantic_error(msg) {
+	print "Semantic error at " NR ": " msg > "/dev/stderr"
+	exit 1
+}
+
+function debug(msg) {
+	print "DEBUG: " msg
+}
+
+function array_size(arr,   i,c) {
+	c = 0
+	for (i in arr)
+		c++
+	return c
+}
+
+/^Table:/ {
+	print "/* " $0 " */"
+	if (tname != "")
+		semantic_error("Hit Table: before EndTable:.");
+}
+
+/^Referrer:/ {
+	if (NF != 1) {
+		# escape opcode table
+		ref = ""
+		for (i = 2; i <= NF; i++)
+			ref = ref $i
+		eid = escape[ref]
+		tname = sprintf("inat_escape_table_%d", eid)
+	}
+}
+
+/^AVXcode:/ {
+	if (NF != 1) {
+		# AVX/escape opcode table
+		aid = $2
+		if (gaid <= aid)
+			gaid = aid + 1
+		if (tname == "")	# AVX only opcode table
+			tname = sprintf("inat_avx_table_%d", $2)
+	}
+	if (aid == -1 && eid == -1)	# primary opcode table
+		tname = "inat_primary_table"
+}
+
+/^GrpTable:/ {
+	print "/* " $0 " */"
+	if (!($2 in group))
+		semantic_error("No group: " $2 )
+	gid = group[$2]
+	tname = "inat_group_table_" gid
+}
+
+function print_table(tbl,name,fmt,n)
+{
+	print "const insn_attr_t " name " = {"
+	for (i = 0; i < n; i++) {
+		id = sprintf(fmt, i)
+		if (tbl[id])
+			print "	[" id "] = " tbl[id] ","
+	}
+	print "};"
+}
+
+/^EndTable/ {
+	if (gid != -1) {
+		# print group tables
+		if (array_size(table) != 0) {
+			print_table(table, tname "[INAT_GROUP_TABLE_SIZE]",
+				    "0x%x", 8)
+			gtable[gid,0] = tname
+		}
+		if (array_size(lptable1) != 0) {
+			print_table(lptable1, tname "_1[INAT_GROUP_TABLE_SIZE]",
+				    "0x%x", 8)
+			gtable[gid,1] = tname "_1"
+		}
+		if (array_size(lptable2) != 0) {
+			print_table(lptable2, tname "_2[INAT_GROUP_TABLE_SIZE]",
+				    "0x%x", 8)
+			gtable[gid,2] = tname "_2"
+		}
+		if (array_size(lptable3) != 0) {
+			print_table(lptable3, tname "_3[INAT_GROUP_TABLE_SIZE]",
+				    "0x%x", 8)
+			gtable[gid,3] = tname "_3"
+		}
+	} else {
+		# print primary/escaped tables
+		if (array_size(table) != 0) {
+			print_table(table, tname "[INAT_OPCODE_TABLE_SIZE]",
+				    "0x%02x", 256)
+			etable[eid,0] = tname
+			if (aid >= 0)
+				atable[aid,0] = tname
+		}
+		if (array_size(lptable1) != 0) {
+			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
+				    "0x%02x", 256)
+			etable[eid,1] = tname "_1"
+			if (aid >= 0)
+				atable[aid,1] = tname "_1"
+		}
+		if (array_size(lptable2) != 0) {
+			print_table(lptable2,tname "_2[INAT_OPCODE_TABLE_SIZE]",
+				    "0x%02x", 256)
+			etable[eid,2] = tname "_2"
+			if (aid >= 0)
+				atable[aid,2] = tname "_2"
+		}
+		if (array_size(lptable3) != 0) {
+			print_table(lptable3,tname "_3[INAT_OPCODE_TABLE_SIZE]",
+				    "0x%02x", 256)
+			etable[eid,3] = tname "_3"
+			if (aid >= 0)
+				atable[aid,3] = tname "_3"
+		}
+	}
+	print ""
+	clear_vars()
+}
+
+function add_flags(old,new) {
+	if (old && new)
+		return old " | " new
+	else if (old)
+		return old
+	else
+		return new
+}
+
+# convert operands to flags.
+function convert_operands(count,opnd,       i,j,imm,mod)
+{
+	imm = null
+	mod = null
+	for (j = 1; j <= count; j++) {
+		i = opnd[j]
+		if (match(i, imm_expr) == 1) {
+			if (!imm_flag[i])
+				semantic_error("Unknown imm opnd: " i)
+			if (imm) {
+				if (i != "Ib")
+					semantic_error("Second IMM error")
+				imm = add_flags(imm, "INAT_SCNDIMM")
+			} else
+				imm = imm_flag[i]
+		} else if (match(i, modrm_expr))
+			mod = "INAT_MODRM"
+	}
+	return add_flags(imm, mod)
+}
+
+/^[0-9a-f]+\:/ {
+	if (NR == 1)
+		next
+	# get index
+	idx = "0x" substr($1, 1, index($1,":") - 1)
+	if (idx in table)
+		semantic_error("Redefine " idx " in " tname)
+
+	# check if escaped opcode
+	if ("escape" == $2) {
+		if ($3 != "#")
+			semantic_error("No escaped name")
+		ref = ""
+		for (i = 4; i <= NF; i++)
+			ref = ref $i
+		if (ref in escape)
+			semantic_error("Redefine escape (" ref ")")
+		escape[ref] = geid
+		geid++
+		table[idx] = "INAT_MAKE_ESCAPE(" escape[ref] ")"
+		next
+	}
+
+	variant = null
+	# converts
+	i = 2
+	while (i <= NF) {
+		opcode = $(i++)
+		delete opnds
+		ext = null
+		flags = null
+		opnd = null
+		# parse one opcode
+		if (match($i, opnd_expr)) {
+			opnd = $i
+			count = split($(i++), opnds, ",")
+			flags = convert_operands(count, opnds)
+		}
+		if (match($i, ext_expr))
+			ext = $(i++)
+		if (match($i, sep_expr))
+			i++
+		else if (i < NF)
+			semantic_error($i " is not a separator")
+
+		# check if group opcode
+		if (match(opcode, group_expr)) {
+			if (!(opcode in group)) {
+				group[opcode] = ggid
+				ggid++
+			}
+			flags = add_flags(flags, "INAT_MAKE_GROUP(" group[opcode] ")")
+		}
+		# check force(or default) 64bit
+		if (match(ext, force64_expr))
+			flags = add_flags(flags, "INAT_FORCE64")
+
+		# check REX prefix
+		if (match(opcode, rex_expr))
+			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
+
+		# check coprocessor escape : TODO
+		if (match(opcode, fpu_expr))
+			flags = add_flags(flags, "INAT_MODRM")
+
+		# check VEX codes
+		if (match(ext, evexonly_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
+		else if (match(ext, vexonly_expr))
+			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
+		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
+			flags = add_flags(flags, "INAT_VEXOK")
+
+		# check prefixes
+		if (match(ext, prefix_expr)) {
+			if (!prefix_num[opcode])
+				semantic_error("Unknown prefix: " opcode)
+			flags = add_flags(flags, "INAT_MAKE_PREFIX(" prefix_num[opcode] ")")
+		}
+		if (length(flags) == 0)
+			continue
+		# check if last prefix
+		if (match(ext, lprefix1_expr)) {
+			lptable1[idx] = add_flags(lptable1[idx],flags)
+			variant = "INAT_VARIANT"
+		}
+		if (match(ext, lprefix2_expr)) {
+			lptable2[idx] = add_flags(lptable2[idx],flags)
+			variant = "INAT_VARIANT"
+		}
+		if (match(ext, lprefix3_expr)) {
+			lptable3[idx] = add_flags(lptable3[idx],flags)
+			variant = "INAT_VARIANT"
+		}
+		if (!match(ext, lprefix_expr)){
+			table[idx] = add_flags(table[idx],flags)
+		}
+	}
+	if (variant)
+		table[idx] = add_flags(table[idx],variant)
+}
+
+END {
+	if (awkchecked != "")
+		exit 1
+	# print escape opcode map's array
+	print "/* Escape opcode map array */"
+	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
+	      "[INAT_LSTPFX_MAX + 1] = {"
+	for (i = 0; i < geid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (etable[i,j])
+				print "	["i"]["j"] = "etable[i,j]","
+	print "};\n"
+	# print group opcode map's array
+	print "/* Group opcode map array */"
+	print "const insn_attr_t * const inat_group_tables[INAT_GRP_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1] = {"
+	for (i = 0; i < ggid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (gtable[i,j])
+				print "	["i"]["j"] = "gtable[i,j]","
+	print "};\n"
+	# print AVX opcode map's array
+	print "/* AVX opcode map array */"
+	print "const insn_attr_t * const inat_avx_tables[X86_VEX_M_MAX + 1]"\
+	      "[INAT_LSTPFX_MAX + 1] = {"
+	for (i = 0; i < gaid; i++)
+		for (j = 0; j < max_lprefix; j++)
+			if (atable[i,j])
+				print "	["i"]["j"] = "atable[i,j]","
+	print "};"
+}
+
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8815823..8c9b9ad 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -33,7 +33,7 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
+	    -I$(srctree)/tools/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
@@ -60,7 +60,7 @@ $(LIBSUBCMD): fixdep FORCE
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/inat-tables.c $(OUTPUT)fixdep
 
 FORCE:
 
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index b998412..7c50040 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,7 +1,7 @@
 objtool-y += decode.o
 
-inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
-inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
+inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
+inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
 
 $(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 	$(call rule_mkdir)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0567c47..a62e032 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -8,8 +8,8 @@
 
 #define unlikely(cond) (cond)
 #include <asm/insn.h>
-#include "lib/inat.c"
-#include "lib/insn.c"
+#include "../../../arch/x86/lib/inat.c"
+#include "../../../arch/x86/lib/insn.c"
 
 #include "../../elf.h"
 #include "../../arch.h"
diff --git a/tools/objtool/arch/x86/include/asm/inat.h b/tools/objtool/arch/x86/include/asm/inat.h
deleted file mode 100644
index 4cf2ad5..0000000
--- a/tools/objtool/arch/x86/include/asm/inat.h
+++ /dev/null
@@ -1,230 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_X86_INAT_H
-#define _ASM_X86_INAT_H
-/*
- * x86 instruction attributes
- *
- * Written by Masami Hiramatsu <mhiramat@redhat.com>
- */
-#include <asm/inat_types.h>
-
-/*
- * Internal bits. Don't use bitmasks directly, because these bits are
- * unstable. You should use checking functions.
- */
-
-#define INAT_OPCODE_TABLE_SIZE 256
-#define INAT_GROUP_TABLE_SIZE 8
-
-/* Legacy last prefixes */
-#define INAT_PFX_OPNDSZ	1	/* 0x66 */ /* LPFX1 */
-#define INAT_PFX_REPE	2	/* 0xF3 */ /* LPFX2 */
-#define INAT_PFX_REPNE	3	/* 0xF2 */ /* LPFX3 */
-/* Other Legacy prefixes */
-#define INAT_PFX_LOCK	4	/* 0xF0 */
-#define INAT_PFX_CS	5	/* 0x2E */
-#define INAT_PFX_DS	6	/* 0x3E */
-#define INAT_PFX_ES	7	/* 0x26 */
-#define INAT_PFX_FS	8	/* 0x64 */
-#define INAT_PFX_GS	9	/* 0x65 */
-#define INAT_PFX_SS	10	/* 0x36 */
-#define INAT_PFX_ADDRSZ	11	/* 0x67 */
-/* x86-64 REX prefix */
-#define INAT_PFX_REX	12	/* 0x4X */
-/* AVX VEX prefixes */
-#define INAT_PFX_VEX2	13	/* 2-bytes VEX prefix */
-#define INAT_PFX_VEX3	14	/* 3-bytes VEX prefix */
-#define INAT_PFX_EVEX	15	/* EVEX prefix */
-
-#define INAT_LSTPFX_MAX	3
-#define INAT_LGCPFX_MAX	11
-
-/* Immediate size */
-#define INAT_IMM_BYTE		1
-#define INAT_IMM_WORD		2
-#define INAT_IMM_DWORD		3
-#define INAT_IMM_QWORD		4
-#define INAT_IMM_PTR		5
-#define INAT_IMM_VWORD32	6
-#define INAT_IMM_VWORD		7
-
-/* Legacy prefix */
-#define INAT_PFX_OFFS	0
-#define INAT_PFX_BITS	4
-#define INAT_PFX_MAX    ((1 << INAT_PFX_BITS) - 1)
-#define INAT_PFX_MASK	(INAT_PFX_MAX << INAT_PFX_OFFS)
-/* Escape opcodes */
-#define INAT_ESC_OFFS	(INAT_PFX_OFFS + INAT_PFX_BITS)
-#define INAT_ESC_BITS	2
-#define INAT_ESC_MAX	((1 << INAT_ESC_BITS) - 1)
-#define INAT_ESC_MASK	(INAT_ESC_MAX << INAT_ESC_OFFS)
-/* Group opcodes (1-16) */
-#define INAT_GRP_OFFS	(INAT_ESC_OFFS + INAT_ESC_BITS)
-#define INAT_GRP_BITS	5
-#define INAT_GRP_MAX	((1 << INAT_GRP_BITS) - 1)
-#define INAT_GRP_MASK	(INAT_GRP_MAX << INAT_GRP_OFFS)
-/* Immediates */
-#define INAT_IMM_OFFS	(INAT_GRP_OFFS + INAT_GRP_BITS)
-#define INAT_IMM_BITS	3
-#define INAT_IMM_MASK	(((1 << INAT_IMM_BITS) - 1) << INAT_IMM_OFFS)
-/* Flags */
-#define INAT_FLAG_OFFS	(INAT_IMM_OFFS + INAT_IMM_BITS)
-#define INAT_MODRM	(1 << (INAT_FLAG_OFFS))
-#define INAT_FORCE64	(1 << (INAT_FLAG_OFFS + 1))
-#define INAT_SCNDIMM	(1 << (INAT_FLAG_OFFS + 2))
-#define INAT_MOFFSET	(1 << (INAT_FLAG_OFFS + 3))
-#define INAT_VARIANT	(1 << (INAT_FLAG_OFFS + 4))
-#define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
-#define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
-#define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
-/* Attribute making macros for attribute tables */
-#define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
-#define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
-#define INAT_MAKE_GROUP(grp)	((grp << INAT_GRP_OFFS) | INAT_MODRM)
-#define INAT_MAKE_IMM(imm)	(imm << INAT_IMM_OFFS)
-
-/* Identifiers for segment registers */
-#define INAT_SEG_REG_IGNORE	0
-#define INAT_SEG_REG_DEFAULT	1
-#define INAT_SEG_REG_CS		2
-#define INAT_SEG_REG_SS		3
-#define INAT_SEG_REG_DS		4
-#define INAT_SEG_REG_ES		5
-#define INAT_SEG_REG_FS		6
-#define INAT_SEG_REG_GS		7
-
-/* Attribute search APIs */
-extern insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode);
-extern int inat_get_last_prefix_id(insn_byte_t last_pfx);
-extern insn_attr_t inat_get_escape_attribute(insn_byte_t opcode,
-					     int lpfx_id,
-					     insn_attr_t esc_attr);
-extern insn_attr_t inat_get_group_attribute(insn_byte_t modrm,
-					    int lpfx_id,
-					    insn_attr_t esc_attr);
-extern insn_attr_t inat_get_avx_attribute(insn_byte_t opcode,
-					  insn_byte_t vex_m,
-					  insn_byte_t vex_pp);
-
-/* Attribute checking functions */
-static inline int inat_is_legacy_prefix(insn_attr_t attr)
-{
-	attr &= INAT_PFX_MASK;
-	return attr && attr <= INAT_LGCPFX_MAX;
-}
-
-static inline int inat_is_address_size_prefix(insn_attr_t attr)
-{
-	return (attr & INAT_PFX_MASK) == INAT_PFX_ADDRSZ;
-}
-
-static inline int inat_is_operand_size_prefix(insn_attr_t attr)
-{
-	return (attr & INAT_PFX_MASK) == INAT_PFX_OPNDSZ;
-}
-
-static inline int inat_is_rex_prefix(insn_attr_t attr)
-{
-	return (attr & INAT_PFX_MASK) == INAT_PFX_REX;
-}
-
-static inline int inat_last_prefix_id(insn_attr_t attr)
-{
-	if ((attr & INAT_PFX_MASK) > INAT_LSTPFX_MAX)
-		return 0;
-	else
-		return attr & INAT_PFX_MASK;
-}
-
-static inline int inat_is_vex_prefix(insn_attr_t attr)
-{
-	attr &= INAT_PFX_MASK;
-	return attr == INAT_PFX_VEX2 || attr == INAT_PFX_VEX3 ||
-	       attr == INAT_PFX_EVEX;
-}
-
-static inline int inat_is_evex_prefix(insn_attr_t attr)
-{
-	return (attr & INAT_PFX_MASK) == INAT_PFX_EVEX;
-}
-
-static inline int inat_is_vex3_prefix(insn_attr_t attr)
-{
-	return (attr & INAT_PFX_MASK) == INAT_PFX_VEX3;
-}
-
-static inline int inat_is_escape(insn_attr_t attr)
-{
-	return attr & INAT_ESC_MASK;
-}
-
-static inline int inat_escape_id(insn_attr_t attr)
-{
-	return (attr & INAT_ESC_MASK) >> INAT_ESC_OFFS;
-}
-
-static inline int inat_is_group(insn_attr_t attr)
-{
-	return attr & INAT_GRP_MASK;
-}
-
-static inline int inat_group_id(insn_attr_t attr)
-{
-	return (attr & INAT_GRP_MASK) >> INAT_GRP_OFFS;
-}
-
-static inline int inat_group_common_attribute(insn_attr_t attr)
-{
-	return attr & ~INAT_GRP_MASK;
-}
-
-static inline int inat_has_immediate(insn_attr_t attr)
-{
-	return attr & INAT_IMM_MASK;
-}
-
-static inline int inat_immediate_size(insn_attr_t attr)
-{
-	return (attr & INAT_IMM_MASK) >> INAT_IMM_OFFS;
-}
-
-static inline int inat_has_modrm(insn_attr_t attr)
-{
-	return attr & INAT_MODRM;
-}
-
-static inline int inat_is_force64(insn_attr_t attr)
-{
-	return attr & INAT_FORCE64;
-}
-
-static inline int inat_has_second_immediate(insn_attr_t attr)
-{
-	return attr & INAT_SCNDIMM;
-}
-
-static inline int inat_has_moffset(insn_attr_t attr)
-{
-	return attr & INAT_MOFFSET;
-}
-
-static inline int inat_has_variant(insn_attr_t attr)
-{
-	return attr & INAT_VARIANT;
-}
-
-static inline int inat_accept_vex(insn_attr_t attr)
-{
-	return attr & INAT_VEXOK;
-}
-
-static inline int inat_must_vex(insn_attr_t attr)
-{
-	return attr & (INAT_VEXONLY | INAT_EVEXONLY);
-}
-
-static inline int inat_must_evex(insn_attr_t attr)
-{
-	return attr & INAT_EVEXONLY;
-}
-#endif
diff --git a/tools/objtool/arch/x86/include/asm/inat_types.h b/tools/objtool/arch/x86/include/asm/inat_types.h
deleted file mode 100644
index b047efa..0000000
--- a/tools/objtool/arch/x86/include/asm/inat_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_X86_INAT_TYPES_H
-#define _ASM_X86_INAT_TYPES_H
-/*
- * x86 instruction attributes
- *
- * Written by Masami Hiramatsu <mhiramat@redhat.com>
- */
-
-/* Instruction attributes */
-typedef unsigned int insn_attr_t;
-typedef unsigned char insn_byte_t;
-typedef signed int insn_value_t;
-
-#endif
diff --git a/tools/objtool/arch/x86/include/asm/insn.h b/tools/objtool/arch/x86/include/asm/insn.h
deleted file mode 100644
index 154f27b..0000000
--- a/tools/objtool/arch/x86/include/asm/insn.h
+++ /dev/null
@@ -1,216 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_X86_INSN_H
-#define _ASM_X86_INSN_H
-/*
- * x86 instruction analysis
- *
- * Copyright (C) IBM Corporation, 2009
- */
-
-/* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
-
-struct insn_field {
-	union {
-		insn_value_t value;
-		insn_byte_t bytes[4];
-	};
-	/* !0 if we've run insn_get_xxx() for this field */
-	unsigned char got;
-	unsigned char nbytes;
-};
-
-struct insn {
-	struct insn_field prefixes;	/*
-					 * Prefixes
-					 * prefixes.bytes[3]: last prefix
-					 */
-	struct insn_field rex_prefix;	/* REX prefix */
-	struct insn_field vex_prefix;	/* VEX prefix */
-	struct insn_field opcode;	/*
-					 * opcode.bytes[0]: opcode1
-					 * opcode.bytes[1]: opcode2
-					 * opcode.bytes[2]: opcode3
-					 */
-	struct insn_field modrm;
-	struct insn_field sib;
-	struct insn_field displacement;
-	union {
-		struct insn_field immediate;
-		struct insn_field moffset1;	/* for 64bit MOV */
-		struct insn_field immediate1;	/* for 64bit imm or off16/32 */
-	};
-	union {
-		struct insn_field moffset2;	/* for 64bit MOV */
-		struct insn_field immediate2;	/* for 64bit imm or seg16 */
-	};
-
-	insn_attr_t attr;
-	unsigned char opnd_bytes;
-	unsigned char addr_bytes;
-	unsigned char length;
-	unsigned char x86_64;
-
-	const insn_byte_t *kaddr;	/* kernel address of insn to analyze */
-	const insn_byte_t *end_kaddr;	/* kernel address of last insn in buffer */
-	const insn_byte_t *next_byte;
-};
-
-#define MAX_INSN_SIZE	15
-
-#define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
-#define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
-#define X86_MODRM_RM(modrm) ((modrm) & 0x07)
-
-#define X86_SIB_SCALE(sib) (((sib) & 0xc0) >> 6)
-#define X86_SIB_INDEX(sib) (((sib) & 0x38) >> 3)
-#define X86_SIB_BASE(sib) ((sib) & 0x07)
-
-#define X86_REX_W(rex) ((rex) & 8)
-#define X86_REX_R(rex) ((rex) & 4)
-#define X86_REX_X(rex) ((rex) & 2)
-#define X86_REX_B(rex) ((rex) & 1)
-
-/* VEX bit flags  */
-#define X86_VEX_W(vex)	((vex) & 0x80)	/* VEX3 Byte2 */
-#define X86_VEX_R(vex)	((vex) & 0x80)	/* VEX2/3 Byte1 */
-#define X86_VEX_X(vex)	((vex) & 0x40)	/* VEX3 Byte1 */
-#define X86_VEX_B(vex)	((vex) & 0x20)	/* VEX3 Byte1 */
-#define X86_VEX_L(vex)	((vex) & 0x04)	/* VEX3 Byte2, VEX2 Byte1 */
-/* VEX bit fields */
-#define X86_EVEX_M(vex)	((vex) & 0x03)		/* EVEX Byte1 */
-#define X86_VEX3_M(vex)	((vex) & 0x1f)		/* VEX3 Byte1 */
-#define X86_VEX2_M	1			/* VEX2.M always 1 */
-#define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
-#define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
-#define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
-
-extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
-extern void insn_get_prefixes(struct insn *insn);
-extern void insn_get_opcode(struct insn *insn);
-extern void insn_get_modrm(struct insn *insn);
-extern void insn_get_sib(struct insn *insn);
-extern void insn_get_displacement(struct insn *insn);
-extern void insn_get_immediate(struct insn *insn);
-extern void insn_get_length(struct insn *insn);
-
-/* Attribute will be determined after getting ModRM (for opcode groups) */
-static inline void insn_get_attribute(struct insn *insn)
-{
-	insn_get_modrm(insn);
-}
-
-/* Instruction uses RIP-relative addressing */
-extern int insn_rip_relative(struct insn *insn);
-
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
-static inline int insn_is_avx(struct insn *insn)
-{
-	if (!insn->prefixes.got)
-		insn_get_prefixes(insn);
-	return (insn->vex_prefix.value != 0);
-}
-
-static inline int insn_is_evex(struct insn *insn)
-{
-	if (!insn->prefixes.got)
-		insn_get_prefixes(insn);
-	return (insn->vex_prefix.nbytes == 4);
-}
-
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
-static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
-{
-	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
-		return X86_VEX2_M;
-	else if (insn->vex_prefix.nbytes == 3)	/* 3 bytes VEX */
-		return X86_VEX3_M(insn->vex_prefix.bytes[1]);
-	else					/* EVEX */
-		return X86_EVEX_M(insn->vex_prefix.bytes[1]);
-}
-
-static inline insn_byte_t insn_vex_p_bits(struct insn *insn)
-{
-	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
-		return X86_VEX_P(insn->vex_prefix.bytes[1]);
-	else
-		return X86_VEX_P(insn->vex_prefix.bytes[2]);
-}
-
-/* Get the last prefix id from last prefix or VEX prefix */
-static inline int insn_last_prefix_id(struct insn *insn)
-{
-	if (insn_is_avx(insn))
-		return insn_vex_p_bits(insn);	/* VEX_p is a SIMD prefix id */
-
-	if (insn->prefixes.bytes[3])
-		return inat_get_last_prefix_id(insn->prefixes.bytes[3]);
-
-	return 0;
-}
-
-/* Offset of each field from kaddr */
-static inline int insn_offset_rex_prefix(struct insn *insn)
-{
-	return insn->prefixes.nbytes;
-}
-static inline int insn_offset_vex_prefix(struct insn *insn)
-{
-	return insn_offset_rex_prefix(insn) + insn->rex_prefix.nbytes;
-}
-static inline int insn_offset_opcode(struct insn *insn)
-{
-	return insn_offset_vex_prefix(insn) + insn->vex_prefix.nbytes;
-}
-static inline int insn_offset_modrm(struct insn *insn)
-{
-	return insn_offset_opcode(insn) + insn->opcode.nbytes;
-}
-static inline int insn_offset_sib(struct insn *insn)
-{
-	return insn_offset_modrm(insn) + insn->modrm.nbytes;
-}
-static inline int insn_offset_displacement(struct insn *insn)
-{
-	return insn_offset_sib(insn) + insn->sib.nbytes;
-}
-static inline int insn_offset_immediate(struct insn *insn)
-{
-	return insn_offset_displacement(insn) + insn->displacement.nbytes;
-}
-
-#define POP_SS_OPCODE 0x1f
-#define MOV_SREG_OPCODE 0x8e
-
-/*
- * Intel SDM Vol.3A 6.8.3 states;
- * "Any single-step trap that would be delivered following the MOV to SS
- * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
- * suppressed."
- * This function returns true if @insn is MOV SS or POP SS. On these
- * instructions, single stepping is suppressed.
- */
-static inline int insn_masking_exception(struct insn *insn)
-{
-	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
-		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
-		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
-}
-
-#endif /* _ASM_X86_INSN_H */
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/tools/objtool/arch/x86/include/asm/orc_types.h
deleted file mode 100644
index 6e06090..0000000
--- a/tools/objtool/arch/x86/include/asm/orc_types.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _ORC_TYPES_H
-#define _ORC_TYPES_H
-
-#include <linux/types.h>
-#include <linux/compiler.h>
-
-/*
- * The ORC_REG_* registers are base registers which are used to find other
- * registers on the stack.
- *
- * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
- * address of the previous frame: the caller's SP before it called the current
- * function.
- *
- * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
- * the current frame.
- *
- * The most commonly used base registers are SP and BP -- which the previous SP
- * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
- * usually based on.
- *
- * The rest of the base registers are needed for special cases like entry code
- * and GCC realigned stacks.
- */
-#define ORC_REG_UNDEFINED		0
-#define ORC_REG_PREV_SP			1
-#define ORC_REG_DX			2
-#define ORC_REG_DI			3
-#define ORC_REG_BP			4
-#define ORC_REG_SP			5
-#define ORC_REG_R10			6
-#define ORC_REG_R13			7
-#define ORC_REG_BP_INDIRECT		8
-#define ORC_REG_SP_INDIRECT		9
-#define ORC_REG_MAX			15
-
-/*
- * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
- * caller's SP right before it made the call).  Used for all callable
- * functions, i.e. all C code and all callable asm functions.
- *
- * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
- * to a fully populated pt_regs from a syscall, interrupt, or exception.
- *
- * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
- * points to the iret return frame.
- *
- * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
- * aren't used in struct orc_entry due to size and complexity constraints.
- * Objtool converts them to real types when it converts the hints to orc
- * entries.
- */
-#define ORC_TYPE_CALL			0
-#define ORC_TYPE_REGS			1
-#define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_SAVE		3
-#define UNWIND_HINT_TYPE_RESTORE	4
-
-#ifndef __ASSEMBLY__
-/*
- * This struct is more or less a vastly simplified version of the DWARF Call
- * Frame Information standard.  It contains only the necessary parts of DWARF
- * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
- * unwinder how to find the previous SP and BP (and sometimes entry regs) on
- * the stack for a given code address.  Each instance of the struct corresponds
- * to one or more code locations.
- */
-struct orc_entry {
-	s16		sp_offset;
-	s16		bp_offset;
-	unsigned	sp_reg:4;
-	unsigned	bp_reg:4;
-	unsigned	type:2;
-	unsigned	end:1;
-} __packed;
-
-/*
- * This struct is used by asm and inline asm code to manually annotate the
- * location of registers on the stack for the ORC unwinder.
- *
- * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
- */
-struct unwind_hint {
-	u32		ip;
-	s16		sp_offset;
-	u8		sp_reg;
-	u8		type;
-	u8		end;
-};
-#endif /* __ASSEMBLY__ */
-
-#endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/arch/x86/lib/inat.c b/tools/objtool/arch/x86/lib/inat.c
deleted file mode 100644
index 12539fc..0000000
--- a/tools/objtool/arch/x86/lib/inat.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * x86 instruction attribute tables
- *
- * Written by Masami Hiramatsu <mhiramat@redhat.com>
- */
-#include <asm/insn.h>
-
-/* Attribute tables are generated from opcode map */
-#include "inat-tables.c"
-
-/* Attribute search APIs */
-insn_attr_t inat_get_opcode_attribute(insn_byte_t opcode)
-{
-	return inat_primary_table[opcode];
-}
-
-int inat_get_last_prefix_id(insn_byte_t last_pfx)
-{
-	insn_attr_t lpfx_attr;
-
-	lpfx_attr = inat_get_opcode_attribute(last_pfx);
-	return inat_last_prefix_id(lpfx_attr);
-}
-
-insn_attr_t inat_get_escape_attribute(insn_byte_t opcode, int lpfx_id,
-				      insn_attr_t esc_attr)
-{
-	const insn_attr_t *table;
-	int n;
-
-	n = inat_escape_id(esc_attr);
-
-	table = inat_escape_tables[n][0];
-	if (!table)
-		return 0;
-	if (inat_has_variant(table[opcode]) && lpfx_id) {
-		table = inat_escape_tables[n][lpfx_id];
-		if (!table)
-			return 0;
-	}
-	return table[opcode];
-}
-
-insn_attr_t inat_get_group_attribute(insn_byte_t modrm, int lpfx_id,
-				     insn_attr_t grp_attr)
-{
-	const insn_attr_t *table;
-	int n;
-
-	n = inat_group_id(grp_attr);
-
-	table = inat_group_tables[n][0];
-	if (!table)
-		return inat_group_common_attribute(grp_attr);
-	if (inat_has_variant(table[X86_MODRM_REG(modrm)]) && lpfx_id) {
-		table = inat_group_tables[n][lpfx_id];
-		if (!table)
-			return inat_group_common_attribute(grp_attr);
-	}
-	return table[X86_MODRM_REG(modrm)] |
-	       inat_group_common_attribute(grp_attr);
-}
-
-insn_attr_t inat_get_avx_attribute(insn_byte_t opcode, insn_byte_t vex_m,
-				   insn_byte_t vex_p)
-{
-	const insn_attr_t *table;
-	if (vex_m > X86_VEX_M_MAX || vex_p > INAT_LSTPFX_MAX)
-		return 0;
-	/* At first, this checks the master table */
-	table = inat_avx_tables[vex_m][0];
-	if (!table)
-		return 0;
-	if (!inat_is_group(table[opcode]) && vex_p) {
-		/* If this is not a group, get attribute directly */
-		table = inat_avx_tables[vex_m][vex_p];
-		if (!table)
-			return 0;
-	}
-	return table[opcode];
-}
-
diff --git a/tools/objtool/arch/x86/lib/insn.c b/tools/objtool/arch/x86/lib/insn.c
deleted file mode 100644
index 0b5862b..0000000
--- a/tools/objtool/arch/x86/lib/insn.c
+++ /dev/null
@@ -1,593 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * x86 instruction analysis
- *
- * Copyright (C) IBM Corporation, 2002, 2004, 2009
- */
-
-#ifdef __KERNEL__
-#include <linux/string.h>
-#else
-#include <string.h>
-#endif
-#include <asm/inat.h>
-#include <asm/insn.h>
-
-/* Verify next sizeof(t) bytes can be on the same instruction */
-#define validate_next(t, insn, n)	\
-	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
-
-#define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
-
-#define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
-
-#define get_next(t, insn)	\
-	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
-
-#define peek_nbyte_next(t, insn, n)	\
-	({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
-
-#define peek_next(t, insn)	peek_nbyte_next(t, insn, 0)
-
-/**
- * insn_init() - initialize struct insn
- * @insn:	&struct insn to be initialized
- * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
- * @x86_64:	!0 for 64-bit kernel or 64-bit app
- */
-void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
-{
-	/*
-	 * Instructions longer than MAX_INSN_SIZE (15 bytes) are invalid
-	 * even if the input buffer is long enough to hold them.
-	 */
-	if (buf_len > MAX_INSN_SIZE)
-		buf_len = MAX_INSN_SIZE;
-
-	memset(insn, 0, sizeof(*insn));
-	insn->kaddr = kaddr;
-	insn->end_kaddr = kaddr + buf_len;
-	insn->next_byte = kaddr;
-	insn->x86_64 = x86_64 ? 1 : 0;
-	insn->opnd_bytes = 4;
-	if (x86_64)
-		insn->addr_bytes = 8;
-	else
-		insn->addr_bytes = 4;
-}
-
-/**
- * insn_get_prefixes - scan x86 instruction prefix bytes
- * @insn:	&struct insn containing instruction
- *
- * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
- * to point to the (first) opcode.  No effect if @insn->prefixes.got
- * is already set.
- */
-void insn_get_prefixes(struct insn *insn)
-{
-	struct insn_field *prefixes = &insn->prefixes;
-	insn_attr_t attr;
-	insn_byte_t b, lb;
-	int i, nb;
-
-	if (prefixes->got)
-		return;
-
-	nb = 0;
-	lb = 0;
-	b = peek_next(insn_byte_t, insn);
-	attr = inat_get_opcode_attribute(b);
-	while (inat_is_legacy_prefix(attr)) {
-		/* Skip if same prefix */
-		for (i = 0; i < nb; i++)
-			if (prefixes->bytes[i] == b)
-				goto found;
-		if (nb == 4)
-			/* Invalid instruction */
-			break;
-		prefixes->bytes[nb++] = b;
-		if (inat_is_address_size_prefix(attr)) {
-			/* address size switches 2/4 or 4/8 */
-			if (insn->x86_64)
-				insn->addr_bytes ^= 12;
-			else
-				insn->addr_bytes ^= 6;
-		} else if (inat_is_operand_size_prefix(attr)) {
-			/* oprand size switches 2/4 */
-			insn->opnd_bytes ^= 6;
-		}
-found:
-		prefixes->nbytes++;
-		insn->next_byte++;
-		lb = b;
-		b = peek_next(insn_byte_t, insn);
-		attr = inat_get_opcode_attribute(b);
-	}
-	/* Set the last prefix */
-	if (lb && lb != insn->prefixes.bytes[3]) {
-		if (unlikely(insn->prefixes.bytes[3])) {
-			/* Swap the last prefix */
-			b = insn->prefixes.bytes[3];
-			for (i = 0; i < nb; i++)
-				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
-		}
-		insn->prefixes.bytes[3] = lb;
-	}
-
-	/* Decode REX prefix */
-	if (insn->x86_64) {
-		b = peek_next(insn_byte_t, insn);
-		attr = inat_get_opcode_attribute(b);
-		if (inat_is_rex_prefix(attr)) {
-			insn->rex_prefix.value = b;
-			insn->rex_prefix.nbytes = 1;
-			insn->next_byte++;
-			if (X86_REX_W(b))
-				/* REX.W overrides opnd_size */
-				insn->opnd_bytes = 8;
-		}
-	}
-	insn->rex_prefix.got = 1;
-
-	/* Decode VEX prefix */
-	b = peek_next(insn_byte_t, insn);
-	attr = inat_get_opcode_attribute(b);
-	if (inat_is_vex_prefix(attr)) {
-		insn_byte_t b2 = peek_nbyte_next(insn_byte_t, insn, 1);
-		if (!insn->x86_64) {
-			/*
-			 * In 32-bits mode, if the [7:6] bits (mod bits of
-			 * ModRM) on the second byte are not 11b, it is
-			 * LDS or LES or BOUND.
-			 */
-			if (X86_MODRM_MOD(b2) != 3)
-				goto vex_end;
-		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
-		if (inat_is_evex_prefix(attr)) {
-			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
-			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
-			insn->vex_prefix.nbytes = 4;
-			insn->next_byte += 4;
-			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
-				insn->opnd_bytes = 8;
-		} else if (inat_is_vex3_prefix(attr)) {
-			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
-			insn->vex_prefix.nbytes = 3;
-			insn->next_byte += 3;
-			if (insn->x86_64 && X86_VEX_W(b2))
-				/* VEX.W overrides opnd_size */
-				insn->opnd_bytes = 8;
-		} else {
-			/*
-			 * For VEX2, fake VEX3-like byte#2.
-			 * Makes it easier to decode vex.W, vex.vvvv,
-			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
-			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
-			insn->vex_prefix.nbytes = 2;
-			insn->next_byte += 2;
-		}
-	}
-vex_end:
-	insn->vex_prefix.got = 1;
-
-	prefixes->got = 1;
-
-err_out:
-	return;
-}
-
-/**
- * insn_get_opcode - collect opcode(s)
- * @insn:	&struct insn containing instruction
- *
- * Populates @insn->opcode, updates @insn->next_byte to point past the
- * opcode byte(s), and set @insn->attr (except for groups).
- * If necessary, first collects any preceding (prefix) bytes.
- * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
- * is already 1.
- */
-void insn_get_opcode(struct insn *insn)
-{
-	struct insn_field *opcode = &insn->opcode;
-	insn_byte_t op;
-	int pfx_id;
-	if (opcode->got)
-		return;
-	if (!insn->prefixes.got)
-		insn_get_prefixes(insn);
-
-	/* Get first opcode */
-	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
-	opcode->nbytes = 1;
-
-	/* Check if there is VEX prefix or not */
-	if (insn_is_avx(insn)) {
-		insn_byte_t m, p;
-		m = insn_vex_m_bits(insn);
-		p = insn_vex_p_bits(insn);
-		insn->attr = inat_get_avx_attribute(op, m, p);
-		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
-		    (!inat_accept_vex(insn->attr) &&
-		     !inat_is_group(insn->attr)))
-			insn->attr = 0;	/* This instruction is bad */
-		goto end;	/* VEX has only 1 byte for opcode */
-	}
-
-	insn->attr = inat_get_opcode_attribute(op);
-	while (inat_is_escape(insn->attr)) {
-		/* Get escaped opcode */
-		op = get_next(insn_byte_t, insn);
-		opcode->bytes[opcode->nbytes++] = op;
-		pfx_id = insn_last_prefix_id(insn);
-		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
-	}
-	if (inat_must_vex(insn->attr))
-		insn->attr = 0;	/* This instruction is bad */
-end:
-	opcode->got = 1;
-
-err_out:
-	return;
-}
-
-/**
- * insn_get_modrm - collect ModRM byte, if any
- * @insn:	&struct insn containing instruction
- *
- * Populates @insn->modrm and updates @insn->next_byte to point past the
- * ModRM byte, if any.  If necessary, first collects the preceding bytes
- * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
- */
-void insn_get_modrm(struct insn *insn)
-{
-	struct insn_field *modrm = &insn->modrm;
-	insn_byte_t pfx_id, mod;
-	if (modrm->got)
-		return;
-	if (!insn->opcode.got)
-		insn_get_opcode(insn);
-
-	if (inat_has_modrm(insn->attr)) {
-		mod = get_next(insn_byte_t, insn);
-		modrm->value = mod;
-		modrm->nbytes = 1;
-		if (inat_is_group(insn->attr)) {
-			pfx_id = insn_last_prefix_id(insn);
-			insn->attr = inat_get_group_attribute(mod, pfx_id,
-							      insn->attr);
-			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
-				insn->attr = 0;	/* This is bad */
-		}
-	}
-
-	if (insn->x86_64 && inat_is_force64(insn->attr))
-		insn->opnd_bytes = 8;
-	modrm->got = 1;
-
-err_out:
-	return;
-}
-
-
-/**
- * insn_rip_relative() - Does instruction use RIP-relative addressing mode?
- * @insn:	&struct insn containing instruction
- *
- * If necessary, first collects the instruction up to and including the
- * ModRM byte.  No effect if @insn->x86_64 is 0.
- */
-int insn_rip_relative(struct insn *insn)
-{
-	struct insn_field *modrm = &insn->modrm;
-
-	if (!insn->x86_64)
-		return 0;
-	if (!modrm->got)
-		insn_get_modrm(insn);
-	/*
-	 * For rip-relative instructions, the mod field (top 2 bits)
-	 * is zero and the r/m field (bottom 3 bits) is 0x5.
-	 */
-	return (modrm->nbytes && (modrm->value & 0xc7) == 0x5);
-}
-
-/**
- * insn_get_sib() - Get the SIB byte of instruction
- * @insn:	&struct insn containing instruction
- *
- * If necessary, first collects the instruction up to and including the
- * ModRM byte.
- */
-void insn_get_sib(struct insn *insn)
-{
-	insn_byte_t modrm;
-
-	if (insn->sib.got)
-		return;
-	if (!insn->modrm.got)
-		insn_get_modrm(insn);
-	if (insn->modrm.nbytes) {
-		modrm = (insn_byte_t)insn->modrm.value;
-		if (insn->addr_bytes != 2 &&
-		    X86_MODRM_MOD(modrm) != 3 && X86_MODRM_RM(modrm) == 4) {
-			insn->sib.value = get_next(insn_byte_t, insn);
-			insn->sib.nbytes = 1;
-		}
-	}
-	insn->sib.got = 1;
-
-err_out:
-	return;
-}
-
-
-/**
- * insn_get_displacement() - Get the displacement of instruction
- * @insn:	&struct insn containing instruction
- *
- * If necessary, first collects the instruction up to and including the
- * SIB byte.
- * Displacement value is sign-expanded.
- */
-void insn_get_displacement(struct insn *insn)
-{
-	insn_byte_t mod, rm, base;
-
-	if (insn->displacement.got)
-		return;
-	if (!insn->sib.got)
-		insn_get_sib(insn);
-	if (insn->modrm.nbytes) {
-		/*
-		 * Interpreting the modrm byte:
-		 * mod = 00 - no displacement fields (exceptions below)
-		 * mod = 01 - 1-byte displacement field
-		 * mod = 10 - displacement field is 4 bytes, or 2 bytes if
-		 * 	address size = 2 (0x67 prefix in 32-bit mode)
-		 * mod = 11 - no memory operand
-		 *
-		 * If address size = 2...
-		 * mod = 00, r/m = 110 - displacement field is 2 bytes
-		 *
-		 * If address size != 2...
-		 * mod != 11, r/m = 100 - SIB byte exists
-		 * mod = 00, SIB base = 101 - displacement field is 4 bytes
-		 * mod = 00, r/m = 101 - rip-relative addressing, displacement
-		 * 	field is 4 bytes
-		 */
-		mod = X86_MODRM_MOD(insn->modrm.value);
-		rm = X86_MODRM_RM(insn->modrm.value);
-		base = X86_SIB_BASE(insn->sib.value);
-		if (mod == 3)
-			goto out;
-		if (mod == 1) {
-			insn->displacement.value = get_next(signed char, insn);
-			insn->displacement.nbytes = 1;
-		} else if (insn->addr_bytes == 2) {
-			if ((mod == 0 && rm == 6) || mod == 2) {
-				insn->displacement.value =
-					 get_next(short, insn);
-				insn->displacement.nbytes = 2;
-			}
-		} else {
-			if ((mod == 0 && rm == 5) || mod == 2 ||
-			    (mod == 0 && base == 5)) {
-				insn->displacement.value = get_next(int, insn);
-				insn->displacement.nbytes = 4;
-			}
-		}
-	}
-out:
-	insn->displacement.got = 1;
-
-err_out:
-	return;
-}
-
-/* Decode moffset16/32/64. Return 0 if failed */
-static int __get_moffset(struct insn *insn)
-{
-	switch (insn->addr_bytes) {
-	case 2:
-		insn->moffset1.value = get_next(short, insn);
-		insn->moffset1.nbytes = 2;
-		break;
-	case 4:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		break;
-	case 8:
-		insn->moffset1.value = get_next(int, insn);
-		insn->moffset1.nbytes = 4;
-		insn->moffset2.value = get_next(int, insn);
-		insn->moffset2.nbytes = 4;
-		break;
-	default:	/* opnd_bytes must be modified manually */
-		goto err_out;
-	}
-	insn->moffset1.got = insn->moffset2.got = 1;
-
-	return 1;
-
-err_out:
-	return 0;
-}
-
-/* Decode imm v32(Iz). Return 0 if failed */
-static int __get_immv32(struct insn *insn)
-{
-	switch (insn->opnd_bytes) {
-	case 2:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
-		break;
-	case 4:
-	case 8:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
-		break;
-	default:	/* opnd_bytes must be modified manually */
-		goto err_out;
-	}
-
-	return 1;
-
-err_out:
-	return 0;
-}
-
-/* Decode imm v64(Iv/Ov), Return 0 if failed */
-static int __get_immv(struct insn *insn)
-{
-	switch (insn->opnd_bytes) {
-	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
-		break;
-	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		break;
-	case 8:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
-		break;
-	default:	/* opnd_bytes must be modified manually */
-		goto err_out;
-	}
-	insn->immediate1.got = insn->immediate2.got = 1;
-
-	return 1;
-err_out:
-	return 0;
-}
-
-/* Decode ptr16:16/32(Ap) */
-static int __get_immptr(struct insn *insn)
-{
-	switch (insn->opnd_bytes) {
-	case 2:
-		insn->immediate1.value = get_next(short, insn);
-		insn->immediate1.nbytes = 2;
-		break;
-	case 4:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		break;
-	case 8:
-		/* ptr16:64 is not exist (no segment) */
-		return 0;
-	default:	/* opnd_bytes must be modified manually */
-		goto err_out;
-	}
-	insn->immediate2.value = get_next(unsigned short, insn);
-	insn->immediate2.nbytes = 2;
-	insn->immediate1.got = insn->immediate2.got = 1;
-
-	return 1;
-err_out:
-	return 0;
-}
-
-/**
- * insn_get_immediate() - Get the immediates of instruction
- * @insn:	&struct insn containing instruction
- *
- * If necessary, first collects the instruction up to and including the
- * displacement bytes.
- * Basically, most of immediates are sign-expanded. Unsigned-value can be
- * get by bit masking with ((1 << (nbytes * 8)) - 1)
- */
-void insn_get_immediate(struct insn *insn)
-{
-	if (insn->immediate.got)
-		return;
-	if (!insn->displacement.got)
-		insn_get_displacement(insn);
-
-	if (inat_has_moffset(insn->attr)) {
-		if (!__get_moffset(insn))
-			goto err_out;
-		goto done;
-	}
-
-	if (!inat_has_immediate(insn->attr))
-		/* no immediates */
-		goto done;
-
-	switch (inat_immediate_size(insn->attr)) {
-	case INAT_IMM_BYTE:
-		insn->immediate.value = get_next(signed char, insn);
-		insn->immediate.nbytes = 1;
-		break;
-	case INAT_IMM_WORD:
-		insn->immediate.value = get_next(short, insn);
-		insn->immediate.nbytes = 2;
-		break;
-	case INAT_IMM_DWORD:
-		insn->immediate.value = get_next(int, insn);
-		insn->immediate.nbytes = 4;
-		break;
-	case INAT_IMM_QWORD:
-		insn->immediate1.value = get_next(int, insn);
-		insn->immediate1.nbytes = 4;
-		insn->immediate2.value = get_next(int, insn);
-		insn->immediate2.nbytes = 4;
-		break;
-	case INAT_IMM_PTR:
-		if (!__get_immptr(insn))
-			goto err_out;
-		break;
-	case INAT_IMM_VWORD32:
-		if (!__get_immv32(insn))
-			goto err_out;
-		break;
-	case INAT_IMM_VWORD:
-		if (!__get_immv(insn))
-			goto err_out;
-		break;
-	default:
-		/* Here, insn must have an immediate, but failed */
-		goto err_out;
-	}
-	if (inat_has_second_immediate(insn->attr)) {
-		insn->immediate2.value = get_next(signed char, insn);
-		insn->immediate2.nbytes = 1;
-	}
-done:
-	insn->immediate.got = 1;
-
-err_out:
-	return;
-}
-
-/**
- * insn_get_length() - Get the length of instruction
- * @insn:	&struct insn containing instruction
- *
- * If necessary, first collects the instruction up to and including the
- * immediates bytes.
- */
-void insn_get_length(struct insn *insn)
-{
-	if (insn->length)
-		return;
-	if (!insn->immediate.got)
-		insn_get_immediate(insn);
-	insn->length = (unsigned char)((unsigned long)insn->next_byte
-				     - (unsigned long)insn->kaddr);
-}
diff --git a/tools/objtool/arch/x86/lib/x86-opcode-map.txt b/tools/objtool/arch/x86/lib/x86-opcode-map.txt
deleted file mode 100644
index e0b8593..0000000
--- a/tools/objtool/arch/x86/lib/x86-opcode-map.txt
+++ /dev/null
@@ -1,1072 +0,0 @@
-# x86 Opcode Maps
-#
-# This is (mostly) based on following documentations.
-# - Intel(R) 64 and IA-32 Architectures Software Developer's Manual Vol.2C
-#   (#326018-047US, June 2013)
-#
-#<Opcode maps>
-# Table: table-name
-# Referrer: escaped-name
-# AVXcode: avx-code
-# opcode: mnemonic|GrpXXX [operand1[,operand2...]] [(extra1)[,(extra2)...] [| 2nd-mnemonic ...]
-# (or)
-# opcode: escape # escaped-name
-# EndTable
-#
-# mnemonics that begin with lowercase 'v' accept a VEX or EVEX prefix
-# mnemonics that begin with lowercase 'k' accept a VEX prefix
-#
-#<group maps>
-# GrpTable: GrpXXX
-# reg:  mnemonic [operand1[,operand2...]] [(extra1)[,(extra2)...] [| 2nd-mnemonic ...]
-# EndTable
-#
-# AVX Superscripts
-#  (ev): this opcode requires EVEX prefix.
-#  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
-#  (v): this opcode requires VEX prefix.
-#  (v1): this opcode only supports 128bit VEX.
-#
-# Last Prefix Superscripts
-#  - (66): the last prefix is 0x66
-#  - (F3): the last prefix is 0xF3
-#  - (F2): the last prefix is 0xF2
-#  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
-#  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
-
-Table: one byte opcode
-Referrer:
-AVXcode:
-# 0x00 - 0x0f
-00: ADD Eb,Gb
-01: ADD Ev,Gv
-02: ADD Gb,Eb
-03: ADD Gv,Ev
-04: ADD AL,Ib
-05: ADD rAX,Iz
-06: PUSH ES (i64)
-07: POP ES (i64)
-08: OR Eb,Gb
-09: OR Ev,Gv
-0a: OR Gb,Eb
-0b: OR Gv,Ev
-0c: OR AL,Ib
-0d: OR rAX,Iz
-0e: PUSH CS (i64)
-0f: escape # 2-byte escape
-# 0x10 - 0x1f
-10: ADC Eb,Gb
-11: ADC Ev,Gv
-12: ADC Gb,Eb
-13: ADC Gv,Ev
-14: ADC AL,Ib
-15: ADC rAX,Iz
-16: PUSH SS (i64)
-17: POP SS (i64)
-18: SBB Eb,Gb
-19: SBB Ev,Gv
-1a: SBB Gb,Eb
-1b: SBB Gv,Ev
-1c: SBB AL,Ib
-1d: SBB rAX,Iz
-1e: PUSH DS (i64)
-1f: POP DS (i64)
-# 0x20 - 0x2f
-20: AND Eb,Gb
-21: AND Ev,Gv
-22: AND Gb,Eb
-23: AND Gv,Ev
-24: AND AL,Ib
-25: AND rAx,Iz
-26: SEG=ES (Prefix)
-27: DAA (i64)
-28: SUB Eb,Gb
-29: SUB Ev,Gv
-2a: SUB Gb,Eb
-2b: SUB Gv,Ev
-2c: SUB AL,Ib
-2d: SUB rAX,Iz
-2e: SEG=CS (Prefix)
-2f: DAS (i64)
-# 0x30 - 0x3f
-30: XOR Eb,Gb
-31: XOR Ev,Gv
-32: XOR Gb,Eb
-33: XOR Gv,Ev
-34: XOR AL,Ib
-35: XOR rAX,Iz
-36: SEG=SS (Prefix)
-37: AAA (i64)
-38: CMP Eb,Gb
-39: CMP Ev,Gv
-3a: CMP Gb,Eb
-3b: CMP Gv,Ev
-3c: CMP AL,Ib
-3d: CMP rAX,Iz
-3e: SEG=DS (Prefix)
-3f: AAS (i64)
-# 0x40 - 0x4f
-40: INC eAX (i64) | REX (o64)
-41: INC eCX (i64) | REX.B (o64)
-42: INC eDX (i64) | REX.X (o64)
-43: INC eBX (i64) | REX.XB (o64)
-44: INC eSP (i64) | REX.R (o64)
-45: INC eBP (i64) | REX.RB (o64)
-46: INC eSI (i64) | REX.RX (o64)
-47: INC eDI (i64) | REX.RXB (o64)
-48: DEC eAX (i64) | REX.W (o64)
-49: DEC eCX (i64) | REX.WB (o64)
-4a: DEC eDX (i64) | REX.WX (o64)
-4b: DEC eBX (i64) | REX.WXB (o64)
-4c: DEC eSP (i64) | REX.WR (o64)
-4d: DEC eBP (i64) | REX.WRB (o64)
-4e: DEC eSI (i64) | REX.WRX (o64)
-4f: DEC eDI (i64) | REX.WRXB (o64)
-# 0x50 - 0x5f
-50: PUSH rAX/r8 (d64)
-51: PUSH rCX/r9 (d64)
-52: PUSH rDX/r10 (d64)
-53: PUSH rBX/r11 (d64)
-54: PUSH rSP/r12 (d64)
-55: PUSH rBP/r13 (d64)
-56: PUSH rSI/r14 (d64)
-57: PUSH rDI/r15 (d64)
-58: POP rAX/r8 (d64)
-59: POP rCX/r9 (d64)
-5a: POP rDX/r10 (d64)
-5b: POP rBX/r11 (d64)
-5c: POP rSP/r12 (d64)
-5d: POP rBP/r13 (d64)
-5e: POP rSI/r14 (d64)
-5f: POP rDI/r15 (d64)
-# 0x60 - 0x6f
-60: PUSHA/PUSHAD (i64)
-61: POPA/POPAD (i64)
-62: BOUND Gv,Ma (i64) | EVEX (Prefix)
-63: ARPL Ew,Gw (i64) | MOVSXD Gv,Ev (o64)
-64: SEG=FS (Prefix)
-65: SEG=GS (Prefix)
-66: Operand-Size (Prefix)
-67: Address-Size (Prefix)
-68: PUSH Iz (d64)
-69: IMUL Gv,Ev,Iz
-6a: PUSH Ib (d64)
-6b: IMUL Gv,Ev,Ib
-6c: INS/INSB Yb,DX
-6d: INS/INSW/INSD Yz,DX
-6e: OUTS/OUTSB DX,Xb
-6f: OUTS/OUTSW/OUTSD DX,Xz
-# 0x70 - 0x7f
-70: JO Jb
-71: JNO Jb
-72: JB/JNAE/JC Jb
-73: JNB/JAE/JNC Jb
-74: JZ/JE Jb
-75: JNZ/JNE Jb
-76: JBE/JNA Jb
-77: JNBE/JA Jb
-78: JS Jb
-79: JNS Jb
-7a: JP/JPE Jb
-7b: JNP/JPO Jb
-7c: JL/JNGE Jb
-7d: JNL/JGE Jb
-7e: JLE/JNG Jb
-7f: JNLE/JG Jb
-# 0x80 - 0x8f
-80: Grp1 Eb,Ib (1A)
-81: Grp1 Ev,Iz (1A)
-82: Grp1 Eb,Ib (1A),(i64)
-83: Grp1 Ev,Ib (1A)
-84: TEST Eb,Gb
-85: TEST Ev,Gv
-86: XCHG Eb,Gb
-87: XCHG Ev,Gv
-88: MOV Eb,Gb
-89: MOV Ev,Gv
-8a: MOV Gb,Eb
-8b: MOV Gv,Ev
-8c: MOV Ev,Sw
-8d: LEA Gv,M
-8e: MOV Sw,Ew
-8f: Grp1A (1A) | POP Ev (d64)
-# 0x90 - 0x9f
-90: NOP | PAUSE (F3) | XCHG r8,rAX
-91: XCHG rCX/r9,rAX
-92: XCHG rDX/r10,rAX
-93: XCHG rBX/r11,rAX
-94: XCHG rSP/r12,rAX
-95: XCHG rBP/r13,rAX
-96: XCHG rSI/r14,rAX
-97: XCHG rDI/r15,rAX
-98: CBW/CWDE/CDQE
-99: CWD/CDQ/CQO
-9a: CALLF Ap (i64)
-9b: FWAIT/WAIT
-9c: PUSHF/D/Q Fv (d64)
-9d: POPF/D/Q Fv (d64)
-9e: SAHF
-9f: LAHF
-# 0xa0 - 0xaf
-a0: MOV AL,Ob
-a1: MOV rAX,Ov
-a2: MOV Ob,AL
-a3: MOV Ov,rAX
-a4: MOVS/B Yb,Xb
-a5: MOVS/W/D/Q Yv,Xv
-a6: CMPS/B Xb,Yb
-a7: CMPS/W/D Xv,Yv
-a8: TEST AL,Ib
-a9: TEST rAX,Iz
-aa: STOS/B Yb,AL
-ab: STOS/W/D/Q Yv,rAX
-ac: LODS/B AL,Xb
-ad: LODS/W/D/Q rAX,Xv
-ae: SCAS/B AL,Yb
-# Note: The May 2011 Intel manual shows Xv for the second parameter of the
-# next instruction but Yv is correct
-af: SCAS/W/D/Q rAX,Yv
-# 0xb0 - 0xbf
-b0: MOV AL/R8L,Ib
-b1: MOV CL/R9L,Ib
-b2: MOV DL/R10L,Ib
-b3: MOV BL/R11L,Ib
-b4: MOV AH/R12L,Ib
-b5: MOV CH/R13L,Ib
-b6: MOV DH/R14L,Ib
-b7: MOV BH/R15L,Ib
-b8: MOV rAX/r8,Iv
-b9: MOV rCX/r9,Iv
-ba: MOV rDX/r10,Iv
-bb: MOV rBX/r11,Iv
-bc: MOV rSP/r12,Iv
-bd: MOV rBP/r13,Iv
-be: MOV rSI/r14,Iv
-bf: MOV rDI/r15,Iv
-# 0xc0 - 0xcf
-c0: Grp2 Eb,Ib (1A)
-c1: Grp2 Ev,Ib (1A)
-c2: RETN Iw (f64)
-c3: RETN
-c4: LES Gz,Mp (i64) | VEX+2byte (Prefix)
-c5: LDS Gz,Mp (i64) | VEX+1byte (Prefix)
-c6: Grp11A Eb,Ib (1A)
-c7: Grp11B Ev,Iz (1A)
-c8: ENTER Iw,Ib
-c9: LEAVE (d64)
-ca: RETF Iw
-cb: RETF
-cc: INT3
-cd: INT Ib
-ce: INTO (i64)
-cf: IRET/D/Q
-# 0xd0 - 0xdf
-d0: Grp2 Eb,1 (1A)
-d1: Grp2 Ev,1 (1A)
-d2: Grp2 Eb,CL (1A)
-d3: Grp2 Ev,CL (1A)
-d4: AAM Ib (i64)
-d5: AAD Ib (i64)
-d6:
-d7: XLAT/XLATB
-d8: ESC
-d9: ESC
-da: ESC
-db: ESC
-dc: ESC
-dd: ESC
-de: ESC
-df: ESC
-# 0xe0 - 0xef
-# Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
-# in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
-# to 16 bits. In 32-bit mode, 0x66 is accepted by both Intel and AMD.
-e0: LOOPNE/LOOPNZ Jb (f64)
-e1: LOOPE/LOOPZ Jb (f64)
-e2: LOOP Jb (f64)
-e3: JrCXZ Jb (f64)
-e4: IN AL,Ib
-e5: IN eAX,Ib
-e6: OUT Ib,AL
-e7: OUT Ib,eAX
-# With 0x66 prefix in 64-bit mode, for AMD CPUs immediate offset
-# in "near" jumps and calls is 16-bit. For CALL,
-# push of return address is 16-bit wide, RSP is decremented by 2
-# but is not truncated to 16 bits, unlike RIP.
-e8: CALL Jz (f64)
-e9: JMP-near Jz (f64)
-ea: JMP-far Ap (i64)
-eb: JMP-short Jb (f64)
-ec: IN AL,DX
-ed: IN eAX,DX
-ee: OUT DX,AL
-ef: OUT DX,eAX
-# 0xf0 - 0xff
-f0: LOCK (Prefix)
-f1:
-f2: REPNE (Prefix) | XACQUIRE (Prefix)
-f3: REP/REPE (Prefix) | XRELEASE (Prefix)
-f4: HLT
-f5: CMC
-f6: Grp3_1 Eb (1A)
-f7: Grp3_2 Ev (1A)
-f8: CLC
-f9: STC
-fa: CLI
-fb: STI
-fc: CLD
-fd: STD
-fe: Grp4 (1A)
-ff: Grp5 (1A)
-EndTable
-
-Table: 2-byte opcode (0x0f)
-Referrer: 2-byte escape
-AVXcode: 1
-# 0x0f 0x00-0x0f
-00: Grp6 (1A)
-01: Grp7 (1A)
-02: LAR Gv,Ew
-03: LSL Gv,Ew
-04:
-05: SYSCALL (o64)
-06: CLTS
-07: SYSRET (o64)
-08: INVD
-09: WBINVD
-0a:
-0b: UD2 (1B)
-0c:
-# AMD's prefetch group. Intel supports prefetchw(/1) only.
-0d: GrpP
-0e: FEMMS
-# 3DNow! uses the last imm byte as opcode extension.
-0f: 3DNow! Pq,Qq,Ib
-# 0x0f 0x10-0x1f
-# NOTE: According to Intel SDM opcode map, vmovups and vmovupd has no operands
-# but it actually has operands. And also, vmovss and vmovsd only accept 128bit.
-# MOVSS/MOVSD has too many forms(3) on SDM. This map just shows a typical form.
-# Many AVX instructions lack v1 superscript, according to Intel AVX-Prgramming
-# Reference A.1
-10: vmovups Vps,Wps | vmovupd Vpd,Wpd (66) | vmovss Vx,Hx,Wss (F3),(v1) | vmovsd Vx,Hx,Wsd (F2),(v1)
-11: vmovups Wps,Vps | vmovupd Wpd,Vpd (66) | vmovss Wss,Hx,Vss (F3),(v1) | vmovsd Wsd,Hx,Vsd (F2),(v1)
-12: vmovlps Vq,Hq,Mq (v1) | vmovhlps Vq,Hq,Uq (v1) | vmovlpd Vq,Hq,Mq (66),(v1) | vmovsldup Vx,Wx (F3) | vmovddup Vx,Wx (F2)
-13: vmovlps Mq,Vq (v1) | vmovlpd Mq,Vq (66),(v1)
-14: vunpcklps Vx,Hx,Wx | vunpcklpd Vx,Hx,Wx (66)
-15: vunpckhps Vx,Hx,Wx | vunpckhpd Vx,Hx,Wx (66)
-16: vmovhps Vdq,Hq,Mq (v1) | vmovlhps Vdq,Hq,Uq (v1) | vmovhpd Vdq,Hq,Mq (66),(v1) | vmovshdup Vx,Wx (F3)
-17: vmovhps Mq,Vq (v1) | vmovhpd Mq,Vq (66),(v1)
-18: Grp16 (1A)
-19:
-# Intel SDM opcode map does not list MPX instructions. For now using Gv for
-# bnd registers and Ev for everything else is OK because the instruction
-# decoder does not use the information except as an indication that there is
-# a ModR/M byte.
-1a: BNDCL Gv,Ev (F3) | BNDCU Gv,Ev (F2) | BNDMOV Gv,Ev (66) | BNDLDX Gv,Ev
-1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
-1c:
-1d:
-1e:
-1f: NOP Ev
-# 0x0f 0x20-0x2f
-20: MOV Rd,Cd
-21: MOV Rd,Dd
-22: MOV Cd,Rd
-23: MOV Dd,Rd
-24:
-25:
-26:
-27:
-28: vmovaps Vps,Wps | vmovapd Vpd,Wpd (66)
-29: vmovaps Wps,Vps | vmovapd Wpd,Vpd (66)
-2a: cvtpi2ps Vps,Qpi | cvtpi2pd Vpd,Qpi (66) | vcvtsi2ss Vss,Hss,Ey (F3),(v1) | vcvtsi2sd Vsd,Hsd,Ey (F2),(v1)
-2b: vmovntps Mps,Vps | vmovntpd Mpd,Vpd (66)
-2c: cvttps2pi Ppi,Wps | cvttpd2pi Ppi,Wpd (66) | vcvttss2si Gy,Wss (F3),(v1) | vcvttsd2si Gy,Wsd (F2),(v1)
-2d: cvtps2pi Ppi,Wps | cvtpd2pi Qpi,Wpd (66) | vcvtss2si Gy,Wss (F3),(v1) | vcvtsd2si Gy,Wsd (F2),(v1)
-2e: vucomiss Vss,Wss (v1) | vucomisd  Vsd,Wsd (66),(v1)
-2f: vcomiss Vss,Wss (v1) | vcomisd  Vsd,Wsd (66),(v1)
-# 0x0f 0x30-0x3f
-30: WRMSR
-31: RDTSC
-32: RDMSR
-33: RDPMC
-34: SYSENTER
-35: SYSEXIT
-36:
-37: GETSEC
-38: escape # 3-byte escape 1
-39:
-3a: escape # 3-byte escape 2
-3b:
-3c:
-3d:
-3e:
-3f:
-# 0x0f 0x40-0x4f
-40: CMOVO Gv,Ev
-41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk | kandb/d Vk,Hk,Uk (66)
-42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk | kandnb/d Vk,Hk,Uk (66)
-43: CMOVAE/NB/NC Gv,Ev
-44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk | knotb/d Vk,Uk (66)
-45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk | korb/d Vk,Hk,Uk (66)
-46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk | kxnorb/d Vk,Hk,Uk (66)
-47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk | kxorb/d Vk,Hk,Uk (66)
-48: CMOVS Gv,Ev
-49: CMOVNS Gv,Ev
-4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk | kaddb/d Vk,Hk,Uk (66)
-4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66) | kunpckwd/dq Vk,Hk,Uk
-4c: CMOVL/NGE Gv,Ev
-4d: CMOVNL/GE Gv,Ev
-4e: CMOVLE/NG Gv,Ev
-4f: CMOVNLE/G Gv,Ev
-# 0x0f 0x50-0x5f
-50: vmovmskps Gy,Ups | vmovmskpd Gy,Upd (66)
-51: vsqrtps Vps,Wps | vsqrtpd Vpd,Wpd (66) | vsqrtss Vss,Hss,Wss (F3),(v1) | vsqrtsd Vsd,Hsd,Wsd (F2),(v1)
-52: vrsqrtps Vps,Wps | vrsqrtss Vss,Hss,Wss (F3),(v1)
-53: vrcpps Vps,Wps | vrcpss Vss,Hss,Wss (F3),(v1)
-54: vandps Vps,Hps,Wps | vandpd Vpd,Hpd,Wpd (66)
-55: vandnps Vps,Hps,Wps | vandnpd Vpd,Hpd,Wpd (66)
-56: vorps Vps,Hps,Wps | vorpd Vpd,Hpd,Wpd (66)
-57: vxorps Vps,Hps,Wps | vxorpd Vpd,Hpd,Wpd (66)
-58: vaddps Vps,Hps,Wps | vaddpd Vpd,Hpd,Wpd (66) | vaddss Vss,Hss,Wss (F3),(v1) | vaddsd Vsd,Hsd,Wsd (F2),(v1)
-59: vmulps Vps,Hps,Wps | vmulpd Vpd,Hpd,Wpd (66) | vmulss Vss,Hss,Wss (F3),(v1) | vmulsd Vsd,Hsd,Wsd (F2),(v1)
-5a: vcvtps2pd Vpd,Wps | vcvtpd2ps Vps,Wpd (66) | vcvtss2sd Vsd,Hx,Wss (F3),(v1) | vcvtsd2ss Vss,Hx,Wsd (F2),(v1)
-5b: vcvtdq2ps Vps,Wdq | vcvtqq2ps Vps,Wqq (evo) | vcvtps2dq Vdq,Wps (66) | vcvttps2dq Vdq,Wps (F3)
-5c: vsubps Vps,Hps,Wps | vsubpd Vpd,Hpd,Wpd (66) | vsubss Vss,Hss,Wss (F3),(v1) | vsubsd Vsd,Hsd,Wsd (F2),(v1)
-5d: vminps Vps,Hps,Wps | vminpd Vpd,Hpd,Wpd (66) | vminss Vss,Hss,Wss (F3),(v1) | vminsd Vsd,Hsd,Wsd (F2),(v1)
-5e: vdivps Vps,Hps,Wps | vdivpd Vpd,Hpd,Wpd (66) | vdivss Vss,Hss,Wss (F3),(v1) | vdivsd Vsd,Hsd,Wsd (F2),(v1)
-5f: vmaxps Vps,Hps,Wps | vmaxpd Vpd,Hpd,Wpd (66) | vmaxss Vss,Hss,Wss (F3),(v1) | vmaxsd Vsd,Hsd,Wsd (F2),(v1)
-# 0x0f 0x60-0x6f
-60: punpcklbw Pq,Qd | vpunpcklbw Vx,Hx,Wx (66),(v1)
-61: punpcklwd Pq,Qd | vpunpcklwd Vx,Hx,Wx (66),(v1)
-62: punpckldq Pq,Qd | vpunpckldq Vx,Hx,Wx (66),(v1)
-63: packsswb Pq,Qq | vpacksswb Vx,Hx,Wx (66),(v1)
-64: pcmpgtb Pq,Qq | vpcmpgtb Vx,Hx,Wx (66),(v1)
-65: pcmpgtw Pq,Qq | vpcmpgtw Vx,Hx,Wx (66),(v1)
-66: pcmpgtd Pq,Qq | vpcmpgtd Vx,Hx,Wx (66),(v1)
-67: packuswb Pq,Qq | vpackuswb Vx,Hx,Wx (66),(v1)
-68: punpckhbw Pq,Qd | vpunpckhbw Vx,Hx,Wx (66),(v1)
-69: punpckhwd Pq,Qd | vpunpckhwd Vx,Hx,Wx (66),(v1)
-6a: punpckhdq Pq,Qd | vpunpckhdq Vx,Hx,Wx (66),(v1)
-6b: packssdw Pq,Qd | vpackssdw Vx,Hx,Wx (66),(v1)
-6c: vpunpcklqdq Vx,Hx,Wx (66),(v1)
-6d: vpunpckhqdq Vx,Hx,Wx (66),(v1)
-6e: movd/q Pd,Ey | vmovd/q Vy,Ey (66),(v1)
-6f: movq Pq,Qq | vmovdqa Vx,Wx (66) | vmovdqa32/64 Vx,Wx (66),(evo) | vmovdqu Vx,Wx (F3) | vmovdqu32/64 Vx,Wx (F3),(evo) | vmovdqu8/16 Vx,Wx (F2),(ev)
-# 0x0f 0x70-0x7f
-70: pshufw Pq,Qq,Ib | vpshufd Vx,Wx,Ib (66),(v1) | vpshufhw Vx,Wx,Ib (F3),(v1) | vpshuflw Vx,Wx,Ib (F2),(v1)
-71: Grp12 (1A)
-72: Grp13 (1A)
-73: Grp14 (1A)
-74: pcmpeqb Pq,Qq | vpcmpeqb Vx,Hx,Wx (66),(v1)
-75: pcmpeqw Pq,Qq | vpcmpeqw Vx,Hx,Wx (66),(v1)
-76: pcmpeqd Pq,Qq | vpcmpeqd Vx,Hx,Wx (66),(v1)
-# Note: Remove (v), because vzeroall and vzeroupper becomes emms without VEX.
-77: emms | vzeroupper | vzeroall
-78: VMREAD Ey,Gy | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
-79: VMWRITE Gy,Ey | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
-7a: vcvtudq2pd/uqq2pd Vpd,Wx (F3),(ev) | vcvtudq2ps/uqq2ps Vpd,Wx (F2),(ev) | vcvttps2qq/pd2qq Vx,Wx (66),(ev)
-7b: vcvtusi2sd Vpd,Hpd,Ev (F2),(ev) | vcvtusi2ss Vps,Hps,Ev (F3),(ev) | vcvtps2qq/pd2qq Vx,Wx (66),(ev)
-7c: vhaddpd Vpd,Hpd,Wpd (66) | vhaddps Vps,Hps,Wps (F2)
-7d: vhsubpd Vpd,Hpd,Wpd (66) | vhsubps Vps,Hps,Wps (F2)
-7e: movd/q Ey,Pd | vmovd/q Ey,Vy (66),(v1) | vmovq Vq,Wq (F3),(v1)
-7f: movq Qq,Pq | vmovdqa Wx,Vx (66) | vmovdqa32/64 Wx,Vx (66),(evo) | vmovdqu Wx,Vx (F3) | vmovdqu32/64 Wx,Vx (F3),(evo) | vmovdqu8/16 Wx,Vx (F2),(ev)
-# 0x0f 0x80-0x8f
-# Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-80: JO Jz (f64)
-81: JNO Jz (f64)
-82: JB/JC/JNAE Jz (f64)
-83: JAE/JNB/JNC Jz (f64)
-84: JE/JZ Jz (f64)
-85: JNE/JNZ Jz (f64)
-86: JBE/JNA Jz (f64)
-87: JA/JNBE Jz (f64)
-88: JS Jz (f64)
-89: JNS Jz (f64)
-8a: JP/JPE Jz (f64)
-8b: JNP/JPO Jz (f64)
-8c: JL/JNGE Jz (f64)
-8d: JNL/JGE Jz (f64)
-8e: JLE/JNG Jz (f64)
-8f: JNLE/JG Jz (f64)
-# 0x0f 0x90-0x9f
-90: SETO Eb | kmovw/q Vk,Wk | kmovb/d Vk,Wk (66)
-91: SETNO Eb | kmovw/q Mv,Vk | kmovb/d Mv,Vk (66)
-92: SETB/C/NAE Eb | kmovw Vk,Rv | kmovb Vk,Rv (66) | kmovq/d Vk,Rv (F2)
-93: SETAE/NB/NC Eb | kmovw Gv,Uk | kmovb Gv,Uk (66) | kmovq/d Gv,Uk (F2)
-94: SETE/Z Eb
-95: SETNE/NZ Eb
-96: SETBE/NA Eb
-97: SETA/NBE Eb
-98: SETS Eb | kortestw/q Vk,Uk | kortestb/d Vk,Uk (66)
-99: SETNS Eb | ktestw/q Vk,Uk | ktestb/d Vk,Uk (66)
-9a: SETP/PE Eb
-9b: SETNP/PO Eb
-9c: SETL/NGE Eb
-9d: SETNL/GE Eb
-9e: SETLE/NG Eb
-9f: SETNLE/G Eb
-# 0x0f 0xa0-0xaf
-a0: PUSH FS (d64)
-a1: POP FS (d64)
-a2: CPUID
-a3: BT Ev,Gv
-a4: SHLD Ev,Gv,Ib
-a5: SHLD Ev,Gv,CL
-a6: GrpPDLK
-a7: GrpRNG
-a8: PUSH GS (d64)
-a9: POP GS (d64)
-aa: RSM
-ab: BTS Ev,Gv
-ac: SHRD Ev,Gv,Ib
-ad: SHRD Ev,Gv,CL
-ae: Grp15 (1A),(1C)
-af: IMUL Gv,Ev
-# 0x0f 0xb0-0xbf
-b0: CMPXCHG Eb,Gb
-b1: CMPXCHG Ev,Gv
-b2: LSS Gv,Mp
-b3: BTR Ev,Gv
-b4: LFS Gv,Mp
-b5: LGS Gv,Mp
-b6: MOVZX Gv,Eb
-b7: MOVZX Gv,Ew
-b8: JMPE (!F3) | POPCNT Gv,Ev (F3)
-b9: Grp10 (1A)
-ba: Grp8 Ev,Ib (1A)
-bb: BTC Ev,Gv
-bc: BSF Gv,Ev (!F3) | TZCNT Gv,Ev (F3)
-bd: BSR Gv,Ev (!F3) | LZCNT Gv,Ev (F3)
-be: MOVSX Gv,Eb
-bf: MOVSX Gv,Ew
-# 0x0f 0xc0-0xcf
-c0: XADD Eb,Gb
-c1: XADD Ev,Gv
-c2: vcmpps Vps,Hps,Wps,Ib | vcmppd Vpd,Hpd,Wpd,Ib (66) | vcmpss Vss,Hss,Wss,Ib (F3),(v1) | vcmpsd Vsd,Hsd,Wsd,Ib (F2),(v1)
-c3: movnti My,Gy
-c4: pinsrw Pq,Ry/Mw,Ib | vpinsrw Vdq,Hdq,Ry/Mw,Ib (66),(v1)
-c5: pextrw Gd,Nq,Ib | vpextrw Gd,Udq,Ib (66),(v1)
-c6: vshufps Vps,Hps,Wps,Ib | vshufpd Vpd,Hpd,Wpd,Ib (66)
-c7: Grp9 (1A)
-c8: BSWAP RAX/EAX/R8/R8D
-c9: BSWAP RCX/ECX/R9/R9D
-ca: BSWAP RDX/EDX/R10/R10D
-cb: BSWAP RBX/EBX/R11/R11D
-cc: BSWAP RSP/ESP/R12/R12D
-cd: BSWAP RBP/EBP/R13/R13D
-ce: BSWAP RSI/ESI/R14/R14D
-cf: BSWAP RDI/EDI/R15/R15D
-# 0x0f 0xd0-0xdf
-d0: vaddsubpd Vpd,Hpd,Wpd (66) | vaddsubps Vps,Hps,Wps (F2)
-d1: psrlw Pq,Qq | vpsrlw Vx,Hx,Wx (66),(v1)
-d2: psrld Pq,Qq | vpsrld Vx,Hx,Wx (66),(v1)
-d3: psrlq Pq,Qq | vpsrlq Vx,Hx,Wx (66),(v1)
-d4: paddq Pq,Qq | vpaddq Vx,Hx,Wx (66),(v1)
-d5: pmullw Pq,Qq | vpmullw Vx,Hx,Wx (66),(v1)
-d6: vmovq Wq,Vq (66),(v1) | movq2dq Vdq,Nq (F3) | movdq2q Pq,Uq (F2)
-d7: pmovmskb Gd,Nq | vpmovmskb Gd,Ux (66),(v1)
-d8: psubusb Pq,Qq | vpsubusb Vx,Hx,Wx (66),(v1)
-d9: psubusw Pq,Qq | vpsubusw Vx,Hx,Wx (66),(v1)
-da: pminub Pq,Qq | vpminub Vx,Hx,Wx (66),(v1)
-db: pand Pq,Qq | vpand Vx,Hx,Wx (66),(v1) | vpandd/q Vx,Hx,Wx (66),(evo)
-dc: paddusb Pq,Qq | vpaddusb Vx,Hx,Wx (66),(v1)
-dd: paddusw Pq,Qq | vpaddusw Vx,Hx,Wx (66),(v1)
-de: pmaxub Pq,Qq | vpmaxub Vx,Hx,Wx (66),(v1)
-df: pandn Pq,Qq | vpandn Vx,Hx,Wx (66),(v1) | vpandnd/q Vx,Hx,Wx (66),(evo)
-# 0x0f 0xe0-0xef
-e0: pavgb Pq,Qq | vpavgb Vx,Hx,Wx (66),(v1)
-e1: psraw Pq,Qq | vpsraw Vx,Hx,Wx (66),(v1)
-e2: psrad Pq,Qq | vpsrad Vx,Hx,Wx (66),(v1)
-e3: pavgw Pq,Qq | vpavgw Vx,Hx,Wx (66),(v1)
-e4: pmulhuw Pq,Qq | vpmulhuw Vx,Hx,Wx (66),(v1)
-e5: pmulhw Pq,Qq | vpmulhw Vx,Hx,Wx (66),(v1)
-e6: vcvttpd2dq Vx,Wpd (66) | vcvtdq2pd Vx,Wdq (F3) | vcvtdq2pd/qq2pd Vx,Wdq (F3),(evo) | vcvtpd2dq Vx,Wpd (F2)
-e7: movntq Mq,Pq | vmovntdq Mx,Vx (66)
-e8: psubsb Pq,Qq | vpsubsb Vx,Hx,Wx (66),(v1)
-e9: psubsw Pq,Qq | vpsubsw Vx,Hx,Wx (66),(v1)
-ea: pminsw Pq,Qq | vpminsw Vx,Hx,Wx (66),(v1)
-eb: por Pq,Qq | vpor Vx,Hx,Wx (66),(v1) | vpord/q Vx,Hx,Wx (66),(evo)
-ec: paddsb Pq,Qq | vpaddsb Vx,Hx,Wx (66),(v1)
-ed: paddsw Pq,Qq | vpaddsw Vx,Hx,Wx (66),(v1)
-ee: pmaxsw Pq,Qq | vpmaxsw Vx,Hx,Wx (66),(v1)
-ef: pxor Pq,Qq | vpxor Vx,Hx,Wx (66),(v1) | vpxord/q Vx,Hx,Wx (66),(evo)
-# 0x0f 0xf0-0xff
-f0: vlddqu Vx,Mx (F2)
-f1: psllw Pq,Qq | vpsllw Vx,Hx,Wx (66),(v1)
-f2: pslld Pq,Qq | vpslld Vx,Hx,Wx (66),(v1)
-f3: psllq Pq,Qq | vpsllq Vx,Hx,Wx (66),(v1)
-f4: pmuludq Pq,Qq | vpmuludq Vx,Hx,Wx (66),(v1)
-f5: pmaddwd Pq,Qq | vpmaddwd Vx,Hx,Wx (66),(v1)
-f6: psadbw Pq,Qq | vpsadbw Vx,Hx,Wx (66),(v1)
-f7: maskmovq Pq,Nq | vmaskmovdqu Vx,Ux (66),(v1)
-f8: psubb Pq,Qq | vpsubb Vx,Hx,Wx (66),(v1)
-f9: psubw Pq,Qq | vpsubw Vx,Hx,Wx (66),(v1)
-fa: psubd Pq,Qq | vpsubd Vx,Hx,Wx (66),(v1)
-fb: psubq Pq,Qq | vpsubq Vx,Hx,Wx (66),(v1)
-fc: paddb Pq,Qq | vpaddb Vx,Hx,Wx (66),(v1)
-fd: paddw Pq,Qq | vpaddw Vx,Hx,Wx (66),(v1)
-fe: paddd Pq,Qq | vpaddd Vx,Hx,Wx (66),(v1)
-ff: UD0
-EndTable
-
-Table: 3-byte opcode 1 (0x0f 0x38)
-Referrer: 3-byte escape 1
-AVXcode: 2
-# 0x0f 0x38 0x00-0x0f
-00: pshufb Pq,Qq | vpshufb Vx,Hx,Wx (66),(v1)
-01: phaddw Pq,Qq | vphaddw Vx,Hx,Wx (66),(v1)
-02: phaddd Pq,Qq | vphaddd Vx,Hx,Wx (66),(v1)
-03: phaddsw Pq,Qq | vphaddsw Vx,Hx,Wx (66),(v1)
-04: pmaddubsw Pq,Qq | vpmaddubsw Vx,Hx,Wx (66),(v1)
-05: phsubw Pq,Qq | vphsubw Vx,Hx,Wx (66),(v1)
-06: phsubd Pq,Qq | vphsubd Vx,Hx,Wx (66),(v1)
-07: phsubsw Pq,Qq | vphsubsw Vx,Hx,Wx (66),(v1)
-08: psignb Pq,Qq | vpsignb Vx,Hx,Wx (66),(v1)
-09: psignw Pq,Qq | vpsignw Vx,Hx,Wx (66),(v1)
-0a: psignd Pq,Qq | vpsignd Vx,Hx,Wx (66),(v1)
-0b: pmulhrsw Pq,Qq | vpmulhrsw Vx,Hx,Wx (66),(v1)
-0c: vpermilps Vx,Hx,Wx (66),(v)
-0d: vpermilpd Vx,Hx,Wx (66),(v)
-0e: vtestps Vx,Wx (66),(v)
-0f: vtestpd Vx,Wx (66),(v)
-# 0x0f 0x38 0x10-0x1f
-10: pblendvb Vdq,Wdq (66) | vpsrlvw Vx,Hx,Wx (66),(evo) | vpmovuswb Wx,Vx (F3),(ev)
-11: vpmovusdb Wx,Vd (F3),(ev) | vpsravw Vx,Hx,Wx (66),(ev)
-12: vpmovusqb Wx,Vq (F3),(ev) | vpsllvw Vx,Hx,Wx (66),(ev)
-13: vcvtph2ps Vx,Wx (66),(v) | vpmovusdw Wx,Vd (F3),(ev)
-14: blendvps Vdq,Wdq (66) | vpmovusqw Wx,Vq (F3),(ev) | vprorvd/q Vx,Hx,Wx (66),(evo)
-15: blendvpd Vdq,Wdq (66) | vpmovusqd Wx,Vq (F3),(ev) | vprolvd/q Vx,Hx,Wx (66),(evo)
-16: vpermps Vqq,Hqq,Wqq (66),(v) | vpermps/d Vqq,Hqq,Wqq (66),(evo)
-17: vptest Vx,Wx (66)
-18: vbroadcastss Vx,Wd (66),(v)
-19: vbroadcastsd Vqq,Wq (66),(v) | vbroadcastf32x2 Vqq,Wq (66),(evo)
-1a: vbroadcastf128 Vqq,Mdq (66),(v) | vbroadcastf32x4/64x2 Vqq,Wq (66),(evo)
-1b: vbroadcastf32x8/64x4 Vqq,Mdq (66),(ev)
-1c: pabsb Pq,Qq | vpabsb Vx,Wx (66),(v1)
-1d: pabsw Pq,Qq | vpabsw Vx,Wx (66),(v1)
-1e: pabsd Pq,Qq | vpabsd Vx,Wx (66),(v1)
-1f: vpabsq Vx,Wx (66),(ev)
-# 0x0f 0x38 0x20-0x2f
-20: vpmovsxbw Vx,Ux/Mq (66),(v1) | vpmovswb Wx,Vx (F3),(ev)
-21: vpmovsxbd Vx,Ux/Md (66),(v1) | vpmovsdb Wx,Vd (F3),(ev)
-22: vpmovsxbq Vx,Ux/Mw (66),(v1) | vpmovsqb Wx,Vq (F3),(ev)
-23: vpmovsxwd Vx,Ux/Mq (66),(v1) | vpmovsdw Wx,Vd (F3),(ev)
-24: vpmovsxwq Vx,Ux/Md (66),(v1) | vpmovsqw Wx,Vq (F3),(ev)
-25: vpmovsxdq Vx,Ux/Mq (66),(v1) | vpmovsqd Wx,Vq (F3),(ev)
-26: vptestmb/w Vk,Hx,Wx (66),(ev) | vptestnmb/w Vk,Hx,Wx (F3),(ev)
-27: vptestmd/q Vk,Hx,Wx (66),(ev) | vptestnmd/q Vk,Hx,Wx (F3),(ev)
-28: vpmuldq Vx,Hx,Wx (66),(v1) | vpmovm2b/w Vx,Uk (F3),(ev)
-29: vpcmpeqq Vx,Hx,Wx (66),(v1) | vpmovb2m/w2m Vk,Ux (F3),(ev)
-2a: vmovntdqa Vx,Mx (66),(v1) | vpbroadcastmb2q Vx,Uk (F3),(ev)
-2b: vpackusdw Vx,Hx,Wx (66),(v1)
-2c: vmaskmovps Vx,Hx,Mx (66),(v) | vscalefps/d Vx,Hx,Wx (66),(evo)
-2d: vmaskmovpd Vx,Hx,Mx (66),(v) | vscalefss/d Vx,Hx,Wx (66),(evo)
-2e: vmaskmovps Mx,Hx,Vx (66),(v)
-2f: vmaskmovpd Mx,Hx,Vx (66),(v)
-# 0x0f 0x38 0x30-0x3f
-30: vpmovzxbw Vx,Ux/Mq (66),(v1) | vpmovwb Wx,Vx (F3),(ev)
-31: vpmovzxbd Vx,Ux/Md (66),(v1) | vpmovdb Wx,Vd (F3),(ev)
-32: vpmovzxbq Vx,Ux/Mw (66),(v1) | vpmovqb Wx,Vq (F3),(ev)
-33: vpmovzxwd Vx,Ux/Mq (66),(v1) | vpmovdw Wx,Vd (F3),(ev)
-34: vpmovzxwq Vx,Ux/Md (66),(v1) | vpmovqw Wx,Vq (F3),(ev)
-35: vpmovzxdq Vx,Ux/Mq (66),(v1) | vpmovqd Wx,Vq (F3),(ev)
-36: vpermd Vqq,Hqq,Wqq (66),(v) | vpermd/q Vqq,Hqq,Wqq (66),(evo)
-37: vpcmpgtq Vx,Hx,Wx (66),(v1)
-38: vpminsb Vx,Hx,Wx (66),(v1) | vpmovm2d/q Vx,Uk (F3),(ev)
-39: vpminsd Vx,Hx,Wx (66),(v1) | vpminsd/q Vx,Hx,Wx (66),(evo) | vpmovd2m/q2m Vk,Ux (F3),(ev)
-3a: vpminuw Vx,Hx,Wx (66),(v1) | vpbroadcastmw2d Vx,Uk (F3),(ev)
-3b: vpminud Vx,Hx,Wx (66),(v1) | vpminud/q Vx,Hx,Wx (66),(evo)
-3c: vpmaxsb Vx,Hx,Wx (66),(v1)
-3d: vpmaxsd Vx,Hx,Wx (66),(v1) | vpmaxsd/q Vx,Hx,Wx (66),(evo)
-3e: vpmaxuw Vx,Hx,Wx (66),(v1)
-3f: vpmaxud Vx,Hx,Wx (66),(v1) | vpmaxud/q Vx,Hx,Wx (66),(evo)
-# 0x0f 0x38 0x40-0x8f
-40: vpmulld Vx,Hx,Wx (66),(v1) | vpmulld/q Vx,Hx,Wx (66),(evo)
-41: vphminposuw Vdq,Wdq (66),(v1)
-42: vgetexpps/d Vx,Wx (66),(ev)
-43: vgetexpss/d Vx,Hx,Wx (66),(ev)
-44: vplzcntd/q Vx,Wx (66),(ev)
-45: vpsrlvd/q Vx,Hx,Wx (66),(v)
-46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
-47: vpsllvd/q Vx,Hx,Wx (66),(v)
-# Skip 0x48-0x4b
-4c: vrcp14ps/d Vpd,Wpd (66),(ev)
-4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
-4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
-4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-# Skip 0x50-0x57
-58: vpbroadcastd Vx,Wx (66),(v)
-59: vpbroadcastq Vx,Wx (66),(v) | vbroadcasti32x2 Vx,Wx (66),(evo)
-5a: vbroadcasti128 Vqq,Mdq (66),(v) | vbroadcasti32x4/64x2 Vx,Wx (66),(evo)
-5b: vbroadcasti32x8/64x4 Vqq,Mdq (66),(ev)
-# Skip 0x5c-0x63
-64: vpblendmd/q Vx,Hx,Wx (66),(ev)
-65: vblendmps/d Vx,Hx,Wx (66),(ev)
-66: vpblendmb/w Vx,Hx,Wx (66),(ev)
-# Skip 0x67-0x74
-75: vpermi2b/w Vx,Hx,Wx (66),(ev)
-76: vpermi2d/q Vx,Hx,Wx (66),(ev)
-77: vpermi2ps/d Vx,Hx,Wx (66),(ev)
-78: vpbroadcastb Vx,Wx (66),(v)
-79: vpbroadcastw Vx,Wx (66),(v)
-7a: vpbroadcastb Vx,Rv (66),(ev)
-7b: vpbroadcastw Vx,Rv (66),(ev)
-7c: vpbroadcastd/q Vx,Rv (66),(ev)
-7d: vpermt2b/w Vx,Hx,Wx (66),(ev)
-7e: vpermt2d/q Vx,Hx,Wx (66),(ev)
-7f: vpermt2ps/d Vx,Hx,Wx (66),(ev)
-80: INVEPT Gy,Mdq (66)
-81: INVVPID Gy,Mdq (66)
-82: INVPCID Gy,Mdq (66)
-83: vpmultishiftqb Vx,Hx,Wx (66),(ev)
-88: vexpandps/d Vpd,Wpd (66),(ev)
-89: vpexpandd/q Vx,Wx (66),(ev)
-8a: vcompressps/d Wx,Vx (66),(ev)
-8b: vpcompressd/q Wx,Vx (66),(ev)
-8c: vpmaskmovd/q Vx,Hx,Mx (66),(v)
-8d: vpermb/w Vx,Hx,Wx (66),(ev)
-8e: vpmaskmovd/q Mx,Vx,Hx (66),(v)
-# 0x0f 0x38 0x90-0xbf (FMA)
-90: vgatherdd/q Vx,Hx,Wx (66),(v) | vpgatherdd/q Vx,Wx (66),(evo)
-91: vgatherqd/q Vx,Hx,Wx (66),(v) | vpgatherqd/q Vx,Wx (66),(evo)
-92: vgatherdps/d Vx,Hx,Wx (66),(v)
-93: vgatherqps/d Vx,Hx,Wx (66),(v)
-94:
-95:
-96: vfmaddsub132ps/d Vx,Hx,Wx (66),(v)
-97: vfmsubadd132ps/d Vx,Hx,Wx (66),(v)
-98: vfmadd132ps/d Vx,Hx,Wx (66),(v)
-99: vfmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
-9a: vfmsub132ps/d Vx,Hx,Wx (66),(v)
-9b: vfmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
-9c: vfnmadd132ps/d Vx,Hx,Wx (66),(v)
-9d: vfnmadd132ss/d Vx,Hx,Wx (66),(v),(v1)
-9e: vfnmsub132ps/d Vx,Hx,Wx (66),(v)
-9f: vfnmsub132ss/d Vx,Hx,Wx (66),(v),(v1)
-a0: vpscatterdd/q Wx,Vx (66),(ev)
-a1: vpscatterqd/q Wx,Vx (66),(ev)
-a2: vscatterdps/d Wx,Vx (66),(ev)
-a3: vscatterqps/d Wx,Vx (66),(ev)
-a6: vfmaddsub213ps/d Vx,Hx,Wx (66),(v)
-a7: vfmsubadd213ps/d Vx,Hx,Wx (66),(v)
-a8: vfmadd213ps/d Vx,Hx,Wx (66),(v)
-a9: vfmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
-aa: vfmsub213ps/d Vx,Hx,Wx (66),(v)
-ab: vfmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
-ac: vfnmadd213ps/d Vx,Hx,Wx (66),(v)
-ad: vfnmadd213ss/d Vx,Hx,Wx (66),(v),(v1)
-ae: vfnmsub213ps/d Vx,Hx,Wx (66),(v)
-af: vfnmsub213ss/d Vx,Hx,Wx (66),(v),(v1)
-b4: vpmadd52luq Vx,Hx,Wx (66),(ev)
-b5: vpmadd52huq Vx,Hx,Wx (66),(ev)
-b6: vfmaddsub231ps/d Vx,Hx,Wx (66),(v)
-b7: vfmsubadd231ps/d Vx,Hx,Wx (66),(v)
-b8: vfmadd231ps/d Vx,Hx,Wx (66),(v)
-b9: vfmadd231ss/d Vx,Hx,Wx (66),(v),(v1)
-ba: vfmsub231ps/d Vx,Hx,Wx (66),(v)
-bb: vfmsub231ss/d Vx,Hx,Wx (66),(v),(v1)
-bc: vfnmadd231ps/d Vx,Hx,Wx (66),(v)
-bd: vfnmadd231ss/d Vx,Hx,Wx (66),(v),(v1)
-be: vfnmsub231ps/d Vx,Hx,Wx (66),(v)
-bf: vfnmsub231ss/d Vx,Hx,Wx (66),(v),(v1)
-# 0x0f 0x38 0xc0-0xff
-c4: vpconflictd/q Vx,Wx (66),(ev)
-c6: Grp18 (1A)
-c7: Grp19 (1A)
-c8: sha1nexte Vdq,Wdq | vexp2ps/d Vx,Wx (66),(ev)
-c9: sha1msg1 Vdq,Wdq
-ca: sha1msg2 Vdq,Wdq | vrcp28ps/d Vx,Wx (66),(ev)
-cb: sha256rnds2 Vdq,Wdq | vrcp28ss/d Vx,Hx,Wx (66),(ev)
-cc: sha256msg1 Vdq,Wdq | vrsqrt28ps/d Vx,Wx (66),(ev)
-cd: sha256msg2 Vdq,Wdq | vrsqrt28ss/d Vx,Hx,Wx (66),(ev)
-db: VAESIMC Vdq,Wdq (66),(v1)
-dc: VAESENC Vdq,Hdq,Wdq (66),(v1)
-dd: VAESENCLAST Vdq,Hdq,Wdq (66),(v1)
-de: VAESDEC Vdq,Hdq,Wdq (66),(v1)
-df: VAESDECLAST Vdq,Hdq,Wdq (66),(v1)
-f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32 Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
-f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
-f2: ANDN Gy,By,Ey (v)
-f3: Grp17 (1A)
-f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
-f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
-EndTable
-
-Table: 3-byte opcode 2 (0x0f 0x3a)
-Referrer: 3-byte escape 2
-AVXcode: 3
-# 0x0f 0x3a 0x00-0xff
-00: vpermq Vqq,Wqq,Ib (66),(v)
-01: vpermpd Vqq,Wqq,Ib (66),(v)
-02: vpblendd Vx,Hx,Wx,Ib (66),(v)
-03: valignd/q Vx,Hx,Wx,Ib (66),(ev)
-04: vpermilps Vx,Wx,Ib (66),(v)
-05: vpermilpd Vx,Wx,Ib (66),(v)
-06: vperm2f128 Vqq,Hqq,Wqq,Ib (66),(v)
-07:
-08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo)
-09: vroundpd Vx,Wx,Ib (66) | vrndscalepd Vx,Wx,Ib (66),(evo)
-0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo)
-0b: vroundsd Vsd,Wsd,Ib (66),(v1) | vrndscalesd Vx,Hx,Wx,Ib (66),(evo)
-0c: vblendps Vx,Hx,Wx,Ib (66)
-0d: vblendpd Vx,Hx,Wx,Ib (66)
-0e: vpblendw Vx,Hx,Wx,Ib (66),(v1)
-0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1)
-14: vpextrb Rd/Mb,Vdq,Ib (66),(v1)
-15: vpextrw Rd/Mw,Vdq,Ib (66),(v1)
-16: vpextrd/q Ey,Vdq,Ib (66),(v1)
-17: vextractps Ed,Vdq,Ib (66),(v1)
-18: vinsertf128 Vqq,Hqq,Wqq,Ib (66),(v) | vinsertf32x4/64x2 Vqq,Hqq,Wqq,Ib (66),(evo)
-19: vextractf128 Wdq,Vqq,Ib (66),(v) | vextractf32x4/64x2 Wdq,Vqq,Ib (66),(evo)
-1a: vinsertf32x8/64x4 Vqq,Hqq,Wqq,Ib (66),(ev)
-1b: vextractf32x8/64x4 Wdq,Vqq,Ib (66),(ev)
-1d: vcvtps2ph Wx,Vx,Ib (66),(v)
-1e: vpcmpud/q Vk,Hd,Wd,Ib (66),(ev)
-1f: vpcmpd/q Vk,Hd,Wd,Ib (66),(ev)
-20: vpinsrb Vdq,Hdq,Ry/Mb,Ib (66),(v1)
-21: vinsertps Vdq,Hdq,Udq/Md,Ib (66),(v1)
-22: vpinsrd/q Vdq,Hdq,Ey,Ib (66),(v1)
-23: vshuff32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
-25: vpternlogd/q Vx,Hx,Wx,Ib (66),(ev)
-26: vgetmantps/d Vx,Wx,Ib (66),(ev)
-27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev)
-30: kshiftrb/w Vk,Uk,Ib (66),(v)
-31: kshiftrd/q Vk,Uk,Ib (66),(v)
-32: kshiftlb/w Vk,Uk,Ib (66),(v)
-33: kshiftld/q Vk,Uk,Ib (66),(v)
-38: vinserti128 Vqq,Hqq,Wqq,Ib (66),(v) | vinserti32x4/64x2 Vqq,Hqq,Wqq,Ib (66),(evo)
-39: vextracti128 Wdq,Vqq,Ib (66),(v) | vextracti32x4/64x2 Wdq,Vqq,Ib (66),(evo)
-3a: vinserti32x8/64x4 Vqq,Hqq,Wqq,Ib (66),(ev)
-3b: vextracti32x8/64x4 Wdq,Vqq,Ib (66),(ev)
-3e: vpcmpub/w Vk,Hk,Wx,Ib (66),(ev)
-3f: vpcmpb/w Vk,Hk,Wx,Ib (66),(ev)
-40: vdpps Vx,Hx,Wx,Ib (66)
-41: vdppd Vdq,Hdq,Wdq,Ib (66),(v1)
-42: vmpsadbw Vx,Hx,Wx,Ib (66),(v1) | vdbpsadbw Vx,Hx,Wx,Ib (66),(evo)
-43: vshufi32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
-44: vpclmulqdq Vdq,Hdq,Wdq,Ib (66),(v1)
-46: vperm2i128 Vqq,Hqq,Wqq,Ib (66),(v)
-4a: vblendvps Vx,Hx,Wx,Lx (66),(v)
-4b: vblendvpd Vx,Hx,Wx,Lx (66),(v)
-4c: vpblendvb Vx,Hx,Wx,Lx (66),(v1)
-50: vrangeps/d Vx,Hx,Wx,Ib (66),(ev)
-51: vrangess/d Vx,Hx,Wx,Ib (66),(ev)
-54: vfixupimmps/d Vx,Hx,Wx,Ib (66),(ev)
-55: vfixupimmss/d Vx,Hx,Wx,Ib (66),(ev)
-56: vreduceps/d Vx,Wx,Ib (66),(ev)
-57: vreducess/d Vx,Hx,Wx,Ib (66),(ev)
-60: vpcmpestrm Vdq,Wdq,Ib (66),(v1)
-61: vpcmpestri Vdq,Wdq,Ib (66),(v1)
-62: vpcmpistrm Vdq,Wdq,Ib (66),(v1)
-63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
-66: vfpclassps/d Vk,Wx,Ib (66),(ev)
-67: vfpclassss/d Vk,Wx,Ib (66),(ev)
-cc: sha1rnds4 Vdq,Wdq,Ib
-df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
-f0: RORX Gy,Ey,Ib (F2),(v)
-EndTable
-
-GrpTable: Grp1
-0: ADD
-1: OR
-2: ADC
-3: SBB
-4: AND
-5: SUB
-6: XOR
-7: CMP
-EndTable
-
-GrpTable: Grp1A
-0: POP
-EndTable
-
-GrpTable: Grp2
-0: ROL
-1: ROR
-2: RCL
-3: RCR
-4: SHL/SAL
-5: SHR
-6:
-7: SAR
-EndTable
-
-GrpTable: Grp3_1
-0: TEST Eb,Ib
-1: TEST Eb,Ib
-2: NOT Eb
-3: NEG Eb
-4: MUL AL,Eb
-5: IMUL AL,Eb
-6: DIV AL,Eb
-7: IDIV AL,Eb
-EndTable
-
-GrpTable: Grp3_2
-0: TEST Ev,Iz
-1:
-2: NOT Ev
-3: NEG Ev
-4: MUL rAX,Ev
-5: IMUL rAX,Ev
-6: DIV rAX,Ev
-7: IDIV rAX,Ev
-EndTable
-
-GrpTable: Grp4
-0: INC Eb
-1: DEC Eb
-EndTable
-
-GrpTable: Grp5
-0: INC Ev
-1: DEC Ev
-# Note: "forced64" is Intel CPU behavior (see comment about CALL insn).
-2: CALLN Ev (f64)
-3: CALLF Ep
-4: JMPN Ev (f64)
-5: JMPF Mp
-6: PUSH Ev (d64)
-7:
-EndTable
-
-GrpTable: Grp6
-0: SLDT Rv/Mw
-1: STR Rv/Mw
-2: LLDT Ew
-3: LTR Ew
-4: VERR Ew
-5: VERW Ew
-EndTable
-
-GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B)
-2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B)
-3: LIDT Ms
-4: SMSW Mw/Rv
-5: rdpkru (110),(11B) | wrpkru (111),(11B)
-6: LMSW Ew
-7: INVLPG Mb | SWAPGS (o64),(000),(11B) | RDTSCP (001),(11B)
-EndTable
-
-GrpTable: Grp8
-4: BT
-5: BTS
-6: BTR
-7: BTC
-EndTable
-
-GrpTable: Grp9
-1: CMPXCHG8B/16B Mq/Mdq
-3: xrstors
-4: xsavec
-5: xsaves
-6: VMPTRLD Mq | VMCLEAR Mq (66) | VMXON Mq (F3) | RDRAND Rv (11B)
-7: VMPTRST Mq | VMPTRST Mq (F3) | RDSEED Rv (11B)
-EndTable
-
-GrpTable: Grp10
-# all are UD1
-0: UD1
-1: UD1
-2: UD1
-3: UD1
-4: UD1
-5: UD1
-6: UD1
-7: UD1
-EndTable
-
-# Grp11A and Grp11B are expressed as Grp11 in Intel SDM
-GrpTable: Grp11A
-0: MOV Eb,Ib
-7: XABORT Ib (000),(11B)
-EndTable
-
-GrpTable: Grp11B
-0: MOV Eb,Iz
-7: XBEGIN Jz (000),(11B)
-EndTable
-
-GrpTable: Grp12
-2: psrlw Nq,Ib (11B) | vpsrlw Hx,Ux,Ib (66),(11B),(v1)
-4: psraw Nq,Ib (11B) | vpsraw Hx,Ux,Ib (66),(11B),(v1)
-6: psllw Nq,Ib (11B) | vpsllw Hx,Ux,Ib (66),(11B),(v1)
-EndTable
-
-GrpTable: Grp13
-0: vprord/q Hx,Wx,Ib (66),(ev)
-1: vprold/q Hx,Wx,Ib (66),(ev)
-2: psrld Nq,Ib (11B) | vpsrld Hx,Ux,Ib (66),(11B),(v1)
-4: psrad Nq,Ib (11B) | vpsrad Hx,Ux,Ib (66),(11B),(v1) | vpsrad/q Hx,Ux,Ib (66),(evo)
-6: pslld Nq,Ib (11B) | vpslld Hx,Ux,Ib (66),(11B),(v1)
-EndTable
-
-GrpTable: Grp14
-2: psrlq Nq,Ib (11B) | vpsrlq Hx,Ux,Ib (66),(11B),(v1)
-3: vpsrldq Hx,Ux,Ib (66),(11B),(v1)
-6: psllq Nq,Ib (11B) | vpsllq Hx,Ux,Ib (66),(11B),(v1)
-7: vpslldq Hx,Ux,Ib (66),(11B),(v1)
-EndTable
-
-GrpTable: Grp15
-0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
-4: XSAVE | ptwrite Ey (F3),(11B)
-5: XRSTOR | lfence (11B)
-6: XSAVEOPT | clwb (66) | mfence (11B)
-7: clflush | clflushopt (66) | sfence (11B)
-EndTable
-
-GrpTable: Grp16
-0: prefetch NTA
-1: prefetch T0
-2: prefetch T1
-3: prefetch T2
-EndTable
-
-GrpTable: Grp17
-1: BLSR By,Ey (v)
-2: BLSMSK By,Ey (v)
-3: BLSI By,Ey (v)
-EndTable
-
-GrpTable: Grp18
-1: vgatherpf0dps/d Wx (66),(ev)
-2: vgatherpf1dps/d Wx (66),(ev)
-5: vscatterpf0dps/d Wx (66),(ev)
-6: vscatterpf1dps/d Wx (66),(ev)
-EndTable
-
-GrpTable: Grp19
-1: vgatherpf0qps/d Wx (66),(ev)
-2: vgatherpf1qps/d Wx (66),(ev)
-5: vscatterpf0qps/d Wx (66),(ev)
-6: vscatterpf1qps/d Wx (66),(ev)
-EndTable
-
-# AMD's Prefetch Group
-GrpTable: GrpP
-0: PREFETCH
-1: PREFETCHW
-EndTable
-
-GrpTable: GrpPDLK
-0: MONTMUL
-1: XSHA1
-2: XSHA2
-EndTable
-
-GrpTable: GrpRNG
-0: xstore-rng
-1: xcrypt-ecb
-2: xcrypt-cbc
-4: xcrypt-cfb
-5: xcrypt-ofb
-EndTable
diff --git a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
deleted file mode 100644
index b02a36b..0000000
--- a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
+++ /dev/null
@@ -1,393 +0,0 @@
-#!/bin/awk -f
-# SPDX-License-Identifier: GPL-2.0
-# gen-insn-attr-x86.awk: Instruction attribute table generator
-# Written by Masami Hiramatsu <mhiramat@redhat.com>
-#
-# Usage: awk -f gen-insn-attr-x86.awk x86-opcode-map.txt > inat-tables.c
-
-# Awk implementation sanity check
-function check_awk_implement() {
-	if (sprintf("%x", 0) != "0")
-		return "Your awk has a printf-format problem."
-	return ""
-}
-
-# Clear working vars
-function clear_vars() {
-	delete table
-	delete lptable2
-	delete lptable1
-	delete lptable3
-	eid = -1 # escape id
-	gid = -1 # group id
-	aid = -1 # AVX id
-	tname = ""
-}
-
-BEGIN {
-	# Implementation error checking
-	awkchecked = check_awk_implement()
-	if (awkchecked != "") {
-		print "Error: " awkchecked > "/dev/stderr"
-		print "Please try to use gawk." > "/dev/stderr"
-		exit 1
-	}
-
-	# Setup generating tables
-	print "/* x86 opcode map generated from x86-opcode-map.txt */"
-	print "/* Do not change this code. */\n"
-	ggid = 1
-	geid = 1
-	gaid = 0
-	delete etable
-	delete gtable
-	delete atable
-
-	opnd_expr = "^[A-Za-z/]"
-	ext_expr = "^\\("
-	sep_expr = "^\\|$"
-	group_expr = "^Grp[0-9A-Za-z]+"
-
-	imm_expr = "^[IJAOL][a-z]"
-	imm_flag["Ib"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
-	imm_flag["Jb"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
-	imm_flag["Iw"] = "INAT_MAKE_IMM(INAT_IMM_WORD)"
-	imm_flag["Id"] = "INAT_MAKE_IMM(INAT_IMM_DWORD)"
-	imm_flag["Iq"] = "INAT_MAKE_IMM(INAT_IMM_QWORD)"
-	imm_flag["Ap"] = "INAT_MAKE_IMM(INAT_IMM_PTR)"
-	imm_flag["Iz"] = "INAT_MAKE_IMM(INAT_IMM_VWORD32)"
-	imm_flag["Jz"] = "INAT_MAKE_IMM(INAT_IMM_VWORD32)"
-	imm_flag["Iv"] = "INAT_MAKE_IMM(INAT_IMM_VWORD)"
-	imm_flag["Ob"] = "INAT_MOFFSET"
-	imm_flag["Ov"] = "INAT_MOFFSET"
-	imm_flag["Lx"] = "INAT_MAKE_IMM(INAT_IMM_BYTE)"
-
-	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
-	force64_expr = "\\([df]64\\)"
-	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
-
-	lprefix1_expr = "\\((66|!F3)\\)"
-	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
-	lprefix_expr = "\\((66|F2|F3)\\)"
-	max_lprefix = 4
-
-	# All opcodes starting with lower-case 'v', 'k' or with (v1) superscript
-	# accepts VEX prefix
-	vexok_opcode_expr = "^[vk].*"
-	vexok_expr = "\\(v1\\)"
-	# All opcodes with (v) superscript supports *only* VEX prefix
-	vexonly_expr = "\\(v\\)"
-	# All opcodes with (ev) superscript supports *only* EVEX prefix
-	evexonly_expr = "\\(ev\\)"
-
-	prefix_expr = "\\(Prefix\\)"
-	prefix_num["Operand-Size"] = "INAT_PFX_OPNDSZ"
-	prefix_num["REPNE"] = "INAT_PFX_REPNE"
-	prefix_num["REP/REPE"] = "INAT_PFX_REPE"
-	prefix_num["XACQUIRE"] = "INAT_PFX_REPNE"
-	prefix_num["XRELEASE"] = "INAT_PFX_REPE"
-	prefix_num["LOCK"] = "INAT_PFX_LOCK"
-	prefix_num["SEG=CS"] = "INAT_PFX_CS"
-	prefix_num["SEG=DS"] = "INAT_PFX_DS"
-	prefix_num["SEG=ES"] = "INAT_PFX_ES"
-	prefix_num["SEG=FS"] = "INAT_PFX_FS"
-	prefix_num["SEG=GS"] = "INAT_PFX_GS"
-	prefix_num["SEG=SS"] = "INAT_PFX_SS"
-	prefix_num["Address-Size"] = "INAT_PFX_ADDRSZ"
-	prefix_num["VEX+1byte"] = "INAT_PFX_VEX2"
-	prefix_num["VEX+2byte"] = "INAT_PFX_VEX3"
-	prefix_num["EVEX"] = "INAT_PFX_EVEX"
-
-	clear_vars()
-}
-
-function semantic_error(msg) {
-	print "Semantic error at " NR ": " msg > "/dev/stderr"
-	exit 1
-}
-
-function debug(msg) {
-	print "DEBUG: " msg
-}
-
-function array_size(arr,   i,c) {
-	c = 0
-	for (i in arr)
-		c++
-	return c
-}
-
-/^Table:/ {
-	print "/* " $0 " */"
-	if (tname != "")
-		semantic_error("Hit Table: before EndTable:.");
-}
-
-/^Referrer:/ {
-	if (NF != 1) {
-		# escape opcode table
-		ref = ""
-		for (i = 2; i <= NF; i++)
-			ref = ref $i
-		eid = escape[ref]
-		tname = sprintf("inat_escape_table_%d", eid)
-	}
-}
-
-/^AVXcode:/ {
-	if (NF != 1) {
-		# AVX/escape opcode table
-		aid = $2
-		if (gaid <= aid)
-			gaid = aid + 1
-		if (tname == "")	# AVX only opcode table
-			tname = sprintf("inat_avx_table_%d", $2)
-	}
-	if (aid == -1 && eid == -1)	# primary opcode table
-		tname = "inat_primary_table"
-}
-
-/^GrpTable:/ {
-	print "/* " $0 " */"
-	if (!($2 in group))
-		semantic_error("No group: " $2 )
-	gid = group[$2]
-	tname = "inat_group_table_" gid
-}
-
-function print_table(tbl,name,fmt,n)
-{
-	print "const insn_attr_t " name " = {"
-	for (i = 0; i < n; i++) {
-		id = sprintf(fmt, i)
-		if (tbl[id])
-			print "	[" id "] = " tbl[id] ","
-	}
-	print "};"
-}
-
-/^EndTable/ {
-	if (gid != -1) {
-		# print group tables
-		if (array_size(table) != 0) {
-			print_table(table, tname "[INAT_GROUP_TABLE_SIZE]",
-				    "0x%x", 8)
-			gtable[gid,0] = tname
-		}
-		if (array_size(lptable1) != 0) {
-			print_table(lptable1, tname "_1[INAT_GROUP_TABLE_SIZE]",
-				    "0x%x", 8)
-			gtable[gid,1] = tname "_1"
-		}
-		if (array_size(lptable2) != 0) {
-			print_table(lptable2, tname "_2[INAT_GROUP_TABLE_SIZE]",
-				    "0x%x", 8)
-			gtable[gid,2] = tname "_2"
-		}
-		if (array_size(lptable3) != 0) {
-			print_table(lptable3, tname "_3[INAT_GROUP_TABLE_SIZE]",
-				    "0x%x", 8)
-			gtable[gid,3] = tname "_3"
-		}
-	} else {
-		# print primary/escaped tables
-		if (array_size(table) != 0) {
-			print_table(table, tname "[INAT_OPCODE_TABLE_SIZE]",
-				    "0x%02x", 256)
-			etable[eid,0] = tname
-			if (aid >= 0)
-				atable[aid,0] = tname
-		}
-		if (array_size(lptable1) != 0) {
-			print_table(lptable1,tname "_1[INAT_OPCODE_TABLE_SIZE]",
-				    "0x%02x", 256)
-			etable[eid,1] = tname "_1"
-			if (aid >= 0)
-				atable[aid,1] = tname "_1"
-		}
-		if (array_size(lptable2) != 0) {
-			print_table(lptable2,tname "_2[INAT_OPCODE_TABLE_SIZE]",
-				    "0x%02x", 256)
-			etable[eid,2] = tname "_2"
-			if (aid >= 0)
-				atable[aid,2] = tname "_2"
-		}
-		if (array_size(lptable3) != 0) {
-			print_table(lptable3,tname "_3[INAT_OPCODE_TABLE_SIZE]",
-				    "0x%02x", 256)
-			etable[eid,3] = tname "_3"
-			if (aid >= 0)
-				atable[aid,3] = tname "_3"
-		}
-	}
-	print ""
-	clear_vars()
-}
-
-function add_flags(old,new) {
-	if (old && new)
-		return old " | " new
-	else if (old)
-		return old
-	else
-		return new
-}
-
-# convert operands to flags.
-function convert_operands(count,opnd,       i,j,imm,mod)
-{
-	imm = null
-	mod = null
-	for (j = 1; j <= count; j++) {
-		i = opnd[j]
-		if (match(i, imm_expr) == 1) {
-			if (!imm_flag[i])
-				semantic_error("Unknown imm opnd: " i)
-			if (imm) {
-				if (i != "Ib")
-					semantic_error("Second IMM error")
-				imm = add_flags(imm, "INAT_SCNDIMM")
-			} else
-				imm = imm_flag[i]
-		} else if (match(i, modrm_expr))
-			mod = "INAT_MODRM"
-	}
-	return add_flags(imm, mod)
-}
-
-/^[0-9a-f]+\:/ {
-	if (NR == 1)
-		next
-	# get index
-	idx = "0x" substr($1, 1, index($1,":") - 1)
-	if (idx in table)
-		semantic_error("Redefine " idx " in " tname)
-
-	# check if escaped opcode
-	if ("escape" == $2) {
-		if ($3 != "#")
-			semantic_error("No escaped name")
-		ref = ""
-		for (i = 4; i <= NF; i++)
-			ref = ref $i
-		if (ref in escape)
-			semantic_error("Redefine escape (" ref ")")
-		escape[ref] = geid
-		geid++
-		table[idx] = "INAT_MAKE_ESCAPE(" escape[ref] ")"
-		next
-	}
-
-	variant = null
-	# converts
-	i = 2
-	while (i <= NF) {
-		opcode = $(i++)
-		delete opnds
-		ext = null
-		flags = null
-		opnd = null
-		# parse one opcode
-		if (match($i, opnd_expr)) {
-			opnd = $i
-			count = split($(i++), opnds, ",")
-			flags = convert_operands(count, opnds)
-		}
-		if (match($i, ext_expr))
-			ext = $(i++)
-		if (match($i, sep_expr))
-			i++
-		else if (i < NF)
-			semantic_error($i " is not a separator")
-
-		# check if group opcode
-		if (match(opcode, group_expr)) {
-			if (!(opcode in group)) {
-				group[opcode] = ggid
-				ggid++
-			}
-			flags = add_flags(flags, "INAT_MAKE_GROUP(" group[opcode] ")")
-		}
-		# check force(or default) 64bit
-		if (match(ext, force64_expr))
-			flags = add_flags(flags, "INAT_FORCE64")
-
-		# check REX prefix
-		if (match(opcode, rex_expr))
-			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
-
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
-
-		# check VEX codes
-		if (match(ext, evexonly_expr))
-			flags = add_flags(flags, "INAT_VEXOK | INAT_EVEXONLY")
-		else if (match(ext, vexonly_expr))
-			flags = add_flags(flags, "INAT_VEXOK | INAT_VEXONLY")
-		else if (match(ext, vexok_expr) || match(opcode, vexok_opcode_expr))
-			flags = add_flags(flags, "INAT_VEXOK")
-
-		# check prefixes
-		if (match(ext, prefix_expr)) {
-			if (!prefix_num[opcode])
-				semantic_error("Unknown prefix: " opcode)
-			flags = add_flags(flags, "INAT_MAKE_PREFIX(" prefix_num[opcode] ")")
-		}
-		if (length(flags) == 0)
-			continue
-		# check if last prefix
-		if (match(ext, lprefix1_expr)) {
-			lptable1[idx] = add_flags(lptable1[idx],flags)
-			variant = "INAT_VARIANT"
-		}
-		if (match(ext, lprefix2_expr)) {
-			lptable2[idx] = add_flags(lptable2[idx],flags)
-			variant = "INAT_VARIANT"
-		}
-		if (match(ext, lprefix3_expr)) {
-			lptable3[idx] = add_flags(lptable3[idx],flags)
-			variant = "INAT_VARIANT"
-		}
-		if (!match(ext, lprefix_expr)){
-			table[idx] = add_flags(table[idx],flags)
-		}
-	}
-	if (variant)
-		table[idx] = add_flags(table[idx],variant)
-}
-
-END {
-	if (awkchecked != "")
-		exit 1
-	# print escape opcode map's array
-	print "/* Escape opcode map array */"
-	print "const insn_attr_t * const inat_escape_tables[INAT_ESC_MAX + 1]" \
-	      "[INAT_LSTPFX_MAX + 1] = {"
-	for (i = 0; i < geid; i++)
-		for (j = 0; j < max_lprefix; j++)
-			if (etable[i,j])
-				print "	["i"]["j"] = "etable[i,j]","
-	print "};\n"
-	# print group opcode map's array
-	print "/* Group opcode map array */"
-	print "const insn_attr_t * const inat_group_tables[INAT_GRP_MAX + 1]"\
-	      "[INAT_LSTPFX_MAX + 1] = {"
-	for (i = 0; i < ggid; i++)
-		for (j = 0; j < max_lprefix; j++)
-			if (gtable[i,j])
-				print "	["i"]["j"] = "gtable[i,j]","
-	print "};\n"
-	# print AVX opcode map's array
-	print "/* AVX opcode map array */"
-	print "const insn_attr_t * const inat_avx_tables[X86_VEX_M_MAX + 1]"\
-	      "[INAT_LSTPFX_MAX + 1] = {"
-	for (i = 0; i < gaid; i++)
-		for (j = 0; j < max_lprefix; j++)
-			if (atable[i,j])
-				print "	["i"]["j"] = "atable[i,j]","
-	print "};"
-}
-
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 1470e74..66f1575 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -2,21 +2,21 @@
 # SPDX-License-Identifier: GPL-2.0
 
 FILES='
-arch/x86/lib/insn.c
-arch/x86/lib/inat.c
-arch/x86/lib/x86-opcode-map.txt
-arch/x86/tools/gen-insn-attr-x86.awk
-arch/x86/include/asm/insn.h
 arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/insn.h
 arch/x86/include/asm/orc_types.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+arch/x86/lib/x86-opcode-map.txt
+arch/x86/tools/gen-insn-attr-x86.awk
 '
 
 check()
 {
 	local file=$1
 
-	diff $file ../../$file > /dev/null ||
+	diff ../$file ../../$file > /dev/null ||
 		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
 }
 
