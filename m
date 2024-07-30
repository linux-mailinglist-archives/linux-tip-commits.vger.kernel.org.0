Return-Path: <linux-tip-commits+bounces-1822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F59410BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C06E1C2315D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1119E7C7;
	Tue, 30 Jul 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBy/7X/b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNccfgGZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301018FC82;
	Tue, 30 Jul 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339601; cv=none; b=a/G+zxNAIF0rZS7x2rl7G+j7PK4LsRQe8/LQfBuhFWGNt/vLJ5wunSoUPrnmbRxMcUmCCWjKgRG2Fu5h6hZdIUCa+wrrgwDes5286AKqX0h1Caejd08uYILmlsuNCzR66TYiwAFcpjADM+xeojillGiF8f+75bJSCYfJNHav9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339601; c=relaxed/simple;
	bh=8rAQ6AB4aVrykSkTJSRX8IRsbErbebxe/9SwefwIFgI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hfnSGjABz14/KUdhBuUE7ns31CyM+/EYI7ppdxouGjvcD0TJj984QbVvw5NgfdRZGtuP93flHsUKj353p3NMI5S4k5ajJeyVS+e56z48pMe2fNJcyTT7OCZzvOWFva1MLkVVtXju4I0LpcjqJncl74fYXuoq42NHTM8+qmkeZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBy/7X/b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNccfgGZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF8mvkjAN+c3CY38EZzeEucm0iDnmotAbIve7kMbOwE=;
	b=BBy/7X/bJBlxXwcGnV9IOeR4xdBRjs2v3DuZxDZ3AeeByoO168WgZAXJ1r4VYZRsajwEmd
	bgmAnDtHsrDnNvliMyv62W+vu0YlF8nt+HduBIS0hx4kvHs4ST6UAHgH0PL1aWt+DFUxBu
	mHetgst1clowDpHT++QRrxO/W7HbE6e8/oHeiMhkJDdhO9tulC0oEv9SFgCjPBJkAvGpdJ
	vtYGqGxM/W3Cdcg8Pr6iAu5vqJxB67CAZSFUouHihQc6zGFGzoBhVZSy/CeuwoPidZBK5H
	fHznwl7MDPs96KKZhZqY8oa3nx7YITdpgNjUSCVQJR06IrLUI/q7iXI8Vm4jGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF8mvkjAN+c3CY38EZzeEucm0iDnmotAbIve7kMbOwE=;
	b=XNccfgGZWX36wmSgWRy74Rz0Q6ECU73/KKHNCW7gqVk7ITmNIA61flCrnTbjNY+mVlq8tj
	XnSE6jIhMN1tlCDA==
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
Message-ID: <172233959779.2215.13281468626631095243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     654caa9db6649dbecdfa55ea29c9cbf4603fb402
Gitweb:        https://git.kernel.org/tip/654caa9db6649dbecdfa55ea29c9cbf4603=
fb402
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:49 +02:00

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
index 8b28188..9c66c25 100644
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

