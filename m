Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40A028639A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgJGQUh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgJGQUZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:25 -0400
Date:   Wed, 07 Oct 2020 16:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nb5MlJRJeSYgs2TjC3lXHJa0XiqzZnW+ARvXJWpgLT4=;
        b=zO9wLpsTX2ts18rkKmxJtiBIuqmTdoY5YkLMOJ6qWQOO702k5LXgdMlSmWJ6A1wAOdNiva
        2w4Ht/NZCBrG+GrnvX/NAms7t8YYb1O7gI2klAyh0K5eVWCgMgireVP/bMpSJCwvxlEzsw
        qTGsDuJbAwrK80g/vosVvNWDKB9ODZ0pgy2K/ZBc1zRhE2G1l5qS3lxD9f0VYLJl67Gwdy
        4zYcKMr+iWQXkr6TcKPJmcwFWDrDNtJYf2Ap/4vaxffaSn9MtWXNyY31FIgAQM51/q2lTB
        G454F0S32Re5/JYGhtncOkE9z7Z5H+8l0/Tqc48oSz2xUGjdW/IOV5iuJgnsvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nb5MlJRJeSYgs2TjC3lXHJa0XiqzZnW+ARvXJWpgLT4=;
        b=UAN0+3gLJPLHezSzF16HAKAZQ5rQP8f66F9NWg2kmSXEyhP1aLK7fcPikfHUWf5xtHhfP4
        I0/eAyhpHzuJrZDw==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rework header include paths
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160208761777.7002.14522125983544999977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a23b701ae9b334f86aabdcba5dd57fc0e81b51b6
Gitweb:        https://git.kernel.org/tip/a23b701ae9b334f86aabdcba5dd57fc0e81b51b6
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Mon, 05 Oct 2020 17:50:41 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 06 Oct 2020 09:37:57 -05:00

objtool: Rework header include paths

Currently objtool headers are being included either by their base name
or included via ../ from a parent directory. In case of a base name usage:

 #include "warn.h"
 #include "arch_elf.h"

it does not make it apparent from which directory the file comes from.
To make it slightly better, and actually to avoid name clashes some arch
specific files have "arch_" suffix. And files from an arch folder have
to revert to including via ../ e.g:
 #include "../../elf.h"

With additional architectures support and the code base growth there is
a need for clearer headers naming scheme for multiple reasons:
1. to make it instantly obvious where these files come from (objtool
   itself / objtool arch|generic folders / some other external files),
2. to avoid name clashes of objtool arch specific headers, potential
   obtool arch generic headers and the system header files (there is
   /usr/include/elf.h already),
3. to avoid ../ includes and improve code readability.
4. to give a warm fuzzy feeling to developers who are mostly kernel
   developers and are accustomed to linux kernel headers arranging
   scheme.

Doesn't this make it instantly obvious where are these files come from?

 #include <objtool/warn.h>
 #include <arch/elf.h>

And doesn't it look nicer to avoid ugly ../ includes? Which also
guarantees this is elf.h from the objtool and not /usr/include/elf.h.

 #include <objtool/elf.h>

This patch defines and implements new objtool headers arranging
scheme. Which is:
- all generic headers go to include/objtool (similar to include/linux)
- all arch headers go to arch/$(SRCARCH)/include/arch (to get arch
  prefix). This is similar to linux arch specific "asm/*" headers but we
  are not abusing "asm" name and calling it what it is. This also helps
  to prevent name clashes (arch is not used in system headers or kernel
  exports).

To bring objtool to this state the following things are done:
1. current top level tools/objtool/ headers are moved into
   include/objtool/ subdirectory,
2. arch specific headers, currently only arch/x86/include/ are moved into
   arch/x86/include/arch/ and were stripped of "arch_" suffix,
3. new -I$(srctree)/tools/objtool/include include path to make
   includes like <objtool/warn.h> possible,
4. rewriting file includes,
5. make git not to ignore include/objtool/ subdirectory.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/.gitignore                         |   2 +-
 tools/objtool/Makefile                           |   1 +-
 tools/objtool/arch.h                             |  93 +---------
 tools/objtool/arch/x86/decode.c                  |   8 +-
 tools/objtool/arch/x86/include/arch/cfi_regs.h   |  25 ++-
 tools/objtool/arch/x86/include/arch/elf.h        |   6 +-
 tools/objtool/arch/x86/include/arch/endianness.h |   9 +-
 tools/objtool/arch/x86/include/arch/special.h    |  20 ++-
 tools/objtool/arch/x86/include/arch_elf.h        |   6 +-
 tools/objtool/arch/x86/include/arch_endianness.h |   9 +-
 tools/objtool/arch/x86/include/arch_special.h    |  20 +--
 tools/objtool/arch/x86/include/cfi_regs.h        |  25 +--
 tools/objtool/arch/x86/special.c                 |   4 +-
 tools/objtool/builtin-check.c                    |   4 +-
 tools/objtool/builtin-orc.c                      |   4 +-
 tools/objtool/builtin.h                          |  16 +--
 tools/objtool/cfi.h                              |  38 +----
 tools/objtool/check.c                            |  16 +-
 tools/objtool/check.h                            |  69 +-------
 tools/objtool/elf.c                              |   6 +-
 tools/objtool/elf.h                              | 148 +--------------
 tools/objtool/endianness.h                       |  38 +----
 tools/objtool/include/objtool/arch.h             |  93 +++++++++-
 tools/objtool/include/objtool/builtin.h          |  16 ++-
 tools/objtool/include/objtool/cfi.h              |  38 ++++-
 tools/objtool/include/objtool/check.h            |  69 +++++++-
 tools/objtool/include/objtool/elf.h              | 148 ++++++++++++++-
 tools/objtool/include/objtool/endianness.h       |  38 ++++-
 tools/objtool/include/objtool/objtool.h          |  32 +++-
 tools/objtool/include/objtool/special.h          |  41 ++++-
 tools/objtool/include/objtool/warn.h             |  66 ++++++-
 tools/objtool/objtool.c                          |   6 +-
 tools/objtool/objtool.h                          |  32 +---
 tools/objtool/orc_dump.c                         |   6 +-
 tools/objtool/orc_gen.c                          |   6 +-
 tools/objtool/special.c                          |  10 +-
 tools/objtool/special.h                          |  41 +----
 tools/objtool/warn.h                             |  66 +------
 tools/objtool/weak.c                             |   2 +-
 39 files changed, 639 insertions(+), 638 deletions(-)
 delete mode 100644 tools/objtool/arch.h
 create mode 100644 tools/objtool/arch/x86/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/x86/include/arch/elf.h
 create mode 100644 tools/objtool/arch/x86/include/arch/endianness.h
 create mode 100644 tools/objtool/arch/x86/include/arch/special.h
 delete mode 100644 tools/objtool/arch/x86/include/arch_elf.h
 delete mode 100644 tools/objtool/arch/x86/include/arch_endianness.h
 delete mode 100644 tools/objtool/arch/x86/include/arch_special.h
 delete mode 100644 tools/objtool/arch/x86/include/cfi_regs.h
 delete mode 100644 tools/objtool/builtin.h
 delete mode 100644 tools/objtool/cfi.h
 delete mode 100644 tools/objtool/check.h
 delete mode 100644 tools/objtool/elf.h
 delete mode 100644 tools/objtool/endianness.h
 create mode 100644 tools/objtool/include/objtool/arch.h
 create mode 100644 tools/objtool/include/objtool/builtin.h
 create mode 100644 tools/objtool/include/objtool/cfi.h
 create mode 100644 tools/objtool/include/objtool/check.h
 create mode 100644 tools/objtool/include/objtool/elf.h
 create mode 100644 tools/objtool/include/objtool/endianness.h
 create mode 100644 tools/objtool/include/objtool/objtool.h
 create mode 100644 tools/objtool/include/objtool/special.h
 create mode 100644 tools/objtool/include/objtool/warn.h
 delete mode 100644 tools/objtool/objtool.h
 delete mode 100644 tools/objtool/special.h
 delete mode 100644 tools/objtool/warn.h

diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 45cefda..14236db 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 arch/x86/lib/inat-tables.c
-objtool
+/objtool
 fixdep
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 4ea9a83..1da7ae2 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -36,6 +36,7 @@ all: $(OBJTOOL)
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
+	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
deleted file mode 100644
index 4a84c30..0000000
--- a/tools/objtool/arch.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _ARCH_H
-#define _ARCH_H
-
-#include <stdbool.h>
-#include <linux/list.h>
-#include "objtool.h"
-#include "cfi.h"
-
-#ifdef INSN_USE_ORC
-#include <asm/orc_types.h>
-#endif
-
-enum insn_type {
-	INSN_JUMP_CONDITIONAL,
-	INSN_JUMP_UNCONDITIONAL,
-	INSN_JUMP_DYNAMIC,
-	INSN_JUMP_DYNAMIC_CONDITIONAL,
-	INSN_CALL,
-	INSN_CALL_DYNAMIC,
-	INSN_RETURN,
-	INSN_CONTEXT_SWITCH,
-	INSN_BUG,
-	INSN_NOP,
-	INSN_STAC,
-	INSN_CLAC,
-	INSN_STD,
-	INSN_CLD,
-	INSN_OTHER,
-};
-
-enum op_dest_type {
-	OP_DEST_REG,
-	OP_DEST_REG_INDIRECT,
-	OP_DEST_MEM,
-	OP_DEST_PUSH,
-	OP_DEST_PUSHF,
-	OP_DEST_LEAVE,
-};
-
-struct op_dest {
-	enum op_dest_type type;
-	unsigned char reg;
-	int offset;
-};
-
-enum op_src_type {
-	OP_SRC_REG,
-	OP_SRC_REG_INDIRECT,
-	OP_SRC_CONST,
-	OP_SRC_POP,
-	OP_SRC_POPF,
-	OP_SRC_ADD,
-	OP_SRC_AND,
-};
-
-struct op_src {
-	enum op_src_type type;
-	unsigned char reg;
-	int offset;
-};
-
-struct stack_op {
-	struct op_dest dest;
-	struct op_src src;
-	struct list_head list;
-};
-
-struct instruction;
-
-void arch_initial_func_cfi_state(struct cfi_init_state *state);
-
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
-			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list);
-
-bool arch_callee_saved_reg(unsigned char reg);
-
-unsigned long arch_jump_destination(struct instruction *insn);
-
-unsigned long arch_dest_reloc_offset(int addend);
-
-const char *arch_nop_insn(int len);
-
-int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
-
-#endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cde9c36..6baa227 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,11 +11,11 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
-#include "../../check.h"
-#include "../../elf.h"
-#include "../../arch.h"
-#include "../../warn.h"
 #include <asm/orc_types.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
+#include <objtool/arch.h>
+#include <objtool/warn.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
diff --git a/tools/objtool/arch/x86/include/arch/cfi_regs.h b/tools/objtool/arch/x86/include/arch/cfi_regs.h
new file mode 100644
index 0000000..79bc517
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/cfi_regs.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _OBJTOOL_CFI_REGS_H
+#define _OBJTOOL_CFI_REGS_H
+
+#define CFI_AX			0
+#define CFI_DX			1
+#define CFI_CX			2
+#define CFI_BX			3
+#define CFI_SI			4
+#define CFI_DI			5
+#define CFI_BP			6
+#define CFI_SP			7
+#define CFI_R8			8
+#define CFI_R9			9
+#define CFI_R10			10
+#define CFI_R11			11
+#define CFI_R12			12
+#define CFI_R13			13
+#define CFI_R14			14
+#define CFI_R15			15
+#define CFI_RA			16
+#define CFI_NUM_REGS		17
+
+#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
new file mode 100644
index 0000000..69cc426
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -0,0 +1,6 @@
+#ifndef _OBJTOOL_ARCH_ELF
+#define _OBJTOOL_ARCH_ELF
+
+#define R_NONE R_X86_64_NONE
+
+#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/x86/include/arch/endianness.h b/tools/objtool/arch/x86/include/arch/endianness.h
new file mode 100644
index 0000000..7c36252
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/endianness.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ARCH_ENDIANNESS_H
+#define _ARCH_ENDIANNESS_H
+
+#include <endian.h>
+
+#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
+
+#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/x86/include/arch/special.h b/tools/objtool/arch/x86/include/arch/special.h
new file mode 100644
index 0000000..d818b2b
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/x86/include/arch_elf.h b/tools/objtool/arch/x86/include/arch_elf.h
deleted file mode 100644
index 69cc426..0000000
--- a/tools/objtool/arch/x86/include/arch_elf.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _OBJTOOL_ARCH_ELF
-#define _OBJTOOL_ARCH_ELF
-
-#define R_NONE R_X86_64_NONE
-
-#endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/arch/x86/include/arch_endianness.h b/tools/objtool/arch/x86/include/arch_endianness.h
deleted file mode 100644
index 7c36252..0000000
--- a/tools/objtool/arch/x86/include/arch_endianness.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ARCH_ENDIANNESS_H
-#define _ARCH_ENDIANNESS_H
-
-#include <endian.h>
-
-#define __TARGET_BYTE_ORDER __LITTLE_ENDIAN
-
-#endif /* _ARCH_ENDIANNESS_H */
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
deleted file mode 100644
index d818b2b..0000000
--- a/tools/objtool/arch/x86/include/arch_special.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _X86_ARCH_SPECIAL_H
-#define _X86_ARCH_SPECIAL_H
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
-
-#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/x86/include/cfi_regs.h b/tools/objtool/arch/x86/include/cfi_regs.h
deleted file mode 100644
index 79bc517..0000000
--- a/tools/objtool/arch/x86/include/cfi_regs.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef _OBJTOOL_CFI_REGS_H
-#define _OBJTOOL_CFI_REGS_H
-
-#define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
-#define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
-#define CFI_R8			8
-#define CFI_R9			9
-#define CFI_R10			10
-#define CFI_R11			11
-#define CFI_R12			12
-#define CFI_R13			13
-#define CFI_R14			14
-#define CFI_R15			15
-#define CFI_RA			16
-#define CFI_NUM_REGS		17
-
-#endif /* _OBJTOOL_CFI_REGS_H */
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index fd4af88..b4bd350 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 
-#include "../../special.h"
-#include "../../builtin.h"
+#include <objtool/special.h>
+#include <objtool/builtin.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c6d199b..f47951e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,8 +15,8 @@
 
 #include <subcmd/parse-options.h>
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
 
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 7b31121..6745f33 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -13,8 +13,8 @@
  */
 
 #include <string.h>
-#include "builtin.h"
-#include "objtool.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
 
 static const char *orc_usage[] = {
 	"objtool orc generate [<options>] file.o",
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
deleted file mode 100644
index 85c979c..0000000
--- a/tools/objtool/builtin.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-#ifndef _BUILTIN_H
-#define _BUILTIN_H
-
-#include <subcmd/parse-options.h>
-
-extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
-
-extern int cmd_check(int argc, const char **argv);
-extern int cmd_orc(int argc, const char **argv);
-
-#endif /* _BUILTIN_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
deleted file mode 100644
index c7c59c6..0000000
--- a/tools/objtool/cfi.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _OBJTOOL_CFI_H
-#define _OBJTOOL_CFI_H
-
-#include "cfi_regs.h"
-
-#define CFI_UNDEFINED		-1
-#define CFI_CFA			-2
-#define CFI_SP_INDIRECT		-3
-#define CFI_BP_INDIRECT		-4
-
-struct cfi_reg {
-	int base;
-	int offset;
-};
-
-struct cfi_init_state {
-	struct cfi_reg regs[CFI_NUM_REGS];
-	struct cfi_reg cfa;
-};
-
-struct cfi_state {
-	struct cfi_reg regs[CFI_NUM_REGS];
-	struct cfi_reg vals[CFI_NUM_REGS];
-	struct cfi_reg cfa;
-	int stack_size;
-	int drap_reg, drap_offset;
-	unsigned char type;
-	bool bp_scratch;
-	bool drap;
-	bool end;
-};
-
-#endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f48430d..f50ffa2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -6,14 +6,14 @@
 #include <string.h>
 #include <stdlib.h>
 
-#include "builtin.h"
-#include "cfi.h"
-#include "arch.h"
-#include "check.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_elf.h"
-#include "endianness.h"
+#include <arch/elf.h>
+#include <objtool/builtin.h>
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
+#include <objtool/check.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 #include <linux/objtool.h>
 #include <linux/hashtable.h>
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
deleted file mode 100644
index 5ec00a4..0000000
--- a/tools/objtool/check.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _CHECK_H
-#define _CHECK_H
-
-#include <stdbool.h>
-#include "cfi.h"
-#include "arch.h"
-
-struct insn_state {
-	struct cfi_state cfi;
-	unsigned int uaccess_stack;
-	bool uaccess;
-	bool df;
-	bool noinstr;
-	s8 instr;
-};
-
-struct instruction {
-	struct list_head list;
-	struct hlist_node hash;
-	struct list_head static_call_node;
-	struct section *sec;
-	unsigned long offset;
-	unsigned int len;
-	enum insn_type type;
-	unsigned long immediate;
-	bool dead_end, ignore, ignore_alts;
-	bool hint;
-	bool retpoline_safe;
-	s8 instr;
-	u8 visited;
-	u8 ret_offset;
-	int alt_group;
-	struct symbol *call_dest;
-	struct instruction *jump_dest;
-	struct instruction *first_jump_src;
-	struct reloc *jump_table;
-	struct list_head alts;
-	struct symbol *func;
-	struct list_head stack_ops;
-	struct cfi_state cfi;
-#ifdef INSN_USE_ORC
-	struct orc_entry orc;
-#endif
-};
-
-static inline bool is_static_jump(struct instruction *insn)
-{
-	return insn->type == INSN_JUMP_CONDITIONAL ||
-	       insn->type == INSN_JUMP_UNCONDITIONAL;
-}
-
-struct instruction *find_insn(struct objtool_file *file,
-			      struct section *sec, unsigned long offset);
-
-#define for_each_insn(file, insn)					\
-	list_for_each_entry(insn, &file->insn_list, list)
-
-#define sec_for_each_insn(file, sec, insn)				\
-	for (insn = find_insn(file, sec, 0);				\
-	     insn && &insn->list != &file->insn_list &&			\
-			insn->sec == sec;				\
-	     insn = list_next_entry(insn, list))
-
-#endif /* _CHECK_H */
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5c0341b..6a54ba7 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -15,10 +15,10 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
-#include "builtin.h"
+#include <objtool/builtin.h>
 
-#include "elf.h"
-#include "warn.h"
+#include <objtool/elf.h>
+#include <objtool/warn.h>
 
 #define MAX_NAME_LEN 128
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
deleted file mode 100644
index 807f8c6..0000000
--- a/tools/objtool/elf.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _OBJTOOL_ELF_H
-#define _OBJTOOL_ELF_H
-
-#include <stdio.h>
-#include <gelf.h>
-#include <linux/list.h>
-#include <linux/hashtable.h>
-#include <linux/rbtree.h>
-#include <linux/jhash.h>
-
-#ifdef LIBELF_USE_DEPRECATED
-# define elf_getshdrnum    elf_getshnum
-# define elf_getshdrstrndx elf_getshstrndx
-#endif
-
-/*
- * Fallback for systems without this "read, mmaping if possible" cmd.
- */
-#ifndef ELF_C_READ_MMAP
-#define ELF_C_READ_MMAP ELF_C_READ
-#endif
-
-struct section {
-	struct list_head list;
-	struct hlist_node hash;
-	struct hlist_node name_hash;
-	GElf_Shdr sh;
-	struct rb_root symbol_tree;
-	struct list_head symbol_list;
-	struct list_head reloc_list;
-	struct section *base, *reloc;
-	struct symbol *sym;
-	Elf_Data *data;
-	char *name;
-	int idx;
-	unsigned int len;
-	bool changed, text, rodata, noinstr;
-};
-
-struct symbol {
-	struct list_head list;
-	struct rb_node node;
-	struct hlist_node hash;
-	struct hlist_node name_hash;
-	GElf_Sym sym;
-	struct section *sec;
-	char *name;
-	unsigned int idx;
-	unsigned char bind, type;
-	unsigned long offset;
-	unsigned int len;
-	struct symbol *pfunc, *cfunc, *alias;
-	bool uaccess_safe;
-	bool static_call_tramp;
-};
-
-struct reloc {
-	struct list_head list;
-	struct hlist_node hash;
-	union {
-		GElf_Rela rela;
-		GElf_Rel  rel;
-	};
-	struct section *sec;
-	struct symbol *sym;
-	unsigned long offset;
-	unsigned int type;
-	int addend;
-	int idx;
-	bool jump_table_start;
-};
-
-#define ELF_HASH_BITS	20
-
-struct elf {
-	Elf *elf;
-	GElf_Ehdr ehdr;
-	int fd;
-	bool changed;
-	char *name;
-	struct list_head sections;
-	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(reloc_hash, ELF_HASH_BITS);
-};
-
-#define OFFSET_STRIDE_BITS	4
-#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
-#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
-
-#define for_offset_range(_offset, _start, _end)			\
-	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
-	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
-	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
-	     _offset += OFFSET_STRIDE)
-
-static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
-{
-	u32 ol, oh, idx = sec->idx;
-
-	offset &= OFFSET_STRIDE_MASK;
-
-	ol = offset;
-	oh = (offset >> 16) >> 16;
-
-	__jhash_mix(ol, oh, idx);
-
-	return ol;
-}
-
-static inline u32 reloc_hash(struct reloc *reloc)
-{
-	return sec_offset_hash(reloc->sec, reloc->offset);
-}
-
-struct elf *elf_open_read(const char *name, int flags);
-struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
-struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
-void elf_add_reloc(struct elf *elf, struct reloc *reloc);
-int elf_write_insn(struct elf *elf, struct section *sec,
-		   unsigned long offset, unsigned int len,
-		   const char *insn);
-int elf_write_reloc(struct elf *elf, struct reloc *reloc);
-int elf_write(struct elf *elf);
-void elf_close(struct elf *elf);
-
-struct section *find_section_by_name(const struct elf *elf, const char *name);
-struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
-struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
-struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
-struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
-struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
-struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
-				     unsigned long offset, unsigned int len);
-struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
-
-#define for_each_sec(file, sec)						\
-	list_for_each_entry(sec, &file->elf->sections, list)
-
-#endif /* _OBJTOOL_ELF_H */
diff --git a/tools/objtool/endianness.h b/tools/objtool/endianness.h
deleted file mode 100644
index ebece31..0000000
--- a/tools/objtool/endianness.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _OBJTOOL_ENDIANNESS_H
-#define _OBJTOOL_ENDIANNESS_H
-
-#include <linux/kernel.h>
-#include <endian.h>
-#include "arch_endianness.h"
-
-#ifndef __TARGET_BYTE_ORDER
-#error undefined arch __TARGET_BYTE_ORDER
-#endif
-
-#if __BYTE_ORDER != __TARGET_BYTE_ORDER
-#define __NEED_BSWAP 1
-#else
-#define __NEED_BSWAP 0
-#endif
-
-/*
- * Does a byte swap if target endianness doesn't match the host, i.e. cross
- * compilation for little endian on big endian and vice versa.
- * To be used for multi-byte values conversion, which are read from / about
- * to be written to a target native endianness ELF file.
- */
-#define bswap_if_needed(val)						\
-({									\
-	__typeof__(val) __ret;						\
-	switch (sizeof(val)) {						\
-	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
-	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
-	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
-	default:							\
-		BUILD_BUG(); break;					\
-	}								\
-	__ret;								\
-})
-
-#endif /* _OBJTOOL_ENDIANNESS_H */
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
new file mode 100644
index 0000000..dc4f503
--- /dev/null
+++ b/tools/objtool/include/objtool/arch.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _ARCH_H
+#define _ARCH_H
+
+#include <stdbool.h>
+#include <linux/list.h>
+#include <objtool/objtool.h>
+#include <objtool/cfi.h>
+
+#ifdef INSN_USE_ORC
+#include <asm/orc_types.h>
+#endif
+
+enum insn_type {
+	INSN_JUMP_CONDITIONAL,
+	INSN_JUMP_UNCONDITIONAL,
+	INSN_JUMP_DYNAMIC,
+	INSN_JUMP_DYNAMIC_CONDITIONAL,
+	INSN_CALL,
+	INSN_CALL_DYNAMIC,
+	INSN_RETURN,
+	INSN_CONTEXT_SWITCH,
+	INSN_BUG,
+	INSN_NOP,
+	INSN_STAC,
+	INSN_CLAC,
+	INSN_STD,
+	INSN_CLD,
+	INSN_OTHER,
+};
+
+enum op_dest_type {
+	OP_DEST_REG,
+	OP_DEST_REG_INDIRECT,
+	OP_DEST_MEM,
+	OP_DEST_PUSH,
+	OP_DEST_PUSHF,
+	OP_DEST_LEAVE,
+};
+
+struct op_dest {
+	enum op_dest_type type;
+	unsigned char reg;
+	int offset;
+};
+
+enum op_src_type {
+	OP_SRC_REG,
+	OP_SRC_REG_INDIRECT,
+	OP_SRC_CONST,
+	OP_SRC_POP,
+	OP_SRC_POPF,
+	OP_SRC_ADD,
+	OP_SRC_AND,
+};
+
+struct op_src {
+	enum op_src_type type;
+	unsigned char reg;
+	int offset;
+};
+
+struct stack_op {
+	struct op_dest dest;
+	struct op_src src;
+	struct list_head list;
+};
+
+struct instruction;
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state);
+
+int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    unsigned int *len, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list);
+
+bool arch_callee_saved_reg(unsigned char reg);
+
+unsigned long arch_jump_destination(struct instruction *insn);
+
+unsigned long arch_dest_reloc_offset(int addend);
+
+const char *arch_nop_insn(int len);
+
+int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
+
+#endif /* _ARCH_H */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
new file mode 100644
index 0000000..85c979c
--- /dev/null
+++ b/tools/objtool/include/objtool/builtin.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+#ifndef _BUILTIN_H
+#define _BUILTIN_H
+
+#include <subcmd/parse-options.h>
+
+extern const struct option check_options[];
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+
+extern int cmd_check(int argc, const char **argv);
+extern int cmd_orc(int argc, const char **argv);
+
+#endif /* _BUILTIN_H */
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
new file mode 100644
index 0000000..fd5cb0b
--- /dev/null
+++ b/tools/objtool/include/objtool/cfi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _OBJTOOL_CFI_H
+#define _OBJTOOL_CFI_H
+
+#include <arch/cfi_regs.h>
+
+#define CFI_UNDEFINED		-1
+#define CFI_CFA			-2
+#define CFI_SP_INDIRECT		-3
+#define CFI_BP_INDIRECT		-4
+
+struct cfi_reg {
+	int base;
+	int offset;
+};
+
+struct cfi_init_state {
+	struct cfi_reg regs[CFI_NUM_REGS];
+	struct cfi_reg cfa;
+};
+
+struct cfi_state {
+	struct cfi_reg regs[CFI_NUM_REGS];
+	struct cfi_reg vals[CFI_NUM_REGS];
+	struct cfi_reg cfa;
+	int stack_size;
+	int drap_reg, drap_offset;
+	unsigned char type;
+	bool bp_scratch;
+	bool drap;
+	bool end;
+};
+
+#endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
new file mode 100644
index 0000000..bba1096
--- /dev/null
+++ b/tools/objtool/include/objtool/check.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _CHECK_H
+#define _CHECK_H
+
+#include <stdbool.h>
+#include <objtool/cfi.h>
+#include <objtool/arch.h>
+
+struct insn_state {
+	struct cfi_state cfi;
+	unsigned int uaccess_stack;
+	bool uaccess;
+	bool df;
+	bool noinstr;
+	s8 instr;
+};
+
+struct instruction {
+	struct list_head list;
+	struct hlist_node hash;
+	struct list_head static_call_node;
+	struct section *sec;
+	unsigned long offset;
+	unsigned int len;
+	enum insn_type type;
+	unsigned long immediate;
+	bool dead_end, ignore, ignore_alts;
+	bool hint;
+	bool retpoline_safe;
+	s8 instr;
+	u8 visited;
+	u8 ret_offset;
+	int alt_group;
+	struct symbol *call_dest;
+	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
+	struct reloc *jump_table;
+	struct list_head alts;
+	struct symbol *func;
+	struct list_head stack_ops;
+	struct cfi_state cfi;
+#ifdef INSN_USE_ORC
+	struct orc_entry orc;
+#endif
+};
+
+static inline bool is_static_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_CONDITIONAL ||
+	       insn->type == INSN_JUMP_UNCONDITIONAL;
+}
+
+struct instruction *find_insn(struct objtool_file *file,
+			      struct section *sec, unsigned long offset);
+
+#define for_each_insn(file, insn)					\
+	list_for_each_entry(insn, &file->insn_list, list)
+
+#define sec_for_each_insn(file, sec, insn)				\
+	for (insn = find_insn(file, sec, 0);				\
+	     insn && &insn->list != &file->insn_list &&			\
+			insn->sec == sec;				\
+	     insn = list_next_entry(insn, list))
+
+#endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
new file mode 100644
index 0000000..807f8c6
--- /dev/null
+++ b/tools/objtool/include/objtool/elf.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _OBJTOOL_ELF_H
+#define _OBJTOOL_ELF_H
+
+#include <stdio.h>
+#include <gelf.h>
+#include <linux/list.h>
+#include <linux/hashtable.h>
+#include <linux/rbtree.h>
+#include <linux/jhash.h>
+
+#ifdef LIBELF_USE_DEPRECATED
+# define elf_getshdrnum    elf_getshnum
+# define elf_getshdrstrndx elf_getshstrndx
+#endif
+
+/*
+ * Fallback for systems without this "read, mmaping if possible" cmd.
+ */
+#ifndef ELF_C_READ_MMAP
+#define ELF_C_READ_MMAP ELF_C_READ
+#endif
+
+struct section {
+	struct list_head list;
+	struct hlist_node hash;
+	struct hlist_node name_hash;
+	GElf_Shdr sh;
+	struct rb_root symbol_tree;
+	struct list_head symbol_list;
+	struct list_head reloc_list;
+	struct section *base, *reloc;
+	struct symbol *sym;
+	Elf_Data *data;
+	char *name;
+	int idx;
+	unsigned int len;
+	bool changed, text, rodata, noinstr;
+};
+
+struct symbol {
+	struct list_head list;
+	struct rb_node node;
+	struct hlist_node hash;
+	struct hlist_node name_hash;
+	GElf_Sym sym;
+	struct section *sec;
+	char *name;
+	unsigned int idx;
+	unsigned char bind, type;
+	unsigned long offset;
+	unsigned int len;
+	struct symbol *pfunc, *cfunc, *alias;
+	bool uaccess_safe;
+	bool static_call_tramp;
+};
+
+struct reloc {
+	struct list_head list;
+	struct hlist_node hash;
+	union {
+		GElf_Rela rela;
+		GElf_Rel  rel;
+	};
+	struct section *sec;
+	struct symbol *sym;
+	unsigned long offset;
+	unsigned int type;
+	int addend;
+	int idx;
+	bool jump_table_start;
+};
+
+#define ELF_HASH_BITS	20
+
+struct elf {
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	int fd;
+	bool changed;
+	char *name;
+	struct list_head sections;
+	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
+	DECLARE_HASHTABLE(reloc_hash, ELF_HASH_BITS);
+};
+
+#define OFFSET_STRIDE_BITS	4
+#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
+#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
+
+#define for_offset_range(_offset, _start, _end)			\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
+	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
+	     _offset += OFFSET_STRIDE)
+
+static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
+{
+	u32 ol, oh, idx = sec->idx;
+
+	offset &= OFFSET_STRIDE_MASK;
+
+	ol = offset;
+	oh = (offset >> 16) >> 16;
+
+	__jhash_mix(ol, oh, idx);
+
+	return ol;
+}
+
+static inline u32 reloc_hash(struct reloc *reloc)
+{
+	return sec_offset_hash(reloc->sec, reloc->offset);
+}
+
+struct elf *elf_open_read(const char *name, int flags);
+struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
+struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
+void elf_add_reloc(struct elf *elf, struct reloc *reloc);
+int elf_write_insn(struct elf *elf, struct section *sec,
+		   unsigned long offset, unsigned int len,
+		   const char *insn);
+int elf_write_reloc(struct elf *elf, struct reloc *reloc);
+int elf_write(struct elf *elf);
+void elf_close(struct elf *elf);
+
+struct section *find_section_by_name(const struct elf *elf, const char *name);
+struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
+struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
+struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
+struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
+				     unsigned long offset, unsigned int len);
+struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
+
+#define for_each_sec(file, sec)						\
+	list_for_each_entry(sec, &file->elf->sections, list)
+
+#endif /* _OBJTOOL_ELF_H */
diff --git a/tools/objtool/include/objtool/endianness.h b/tools/objtool/include/objtool/endianness.h
new file mode 100644
index 0000000..1024134
--- /dev/null
+++ b/tools/objtool/include/objtool/endianness.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ENDIANNESS_H
+#define _OBJTOOL_ENDIANNESS_H
+
+#include <arch/endianness.h>
+#include <linux/kernel.h>
+#include <endian.h>
+
+#ifndef __TARGET_BYTE_ORDER
+#error undefined arch __TARGET_BYTE_ORDER
+#endif
+
+#if __BYTE_ORDER != __TARGET_BYTE_ORDER
+#define __NEED_BSWAP 1
+#else
+#define __NEED_BSWAP 0
+#endif
+
+/*
+ * Does a byte swap if target endianness doesn't match the host, i.e. cross
+ * compilation for little endian on big endian and vice versa.
+ * To be used for multi-byte values conversion, which are read from / about
+ * to be written to a target native endianness ELF file.
+ */
+#define bswap_if_needed(val)						\
+({									\
+	__typeof__(val) __ret;						\
+	switch (sizeof(val)) {						\
+	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
+	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
+	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
+	default:							\
+		BUILD_BUG(); break;					\
+	}								\
+	__ret;								\
+})
+
+#endif /* _OBJTOOL_ENDIANNESS_H */
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
new file mode 100644
index 0000000..32f4cd1
--- /dev/null
+++ b/tools/objtool/include/objtool/objtool.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
+ */
+
+#ifndef _OBJTOOL_H
+#define _OBJTOOL_H
+
+#include <stdbool.h>
+#include <linux/list.h>
+#include <linux/hashtable.h>
+
+#include <objtool/elf.h>
+
+#define __weak __attribute__((weak))
+
+struct objtool_file {
+	struct elf *elf;
+	struct list_head insn_list;
+	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head static_call_list;
+	bool ignore_unreachables, c_file, hints, rodata;
+};
+
+struct objtool_file *objtool_open_read(const char *_objname);
+
+int check(struct objtool_file *file);
+int orc_dump(const char *objname);
+int create_orc(struct objtool_file *file);
+int create_orc_sections(struct objtool_file *file);
+
+#endif /* _OBJTOOL_H */
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
new file mode 100644
index 0000000..8a09f4e
--- /dev/null
+++ b/tools/objtool/include/objtool/special.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _SPECIAL_H
+#define _SPECIAL_H
+
+#include <stdbool.h>
+#include <objtool/check.h>
+#include <objtool/elf.h>
+
+#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
+
+struct special_alt {
+	struct list_head list;
+
+	bool group;
+	bool skip_orig;
+	bool skip_alt;
+	bool jump_or_nop;
+
+	struct section *orig_sec;
+	unsigned long orig_off;
+
+	struct section *new_sec;
+	unsigned long new_off;
+
+	unsigned int orig_len, new_len; /* group only */
+};
+
+int special_get_alts(struct elf *elf, struct list_head *alts);
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc);
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				    struct instruction *insn);
+#endif /* _SPECIAL_H */
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
new file mode 100644
index 0000000..d99c467
--- /dev/null
+++ b/tools/objtool/include/objtool/warn.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#ifndef _WARN_H
+#define _WARN_H
+
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <objtool/elf.h>
+
+extern const char *objname;
+
+static inline char *offstr(struct section *sec, unsigned long offset)
+{
+	struct symbol *func;
+	char *name, *str;
+	unsigned long name_off;
+
+	func = find_func_containing(sec, offset);
+	if (func) {
+		name = func->name;
+		name_off = offset - func->offset;
+	} else {
+		name = sec->name;
+		name_off = offset;
+	}
+
+	str = malloc(strlen(name) + 20);
+
+	if (func)
+		sprintf(str, "%s()+0x%lx", name, name_off);
+	else
+		sprintf(str, "%s+0x%lx", name, name_off);
+
+	return str;
+}
+
+#define WARN(format, ...)				\
+	fprintf(stderr,					\
+		"%s: warning: objtool: " format "\n",	\
+		objname, ##__VA_ARGS__)
+
+#define WARN_FUNC(format, sec, offset, ...)		\
+({							\
+	char *_str = offstr(sec, offset);		\
+	WARN("%s: " format, _str, ##__VA_ARGS__);	\
+	free(_str);					\
+})
+
+#define BT_FUNC(format, insn, ...)			\
+({							\
+	struct instruction *_insn = (insn);		\
+	char *_str = offstr(_insn->sec, _insn->offset); \
+	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
+	free(_str);					\
+})
+
+#define WARN_ELF(format, ...)				\
+	WARN(format ": %s", ##__VA_ARGS__, elf_errmsg(-1))
+
+#endif /* _WARN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 9df0cd8..e848feb 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -21,9 +21,9 @@
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
 
-#include "builtin.h"
-#include "objtool.h"
-#include "warn.h"
+#include <objtool/builtin.h>
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
 
 struct cmd_struct {
 	const char *name;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
deleted file mode 100644
index 4125d45..0000000
--- a/tools/objtool/objtool.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
- */
-
-#ifndef _OBJTOOL_H
-#define _OBJTOOL_H
-
-#include <stdbool.h>
-#include <linux/list.h>
-#include <linux/hashtable.h>
-
-#include "elf.h"
-
-#define __weak __attribute__((weak))
-
-struct objtool_file {
-	struct elf *elf;
-	struct list_head insn_list;
-	DECLARE_HASHTABLE(insn_hash, 20);
-	struct list_head static_call_list;
-	bool ignore_unreachables, c_file, hints, rodata;
-};
-
-struct objtool_file *objtool_open_read(const char *_objname);
-
-int check(struct objtool_file *file);
-int orc_dump(const char *objname);
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
-
-#endif /* _OBJTOOL_H */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 4e818a2..c53fae9 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -6,9 +6,9 @@
 #include <unistd.h>
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
-#include "objtool.h"
-#include "warn.h"
-#include "endianness.h"
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 static const char *reg_name(unsigned int reg)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 134d786..8a56cb5 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,9 +9,9 @@
 #include <linux/objtool.h>
 #include <asm/orc_types.h>
 
-#include "check.h"
-#include "warn.h"
-#include "endianness.h"
+#include <objtool/check.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 int create_orc(struct objtool_file *file)
 {
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index ab7cb1e..2c7fbda 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -11,11 +11,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "builtin.h"
-#include "special.h"
-#include "warn.h"
-#include "arch_special.h"
-#include "endianness.h"
+#include <arch/special.h>
+#include <objtool/builtin.h>
+#include <objtool/special.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
 
 struct special_entry {
 	const char *sec;
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
deleted file mode 100644
index abddf38..0000000
--- a/tools/objtool/special.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _SPECIAL_H
-#define _SPECIAL_H
-
-#include <stdbool.h>
-#include "check.h"
-#include "elf.h"
-
-#define C_JUMP_TABLE_SECTION ".rodata..c_jump_table"
-
-struct special_alt {
-	struct list_head list;
-
-	bool group;
-	bool skip_orig;
-	bool skip_alt;
-	bool jump_or_nop;
-
-	struct section *orig_sec;
-	unsigned long orig_off;
-
-	struct section *new_sec;
-	unsigned long new_off;
-
-	unsigned int orig_len, new_len; /* group only */
-};
-
-int special_get_alts(struct elf *elf, struct list_head *alts);
-
-void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
-
-bool arch_support_alt_relocation(struct special_alt *special_alt,
-				 struct instruction *insn,
-				 struct reloc *reloc);
-struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn);
-#endif /* _SPECIAL_H */
diff --git a/tools/objtool/warn.h b/tools/objtool/warn.h
deleted file mode 100644
index 7799f60..0000000
--- a/tools/objtool/warn.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-#ifndef _WARN_H
-#define _WARN_H
-
-#include <stdlib.h>
-#include <string.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include "elf.h"
-
-extern const char *objname;
-
-static inline char *offstr(struct section *sec, unsigned long offset)
-{
-	struct symbol *func;
-	char *name, *str;
-	unsigned long name_off;
-
-	func = find_func_containing(sec, offset);
-	if (func) {
-		name = func->name;
-		name_off = offset - func->offset;
-	} else {
-		name = sec->name;
-		name_off = offset;
-	}
-
-	str = malloc(strlen(name) + 20);
-
-	if (func)
-		sprintf(str, "%s()+0x%lx", name, name_off);
-	else
-		sprintf(str, "%s+0x%lx", name, name_off);
-
-	return str;
-}
-
-#define WARN(format, ...)				\
-	fprintf(stderr,					\
-		"%s: warning: objtool: " format "\n",	\
-		objname, ##__VA_ARGS__)
-
-#define WARN_FUNC(format, sec, offset, ...)		\
-({							\
-	char *_str = offstr(sec, offset);		\
-	WARN("%s: " format, _str, ##__VA_ARGS__);	\
-	free(_str);					\
-})
-
-#define BT_FUNC(format, insn, ...)			\
-({							\
-	struct instruction *_insn = (insn);		\
-	char *_str = offstr(_insn->sec, _insn->offset); \
-	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-	free(_str);					\
-})
-
-#define WARN_ELF(format, ...)				\
-	WARN(format ": %s", ##__VA_ARGS__, elf_errmsg(-1))
-
-#endif /* _WARN_H */
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 7843e9a..f271682 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -7,7 +7,7 @@
 
 #include <stdbool.h>
 #include <errno.h>
-#include "objtool.h"
+#include <objtool/objtool.h>
 
 #define UNSUPPORTED(name)						\
 ({									\
