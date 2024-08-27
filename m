Return-Path: <linux-tip-commits+bounces-2132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34E96097A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CF31C20D29
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB31A08C6;
	Tue, 27 Aug 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oa/I9+Mx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3idW99Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E71A01C4;
	Tue, 27 Aug 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760158; cv=none; b=Zu4eMDKGjeYFK4Iwf6Y2aAUPcD4LIfMCoMHcPusRuLaHhyfwHlrOZXt7mVE2qDM6Pb1T7SJxk7Ji+7FrqKhlNYloJA9cC4hr2YTo3FyaAxio54IP9nB161xG7e1jgpRXrJMKiXgOzUToYCdGBHpIQy6biNK2GXEFEfCQ9zuSafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760158; c=relaxed/simple;
	bh=4I98SlbNG6iN9Y5851enoMRbrc8v7J1YBlToWju6b+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZBwVlARIykODgMLzBMXtrX9yESKtgouzqVxdp/+Ixax9rfZ1EPsaF7keu+FIqxA/P9BI1dqRReF9xWvy9vxspAufHsfRnD7k7o0xpHeDewSIkh1chNHRFGO8R7vGER3EMmWCw10qZOtfSarITjACnuv8aPRPpZNx4b3icHTm6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oa/I9+Mx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3idW99Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 12:02:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724760155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nciwL1u0rp8c+nVNiZ8C9oNrnummWZpwLgNIL7epbNk=;
	b=oa/I9+Mx81UiIIiAi6bbvvRfuNsSuu3cfo3ETkFAWhVIz9LBj8kXTGO3IHg83Cw4EcsVQK
	xROcFXGegAIeEBIfmMqH6gB7307wQLig2pqzGaQNYugQaZnEgZiTSj2maxljc6R9Kz9kuf
	KasnhF16i/akZ31xkZ5YDA/nGfZvOwRQFIFiTCMeNq4j0dCnUcV9qRoJtTWEk9UVV2h0ep
	OKKiOslPK4ajHYHT8OMxMb6RzLxlvp3OwuxGjtT5aUSrHov30EKbZmTHRwWSq0WZ0QVdv2
	TBLB5XOsg+iH5lAhXD/c58H1da5GVLu/ZkdDNlv2+TmTfpojraSaoof9RcgsIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724760155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nciwL1u0rp8c+nVNiZ8C9oNrnummWZpwLgNIL7epbNk=;
	b=U3idW99Qz3d2Ka3HxzfxTFPKx8Tl76NHVj55ZqmzFHUVQg4IbbLKqs0ghhOY9djfz27zZB
	etjAfgZt7fN5DiAQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq: Get rid of global lock in irq_do_set_affinity()
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240826080618.3886694-1-maz@kernel.org>
References: <20240826080618.3886694-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172476015469.2215.1516167821717273436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     64b6d1d7a84538de34c22a6fc92a7dcc2b196b64
Gitweb:        https://git.kernel.org/tip/64b6d1d7a84538de34c22a6fc92a7dcc2b196b64
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 26 Aug 2024 09:06:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Aug 2024 13:54:15 +02:00

genirq: Get rid of global lock in irq_do_set_affinity()

Kunkun Jiang reports that for a workload involving the simultaneous startup
of a large number of VMs (for a total of about 200 vcpus), a lot of CPU
time gets spent on spinning on the tmp_mask_lock that exists as a static
raw spinlock in irq_do_set_affinity(). This lock protects a global cpumask
(tmp_mask) that is used as a temporary variable to compute the resulting
affinity.

While this is triggered by KVM issuing a irq_set_affinity() call each time
a vcpu is about to execute, it is obvious that having a single global
resource is not very scalable.

Since a cpumask can be a fairly large structure on systems with a high core
count, a stack allocation is not really appropriate.  Instead, turn the
global cpumask into a per-CPU variable, removing the need for locking
altogether as the code is executed with preemption and interrupts disabled.

[ tglx: Moved the per CPU variable declaration outside of the function ]

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kunkun Jiang <jiangkunkun@huawei.com>
Link: https://lore.kernel.org/all/20240826080618.3886694-1-maz@kernel.org
Link: https://lore.kernel.org/all/a7fc58e4-64c2-77fc-c1dc-f5eb78dbbb01@huawei.com
---
 kernel/irq/manage.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dd53298..f0803d6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -218,21 +218,20 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
 #endif
 
+static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
+
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
+	struct cpumask *tmp_mask = this_cpu_ptr(&__tmp_mask);
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	const struct cpumask  *prog_mask;
 	int ret;
 
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
-
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	raw_spin_lock(&tmp_mask_lock);
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -258,11 +257,11 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 
-		cpumask_and(&tmp_mask, mask, hk_mask);
-		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
+		cpumask_and(tmp_mask, mask, hk_mask);
+		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			prog_mask = mask;
 		else
-			prog_mask = &tmp_mask;
+			prog_mask = tmp_mask;
 	} else {
 		prog_mask = mask;
 	}
@@ -272,16 +271,14 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * unless we are being asked to force the affinity (in which
 	 * case we do as we are told).
 	 */
-	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!force && !cpumask_empty(&tmp_mask))
-		ret = chip->irq_set_affinity(data, &tmp_mask, force);
+	cpumask_and(tmp_mask, prog_mask, cpu_online_mask);
+	if (!force && !cpumask_empty(tmp_mask))
+		ret = chip->irq_set_affinity(data, tmp_mask, force);
 	else if (force)
 		ret = chip->irq_set_affinity(data, mask, force);
 	else
 		ret = -EINVAL;
 
-	raw_spin_unlock(&tmp_mask_lock);
-
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:

