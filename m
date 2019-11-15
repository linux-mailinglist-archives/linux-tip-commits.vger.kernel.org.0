Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64C7FD99C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOJnZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:43:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJnY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8G-0004Ph-1C; Fri, 15 Nov 2019 10:43:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A5DEF1C08AC;
        Fri, 15 Nov 2019 10:43:11 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:11 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternatives: Add and use text_gen_insn() helper
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.703538332@infradead.org>
References: <20191111132457.703538332@infradead.org>
MIME-Version: 1.0
Message-ID: <157381099109.29467.17575049624907378163.tip-bot2@tip-bot2>
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

Commit-ID:     7eb9fe7b170c81970cc14a9f6bcfed063c2e9ab6
Gitweb:        https://git.kernel.org/tip/7eb9fe7b170c81970cc14a9f6bcfed063c2e9ab6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 03 Oct 2019 14:50:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:42 +01:00

x86/alternatives: Add and use text_gen_insn() helper

Provide a simple helper function to create common instruction
encodings.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.703538332@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  2 ++-
 arch/x86/kernel/alternative.c        | 36 +++++++++++++++++++++++++++-
 arch/x86/kernel/jump_label.c         | 31 ++++++++---------------
 arch/x86/kernel/kprobes/opt.c        |  7 +-----
 4 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 3bcd266..95beb85 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -49,6 +49,8 @@ extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
+extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 42e7f0a..714b4a2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1237,3 +1237,39 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulat
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
+
+union text_poke_insn {
+	u8 text[POKE_MAX_OPCODE_SIZE];
+	struct {
+		u8 opcode;
+		s32 disp;
+	} __attribute__((packed));
+};
+
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* text_mutex */
+	int size = 0;
+
+	lockdep_assert_held(&text_mutex);
+
+	insn.opcode = opcode;
+
+#define __CASE(insn)	\
+	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
+
+	switch(opcode) {
+	__CASE(INT3);
+	__CASE(CALL);
+	__CASE(JMP32);
+	__CASE(JMP8);
+	}
+
+	if (size > 1) {
+		insn.disp = (long)dest - (long)(addr + size);
+		if (size == 2)
+			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+	}
+
+	return &insn.text;
+}
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index cf8c847..9c4498e 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,15 +16,7 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-union jump_code_union {
-	char code[JUMP_LABEL_NOP_SIZE];
-	struct {
-		char jump;
-		int offset;
-	} __attribute__((packed));
-};
-
-static void bug_at(unsigned char *ip, int line)
+static void bug_at(const void *ip, int line)
 {
 	/*
 	 * The location is not an op that we were expecting.
@@ -38,33 +30,32 @@ static void bug_at(unsigned char *ip, int line)
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
 {
-	static union jump_code_union code; /* relies on text_mutex */
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *expect;
+	const void *expect, *code;
+	const void *addr, *dest;
 	int line;
 
-	lockdep_assert_held(&text_mutex);
+	addr = (void *)jump_entry_code(entry);
+	dest = (void *)jump_entry_target(entry);
 
-	code.jump = JMP32_INSN_OPCODE;
-	code.offset = jump_entry_target(entry) -
-		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
 	if (init) {
 		expect = default_nop; line = __LINE__;
 	} else if (type == JUMP_LABEL_JMP) {
 		expect = ideal_nop; line = __LINE__;
 	} else {
-		expect = code.code; line = __LINE__;
+		expect = code; line = __LINE__;
 	}
 
-	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
-		bug_at((void *)jump_entry_code(entry), line);
+	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
+		bug_at(addr, line);
 
 	if (type == JUMP_LABEL_NOP)
-		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+		code = ideal_nop;
 
-	return &code;
+	return code;
 }
 
 static void inline __jump_label_transform(struct jump_entry *entry,
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 8900329..9b01ee7 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -447,18 +447,13 @@ void arch_optimize_kprobes(struct list_head *oplist)
 void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	u8 insn_buff[RELATIVEJUMP_SIZE];
-	u8 emulate_buff[RELATIVEJUMP_SIZE];
 
 	/* Set int3 to first byte for kprobes */
 	insn_buff[0] = BREAKPOINT_INSTRUCTION;
 	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
 
-	emulate_buff[0] = RELATIVEJUMP_OPCODE;
-	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
-			((long)op->kp.addr + RELATIVEJUMP_SIZE));
-
 	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
-		     emulate_buff);
+		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
 }
 
 /*
