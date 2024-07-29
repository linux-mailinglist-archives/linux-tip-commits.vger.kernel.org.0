Return-Path: <linux-tip-commits+bounces-1758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFA93F19C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188FBB23018
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781C9144306;
	Mon, 29 Jul 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ETRNnmKe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcOBVEHj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B3143723;
	Mon, 29 Jul 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246587; cv=none; b=QLkJDVGAC9yNpxgSOMZGK+rmjKE0EZ4GX6wZJDuovdlEI6YCNfApp9r/eG6lnj2HC8CfKAuHg3afZS3HDbUnYOTb+eGULvUBiAEKG+9oKdtF0O1LIrOz8BrppF9mKI6EAfzDS5++yc57mbE+eDPyub5So2RZTQODBs4LZHLsM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246587; c=relaxed/simple;
	bh=iQUG/iZMTLcmsjC0wDM+SIY1Rdpo2n1UBqhFSpCi2RE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BzXK/GTWHQkTRb3i+qT/6Ror8pkMiAA67inpTupilAXkh9sOIgPLAGRa6yXjfxPM9Io9gqq4jn0F6KHz2VSdbZCQv4x/97D/vTeCyhkfTUePex9DZ7FYRXKAxTZJB7nZfTHKZHDkWSyzUe3Q2mMD8xfs2/bvjNIkvwvgs6wnzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ETRNnmKe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcOBVEHj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0f9M/IJdRd5ylaDmrdKx3jGv+uiKEmMecbCegdqbz8=;
	b=ETRNnmKeDDZz1IX1SxZ2reOxi2fAbyaXoFd0mrRlB61/w05PyQ0uLjSqldWa6bbG508Lqj
	YJHz/OZC9J5rn9bPDzlM75DSgL6wIrpvh0A8AgkOpokf0SevZoyoAzbrN0fSeyJN70Cbqs
	lgSvmp5J3Nl8k12Jje/cT/x0N/0Ocwpg0NUEsXX+WjSejENos8DQxZplVr7OXfaFwBQ7qe
	B5qZ7+dU0xqBTrcESy1Ic7N71nzXYlaADx3xK0ypa2EM7udXb1ei7nA6Ife26qFNTUq1me
	qwvGA/yfYLvB7FWYaFOs9yeqk7qAZqK/q7jdljwOuQUOXgeq6B9tHLn3nJadNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0f9M/IJdRd5ylaDmrdKx3jGv+uiKEmMecbCegdqbz8=;
	b=FcOBVEHj74/5TPmNEpbqADCXBSJFVA3daSzFFPYn+heCHsmMu6V2Vp1yWTwwmaZhaG8O6C
	rmTA0hTU9FFr6nDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use consistent name for struct
 irq_data variables
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-4-kabel@kernel.org>
References: <20240711160907.31012-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658230.2215.2389013389136353122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f72976cd7f0e16639f29398d5fe5ab1b03789b42
Gitweb:        https://git.kernel.org/tip/f72976cd7f0e16639f29398d5fe5ab1b037=
89b42
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

irqchip/armada-370-xp: Use consistent name for struct irq_data variables

Always use variable name "d" for struct irq_data *, for consistency.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-4-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index db9594b..bab9297 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -239,13 +239,13 @@ static struct msi_domain_info mpic_msi_domain_info =3D {
 	.chip	=3D &mpic_msi_irq_chip,
 };
=20
-static void mpic_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+static void mpic_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(dat=
a));
+	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
=20
 	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
-	msg->data =3D BIT(cpu + 8) | (data->hwirq + msi_doorbell_start());
+	msg->data =3D BIT(cpu + 8) | (d->hwirq + msi_doorbell_start());
 }
=20
 static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpu=
mask *mask, bool force)
@@ -260,7 +260,7 @@ static int mpic_msi_set_affinity(struct irq_data *irq_dat=
a, const struct cpumask
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
 	return IRQ_SET_MASK_OK;
 }
@@ -517,19 +517,19 @@ static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
-		struct irq_data *data;
+		struct irq_data *d;
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20
-		data =3D irq_get_irq_data(virq);
+		d =3D irq_get_irq_data(virq);
=20
 		if (!irq_percpu_is_enabled(virq))
 			continue;
=20
-		mpic_irq_unmask(data);
+		mpic_irq_unmask(d);
 	}
=20
 	if (mpic_is_ipi_available())
@@ -706,20 +706,20 @@ static void mpic_resume(void)
=20
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++) {
-		struct irq_data *data;
+		struct irq_data *d;
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20
-		data =3D irq_get_irq_data(virq);
+		d =3D irq_get_irq_data(virq);
=20
 		if (!mpic_is_percpu_irq(i)) {
 			/* Non per-CPU interrupts */
 			writel(i, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
-			if (!irqd_irq_disabled(data))
-				mpic_irq_unmask(data);
+			if (!irqd_irq_disabled(d))
+				mpic_irq_unmask(d);
 		} else {
 			/* Per-CPU interrupts */
 			writel(i, main_int_base + MPIC_INT_SET_ENABLE);
@@ -729,7 +729,7 @@ static void mpic_resume(void)
 			 * will take care of secondary CPUs when they come up.
 			 */
 			if (irq_percpu_is_enabled(virq))
-				mpic_irq_unmask(data);
+				mpic_irq_unmask(d);
 		}
 	}
=20

