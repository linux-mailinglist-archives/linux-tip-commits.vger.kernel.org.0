Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12CFD987
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfKOJnc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:43:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKOJna (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8H-0004R5-DM; Fri, 15 Nov 2019 10:43:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1F3611C18B4;
        Fri, 15 Nov 2019 10:43:13 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:12 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.529086974@infradead.org>
References: <20191111132457.529086974@infradead.org>
MIME-Version: 1.0
Message-ID: <157381099273.29467.15563900217644909068.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     8c7eebc10687af45ac8e40ad1bac0cf7893dba9f
Gitweb:        https://git.kernel.org/tip/8c7eebc10687af45ac8e40ad1bac0cf7893dba9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 05 Jun 2019 10:48:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:41 +01:00

x86/alternatives: Teach text_poke_bp() to emulate instructions

In preparation for static_call and variable size jump_label support,
teach text_poke_bp() to emulate instructions, namely:

  JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5, INT3

The current text_poke_bp() takes a @handler argument which is used as
a jump target when the temporary INT3 is hit by a different CPU.

When patching CALL instructions, this doesn't work because we'd miss
the PUSH of the return address. Instead, teach poke_int3_handler() to
emulate an instruction, typically the instruction we're patching in.

This fits almost all text_poke_bp() users, except
arch_unoptimize_kprobe() which restores random text, and for that site
we have to build an explicit emulate instruction.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.529086974@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  24 +++--
 arch/x86/kernel/alternative.c        | 132 +++++++++++++++++++-------
 arch/x86/kernel/jump_label.c         |   9 +--
 arch/x86/kernel/kprobes/opt.c        |  11 +-
 4 files changed, 130 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 5e8319b..23c626a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -26,10 +26,11 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define POKE_MAX_OPCODE_SIZE	5
 
 struct text_poke_loc {
-	void *detour;
 	void *addr;
-	size_t len;
-	const char opcode[POKE_MAX_OPCODE_SIZE];
+	int len;
+	s32 rel32;
+	u8 opcode;
+	const u8 text[POKE_MAX_OPCODE_SIZE];
 };
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -51,8 +52,10 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
+extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+			       const void *opcode, size_t len, const void *emulate);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
@@ -63,8 +66,17 @@ static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 	regs->ip = ip;
 }
 
-#define INT3_INSN_SIZE 1
-#define CALL_INSN_SIZE 5
+#define INT3_INSN_SIZE		1
+#define INT3_INSN_OPCODE	0xCC
+
+#define CALL_INSN_SIZE		5
+#define CALL_INSN_OPCODE	0xE8
+
+#define JMP32_INSN_SIZE		5
+#define JMP32_INSN_OPCODE	0xE9
+
+#define JMP8_INSN_SIZE		2
+#define JMP8_INSN_OPCODE	0xEB
 
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9d3a971..9ec463f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -956,16 +956,15 @@ NOKPROBE_SYMBOL(patch_cmp);
 int poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_loc *tp;
-	unsigned char int3 = 0xcc;
 	void *ip;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching.nr_entries.
 	 *
-	 * 	nr_entries != 0			INT3
-	 * 	WMB				RMB
-	 * 	write INT3			if (nr_entries)
+	 *	nr_entries != 0			INT3
+	 *	WMB				RMB
+	 *	write INT3			if (nr_entries)
 	 *
 	 * Idem for other elements in bp_patching.
 	 */
@@ -978,9 +977,9 @@ int poke_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	/*
-	 * Discount the sizeof(int3). See text_poke_bp_batch().
+	 * Discount the INT3. See text_poke_bp_batch().
 	 */
-	ip = (void *) regs->ip - sizeof(int3);
+	ip = (void *) regs->ip - INT3_INSN_SIZE;
 
 	/*
 	 * Skip the binary search if there is a single member in the vector.
@@ -997,8 +996,28 @@ int poke_int3_handler(struct pt_regs *regs)
 			return 0;
 	}
 
-	/* set up the specified breakpoint detour */
-	regs->ip = (unsigned long) tp->detour;
+	ip += tp->len;
+
+	switch (tp->opcode) {
+	case INT3_INSN_OPCODE:
+		/*
+		 * Someone poked an explicit INT3, they'll want to handle it,
+		 * do not consume.
+		 */
+		return 0;
+
+	case CALL_INSN_OPCODE:
+		int3_emulate_call(regs, (long)ip + tp->rel32);
+		break;
+
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		int3_emulate_jmp(regs, (long)ip + tp->rel32);
+		break;
+
+	default:
+		BUG();
+	}
 
 	return 1;
 }
@@ -1014,7 +1033,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  * synchronization using int3 breakpoint.
  *
  * The way it is done:
- * 	- For each entry in the vector:
+ *	- For each entry in the vector:
  *		- add a int3 trap to the address that will be patched
  *	- sync cores
  *	- For each entry in the vector:
@@ -1027,9 +1046,9 @@ NOKPROBE_SYMBOL(poke_int3_handler);
  */
 void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
-	int patched_all_but_first = 0;
-	unsigned char int3 = 0xcc;
+	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
+	int do_sync;
 
 	lockdep_assert_held(&text_mutex);
 
@@ -1053,16 +1072,16 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
-	for (i = 0; i < nr_entries; i++) {
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		if (tp[i].len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
-				  (const char *)tp[i].opcode + sizeof(int3),
+				  (const char *)tp[i].text + sizeof(int3),
 				  tp[i].len - sizeof(int3));
-			patched_all_but_first++;
+			do_sync++;
 		}
 	}
 
-	if (patched_all_but_first) {
+	if (do_sync) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -1075,10 +1094,17 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
 	 */
-	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
+	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		if (tp[i].text[0] == INT3_INSN_OPCODE)
+			continue;
+
+		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		do_sync++;
+	}
+
+	if (do_sync)
+		on_each_cpu(do_sync_core, NULL, 1);
 
-	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
@@ -1087,6 +1113,60 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 	bp_patching.nr_entries = 0;
 }
 
+void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+			const void *opcode, size_t len, const void *emulate)
+{
+	struct insn insn;
+
+	if (!opcode)
+		opcode = (void *)tp->text;
+	else
+		memcpy((void *)tp->text, opcode, len);
+
+	if (!emulate)
+		emulate = opcode;
+
+	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+
+	BUG_ON(!insn_complete(&insn));
+	BUG_ON(len != insn.length);
+
+	tp->addr = addr;
+	tp->len = len;
+	tp->opcode = insn.opcode.bytes[0];
+
+	switch (tp->opcode) {
+	case INT3_INSN_OPCODE:
+		break;
+
+	case CALL_INSN_OPCODE:
+	case JMP32_INSN_OPCODE:
+	case JMP8_INSN_OPCODE:
+		tp->rel32 = insn.immediate.value;
+		break;
+
+	default: /* assume NOP */
+		switch (len) {
+		case 2: /* NOP2 -- emulate as JMP8+0 */
+			BUG_ON(memcmp(emulate, ideal_nops[len], len));
+			tp->opcode = JMP8_INSN_OPCODE;
+			tp->rel32 = 0;
+			break;
+
+		case 5: /* NOP5 -- emulate as JMP32+0 */
+			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
+			tp->opcode = JMP32_INSN_OPCODE;
+			tp->rel32 = 0;
+			break;
+
+		default: /* unknown instruction */
+			BUG();
+		}
+		break;
+	}
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -1098,20 +1178,10 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct text_poke_loc tp = {
-		.detour = handler,
-		.addr = addr,
-		.len = len,
-	};
-
-	if (len > POKE_MAX_OPCODE_SIZE) {
-		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
-		return;
-	}
-
-	memcpy((void *)tp.opcode, opcode, len);
+	struct text_poke_loc tp;
 
+	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 0440532..c1a8b9e 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -89,8 +89,7 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
-		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
@@ -147,11 +146,9 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 	}
 
 	__jump_label_set_jump_code(entry, type,
-				   (union jump_code_union *) &tp->opcode, 0);
+				   (union jump_code_union *)&tp->text, 0);
 
-	tp->addr = entry_code;
-	tp->detour = entry_code + JUMP_LABEL_NOP_SIZE;
-	tp->len = JUMP_LABEL_NOP_SIZE;
+	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
 
 	tp_vec_nr++;
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index b348dd5..8900329 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -437,8 +437,7 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buff[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-			     op->optinsn.insn);
+		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE, NULL);
 
 		list_del_init(&op->list);
 	}
@@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_head *oplist)
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	u8 insn_buff[RELATIVEJUMP_SIZE];
+	u8 emulate_buff[RELATIVEJUMP_SIZE];
 
 	/* Set int3 to first byte for kprobes */
 	insn_buff[0] = BREAKPOINT_INSTRUCTION;
 	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
+
+	emulate_buff[0] = RELATIVEJUMP_OPCODE;
+	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
+			((long)op->kp.addr + RELATIVEJUMP_SIZE));
+
 	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-		     op->optinsn.insn);
+		     emulate_buff);
 }
 
 /*
