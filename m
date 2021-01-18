Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB642FABFD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389770AbhARU7C (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 15:59:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbhARKOj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:39 -0500
Date:   Mon, 18 Jan 2021 10:13:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AhkYn2QuyyYwJzJtxxf+DkDOEIbGqO8iwnytR3BvJwA=;
        b=UkK3vH5NgARdsNcB/RcVXpLUJjXEDoRDBzDVohg6E//XD2GHO5h2RCDVFqHAn77ZJp6e1d
        FIVJdOeKvicTkndJkTMMPHO21IvFZrZWX846HbzkfEbihuTSEA/8m89gFGvXQPItB8L+IC
        m534asAwlQc1smWU8nEbwGZLbl8Vn8RgBn8nha7tPVfB5lYhAbkiIt3Z8Zl6xkWVUvuUwR
        wvK7gS4nwhkdmcfw1d45pBH2nkpRlDFkWWCx5pgxqxfF+EPpxBQldeNFdsqLI+3U6IJiS0
        +S7J+E+8iUng0MnBjRX72Mm1uRJzQ4YdBc5O+0pyJ4YWJF8prDfdw0CMwujpgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AhkYn2QuyyYwJzJtxxf+DkDOEIbGqO8iwnytR3BvJwA=;
        b=5vqJE3WB+uDBex0SuNuNQvoocRYtsiChu3LWgg5X32wXvJcLmFV1h4HjI2phQwE4V/CkiK
        LjQYry1V+8TwgQCw==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix x86 orc generation on big endian
 cross-compiles
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481157.414.13771472378803689415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8bfe273238d77d3cee18e4c03b2f26ae360b5661
Gitweb:        https://git.kernel.org/tip/8bfe273238d77d3cee18e4c03b2f26ae360b5661
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Fri, 13 Nov 2020 00:03:29 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:13 -06:00

objtool: Fix x86 orc generation on big endian cross-compiles

Correct objtool orc generation endianness problems to enable fully
functional x86 cross-compiles on big endian hardware.

Introduce bswap_if_needed() macro, which does a byte swap if target
endianness doesn't match the host, i.e. cross-compilation for little
endian on big endian and vice versa.  The macro is used for conversion
of multi-byte values which are read from / about to be written to a
target native endianness ELF file.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/orc_types.h                 | 10 ++++-
 tools/arch/x86/include/asm/orc_types.h           | 10 ++++-
 tools/objtool/arch/x86/include/arch_endianness.h |  9 ++++-
 tools/objtool/check.c                            |  5 +-
 tools/objtool/endianness.h                       | 38 +++++++++++++++-
 tools/objtool/orc_dump.c                         |  5 +-
 tools/objtool/orc_gen.c                          |  3 +-
 tools/objtool/special.c                          |  6 +-
 8 files changed, 80 insertions(+), 6 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_endianness.h
 create mode 100644 tools/objtool/endianness.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index fdbffec..5a2baf2 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index fdbffec..5a2baf2 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -40,6 +40,8 @@
 #define ORC_REG_MAX			15
 
 #ifndef __ASSEMBLY__
+#include <asm/byteorder.h>
+
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
  * Frame Information standard.  It contains only the necessary parts of DWARF
@@ -51,10 +53,18 @@
 struct orc_entry {
 	s16		sp_offset;
 	s16		bp_offset;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
 	unsigned	end:1;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	unsigned	bp_reg:4;
+	unsigned	sp_reg:4;
+	unsigned	unused:5;
+	unsigned	end:1;
+	unsigned	type:2;
+#endif
 } __packed;
 
 #endif /* __ASSEMBLY__ */
diff --git a/tools/objtool/arch/x86/include/arch_endianness.h b/tools/objtool/arch/x86/include/arch_endianness.h
new file mode 100644
index 0000000..7c36252
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_endianness.h
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 270adc3..8cda0ef 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -13,6 +13,7 @@
 #include "special.h"
 #include "warn.h"
 #include "arch_elf.h"
+#include "endianness.h"
 
 #include <linux/objtool.h>
 #include <linux/hashtable.h>
@@ -1435,7 +1436,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		cfa = &insn->cfi.cfa;
 
 		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
+			insn->ret_offset = bswap_if_needed(hint->sp_offset);
 			continue;
 		}
 
@@ -1447,7 +1448,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa->offset = hint->sp_offset;
+		cfa->offset = bswap_if_needed(hint->sp_offset);
 		insn->cfi.type = hint->type;
 		insn->cfi.end = hint->end;
 	}
diff --git a/tools/objtool/endianness.h b/tools/objtool/endianness.h
new file mode 100644
index 0000000..ebece31
--- /dev/null
+++ b/tools/objtool/endianness.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ENDIANNESS_H
+#define _OBJTOOL_ENDIANNESS_H
+
+#include <linux/kernel.h>
+#include <endian.h>
+#include "arch_endianness.h"
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
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 5e6a953..4e818a2 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -8,6 +8,7 @@
 #include <asm/orc_types.h>
 #include "objtool.h"
 #include "warn.h"
+#include "endianness.h"
 
 static const char *reg_name(unsigned int reg)
 {
@@ -197,11 +198,11 @@ int orc_dump(const char *_objname)
 
 		printf(" sp:");
 
-		print_reg(orc[i].sp_reg, orc[i].sp_offset);
+		print_reg(orc[i].sp_reg, bswap_if_needed(orc[i].sp_offset));
 
 		printf(" bp:");
 
-		print_reg(orc[i].bp_reg, orc[i].bp_offset);
+		print_reg(orc[i].bp_reg, bswap_if_needed(orc[i].bp_offset));
 
 		printf(" type:%s end:%d\n",
 		       orc_type_name(orc[i].type), orc[i].end);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 9ce68b3..1be7e16 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -11,6 +11,7 @@
 
 #include "check.h"
 #include "warn.h"
+#include "endianness.h"
 
 int create_orc(struct objtool_file *file)
 {
@@ -96,6 +97,8 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
+	orc->sp_offset = bswap_if_needed(orc->sp_offset);
+	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
 	reloc = malloc(sizeof(*reloc));
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 1a2420f..ab7cb1e 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -15,6 +15,7 @@
 #include "special.h"
 #include "warn.h"
 #include "arch_special.h"
+#include "endianness.h"
 
 struct special_entry {
 	const char *sec;
@@ -77,8 +78,9 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 	if (entry->feature) {
 		unsigned short feature;
 
-		feature = *(unsigned short *)(sec->data->d_buf + offset +
-					      entry->feature);
+		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
+							      offset +
+							      entry->feature));
 		arch_handle_alternative(feature, alt);
 	}
 
