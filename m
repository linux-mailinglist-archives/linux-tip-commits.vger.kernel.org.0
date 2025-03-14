Return-Path: <linux-tip-commits+bounces-4222-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6CA61C6E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434FC189DB33
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E02046B9;
	Fri, 14 Mar 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqQsqv/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8YDFiAd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3918A6BD;
	Fri, 14 Mar 2025 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983836; cv=none; b=s0SuG8oYYeL2so4R0j3dQ8zGVUKqkqCutXp+c2e4nQ3i7EG1vJJ2mpC6Zykbm3G09gU4tpaf1v+LliTi69t/1OBKi82avyjyS9FD29RVoU6ArBRAm/MvTwaUZb3lA64632lzbgob7du8kuHy6VJtl9W19ZHJ59fkpL8QQqyf+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983836; c=relaxed/simple;
	bh=SSQ+fBG40ONVVlySgiNs5h9fplRRLrSBP4xVLtfB5Uo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TTdiDja8/SIkqCIQ5WUw6g4HEt2+dpKb6rDIa6y/Wi5B0L7eqp5bWWgY5uF0eo2ht8WfMI3vPeT/NK0BskLdd+QaOJl6rUu98CcxbWps7O733GU4SG4wiZI4+VIJug702g9SL8WQzenbyZihZYf17I0l0oazoIu+SmkQDqEKfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqQsqv/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8YDFiAd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:23:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741983833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56WAGsxiEDkr6l/q7GY0YhQW/9NPHq5DD64gwXxIKwU=;
	b=LqQsqv/um1kHjJnYA27cWkRvdFT5y97xe1Xhwlz7l0MB9PChOY0VCEC2qfghvpR3KhUstz
	n9+aSds5LotPWiIThzJJxCjzBCNmxg9+8jQcAybifXmjWle12fi10/OzOSE9+0Pj45ruWm
	nYODcuW7NvEC98TSf7VtEj1yk7ImyMzKU2bzoIOuOJiXoqzT62/d+9B3blYSVWpfBolBp5
	fBqqQiTdkUudGAyjxa+NpbsCXyUpwEiGLZYUDOh7+PefmQA0T9rgFHQHVClcY+xyxWjeNv
	InPqPMEGWVMJsiCU0NQHxRnrTStV/cK1PFoNthiBAOYEE8MaJ+0zgOYFyIa2bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741983833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56WAGsxiEDkr6l/q7GY0YhQW/9NPHq5DD64gwXxIKwU=;
	b=p8YDFiAd0QSzBSPknsg1WwSWB8O4na+KFE+T4XUNEvV9xpngwdhGwZRmKOm3x+GXloDl3V
	pmq22MYN8dcNrsCA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Cc: Guenter Roeck <linux@roeck-us.net>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>
References: <20250212103619.2560503-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198383247.14745.4699313484562904011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     87886b32d669abc11c7be95ef44099215e4f5788
Gitweb:        https://git.kernel.org/tip/87886b32d669abc11c7be95ef44099215e4f5788
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 12 Feb 2025 11:36:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Mar 2025 21:13:20 +01:00

lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()

disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
avoid false positive reports by lockdep that a certain lock has not been
acquired with disabled interrupts. The user of this macros expects that
a lock can be acquried without disabling interrupts because the IRQ line
triggering the interrupt is disabled.

This triggers a warning on PREEMPT_RT because after
disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
with disabled interrupts.

On PREEMPT_RT there is no difference between spin_lock() and
spin_lock_irq() so avoiding disabling interrupts in this case works for
the two remaining callers as of today.

Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().

Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250212103619.2560503-2-bigeasy@linutronix.de
---
 include/linux/interrupt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 8cd9327..a1b1be9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 static inline void disable_irq_nosync_lockdep(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_disable();
 #endif
 }
@@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
 static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
 {
 	disable_irq_nosync(irq);
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_save(*flags);
 #endif
 }
@@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep(unsigned int irq)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_enable();
 #endif
 	enable_irq(irq);
@@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
 
 static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
 {
-#ifdef CONFIG_LOCKDEP
+#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
 	local_irq_restore(*flags);
 #endif
 	enable_irq(irq);

