Return-Path: <linux-tip-commits+bounces-3374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E9A36D77
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AB37A4FA7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A41CEAB2;
	Sat, 15 Feb 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EJsHiKU9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPtbT4S9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF61ACEBF;
	Sat, 15 Feb 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617004; cv=none; b=C1QywQ+QQXHTwULUeeLSDb39mLK4s141kVXTh+4JuilAlXXX5oqoSCBjB301qVhP9ch7NIGkAcevoMHCsk7thqjZlD/V8ayI8wzMdvQ9kC70elVvhbs+8wzSgdf044XaUsm6+rL+D551bDFO3WF6diLc+AA51K/2eYgIJDX8L5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617004; c=relaxed/simple;
	bh=WIgtQ6qzQ2spORBaWWTcOb0m/U45CTfUeRf0D3KhoJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CLadr7Qjihm3YYCOj65RV/T+5bxrkWWJMIVHx6KaVbj64N34WrIX4Hwkc4oCEueSva3YEmIme2JGY7FGnbxzBtj5PMgk72kPCfpIbzV1B156mEgaX4knMSScjROa1PbhiV2jV51YgZLgqcTXBYmgSPqRQ9iKCpMOBc65uV318OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EJsHiKU9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPtbT4S9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739617001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IlN82XKDHW2wt9Mef5feZxpcXI8fZcEdF/IOJP8Sf4=;
	b=EJsHiKU9P8TR3s4sBYtj2bFMpvIYtA/lt81D9kfR28lCRRU8jR0XLtvjHtxttAla8tLBxh
	DIBFOIGmtx6pai1NcjKG8dWNEmViK5hJIaNYctz69UOBb/Y0i5EZdcpUCeINTqKyom/Ecu
	OS9rvYqoMG9NPkh074c1WRrD3xBCYq4GxWsvGI2vVf8vn/3Oah0D3bLIubWRaHlUkLb71V
	2zZJSUDiRzegeduO+MUm9tNO4TXcZQJmq0AnsI/xPlUKbgnh73dHs21Rq83xIhVFgaxEz/
	ZYbtkiqwFsDbXivrssK0zB0MiXThPxsn9rByGtF5sApAY3yxLW5jcArKf5SFyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739617001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IlN82XKDHW2wt9Mef5feZxpcXI8fZcEdF/IOJP8Sf4=;
	b=EPtbT4S9zB+jL97iSoJr9dJ/MiXGsv+ZSkWgQa169VAtnDQlhg9o31RN4A2Tuaxqm1sMeM
	WwKIvaOBKsbDpLDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Clean up is_endbr()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.181367417@infradead.org>
References: <20250207122546.181367417@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961700035.10177.32166133596843013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     72e213a7ccf9dc78a85eecee8dc8170762ed876c
Gitweb:        https://git.kernel.org/tip/72e213a7ccf9dc78a85eecee8dc8170762ed876c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:04 +01:00

x86/ibt: Clean up is_endbr()

Pretty much every caller of is_endbr() actually wants to test something at an
address and ends up doing get_kernel_nofault(). Fold the lot into a more
convenient helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250207122546.181367417@infradead.org
---
 arch/x86/events/core.c         |  2 +-
 arch/x86/include/asm/ftrace.h  | 16 ++--------------
 arch/x86/include/asm/ibt.h     |  5 +++--
 arch/x86/kernel/alternative.c  | 20 ++++++++++++++------
 arch/x86/kernel/kprobes/core.c | 11 +----------
 arch/x86/net/bpf_jit_comp.c    |  4 ++--
 kernel/trace/bpf_trace.c       | 21 ++++-----------------
 7 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac..ff4e84a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2844,7 +2844,7 @@ static bool is_uprobe_at_func_entry(struct pt_regs *regs)
 		return true;
 
 	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
 		return true;
 
 	return false;
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d0..f226524 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,21 +36,9 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 {
-#ifdef CONFIG_X86_KERNEL_IBT
-	u32 instr;
-
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
+	if (is_endbr((void*)(fentry_ip - ENDBR_INSN_SIZE)))
 		fentry_ip -= ENDBR_INSN_SIZE;
-#endif
+
 	return fentry_ip;
 }
 #define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 1e59581..d955e0d 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static inline __attribute_const__ u32 gen_endbr_poison(void)
 	return 0x001f0f66; /* osp nopl (%rax) */
 }
 
-static inline bool is_endbr(u32 val)
+static inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
@@ -74,6 +74,7 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr bool is_endbr(u32 *val);
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
@@ -98,7 +99,7 @@ extern __noendbr void ibt_restore(u64 save);
 
 #define __noendbr
 
-static inline bool is_endbr(u32 val) { return false; }
+static inline bool is_endbr(u32 *val) { return false; }
 
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8b66a55..9a252bb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -852,16 +852,24 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+__noendbr bool is_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return __is_endbr(endbr);
+
+Efault:
+	return false;
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
-	u32 endbr, poison = gen_endbr_poison();
-
-	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
-		return;
+	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(endbr)) {
+	if (!is_endbr(addr)) {
 		WARN_ON_ONCE(warn);
 		return;
 	}
@@ -988,7 +996,7 @@ static u32  cfi_seed __ro_after_init;
 static u32 cfi_rehash(u32 hash)
 {
 	hash ^= cfi_seed;
-	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+	while (unlikely(__is_endbr(hash) || __is_endbr(-hash))) {
 		bool lsb = hash & 1;
 		hash >>= 1;
 		if (lsb)
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 72e6a45..09608fd 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,16 +373,7 @@ out:
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	u32 insn;
-
-	/*
-	 * Since 'addr' is not guaranteed to be safe to access, use
-	 * copy_from_kernel_nofault() to read the instruction:
-	 */
-	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
-		return NULL;
-
-	if (is_endbr(insn)) {
+	if (is_endbr((u32 *)addr)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5a..f36508b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -641,7 +641,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
 	 * with an ENDBR instruction.
 	 */
-	if (is_endbr(*(u32 *)ip))
+	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
@@ -3036,7 +3036,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		if (is_endbr(*(u32 *)orig_call))
+		if (is_endbr(orig_call))
 			orig_call += ENDBR_INSN_SIZE;
 		orig_call += X86_PATCH_SIZE;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index adc9475..997fb2a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1038,27 +1038,14 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-#ifdef CONFIG_X86_KERNEL_IBT
-static unsigned long get_entry_ip(unsigned long fentry_ip)
+static inline unsigned long get_entry_ip(unsigned long fentry_ip)
 {
-	u32 instr;
-
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
 		fentry_ip -= ENDBR_INSN_SIZE;
+#endif
 	return fentry_ip;
 }
-#else
-#define get_entry_ip(fentry_ip) fentry_ip
-#endif
 
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {

