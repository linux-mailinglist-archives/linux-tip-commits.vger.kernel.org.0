Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93EB346295
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhCWPPU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhCWPPL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:15:11 -0400
Date:   Tue, 23 Mar 2021 15:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=910XNFfzt2+OyG4wvW2H1UPtsCsCeTOM5pjiOLRLVNA=;
        b=hpcD5D6wHRwrA3w2ucUwJMH1WDmAJuUtcxEPokV1ZCeGgMA8fU7Iuosy+zE6xDvEI4z4gR
        39ACt00KQt8RCuz6YwHmp6/ZJuNVSj5RnOigLtgKsrnmtXgHOFCBYL1C/h9kxzh1bP7xwg
        S6LLVMTdQV6gRQhhfmYbS+OQQ3EQeNY/JERAu5RDZHB666VG4CexEUt+E2cUF+X1LpL5y5
        cWmraTYunejdWdU/55YpLFFHpmQpE3dxIL2rB/Fnmvkel4j2ZNTtMWM4SF4XKf+HabOyD/
        9Ckh6aqJTYIZVnXsV8Y0yQW7doXR+dZRMyPGb+jEmpQttEUyyl/FndSANAZ4KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=910XNFfzt2+OyG4wvW2H1UPtsCsCeTOM5pjiOLRLVNA=;
        b=CetcnKZpYt6A9VqN6J9n3n6FaA9Css8CFBif4f3oNjTUWePmE+I05BfUfkIyZbxHn5F8K0
        a7XXbYw3W1SEARDQ==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Use int3 instead of debug trap for single-step
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161469874601.49483.11985325887166921076.stgit@devnote2>
References: <161469874601.49483.11985325887166921076.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <161651250885.398.9194619892260347744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6256e668b7af9d81472e03c6a171630c08f8858a
Gitweb:        https://git.kernel.org/tip/6256e668b7af9d81472e03c6a171630c08f8858a
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 03 Mar 2021 00:25:46 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:07:56 +01:00

x86/kprobes: Use int3 instead of debug trap for single-step

Use int3 instead of debug trap exception for single-stepping the
probed instructions. Some instructions which change the ip
registers or modify IF flags are emulated because those are not
able to be single-stepped by int3 or may allow the interrupt
while single-stepping.

This actually changes the kprobes behavior.

- kprobes can not probe following instructions; int3, iret,
  far jmp/call which get absolute address as immediate,
  indirect far jmp/call, indirect near jmp/call with addressing
  by memory (register-based indirect jmp/call are OK), and
  vmcall/vmlaunch/vmresume/vmxoff.

- If the kprobe post_handler doesn't set before registering,
  it may not be called in some case even if you set it afterwards.
  (IOW, kprobe booster is enabled at registration, user can not
   change it)

But both are rare issue, unsupported instructions will not be
used in the kernel (or rarely used), and post_handlers are
rarely used (I don't see it except for the test code).

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469874601.49483.11985325887166921076.stgit@devnote2
---
 arch/x86/include/asm/kprobes.h |  21 +-
 arch/x86/kernel/kprobes/core.c | 517 ++++++++++++++++++++------------
 arch/x86/kernel/traps.c        |   3 +-
 3 files changed, 353 insertions(+), 188 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index d20a3d6..bd7f588 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -65,10 +65,22 @@ struct arch_specific_insn {
 	 * a post_handler).
 	 */
 	unsigned boostable:1;
-	unsigned if_modifier:1;
-	unsigned is_call:1;
-	unsigned is_pushf:1;
-	unsigned is_abs_ip:1;
+	unsigned char size;	/* The size of insn */
+	union {
+		unsigned char opcode;
+		struct {
+			unsigned char type;
+		} jcc;
+		struct {
+			unsigned char type;
+			unsigned char asize;
+		} loop;
+		struct {
+			unsigned char reg;
+		} indirect;
+	};
+	s32 rel32;	/* relative offset must be s32, s16, or s8 */
+	void (*emulate_op)(struct kprobe *p, struct pt_regs *regs);
 	/* Number of bytes of text poked */
 	int tp_len;
 };
@@ -107,7 +119,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 extern int kprobe_int3_handler(struct pt_regs *regs);
-extern int kprobe_debug_handler(struct pt_regs *regs);
 
 #else
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f6ec57f..3a14e8a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -177,6 +177,9 @@ int can_boost(struct insn *insn, void *addr)
 	case 0xf0:
 		/* clear and set flags are boostable */
 		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
+	case 0xff:
+		/* indirect jmp is boostable */
+		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
 		/* CS override prefix and call are not boostable */
 		return (opcode != 0x2e && opcode != 0x9a);
@@ -362,13 +365,14 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	return insn->length;
 }
 
-/* Prepare reljump right after instruction to boost */
-static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
-			  struct insn *insn)
+/* Prepare reljump or int3 right after instruction */
+static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
+			      struct insn *insn)
 {
 	int len = insn->length;
 
-	if (can_boost(insn, p->addr) &&
+	if (!IS_ENABLED(CONFIG_PREEMPTION) &&
+	    !p->post_handler && can_boost(insn, p->addr) &&
 	    MAX_INSN_SIZE - len >= JMP32_INSN_SIZE) {
 		/*
 		 * These instructions can be executed directly if it
@@ -379,7 +383,12 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 		len += JMP32_INSN_SIZE;
 		p->ainsn.boostable = 1;
 	} else {
-		p->ainsn.boostable = 0;
+		/* Otherwise, put an int3 for trapping singlestep */
+		if (MAX_INSN_SIZE - len < INT3_INSN_SIZE)
+			return -ENOSPC;
+
+		buf[len] = INT3_INSN_OPCODE;
+		len += INT3_INSN_SIZE;
 	}
 
 	return len;
@@ -416,42 +425,232 @@ void free_insn_page(void *page)
 	module_memfree(page);
 }
 
-static void set_resume_flags(struct kprobe *p, struct insn *insn)
+/* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
+
+static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
+{
+	switch (p->ainsn.opcode) {
+	case 0xfa:	/* cli */
+		regs->flags &= ~(X86_EFLAGS_IF);
+		break;
+	case 0xfb:	/* sti */
+		regs->flags |= X86_EFLAGS_IF;
+		break;
+	case 0x9c:	/* pushf */
+		int3_emulate_push(regs, regs->flags);
+		break;
+	case 0x9d:	/* popf */
+		regs->flags = int3_emulate_pop(regs);
+		break;
+	}
+	regs->ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ifmodifiers);
+
+static void kprobe_emulate_ret(struct kprobe *p, struct pt_regs *regs)
+{
+	int3_emulate_ret(regs);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_ret);
+
+static void kprobe_emulate_call(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long func = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	func += p->ainsn.rel32;
+	int3_emulate_call(regs, func);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call);
+
+static nokprobe_inline
+void __kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs, bool cond)
+{
+	unsigned long ip = regs->ip - INT3_INSN_SIZE + p->ainsn.size;
+
+	if (cond)
+		ip += p->ainsn.rel32;
+	int3_emulate_jmp(regs, ip);
+}
+
+static void kprobe_emulate_jmp(struct kprobe *p, struct pt_regs *regs)
+{
+	__kprobe_emulate_jmp(p, regs, true);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp);
+
+static const unsigned long jcc_mask[6] = {
+	[0] = X86_EFLAGS_OF,
+	[1] = X86_EFLAGS_CF,
+	[2] = X86_EFLAGS_ZF,
+	[3] = X86_EFLAGS_CF | X86_EFLAGS_ZF,
+	[4] = X86_EFLAGS_SF,
+	[5] = X86_EFLAGS_PF,
+};
+
+static void kprobe_emulate_jcc(struct kprobe *p, struct pt_regs *regs)
+{
+	bool invert = p->ainsn.jcc.type & 1;
+	bool match;
+
+	if (p->ainsn.jcc.type < 0xc) {
+		match = regs->flags & jcc_mask[p->ainsn.jcc.type >> 1];
+	} else {
+		match = ((regs->flags & X86_EFLAGS_SF) >> X86_EFLAGS_SF_BIT) ^
+			((regs->flags & X86_EFLAGS_OF) >> X86_EFLAGS_OF_BIT);
+		if (p->ainsn.jcc.type >= 0xe)
+			match = match && (regs->flags & X86_EFLAGS_ZF);
+	}
+	__kprobe_emulate_jmp(p, regs, (match && !invert) || (!match && invert));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jcc);
+
+static void kprobe_emulate_loop(struct kprobe *p, struct pt_regs *regs)
+{
+	bool match;
+
+	if (p->ainsn.loop.type != 3) {	/* LOOP* */
+		if (p->ainsn.loop.asize == 32)
+			match = ((*(u32 *)&regs->cx)--) != 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = ((*(u64 *)&regs->cx)--) != 0;
+#endif
+		else
+			match = ((*(u16 *)&regs->cx)--) != 0;
+	} else {			/* JCXZ */
+		if (p->ainsn.loop.asize == 32)
+			match = *(u32 *)(&regs->cx) == 0;
+#ifdef CONFIG_X86_64
+		else if (p->ainsn.loop.asize == 64)
+			match = *(u64 *)(&regs->cx) == 0;
+#endif
+		else
+			match = *(u16 *)(&regs->cx) == 0;
+	}
+
+	if (p->ainsn.loop.type == 0)	/* LOOPNE */
+		match = match && !(regs->flags & X86_EFLAGS_ZF);
+	else if (p->ainsn.loop.type == 1)	/* LOOPE */
+		match = match && (regs->flags & X86_EFLAGS_ZF);
+
+	__kprobe_emulate_jmp(p, regs, match);
+}
+NOKPROBE_SYMBOL(kprobe_emulate_loop);
+
+static const int addrmode_regoffs[] = {
+	offsetof(struct pt_regs, ax),
+	offsetof(struct pt_regs, cx),
+	offsetof(struct pt_regs, dx),
+	offsetof(struct pt_regs, bx),
+	offsetof(struct pt_regs, sp),
+	offsetof(struct pt_regs, bp),
+	offsetof(struct pt_regs, si),
+	offsetof(struct pt_regs, di),
+#ifdef CONFIG_X86_64
+	offsetof(struct pt_regs, r8),
+	offsetof(struct pt_regs, r9),
+	offsetof(struct pt_regs, r10),
+	offsetof(struct pt_regs, r11),
+	offsetof(struct pt_regs, r12),
+	offsetof(struct pt_regs, r13),
+	offsetof(struct pt_regs, r14),
+	offsetof(struct pt_regs, r15),
+#endif
+};
+
+static void kprobe_emulate_call_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_call(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_call_indirect);
+
+static void kprobe_emulate_jmp_indirect(struct kprobe *p, struct pt_regs *regs)
+{
+	unsigned long offs = addrmode_regoffs[p->ainsn.indirect.reg];
+
+	int3_emulate_jmp(regs, regs_get_register(regs, offs));
+}
+NOKPROBE_SYMBOL(kprobe_emulate_jmp_indirect);
+
+static int prepare_emulation(struct kprobe *p, struct insn *insn)
 {
 	insn_byte_t opcode = insn->opcode.bytes[0];
 
 	switch (opcode) {
 	case 0xfa:		/* cli */
 	case 0xfb:		/* sti */
+	case 0x9c:		/* pushfl */
 	case 0x9d:		/* popf/popfd */
-		/* Check whether the instruction modifies Interrupt Flag or not */
-		p->ainsn.if_modifier = 1;
-		break;
-	case 0x9c:	/* pushfl */
-		p->ainsn.is_pushf = 1;
+		/*
+		 * IF modifiers must be emulated since it will enable interrupt while
+		 * int3 single stepping.
+		 */
+		p->ainsn.emulate_op = kprobe_emulate_ifmodifiers;
+		p->ainsn.opcode = opcode;
 		break;
-	case 0xcf:	/* iret */
-		p->ainsn.if_modifier = 1;
-		fallthrough;
 	case 0xc2:	/* ret/lret */
 	case 0xc3:
 	case 0xca:
 	case 0xcb:
-	case 0xea:	/* jmp absolute -- ip is correct */
-		/* ip is already adjusted, no more changes required */
-		p->ainsn.is_abs_ip = 1;
-		/* Without resume jump, this is boostable */
-		p->ainsn.boostable = 1;
+		p->ainsn.emulate_op = kprobe_emulate_ret;
 		break;
-	case 0xe8:	/* call relative - Fix return addr */
-		p->ainsn.is_call = 1;
+	case 0x9a:	/* far call absolute -- segment is not supported */
+	case 0xea:	/* far jmp absolute -- segment is not supported */
+	case 0xcc:	/* int3 */
+	case 0xcf:	/* iret -- in-kernel IRET is not supported */
+		return -EOPNOTSUPP;
 		break;
-#ifdef CONFIG_X86_32
-	case 0x9a:	/* call absolute -- same as call absolute, indirect */
-		p->ainsn.is_call = 1;
-		p->ainsn.is_abs_ip = 1;
+	case 0xe8:	/* near call relative */
+		p->ainsn.emulate_op = kprobe_emulate_call;
+		if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0xeb:	/* short jump relative */
+	case 0xe9:	/* near jump relative */
+		p->ainsn.emulate_op = kprobe_emulate_jmp;
+		if (insn->immediate.nbytes == 1)
+			p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
+		else if (insn->immediate.nbytes == 2)
+			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+		else
+			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		break;
+	case 0x70 ... 0x7f:
+		/* 1 byte conditional jump */
+		p->ainsn.emulate_op = kprobe_emulate_jcc;
+		p->ainsn.jcc.type = opcode & 0xf;
+		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		break;
+	case 0x0f:
+		opcode = insn->opcode.bytes[1];
+		if ((opcode & 0xf0) == 0x80) {
+			/* 2 bytes Conditional Jump */
+			p->ainsn.emulate_op = kprobe_emulate_jcc;
+			p->ainsn.jcc.type = opcode & 0xf;
+			if (insn->immediate.nbytes == 2)
+				p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
+			else
+				p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
+		} else if (opcode == 0x01 &&
+			   X86_MODRM_REG(insn->modrm.bytes[0]) == 0 &&
+			   X86_MODRM_MOD(insn->modrm.bytes[0]) == 3) {
+			/* VM extensions - not supported */
+			return -EOPNOTSUPP;
+		}
+		break;
+	case 0xe0:	/* Loop NZ */
+	case 0xe1:	/* Loop */
+	case 0xe2:	/* Loop */
+	case 0xe3:	/* J*CXZ */
+		p->ainsn.emulate_op = kprobe_emulate_loop;
+		p->ainsn.loop.type = opcode & 0x3;
+		p->ainsn.loop.asize = insn->addr_bytes * 8;
+		p->ainsn.rel32 = *(s8 *)&insn->immediate.value;
 		break;
-#endif
 	case 0xff:
 		/*
 		 * Since the 0xff is an extended group opcode, the instruction
@@ -459,46 +658,57 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 		 */
 		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
-			/*
-			 * call absolute, indirect
-			 * Fix return addr; ip is correct.
-			 * But this is not boostable
-			 */
-			p->ainsn.is_call = 1;
-			p->ainsn.is_abs_ip = 1;
-			break;
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far call */
+			/* call absolute, indirect */
+			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
 		} else if ((opcode & 0x30) == 0x20) {
-			/*
-			 * jmp near and far, absolute indirect
-			 * ip is correct.
-			 */
-			p->ainsn.is_abs_ip = 1;
-			/* Without resume jump, this is boostable */
-			p->ainsn.boostable = 1;
-		}
+			if ((opcode & 0x8) == 0x8)
+				return -EOPNOTSUPP;	/* far jmp */
+			/* jmp near absolute indirect */
+			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
+		} else
+			break;
+
+		if (insn->addr_bytes != sizeof(unsigned long))
+			return -EOPNOTSUPP;	/* Don't support differnt size */
+		if (X86_MODRM_MOD(opcode) != 3)
+			return -EOPNOTSUPP;	/* TODO: support memory addressing */
+
+		p->ainsn.indirect.reg = X86_MODRM_RM(opcode);
+#ifdef CONFIG_X86_64
+		if (X86_REX_B(insn->rex_prefix.value))
+			p->ainsn.indirect.reg += 8;
+#endif
+		break;
+	default:
 		break;
 	}
+	p->ainsn.size = insn->length;
+
+	return 0;
 }
 
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	int len;
+	int ret, len;
 
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
 	len = __copy_instruction(buf, p->addr, p->ainsn.insn, &insn);
 	if (!len)
 		return -EINVAL;
 
-	/*
-	 * __copy_instruction can modify the displacement of the instruction,
-	 * but it doesn't affect boostable check.
-	 */
-	len = prepare_boost(buf, p, &insn);
+	/* Analyze the opcode and setup emulate functions */
+	ret = prepare_emulation(p, &insn);
+	if (ret < 0)
+		return ret;
 
-	/* Analyze the opcode and set resume flags */
-	set_resume_flags(p, &insn);
+	/* Add int3 for single-step or booster jmp */
+	len = prepare_singlestep(buf, p, &insn);
+	if (len < 0)
+		return len;
 
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
@@ -591,29 +801,7 @@ set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 {
 	__this_cpu_write(current_kprobe, p);
 	kcb->kprobe_saved_flags = kcb->kprobe_old_flags
-		= (regs->flags & (X86_EFLAGS_TF | X86_EFLAGS_IF));
-	if (p->ainsn.if_modifier)
-		kcb->kprobe_saved_flags &= ~X86_EFLAGS_IF;
-}
-
-static nokprobe_inline void clear_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl &= ~DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
-}
-
-static nokprobe_inline void restore_btf(void)
-{
-	if (test_thread_flag(TIF_BLOCKSTEP)) {
-		unsigned long debugctl = get_debugctlmsr();
-
-		debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
-	}
+		= (regs->flags & X86_EFLAGS_IF);
 }
 
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
@@ -628,6 +816,22 @@ void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
+static void kprobe_post_process(struct kprobe *cur, struct pt_regs *regs,
+			       struct kprobe_ctlblk *kcb)
+{
+	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		cur->post_handler(cur, regs, 0);
+	}
+
+	/* Restore back the original saved kprobes variables and continue. */
+	if (kcb->kprobe_status == KPROBE_REENTER)
+		restore_previous_kprobe(kcb);
+	else
+		reset_current_kprobe();
+}
+NOKPROBE_SYMBOL(kprobe_post_process);
+
 static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb, int reenter)
 {
@@ -635,7 +839,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		return;
 
 #if !defined(CONFIG_PREEMPTION)
-	if (p->ainsn.boostable && !p->post_handler) {
+	if (p->ainsn.boostable) {
 		/* Boost up -- we can execute copied instructions directly */
 		if (!reenter)
 			reset_current_kprobe();
@@ -654,19 +858,51 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 		kcb->kprobe_status = KPROBE_REENTER;
 	} else
 		kcb->kprobe_status = KPROBE_HIT_SS;
-	/* Prepare real single stepping */
-	clear_btf();
-	regs->flags |= X86_EFLAGS_TF;
+
+	if (p->ainsn.emulate_op) {
+		p->ainsn.emulate_op(p, regs);
+		kprobe_post_process(p, regs, kcb);
+		return;
+	}
+
+	/* Disable interrupt, and set ip register on trampoline */
 	regs->flags &= ~X86_EFLAGS_IF;
-	/* single step inline if the instruction is an int3 */
-	if (p->opcode == INT3_INSN_OPCODE)
-		regs->ip = (unsigned long)p->addr;
-	else
-		regs->ip = (unsigned long)p->ainsn.insn;
+	regs->ip = (unsigned long)p->ainsn.insn;
 }
 NOKPROBE_SYMBOL(setup_singlestep);
 
 /*
+ * Called after single-stepping.  p->addr is the address of the
+ * instruction whose first byte has been replaced by the "int3"
+ * instruction.  To avoid the SMP problems that can occur when we
+ * temporarily put back the original opcode to single-step, we
+ * single-stepped a copy of the instruction.  The address of this
+ * copy is p->ainsn.insn. We also doesn't use trap, but "int3" again
+ * right after the copied instruction.
+ * Different from the trap single-step, "int3" single-step can not
+ * handle the instruction which changes the ip register, e.g. jmp,
+ * call, conditional jmp, and the instructions which changes the IF
+ * flags because interrupt must be disabled around the single-stepping.
+ * Such instructions are software emulated, but others are single-stepped
+ * using "int3".
+ *
+ * When the 2nd "int3" handled, the regs->ip and regs->flags needs to
+ * be adjusted, so that we can resume execution on correct code.
+ */
+static void resume_singlestep(struct kprobe *p, struct pt_regs *regs,
+			      struct kprobe_ctlblk *kcb)
+{
+	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
+	unsigned long orig_ip = (unsigned long)p->addr;
+
+	/* Restore saved interrupt flag and ip register */
+	regs->flags |= kcb->kprobe_saved_flags;
+	/* Note that regs->ip is executed int3 so must be a step back */
+	regs->ip += (orig_ip - copy_ip) - INT3_INSN_SIZE;
+}
+NOKPROBE_SYMBOL(resume_singlestep);
+
+/*
  * We have reentered the kprobe_handler(), since another probe was hit while
  * within the handler. We save the original kprobes variables and just single
  * step on the instruction of the new probe without calling any user handlers.
@@ -701,6 +937,12 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
+static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
+{
+	return (kcb->kprobe_status == KPROBE_HIT_SS ||
+		kcb->kprobe_status == KPROBE_REENTER);
+}
+
 /*
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled throughout this function.
@@ -745,7 +987,18 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			return 1;
 		}
-	} else if (*addr != INT3_INSN_OPCODE) {
+	} else if (kprobe_is_ss(kcb)) {
+		p = kprobe_running();
+		if ((unsigned long)p->ainsn.insn < regs->ip &&
+		    (unsigned long)p->ainsn.insn + MAX_INSN_SIZE > regs->ip) {
+			/* Most provably this is the second int3 for singlestep */
+			resume_singlestep(p, regs, kcb);
+			kprobe_post_process(p, regs, kcb);
+			return 1;
+		}
+	}
+
+	if (*addr != INT3_INSN_OPCODE) {
 		/*
 		 * The breakpoint instruction was removed right
 		 * after we hit it.  Another cpu has removed
@@ -818,91 +1071,6 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 
-/*
- * Called after single-stepping.  p->addr is the address of the
- * instruction whose first byte has been replaced by the "int 3"
- * instruction.  To avoid the SMP problems that can occur when we
- * temporarily put back the original opcode to single-step, we
- * single-stepped a copy of the instruction.  The address of this
- * copy is p->ainsn.insn.
- *
- * This function prepares to return from the post-single-step
- * interrupt.  We have to fix up the stack as follows:
- *
- * 0) Except in the case of absolute or indirect jump or call instructions,
- * the new ip is relative to the copied instruction.  We need to make
- * it relative to the original instruction.
- *
- * 1) If the single-stepped instruction was pushfl, then the TF and IF
- * flags are set in the just-pushed flags, and may need to be cleared.
- *
- * 2) If the single-stepped instruction was a call, the return address
- * that is atop the stack is the address following the copied instruction.
- * We need to make it the address following the original instruction.
- */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs,
-			     struct kprobe_ctlblk *kcb)
-{
-	unsigned long *tos = stack_addr(regs);
-	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
-	unsigned long orig_ip = (unsigned long)p->addr;
-
-	regs->flags &= ~X86_EFLAGS_TF;
-
-	/* Fixup the contents of top of stack */
-	if (p->ainsn.is_pushf) {
-		*tos &= ~(X86_EFLAGS_TF | X86_EFLAGS_IF);
-		*tos |= kcb->kprobe_old_flags;
-	} else if (p->ainsn.is_call) {
-		*tos = orig_ip + (*tos - copy_ip);
-	}
-
-	if (!p->ainsn.is_abs_ip)
-		regs->ip += orig_ip - copy_ip;
-
-	restore_btf();
-}
-NOKPROBE_SYMBOL(resume_execution);
-
-/*
- * Interrupts are disabled on entry as trap1 is an interrupt gate and they
- * remain disabled throughout this function.
- */
-int kprobe_debug_handler(struct pt_regs *regs)
-{
-	struct kprobe *cur = kprobe_running();
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (!cur)
-		return 0;
-
-	resume_execution(cur, regs, kcb);
-	regs->flags |= kcb->kprobe_saved_flags;
-
-	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		cur->post_handler(cur, regs, 0);
-	}
-
-	/* Restore back the original saved kprobes variables and continue. */
-	if (kcb->kprobe_status == KPROBE_REENTER) {
-		restore_previous_kprobe(kcb);
-		goto out;
-	}
-	reset_current_kprobe();
-out:
-	/*
-	 * if somebody else is singlestepping across a probe point, flags
-	 * will have TF set, in which case, continue the remaining processing
-	 * of do_debug, as if this is not a probe hit.
-	 */
-	if (regs->flags & X86_EFLAGS_TF)
-		return 0;
-
-	return 1;
-}
-NOKPROBE_SYMBOL(kprobe_debug_handler);
-
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
@@ -920,20 +1088,9 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->ip = (unsigned long)cur->addr;
-		/*
-		 * Trap flag (TF) has been set here because this fault
-		 * happened where the single stepping will be done.
-		 * So clear it by resetting the current kprobe:
-		 */
-		regs->flags &= ~X86_EFLAGS_TF;
-		/*
-		 * Since the single step (trap) has been cancelled,
-		 * we need to restore BTF here.
-		 */
-		restore_btf();
 
 		/*
-		 * If the TF flag was set before the kprobe hit,
+		 * If the IF flag was set before the kprobe hit,
 		 * don't touch it:
 		 */
 		regs->flags |= kcb->kprobe_old_flags;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0da8d2a..a5d2540 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -890,9 +890,6 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &= ~DR_STEP;
 
-	if (kprobe_debug_handler(regs))
-		goto out;
-
 	/*
 	 * The kernel doesn't use INT1
 	 */
