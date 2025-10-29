Return-Path: <linux-tip-commits+bounces-7074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FCC19C08
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9790564FC5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419C3396EE;
	Wed, 29 Oct 2025 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1e17eMdf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhiAffAf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3572FCC1D;
	Wed, 29 Oct 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733438; cv=none; b=AOb9IyZX5gp5/2hQ4nVibZa2zg8oRSvD8F2zpUvyOGSEQYrcSLe7oBDt6smpdp3tlMIq6o4qemRQ1xySnKXYf6XMfDYOjVgzG4szotYDXFOTw7SNFeiI2COfquysMPT2DspEjUoZ/Yo/HgYUNKIBLF91+5HaP1p3ZQFv72IUcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733438; c=relaxed/simple;
	bh=yTz1h0JY+TeAxFc0p0z4LhqKbj8JsCKB+V66gdcgKbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gL+inRJc2mqvh97wjzUuYv4QFX/ZX6wT5CkWaSOw6ZZOVZD0keVNJREJAXIyjCribJqPEn+CTFOtfnx9ujXmtPxMBo9MeYE79Yg5JlkIuxhwzUWr3tvFGeob25R+Xn6Iggpvs/5EaBcKFHL+QZF84bZcrrS2ggXaOkp7HzDFYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1e17eMdf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhiAffAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2ndwRJzNmV6eBKFjCfl3mee5WzZOU16f73LkUoIAFU=;
	b=1e17eMdfZ1sKkLeiGhsJqOOwTWVhgVTgABIE12VwLo6WQNyphZDi9C7c+/oQXGnvhtvfXA
	n4E8UhtKsZozOD/Wb+3b7GJwiJSM5XDg2AZipR3rvTXp/bqGdfLlnibEAa8GL5vH0ZwF9z
	xFgYlyecA1yBAhBeTvkcb7BQu7EBmPHayBLS1z0fCFGBvUQRf1PynR1Q7VWD9Y46pNvxIy
	WlJQAEdSiowr5rMTMAaW7oth8fYz6GkkoDK1cVqRMxHuKjxwUDnzyOyRz3ixNPj596DXv0
	/hMhIR4V/6U4v8+H00id/9YUWcFZmTgYKzwSsYX5mDj1wrjNbLKBMI72lJFPMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2ndwRJzNmV6eBKFjCfl3mee5WzZOU16f73LkUoIAFU=;
	b=QhiAffAfu4x6qWUUnsMZ3U7npA+CY4VKGvV8p+YcJ50qwRLN2W00ANNxegPrObGJpnMle9
	R/hzX27fQemd1NAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] entry: Cleanup header
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176173343234.2601451.14541294337811976636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     9ef94cc077010c99ff1e8a32d0719cecd8f79552
Gitweb:        https://git.kernel.org/tip/9ef94cc077010c99ff1e8a32d0719cecd8f=
79552
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:13 +01:00

entry: Cleanup header

Cleanup the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

