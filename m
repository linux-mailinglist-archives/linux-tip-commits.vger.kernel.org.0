Return-Path: <linux-tip-commits+bounces-7013-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA417C0F527
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86164E307C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11113195FB;
	Mon, 27 Oct 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="325jgcMW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCCFqU2w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C813191BC;
	Mon, 27 Oct 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582672; cv=none; b=rHvnzkKowOK8rVz0fPm0jWNN1in957A/m5pF6/n06Jylt+xjNrnVmZQaDBagXHlKKsWRGcLRRKQkBkjO4sYn+cn2iihSKslKHwl/xNb0Z7BWBk4AgwkKnb7exDEGOw0+bSmvkpsfYPfnodD1jN0a+r8UbQxOdQ4e5E+PqAovBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582672; c=relaxed/simple;
	bh=yljfzHftsI8vWs+kC5byP5H20IdWLsZ+6I3VnkvSuvs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PJSTbbDAWpsi7qZU7JOuQ9z/7VHMp4cSvjzETmgKiILjiXTLjvxyhjOAj2lrKTcTJ3rTVTynlmz8bMicECtco0shzZAXCG18qAcTTCWvhGpnIE/fzB7pop5IrdptXcWD0nG0aUhBZunjNIRknIWXzL9PZJFMbYgDQuHA41TEr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=325jgcMW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCCFqU2w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qquZdUKnflHg6HElTJDkDYarbGZxtfYbPq8glJfKzLs=;
	b=325jgcMWVe2r4WzFOAKoQ6IEP6jE90CmGyj2OohJFgtX8pkTLSUmVoS1X7izfKpOVntlXz
	6UMBJsYwjzLTUoOr4T2+OkTdhC7xu1SFHhd2G+2g5To+NRZIgtEAkM6LppyOGGalArcJlD
	7KgulPyWhhCuStjAt9AZeNxgeoOigonGCukgFj8SDvGzBnn6k3FhXIFCPuxuXJRouWGDM/
	/gdEfRDFpON45y/RfLHxnf+20WJwXQg5fMB8I1lgDy2oRMm+Ncc/6CbDFvXvA0JUgg7FZZ
	35rB4mkwdkr3PZSpPzuvoVjbC6WetYylnNwoy4Fxr2/2gtcIr0RKHqLQWDpwrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qquZdUKnflHg6HElTJDkDYarbGZxtfYbPq8glJfKzLs=;
	b=iCCFqU2wMzl0N+X+SZgy0GcfODxk9n24ga3J0cpEodEeYmd4AcAhYO4kJFQzhj4V3Yn44B
	Zk6QIYgLbXP+z9Cg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Factor-in percpu irqaction creation
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-14-maz@kernel.org>
References: <20251020122944.3074811-14-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266775.2601451.16980101553960468233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9047a39daa7832e40a9ae2d190ae5e7b351a9121
Gitweb:        https://git.kernel.org/tip/9047a39daa7832e40a9ae2d190ae5e7b351=
a9121
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:34 +01:00

genirq: Factor-in percpu irqaction creation

Move the code creating a per-cpu irqaction into its own helper, so that
future changes to this code can be kept localised.

At the same time, fix the documentation which appears to say the wrong
thing when it comes to interrupts being automatically enabled
(percpu_devid interrupts never are).

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-14-maz@kernel.org
---
 kernel/irq/manage.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c948373..d9ddc30 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2442,6 +2442,24 @@ int setup_percpu_irq(unsigned int irq, struct irqactio=
n *act)
 	return retval;
 }
=20
+static
+struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned lo=
ng flags,
+					  const char *devname, void __percpu *dev_id)
+{
+	struct irqaction *action;
+
+	action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	if (!action)
+		return NULL;
+
+	action->handler =3D handler;
+	action->flags =3D flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
+	action->name =3D devname;
+	action->percpu_dev_id =3D dev_id;
+
+	return action;
+}
+
 /**
  * __request_percpu_irq - allocate a percpu interrupt line
  * @irq:	Interrupt line to allocate
@@ -2450,9 +2468,9 @@ int setup_percpu_irq(unsigned int irq, struct irqaction=
 *act)
  * @devname:	An ascii name for the claiming device
  * @dev_id:	A percpu cookie passed back to the handler function
  *
- * This call allocates interrupt resources and enables the interrupt on the
- * local CPU. If the interrupt is supposed to be enabled on other CPUs, it
- * has to be done on each CPU using enable_percpu_irq().
+ * This call allocates interrupt resources, but doesn't enable the interrupt
+ * on any CPU, as all percpu-devid interrupts are flagged with IRQ_NOAUTOEN.
+ * It has to be done on each CPU using enable_percpu_irq().
  *
  * @dev_id must be globally unique. It is a per-cpu variable, and
  * the handler gets called with the interrupted CPU's instance of
@@ -2477,15 +2495,10 @@ int __request_percpu_irq(unsigned int irq, irq_handle=
r_t handler,
 	if (flags && flags !=3D IRQF_TIMER)
 		return -EINVAL;
=20
-	action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	action =3D create_percpu_irqaction(handler, flags, devname, dev_id);
 	if (!action)
 		return -ENOMEM;
=20
-	action->handler =3D handler;
-	action->flags =3D flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
-	action->name =3D devname;
-	action->percpu_dev_id =3D dev_id;
-
 	retval =3D irq_chip_pm_get(&desc->irq_data);
 	if (retval < 0) {
 		kfree(action);
@@ -2546,16 +2559,11 @@ int request_percpu_nmi(unsigned int irq, irq_handler_=
t handler,
 	if (irq_is_nmi(desc))
 		return -EINVAL;
=20
-	action =3D kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	action =3D create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCI=
NG,
+					 name, dev_id);
 	if (!action)
 		return -ENOMEM;
=20
-	action->handler =3D handler;
-	action->flags =3D IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_NO_THREAD
-		| IRQF_NOBALANCING;
-	action->name =3D name;
-	action->percpu_dev_id =3D dev_id;
-
 	retval =3D irq_chip_pm_get(&desc->irq_data);
 	if (retval < 0)
 		goto err_out;

