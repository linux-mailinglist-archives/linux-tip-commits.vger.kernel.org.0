Return-Path: <linux-tip-commits+bounces-5385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E01AADAD7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90401BC1B8F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52D239E93;
	Wed,  7 May 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+MDBAd1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1iZoKICL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E6238C08;
	Wed,  7 May 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608854; cv=none; b=GG0raGSlP5t3UINaXSR/Z+42l1insK+yP4MFNAo8hmBbYZz5JiJx3aWsX+GTz6D/TU8ZklCFR5eaRkyd9vZaoubtRbqB6fw39bAnCgwcNhzOV2pMsUAmKGLilhE2sfGNYYKXbwYhnDDyOAm0vciqNmG98uV6jLenlWLRms3MgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608854; c=relaxed/simple;
	bh=ccfmx8IjfGcvvC9E1SoVf9TVuGmEPvO5cBFzoMBu6kI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bhQ+nfFyYXLuAnCrgvlxQpbXmf64cyX672BWdzOtkPXF5XNvXhKEtvB/VxKAEk69OS3O4lNxQ7EDoZOxMkVviWpugnlJt1bMcTrMFUZ6WkadXwKqnvTOUTp8QVWEOu5k8HzOL/f/WcpSswllKcYyMyocBgzdUYcyyYLnsxYj0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+MDBAd1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1iZoKICL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noQ3o/mqTvLM/HRUPpm/Ti2d1OXPA5PVRIFLUm3zgBk=;
	b=X+MDBAd1NDVIoDnwVCESKcPdiFrjuhowNvnZyY7uTSzelJCt7AqyobcOjMaN2kQo9eboWe
	AjKx9+MKiPXnsnab02Z7EY39o6fWTmk1fPt+LSmPpng+kNeGib/b4m6ek7kw6rXyS+B4SN
	5D2Wh+mSYENbPjGXrhxa2qLYKfi3vqhpLg4crZDFOil+FFNaoePBvhsXf8944SiLTfikVL
	Cl2ugZ/eT8sJoS5Tavla+7yXbTvUU91uiYWm3wfdFyqUFMcMXNz0h1p47pdnMut9oEuA3R
	NgPPFQ+Hhq4UTuh6X/app39JT9lutq5yBtL5hQv6SoMFyF7UHstcPgdKyD79MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noQ3o/mqTvLM/HRUPpm/Ti2d1OXPA5PVRIFLUm3zgBk=;
	b=1iZoKICL8VpXKm/ZZsXh5XRNDAPZi4z25+rjhr2G1gge33kyfIcuASVP9CUEAcV2kLghC4
	06OxAVRHvGEtq3CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Convert to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.771476066@linutronix.de>
References: <20250429065421.771476066@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884940.406.5561788089487732135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     17c1953567ebe08c88effb053df13744d0952cd1
Gitweb:        https://git.kernel.org/tip/17c1953567ebe08c88effb053df13744d0952cd1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/manage: Convert to lock guards

Convert lock/unlock pairs to guards.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.771476066@linutronix.de


---
 kernel/irq/manage.c | 155 ++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 97 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 570fa5a..8b4b960 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -43,8 +43,6 @@ static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 	bool inprogress;
 
 	do {
-		unsigned long flags;
-
 		/*
 		 * Wait until we're out of the critical section.  This might
 		 * give the wrong answer due to the lack of memory barriers.
@@ -53,7 +51,7 @@ static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 			cpu_relax();
 
 		/* Ok, that indicated we're done: double-check carefully. */
-		raw_spin_lock_irqsave(&desc->lock, flags);
+		guard(raw_spinlock_irqsave)(&desc->lock);
 		inprogress = irqd_irq_inprogress(&desc->irq_data);
 
 		/*
@@ -69,8 +67,6 @@ static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
 						&inprogress);
 		}
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-
 		/* Oops, that failed? */
 	} while (inprogress);
 }
@@ -458,16 +454,12 @@ static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,
 			      bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
-	int ret;
 
 	if (!desc)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	ret = irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask, force);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return ret;
+	guard(raw_spinlock_irqsave)(&desc->lock);
+	return irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask, force);
 }
 
 /**
@@ -522,17 +514,16 @@ static void irq_affinity_notify(struct work_struct *work)
 		container_of(work, struct irq_affinity_notify, work);
 	struct irq_desc *desc = irq_to_desc(notify->irq);
 	cpumask_var_t cpumask;
-	unsigned long flags;
 
 	if (!desc || !alloc_cpumask_var(&cpumask, GFP_KERNEL))
 		goto out;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	if (irq_move_pending(&desc->irq_data))
-		irq_get_pending(cpumask, desc);
-	else
-		cpumask_copy(cpumask, desc->irq_common_data.affinity);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		if (irq_move_pending(&desc->irq_data))
+			irq_get_pending(cpumask, desc);
+		else
+			cpumask_copy(cpumask, desc->irq_common_data.affinity);
+	}
 
 	notify->notify(notify, cpumask);
 
@@ -556,7 +547,6 @@ int irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *noti
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_affinity_notify *old_notify;
-	unsigned long flags;
 
 	/* The release function is promised process context */
 	might_sleep();
@@ -571,10 +561,10 @@ int irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *noti
 		INIT_WORK(&notify->work, irq_affinity_notify);
 	}
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	old_notify = desc->affinity_notify;
-	desc->affinity_notify = notify;
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		old_notify = desc->affinity_notify;
+		desc->affinity_notify = notify;
+	}
 
 	if (old_notify) {
 		if (cancel_work_sync(&old_notify->work)) {
@@ -595,7 +585,8 @@ EXPORT_SYMBOL_GPL(irq_set_affinity_notifier);
 int irq_setup_affinity(struct irq_desc *desc)
 {
 	struct cpumask *set = irq_default_affinity;
-	int ret, node = irq_desc_get_node(desc);
+	int node = irq_desc_get_node(desc);
+
 	static DEFINE_RAW_SPINLOCK(mask_lock);
 	static struct cpumask mask;
 
@@ -603,7 +594,7 @@ int irq_setup_affinity(struct irq_desc *desc)
 	if (!__irq_can_set_affinity(desc))
 		return 0;
 
-	raw_spin_lock(&mask_lock);
+	guard(raw_spinlock)(&mask_lock);
 	/*
 	 * Preserve the managed affinity setting and a userspace affinity
 	 * setup, but make sure that one of the targets is online.
@@ -628,9 +619,7 @@ int irq_setup_affinity(struct irq_desc *desc)
 		if (cpumask_intersects(&mask, nodemask))
 			cpumask_and(&mask, &mask, nodemask);
 	}
-	ret = irq_do_set_affinity(&desc->irq_data, &mask, false);
-	raw_spin_unlock(&mask_lock);
-	return ret;
+	return irq_do_set_affinity(&desc->irq_data, &mask, false);
 }
 #else
 /* Wrapper for ALPHA specific affinity selector magic */
@@ -1072,19 +1061,19 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 		return;
 	}
 
-	raw_spin_lock_irq(&desc->lock);
-	/*
-	 * This code is triggered unconditionally. Check the affinity
-	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
-	 */
-	if (cpumask_available(desc->irq_common_data.affinity)) {
-		const struct cpumask *m;
+	scoped_guard(raw_spinlock_irq, &desc->lock) {
+		/*
+		 * This code is triggered unconditionally. Check the affinity
+		 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
+		 */
+		if (cpumask_available(desc->irq_common_data.affinity)) {
+			const struct cpumask *m;
 
-		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
-		cpumask_copy(mask, m);
-		valid = true;
+			m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+			cpumask_copy(mask, m);
+			valid = true;
+		}
 	}
-	raw_spin_unlock_irq(&desc->lock);
 
 	if (valid)
 		set_cpus_allowed_ptr(current, mask);
@@ -1252,9 +1241,8 @@ static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
 	if (WARN_ON_ONCE(!secondary))
 		return;
 
-	raw_spin_lock_irq(&desc->lock);
+	guard(raw_spinlock_irq)(&desc->lock);
 	__irq_wake_thread(desc, secondary);
-	raw_spin_unlock_irq(&desc->lock);
 }
 
 /*
@@ -1335,12 +1323,11 @@ void irq_wake_thread(unsigned int irq, void *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irqaction *action;
-	unsigned long flags;
 
 	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
 		return;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irqsave)(&desc->lock);
 	for_each_action_of_desc(desc, action) {
 		if (action->dev_id == dev_id) {
 			if (action->thread)
@@ -1348,7 +1335,6 @@ void irq_wake_thread(unsigned int irq, void *dev_id)
 			break;
 		}
 	}
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(irq_wake_thread);
 
@@ -1979,9 +1965,8 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		 * There is no interrupt on the fly anymore. Deactivate it
 		 * completely.
 		 */
-		raw_spin_lock_irqsave(&desc->lock, flags);
-		irq_domain_deactivate_irq(&desc->irq_data);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		scoped_guard(raw_spinlock_irqsave, &desc->lock)
+			irq_domain_deactivate_irq(&desc->irq_data);
 
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
@@ -2066,8 +2051,6 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 const void *free_nmi(unsigned int irq, void *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
-	const void *devname;
 
 	if (!desc || WARN_ON(!irq_is_nmi(desc)))
 		return NULL;
@@ -2079,14 +2062,9 @@ const void *free_nmi(unsigned int irq, void *dev_id)
 	if (WARN_ON(desc->depth == 0))
 		disable_nmi_nosync(irq);
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-
+	guard(raw_spinlock_irqsave)(&desc->lock);
 	irq_nmi_teardown(desc);
-	devname = __cleanup_nmi(irq, desc);
-
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
-	return devname;
+	return __cleanup_nmi(irq, desc);
 }
 
 /**
@@ -2290,7 +2268,6 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
-	unsigned long flags;
 	int retval;
 
 	if (irq == IRQ_NOTCONNECTED)
@@ -2332,21 +2309,17 @@ int request_nmi(unsigned int irq, irq_handler_t handler,
 	if (retval)
 		goto err_irq_setup;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-
-	/* Setup NMI state */
-	desc->istate |= IRQS_NMI;
-	retval = irq_nmi_setup(desc);
-	if (retval) {
-		__cleanup_nmi(irq, desc);
-		raw_spin_unlock_irqrestore(&desc->lock, flags);
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		/* Setup NMI state */
+		desc->istate |= IRQS_NMI;
+		retval = irq_nmi_setup(desc);
+		if (retval) {
+			__cleanup_nmi(irq, desc);
+			return -EINVAL;
+		}
+		return 0;
 	}
 
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
-	return 0;
-
 err_irq_setup:
 	irq_chip_pm_put(&desc->irq_data);
 err_out:
@@ -2445,43 +2418,34 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irqaction *action;
-	unsigned long flags;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
 	if (!desc)
 		return NULL;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+		action = desc->action;
+		if (!action || action->percpu_dev_id != dev_id) {
+			WARN(1, "Trying to free already-free IRQ %d\n", irq);
+			return NULL;
+		}
 
-	action = desc->action;
-	if (!action || action->percpu_dev_id != dev_id) {
-		WARN(1, "Trying to free already-free IRQ %d\n", irq);
-		goto bad;
-	}
+		if (!cpumask_empty(desc->percpu_enabled)) {
+			WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
+			     irq, cpumask_first(desc->percpu_enabled));
+			return NULL;
+		}
 
-	if (!cpumask_empty(desc->percpu_enabled)) {
-		WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
-		     irq, cpumask_first(desc->percpu_enabled));
-		goto bad;
+		/* Found it - now remove it from the list of entries: */
+		desc->action = NULL;
+		desc->istate &= ~IRQS_NMI;
 	}
 
-	/* Found it - now remove it from the list of entries: */
-	desc->action = NULL;
-
-	desc->istate &= ~IRQS_NMI;
-
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
 	unregister_handler_proc(irq, action);
-
 	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
 	return action;
-
-bad:
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return NULL;
 }
 
 /**
@@ -2651,7 +2615,6 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
-	unsigned long flags;
 	int retval;
 
 	if (!handler)
@@ -2687,10 +2650,8 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 	if (retval)
 		goto err_irq_setup;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irqsave)(&desc->lock);
 	desc->istate |= IRQS_NMI;
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-
 	return 0;
 
 err_irq_setup:

