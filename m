Return-Path: <linux-tip-commits+bounces-4959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17CA878DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B8C164295
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3025A2D2;
	Mon, 14 Apr 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BabdX7dL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOvzAxQ0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D668259498;
	Mon, 14 Apr 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616092; cv=none; b=aZ/Mm3XU6voCS+LtTjxiNRg2NVu/dKUz0alG40R49kXBvOu1ifrDN6l2achVRwo4uf//02qf7a7TkOdkldaQUJvHaGpJ8WLeQOIqR7oQNboKNzVLnyAUmX4Sn/XT9WOoaQAoaHTvqOw6XxG1977yCCkLWMWzAnkLNHW1sqQhY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616092; c=relaxed/simple;
	bh=P/FF+DjUJzZeTs6ySv5W1avpU23vPgKKEd9nqJ0goz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dqdPvBFSLPDBkhStNssR3aODdKT6PTudHGu28k4vwNRW3OXHQKDIt+w/b/6gPF60u035Vs2Q/LYNd97InJrk/Xtv0nuGVRH/0II9pWagfb8eIQ/3KmiNgcFVi6+AIvMWaeqgdKtFyuGqG1g5u8ksnHGav0v+w/5nUrPwW49DXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BabdX7dL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOvzAxQ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744616088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS5VEqA6spfCmgguOSLrVSt/pX90gqpbIjDS2aZo7YA=;
	b=BabdX7dL5UKAR1XRYE/VrfavBe1MpZ9YHS0QbLPyjl27dg4PLueXQDPpP4akqF1NdO7JdV
	BwM+CxBzqvWW1nTV0ALzBvt7JlN1nYu9J6paIcVOTj+mVHrm3FUFjUTdrJb6/0ulsV7FE1
	Re0wpXs5mcvfieBAHhjwjIWwmNdnMIHPA/8jIiAsmQ3r0J0zG96EK1y4iepHj62gjCCY5K
	oMLwO6ZGbWB4GU42v1B8CNXuqXL8PqydnDbxtjyGcZbw8Y8LeXAzcbIbHhMZoNjBKxpi4r
	8Zj/8+7O2wtsorQRoGbIj4EaaxSpiAiQEh+Bx5nugGheq2a7rJ467q2VfhFzJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744616088;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS5VEqA6spfCmgguOSLrVSt/pX90gqpbIjDS2aZo7YA=;
	b=gOvzAxQ0JiQUk+VPG3cO6UGEuci1wYzwz7CmnMX3ET0DB5ciBkxqJNQK87AkDypQge46nq
	PzZTKBL3LVb/mTBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/fpu: Push 'fpu' pointer calculation into the
 fpu__drop() call
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409211127.3544993-6-mingo@kernel.org>
References: <20250409211127.3544993-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461608736.31282.11951675295903835985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     ec2227e03a46a162f2721917262adc553b212e2d
Gitweb:        https://git.kernel.org/tip/ec2227e03a46a162f2721917262adc553b212e2d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 23:11:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 08:18:29 +02:00

x86/fpu: Push 'fpu' pointer calculation into the fpu__drop() call

This encapsulates the fpu__drop() functionality better, and it
will also enable other changes that want to check a task for
PF_KTHREAD before calling x86_task_fpu().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409211127.3544993-6-mingo@kernel.org
---
 arch/x86/include/asm/fpu/sched.h | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 +++-
 arch/x86/kernel/process.c        | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 1feaa68..5fd1263 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -10,7 +10,7 @@
 #include <asm/trace/fpu.h>
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
-extern void fpu__drop(struct fpu *fpu);
+extern void fpu__drop(struct task_struct *tsk);
 extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 		      unsigned long shstk_addr);
 extern void fpu_flush_thread(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 974b276..e4c2090 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -681,8 +681,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
  * a state-restore is coming: either an explicit one,
  * or a reschedule.
  */
-void fpu__drop(struct fpu *fpu)
+void fpu__drop(struct task_struct *tsk)
 {
+	struct fpu *fpu = x86_task_fpu(tsk);
+
 	preempt_disable();
 
 	if (fpu == x86_task_fpu(current)) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 88868a9..5fb502c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -120,7 +120,6 @@ void arch_release_task_struct(struct task_struct *tsk)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct fpu *fpu = x86_task_fpu(tsk);
 
 	if (test_thread_flag(TIF_IO_BITMAP))
 		io_bitmap_exit(tsk);
@@ -128,7 +127,7 @@ void exit_thread(struct task_struct *tsk)
 	free_vm86(t);
 
 	shstk_free(tsk);
-	fpu__drop(fpu);
+	fpu__drop(tsk);
 }
 
 static int set_new_tls(struct task_struct *p, unsigned long tls)

