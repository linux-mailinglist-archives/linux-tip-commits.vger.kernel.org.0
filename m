Return-Path: <linux-tip-commits+bounces-1755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23193F194
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545E61F23B22
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FE1422A8;
	Mon, 29 Jul 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EiPrePPS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7BkTN8h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585E13DB9B;
	Mon, 29 Jul 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246584; cv=none; b=GpciIwGHrUw5djHwNSobmQWlKeGu5MDxHAn7mlp18x8pgVSZ7VTt29YyGIbXZ3QJSyrH+KP+o2S1NBPSWrOWHFBnqdga1CsGrJv2BtLwqF1ESxxSD+yxFerqChHYWrwxSwYRwKiLmJ6KQENprWzQTJrmjdpYOtSOh6NDW2mkG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246584; c=relaxed/simple;
	bh=HOzsuRXYHehuD5SySC89EKy3uVEdNGKOZra0qMxcpco=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MhccoqT1pFDylr6U8YAMOVHxPkHu8g+gyIXHERUKFpBuJYMxq4qFeXiHP2+v/LURr/pqIfvfhBZ2ur0AxSptnkO9cI8u2vWep8xnU0go8p8GXZgXt+8RRlGtIB1JNdPzskZiaHO5xSGNY0h9v+/JoHNZsi3Ascmy4El/k0v1cDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EiPrePPS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7BkTN8h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I8lIq8jBDQZkIQ6mBkEWJEOGoDxUuwNPIBBESCrYGA=;
	b=EiPrePPS/cOX2UxRR/FBqRJBB4zN9gm6EjelNLcgLBvp+iYwWmu07R6VMSXx26Q2TUp5wc
	thD8AUnsx1R8d1bCNDyx0H2LVC4SbeFN8WrHSHbg3Ejuw2rbSneMx3oJPD8G3CqmD1NzBF
	p/RoMyRNgB0FyWh+viYJXcDh7INtEeHcTST6gNIQ8Rbob7BzNCLSGDnE2P2sx2LOCugz8T
	i0Qw/bDPY3qaAJCIRDju4PLlrllrfNSbfOYQosBwnoakOngS8ooVpjdAfQIuWm+jV5K3/3
	8y4EBYQdXumpQRkEbFuwqoUIJjlNqy0eKt92KDK6XMoFWOZB2jgKa0Ss/11S1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I8lIq8jBDQZkIQ6mBkEWJEOGoDxUuwNPIBBESCrYGA=;
	b=m7BkTN8hNvKaO+7Gm6hwAETp2Phpm1Wq+1h8gkBVcZNr+q8G6tUWN5J/glFj1KYyGqT3Px
	qcCrLwXWWw+tI9Cw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Refactor initial memory
 regions mapping
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-10-kabel@kernel.org>
References: <20240711160907.31012-10-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658118.2215.17849198927343225043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     732639e1d5f0f4b5135833de63ad4e4b79cbfd78
Gitweb:        https://git.kernel.org/tip/732639e1d5f0f4b5135833de63ad4e4b79c=
bfd78
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

irqchip/armada-370-xp: Refactor initial memory regions mapping

Refactor the initial memory regions mapping:
- put into its own function
- return error numbers on failure
- use WARN_ON() instead of BUG_ON()

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-10-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 60 +++++++++++++++++++---------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 1e0f1b4..244454e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -12,6 +12,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -751,29 +752,50 @@ static struct syscore_ops mpic_syscore_ops =3D {
 	.resume		=3D mpic_resume,
 };
=20
-static int __init mpic_of_init(struct device_node *node,
-			       struct device_node *parent)
+static int __init mpic_map_region(struct device_node *np, int index,
+				  void __iomem **base, phys_addr_t *phys_base)
 {
-	struct resource main_int_res, per_cpu_int_res;
-	unsigned int nr_irqs;
+	struct resource res;
+	int err;
+
+	err =3D of_address_to_resource(np, index, &res);
+	if (WARN_ON(err))
+		goto fail;
+
+	if (WARN_ON(!request_mem_region(res.start, resource_size(&res), np->full_na=
me))) {
+		err =3D -EBUSY;
+		goto fail;
+	}
+
+	*base =3D ioremap(res.start, resource_size(&res));
+	if (WARN_ON(!*base)) {
+		err =3D -ENOMEM;
+		goto fail;
+	}
=20
-	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
-	BUG_ON(of_address_to_resource(node, 1, &per_cpu_int_res));
+	if (phys_base)
+		*phys_base =3D res.start;
=20
-	BUG_ON(!request_mem_region(main_int_res.start,
-				   resource_size(&main_int_res),
-				   node->full_name));
-	BUG_ON(!request_mem_region(per_cpu_int_res.start,
-				   resource_size(&per_cpu_int_res),
-				   node->full_name));
+	return 0;
+
+fail:
+	pr_err("%pOF: Unable to map resource %d: %pE\n", np, index, ERR_PTR(err));
+	return err;
+}
+
+static int __init mpic_of_init(struct device_node *node, struct device_node =
*parent)
+{
+	phys_addr_t phys_base;
+	unsigned int nr_irqs;
+	int err;
=20
-	main_int_base =3D ioremap(main_int_res.start,
-				resource_size(&main_int_res));
-	BUG_ON(!main_int_base);
+	err =3D mpic_map_region(node, 0, &main_int_base, &phys_base);
+	if (err)
+		return err;
=20
-	per_cpu_int_base =3D ioremap(per_cpu_int_res.start,
-				   resource_size(&per_cpu_int_res));
-	BUG_ON(!per_cpu_int_base);
+	err =3D mpic_map_region(node, 1, &per_cpu_int_base, NULL);
+	if (err)
+		return err;
=20
 	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(main_int_base + M=
PIC_INT_CONTROL));
=20
@@ -794,7 +816,7 @@ static int __init mpic_of_init(struct device_node *node,
 	mpic_perf_init();
 	mpic_smp_cpu_init();
=20
-	mpic_msi_init(node, main_int_res.start);
+	mpic_msi_init(node, phys_base);
=20
 	if (parent_irq <=3D 0) {
 		irq_set_default_host(mpic_domain);

