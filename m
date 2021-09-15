Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6D40C8C7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhIOPvB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbhIOPuz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:55 -0400
Date:   Wed, 15 Sep 2021 15:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRaQmiagS/4WnW0M0e/3uBbmB1DK2XR/bDx7AdBYmJs=;
        b=qKA8OhhIJFeVvknyB+fhpQnSEpvm4S3f5pE3BsGhPkhi1hsCeQYbtWrJyDN5hSEfVoS1+u
        LO7BssXNuRU82J5CEhKZdQSDD2U6esM/iVZRaYrc/ViKeRcDlCgWT1WYDByychR82p5FXp
        XwjtaQA9JHcdHsqwmffo1GZSKEqgJvG0PhneIaHaWs4qk462Zjj9xqYOnaErgQfYzIpxya
        qQcQudvmsQd6u6kDRQLq6ymiwgOz2wIRkzeO5p/BclMRtPD/+bABAkuxxvQ/GHcv0UM/SM
        Rag2iN+zVOJ5mCVXvTw86g/Wkej6wa3Q8+kSH7eR9s2fsJQI8QM3bFeAgh7GVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRaQmiagS/4WnW0M0e/3uBbmB1DK2XR/bDx7AdBYmJs=;
        b=3bS3YaXERJwgwlLwOMKUuL+EiaIFr/JSwnxGKE5/YwXHhJ7u6MGc1twci1635sPvttvGIQ
        dylJESNKlSeqIiBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Introduce CFI hash
Cc:     Andi Kleen <andi@firstfloor.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095147.756759107@infradead.org>
References: <20210624095147.756759107@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097425.25758.16383837121009704946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8b946cc38e063f0f7bb67789478c38f6d7d457c9
Gitweb:        https://git.kernel.org/tip/8b946cc38e063f0f7bb67789478c38f6d7d457c9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:45 +02:00

objtool: Introduce CFI hash

Andi reported that objtool on vmlinux.o consumes more memory than his
system has, leading to horrific performance.

This is in part because we keep a struct instruction for every
instruction in the file in-memory. Shrink struct instruction by
removing the CFI state (which includes full register state) from it
and demand allocating it.

Given most instructions don't actually change CFI state, there's lots
of repetition there, so add a hash table to find previous CFI
instances.

Reduces memory consumption (and runtime) for processing an
x86_64-allyesconfig:

  pre:  4:40.84 real,   143.99 user,    44.18 sys,      30624988 mem
  post: 2:14.61 real,   108.58 user,    25.04 sys,      16396184 mem

Suggested-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095147.756759107@infradead.org
---
 tools/objtool/arch/x86/decode.c       |  20 +--
 tools/objtool/check.c                 | 154 ++++++++++++++++++++++---
 tools/objtool/include/objtool/arch.h  |   2 +-
 tools/objtool/include/objtool/cfi.h   |   2 +-
 tools/objtool/include/objtool/check.h |   2 +-
 tools/objtool/orc_gen.c               |  15 +-
 6 files changed, 160 insertions(+), 35 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc82105..3435a32 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -779,34 +779,32 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 	return 0;
 }
 
-int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
+int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
-	struct cfi_reg *cfa = &insn->cfi.cfa;
-
 	switch (sp_reg) {
 	case ORC_REG_UNDEFINED:
-		cfa->base = CFI_UNDEFINED;
+		*base = CFI_UNDEFINED;
 		break;
 	case ORC_REG_SP:
-		cfa->base = CFI_SP;
+		*base = CFI_SP;
 		break;
 	case ORC_REG_BP:
-		cfa->base = CFI_BP;
+		*base = CFI_BP;
 		break;
 	case ORC_REG_SP_INDIRECT:
-		cfa->base = CFI_SP_INDIRECT;
+		*base = CFI_SP_INDIRECT;
 		break;
 	case ORC_REG_R10:
-		cfa->base = CFI_R10;
+		*base = CFI_R10;
 		break;
 	case ORC_REG_R13:
-		cfa->base = CFI_R13;
+		*base = CFI_R13;
 		break;
 	case ORC_REG_DI:
-		cfa->base = CFI_DI;
+		*base = CFI_DI;
 		break;
 	case ORC_REG_DX:
-		cfa->base = CFI_DX;
+		*base = CFI_DX;
 		break;
 	default:
 		return -1;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0e3981d..d9f3273 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <sys/mman.h>
 
 #include <arch/elf.h>
 #include <objtool/builtin.h>
@@ -26,7 +27,11 @@ struct alternative {
 	bool skip_orig;
 };
 
-struct cfi_init_state initial_func_cfi;
+static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
+
+static struct cfi_init_state initial_func_cfi;
+static struct cfi_state init_cfi;
+static struct cfi_state func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -266,6 +271,78 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 		state->noinstr = sec->noinstr;
 }
 
+static struct cfi_state *cfi_alloc(void)
+{
+	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
+	if (!cfi) {
+		WARN("calloc failed");
+		exit(1);
+	}
+	nr_cfi++;
+	return cfi;
+}
+
+static int cfi_bits;
+static struct hlist_head *cfi_hash;
+
+static inline bool cficmp(struct cfi_state *cfi1, struct cfi_state *cfi2)
+{
+	return memcmp((void *)cfi1 + sizeof(cfi1->hash),
+		      (void *)cfi2 + sizeof(cfi2->hash),
+		      sizeof(struct cfi_state) - sizeof(struct hlist_node));
+}
+
+static inline u32 cfi_key(struct cfi_state *cfi)
+{
+	return jhash((void *)cfi + sizeof(cfi->hash),
+		     sizeof(*cfi) - sizeof(cfi->hash), 0);
+}
+
+static struct cfi_state *cfi_hash_find_or_add(struct cfi_state *cfi)
+{
+	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+	struct cfi_state *obj;
+
+	hlist_for_each_entry(obj, head, hash) {
+		if (!cficmp(cfi, obj)) {
+			nr_cfi_cache++;
+			return obj;
+		}
+	}
+
+	obj = cfi_alloc();
+	*obj = *cfi;
+	hlist_add_head(&obj->hash, head);
+
+	return obj;
+}
+
+static void cfi_hash_add(struct cfi_state *cfi)
+{
+	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
+
+	hlist_add_head(&cfi->hash, head);
+}
+
+static void *cfi_hash_alloc(unsigned long size)
+{
+	cfi_bits = max(10, ilog2(size));
+	cfi_hash = mmap(NULL, sizeof(struct hlist_head) << cfi_bits,
+			PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANON, -1, 0);
+	if (cfi_hash == (void *)-1L) {
+		WARN("mmap fail cfi_hash");
+		cfi_hash = NULL;
+	}  else if (stats) {
+		printf("cfi_bits: %d\n", cfi_bits);
+	}
+
+	return cfi_hash;
+}
+
+static unsigned long nr_insns;
+static unsigned long nr_insns_visited;
+
 /*
  * Call the arch-specific instruction decoder for all the instructions and add
  * them to the global instruction list.
@@ -276,7 +353,6 @@ static int decode_instructions(struct objtool_file *file)
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
-	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -302,7 +378,6 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
-			init_cfi_state(&insn->cfi);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1137,7 +1212,6 @@ static int handle_group_alt(struct objtool_file *file,
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
 		INIT_LIST_HEAD(&nop->stack_ops);
-		init_cfi_state(&nop->cfi);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -1546,10 +1620,11 @@ static void set_func_state(struct cfi_state *state)
 
 static int read_unwind_hints(struct objtool_file *file)
 {
+	struct cfi_state cfi = init_cfi;
 	struct section *sec, *relocsec;
-	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
+	struct reloc *reloc;
 	int i;
 
 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1587,19 +1662,24 @@ static int read_unwind_hints(struct objtool_file *file)
 		insn->hint = true;
 
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
-			set_func_state(&insn->cfi);
+			insn->cfi = &func_cfi;
 			continue;
 		}
 
-		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
+		if (insn->cfi)
+			cfi = *(insn->cfi);
+
+		if (arch_decode_hint_reg(hint->sp_reg, &cfi.cfa.base)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
 				  insn->sec, insn->offset, hint->sp_reg);
 			return -1;
 		}
 
-		insn->cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
+		cfi.cfa.offset = bswap_if_needed(hint->sp_offset);
+		cfi.type = hint->type;
+		cfi.end = hint->end;
+
+		insn->cfi = cfi_hash_find_or_add(&cfi);
 	}
 
 	return 0;
@@ -2453,13 +2533,18 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
 	if (!insn->alt_group)
 		return 0;
 
+	if (!insn->cfi) {
+		WARN("CFI missing");
+		return -1;
+	}
+
 	alt_cfi = insn->alt_group->cfi;
 	group_off = insn->offset - insn->alt_group->first_insn->offset;
 
 	if (!alt_cfi[group_off]) {
-		alt_cfi[group_off] = &insn->cfi;
+		alt_cfi[group_off] = insn->cfi;
 	} else {
-		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+		if (cficmp(alt_cfi[group_off], insn->cfi)) {
 			WARN_FUNC("stack layout conflict in alternatives",
 				  insn->sec, insn->offset);
 			return -1;
@@ -2510,9 +2595,14 @@ static int handle_insn_ops(struct instruction *insn,
 
 static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 {
-	struct cfi_state *cfi1 = &insn->cfi;
+	struct cfi_state *cfi1 = insn->cfi;
 	int i;
 
+	if (!cfi1) {
+		WARN("CFI missing");
+		return false;
+	}
+
 	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
 
 		WARN_FUNC("stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
@@ -2697,7 +2787,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *next_insn;
+	struct instruction *next_insn, *prev_insn = NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2726,15 +2816,25 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			if (insn->visited & visited)
 				return 0;
+		} else {
+			nr_insns_visited++;
 		}
 
 		if (state.noinstr)
 			state.instr += insn->instr;
 
-		if (insn->hint)
-			state.cfi = insn->cfi;
-		else
-			insn->cfi = state.cfi;
+		if (insn->hint) {
+			state.cfi = *insn->cfi;
+		} else {
+			/* XXX track if we actually changed state.cfi */
+
+			if (prev_insn && !cficmp(prev_insn->cfi, &state.cfi)) {
+				insn->cfi = prev_insn->cfi;
+				nr_cfi_reused++;
+			} else {
+				insn->cfi = cfi_hash_find_or_add(&state.cfi);
+			}
+		}
 
 		insn->visited |= visited;
 
@@ -2884,6 +2984,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 1;
 		}
 
+		prev_insn = insn;
 		insn = next_insn;
 	}
 
@@ -3139,10 +3240,20 @@ int check(struct objtool_file *file)
 	int ret, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&init_cfi);
+	init_cfi_state(&func_cfi);
+	set_func_state(&func_cfi);
+
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+		goto out;
+
+	cfi_hash_add(&init_cfi);
+	cfi_hash_add(&func_cfi);
 
 	ret = decode_sections(file);
 	if (ret < 0)
 		goto out;
+
 	warnings += ret;
 
 	if (list_empty(&file->insn_list))
@@ -3193,6 +3304,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (stats) {
+		printf("nr_insns_visited: %ld\n", nr_insns_visited);
+		printf("nr_cfi: %ld\n", nr_cfi);
+		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
+		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+	}
+
 out:
 	/*
 	 *  For now, don't fail the kernel build on fatal warnings.  These
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 062bb6e..a5ab682 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -83,7 +83,7 @@ unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
 
-int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
+int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index fd5cb0b..f11d1ac 100644
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -7,6 +7,7 @@
 #define _OBJTOOL_CFI_H
 
 #include <arch/cfi_regs.h>
+#include <linux/list.h>
 
 #define CFI_UNDEFINED		-1
 #define CFI_CFA			-2
@@ -24,6 +25,7 @@ struct cfi_init_state {
 };
 
 struct cfi_state {
+	struct hlist_node hash; /* must be first, cficmp() */
 	struct cfi_reg regs[CFI_NUM_REGS];
 	struct cfi_reg vals[CFI_NUM_REGS];
 	struct cfi_reg cfa;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 56d50bc..07e99c2 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -60,7 +60,7 @@ struct instruction {
 	struct list_head alts;
 	struct symbol *func;
 	struct list_head stack_ops;
-	struct cfi_state cfi;
+	struct cfi_state *cfi;
 };
 
 static inline bool is_static_jump(struct instruction *insn)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dc9b7dd..ddacb42 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -13,13 +13,19 @@
 #include <objtool/warn.h>
 #include <objtool/endianness.h>
 
-static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
+static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
+			  struct instruction *insn)
 {
-	struct instruction *insn = container_of(cfi, struct instruction, cfi);
 	struct cfi_reg *bp = &cfi->regs[CFI_BP];
 
 	memset(orc, 0, sizeof(*orc));
 
+	if (!cfi) {
+		orc->end = 0;
+		orc->sp_reg = ORC_REG_UNDEFINED;
+		return 0;
+	}
+
 	orc->end = cfi->end;
 
 	if (cfi->cfa.base == CFI_UNDEFINED) {
@@ -162,7 +168,7 @@ int orc_create(struct objtool_file *file)
 			int i;
 
 			if (!alt_group) {
-				if (init_orc_entry(&orc, &insn->cfi))
+				if (init_orc_entry(&orc, insn->cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
@@ -186,7 +192,8 @@ int orc_create(struct objtool_file *file)
 				struct cfi_state *cfi = alt_group->cfi[i];
 				if (!cfi)
 					continue;
-				if (init_orc_entry(&orc, cfi))
+				/* errors are reported on the original insn */
+				if (init_orc_entry(&orc, cfi, insn))
 					return -1;
 				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
 					continue;
