Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94B2FAC3A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbhARVBZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 16:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389758AbhARKOh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CBC061574;
        Mon, 18 Jan 2021 02:13:32 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:13:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nPRQgqrk7AA6WWZoc1Cg2/6pT2I+bT5CrRBPZj7PCX0=;
        b=nKHHXJkoYf1iGuqVWZ63xFkuACt5Q3Oc8fsP7bQ9xn0f25PKu+zdlEKeofUdnuHvHGiq1M
        CCMnAtOjrOEIiyF+/hlxrl08+Zz6XoumO/BQ/dXUnCfrQ+FClSLO3MpDZz1Yl1PnvotyHV
        5gbQrvQnX8w1ErK7vOlDiq7MfuSP+RvghujhJY7ye25Vj8woQCugqzSSPUxeD9ZUvFoiYJ
        hQDAufvKTlSYj6cD7w6KhQfLr7GmDuHQWFZ51+qR0a5HpWrLlp1wk0U3lYzHT1OXbqszix
        00KxolwqfVHIdbkIgxt4P3gj28SjNJiH53X0VF6/hDqMrBw/BO1jNbxd5D20Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nPRQgqrk7AA6WWZoc1Cg2/6pT2I+bT5CrRBPZj7PCX0=;
        b=U8L+Z1GnWTQU63WUJMiqoW9fbVCkmlTn043u8SFBvp9Bat5tka/EqCKQPnJDUbhF4kGVUX
        w1cenwT9zdk/ZhCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support stack layout changes in alternatives
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096480978.414.11066750423049394995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c9c324dc22aab1687da37001b321b6dfa93a0699
Gitweb:        https://git.kernel.org/tip/c9c324dc22aab1687da37001b321b6dfa93a0699
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 18 Dec 2020 14:26:21 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 14 Jan 2021 09:53:54 -06:00

objtool: Support stack layout changes in alternatives

The ORC unwinder showed a warning [1] which revealed the stack layout
didn't match what was expected.  The problem was that paravirt patching
had replaced "CALL *pv_ops.irq.save_fl" with "PUSHF;POP".  That changed
the stack layout between the PUSHF and the POP, so unwinding from an
interrupt which occurred between those two instructions would fail.

Part of the agreed upon solution was to rework the custom paravirt
patching code to use alternatives instead, since objtool already knows
how to read alternatives (and converging runtime patching infrastructure
is always a good thing anyway).  But the main problem still remains,
which is that runtime patching can change the stack layout.

Making stack layout changes in alternatives was disallowed with commit
7117f16bf460 ("objtool: Fix ORC vs alternatives"), but now that paravirt
is going to be doing it, it needs to be supported.

One way to do so would be to modify the ORC table when the code gets
patched.  But ORC is simple -- a good thing! -- and it's best to leave
it alone.

Instead, support stack layout changes by "flattening" all possible stack
states (CFI) from parallel alternative code streams into a single set of
linear states.  The only necessary limitation is that CFI conflicts are
disallowed at all possible instruction boundaries.

For example, this scenario is allowed:

          Alt1                    Alt2                    Alt3

   0x00   CALL *pv_ops.save_fl    CALL xen_save_fl        PUSHF
   0x01                                                   POP %RAX
   0x02                                                   NOP
   ...
   0x05                           NOP
   ...
   0x07   <insn>

The unwind information for offset-0x00 is identical for all 3
alternatives.  Similarly offset-0x05 and higher also are identical (and
the same as 0x00).  However offset-0x01 has deviating CFI, but that is
only relevant for Alt3, neither of the other alternative instruction
streams will ever hit that offset.

This scenario is NOT allowed:

          Alt1                    Alt2

   0x00   CALL *pv_ops.save_fl    PUSHF
   0x01                           NOP6
   ...
   0x07   NOP                     POP %RAX

The problem here is that offset-0x7, which is an instruction boundary in
both possible instruction patch streams, has two conflicting stack
layouts.

[ The above examples were stolen from Peter Zijlstra. ]

The new flattened CFI array is used both for the detection of conflicts
(like the second example above) and the generation of linear ORC
entries.

BTW, another benefit of these changes is that, thanks to some related
cleanups (new fake nops and alt_group struct) objtool can finally be rid
of fake jumps, which were a constant source of headaches.

[1] https://lkml.kernel.org/r/20201111170536.arx2zbn4ngvjoov7@treble

Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Documentation/stack-validation.txt |  16 +-
 tools/objtool/check.c                            | 192 +++++++-------
 tools/objtool/include/objtool/check.h            |   6 +-
 tools/objtool/orc_gen.c                          |  56 +++-
 4 files changed, 159 insertions(+), 111 deletions(-)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 0542e46..30f38fd 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -315,13 +315,15 @@ they mean, and suggestions for how to fix them.
       function tracing inserts additional calls, which is not obvious from the
       sources).
 
-10. file.o: warning: func()+0x5c: alternative modifies stack
-
-    This means that an alternative includes instructions that modify the
-    stack. The problem is that there is only one ORC unwind table, this means
-    that the ORC unwind entries must be valid for each of the alternatives.
-    The easiest way to enforce this is to ensure alternatives do not contain
-    any ORC entries, which in turn implies the above constraint.
+10. file.o: warning: func()+0x5c: stack layout conflict in alternatives
+
+    This means that in the use of the alternative() or ALTERNATIVE()
+    macro, the code paths have conflicting modifications to the stack.
+    The problem is that there is only one ORC unwind table, which means
+    that the ORC unwind entries must be consistent for all possible
+    instruction boundaries regardless of which code has been patched.
+    This limitation can be overcome by massaging the alternatives with
+    NOPs to shift the stack changes around so they no longer conflict.
 
 11. file.o: warning: unannotated intra-function call
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9aa324b..270b507 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,8 +20,6 @@
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
 
-#define FAKE_JUMP_OFFSET -1
-
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
@@ -775,9 +773,6 @@ static int add_jump_destinations(struct objtool_file *file)
 		if (!is_static_jump(insn))
 			continue;
 
-		if (insn->offset == FAKE_JUMP_OFFSET)
-			continue;
-
 		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
 		if (!reloc) {
@@ -971,28 +966,15 @@ static int add_call_destinations(struct objtool_file *file)
 }
 
 /*
- * The .alternatives section requires some extra special care, over and above
- * what other special sections require:
- *
- * 1. Because alternatives are patched in-place, we need to insert a fake jump
- *    instruction at the end so that validate_branch() skips all the original
- *    replaced instructions when validating the new instruction path.
- *
- * 2. An added wrinkle is that the new instruction length might be zero.  In
- *    that case the old instructions are replaced with noops.  We simulate that
- *    by creating a fake jump as the only new instruction.
- *
- * 3. In some cases, the alternative section includes an instruction which
- *    conditionally jumps to the _end_ of the entry.  We have to modify these
- *    jumps' destinations to point back to .text rather than the end of the
- *    entry in .altinstr_replacement.
+ * The .alternatives section requires some extra special care over and above
+ * other special sections because alternatives are patched in place.
  */
 static int handle_group_alt(struct objtool_file *file,
 			    struct special_alt *special_alt,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	struct instruction *last_orig_insn, *last_new_insn = NULL, *insn, *nop = NULL;
 	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
 
@@ -1002,6 +984,13 @@ static int handle_group_alt(struct objtool_file *file,
 		WARN("malloc failed");
 		return -1;
 	}
+	orig_alt_group->cfi = calloc(special_alt->orig_len,
+				     sizeof(struct cfi_state *));
+	if (!orig_alt_group->cfi) {
+		WARN("calloc failed");
+		return -1;
+	}
+
 	last_orig_insn = NULL;
 	insn = orig_insn;
 	sec_for_each_insn_from(file, insn) {
@@ -1015,42 +1004,45 @@ static int handle_group_alt(struct objtool_file *file,
 	orig_alt_group->first_insn = orig_insn;
 	orig_alt_group->last_insn = last_orig_insn;
 
-	if (next_insn_same_sec(file, last_orig_insn)) {
-		fake_jump = malloc(sizeof(*fake_jump));
-		if (!fake_jump) {
-			WARN("malloc failed");
-			return -1;
-		}
-		memset(fake_jump, 0, sizeof(*fake_jump));
-		INIT_LIST_HEAD(&fake_jump->alts);
-		INIT_LIST_HEAD(&fake_jump->stack_ops);
-		init_cfi_state(&fake_jump->cfi);
 
-		fake_jump->sec = special_alt->new_sec;
-		fake_jump->offset = FAKE_JUMP_OFFSET;
-		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
-		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-		fake_jump->func = orig_insn->func;
+	new_alt_group = malloc(sizeof(*new_alt_group));
+	if (!new_alt_group) {
+		WARN("malloc failed");
+		return -1;
 	}
 
-	if (!special_alt->new_len) {
-		if (!fake_jump) {
-			WARN("%s: empty alternative at end of section",
-			     special_alt->orig_sec->name);
+	if (special_alt->new_len < special_alt->orig_len) {
+		/*
+		 * Insert a fake nop at the end to make the replacement
+		 * alt_group the same size as the original.  This is needed to
+		 * allow propagate_alt_cfi() to do its magic.  When the last
+		 * instruction affects the stack, the instruction after it (the
+		 * nop) will propagate the new state to the shared CFI array.
+		 */
+		nop = malloc(sizeof(*nop));
+		if (!nop) {
+			WARN("malloc failed");
 			return -1;
 		}
+		memset(nop, 0, sizeof(*nop));
+		INIT_LIST_HEAD(&nop->alts);
+		INIT_LIST_HEAD(&nop->stack_ops);
+		init_cfi_state(&nop->cfi);
 
-		*new_insn = fake_jump;
-		return 0;
+		nop->sec = special_alt->new_sec;
+		nop->offset = special_alt->new_off + special_alt->new_len;
+		nop->len = special_alt->orig_len - special_alt->new_len;
+		nop->type = INSN_NOP;
+		nop->func = orig_insn->func;
+		nop->alt_group = new_alt_group;
+		nop->ignore = orig_insn->ignore_alts;
 	}
 
-	new_alt_group = malloc(sizeof(*new_alt_group));
-	if (!new_alt_group) {
-		WARN("malloc failed");
-		return -1;
+	if (!special_alt->new_len) {
+		*new_insn = nop;
+		goto end;
 	}
 
-	last_new_insn = NULL;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		struct reloc *alt_reloc;
@@ -1089,14 +1081,8 @@ static int handle_group_alt(struct objtool_file *file,
 			continue;
 
 		dest_off = arch_jump_destination(insn);
-		if (dest_off == special_alt->new_off + special_alt->new_len) {
-			if (!fake_jump) {
-				WARN("%s: alternative jump to end of section",
-				     special_alt->orig_sec->name);
-				return -1;
-			}
-			insn->jump_dest = fake_jump;
-		}
+		if (dest_off == special_alt->new_off + special_alt->new_len)
+			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -1111,13 +1097,13 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	if (nop)
+		list_add(&nop->list, &last_new_insn->list);
+end:
 	new_alt_group->orig_group = orig_alt_group;
 	new_alt_group->first_insn = *new_insn;
-	new_alt_group->last_insn = last_new_insn;
-
-	if (fake_jump)
-		list_add(&fake_jump->list, &last_new_insn->list);
-
+	new_alt_group->last_insn = nop ? : last_new_insn;
+	new_alt_group->cfi = orig_alt_group->cfi;
 	return 0;
 }
 
@@ -2248,22 +2234,47 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 	return 0;
 }
 
-static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+/*
+ * The stack layouts of alternatives instructions can sometimes diverge when
+ * they have stack modifications.  That's fine as long as the potential stack
+ * layouts don't conflict at any given potential instruction boundary.
+ *
+ * Flatten the CFIs of the different alternative code streams (both original
+ * and replacement) into a single shared CFI array which can be used to detect
+ * conflicts and nicely feed a linear array of ORC entries to the unwinder.
+ */
+static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn)
 {
-	struct stack_op *op;
+	struct cfi_state **alt_cfi;
+	int group_off;
 
-	list_for_each_entry(op, &insn->stack_ops, list) {
-		struct cfi_state old_cfi = state->cfi;
-		int res;
+	if (!insn->alt_group)
+		return 0;
 
-		res = update_cfi_state(insn, &state->cfi, op);
-		if (res)
-			return res;
+	alt_cfi = insn->alt_group->cfi;
+	group_off = insn->offset - insn->alt_group->first_insn->offset;
 
-		if (insn->alt_group && memcmp(&state->cfi, &old_cfi, sizeof(struct cfi_state))) {
-			WARN_FUNC("alternative modifies stack", insn->sec, insn->offset);
+	if (!alt_cfi[group_off]) {
+		alt_cfi[group_off] = &insn->cfi;
+	} else {
+		if (memcmp(alt_cfi[group_off], &insn->cfi, sizeof(struct cfi_state))) {
+			WARN_FUNC("stack layout conflict in alternatives",
+				  insn->sec, insn->offset);
 			return -1;
 		}
+	}
+
+	return 0;
+}
+
+static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+{
+	struct stack_op *op;
+
+	list_for_each_entry(op, &insn->stack_ops, list) {
+
+		if (update_cfi_state(insn, &state->cfi, op))
+			return 1;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
 			if (!state->uaccess_stack) {
@@ -2453,28 +2464,20 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
-/*
- * Alternatives should not contain any ORC entries, this in turn means they
- * should not contain any CFI ops, which implies all instructions should have
- * the same same CFI state.
- *
- * It is possible to constuct alternatives that have unreachable holes that go
- * unreported (because they're NOPs), such holes would result in CFI_UNDEFINED
- * states which then results in ORC entries, which we just said we didn't want.
- *
- * Avoid them by copying the CFI entry of the first instruction into the whole
- * alternative.
- */
-static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
+static struct instruction *next_insn_to_validate(struct objtool_file *file,
+						 struct instruction *insn)
 {
-	struct instruction *first_insn = insn;
 	struct alt_group *alt_group = insn->alt_group;
 
-	sec_for_each_insn_continue(file, insn) {
-		if (insn->alt_group != alt_group)
-			break;
-		insn->cfi = first_insn->cfi;
-	}
+	/*
+	 * Simulate the fact that alternatives are patched in-place.  When the
+	 * end of a replacement alt_group is reached, redirect objtool flow to
+	 * the end of the original alt_group.
+	 */
+	if (alt_group && insn == alt_group->last_insn && alt_group->orig_group)
+		return next_insn_same_sec(file, alt_group->orig_group->last_insn);
+
+	return next_insn_same_sec(file, insn);
 }
 
 /*
@@ -2495,7 +2498,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	sec = insn->sec;
 
 	while (1) {
-		next_insn = next_insn_same_sec(file, insn);
+		next_insn = next_insn_to_validate(file, insn);
 
 		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
@@ -2528,6 +2531,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		insn->visited |= visited;
 
+		if (propagate_alt_cfi(file, insn))
+			return 1;
+
 		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
 			bool skip_orig = false;
 
@@ -2543,9 +2549,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 			}
 
-			if (insn->alt_group)
-				fill_alternative_cfi(file, insn);
-
 			if (skip_orig)
 				return 0;
 		}
@@ -2779,9 +2782,6 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
-	if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->offset == FAKE_JUMP_OFFSET)
-		return true;
-
 	if (!insn->func)
 		return false;
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 7893e97..f4e041f 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -28,6 +28,12 @@ struct alt_group {
 
 	/* First and last instructions in the group */
 	struct instruction *first_insn, *last_insn;
+
+	/*
+	 * Byte-offset-addressed len-sized array of pointers to CFI structs.
+	 * This is shared with the other alt_groups in the same alternative.
+	 */
+	struct cfi_state **cfi;
 };
 
 struct instruction {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 38e1a8d..738aa50 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -144,6 +144,13 @@ static int orc_list_add(struct list_head *orc_list, struct orc_entry *orc,
 	return 0;
 }
 
+static unsigned long alt_group_len(struct alt_group *alt_group)
+{
+	return alt_group->last_insn->offset +
+	       alt_group->last_insn->len -
+	       alt_group->first_insn->offset;
+}
+
 int orc_create(struct objtool_file *file)
 {
 	struct section *sec, *ip_rsec, *orc_sec;
@@ -168,15 +175,48 @@ int orc_create(struct objtool_file *file)
 			continue;
 
 		sec_for_each_insn(file, sec, insn) {
-			if (init_orc_entry(&orc, &insn->cfi))
-				return -1;
-			if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+			struct alt_group *alt_group = insn->alt_group;
+			int i;
+
+			if (!alt_group) {
+				if (init_orc_entry(&orc, &insn->cfi))
+					return -1;
+				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+					continue;
+				if (orc_list_add(&orc_list, &orc, sec,
+						 insn->offset))
+					return -1;
+				nr++;
+				prev_orc = orc;
+				empty = false;
 				continue;
-			if (orc_list_add(&orc_list, &orc, sec, insn->offset))
-				return -1;
-			nr++;
-			prev_orc = orc;
-			empty = false;
+			}
+
+			/*
+			 * Alternatives can have different stack layout
+			 * possibilities (but they shouldn't conflict).
+			 * Instead of traversing the instructions, use the
+			 * alt_group's flattened byte-offset-addressed CFI
+			 * array.
+			 */
+			for (i = 0; i < alt_group_len(alt_group); i++) {
+				struct cfi_state *cfi = alt_group->cfi[i];
+				if (!cfi)
+					continue;
+				if (init_orc_entry(&orc, cfi))
+					return -1;
+				if (!memcmp(&prev_orc, &orc, sizeof(orc)))
+					continue;
+				if (orc_list_add(&orc_list, &orc, insn->sec,
+						 insn->offset + i))
+					return -1;
+				nr++;
+				prev_orc = orc;
+				empty = false;
+			}
+
+			/* Skip to the end of the alt_group */
+			insn = alt_group->last_insn;
 		}
 
 		/* Add a section terminator */
