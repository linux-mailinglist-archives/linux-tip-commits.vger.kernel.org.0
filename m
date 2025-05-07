Return-Path: <linux-tip-commits+bounces-5408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8EAADB0C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B0E465241
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C552512D5;
	Wed,  7 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bb6sZzGM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQGePjHs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89392248872;
	Wed,  7 May 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608870; cv=none; b=PGPehKFLzlADyVdGO6bbvStkb9soaeXvH5UFdOk3A7g3qDu6oTVB5qNpMW8NqXDMPKBaemw3lFkwbP9+ey72I1HK91HLk+gz3NqWejqtcx+lfx0uy5+fRB5Rfb7r6QUm4VGUeipT4hHr40togY3MJmxS49tMBh9AKbjKUlPD3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608870; c=relaxed/simple;
	bh=HGO9WdNs95uI3/gt+gKvOp5Yy/p6Y2bp81zl4mYuH88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ovEEGEmwquD2SIJuq9zO9t5yQbyIBZPvlHqQnvJ66v0pgy1svix/+w4eXNS12driCYT+u844NKp3AziN8jASLwOYzeT9D/rqWT5/A6cI93qwRRLSsRkpcEn0+14PR7tYTJUNzjo9lR5uB7cOBdSvOEMV+75KOEZUJOXifx5Kgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bb6sZzGM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQGePjHs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irdoxvbikSTH568qL7ZqWsgIt0ZKNPnrNyGKHfgcLhQ=;
	b=Bb6sZzGMepRPeTdg/7AFpiWu3HrUefyaDsEBLZ8PClfstEwg9jkupfckqVfU96EyYx9e2/
	cE4H5LnG2p7JnqfLTUDvIM8hlfTN2HE7J5J0w/+VCQYMcBT7gWx6Rpxvh3l2LrpOAlK/++
	sOo4Mbn65nYYl4ybdRMPOCvLrjiDnCkyYil7cOjYTwW+kgGenXU/GF35DVYD1zNDVYB2bf
	TmR9OXSMChdzJS1oh/jWHLR5vIuHvnfByY5UHsdGpkGp7Cp+kViVhwO04WsvkrqgGsgXGN
	fthC7ndObrP4wXDlSVvPNrKdUqCRyfUHKcgZxyE0VBvPpTtQzM5a/U/Q6hFUkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irdoxvbikSTH568qL7ZqWsgIt0ZKNPnrNyGKHfgcLhQ=;
	b=kQGePjHsdeO4J8pVlWkxoPScoN9wd8ncBvb96EqmaSrWBEQbYmrsyaMWcZbOrgCaScgdox
	uBAhgLoXCRSAV+Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/proc: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.373998838@linutronix.de>
References: <20250429065420.373998838@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886505.406.6692239363644484881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     659ff9c9d77b8ad9d9c18e264abc9a56bd19230e
Gitweb:        https://git.kernel.org/tip/659ff9c9d77b8ad9d9c18e264abc9a56bd19230e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq/proc: Switch to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.373998838@linutronix.de


---
 kernel/irq/proc.c | 65 ++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 8e29809..94eba9a 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -81,20 +81,18 @@ static int show_irq_affinity(int type, struct seq_file *m)
 static int irq_affinity_hint_proc_show(struct seq_file *m, void *v)
 {
 	struct irq_desc *desc = irq_to_desc((long)m->private);
-	unsigned long flags;
 	cpumask_var_t mask;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	if (desc->affinity_hint)
-		cpumask_copy(mask, desc->affinity_hint);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	scoped_guard(raw_spinlock_irq, &desc->lock) {
+		if (desc->affinity_hint)
+			cpumask_copy(mask, desc->affinity_hint);
+	}
 
 	seq_printf(m, "%*pb\n", cpumask_pr_args(mask));
 	free_cpumask_var(mask);
-
 	return 0;
 }
 
@@ -295,23 +293,18 @@ static int irq_spurious_proc_show(struct seq_file *m, void *v)
 
 #define MAX_NAMELEN 128
 
-static int name_unique(unsigned int irq, struct irqaction *new_action)
+static bool name_unique(unsigned int irq, struct irqaction *new_action)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irqaction *action;
-	unsigned long flags;
-	int ret = 1;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irq)(&desc->lock);
 	for_each_action_of_desc(desc, action) {
 		if ((action != new_action) && action->name &&
-				!strcmp(new_action->name, action->name)) {
-			ret = 0;
-			break;
-		}
+		    !strcmp(new_action->name, action->name))
+			return false;
 	}
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-	return ret;
+	return true;
 }
 
 void register_handler_proc(unsigned int irq, struct irqaction *action)
@@ -319,8 +312,7 @@ void register_handler_proc(unsigned int irq, struct irqaction *action)
 	char name [MAX_NAMELEN];
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (!desc->dir || action->dir || !action->name ||
-					!name_unique(irq, action))
+	if (!desc->dir || action->dir || !action->name || !name_unique(irq, action))
 		return;
 
 	snprintf(name, MAX_NAMELEN, "%s", action->name);
@@ -347,17 +339,16 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	 * added, not when the descriptor is created, so multiple
 	 * tasks might try to register at the same time.
 	 */
-	mutex_lock(&register_lock);
+	guard(mutex)(&register_lock);
 
 	if (desc->dir)
-		goto out_unlock;
-
-	sprintf(name, "%d", irq);
+		return;
 
 	/* create /proc/irq/1234 */
+	sprintf(name, "%d", irq);
 	desc->dir = proc_mkdir(name, root_irq_dir);
 	if (!desc->dir)
-		goto out_unlock;
+		return;
 
 #ifdef CONFIG_SMP
 	umode_t umode = S_IRUGO;
@@ -366,31 +357,27 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 		umode |= S_IWUSR;
 
 	/* create /proc/irq/<irq>/smp_affinity */
-	proc_create_data("smp_affinity", umode, desc->dir,
-			 &irq_affinity_proc_ops, irqp);
+	proc_create_data("smp_affinity", umode, desc->dir, &irq_affinity_proc_ops, irqp);
 
 	/* create /proc/irq/<irq>/affinity_hint */
 	proc_create_single_data("affinity_hint", 0444, desc->dir,
-			irq_affinity_hint_proc_show, irqp);
+				irq_affinity_hint_proc_show, irqp);
 
 	/* create /proc/irq/<irq>/smp_affinity_list */
 	proc_create_data("smp_affinity_list", umode, desc->dir,
 			 &irq_affinity_list_proc_ops, irqp);
 
-	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show,
-			irqp);
+	proc_create_single_data("node", 0444, desc->dir, irq_node_proc_show, irqp);
 # ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	proc_create_single_data("effective_affinity", 0444, desc->dir,
-			irq_effective_aff_proc_show, irqp);
+				irq_effective_aff_proc_show, irqp);
 	proc_create_single_data("effective_affinity_list", 0444, desc->dir,
-			irq_effective_aff_list_proc_show, irqp);
+				irq_effective_aff_list_proc_show, irqp);
 # endif
 #endif
 	proc_create_single_data("spurious", 0444, desc->dir,
-			irq_spurious_proc_show, (void *)(long)irq);
+				irq_spurious_proc_show, (void *)(long)irq);
 
-out_unlock:
-	mutex_unlock(&register_lock);
 }
 
 void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
@@ -468,7 +455,6 @@ int show_interrupts(struct seq_file *p, void *v)
 	int i = *(loff_t *) v, j;
 	struct irqaction *action;
 	struct irq_desc *desc;
-	unsigned long flags;
 
 	if (i > ACTUAL_NR_IRQS)
 		return 0;
@@ -487,13 +473,13 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 	}
 
-	rcu_read_lock();
+	guard(rcu)();
 	desc = irq_to_desc(i);
 	if (!desc || irq_settings_is_hidden(desc))
-		goto outsparse;
+		return 0;
 
 	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
-		goto outsparse;
+		return 0;
 
 	seq_printf(p, "%*d:", prec, i);
 	for_each_online_cpu(j) {
@@ -503,7 +489,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 	seq_putc(p, ' ');
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
+	guard(raw_spinlock_irq)(&desc->lock);
 	if (desc->irq_data.chip) {
 		if (desc->irq_data.chip->irq_print_chip)
 			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
@@ -532,9 +518,6 @@ int show_interrupts(struct seq_file *p, void *v)
 	}
 
 	seq_putc(p, '\n');
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
-outsparse:
-	rcu_read_unlock();
 	return 0;
 }
 #endif

