Return-Path: <linux-tip-commits+bounces-5407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66459AADB09
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266B617C62A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C52505A9;
	Wed,  7 May 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AS0F4rm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBWAVmLz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407B231A4D;
	Wed,  7 May 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608869; cv=none; b=aO51PVLY8jZXvswmQXU765eGMDKUQ0caABbvHf/PJ5pAS2xYC4ggD4844Wgc/D1nb1uUH7RghXG+X43+Jao46iiOq6PX28EPn8blmayb4gqL4gM8yXweSFFfhSRnuIvsVP93iNoWBwiT4ejZ/nmXJkpQMeD7QSDPvqTNWP2bPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608869; c=relaxed/simple;
	bh=C5VXAxyjd/U2MHauCWgHA7bTdoGk6wnG0okkTmOoA1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a+O+mcG9dvhe5ABGmA+G12+GZqZNHvJLpCQ1gbepkeb8ULBt5XSMmfZ/AK+AUyYxpSoU1P5H01tHsnoYfOI9N0BvqL2glY9q8dHOPi6woI7nkYHqlPkkF9LsGAxJqY7MroIWUAQNzenKgLTzTqMzj18JqaSFGzbLTsd0RUGbyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AS0F4rm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBWAVmLz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33u7MlwdAPqT1JKiraCBMgw86uvKkg8rTWjyrE+BH4I=;
	b=1AS0F4rmSmtc2/JbZZlw6z8HiKW5GtojyPf8Ex6hUEH+YucpBSxXmAECVq/vJHLoaTfOO3
	c0Q9tEXcR5jmxLNOUfdh77MgCl/0s2myrbCo1VoossNC4RG7kpGJGvLbvqQXxgL7MHZwkY
	dpm2F8n9opsh8cX8y/4q9D7x69mNw/4uMFM+eotfqj94tRwOPTGzu0VksyDgnM4cNYl+oD
	O3XP+7TTrKwMSaG/ToyWi/6cqONFqHP7ih91+qEoXZM70IFRhreaAzGO72Cv7qiw4vgVmq
	ehAjL3IKPW2mziofvob4DqWxKO5FKXflcINV4T7bYXaaWLIBJoH6r8v07kcieA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33u7MlwdAPqT1JKiraCBMgw86uvKkg8rTWjyrE+BH4I=;
	b=gBWAVmLzhoyZLskreorMPMLwOW4JhZOmk14VQgLk/O4Nk5XH9QnHv7SVNxnaHTEHT9gIQK
	OTgEPe0+6xwT3hDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/spurious: Cleanup code
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.437285102@linutronix.de>
References: <20250429065420.437285102@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886439.406.26903020845620109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e815ffc759fb810672b9d90badae928534cde78a
Gitweb:        https://git.kernel.org/tip/e815ffc759fb810672b9d90badae928534cde78a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/spurious: Cleanup code

Clean up the coding style

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.437285102@linutronix.de


---
 kernel/irq/spurious.c | 74 +++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf..296cb48 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -34,8 +34,9 @@ static atomic_t irq_poll_active;
  * true and let the handler run.
  */
 bool irq_wait_for_poll(struct irq_desc *desc)
-	__must_hold(&desc->lock)
 {
+	lockdep_assert_held(&desc->lock);
+
 	if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
 		      "irq poll in progress on cpu %d for irq %d\n",
 		      smp_processor_id(), desc->irq_data.irq))
@@ -157,8 +158,7 @@ static void poll_spurious_irqs(struct timer_list *unused)
 			 continue;
 
 		/* Racy but it doesn't matter */
-		state = desc->istate;
-		barrier();
+		state = READ_ONCE(desc->istate);
 		if (!(state & IRQS_SPURIOUS_DISABLED))
 			continue;
 
@@ -168,8 +168,7 @@ static void poll_spurious_irqs(struct timer_list *unused)
 	}
 out:
 	atomic_dec(&irq_poll_active);
-	mod_timer(&poll_spurious_irq_timer,
-		  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
+	mod_timer(&poll_spurious_irq_timer, jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 }
 
 static inline int bad_action_ret(irqreturn_t action_ret)
@@ -195,15 +194,12 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 	struct irqaction *action;
 	unsigned long flags;
 
-	if (bad_action_ret(action_ret)) {
-		printk(KERN_ERR "irq event %d: bogus return value %x\n",
-				irq, action_ret);
-	} else {
-		printk(KERN_ERR "irq %d: nobody cared (try booting with "
-				"the \"irqpoll\" option)\n", irq);
-	}
+	if (bad_action_ret(action_ret))
+		pr_err("irq event %d: bogus return value %x\n", irq, action_ret);
+	else
+		pr_err("irq %d: nobody cared (try booting with the \"irqpoll\" option)\n", irq);
 	dump_stack();
-	printk(KERN_ERR "handlers:\n");
+	pr_err("handlers:\n");
 
 	/*
 	 * We need to take desc->lock here. note_interrupt() is called
@@ -213,11 +209,10 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 	 */
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	for_each_action_of_desc(desc, action) {
-		printk(KERN_ERR "[<%p>] %ps", action->handler, action->handler);
+		pr_err("[<%p>] %ps", action->handler, action->handler);
 		if (action->thread_fn)
-			printk(KERN_CONT " threaded [<%p>] %ps",
-					action->thread_fn, action->thread_fn);
-		printk(KERN_CONT "\n");
+			pr_cont(" threaded [<%p>] %ps", action->thread_fn, action->thread_fn);
+		pr_cont("\n");
 	}
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
@@ -232,18 +227,17 @@ static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 	}
 }
 
-static inline int
-try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
-		  irqreturn_t action_ret)
+static inline bool try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
+				     irqreturn_t action_ret)
 {
 	struct irqaction *action;
 
 	if (!irqfixup)
-		return 0;
+		return false;
 
 	/* We didn't actually handle the IRQ - see if it was misrouted? */
 	if (action_ret == IRQ_NONE)
-		return 1;
+		return true;
 
 	/*
 	 * But for 'irqfixup == 2' we also do it for handled interrupts if
@@ -251,19 +245,16 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 	 * traditional PC timer interrupt.. Legacy)
 	 */
 	if (irqfixup < 2)
-		return 0;
+		return false;
 
 	if (!irq)
-		return 1;
+		return true;
 
 	/*
 	 * Since we don't get the descriptor lock, "action" can
-	 * change under us.  We don't really care, but we don't
-	 * want to follow a NULL pointer. So tell the compiler to
-	 * just load it once by using a barrier.
+	 * change under us.
 	 */
-	action = desc->action;
-	barrier();
+	action = READ_ONCE(desc->action);
 	return action && (action->flags & IRQF_IRQPOLL);
 }
 
@@ -273,8 +264,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq;
 
-	if (desc->istate & IRQS_POLL_INPROGRESS ||
-	    irq_settings_is_polled(desc))
+	if (desc->istate & IRQS_POLL_INPROGRESS || irq_settings_is_polled(desc))
 		return;
 
 	if (bad_action_ret(action_ret)) {
@@ -420,13 +410,12 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		/*
 		 * Now kill the IRQ
 		 */
-		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
+		pr_emerg("Disabling IRQ #%d\n", irq);
 		desc->istate |= IRQS_SPURIOUS_DISABLED;
 		desc->depth++;
 		irq_disable(desc);
 
-		mod_timer(&poll_spurious_irq_timer,
-			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
+		mod_timer(&poll_spurious_irq_timer, jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 	}
 	desc->irqs_unhandled = 0;
 }
@@ -436,11 +425,9 @@ bool noirqdebug __read_mostly;
 int noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
-	printk(KERN_INFO "IRQ lockup detection disabled\n");
-
+	pr_info("IRQ lockup detection disabled\n");
 	return 1;
 }
-
 __setup("noirqdebug", noirqdebug_setup);
 module_param(noirqdebug, bool, 0644);
 MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detection when true");
@@ -452,12 +439,10 @@ static int __init irqfixup_setup(char *str)
 		return 1;
 	}
 	irqfixup = 1;
-	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
-	printk(KERN_WARNING "This may impact system performance.\n");
-
+	pr_warn("Misrouted IRQ fixup support enabled.\n");
+	pr_warn("This may impact system performance.\n");
 	return 1;
 }
-
 __setup("irqfixup", irqfixup_setup);
 module_param(irqfixup, int, 0644);
 
@@ -468,11 +453,8 @@ static int __init irqpoll_setup(char *str)
 		return 1;
 	}
 	irqfixup = 2;
-	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
-				"enabled\n");
-	printk(KERN_WARNING "This may significantly impact system "
-				"performance\n");
+	pr_warn("Misrouted IRQ fixup and polling support enabled\n");
+	pr_warn("This may significantly impact system performance\n");
 	return 1;
 }
-
 __setup("irqpoll", irqpoll_setup);

