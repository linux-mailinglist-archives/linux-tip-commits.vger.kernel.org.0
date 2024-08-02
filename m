Return-Path: <linux-tip-commits+bounces-1920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF16945E47
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29B61C211A9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811041E4EF2;
	Fri,  2 Aug 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXfGqyZA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cA4sjD+B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBA1E485F;
	Fri,  2 Aug 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603676; cv=none; b=EsJIgEQmZEg+is9HS/w7n8C4INcQdEmiPjL7DI7eUljVfjGEmD7W26PXVz0kpYPFO/DFngeNKEOFWT2ydy6cNFix9KLM3BL6Xbl62rL4B5fLeMEwKtr1OIWgqbWr+Vr14Xf1e6NPt/W1hFia3Z4QfXP5+wSi5SB1x0R5b6uzFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603676; c=relaxed/simple;
	bh=hCDw++Y+zxHQ++HhBP11QSZXNoCF2wRkw9kwksZycbw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=crSy3+vpllnoh+UOc3cv66vWvo16BNTX2B9JTdtioCMTGIjt5f136xKsvY0JVkS8no4uvMOwOapow16NYmVGe1zyrkFu3o92CbipMetin+iSePjwcBP5zOH4XV0+ZD/oSgP6AJ11mKVVmS+yF64lc0Cwek0fRJaEg6MQNRiQfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXfGqyZA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cA4sjD+B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 13:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iLXQnlVSn1ORzsAh1CnAoFqCCIPQ6/PuYkY0+1dB48=;
	b=HXfGqyZAMmC4MFt4YCSu67TCey/CK/DOlN0xBQ5dnXQc6N8IgIQ943SlqwYuiiacdIsqR9
	gJSFvcUToUCnCYRg93Qd2To1ZddSBA5V4gW6ter3J2AnbM1NrZvpACG3bRHkDOrrPxCGFC
	5mMlAHxUyyaNukhmZ6DgsnlwwKXPmYsVVxD5mXZZXWjgsL16GrE1s9QcROdUG5acUnnSCn
	y7S32zEDhSbnrFcD7A0pCuJq6auNRi3ZH01aOurhWc22WPaxhRrjdkhPzHtcN71DV5q4jt
	YJkp7HZ2F9HnwPplvIeKjA3y9faPWVL5VR5WI3wG7vOTvWqztxtK9cUbFgLAyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iLXQnlVSn1ORzsAh1CnAoFqCCIPQ6/PuYkY0+1dB48=;
	b=cA4sjD+B/gAKaYW+m5ZNd69jjmGRX/JQ+YxmuO755ykWwYa7KU9ZEIkeeoDESEelSEQlfg
	bkfyUpzAyQKLMeCA==
From: "tip-bot2 for Aruna Ramakrishna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/pkeys: Add PKRU as a parameter in signal handling functions
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802061318.2140081-2-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-2-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260367260.2215.4188177993426167724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     24cf2bc982ffe02aeffb4a3885c71751a2c7023b
Gitweb:        https://git.kernel.org/tip/24cf2bc982ffe02aeffb4a3885c71751a2c7023b
Author:        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
AuthorDate:    Fri, 02 Aug 2024 06:13:14 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:12:20 +02:00

x86/pkeys: Add PKRU as a parameter in signal handling functions

Assume there's a multithreaded application that runs untrusted user
code. Each thread has its stack/code protected by a non-zero PKEY, and the
PKRU register is set up such that only that particular non-zero PKEY is
enabled. Each thread also sets up an alternate signal stack to handle
signals, which is protected by PKEY zero. The PKEYs man page documents that
the PKRU will be reset to init_pkru when the signal handler is invoked,
which means that PKEY zero access will be enabled.  But this reset happens
after the kernel attempts to push fpu state to the alternate stack, which
is not (yet) accessible by the kernel, which leads to a new SIGSEGV being
sent to the application, terminating it.

Enabling both the non-zero PKEY (for the thread) and PKEY zero in
userspace will not work for this use case. It cannot have the alt stack
writeable by all - the rationale here is that the code running in that
thread (using a non-zero PKEY) is untrusted and should not have access
to the alternate signal stack (that uses PKEY zero), to prevent the
return address of a function from being changed. The expectation is that
kernel should be able to set up the alternate signal stack and deliver
the signal to the application even if PKEY zero is explicitly disabled
by the application. The signal handler accessibility should not be
dictated by whatever PKRU value the thread sets up.

The PKRU register is managed by XSAVE, which means the sigframe contents
must match the register contents - which is not the case here. It's
required that the signal frame contains the user-defined PKRU value (so
that it is restored correctly from sigcontext) but the actual register must
be reset to init_pkru so that the alt stack is accessible and the signal
can be delivered to the application. It seems that the proper fix here
would be to remove PKRU from the XSAVE framework and manage it separately,
which is quite complicated. As a workaround, do this:

        orig_pkru = rdpkru();
        wrpkru(orig_pkru & init_pkru_value);
        xsave_to_user_sigframe();
        put_user(pkru_sigframe_addr, orig_pkru)

In preparation for writing PKRU to sigframe, pass PKRU as an additional
parameter down the call chain from get_sigframe().

No functional change.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-2-aruna.ramakrishna@oracle.com

---
 arch/x86/include/asm/fpu/signal.h | 2 +-
 arch/x86/kernel/fpu/signal.c      | 6 +++---
 arch/x86/kernel/signal.c          | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 611fa41..eccc75b 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,7 +29,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size, u32 pkru);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f222..2b3b9e1 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	return !err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
 	if (use_xsave())
 		return xsave_to_user_sigframe(buf);
@@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size, u32 pkru)
 {
 	struct task_struct *tsk = current;
 	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
@@ -228,7 +228,7 @@ retry:
 		fpregs_restore_userregs();
 
 	pagefault_disable();
-	ret = copy_fpregs_to_sigframe(buf_fx);
+	ret = copy_fpregs_to_sigframe(buf_fx, pkru);
 	pagefault_enable();
 	fpregs_unlock();
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5d..1f1e8e0 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -84,6 +84,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
+	u32 pkru = read_pkru();
 
 	/* redzone */
 	if (!ia32_frame)
@@ -139,7 +140,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;

