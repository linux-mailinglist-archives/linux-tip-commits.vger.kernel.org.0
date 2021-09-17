Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3358E40F87D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbhIQM70 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244913AbhIQM7Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B3EC061574;
        Fri, 17 Sep 2021 05:58:03 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJlvR+5z1sl31iGsebe3q9KPF15mYuqxj/ZQo3trNSQ=;
        b=Qf2bUxI6Z9xbytRDpBiZ+ZAC5cb3+bEp98hd8R/H8DueFM2G4bNrF7S5eTAcRQpImDdYJt
        MrFjq+X9P81saJ9t0x/c+0LfYR2HQqZ+e+pdGMJBD0EeosGBlSWarmYxqy+fU8DtlSiw+q
        9vZ0/45TkWqPCXOavDLKKOcPH1uuHW+vMJ+yo7/67nfoexL/iRzZDvu6uRu3WOrXj2sEH/
        ZIgyb4Sa4H8qa6vvTJVOFtYcz+jAQjY2VV+q49oPoBvYk/CIar2mFpcNJyLCA6TRlLW/gG
        ex5JVHIEODGEC+mPUB/d95X7AYwww0Uv0NukjeOK1LD5unlps0ExE8K2Ah3T8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJlvR+5z1sl31iGsebe3q9KPF15mYuqxj/ZQo3trNSQ=;
        b=TgPe4rB3xfllYTscO9H3iELO7Lm19dr+LHdLTxHNBu9Uu/6ERlCTxZtrglbkgvRdbAoa9P
        NuNA55e9nFFmMPCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support pv_opsindirect calls for noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095149.118815755@infradead.org>
References: <20210624095149.118815755@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348099.25758.16639714278203252901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     db2b0c5d7b6f19b3c2cab08c531b65342eb5252b
Gitweb:        https://git.kernel.org/tip/db2b0c5d7b6f19b3c2cab08c531b65342eb5252b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:20:26 +02:00

objtool: Support pv_opsindirect calls for noinstr

Normally objtool will now follow indirect calls; there is no need.

However, this becomes a problem with noinstr validation; if there's an
indirect call from noinstr code, we very much need to know it is to
another noinstr function. Luckily there aren't many indirect calls in
entry code with the obvious exception of paravirt. As such, noinstr
validation didn't work with paravirt kernels.

In order to track pv_ops[] call targets, objtool reads the static
pv_ops[] tables as well as direct assignments to the pv_ops[] array,
provided the compiler makes them a single instruction like:

  bf87:       48 c7 05 00 00 00 00 00 00 00 00        movq   $0x0,0x0(%rip)
    bf92 <xen_init_spinlocks+0x5f>
    bf8a: R_X86_64_PC32     pv_ops+0x268

There are, as of yet, no warnings for when this goes wrong :/

Using the functions found with the above means, all pv_ops[] calls are
now subject to noinstr validation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095149.118815755@infradead.org
---
 lib/Kconfig.debug                       |   2 +-
 tools/objtool/arch/x86/decode.c         |  34 ++++-
 tools/objtool/check.c                   | 151 +++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h    |   2 +-
 tools/objtool/include/objtool/elf.h     |   1 +-
 tools/objtool/include/objtool/objtool.h |   9 +-
 tools/objtool/objtool.c                 |  22 +++-
 7 files changed, 208 insertions(+), 13 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ed4a31e..63a4735 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -458,7 +458,7 @@ config STACK_VALIDATION
 
 config VMLINUX_VALIDATION
 	bool
-	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
+	depends on STACK_VALIDATION && DEBUG_ENTRY
 	default y
 
 config VMLINUX_MAP
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 340a3dc..3172983 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -20,6 +20,7 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
+#include <objtool/builtin.h>
 #include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
@@ -102,12 +103,13 @@ unsigned long arch_jump_destination(struct instruction *insn)
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
 #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
 			    struct list_head *ops_list)
 {
+	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
 	unsigned char op1, op2,
@@ -544,6 +546,36 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		*type = INSN_RETURN;
 		break;
 
+	case 0xc7: /* mov imm, r/m */
+		if (!noinstr)
+			break;
+
+		if (insn.length == 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
+			struct reloc *immr, *disp;
+			struct symbol *func;
+			int idx;
+
+			immr = find_reloc_by_dest(elf, (void *)sec, offset+3);
+			disp = find_reloc_by_dest(elf, (void *)sec, offset+7);
+
+			if (!immr || strcmp(immr->sym->name, "pv_ops"))
+				break;
+
+			idx = (immr->addend + 8) / sizeof(void *);
+
+			func = disp->sym;
+			if (disp->sym->type == STT_SECTION)
+				func = find_symbol_by_offset(disp->sym->sec, disp->addend);
+			if (!func) {
+				WARN("no func for pv_ops[]");
+				return -1;
+			}
+
+			objtool_pv_add(file, idx, func);
+		}
+
+		break;
+
 	case 0xcf: /* iret */
 		/*
 		 * Handle sync_core(), which has an IRET to self.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6f206f..84e59a9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -382,7 +382,7 @@ static int decode_instructions(struct objtool_file *file)
 			insn->sec = sec;
 			insn->offset = offset;
 
-			ret = arch_decode_instruction(file->elf, sec, offset,
+			ret = arch_decode_instruction(file, sec, offset,
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
@@ -420,6 +420,82 @@ err:
 	return ret;
 }
 
+/*
+ * Read the pv_ops[] .data table to find the static initialized values.
+ */
+static int add_pv_ops(struct objtool_file *file, const char *symname)
+{
+	struct symbol *sym, *func;
+	unsigned long off, end;
+	struct reloc *rel;
+	int idx;
+
+	sym = find_symbol_by_name(file->elf, symname);
+	if (!sym)
+		return 0;
+
+	off = sym->offset;
+	end = off + sym->len;
+	for (;;) {
+		rel = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
+		if (!rel)
+			break;
+
+		func = rel->sym;
+		if (func->type == STT_SECTION)
+			func = find_symbol_by_offset(rel->sym->sec, rel->addend);
+
+		idx = (rel->offset - sym->offset) / sizeof(unsigned long);
+
+		objtool_pv_add(file, idx, func);
+
+		off = rel->offset + 1;
+		if (off > end)
+			break;
+	}
+
+	return 0;
+}
+
+/*
+ * Allocate and initialize file->pv_ops[].
+ */
+static int init_pv_ops(struct objtool_file *file)
+{
+	static const char *pv_ops_tables[] = {
+		"pv_ops",
+		"xen_cpu_ops",
+		"xen_irq_ops",
+		"xen_mmu_ops",
+		NULL,
+	};
+	const char *pv_ops;
+	struct symbol *sym;
+	int idx, nr;
+
+	if (!noinstr)
+		return 0;
+
+	file->pv_ops = NULL;
+
+	sym = find_symbol_by_name(file->elf, "pv_ops");
+	if (!sym)
+		return 0;
+
+	nr = sym->len / sizeof(unsigned long);
+	file->pv_ops = calloc(sizeof(struct pv_state), nr);
+	if (!file->pv_ops)
+		return -1;
+
+	for (idx = 0; idx < nr; idx++)
+		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
+
+	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++)
+		add_pv_ops(file, pv_ops);
+
+	return 0;
+}
+
 static struct instruction *find_last_insn(struct objtool_file *file,
 					  struct section *sec)
 {
@@ -893,6 +969,9 @@ static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *i
 		return NULL;
 
 	if (!insn->reloc) {
+		if (!file)
+			return NULL;
+
 		insn->reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 						       insn->offset, insn->len);
 		if (!insn->reloc) {
@@ -1882,6 +1961,10 @@ static int decode_sections(struct objtool_file *file)
 
 	mark_rodata(file);
 
+	ret = init_pv_ops(file);
+	if (ret)
+		return ret;
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
@@ -2663,20 +2746,64 @@ static inline bool func_uaccess_safe(struct symbol *func)
 
 static inline const char *call_dest_name(struct instruction *insn)
 {
+	static char pvname[16];
+	struct reloc *rel;
+	int idx;
+
 	if (insn->call_dest)
 		return insn->call_dest->name;
 
+	rel = insn_reloc(NULL, insn);
+	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
+		idx = (rel->addend / sizeof(void *));
+		snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
+		return pvname;
+	}
+
 	return "{dynamic}";
 }
 
-static inline bool noinstr_call_dest(struct symbol *func)
+static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *target;
+	struct reloc *rel;
+	int idx;
+
+	rel = insn_reloc(file, insn);
+	if (!rel || strcmp(rel->sym->name, "pv_ops"))
+		return false;
+
+	idx = (arch_dest_reloc_offset(rel->addend) / sizeof(void *));
+
+	if (file->pv_ops[idx].clean)
+		return true;
+
+	file->pv_ops[idx].clean = true;
+
+	list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
+		if (!target->sec->noinstr) {
+			WARN("pv_ops[%d]: %s", idx, target->name);
+			file->pv_ops[idx].clean = false;
+		}
+	}
+
+	return file->pv_ops[idx].clean;
+}
+
+static inline bool noinstr_call_dest(struct objtool_file *file,
+				     struct instruction *insn,
+				     struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
 	 * assume they're instrumented.
 	 */
-	if (!func)
+	if (!func) {
+		if (file->pv_ops)
+			return pv_call_dest(file, insn);
+
 		return false;
+	}
 
 	/*
 	 * If the symbol is from a noinstr section; we good.
@@ -2695,10 +2822,12 @@ static inline bool noinstr_call_dest(struct symbol *func)
 	return false;
 }
 
-static int validate_call(struct instruction *insn, struct insn_state *state)
+static int validate_call(struct objtool_file *file,
+			 struct instruction *insn,
+			 struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -2719,7 +2848,9 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 	return 0;
 }
 
-static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
+static int validate_sibling_call(struct objtool_file *file,
+				 struct instruction *insn,
+				 struct insn_state *state)
 {
 	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
@@ -2727,7 +2858,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 		return 1;
 	}
 
-	return validate_call(insn, state);
+	return validate_call(file, insn, state);
 }
 
 static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
@@ -2880,7 +3011,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
-			ret = validate_call(insn, &state);
+			ret = validate_call(file, insn, &state);
 			if (ret)
 				return ret;
 
@@ -2899,7 +3030,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 
@@ -2921,7 +3052,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(insn, &state);
+				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
 			}
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6f482ae..589ff58 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -69,7 +69,7 @@ struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
 
-int arch_decode_instruction(const struct elf *elf, const struct section *sec,
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
 			    unsigned long *immediate,
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e343950..c3857fa 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -57,6 +57,7 @@ struct symbol {
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
 	bool static_call_tramp;
+	struct list_head pv_target;
 };
 
 struct reloc {
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 24fa836..f99fbc6 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -14,6 +14,11 @@
 
 #define __weak __attribute__((weak))
 
+struct pv_state {
+	bool clean;
+	struct list_head targets;
+};
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
@@ -25,10 +30,14 @@ struct objtool_file {
 
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
+
+	struct pv_state *pv_ops;
 };
 
 struct objtool_file *objtool_open_read(const char *_objname);
 
+void objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
+
 int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index e21db8b..c90c708 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -135,6 +135,28 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	return &file;
 }
 
+void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
+{
+	if (!noinstr)
+		return;
+
+	if (!f->pv_ops) {
+		WARN("paravirt confusion");
+		return;
+	}
+
+	/*
+	 * These functions will be patched into native code,
+	 * see paravirt_patch().
+	 */
+	if (!strcmp(func->name, "_paravirt_nop") ||
+	    !strcmp(func->name, "_paravirt_ident_64"))
+		return;
+
+	list_add(&func->pv_target, &f->pv_ops[idx].targets);
+	f->pv_ops[idx].clean = false;
+}
+
 static void cmd_usage(void)
 {
 	unsigned int i, longest = 0;
