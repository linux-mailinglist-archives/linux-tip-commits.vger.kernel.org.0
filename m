Return-Path: <linux-tip-commits+bounces-4465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5BA6EBC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29423AA90B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E11F2580CE;
	Tue, 25 Mar 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jap/rfEr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PKcnlHb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0525742B;
	Tue, 25 Mar 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891714; cv=none; b=tz3IJ8AAtBJQn9sa/H8l4dqw3Q178wJt1Wo7aukiAlXGF3gnhyuBXlkAvfT7QyO5ndrI3ar7oEHgzpifgwDHd0XmYjEDSy7b+IBxbX28+ZUyxY6FAJAPghemyRuIWwjHco9M/d+GxVOWoW57OwkDwO3Dj7WViX4WsuEsNoQFTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891714; c=relaxed/simple;
	bh=fceMNrnCyVTdhgMWzQGlXiSceAqqEgdwtlpqsVQewL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LGr01glzwH5SDQo8gRtb7SiEsVbF6CWAGrpQxqdpdqZwcIzSMiMkI6pEyJlpiaNkulSCKeUmXq+lRVPgREv4hksLrE6qNgfJxgT8KJCUQ0eMPXqLIdt1K4G6l0Q6M7ZjFX9fP9tOiz4fQnn09PnDuxKKK572+bmpQKP4bV1t+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jap/rfEr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PKcnlHb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVR5F/0mBWtxIm81U9ictH4C4UGLg8a13dlwExx+qBM=;
	b=jap/rfErnqIDiwqbqimplN47KiMXZQGh724HI7sdGCyfdHLKpT4C7zyOB8b/kCc+i/VdqZ
	kJK8Yiek4GnLwDkm8QHvHTb9MuPXqFngZwHXDfBBdxfLGJXvHyQNVvafLZN5fcu+iOWE7B
	EvAgs1W7bh6Z88ndbYp5ZbXpp9Vx/EamK5oByzp+jCmbO4FS+mJwhDE5pkyLX86Z2svmD2
	tfkHUTA4roxxEpFa6dxlOLid12Vm26Jqr41YJzWf1bLFxpIsa5vWRiW7lRXBgXEbLeNcZy
	nnn7dYL4O8eq9nI83VcLu0Y2hAKr5a9YigX82VrlUXSYbHAGv3P/mXmYTF9yew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVR5F/0mBWtxIm81U9ictH4C4UGLg8a13dlwExx+qBM=;
	b=3PKcnlHbM0shFAjZF9hvmTDfsKlPD8+hrqW4SDkaGBFafwvdYjYmtpi1TBQOjsZ8tZDEjg
	SUdY91TTWl1Pf1Dw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix X86_FEATURE_SMAP alternative handling
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <de0621ca242130156a55d5d74fed86994dfa4c9c.1742852846.git.jpoimboe@kernel.org>
References:
 <de0621ca242130156a55d5d74fed86994dfa4c9c.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170972.14745.3057944293646099727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1154bbd326de4453858cf78cf29420888b3ffd52
Gitweb:        https://git.kernel.org/tip/1154bbd326de4453858cf78cf29420888b3ffd52
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:26 +01:00

objtool: Fix X86_FEATURE_SMAP alternative handling

For X86_FEATURE_SMAP alternatives which replace NOP with STAC or CLAC,
uaccess validation skips the NOP branch to avoid following impossible
code paths, e.g. where a STAC would be patched but a CLAC wouldn't.

However, it's not safe to assume an X86_FEATURE_SMAP alternative is
patching STAC/CLAC.  There can be other alternatives, like
static_cpu_has(), where both branches need to be validated.

Fix that by repurposing ANNOTATE_IGNORE_ALTERNATIVE for skipping either
original instructions or new ones.  This is a more generic approach
which enables the removal of the feature checking hacks and the
insn->ignore bit.

Fixes the following warnings:

  arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x8ec: __stack_chk_fail() missing __noreturn in .c/.h or NORETURN() in noreturns.h
  arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x8f1: unreachable instruction

[ mingo: Fix up conflicts with recent x86 changes. ]

Fixes: ea24213d8088 ("objtool: Add UACCESS validation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/de0621ca242130156a55d5d74fed86994dfa4c9c.1742852846.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503181736.zkZUBv4N-lkp@intel.com/
---
 arch/x86/include/asm/arch_hweight.h     |  6 ++--
 arch/x86/include/asm/smap.h             | 23 +++++++++-----
 arch/x86/include/asm/xen/hypercall.h    |  6 +---
 tools/objtool/arch/x86/special.c        | 33 +--------------------
 tools/objtool/check.c                   | 39 ++++++------------------
 tools/objtool/include/objtool/check.h   |  3 +-
 tools/objtool/include/objtool/special.h |  4 +--
 tools/objtool/special.c                 | 12 +------
 8 files changed, 37 insertions(+), 89 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index b5982b9..cbc6157 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,7 +16,8 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm_inline (ALTERNATIVE("call __sw_hweight32",
+	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				"call __sw_hweight32",
 				"popcntl %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
@@ -45,7 +46,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm_inline (ALTERNATIVE("call __sw_hweight64",
+	asm_inline (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				"call __sw_hweight64",
 				"popcntq %[val], %[cnt]", X86_FEATURE_POPCNT)
 			 : [cnt] "=" REG_OUT (res), ASM_CALL_CONSTRAINT
 			 : [val] REG_IN (w));
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index daea94c..55a5e65 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -16,23 +16,23 @@
 #ifdef __ASSEMBLER__
 
 #define ASM_CLAC \
-	ALTERNATIVE "", "clac", X86_FEATURE_SMAP
+	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "clac", X86_FEATURE_SMAP
 
 #define ASM_STAC \
-	ALTERNATIVE "", "stac", X86_FEATURE_SMAP
+	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "stac", X86_FEATURE_SMAP
 
 #else /* __ASSEMBLER__ */
 
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", "clac", X86_FEATURE_SMAP);
+	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", "stac", X86_FEATURE_SMAP);
+	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP);
 }
 
 static __always_inline unsigned long smap_save(void)
@@ -40,7 +40,8 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
 
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("", "pushf; pop %0; " "clac" "\n\t",
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				  "", "pushf; pop %0; clac",
 				  X86_FEATURE_SMAP)
 		      : "=rm" (flags) : : "memory", "cc");
 
@@ -50,16 +51,22 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("", "push %0; popf\n\t",
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				  "", "push %0; popf",
 				  X86_FEATURE_SMAP)
 		      : : "g" (flags) : "memory", "cc");
 }
 
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
-	ALTERNATIVE("", "clac", X86_FEATURE_SMAP)
+	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP)
 #define ASM_STAC \
-	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
+	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP)
+
+#define ASM_CLAC_UNSAFE \
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "clac", X86_FEATURE_SMAP)
+#define ASM_STAC_UNSAFE \
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "stac", X86_FEATURE_SMAP)
 
 #endif /* __ASSEMBLER__ */
 
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9..59a62c3 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -231,14 +231,12 @@ static __always_inline void __xen_stac(void)
 	 * Suppress objtool seeing the STAC/CLAC and getting confused about it
 	 * calling random code with AC=1.
 	 */
-	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
-		     ASM_STAC ::: "memory", "flags");
+	asm volatile(ASM_STAC_UNSAFE ::: "memory", "flags");
 }
 
 static __always_inline void __xen_clac(void)
 {
-	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
-		     ASM_CLAC ::: "memory", "flags");
+	asm volatile(ASM_CLAC_UNSAFE ::: "memory", "flags");
 }
 
 static inline long
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 5f46d4e..403e587 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -5,10 +5,7 @@
 #include <objtool/builtin.h>
 #include <objtool/warn.h>
 
-#define X86_FEATURE_POPCNT (4 * 32 + 23)
-#define X86_FEATURE_SMAP   (9 * 32 + 20)
-
-void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+void arch_handle_alternative(struct special_alt *alt)
 {
 	static struct special_alt *group, *prev;
 
@@ -32,34 +29,6 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 	} else group = alt;
 
 	prev = alt;
-
-	switch (feature) {
-	case X86_FEATURE_SMAP:
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (opts.uaccess)
-			alt->skip_orig = true;
-		else
-			alt->skip_alt = true;
-		break;
-	case X86_FEATURE_POPCNT:
-		/*
-		 * It has been requested that we don't validate the !POPCNT
-		 * feature path which is a "very very small percentage of
-		 * machines".
-		 */
-		alt->skip_orig = true;
-		break;
-	default:
-		break;
-	}
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f465020..b2f6a7f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -25,7 +25,6 @@
 struct alternative {
 	struct alternative *next;
 	struct instruction *insn;
-	bool skip_orig;
 };
 
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
@@ -1696,6 +1695,7 @@ static int handle_group_alt(struct objtool_file *file,
 		orig_alt_group->first_insn = orig_insn;
 		orig_alt_group->last_insn = last_orig_insn;
 		orig_alt_group->nop = NULL;
+		orig_alt_group->ignore = orig_insn->ignore_alts;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
@@ -1735,7 +1735,6 @@ static int handle_group_alt(struct objtool_file *file,
 		nop->type = INSN_NOP;
 		nop->sym = orig_insn->sym;
 		nop->alt_group = new_alt_group;
-		nop->ignore = orig_insn->ignore_alts;
 	}
 
 	if (!special_alt->new_len) {
@@ -1752,7 +1751,6 @@ static int handle_group_alt(struct objtool_file *file,
 
 		last_new_insn = insn;
 
-		insn->ignore = orig_insn->ignore_alts;
 		insn->sym = orig_insn->sym;
 		insn->alt_group = new_alt_group;
 
@@ -1799,6 +1797,7 @@ end:
 	new_alt_group->first_insn = *new_insn;
 	new_alt_group->last_insn = last_new_insn;
 	new_alt_group->nop = nop;
+	new_alt_group->ignore = (*new_insn)->ignore_alts;
 	new_alt_group->cfi = orig_alt_group->cfi;
 	return 0;
 }
@@ -1916,8 +1915,6 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		alt->insn = new_insn;
-		alt->skip_orig = special_alt->skip_orig;
-		orig_insn->ignore_alts |= special_alt->skip_alt;
 		alt->next = orig_insn->alts;
 		orig_insn->alts = alt;
 
@@ -2295,6 +2292,8 @@ static int read_annotate(struct objtool_file *file,
 static int __annotate_early(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
+
+	/* Must be before add_special_section_alts() */
 	case ANNOTYPE_IGNORE_ALTS:
 		insn->ignore_alts = true;
 		break;
@@ -3488,11 +3487,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 1;
 		}
 
-		if (func && insn->ignore) {
-			WARN_INSN(insn, "BUG: why am I validating an ignored function?");
-			return 1;
-		}
-
 		visited = VISITED_BRANCH << state.uaccess;
 		if (insn->visited & VISITED_BRANCH_MASK) {
 			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
@@ -3564,24 +3558,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (propagate_alt_cfi(file, insn))
 			return 1;
 
-		if (!insn->ignore_alts && insn->alts) {
-			bool skip_orig = false;
-
+		if (insn->alts) {
 			for (alt = insn->alts; alt; alt = alt->next) {
-				if (alt->skip_orig)
-					skip_orig = true;
-
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
-
-			if (skip_orig)
-				return 0;
 		}
 
+		if (insn->alt_group && insn->alt_group->ignore)
+			return 0;
+
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
@@ -3768,23 +3757,15 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 		insn->visited |= VISITED_UNRET;
 
-		if (!insn->ignore_alts && insn->alts) {
+		if (insn->alts) {
 			struct alternative *alt;
-			bool skip_orig = false;
-
 			for (alt = insn->alts; alt; alt = alt->next) {
-				if (alt->skip_orig)
-					skip_orig = true;
-
 				ret = validate_unret(file, alt->insn);
 				if (ret) {
 					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
-
-			if (skip_orig)
-				return 0;
 		}
 
 		switch (insn->type) {
@@ -3935,7 +3916,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	struct instruction *prev_insn;
 	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
+	if (insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
 		return true;
 
 	/*
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e1cd13c..00fb745 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -34,6 +34,8 @@ struct alt_group {
 	 * This is shared with the other alt_groups in the same alternative.
 	 */
 	struct cfi_state **cfi;
+
+	bool ignore;
 };
 
 #define INSN_CHUNK_BITS		8
@@ -54,7 +56,6 @@ struct instruction {
 
 	u32 idx			: INSN_CHUNK_BITS,
 	    dead_end		: 1,
-	    ignore		: 1,
 	    ignore_alts		: 1,
 	    hint		: 1,
 	    save		: 1,
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e049679..72d09c0 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -16,8 +16,6 @@ struct special_alt {
 	struct list_head list;
 
 	bool group;
-	bool skip_orig;
-	bool skip_alt;
 	bool jump_or_nop;
 	u8 key_addend;
 
@@ -32,7 +30,7 @@ struct special_alt {
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
-void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+void arch_handle_alternative(struct special_alt *alt);
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 097a69d..6cd7b1b 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -54,7 +54,7 @@ static const struct special_entry entries[] = {
 	{},
 };
 
-void __weak arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+void __weak arch_handle_alternative(struct special_alt *alt)
 {
 }
 
@@ -92,15 +92,7 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 
 	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
 
-	if (entry->feature) {
-		unsigned short feature;
-
-		feature = bswap_if_needed(elf,
-					  *(unsigned short *)(sec->data->d_buf +
-							      offset +
-							      entry->feature));
-		arch_handle_alternative(feature, alt);
-	}
+	arch_handle_alternative(alt);
 
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);

