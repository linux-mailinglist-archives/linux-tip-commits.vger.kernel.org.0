Return-Path: <linux-tip-commits+bounces-7196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D41DC2CA2B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A74606B7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933E31A815;
	Mon,  3 Nov 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bHa9pfUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwl1qc/a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012C314A8A;
	Mon,  3 Nov 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181270; cv=none; b=D4RfDulK6lTjk6o98WFukCq8oF6ics6IIL+VJyMpl7LpqWYW2wpIWG6zUiXebe95KTQOApBHocKwnFHCBpJzVVNkRTKjCTAcsMC9eZ/ngPUHEkVtUS3+fKiFEC5wQaNJPzlV1ykXQV8fbZI6LKzbYe1qi4jvIRkVPLbESodEEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181270; c=relaxed/simple;
	bh=xo/11Nskqi+fKck/JyLoUdVX9zLw78UoKbqSOrEPrsw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JAJexgtu8Hw1LmYtlMWJRGcbruBgtCe+Z25mbQJ/ondECP3lAFlhgvoPG3QdW4VrutfTFQsQYixqR9gNPGvdGVFonBOx5h94B8ePXbMRBZLmT4kzD1d8n8jCRgoO5c7Q/GBpU81+sWelB+8s7IunMThfcmHwSVo6GAstYtHjLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bHa9pfUm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwl1qc/a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yW7b+rEc2zXkxK4pe+KNR8jt2zncL1KCwQz1lpVYeRk=;
	b=bHa9pfUmS8jVy6F4gvvbAZ/CZkSrUOCiDopaZABUAy+cZotphMgwLB5s63uNnJUQOCvR4Q
	Mdl6XM2H8FerKS3hQc+XkR+oQmIxXq+Z+OmWLso35y6mHoL0VSiRWz9RVe0fA6OZlRa7zI
	GZ7wewUXw2rEonSZYFY4+TlPQXGPAVwF811yF+Url/PqlssoHPUUXhlecmtrED0fcGX9Ck
	bG0TB250ECoIiY+d0Ad69WhvYenCnuZDaozEmULEDD1smPEVhjvbVshbP/El6/tL9stPKE
	34APD2UeZyfwjuztdsEun37Luy+B4J+pn03lCxQYTJE6nPBbRbM3N5rRVCJVbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yW7b+rEc2zXkxK4pe+KNR8jt2zncL1KCwQz1lpVYeRk=;
	b=cwl1qc/aCx0l7rCaSm8GNZ9SYwb2mUXACL1W+2GQSKgRlJe0iW/tGFwPV71icAvYb29odK
	caLGKMQXM9D9S2Aw==
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
Message-ID: <176218126632.2601451.6142961188434395605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     d73c292f40b4ebb8369f5d0273b4dd5fc229b707
Gitweb:        https://git.kernel.org/tip/d73c292f40b4ebb8369f5d0273b4dd5fc22=
9b707
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:15 +01:00

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

