Return-Path: <linux-tip-commits+bounces-5547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93559AB89E3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 16:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453401889496
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92991DED5B;
	Thu, 15 May 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtM4XZ8g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="35dbUjf3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6434CF9;
	Thu, 15 May 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320707; cv=none; b=NBnn6PUhJSh6Dodq4S1CJsp7l87/avfuUs0z7/4YeqnvVH69EjyM8H9kuBqyiNau/EEr8GexsFqC6NOKHtXEqLm4TT8h4vk4Zzt+FV3vWz7PLEU0uNaY7i5XncShlaDjRyR3OzrX8To3npwyKNlWJxOMy1CSmHDxnAL1U+wj+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320707; c=relaxed/simple;
	bh=46qP591hUZ1F/7waKJZm7/juT8PjsGzd0r+2kBfe5eI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jdkhrGzC+I8Pnk0etrFndujtmo80Uhhk4TDsrTo8bXRSnFCxNcE9F0Xefqx3f4Bj2xPJ8/EdLF1h21CNfqwVwK4ApTllQMa9FlX0xlaQ7qp9O6RmCrhxn0ToO5l/2Qd87ThE0i4hl+hfyFWtnLK8EE5KNx8sRa0bZ3iB+U3QCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtM4XZ8g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=35dbUjf3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 14:51:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747320703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GinOpFlC91u2NxzD9w3EoFnZRayWWyDQFgi9M/Ggz2g=;
	b=WtM4XZ8g+rFS3FX73lxQuf7rbp2JUlkytXZeZquPRF9P2PmAXdpOIswwleYhDs/WJ7ETvG
	dT0LofyNXmHx1pIP7VTaJaUvZk8cQ8APeRyrNZbjmD6eLYW4QQb8xRMwd50Cfd8KGu6NZY
	nYKoUhpjfIN+3y/1DybIhydwZHd1834vjVI+HFTDTFW678EpRzz23dq90TArdumcBOFPXD
	w0S3Uf28FNowtUNftZGHZ7oOPUnR0ECj19F1BLbX8cKzAmy2is+RntgL60YaJvTuZbzLLB
	zDL5PSjvVZ1+WKYuTQkP3XVJUstvgf1rv4txwa9rfUCNiUC7vxTbrJFrlQiI3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747320703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GinOpFlC91u2NxzD9w3EoFnZRayWWyDQFgi9M/Ggz2g=;
	b=35dbUjf3s3NhLdyNzbvQE8fqCz6pJOCs00kF7E13XOwQsgm26WeqYLzsYVEoBSIhuoB9vg
	aH/+OVaLsYbgOzAQ==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Retain disable depth for managed interrupts
 across CPU hotplug
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Brian Norris <briannorris@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250514201353.3481400-2-briannorris@chromium.org>
References: <20250514201353.3481400-2-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732070271.406.3712146055779909597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     788019eb559fd0b365f501467ceafce540e377cc
Gitweb:        https://git.kernel.org/tip/788019eb559fd0b365f501467ceafce540e377cc
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Wed, 14 May 2025 13:13:16 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 May 2025 16:44:25 +02:00

genirq: Retain disable depth for managed interrupts across CPU hotplug

Affinity-managed interrupts can be shut down and restarted during CPU
hotunplug/plug. Thereby the interrupt may be left in an unexpected state.
Specifically:

 1. Interrupt is affine to CPU N
 2. disable_irq() -> depth is 1
 3. CPU N goes offline
 4. irq_shutdown() -> depth is set to 1 (again)
 5. CPU N goes online
 6. irq_startup() -> depth is set to 0 (BUG! driver expects that the interrupt
    		     	      	        still disabled)
 7. enable_irq() -> depth underflow / unbalanced enable_irq() warning

This is only a problem for managed interrupts and CPU hotplug, all other
cases like request()/free()/request() truly needs to reset a possibly stale
disable depth value.

Provide a startup function, which takes the disable depth into account, and
invoked it for the managed interrupts in the CPU hotplug path.

This requires to change irq_shutdown() to do a depth increment instead of
setting it to 1, which allows to retain the disable depth, but is harmless
for the other code paths using irq_startup(), which will still reset the
disable depth unconditionally to keep the original correct behaviour.

A kunit tests will be added separately to cover some of these aspects.

[ tglx: Massaged changelog ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250514201353.3481400-2-briannorris@chromium.org
---
 kernel/irq/chip.c       | 22 +++++++++++++++++++++-
 kernel/irq/cpuhotplug.c |  2 +-
 kernel/irq/internals.h  |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 1d45c84..b0e0a73 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -202,6 +202,19 @@ __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 		return IRQ_STARTUP_ABORT;
 	return IRQ_STARTUP_MANAGED;
 }
+
+void irq_startup_managed(struct irq_desc *desc)
+{
+	/*
+	 * Only start it up when the disable depth is 1, so that a disable,
+	 * hotunplug, hotplug sequence does not end up enabling it during
+	 * hotplug unconditionally.
+	 */
+	desc->depth--;
+	if (!desc->depth)
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+}
+
 #else
 static __always_inline int
 __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
@@ -269,6 +282,7 @@ int irq_startup(struct irq_desc *desc, bool resend, bool force)
 			ret = __irq_startup(desc);
 			break;
 		case IRQ_STARTUP_ABORT:
+			desc->depth = 1;
 			irqd_set_managed_shutdown(d);
 			return 0;
 		}
@@ -301,7 +315,13 @@ void irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
 		clear_irq_resend(desc);
-		desc->depth = 1;
+		/*
+		 * Increment disable depth, so that a managed shutdown on
+		 * CPU hotunplug preserves the actual disabled state when the
+		 * CPU comes back online. See irq_startup_managed().
+		 */
+		desc->depth++;
+
 		if (desc->irq_data.chip->irq_shutdown) {
 			desc->irq_data.chip->irq_shutdown(&desc->irq_data);
 			irq_state_set_disabled(desc);
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index e77ca6d..f07529a 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -218,7 +218,7 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 		return;
 
 	if (irqd_is_managed_and_shutdown(data))
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+		irq_startup_managed(desc);
 
 	/*
 	 * If the interrupt can only be directed to a single target
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 476a20f..aebfe22 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -87,6 +87,7 @@ extern void __enable_irq(struct irq_desc *desc);
 extern int irq_activate(struct irq_desc *desc);
 extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
+extern void irq_startup_managed(struct irq_desc *desc);
 
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);

