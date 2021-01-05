Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799412EADB6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Jan 2021 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbhAEOsh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Jan 2021 09:48:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAEOsh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Jan 2021 09:48:37 -0500
Date:   Tue, 05 Jan 2021 14:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609858073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yzAS/LKFprocVzBGk9g1G10eHKLCr3slIGCsk1jOpc=;
        b=LWcDQpCuMMQhmQpa7LHwyNZGuK2OxI+g1QTsaS7N9cymCqawEFo30vIm3FzojnY4Sr/OFj
        LihzB2+CvNLd5DBGVfqJozm8EWh3GdkzHbjf7C93lZwU2SspBP/4X43kUSbsJ81mFpA20c
        Y3Z/DHea2MmOFDzt0OAp7GqU9LC2Ps4wy4l+rf0qU+GoKrE168c3a9F78a3zLq+6pe/efE
        8IOICjx1sHbGTPjMqlucTN09U+I4uGa41Z6ROoDEEB4TZT8BlZPlbkJ1fhoddLwbzdWL+o
        0qMcaERIkbIFVfUfEMFndUZIZQg+xnE3p56f9EVZfyJIhSatxAzb9gJp6O3tfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609858073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yzAS/LKFprocVzBGk9g1G10eHKLCr3slIGCsk1jOpc=;
        b=mzJMRuYGAUU2VgkzPVag+YxHOlp6b/+Jwpm4OCch4BCxO4DIhyHNhkUHHpnOpNz6vucEQa
        pKW7xejFsUbRtOBw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] x86/kprobes: Do not decode opcode in resume_execution()
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <160830072561.349576.3014979564448023213.stgit@devnote2>
References: <160830072561.349576.3014979564448023213.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160985807183.414.394791965475735165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     abd82e533d88df1521e3da6799b83ce88852ab88
Gitweb:        https://git.kernel.org/tip/abd82e533d88df1521e3da6799b83ce88852ab88
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 18 Dec 2020 23:12:05 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Jan 2021 15:42:30 +01:00

x86/kprobes: Do not decode opcode in resume_execution()

Currently, kprobes decodes the opcode right after single-stepping in
resume_execution(). But the opcode was already decoded while preparing
arch_specific_insn in arch_copy_kprobe().

Decode the opcode in arch_copy_kprobe() instead of in resume_execution()
and set some flags which classify the opcode for the resuming process.

 [ bp: Massage commit message. ]

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/160830072561.349576.3014979564448023213.stgit@devnote2
---
 arch/x86/include/asm/kprobes.h |  11 +-
 arch/x86/kernel/kprobes/core.c | 168 ++++++++++++++------------------
 2 files changed, 81 insertions(+), 98 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 991a7ad..d20a3d6 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -58,14 +58,17 @@ struct arch_specific_insn {
 	/* copy of the original instruction */
 	kprobe_opcode_t *insn;
 	/*
-	 * boostable = false: This instruction type is not boostable.
-	 * boostable = true: This instruction has been boosted: we have
+	 * boostable = 0: This instruction type is not boostable.
+	 * boostable = 1: This instruction has been boosted: we have
 	 * added a relative jump after the instruction copy in insn,
 	 * so no single-step and fixup are needed (unless there's
 	 * a post_handler).
 	 */
-	bool boostable;
-	bool if_modifier;
+	unsigned boostable:1;
+	unsigned if_modifier:1;
+	unsigned is_call:1;
+	unsigned is_pushf:1;
+	unsigned is_abs_ip:1;
 	/* Number of bytes of text poked */
 	int tp_len;
 };
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a65e9e9..df776cd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -133,26 +133,6 @@ void synthesize_relcall(void *dest, void *from, void *to)
 NOKPROBE_SYMBOL(synthesize_relcall);
 
 /*
- * Skip the prefixes of the instruction.
- */
-static kprobe_opcode_t *skip_prefixes(kprobe_opcode_t *insn)
-{
-	insn_attr_t attr;
-
-	attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	while (inat_is_legacy_prefix(attr)) {
-		insn++;
-		attr = inat_get_opcode_attribute((insn_byte_t)*insn);
-	}
-#ifdef CONFIG_X86_64
-	if (inat_is_rex_prefix(attr))
-		insn++;
-#endif
-	return insn;
-}
-NOKPROBE_SYMBOL(skip_prefixes);
-
-/*
  * Returns non-zero if INSN is boostable.
  * RIP relative instructions are adjusted at copying time in 64 bits mode
  */
@@ -312,25 +292,6 @@ static int can_probe(unsigned long paddr)
 }
 
 /*
- * Returns non-zero if opcode modifies the interrupt flag.
- */
-static int is_IF_modifier(kprobe_opcode_t *insn)
-{
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
-
-	switch (*insn) {
-	case 0xfa:		/* cli */
-	case 0xfb:		/* sti */
-	case 0xcf:		/* iret/iretd */
-	case 0x9d:		/* popf/popfd */
-		return 1;
-	}
-
-	return 0;
-}
-
-/*
  * Copy an instruction with recovering modified instruction by kprobes
  * and adjust the displacement if the instruction uses the %rip-relative
  * addressing mode. Note that since @real will be the final place of copied
@@ -411,9 +372,9 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 		synthesize_reljump(buf + len, p->ainsn.insn + len,
 				   p->addr + insn->length);
 		len += JMP32_INSN_SIZE;
-		p->ainsn.boostable = true;
+		p->ainsn.boostable = 1;
 	} else {
-		p->ainsn.boostable = false;
+		p->ainsn.boostable = 0;
 	}
 
 	return len;
@@ -450,6 +411,67 @@ void free_insn_page(void *page)
 	module_memfree(page);
 }
 
+static void set_resume_flags(struct kprobe *p, struct insn *insn)
+{
+	insn_byte_t opcode = insn->opcode.bytes[0];
+
+	switch (opcode) {
+	case 0xfa:		/* cli */
+	case 0xfb:		/* sti */
+	case 0x9d:		/* popf/popfd */
+		/* Check whether the instruction modifies Interrupt Flag or not */
+		p->ainsn.if_modifier = 1;
+		break;
+	case 0x9c:	/* pushfl */
+		p->ainsn.is_pushf = 1;
+		break;
+	case 0xcf:	/* iret */
+		p->ainsn.if_modifier = 1;
+		fallthrough;
+	case 0xc2:	/* ret/lret */
+	case 0xc3:
+	case 0xca:
+	case 0xcb:
+	case 0xea:	/* jmp absolute -- ip is correct */
+		/* ip is already adjusted, no more changes required */
+		p->ainsn.is_abs_ip = 1;
+		/* Without resume jump, this is boostable */
+		p->ainsn.boostable = 1;
+		break;
+	case 0xe8:	/* call relative - Fix return addr */
+		p->ainsn.is_call = 1;
+		break;
+#ifdef CONFIG_X86_32
+	case 0x9a:	/* call absolute -- same as call absolute, indirect */
+		p->ainsn.is_call = 1;
+		p->ainsn.is_abs_ip = 1;
+		break;
+#endif
+	case 0xff:
+		opcode = insn->opcode.bytes[1];
+		if ((opcode & 0x30) == 0x10) {
+			/*
+			 * call absolute, indirect
+			 * Fix return addr; ip is correct.
+			 * But this is not boostable
+			 */
+			p->ainsn.is_call = 1;
+			p->ainsn.is_abs_ip = 1;
+			break;
+		} else if (((opcode & 0x31) == 0x20) ||
+			   ((opcode & 0x31) == 0x21)) {
+			/*
+			 * jmp near and far, absolute indirect
+			 * ip is correct.
+			 */
+			p->ainsn.is_abs_ip = 1;
+			/* Without resume jump, this is boostable */
+			p->ainsn.boostable = 1;
+		}
+		break;
+	}
+}
+
 static int arch_copy_kprobe(struct kprobe *p)
 {
 	struct insn insn;
@@ -467,8 +489,8 @@ static int arch_copy_kprobe(struct kprobe *p)
 	 */
 	len = prepare_boost(buf, p, &insn);
 
-	/* Check whether the instruction modifies Interrupt Flag or not */
-	p->ainsn.if_modifier = is_IF_modifier(buf);
+	/* Analyze the opcode and set resume flags */
+	set_resume_flags(p, &insn);
 
 	/* Also, displacement change doesn't affect the first byte */
 	p->opcode = buf[0];
@@ -491,6 +513,9 @@ int arch_prepare_kprobe(struct kprobe *p)
 
 	if (!can_probe((unsigned long)p->addr))
 		return -EILSEQ;
+
+	memset(&p->ainsn, 0, sizeof(p->ainsn));
+
 	/* insn: must be on special executable page on x86. */
 	p->ainsn.insn = get_insn_slot();
 	if (!p->ainsn.insn)
@@ -806,11 +831,6 @@ NOKPROBE_SYMBOL(trampoline_handler);
  * 2) If the single-stepped instruction was a call, the return address
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
- *
- * If this is the first time we've single-stepped the instruction at
- * this probepoint, and the instruction is boostable, boost it: add a
- * jump instruction after the copied instruction, that jumps to the next
- * instruction after the probepoint.
  */
 static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 			     struct kprobe_ctlblk *kcb)
@@ -818,60 +838,20 @@ static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 	unsigned long *tos = stack_addr(regs);
 	unsigned long copy_ip = (unsigned long)p->ainsn.insn;
 	unsigned long orig_ip = (unsigned long)p->addr;
-	kprobe_opcode_t *insn = p->ainsn.insn;
-
-	/* Skip prefixes */
-	insn = skip_prefixes(insn);
 
 	regs->flags &= ~X86_EFLAGS_TF;
-	switch (*insn) {
-	case 0x9c:	/* pushfl */
+
+	/* Fixup the contents of top of stack */
+	if (p->ainsn.is_pushf) {
 		*tos &= ~(X86_EFLAGS_TF | X86_EFLAGS_IF);
 		*tos |= kcb->kprobe_old_flags;
-		break;
-	case 0xc2:	/* iret/ret/lret */
-	case 0xc3:
-	case 0xca:
-	case 0xcb:
-	case 0xcf:
-	case 0xea:	/* jmp absolute -- ip is correct */
-		/* ip is already adjusted, no more changes required */
-		p->ainsn.boostable = true;
-		goto no_change;
-	case 0xe8:	/* call relative - Fix return addr */
+	} else if (p->ainsn.is_call) {
 		*tos = orig_ip + (*tos - copy_ip);
-		break;
-#ifdef CONFIG_X86_32
-	case 0x9a:	/* call absolute -- same as call absolute, indirect */
-		*tos = orig_ip + (*tos - copy_ip);
-		goto no_change;
-#endif
-	case 0xff:
-		if ((insn[1] & 0x30) == 0x10) {
-			/*
-			 * call absolute, indirect
-			 * Fix return addr; ip is correct.
-			 * But this is not boostable
-			 */
-			*tos = orig_ip + (*tos - copy_ip);
-			goto no_change;
-		} else if (((insn[1] & 0x31) == 0x20) ||
-			   ((insn[1] & 0x31) == 0x21)) {
-			/*
-			 * jmp near and far, absolute indirect
-			 * ip is correct. And this is boostable
-			 */
-			p->ainsn.boostable = true;
-			goto no_change;
-		}
-		break;
-	default:
-		break;
 	}
 
-	regs->ip += orig_ip - copy_ip;
+	if (!p->ainsn.is_abs_ip)
+		regs->ip += orig_ip - copy_ip;
 
-no_change:
 	restore_btf();
 }
 NOKPROBE_SYMBOL(resume_execution);
