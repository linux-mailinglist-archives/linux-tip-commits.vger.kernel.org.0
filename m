Return-Path: <linux-tip-commits+bounces-1827-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB89410C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790B0286449
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB419FA92;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzTVcUSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5c55aElI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D219EEAB;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=O5dhjY7KIhk3ZO+SlDZywvqPkN/oXIazNsHSic4I3BZsU+aBQsXWNiFp0G3qNvPpzlpcfTr6KLRWS3uezlbyZGtq3HTfRK7mOor5WxpbdLM5kqAeGihOikGqFFJSBzVDTqpc1DMY/o7hr26c1vAsi32yN6srql6g0qiVBSonF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=q7VfIJ6OAfC8U8CtvglZNvT4aWxZfquLbxdfvmzPn/8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TzlZZaVXsW/mw65KF6Lz5oZNYkBkv+WCXwKMD1CxW0/xnoMFzCQY7adrVSTe/Ow2G3uS8n92k4pWDETBbSj7Wu22nYypvbpJJbYCzai7wx7IHkaPzP6iUoTaP6oNRhS7/7Qh04EDKEJRj5UX1XlpgoHpEgerYTpIoeUNoeQEGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzTVcUSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5c55aElI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYCw6+RviHVzdV9wQp3HQ7/41JnoSq3Iqh/BBtv6JI0=;
	b=GzTVcUSnMg2CHtKnAj+E5CfKZJgb3MnNSYJ3YlPYWtfTeH++hLytb8zHJxC+z6lIXbYzrt
	X5vfwOHXmDeF7hHjVCjY03Ab+B+Z4B2KI8+9gPKrqVBNT6t+hATieHxSNyNfJTUkpnKVjj
	SOJc3oE00h/x766RMfU4NAEIkVzufAWHDuyf3ryZnx4iwOgzw187Gezp/w+k7kaGGknEOH
	qODcYgsgBSrtelLNWxfIsJ21stM3YFuayWufu6MntaQs0A0P1YhPiAAAtEZ/VBs9EKTAcd
	qXzr4XszUZH7HBSKWmIXp+xR2lh60omVPiTHqzdLHOaKpq4xcIRFrELGQ8NKQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYCw6+RviHVzdV9wQp3HQ7/41JnoSq3Iqh/BBtv6JI0=;
	b=5c55aElIB825fkRJpQdRXqVfPoc9VN4y+qhrH69mzIGbUoobQHSmsZoV2Dm9M4XOjQ5+v+
	8zeAzKwsshdBaEAQ==
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
Message-ID: <172233959905.2215.1554871277589731206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0d4b1fcd378ea61ff76bedf0d484eac69c028c57
Gitweb:        https://git.kernel.org/tip/0d4b1fcd378ea61ff76bedf0d484eac69c0=
28c57
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Use consistent name for struct irq_data variables

Always use variable name "d" for struct irq_data *, for consistency.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-4-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index db9594b..98f90a3 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -239,16 +239,16 @@ static struct msi_domain_info mpic_msi_domain_info =3D {
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
-static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpu=
mask *mask, bool force)
+static int mpic_msi_set_affinity(struct irq_data *d, const struct cpumask *m=
ask, bool force)
 {
 	unsigned int cpu;
=20
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

