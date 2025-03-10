Return-Path: <linux-tip-commits+bounces-4101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD0A58EFF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4B1884476
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CB6224B0D;
	Mon, 10 Mar 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YU940qof";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CA/f4cxg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059412248BE;
	Mon, 10 Mar 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597573; cv=none; b=o5+gfaLT+7sUmWTYE9U4gAmXJMxbSRTCstwIxK66l3YyBR4RrgGhja1mFb8sVmj7ukwhEOkRM1BdIWt5c3vI/zcAommFzHMDajFuWJm02/ELI3EHKpH77YgNEX2alPB84L5ut1Tu+O2JlBDcwUWNGAfmUsAT18Ra37oxHtanXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597573; c=relaxed/simple;
	bh=UI7ErRhpEadCdOBjNdBSlvGGGYCRP1U256mQOFMKUv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pmoT0QLrZ3nfj0w0R2ZBTFaISnz6XSzUvEie/Vd8Ff+Ohmy2ODBP7GzZJQehOI47k4eaf0Pk85F/+nd7ax575xGhOZn3zwI+GElFjLhN0ZT2qgMXTQbdlGiiwPbE2EaiTAb64FPiXmCCoC2c4BR9c5ytXvW2RcXkzvWjMzvsycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YU940qof; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CA/f4cxg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 09:06:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741597569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o87HqDsyM3aadgsjrSuiG4DHCPd+lW3gxR4311/QBck=;
	b=YU940qof3lgGuEdmFljulp7IxwqMl9mpaLgxKStyCvBM4r/EmfAkfLW3XsTGQU+KdorIGp
	TXAWZQyPBOURgV6UfiwIJ946nxPSbizFZ5jPPyZWpsDt25f8LeDUQSPwZZRR2dQyY/aAh2
	HOH5G1KydhmuAagflMPYfkMScVoIjbclW2m13lxYTcDF7W85m0O4pBE+M5YrpHLYb0DO41
	PsYa56BoYwGilklyFEF481DdLGQkej1Qnl/c8fsVex9kRqB+N5mWYu0MrHnltmF/DMnZc8
	+zJ3Qr3TaH15amwdJYDgzM5vwlDnDm0312B/9uj4EMiNyRiDnR+CH7JaV1rK9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741597569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o87HqDsyM3aadgsjrSuiG4DHCPd+lW3gxR4311/QBck=;
	b=CA/f4cxguoU+O2B2U5ecIx3vAlNbXhpEr4uilNeKULtJSEcuADhtKzFBMBEvQXxa3aGkk/
	T8xsK4HQ2Y52xMDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Make a few functions static
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <878qpe2gnx.ffs@tglx>
References: <878qpe2gnx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174159756789.14745.16482426960561138877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     827bafd527dde5a6e81421e88fb2144adac1f36c
Gitweb:        https://git.kernel.org/tip/827bafd527dde5a6e81421e88fb2144adac1f36c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 09 Mar 2025 19:38:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Mar 2025 10:01:20 +01:00

genirq: Make a few functions static

None of these functions are used outside of their source files.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/878qpe2gnx.ffs@tglx

---
 include/linux/irqdomain.h |  3 ---
 kernel/irq/chip.c         | 30 +++++++++++++++---------------
 kernel/irq/internals.h    |  9 ---------
 kernel/irq/irqdesc.c      |  2 +-
 kernel/irq/irqdomain.c    |  5 ++---
 kernel/irq/manage.c       |  7 ++++---
 6 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5c0ec33..33ff41e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -630,9 +630,6 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 				       NULL);
 }
 
-int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-				    unsigned int irq_base,
-				    unsigned int nr_irqs, void *arg);
 int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 				  unsigned int virq,
 				  irq_hw_number_t hwirq,
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c901436..0ff987d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -232,6 +232,21 @@ __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 }
 #endif
 
+static void irq_enable(struct irq_desc *desc)
+{
+	if (!irqd_irq_disabled(&desc->irq_data)) {
+		unmask_irq(desc);
+	} else {
+		irq_state_clr_disabled(desc);
+		if (desc->irq_data.chip->irq_enable) {
+			desc->irq_data.chip->irq_enable(&desc->irq_data);
+			irq_state_clr_masked(desc);
+		} else {
+			unmask_irq(desc);
+		}
+	}
+}
+
 static int __irq_startup(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
@@ -332,21 +347,6 @@ void irq_shutdown_and_deactivate(struct irq_desc *desc)
 	irq_domain_deactivate_irq(&desc->irq_data);
 }
 
-void irq_enable(struct irq_desc *desc)
-{
-	if (!irqd_irq_disabled(&desc->irq_data)) {
-		unmask_irq(desc);
-	} else {
-		irq_state_clr_disabled(desc);
-		if (desc->irq_data.chip->irq_enable) {
-			desc->irq_data.chip->irq_enable(&desc->irq_data);
-			irq_state_clr_masked(desc);
-		} else {
-			unmask_irq(desc);
-		}
-	}
-}
-
 static void __irq_disable(struct irq_desc *desc, bool mask)
 {
 	if (irqd_irq_disabled(&desc->irq_data)) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index a979523..556b713 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -90,7 +90,6 @@ extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
-extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
@@ -98,18 +97,12 @@ extern void mask_irq(struct irq_desc *desc);
 extern void unmask_irq(struct irq_desc *desc);
 extern void unmask_threaded_irq(struct irq_desc *desc);
 
-extern unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask);
-
 #ifdef CONFIG_SPARSE_IRQ
 static inline void irq_mark_irq(unsigned int irq) { }
 #else
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
-extern int __irq_get_irqchip_state(struct irq_data *data,
-				   enum irqchip_irq_state which,
-				   bool *state);
-
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event_percpu(struct irq_desc *desc);
 irqreturn_t handle_irq_event(struct irq_desc *desc);
@@ -139,8 +132,6 @@ static inline void unregister_handler_proc(unsigned int irq,
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
 
-extern void irq_set_thread_affinity(struct irq_desc *desc);
-
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2878307..4258cd6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -991,7 +991,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
-unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
+static unsigned int kstat_irqs_desc(struct irq_desc *desc, const struct cpumask *cpumask)
 {
 	unsigned int sum = 0;
 	int cpu;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ec6d8e7..2861f89 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1589,9 +1589,8 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 	}
 }
 
-int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-				    unsigned int irq_base,
-				    unsigned int nr_irqs, void *arg)
+static int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain, unsigned int irq_base,
+					   unsigned int nr_irqs, void *arg)
 {
 	if (!domain->ops->alloc) {
 		pr_debug("domain->ops->alloc() is NULL\n");
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f300bb6..753eef8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,8 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
+static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_state which, bool *state);
+
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
 	struct irq_data *irqd = irq_desc_get_irq_data(desc);
@@ -187,7 +189,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
  *	set_cpus_allowed_ptr() here as we hold desc->lock and this
  *	code can be called from hard interrupt context.
  */
-void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
@@ -2789,8 +2791,7 @@ out:
 	irq_put_desc_unlock(desc, flags);
 }
 
-int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
-			    bool *state)
+static int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which, bool *state)
 {
 	struct irq_chip *chip;
 	int err = -EINVAL;

