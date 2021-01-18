Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBC2FAC06
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394387AbhARVAb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 16:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbhARKOh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA997C061575;
        Mon, 18 Jan 2021 02:13:32 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TwV6gE59leyLLdqT2Hjs/wCZn6Xmcj+o8gdg4P+pbA0=;
        b=SeO/+kiUZAHT4E+k0ndD2dgjMdOvbAtcHSZa8x43gbocluhmp+AD1Q6TmyR4GIw0ijXYcw
        VBsOrizrzxRMM0n6U68PNjEkaKBL/3jFDBBExojeiIkU3nvF3vZpBDvuYjb59ZUAlct6YA
        hrWZQpmUmyrPU7PGu4ji8NTuQSmmS2hR4erA2D56hDrU4t2WQDo8ICXJL3xJtPTiL1EdBX
        vKXqYisCREikDj7yrzZQOw/DKtfSZ6SxXLwlf6+pTGwHyFD8AbF/dmXOtk3JvYRrFOPJEa
        fd2i8m38ntTwTPz4df2sQ1+aLtMvslJvUBJ8l/CoSpMePHvNE9MdPTrEp2jb1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TwV6gE59leyLLdqT2Hjs/wCZn6Xmcj+o8gdg4P+pbA0=;
        b=8asCzAVjW56Ji+GhJdvzO20Z55zslCOtfF+xpcdzq69EKBw1EYesGuPzHPFy1eKBFjKO2i
        z6F0cjlA7EHhy0BQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Refactor ORC section generation
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481052.414.11804292955363883067.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ab4e0744e99b87e1a223e89fc3c9ae44f727c9a6
Gitweb:        https://git.kernel.org/tip/ab4e0744e99b87e1a223e89fc3c9ae44f727c9a6
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 17 Dec 2020 15:02:42 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 14 Jan 2021 09:53:42 -06:00

objtool: Refactor ORC section generation

Decouple ORC entries from instructions.  This simplifies the
control/data flow, and is going to make it easier to support alternative
instructions which change the stack layout.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile                  |   4 +-
 tools/objtool/builtin-orc.c             |   6 +-
 tools/objtool/include/objtool/arch.h    |   4 +-
 tools/objtool/include/objtool/check.h   |   3 +-
 tools/objtool/include/objtool/objtool.h |   3 +-
 tools/objtool/orc_gen.c                 | 272 +++++++++++------------
 tools/objtool/weak.c                    |   7 +-
 7 files changed, 140 insertions(+), 159 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index d179299..92ce4fc 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -47,10 +47,6 @@ ifeq ($(SRCARCH),x86)
 	SUBCMD_ORC := y
 endif
 
-ifeq ($(SUBCMD_ORC),y)
-	CFLAGS += -DINSN_USE_ORC
-endif
-
 export SUBCMD_CHECK SUBCMD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 6745f33..8273bbf 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -51,11 +51,7 @@ int cmd_orc(int argc, const char **argv)
 		if (list_empty(&file->insn_list))
 			return 0;
 
-		ret = create_orc(file);
-		if (ret)
-			return ret;
-
-		ret = create_orc_sections(file);
+		ret = orc_create(file);
 		if (ret)
 			return ret;
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index dc4f503..6ff0685 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -11,10 +11,6 @@
 #include <objtool/objtool.h>
 #include <objtool/cfi.h>
 
-#ifdef INSN_USE_ORC
-#include <asm/orc_types.h>
-#endif
-
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index bba1096..df1e3e8 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -43,9 +43,6 @@ struct instruction {
 	struct symbol *func;
 	struct list_head stack_ops;
 	struct cfi_state cfi;
-#ifdef INSN_USE_ORC
-	struct orc_entry orc;
-#endif
 };
 
 static inline bool is_static_jump(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 32f4cd1..e114642 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -26,7 +26,6 @@ struct objtool_file *objtool_open_read(const char *_objname);
 
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
+int orc_create(struct objtool_file *file);
 
 #endif /* _OBJTOOL_H */
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 2e5fb78..38e1a8d 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -13,89 +13,84 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-int create_orc(struct objtool_file *file)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
 {
-	struct instruction *insn;
+	struct instruction *insn = container_of(cfi, struct instruction, cfi);
+	struct cfi_reg *bp = &cfi->regs[CFI_BP];
 
-	for_each_insn(file, insn) {
-		struct orc_entry *orc = &insn->orc;
-		struct cfi_reg *cfa = &insn->cfi.cfa;
-		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
+	memset(orc, 0, sizeof(*orc));
 
-		if (!insn->sec->text)
-			continue;
-
-		orc->end = insn->cfi.end;
+	orc->end = cfi->end;
 
-		if (cfa->base == CFI_UNDEFINED) {
-			orc->sp_reg = ORC_REG_UNDEFINED;
-			continue;
-		}
-
-		switch (cfa->base) {
-		case CFI_SP:
-			orc->sp_reg = ORC_REG_SP;
-			break;
-		case CFI_SP_INDIRECT:
-			orc->sp_reg = ORC_REG_SP_INDIRECT;
-			break;
-		case CFI_BP:
-			orc->sp_reg = ORC_REG_BP;
-			break;
-		case CFI_BP_INDIRECT:
-			orc->sp_reg = ORC_REG_BP_INDIRECT;
-			break;
-		case CFI_R10:
-			orc->sp_reg = ORC_REG_R10;
-			break;
-		case CFI_R13:
-			orc->sp_reg = ORC_REG_R13;
-			break;
-		case CFI_DI:
-			orc->sp_reg = ORC_REG_DI;
-			break;
-		case CFI_DX:
-			orc->sp_reg = ORC_REG_DX;
-			break;
-		default:
-			WARN_FUNC("unknown CFA base reg %d",
-				  insn->sec, insn->offset, cfa->base);
-			return -1;
-		}
+	if (cfi->cfa.base == CFI_UNDEFINED) {
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
 
-		switch(bp->base) {
-		case CFI_UNDEFINED:
-			orc->bp_reg = ORC_REG_UNDEFINED;
-			break;
-		case CFI_CFA:
-			orc->bp_reg = ORC_REG_PREV_SP;
-			break;
-		case CFI_BP:
-			orc->bp_reg = ORC_REG_BP;
-			break;
-		default:
-			WARN_FUNC("unknown BP base reg %d",
-				  insn->sec, insn->offset, bp->base);
-			return -1;
-		}
+	switch (cfi->cfa.base) {
+	case CFI_SP:
+		orc->sp_reg = ORC_REG_SP;
+		break;
+	case CFI_SP_INDIRECT:
+		orc->sp_reg = ORC_REG_SP_INDIRECT;
+		break;
+	case CFI_BP:
+		orc->sp_reg = ORC_REG_BP;
+		break;
+	case CFI_BP_INDIRECT:
+		orc->sp_reg = ORC_REG_BP_INDIRECT;
+		break;
+	case CFI_R10:
+		orc->sp_reg = ORC_REG_R10;
+		break;
+	case CFI_R13:
+		orc->sp_reg = ORC_REG_R13;
+		break;
+	case CFI_DI:
+		orc->sp_reg = ORC_REG_DI;
+		break;
+	case CFI_DX:
+		orc->sp_reg = ORC_REG_DX;
+		break;
+	default:
+		WARN_FUNC("unknown CFA base reg %d",
+			  insn->sec, insn->offset, cfi->cfa.base);
+		return -1;
+	}
 
-		orc->sp_offset = cfa->offset;
-		orc->bp_offset = bp->offset;
-		orc->type = insn->cfi.type;
+	switch (bp->base) {
+	case CFI_UNDEFINED:
+		orc->bp_reg = ORC_REG_UNDEFINED;
+		break;
+	case CFI_CFA:
+		orc->bp_reg = ORC_REG_PREV_SP;
+		break;
+	case CFI_BP:
+		orc->bp_reg = ORC_REG_BP;
+		break;
+	default:
+		WARN_FUNC("unknown BP base reg %d",
+			  insn->sec, insn->offset, bp->base);
+		return -1;
 	}
 
+	orc->sp_offset = cfi->cfa.offset;
+	orc->bp_offset = bp->offset;
+	orc->type = cfi->type;
+
 	return 0;
 }
 
-static int create_orc_entry(struct elf *elf, struct section *u_sec, struct section *ip_relocsec,
-				unsigned int idx, struct section *insn_sec,
-				unsigned long insn_off, struct orc_entry *o)
+static int write_orc_entry(struct elf *elf, struct section *orc_sec,
+			   struct section *ip_rsec, unsigned int idx,
+			   struct section *insn_sec, unsigned long insn_off,
+			   struct orc_entry *o)
 {
 	struct orc_entry *orc;
 	struct reloc *reloc;
 
 	/* populate ORC data */
-	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
+	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
 	orc->sp_offset = bswap_if_needed(orc->sp_offset);
 	orc->bp_offset = bswap_if_needed(orc->bp_offset);
@@ -117,102 +112,109 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 
 	reloc->type = R_X86_64_PC32;
 	reloc->offset = idx * sizeof(int);
-	reloc->sec = ip_relocsec;
+	reloc->sec = ip_rsec;
 
 	elf_add_reloc(elf, reloc);
 
 	return 0;
 }
 
-int create_orc_sections(struct objtool_file *file)
+struct orc_list_entry {
+	struct list_head list;
+	struct orc_entry orc;
+	struct section *insn_sec;
+	unsigned long insn_off;
+};
+
+static int orc_list_add(struct list_head *orc_list, struct orc_entry *orc,
+			struct section *sec, unsigned long offset)
+{
+	struct orc_list_entry *entry = malloc(sizeof(*entry));
+
+	if (!entry) {
+		WARN("malloc failed");
+		return -1;
+	}
+
+	entry->orc	= *orc;
+	entry->insn_sec = sec;
+	entry->insn_off = offset;
+
+	list_add_tail(&entry->list, orc_list);
+	return 0;
+}
+
+int orc_create(struct objtool_file *file)
 {
-	struct instruction *insn, *prev_insn;
-	struct section *sec, *u_sec, *ip_relocsec;
-	unsigned int idx;
+	struct section *sec, *ip_rsec, *orc_sec;
+	unsigned int nr = 0, idx = 0;
+	struct orc_list_entry *entry;
+	struct list_head orc_list;
 
-	struct orc_entry empty = {
-		.sp_reg = ORC_REG_UNDEFINED,
+	struct orc_entry null = {
+		.sp_reg  = ORC_REG_UNDEFINED,
 		.bp_reg  = ORC_REG_UNDEFINED,
 		.type    = UNWIND_HINT_TYPE_CALL,
 	};
 
-	sec = find_section_by_name(file->elf, ".orc_unwind");
-	if (sec) {
-		WARN("file already has .orc_unwind section, skipping");
-		return -1;
-	}
-
-	/* count the number of needed orcs */
-	idx = 0;
+	/* Build a deduplicated list of ORC entries: */
+	INIT_LIST_HEAD(&orc_list);
 	for_each_sec(file, sec) {
+		struct orc_entry orc, prev_orc = {0};
+		struct instruction *insn;
+		bool empty = true;
+
 		if (!sec->text)
 			continue;
 
-		prev_insn = NULL;
 		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn ||
-			    memcmp(&insn->orc, &prev_insn->orc,
-				   sizeof(struct orc_entry))) {
-				idx++;
-			}
-			prev_insn = insn;
+			if (init_orc_entry(&orc, &insn->cfi))
+				return -1;
+			if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+				continue;
+			if (orc_list_add(&orc_list, &orc, sec, insn->offset))
+				return -1;
+			nr++;
+			prev_orc = orc;
+			empty = false;
 		}
 
-		/* section terminator */
-		if (prev_insn)
-			idx++;
+		/* Add a section terminator */
+		if (!empty) {
+			orc_list_add(&orc_list, &null, sec, sec->len);
+			nr++;
+		}
 	}
-	if (!idx)
-		return -1;
+	if (!nr)
+		return 0;
 
+	/* Create .orc_unwind, .orc_unwind_ip and .rela.orc_unwind_ip sections: */
+	sec = find_section_by_name(file->elf, ".orc_unwind");
+	if (sec) {
+		WARN("file already has .orc_unwind section, skipping");
+		return -1;
+	}
+	orc_sec = elf_create_section(file->elf, ".orc_unwind", 0,
+				     sizeof(struct orc_entry), nr);
+	if (!orc_sec)
+		return -1;
 
-	/* create .orc_unwind_ip and .rela.orc_unwind_ip sections */
-	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), idx);
+	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
 	if (!sec)
 		return -1;
-
-	ip_relocsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!ip_relocsec)
+	ip_rsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
+	if (!ip_rsec)
 		return -1;
 
-	/* create .orc_unwind section */
-	u_sec = elf_create_section(file->elf, ".orc_unwind", 0,
-				   sizeof(struct orc_entry), idx);
-
-	/* populate sections */
-	idx = 0;
-	for_each_sec(file, sec) {
-		if (!sec->text)
-			continue;
-
-		prev_insn = NULL;
-		sec_for_each_insn(file, sec, insn) {
-			if (!prev_insn || memcmp(&insn->orc, &prev_insn->orc,
-						 sizeof(struct orc_entry))) {
-
-				if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
-						     insn->sec, insn->offset,
-						     &insn->orc))
-					return -1;
-
-				idx++;
-			}
-			prev_insn = insn;
-		}
-
-		/* section terminator */
-		if (prev_insn) {
-			if (create_orc_entry(file->elf, u_sec, ip_relocsec, idx,
-					     prev_insn->sec,
-					     prev_insn->offset + prev_insn->len,
-					     &empty))
-				return -1;
-
-			idx++;
-		}
+	/* Write ORC entries to sections: */
+	list_for_each_entry(entry, &orc_list, list) {
+		if (write_orc_entry(file->elf, orc_sec, ip_rsec, idx++,
+				    entry->insn_sec, entry->insn_off,
+				    &entry->orc))
+			return -1;
 	}
 
-	if (elf_rebuild_reloc_section(file->elf, ip_relocsec))
+	if (elf_rebuild_reloc_section(file->elf, ip_rsec))
 		return -1;
 
 	return 0;
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index f271682..8314e82 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -25,12 +25,7 @@ int __weak orc_dump(const char *_objname)
 	UNSUPPORTED("orc");
 }
 
-int __weak create_orc(struct objtool_file *file)
-{
-	UNSUPPORTED("orc");
-}
-
-int __weak create_orc_sections(struct objtool_file *file)
+int __weak orc_create(struct objtool_file *file)
 {
 	UNSUPPORTED("orc");
 }
