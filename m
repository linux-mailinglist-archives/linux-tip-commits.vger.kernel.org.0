Return-Path: <linux-tip-commits+bounces-5839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE3AD8CF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E619D17401D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81082E555;
	Fri, 13 Jun 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wAeCRBLA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbTGNsdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094E275B16;
	Fri, 13 Jun 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820552; cv=none; b=WIe924k3U9M8qtuAMsRX1jTI98pgR6xRFmI3aD4YssmuNnu+nYrfNCl6BXjR3242WJJNuAWXfZrLDqLzau41PiVf9Zho0r53MZhRdF3/RLojpxO3MefTyudwadZeSd2pqhyJC/TSDUEO9wyXHpavDvMN/KuX9swl/iT5BoYOn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820552; c=relaxed/simple;
	bh=JmkT4xBJmwfzj3Z6UrKXTQcxKeDOw+MIsJe38RfHC2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cp97B9+ts63QGeRgCStr4XWHIBKg2cW82qgffh9Hy6Thzy2lx0l0zchKKkJDDauLlGoQdREW+QDW750/CWJBgwqtrNt168VUZoOFlymGkA9ytuo6Coa5ZVEUi1wPqatTh/3aBGIfVcKitu3bBnJUpcabuqroI9m0ra5ElKZz7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wAeCRBLA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WbTGNsdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 13:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749820549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24z977dzB33rivAEdGO7Uhy6z7X+GMNhhSv7BafVmEE=;
	b=wAeCRBLAbXUvB45FNzSD8RVvvAqUrKIQmyigeL7MYnPa+ji7YFJAVSDfECcMBtaDT73TSH
	/+UlpaCauutK9a2THml3me5co6Rl/1o7KLloS6y8b2VczUiqfwxC7c/134ZFkSSJI73WQW
	Flon40AjV2H31eQTkhHLNF0kcjVVJbOuqZo/kE/cWQFu+k82wZJCjuW9ssFAuoL4F7e4qa
	MJxAUGI4wvjXA5XYf7h32ixjM2BCLfn+9QS7HzsEnYs0KPKzDqENf5kDkLHXn26ZrpdJf5
	PtSueOuJAh1be7ps2ON3KM4JB6RC9tMR2TWnJGutN2CDV0MFLCyK1YoNCttprg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749820549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24z977dzB33rivAEdGO7Uhy6z7X+GMNhhSv7BafVmEE=;
	b=WbTGNsdAdJn/p++NQmjoKwHeanJodZ12tpnXtwdusAdsbwQ8i12lwaGfGlOlXrUL97NFEp
	b+QmQAKvxqhcoiAQ==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] genirq/cpuhotplug: Restore affinity even for suspended IRQ
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250612183303.3433234-3-briannorris@chromium.org>
References: <20250612183303.3433234-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174982054803.406.16499151161208578856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     72218d74c9c57b8ea36c2a58875dff406fc10462
Gitweb:        https://git.kernel.org/tip/72218d74c9c57b8ea36c2a58875dff406fc10462
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Thu, 12 Jun 2025 11:32:52 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 15:13:35 +02:00

genirq/cpuhotplug: Restore affinity even for suspended IRQ

Commit 788019eb559f ("genirq: Retain disable depth for managed interrupts
across CPU hotplug") tried to make managed shutdown/startup properly
reference counted, but it missed the fact that the unplug and hotplug code
has an intentional imbalance by skipping IRQS_SUSPENDED interrupts on
the "restore" path.

This means that if a managed-affinity interrupt was both suspended and
managed-shutdown (such as may happen during system suspend / S3), resume
skips calling irq_startup_managed(), and would again have an unbalanced
depth this time, with a positive value (i.e., remaining unexpectedly
masked).

This IRQS_SUSPENDED check was introduced in commit a60dd06af674
("genirq/cpuhotplug: Skip suspended interrupts when restoring affinity")
for essentially the same reason as commit 788019eb559f, to prevent that
irq_startup() would unconditionally re-enable an interrupt too early.

Because irq_startup_managed() now respsects the disable-depth count, the
IRQS_SUSPENDED check is not longer needed, and instead, it causes harm.

Thus, drop the IRQS_SUSPENDED check, and restore balance.

This effectively reverts commit a60dd06af674 ("genirq/cpuhotplug: Skip
suspended interrupts when restoring affinity"), because it is replaced
by commit 788019eb559f ("genirq: Retain disable depth for managed
interrupts across CPU hotplug").

Fixes: 788019eb559f ("genirq: Retain disable depth for managed interrupts across CPU hotplug")
Reported-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Link: https://lore.kernel.org/all/20250612183303.3433234-3-briannorris@chromium.org
Closes: https://lore.kernel.org/lkml/24ec4adc-7c80-49e9-93ee-19908a97ab84@gmail.com/
---
 kernel/irq/cpuhotplug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index f07529a..755346e 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -210,13 +210,6 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
 
-	/*
-	 * Don't restore suspended interrupts here when a system comes back
-	 * from S3. They are reenabled via resume_device_irqs().
-	 */
-	if (desc->istate & IRQS_SUSPENDED)
-		return;
-
 	if (irqd_is_managed_and_shutdown(data))
 		irq_startup_managed(desc);
 

