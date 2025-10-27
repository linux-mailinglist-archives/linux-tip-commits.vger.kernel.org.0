Return-Path: <linux-tip-commits+bounces-7017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F2C0F554
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9B4F680B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4631A7E6;
	Mon, 27 Oct 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZ2iE57s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1D1Ozhy+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3B31987B;
	Mon, 27 Oct 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582676; cv=none; b=ixfZtoRV1rYHEkMDwnQxugLnVs+/rY40Vt1gqoIZfL2XQeIMZZinPKGkGEsBVHd5t9PVGL566DNYnstZlZm/OsBsFjuUuCnH304ObAyfHYebBwy3l922g2TuANZUOGSM1VQn3wNnYzk6zAep19wEqRqSpnfUfnVP5Q/7j5pE9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582676; c=relaxed/simple;
	bh=t61nkLyHAfjJIZVsCK1LYBzDSlWsNQ5ZFnIuePSueSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aWY61i3bUSJ2FJgV2ml3yKSCziXYCafkLYej4qBd1nVuOrccOLHTStx2fxykDYrbEkxsjGi/9t9AGTnB9IuSWPTnaQ8uy9XCZxwx7ZRdTa+ENqHrYht1OVtndhffksij3OnXhD8o61d9LIlk+RCkP+8Jr9tPRxIxCrpqX2nveQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZ2iE57s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1D1Ozhy+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5oulnGCiVLRi+Y753m/Tb8ewkFH+DKW0bX+Cit6feXE=;
	b=dZ2iE57s9rAmjYN0ZORwnRkYw9XdVXqmKbbAA6X8KTF4y7SzSd9YuahSZSjcLn5hV6452Y
	na67bcyLclSlPrW+tInxtsq+ADxjp78QzmkNkmDpMiFcKhUUdBaB3gly9yZ4CCZzaOcYrj
	xB+/GxjsNRvngnxj5l1xDQ5YMbLHYP83NIjeTG+eZ3c54Ut2LFxxKT8bSIhzMz6GWIxS2Q
	FYWLtB61Mhhu01H5Zl+VZD62CYgdIlSen5WmRhFZmyWG84cYkZWLpGR05pCOKwSab79vUI
	Gzu2D+oHgN/MeCavC7k5gRYLrmJaabHBtQwQXIKtg6s4Ha0kVR35Z9IDx/RVxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5oulnGCiVLRi+Y753m/Tb8ewkFH+DKW0bX+Cit6feXE=;
	b=1D1Ozhy+bl/Zs9YnXXVs9MFmE3yxOO84ALnJwBVIpNJhpWij7GKpmubmXyxQwALrD0Oqk7
	whwTXMmjycU50MBA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Switch high priority PPIs over to
 handle_percpu_devid_irq()
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-11-maz@kernel.org>
References: <20251020122944.3074811-11-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267154.2601451.17024825684483443214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     21bbbc50f398f5d58a14669ee18b10a2bd30e916
Gitweb:        https://git.kernel.org/tip/21bbbc50f398f5d58a14669ee18b10a2bd3=
0e916
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:34 +01:00

irqchip/gic-v3: Switch high priority PPIs over to handle_percpu_devid_irq()

It so appears that handle_percpu_devid_irq() is extremely similar to
handle_percpu_devid_fasteoi_nmi(), and that the differences do no justify
the horrid machinery in the GICv3 driver to handle the flow handler switch.

Stick with the standard flow handler, even for NMIs.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-11-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 54 +----------------------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cf0ba83..dd2d6d7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -230,9 +230,6 @@ static void __init gic_prio_init(void)
 		!cpus_have_group0);
 }
=20
-/* rdist_nmi_refs[n] =3D=3D number of cpus having the rdist interrupt n set =
as NMI */
-static refcount_t *rdist_nmi_refs;
-
 static struct gic_kvm_info gic_v3_kvm_info __initdata;
 static DEFINE_PER_CPU(bool, has_rss);
=20
@@ -608,24 +605,6 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 	}
 }
=20
-static u32 __gic_get_rdist_index(irq_hw_number_t hwirq)
-{
-	switch (__get_intid_range(hwirq)) {
-	case SGI_RANGE:
-	case PPI_RANGE:
-		return hwirq;
-	case EPPI_RANGE:
-		return hwirq - EPPI_BASE_INTID + 32;
-	default:
-		unreachable();
-	}
-}
-
-static u32 gic_get_rdist_index(struct irq_data *d)
-{
-	return __gic_get_rdist_index(d->hwirq);
-}
-
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc =3D irq_to_desc(d->irq);
@@ -646,20 +625,8 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
=20
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx =3D gic_get_rdist_index(d);
-
-		/*
-		 * Setting up a percpu interrupt as NMI, only switch handler
-		 * for first NMI
-		 */
-		if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
-			refcount_set(&rdist_nmi_refs[idx], 1);
-			desc->handle_irq =3D handle_percpu_devid_fasteoi_nmi;
-		}
-	} else {
+	if (!gic_irq_in_rdist(d))
 		desc->handle_irq =3D handle_fasteoi_nmi;
-	}
=20
 	gic_irq_set_prio(d, dist_prio_nmi);
=20
@@ -686,15 +653,8 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
=20
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx =3D gic_get_rdist_index(d);
-
-		/* Tearing down NMI, only switch handler for last NMI */
-		if (refcount_dec_and_test(&rdist_nmi_refs[idx]))
-			desc->handle_irq =3D handle_percpu_devid_irq;
-	} else {
+	if (!gic_irq_in_rdist(d))
 		desc->handle_irq =3D handle_fasteoi_irq;
-	}
=20
 	gic_irq_set_prio(d, dist_prio_irq);
 }
@@ -2080,19 +2040,9 @@ static const struct gic_quirk gic_quirks[] =3D {
=20
 static void gic_enable_nmi_support(void)
 {
-	int i;
-
 	if (!gic_prio_masking_enabled() || nmi_support_forbidden)
 		return;
=20
-	rdist_nmi_refs =3D kcalloc(gic_data.ppi_nr + SGI_NR,
-				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
-	if (!rdist_nmi_refs)
-		return;
-
-	for (i =3D 0; i < gic_data.ppi_nr + SGI_NR; i++)
-		refcount_set(&rdist_nmi_refs[i], 0);
-
 	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
 		gic_has_relaxed_pmr_sync() ? "relaxed" : "forced");
=20

