Return-Path: <linux-tip-commits+bounces-4880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2115A8590F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1490F7B7A6D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B14238C35;
	Fri, 11 Apr 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIoH0VQg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coBv3Gi/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66B24DC6E;
	Fri, 11 Apr 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365743; cv=none; b=XYXvCCrpif2Zg4mOV96QsVEz99fFGB4/76zuxef0dhuW3a5/+8n87NZCWpQl+1WcP0CinrLI3hzyb5Q/oOm/ITeb0SiYfbNdM6t8Ij79CBgY554ZooTEnT4pNGP+lkQqilZNHNoO18OzWvXL2MSNQdWLPnaF9mrkDONIinGxAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365743; c=relaxed/simple;
	bh=StsbyfavKKv2M1nRByDl2Ss8O62f0V4NSrlerOAFCpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HLf4cyaTvNmG3jKV4lD4MriIuHDy1mRulSSSU8sUUgrOyiUwIvG5CIYugeoJrCd3IhZ1K0bpnuzJl/ygEJmrf9ohahe/Jv/0wmxwe/vM/IU4US3n70zku3LF4zYm9aWroNFDV3X0TaM5tiEZlEpsRg9SR/1LtxbcCOfzR/6vphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIoH0VQg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coBv3Gi/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMt01x0GKXBDaw11SqufwZ23rGWnK5O+atZ0Sh9HM6w=;
	b=cIoH0VQgGkLqoknpodYGxrFQ1Rs9ZcO3kvb0g3C+n3Oxp87yFV7JCP6eB2Q0HXS0trwaUi
	78vMnh292pJC5V7HPPjeH4ns3BHN4ujqDSHRsb9hbMRRrcAxLqKHVr+tMUvtjwDen3fZrs
	h0FwyL/ySKGsqMPkimjM9X1hk13K1LOWUhzkesrbOy5KtXq0yh1Sr1wo2C8Gj7S7Wuehqa
	HBZYUuYMu+LlP2TPeSvQD4UYwiJoLpnTX1zVCF+uTW28K0xhhKCsIjDqkh9IVSl5Xt7R48
	rGboEpwXdU5P9BPVF/RgTTMvFcw4D+pBH4JLfJRy6hEFmy/0z2AxgxVht44iWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMt01x0GKXBDaw11SqufwZ23rGWnK5O+atZ0Sh9HM6w=;
	b=coBv3Gi/y74hrPVn3y8DM0JZCVeCCyUHelfNRp55aQ40LM1eCAkwuS7pTTx1wdgRN0jL5b
	/+/bzJniBielypAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'text_poke_bp()' to
 'smp_text_poke_single()'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-7-mingo@kernel.org>
References: <20250411054105.2341982-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573843.31282.13460593049348122760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     9586ae48e785b48b8dd25136c34c8d0e3e1d2cc8
Gitweb:        https://git.kernel.org/tip/9586ae48e785b48b8dd25136c34c8d0e3e1d2cc8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'text_poke_bp()' to 'smp_text_poke_single()'

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-7-mingo@kernel.org
---
 arch/x86/include/asm/text-patching.h | 2 +-
 arch/x86/kernel/alternative.c        | 4 ++--
 arch/x86/kernel/ftrace.c             | 8 ++++----
 arch/x86/kernel/jump_label.c         | 2 +-
 arch/x86/kernel/kprobes/opt.c        | 2 +-
 arch/x86/kernel/static_call.c        | 2 +-
 arch/x86/net/bpf_jit_comp.c          | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index ab9e143..5189188 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,7 +39,7 @@ extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
 extern void *text_poke_set(void *addr, int c, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
+extern void smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate);
 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_finish(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 78024e5..222021a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2887,7 +2887,7 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 }
 
 /**
- * text_poke_bp() -- update instructions on live kernel on SMP
+ * smp_text_poke_single() -- update instructions on live kernel on SMP
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
@@ -2897,7 +2897,7 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
  * dynamically allocated memory. This function should be used when it is
  * not possible to allocate memory.
  */
-void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+void __ref smp_text_poke_single(void *addr, const void *opcode, size_t len, const void *emulate)
 {
 	struct text_poke_loc tp;
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index cace6e8..7175a04 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -186,11 +186,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	ip = (unsigned long)(&ftrace_call);
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 
 	ip = (unsigned long)(&ftrace_regs_call);
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 
 	return 0;
 }
@@ -492,7 +492,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	mutex_lock(&text_mutex);
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 	mutex_unlock(&text_mutex);
 }
 
@@ -586,7 +586,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 	const char *new;
 
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	smp_text_poke_single((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f5b8ef0..166e120 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -102,7 +102,7 @@ __jump_label_transform(struct jump_entry *entry,
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
+	smp_text_poke_single((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 }
 
 static void __ref jump_label_transform(struct jump_entry *entry,
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 36d6809..9307a40 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -488,7 +488,7 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buff[0] = JMP32_INSN_OPCODE;
 		*(s32 *)(&insn_buff[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
+		smp_text_poke_single(op->kp.addr, insn_buff, JMP32_INSN_SIZE, NULL);
 
 		list_del_init(&op->list);
 	}
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index a59c72e..8164a73 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -108,7 +108,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 	if (system_state == SYSTEM_BOOTING || modinit)
 		return text_poke_early(insn, code, size);
 
-	text_poke_bp(insn, code, size, emulate);
+	smp_text_poke_single(insn, code, size, emulate);
 }
 
 static void __static_call_validate(u8 *insn, bool tail, bool tramp)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2b..e2b9991 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -629,7 +629,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		goto out;
 	ret = 1;
 	if (memcmp(ip, new_insn, X86_PATCH_SIZE)) {
-		text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL);
+		smp_text_poke_single(ip, new_insn, X86_PATCH_SIZE, NULL);
 		ret = 0;
 	}
 out:

