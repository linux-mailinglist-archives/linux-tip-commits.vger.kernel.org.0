Return-Path: <linux-tip-commits+bounces-5412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0CCAADB11
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC29A2715
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA88253B67;
	Wed,  7 May 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLNB7HBr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6oXrt1f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E822512EB;
	Wed,  7 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608872; cv=none; b=K+EU99xIolWcmKXMYlQeyZ9Rwngoix/UmGjWFLFjPZwJWN1nAfhuU67cJaOVHO6ievDdQmjy/ZrT9i7BJIn9+I3mTwFYG/qVyiTtaLHfuHhTmTqtYpB1ztqhcCOXQ4Z1x21BermyC1t9K+HNEloGvzpddfNUcRB3HifJIBXbD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608872; c=relaxed/simple;
	bh=W6zwwnBA4ty4Zo5XHUSPd+rW0/SKW4m8W4ijM+HFVoU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F+poNNsHg8KBDDFi34dnqCSNhIS6nxj48pwhwpo5BEx4WuiKdJT8qB+LTnjrdl/gV59VYV7cJvbmcsrl7asCRyp4IIl/RK0lNPzKjrbxP4tmSuU0HcqHXvC7EU6oYJzxBHzqTvxR7CL3+ygk81xsSgpe1bbY+DMdMNAmV9CibBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLNB7HBr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z6oXrt1f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPXGGruFk6oCm9A13KuNJGd6i39a0WGOPaEVLEB8+7w=;
	b=LLNB7HBrDuncFI41mVLbNM/6GPyRsXUY+MMvTTVat+16Turh36jNrhgqi+KaG4+BzO9vfc
	ihlxvMURX0GFYQ6qYsLp6OA5e6gL0aTgU+EU+ny3SjPTPBUkN4GY/kFhqI7sBokeeXLjzM
	noaFleuqQhLkMewGdPtq8nNlgAcTJ86etVj1SuxmwOSFNpYJixGrkxKvLQ167i757WHk6C
	4NPurV0qfTbclaXVRQepqNajqJ/49HrnbwmsuuMZMCUECZQtbguEmNN9aHBvKtsDv+LDhk
	WtI1/9Tz39Okf8KYg5QZrMs8M0N6hpRXzJto7xY10uz+kggXXIuxBrvgA4xlsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPXGGruFk6oCm9A13KuNJGd6i39a0WGOPaEVLEB8+7w=;
	b=Z6oXrt1fR1j99sJASdLcgyQWHT9MTNQajIpkk8ZF2Ty9opeh4czBzmZe4NoX6MACPz3Vrc
	kJcvLHbksAEssoCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdesc: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <871ptaqhoo.ffs@tglx>
References: <871ptaqhoo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886775.406.17965564730523036752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5d964a9f7cd8f669db588d9d0db61b4f81af4978
Gitweb:        https://git.kernel.org/tip/5d964a9f7cd8f669db588d9d0db61b4f81af4978
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 30 Apr 2025 08:36:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq/irqdesc: Switch to lock guards

Replace all lock/unlock pairs with lock guards and simplify the code flow.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/871ptaqhoo.ffs@tglx

---
 kernel/irq/irqdesc.c | 129 ++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 85 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5b3aee2..6d006a6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -246,8 +246,7 @@ static struct kobject *irq_kobj_base;
 #define IRQ_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
-static ssize_t per_cpu_count_show(struct kobject *kobj,
-				  struct kobj_attribute *attr, char *buf)
+static ssize_t per_cpu_count_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 	ssize_t ret = 0;
@@ -266,99 +265,75 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(per_cpu_count);
 
-static ssize_t chip_name_show(struct kobject *kobj,
-			      struct kobj_attribute *attr, char *buf)
+static ssize_t chip_name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
 
-	raw_spin_lock_irq(&desc->lock);
+	guard(raw_spinlock_irq)(&desc->lock);
 	if (desc->irq_data.chip && desc->irq_data.chip->name)
-		ret = sysfs_emit(buf, "%s\n", desc->irq_data.chip->name);
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
+		return sysfs_emit(buf, "%s\n", desc->irq_data.chip->name);
+	return 0;
 }
 IRQ_ATTR_RO(chip_name);
 
-static ssize_t hwirq_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf)
+static ssize_t hwirq_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
 
+	guard(raw_spinlock_irq)(&desc->lock);
 	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.domain)
-		ret = sysfs_emit(buf, "%lu\n", desc->irq_data.hwirq);
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
+		return sysfs_emit(buf, "%lu\n", desc->irq_data.hwirq);
+	return 0;
 }
 IRQ_ATTR_RO(hwirq);
 
-static ssize_t type_show(struct kobject *kobj,
-			 struct kobj_attribute *attr, char *buf)
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	ret = sysfs_emit(buf, "%s\n", irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
-	raw_spin_unlock_irq(&desc->lock);
 
-	return ret;
+	guard(raw_spinlock_irq)(&desc->lock);
+	return sysfs_emit(buf, "%s\n", irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
 
 }
 IRQ_ATTR_RO(type);
 
-static ssize_t wakeup_show(struct kobject *kobj,
-			   struct kobj_attribute *attr, char *buf)
+static ssize_t wakeup_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
-
-	raw_spin_lock_irq(&desc->lock);
-	ret = sysfs_emit(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
 
+	guard(raw_spinlock_irq)(&desc->lock);
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
 }
 IRQ_ATTR_RO(wakeup);
 
-static ssize_t name_show(struct kobject *kobj,
-			 struct kobj_attribute *attr, char *buf)
+static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
-	ssize_t ret = 0;
 
-	raw_spin_lock_irq(&desc->lock);
+	guard(raw_spinlock_irq)(&desc->lock);
 	if (desc->name)
-		ret = sysfs_emit(buf, "%s\n", desc->name);
-	raw_spin_unlock_irq(&desc->lock);
-
-	return ret;
+		return sysfs_emit(buf, "%s\n", desc->name);
+	return 0;
 }
 IRQ_ATTR_RO(name);
 
-static ssize_t actions_show(struct kobject *kobj,
-			    struct kobj_attribute *attr, char *buf)
+static ssize_t actions_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
 	struct irqaction *action;
 	ssize_t ret = 0;
 	char *p = "";
 
-	raw_spin_lock_irq(&desc->lock);
-	for_each_action_of_desc(desc, action) {
-		ret += sysfs_emit_at(buf, ret, "%s%s", p, action->name);
-		p = ",";
+	scoped_guard(raw_spinlock_irq, &desc->lock) {
+		for_each_action_of_desc(desc, action) {
+			ret += sysfs_emit_at(buf, ret, "%s%s", p, action->name);
+			p = ",";
+		}
 	}
-	raw_spin_unlock_irq(&desc->lock);
 
 	if (ret)
 		ret += sysfs_emit_at(buf, ret, "\n");
-
 	return ret;
 }
 IRQ_ATTR_RO(actions);
@@ -414,19 +389,14 @@ static int __init irq_sysfs_init(void)
 	int irq;
 
 	/* Prevent concurrent irq alloc/free */
-	irq_lock_sparse();
-
+	guard(mutex)(&sparse_irq_lock);
 	irq_kobj_base = kobject_create_and_add("irq", kernel_kobj);
-	if (!irq_kobj_base) {
-		irq_unlock_sparse();
+	if (!irq_kobj_base)
 		return -ENOMEM;
-	}
 
 	/* Add the already allocated interrupts */
 	for_each_irq_desc(irq, desc)
 		irq_sysfs_add(irq, desc);
-	irq_unlock_sparse();
-
 	return 0;
 }
 postcore_initcall(irq_sysfs_init);
@@ -569,12 +539,12 @@ err:
 	return -ENOMEM;
 }
 
-static int irq_expand_nr_irqs(unsigned int nr)
+static bool irq_expand_nr_irqs(unsigned int nr)
 {
 	if (nr > MAX_SPARSE_IRQS)
-		return -ENOMEM;
+		return false;
 	nr_irqs = nr;
-	return 0;
+	return true;
 }
 
 int __init early_irq_init(void)
@@ -652,11 +622,9 @@ EXPORT_SYMBOL(irq_to_desc);
 static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&desc->lock, flags);
-	desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
-	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock)
+		desc_set_defaults(irq, desc, irq_desc_get_node(desc), NULL, NULL);
 	delete_irq_desc(irq);
 }
 
@@ -675,16 +643,15 @@ static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
 	return start;
 }
 
-static int irq_expand_nr_irqs(unsigned int nr)
+static inline bool irq_expand_nr_irqs(unsigned int nr)
 {
-	return -ENOMEM;
+	return false;
 }
 
 void irq_mark_irq(unsigned int irq)
 {
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 	irq_insert_desc(irq, irq_desc + irq);
-	mutex_unlock(&sparse_irq_lock);
 }
 
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
@@ -823,11 +790,9 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 	if (from >= nr_irqs || (from + cnt) > nr_irqs)
 		return;
 
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 	for (i = 0; i < cnt; i++)
 		free_desc(from + i);
-
-	mutex_unlock(&sparse_irq_lock);
 }
 EXPORT_SYMBOL_GPL(irq_free_descs);
 
@@ -844,11 +809,10 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  *
  * Returns the first irq number or error code
  */
-int __ref
-__irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct irq_affinity_desc *affinity)
+int __ref __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
+			    struct module *owner, const struct irq_affinity_desc *affinity)
 {
-	int start, ret;
+	int start;
 
 	if (!cnt)
 		return -EINVAL;
@@ -866,22 +830,17 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		from = arch_dynirq_lower_bound(from);
 	}
 
-	mutex_lock(&sparse_irq_lock);
+	guard(mutex)(&sparse_irq_lock);
 
 	start = irq_find_free_area(from, cnt);
-	ret = -EEXIST;
 	if (irq >=0 && start != irq)
-		goto unlock;
+		return -EEXIST;
 
 	if (start + cnt > nr_irqs) {
-		ret = irq_expand_nr_irqs(start + cnt);
-		if (ret)
-			goto unlock;
+		if (!irq_expand_nr_irqs(start + cnt))
+			return -ENOMEM;
 	}
-	ret = alloc_descs(start, cnt, node, affinity, owner);
-unlock:
-	mutex_unlock(&sparse_irq_lock);
-	return ret;
+	return alloc_descs(start, cnt, node, affinity, owner);
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 

