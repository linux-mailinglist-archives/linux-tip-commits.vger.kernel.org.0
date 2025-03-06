Return-Path: <linux-tip-commits+bounces-4030-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87712A54A33
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 13:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B0C3A28DE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB4146588;
	Thu,  6 Mar 2025 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9v+vhmI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGTpdKVc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78442E3397;
	Thu,  6 Mar 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262423; cv=none; b=XdBl+IAMTgH9+dfbhqt9hIdydzA6JOiwMxR3U+jOF+uY9dfTlhsDPDJT46GV+5QjQNvZmbrA7+2EvsinQi8nU71JgByUQG2e5Ewtl/W5EvSMYy2aMwmPdA2GUEnEeLeFZ7h6bdiNhvmNQGAkHDrGF3nJTFKxOLfEcUDS9xx0ObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262423; c=relaxed/simple;
	bh=k/Z3JskPodBWb7rxNqwMFKnqIJPwtUB3Twegd1jUOEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hU3FwJ8Vw0ZOd0UzOGrpGKUFdlJyrquoI93flC9002L+SSymuyZp/keM1Tdx0wqWnzC9pgW+2cdtQlJg8GUxh4KbgIZw90OG0kswDJGnhf0BwM/EPytYW617MubCvo6SIYdM36KoFrZDNItOxkQxJGbXF00emMtjkvj60LmwL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9v+vhmI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGTpdKVc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 12:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741262418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKYsissuzvT9ielN6X7uJeEG5droGUC8fYTwP7lvPJ0=;
	b=Q9v+vhmIBX7SlwAa15q4qCci46LQKpUlamCEZ3uXxLPU0pssyiarXHJfXy3VXblvQIpWs+
	vYyxBgL0RIuT8EJmowLVu/cC9xz0Y2NxGhj8pCWfJY0+0TJ8Lzu5ZhAOExmcDmd3xC39ML
	4MTT3QFarTCr6Bb+uSxJ57umVYD38oYHhaJ4X2SY9nNRooUoZQcn+pxCbq5qosj2E7AYPs
	yj0Br6fCNlSxtMuefxjMqyXm6ejhZi/CvsQnWRtZtYIEO0tAzCKOhdIKtvsJ5QFJBd0lln
	irPetMXmm5W5p4tN4iE970+N1rZ0HaRAA1j/3FLl8iqFWFxMKJYPaUNE+fvhoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741262418;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKYsissuzvT9ielN6X7uJeEG5droGUC8fYTwP7lvPJ0=;
	b=WGTpdKVcTMRxjTCeIyJ5rVn+MA0wDj6C5aVp0vPvz1U1FCfV2Jwv03leeVQ4zxP3YtLBLW
	1T9L37YelVAGcvAg==
From: "tip-bot2 for Eric Biggers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Improve crypto performance by making
 kernel-mode FPU reliably usable in softirqs
Cc: Eric Biggers <ebiggers@google.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304204954.3901-1-ebiggers@kernel.org>
References: <20250304204954.3901-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174126241675.14745.2521678635311279694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d02198550423a0b695e7a24ec77153209ad45b09
Gitweb:        https://git.kernel.org/tip/d02198550423a0b695e7a24ec77153209ad45b09
Author:        Eric Biggers <ebiggers@google.com>
AuthorDate:    Tue, 04 Mar 2025 12:49:54 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 12:44:09 +01:00

x86/fpu: Improve crypto performance by making kernel-mode FPU reliably usable in softirqs

Background:
===========

Currently kernel-mode FPU is not always usable in softirq context on
x86, since softirqs can nest inside a kernel-mode FPU section in task
context, and nested use of kernel-mode FPU is not supported.

Therefore, x86 SIMD-optimized code that can be called in softirq context
has to sometimes fall back to non-SIMD code.  There are two options for
the fallback, both of which are pretty terrible:

  (a) Use a scalar fallback.  This can be 10-100x slower than vectorized
      code because it cannot use specialized instructions like AES, SHA,
      or carryless multiplication.

  (b) Execute the request asynchronously using a kworker.  In other
      words, use the "crypto SIMD helper" in crypto/simd.c.

Currently most of the x86 en/decryption code (skcipher and aead
algorithms) uses option (b), since this avoids the slow scalar fallback
and it is easier to wire up.  But option (b) is still really bad for its
own reasons:

  - Punting the request to a kworker is bad for performance too.

  - It forces the algorithm to be marked as asynchronous
    (CRYPTO_ALG_ASYNC), preventing it from being used by crypto API
    users who request a synchronous algorithm.  That's another huge
    performance problem, which is especially unfortunate for users who
    don't even do en/decryption in softirq context.

  - It makes all en/decryption operations take a detour through
    crypto/simd.c.  That involves additional checks and an additional
    indirect call, which slow down en/decryption for *everyone*.

Fortunately, the skcipher and aead APIs are only usable in task and
softirq context in the first place.  Thus, if kernel-mode FPU were to be
reliably usable in softirq context, no fallback would be needed.
Indeed, other architectures such as arm, arm64, and riscv have already
done this.

Changes implemented:
====================

Therefore, this patch updates x86 accordingly to reliably support
kernel-mode FPU in softirqs.

This is done by just disabling softirq processing in kernel-mode FPU
sections (when hardirqs are not already disabled), as that prevents the
nesting that was problematic.

This will delay some softirqs slightly, but only ones that would have
otherwise been nested inside a task context kernel-mode FPU section.
Any such softirqs would have taken the slow fallback path before if they
tried to do any en/decryption.  Now these softirqs will just run at the
end of the task context kernel-mode FPU section (since local_bh_enable()
runs pending softirqs) and will no longer take the slow fallback path.

Alternatives considered:
========================

- Make kernel-mode FPU sections fully preemptible.  This would require
  growing task_struct by another struct fpstate which is more than 2K.

- Make softirqs save/restore the kernel-mode FPU state to a per-CPU
  struct fpstate when nested use is detected.  Somewhat interesting, but
  seems unnecessary when a simpler solution exists.

Performance results:
====================

I did some benchmarks with AES-XTS encryption of 16-byte messages (which is
unrealistically small, but this makes it easier to see the overhead of
kernel-mode FPU...).  The baseline was 384 MB/s.  Removing the use of
crypto/simd.c, which this work makes possible, increases it to 487 MB/s,
a +27% improvement in throughput.

CPU was AMD Ryzen 9 9950X (Zen 5).  No debugging options were enabled.

[ mingo: Prettified the changelog and added performance results. ]

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250304204954.3901-1-ebiggers@kernel.org
---
 arch/x86/include/asm/fpu/api.h | 17 +++++++----------
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index f86ad33..f42de5f 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -16,10 +16,9 @@
 
 /*
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
- * disables preemption so be careful if you intend to use it for long periods
- * of time.
- * If you intend to use the FPU in irq/softirq you need to check first with
- * irq_fpu_usable() if it is possible.
+ * disables preemption and softirq processing, so be careful if you intend to
+ * use it for long periods of time.  Kernel-mode FPU cannot be used in all
+ * contexts -- see irq_fpu_usable() for details.
  */
 
 /* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
@@ -50,10 +49,10 @@ static inline void kernel_fpu_begin(void)
 }
 
 /*
- * Use fpregs_lock() while editing CPU's FPU registers or fpu->fpstate.
- * A context switch will (and softirq might) save CPU's FPU registers to
- * fpu->fpstate.regs and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in
- * a random state.
+ * Use fpregs_lock() while editing CPU's FPU registers or fpu->fpstate, or while
+ * using the FPU in kernel mode.  A context switch will (and softirq might) save
+ * CPU's FPU registers to fpu->fpstate.regs and set TIF_NEED_FPU_LOAD leaving
+ * CPU's FPU registers in a random state.
  *
  * local_bh_disable() protects against both preemption and soft interrupts
  * on !RT kernels.
@@ -63,8 +62,6 @@ static inline void kernel_fpu_begin(void)
  * preemptible. Disabling preemption is the right choice here as bottom
  * half processing is always in thread context on RT kernels so it
  * implicitly prevents bottom half processing as well.
- *
- * Disabling preemption also serializes against kernel_fpu_begin().
  */
 static inline void fpregs_lock(void)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 36df548..422c98c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -60,9 +60,16 @@ bool irq_fpu_usable(void)
 	if (WARN_ON_ONCE(in_nmi()))
 		return false;
 
-	/* In kernel FPU usage already active? */
-	if (this_cpu_read(in_kernel_fpu))
+	/*
+	 * In kernel FPU usage already active?  This detects any explicitly
+	 * nested usage in task or softirq context, which is unsupported.  It
+	 * also detects attempted usage in a hardirq that has interrupted a
+	 * kernel-mode FPU section.
+	 */
+	if (this_cpu_read(in_kernel_fpu)) {
+		WARN_ON_FPU(!in_hardirq());
 		return false;
+	}
 
 	/*
 	 * When not in NMI or hard interrupt context, FPU can be used in:
@@ -420,7 +427,8 @@ EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
-	preempt_disable();
+	if (!irqs_disabled())
+		fpregs_lock();
 
 	WARN_ON_FPU(!irq_fpu_usable());
 	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
@@ -448,7 +456,8 @@ void kernel_fpu_end(void)
 	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, false);
-	preempt_enable();
+	if (!irqs_disabled())
+		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 

