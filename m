Return-Path: <linux-tip-commits+bounces-4961-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249D8A878DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A88C1890D37
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE925C6E6;
	Mon, 14 Apr 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gJGfhvZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMksOdfu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DC259C97;
	Mon, 14 Apr 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616093; cv=none; b=PSrkncLVvaGthnentavmRePSoN/F1V34APC58LssURqjRPkpVGnhltiYZyzpq3DCHva5JG57KDgg05XsHpL/bq8wr0MTpOYCANkzZTa65/nte30f/72S8kq4sLGQIZ7rAoa6iY3VXeeNFzs5QJUw/YoXGANY1rKSlY7QQhUe/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616093; c=relaxed/simple;
	bh=Tp+P1rWwh5i9VkPDefFfS9EnD/1dU0v0KxOsSLU7O8w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G8YRXIC0Ur2ownUgMR8gqPJ9I3nHT5nS0owxLDjOucqXhxYL8kK57yasHoBHml8UUg9OhwW+LZbVwcu+UGQRuwIUW4JoHAh/n9pTdejd4XEKqGdQ/HC6vrX4R4g8A2uxOm9gIUdKxbFPOizx9EfGaZuakhZliVqM3s/sGpHBKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gJGfhvZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMksOdfu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/PJJSya/TsH0sUgeRy+taviW+ff2SXVkqEd1Ul7brc=;
	b=3gJGfhvZT4TA0RRTSt4aDiYi/VDFetoMOIf/EPu1YFVXWm1/c94hkHdUtDfbaJ0SSeBPp+
	zL+XeT+EN3Bx05Urz//yKGwz8J/8C6d9oKd5RgLRzzPkQ/OSApXWIRqBJTF//lorRdyLr8
	ezpDrHLcZ8PBcPdFdMArIPakDgRDSr505bB0q8c3+ia0qdGlLOeR3w4QeyC/RVI/0cQggc
	r04mITI/Ho2Eif+hPefYDLwGXDkyKHl0vushzZobOltl+cnOMufoEZi4kI4qqzoOv/+U0j
	Nnd1GO3SduG/8szODeZMsTLdZr29EI8z7o1GNfoZQuye8xq97dw813RS++yhSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/PJJSya/TsH0sUgeRy+taviW+ff2SXVkqEd1Ul7brc=;
	b=MMksOdfu8VuonRgfgNeITYUCTdxvpXMQ0Zl83h4Pq/G8JLnThTC7YKBi6v2jLNqSN9oMSQ
	Le5tI2xRHIQWSKBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Remove the thread::fpu pointer
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-5-mingo@kernel.org>
References: <20250409211127.3544993-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608824.31282.10843755840786408772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     55bc30f2e34dcc17a370d1f6c1c992be107c4502
Gitweb:        https://git.kernel.org/tip/55bc30f2e34dcc17a370d1f6c1c992be107c4502
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Remove the thread::fpu pointer

As suggested by Oleg, remove the thread::fpu pointer, as we can
calculate it via x86_task_fpu() at compile-time.

This improves code generation a bit:

   kepler:~/tip> size vmlinux.before vmlinux.after
   text        data        bss        dec         hex        filename
   26475405    10435342    1740804    38651551    24dc69f    vmlinux.before
   26475339    10959630    1216516    38651485    24dc65d    vmlinux.after

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250409211127.3544993-5-mingo@kernel.org
---
 arch/x86/include/asm/processor.h | 5 +----
 arch/x86/kernel/fpu/core.c       | 4 +---
 arch/x86/kernel/fpu/init.c       | 1 -
 arch/x86/kernel/process.c        | 2 --
 arch/x86/kernel/vmlinux.lds.S    | 4 ++++
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5ea7e5d..b7f7c9c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -514,12 +514,9 @@ struct thread_struct {
 
 	struct thread_shstk	shstk;
 #endif
-
-	/* Floating point and extended processor state */
-	struct fpu		*fpu;
 };
 
-#define x86_task_fpu(task) ((task)->thread.fpu)
+#define x86_task_fpu(task)	((struct fpu *)((void *)(task) + sizeof(*(task))))
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 853a738..974b276 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -600,13 +600,11 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *src_fpu = x86_task_fpu(current);
-	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+	struct fpu *dst_fpu = x86_task_fpu(dst);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
 	BUG_ON(!src_fpu);
 
-	dst->thread.fpu = dst_fpu;
-
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 848ea79..da41a1d 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -76,7 +76,6 @@ static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
 static void __init fpu__init_system_early_generic(void)
 {
 	fpstate_reset(&x86_init_fpu);
-	current->thread.fpu = &x86_init_fpu;
 	set_thread_flag(TIF_NEED_FPU_LOAD);
 	x86_init_fpu.last_cpu = -1;
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3ce4cce..88868a9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -102,8 +102,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
-	/* Drop the copied pointer to current's fpstate */
-	dst->thread.fpu = NULL;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ccdc45e..d9ca2d1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -181,6 +181,10 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
+		__x86_init_fpu_begin = .;
+		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
+		__x86_init_fpu_end = .;
+
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA

