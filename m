Return-Path: <linux-tip-commits+bounces-2121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6D95F100
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC9B229BE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Aug 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7299189B9B;
	Mon, 26 Aug 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hB9o6d4N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSHb/iNn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FB189515;
	Mon, 26 Aug 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674200; cv=none; b=gNDZ47ZGy6Ag3BHHPAe1JHuU1c8RWK0PnjJRKMWIAeDgXpGA/Gs0OKZYgAp9VTc4ufpQdfkVyOJMyZ1EuBZVt9KwTZlzBFX2X+v8HkiwHPJlt98wOMKQu7qpfNHP98yWPZ+TkguuzvFjgHP4vvLsBa1SXMku6oIWRGKIN5gFJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674200; c=relaxed/simple;
	bh=uJwN0fxg1N1IkI6Yhq5fmrk/zkE6cZP1VOTxvkJrg1o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gEq+YUPeVasmFqdRRV1IUGFD49QCb+87NSVQzxuAFOUdSRQj5NAIrKauaiCPwAxkIZ6F7wFJ7/VYC3lw20fO9u+6Y3A3tQ4D46bdeX44rZ8OeEQxDOrPOdC9ToR0cje68Yh2dr2AsvF/ct29PqKlH3Ms5KRkZJAudqVzcR5fX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hB9o6d4N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSHb/iNn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 12:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724674197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMstrOJVoWDIQbKV+Oeld0jHFTvF+gmpAx0n7F8s8+E=;
	b=hB9o6d4NGL5lbu5Lj/ogqYXXRkZyanCAKfNx5icOVdBIuFKjmzHYbm56HCBjTMYOZKBrrQ
	HYwPGdexUWc9HCOe05cDwXcchgk6aBsS8KZc3wYKsJK+KARhSwWpkOtvps6EmQftDt9MHv
	lv3icMvjhx0/Ld29XkXl7FK41KsYvyUF7qDh9AJSdqJsdgwMyy3oHY7xekxVtwG1TZD1Fo
	HnX22v2wLK6hugxg0IZSYRKKKUJd2ZwaPRTJGpKSZxW01TzrrAS1ryA/T/AAoAdTwumT/A
	g2dlTiLVrWy7O3wqIcKyPFFQ1bBEdkcmmFk/7NwSLN8WCdhX0uMz8Z4jKgZjpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724674197;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMstrOJVoWDIQbKV+Oeld0jHFTvF+gmpAx0n7F8s8+E=;
	b=PSHb/iNn/wxdA8RN1+pa2ytlC3h3061dsspJMJpXX1lPoqresVM5VhesC/yBYPyaHGjTCE
	PRhXU8Y+fUowphDA==
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
Message-ID: <172467419687.2215.7707880284542876223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6c70d79f363c0c9a712e107b9c4d3644ca8c7490
Gitweb:        https://git.kernel.org/tip/6c70d79f363c0c9a712e107b9c4d3644ca8c7490
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 26 Aug 2024 09:06:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Aug 2024 12:52:35 +02:00

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

Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kunkun Jiang <jiangkunkun@huawei.com>
Link: https://lore.kernel.org/all/20240826080618.3886694-1-maz@kernel.org
Link: https://lore.kernel.org/all/a7fc58e4-64c2-77fc-c1dc-f5eb78dbbb01@huawei.com
---
 kernel/irq/manage.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dd53298..b6aa259 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -224,15 +224,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	const struct cpumask  *prog_mask;
+	struct cpumask *tmp_mask;
 	int ret;
 
-	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
-	static struct cpumask tmp_mask;
+	static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
 
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	raw_spin_lock(&tmp_mask_lock);
+	tmp_mask = this_cpu_ptr(&__tmp_mask);
+
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -258,11 +259,11 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 
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
@@ -272,16 +273,14 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
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

