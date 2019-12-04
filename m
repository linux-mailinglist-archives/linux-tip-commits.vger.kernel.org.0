Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF6112519
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2019 09:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLDIdx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Dec 2019 03:33:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfLDIdx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6O-0005Lf-8k; Wed, 04 Dec 2019 09:33:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F39981C265B;
        Wed,  4 Dec 2019 09:33:36 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternative: Add text_opcode_size()
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132457.875666061@infradead.org>
References: <20191111132457.875666061@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841687.21853.7672694301829898415.tip-bot2@tip-bot2>
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

Commit-ID:     254d2c04515ea4532a503cc5d8649e1513042e56
Gitweb:        https://git.kernel.org/tip/254d2c04515ea4532a503cc5d8649e1513042e56
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 12:44:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/alternative: Add text_opcode_size()

Introduce a common helper to map *_INSN_OPCODE to *_INSN_SIZE.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132457.875666061@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h | 43 +++++++++++++++++++--------
 arch/x86/kernel/alternative.c        | 12 +--------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 95beb85..93e4266 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -49,18 +49,6 @@ extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
 
-extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
-
-extern int after_bootmem;
-extern __ro_after_init struct mm_struct *poking_mm;
-extern __ro_after_init unsigned long poking_addr;
-
-#ifndef CONFIG_UML_X86
-static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
-{
-	regs->ip = ip;
-}
-
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
@@ -73,6 +61,37 @@ static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+static inline int text_opcode_size(u8 opcode)
+{
+	int size = 0;
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
+#undef __CASE
+
+	return size;
+}
+
+extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+
+extern int after_bootmem;
+extern __ro_after_init struct mm_struct *poking_mm;
+extern __ro_after_init unsigned long poking_addr;
+
+#ifndef CONFIG_UML_X86
+static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+{
+	regs->ip = ip;
+}
+
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ce737f1..f8f34f9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1259,22 +1259,12 @@ union text_poke_insn {
 void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
 {
 	static union text_poke_insn insn; /* text_mutex */
-	int size = 0;
+	int size = text_opcode_size(opcode);
 
 	lockdep_assert_held(&text_mutex);
 
 	insn.opcode = opcode;
 
-#define __CASE(insn)	\
-	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
-
-	switch(opcode) {
-	__CASE(INT3);
-	__CASE(CALL);
-	__CASE(JMP32);
-	__CASE(JMP8);
-	}
-
 	if (size > 1) {
 		insn.disp = (long)dest - (long)(addr + size);
 		if (size == 2)
