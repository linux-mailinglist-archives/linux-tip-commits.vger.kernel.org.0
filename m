Return-Path: <linux-tip-commits+bounces-7243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38AC2FD37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D45189DF83
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D588931CA59;
	Tue,  4 Nov 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V75OkDXv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7yYDZm5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA031B81A;
	Tue,  4 Nov 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244255; cv=none; b=T9DyHgS63nCNoChm+pzrAW5o+ThqALxyXh3MrU3C+bTxz2ig9GO7tOLxUYYGohRENmlZPy3NhDqnrUGW5wOwh0KdESHROE9n7pqntbwln+qhG2GWuEkTaYC8VbIS1YWKQ1ZPFDVX+f++l4EKLGFRIJt4XPoLmB6gUqrfoj1sRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244255; c=relaxed/simple;
	bh=9qr0lCVUAsjgR7HUjUybCVTwn1/ELzVIQb/k096j0H8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZlWTKT5JTprUSt221orWF5o+5qGdjMeXL/24d83erYnW/mmuERh289wLnQHq7HvVnA+Lb89l6ftgxn2IPSYctL/HlWSR1OLXin7mxCy6saN7pmpRq/UmLOfHJQ9eFpLlN+Fp16ro5A7c4dFiG0gGT0vA7deZgaumowxwR71Ew+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V75OkDXv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7yYDZm5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0owKGkFW6AvAACW5HQ6NA5RUhvADynv8OsKuoFVOJM=;
	b=V75OkDXveoGMFeueqD+ONFkt49nsCSXPFWBHTHn5w/6GiOnIdvHlHPyzNWFA5ZKA88ZVYt
	tVi4GzbEqynnKSLzrJwXAyRpkeYPaIGjEJJGoON/8PSjbYTdgVgLSj1OzHRRmgdi+DAS9Y
	WczKCM22XN1hx9ccftBmmy+AyyoGziP2b+pZzlp/JrVVkDDRDsD5SWaqSNjkaKXJFuSa37
	bJLPKExykBg1Uh6D7QwHVwMajY8lwGSYhOYFfx/J5R5qzLKy9gKvRtbcrYJY4fT0RbZ6tN
	wrbPU+7M9/fY5QHNim0FKAqY7uYs5liWZVNvkdDdptRgwPdu35ZpPiP5motZWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0owKGkFW6AvAACW5HQ6NA5RUhvADynv8OsKuoFVOJM=;
	b=a7yYDZm5UdwnWT36pcRTFriVRBHj7ntj+NIZmblqFEcDBu3cNbBzTJFtTZ8t8nKSUmNWgH
	K8d7GuQPFTaivlAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Clean up header
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.590338411@linutronix.de>
References: <20251027084306.590338411@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224425076.2601451.13827907253059618227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     5204be16790f305febbf331d0ec2cead7978b3c3
Gitweb:        https://git.kernel.org/tip/5204be16790f305febbf331d0ec2cead797=
8b3c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:31:14 +01:00

entry: Clean up header

Clean up the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.590338411@linutronix.de
---
 include/linux/entry-common.h     | 8 ++++----
 include/linux/irq-entry-common.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 7177436..c585221 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,11 +3,11 @@
 #define __LINUX_ENTRYCOMMON_H
=20
 #include <linux/irq-entry-common.h>
+#include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/livepatch.h>
-#include <linux/resume_user_mode.h>
=20
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -37,6 +37,7 @@
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
+
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
@@ -61,8 +62,7 @@
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-			 unsigned long work);
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long w=
ork);
=20
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index e5941df..9b1f386 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -68,6 +68,7 @@ static __always_inline bool arch_in_rcu_eqs(void) { return =
false; }
=20
 /**
  * enter_from_user_mode - Establish state when coming from user mode
+ * @regs:	Pointer to currents pt_regs
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -357,6 +358,7 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *r=
egs);
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_re=
sched

