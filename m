Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA583518B1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhDARrM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhDARlp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE99AC00F7DA;
        Thu,  1 Apr 2021 08:08:56 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kQpLj9OOa6mEj53pqc+17px6T7ZFNkd9qc98SDa4RM=;
        b=PXoUnjCtfjjLdihtYkPkoXhow7zFSWElN7c1lfCFmAm8dXBKOFBY69sjdj2nmHZMme5Ode
        9RtwU1/NoTt2zD0mH4ZST8J7265n/J8vH51Sf4SGff5AO03MhvpkfMLuFsXO1SNNeROAxx
        A88xomp0VFf8SHfAwiPeVOrRVMe4W7Rx+zr2epocQ3rm5kq/O1eARpj4ODmH4r+1DAZJN1
        wDe79FkNF/j+/Jm9Ojea3Q2bulVzNLQ7TLQBXWZ6keQ4Vcmko3A0FJAnLEjMNzSXKnh6lU
        w8tN/qm4g32xBOMj7642OG/Q7ScOGlWKXjZd/EwlCVRmJVlu/bn+aW9V6LjpMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kQpLj9OOa6mEj53pqc+17px6T7ZFNkd9qc98SDa4RM=;
        b=aYldOfvO4Dbc8fziug6QSkMUfI40HEMy80PDWpB6ebxKVoMjzLeBxu+gVhV/0bO8kdhqRr
        +YlwE9KOi3FA1wDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool/x86: Rewrite retpoline thunk calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.320177914@infradead.org>
References: <20210326151300.320177914@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973397.29796.9283971977578914711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f31390437ce984118215169d75570e365457ec23
Gitweb:        https://git.kernel.org/tip/f31390437ce984118215169d75570e365457ec23
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:15 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 14:30:45 +02:00

objtool/x86: Rewrite retpoline thunk calls

When the compiler emits: "CALL __x86_indirect_thunk_\reg" for an
indirect call, have objtool rewrite it to:

	ALTERNATIVE "call __x86_indirect_thunk_\reg",
		    "call *%reg", ALT_NOT(X86_FEATURE_RETPOLINE)

Additionally, in order to not emit endless identical
.altinst_replacement chunks, use a global symbol for them, see
__x86_indirect_alt_*.

This also avoids objtool from having to do code generation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.320177914@infradead.org
---
 arch/x86/include/asm/asm-prototypes.h |  12 ++-
 arch/x86/lib/retpoline.S              |  41 ++++++++-
 tools/objtool/arch/x86/decode.c       | 117 +++++++++++++++++++++++++-
 3 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 0545b07..4cb726c 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,11 +19,19 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 
-#define DECL_INDIRECT_THUNK(reg) \
+#undef GEN
+#define GEN(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) \
+	extern asmlinkage void __x86_indirect_alt_call_ ## reg (void);
+#include <asm/GEN-for-each-reg.h>
 
 #undef GEN
-#define GEN(reg) DECL_INDIRECT_THUNK(reg)
+#define GEN(reg) \
+	extern asmlinkage void __x86_indirect_alt_jmp_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
 
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d2c0d14..4d32cb0 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -10,6 +10,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
 
+	.section .text.__x86.indirect_thunk
+
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@
@@ -25,9 +27,9 @@
 .endm
 
 .macro THUNK reg
-	.section .text.__x86.indirect_thunk
 
 	.align 32
+
 SYM_FUNC_START(__x86_indirect_thunk_\reg)
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
@@ -39,6 +41,32 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 .endm
 
 /*
+ * This generates .altinstr_replacement symbols for use by objtool. They,
+ * however, must not actually live in .altinstr_replacement since that will be
+ * discarded after init, but module alternatives will also reference these
+ * symbols.
+ *
+ * Their names matches the "__x86_indirect_" prefix to mark them as retpolines.
+ */
+.macro ALT_THUNK reg
+
+	.align 1
+
+SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
+	ANNOTATE_RETPOLINE_SAFE
+1:	call	*%\reg
+2:	.skip	5-(2b-1b), 0x90
+SYM_FUNC_END(__x86_indirect_alt_call_\reg)
+
+SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
+	ANNOTATE_RETPOLINE_SAFE
+1:	jmp	*%\reg
+2:	.skip	5-(2b-1b), 0x90
+SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
+
+.endm
+
+/*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
  * only see one instance of "__x86_indirect_thunk_\reg" rather
@@ -61,3 +89,14 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
 
+#undef GEN
+#define GEN(reg) ALT_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
+#include <asm/GEN-for-each-reg.h>
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e5fa3a5..44375fa 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -16,6 +16,7 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
+#include <arch/elf.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -610,6 +611,122 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+/* asm/alternative.h ? */
+
+#define ALTINSTR_FLAG_INV	(1 << 15)
+#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
+
+struct alt_instr {
+	s32 instr_offset;	/* original instruction */
+	s32 repl_offset;	/* offset to replacement instruction */
+	u16 cpuid;		/* cpuid bit set for replacement */
+	u8  instrlen;		/* length of original instruction */
+	u8  replacementlen;	/* length of new instruction */
+} __packed;
+
+static int elf_add_alternative(struct elf *elf,
+			       struct instruction *orig, struct symbol *sym,
+			       int cpuid, u8 orig_len, u8 repl_len)
+{
+	const int size = sizeof(struct alt_instr);
+	struct alt_instr *alt;
+	struct section *sec;
+	Elf_Scn *s;
+
+	sec = find_section_by_name(elf, ".altinstructions");
+	if (!sec) {
+		sec = elf_create_section(elf, ".altinstructions",
+					 SHF_WRITE, size, 0);
+
+		if (!sec) {
+			WARN_ELF("elf_create_section");
+			return -1;
+		}
+	}
+
+	s = elf_getscn(elf->elf, sec->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	sec->data = elf_newdata(s);
+	if (!sec->data) {
+		WARN_ELF("elf_newdata");
+		return -1;
+	}
+
+	sec->data->d_size = size;
+	sec->data->d_align = 1;
+
+	alt = sec->data->d_buf = malloc(size);
+	if (!sec->data->d_buf) {
+		perror("malloc");
+		return -1;
+	}
+	memset(sec->data->d_buf, 0, size);
+
+	if (elf_add_reloc_to_insn(elf, sec, sec->sh.sh_size,
+				  R_X86_64_PC32, orig->sec, orig->offset)) {
+		WARN("elf_create_reloc: alt_instr::instr_offset");
+		return -1;
+	}
+
+	if (elf_add_reloc(elf, sec, sec->sh.sh_size + 4,
+			  R_X86_64_PC32, sym, 0)) {
+		WARN("elf_create_reloc: alt_instr::repl_offset");
+		return -1;
+	}
+
+	alt->cpuid = cpuid;
+	alt->instrlen = orig_len;
+	alt->replacementlen = repl_len;
+
+	sec->sh.sh_size += size;
+	sec->changed = true;
+
+	return 0;
+}
+
+#define X86_FEATURE_RETPOLINE                ( 7*32+12)
+
+int arch_rewrite_retpolines(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct reloc *reloc;
+	struct symbol *sym;
+	char name[32] = "";
+
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+
+		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
+			continue;
+
+		reloc = insn->reloc;
+
+		sprintf(name, "__x86_indirect_alt_%s_%s",
+			insn->type == INSN_JUMP_DYNAMIC ? "jmp" : "call",
+			reloc->sym->name + 21);
+
+		sym = find_symbol_by_name(file->elf, name);
+		if (!sym) {
+			sym = elf_create_undef_symbol(file->elf, name);
+			if (!sym) {
+				WARN("elf_create_undef_symbol");
+				return -1;
+			}
+		}
+
+		if (elf_add_alternative(file->elf, insn, sym,
+					ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5)) {
+			WARN("elf_add_alternative");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 {
 	struct cfi_reg *cfa = &insn->cfi.cfa;
