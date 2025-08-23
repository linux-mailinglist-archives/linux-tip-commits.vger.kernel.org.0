Return-Path: <linux-tip-commits+bounces-6328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF0B32BBB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 21:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33923683652
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121B21B9DA;
	Sat, 23 Aug 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqCwiQnI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/CqxUERT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A281F130B;
	Sat, 23 Aug 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755978759; cv=none; b=roQtDCe67aiX0YTXYUBMcHjNxkYaeYrNplvRCdpUz25WbBJs+7QDtFsIgkfDsbLEj2ZQowT5kwZOrg+b+lD0wa+6+l8ZHmWKNfXc8QdyKgHbr6aSORBQk/f6AC8393sIuppPl31Xb1zRxbSAYXp+QoMj6IaogMmcsHpEcwyArbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755978759; c=relaxed/simple;
	bh=v1wEZO56GummziL9neBU05SCWlnDR9yrnpOCiGuKjSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZLdOREDkj3q41skLd2010BQXSiX4Lqw1OHQIEZoAH2m3hMi4D+zEec98qnZl91KA8CwSQULRjzzpABmqJAttzJOnC+uk8nQ7+x7LFTgHuVxljdQA+THf14VtXkXT9BYhaounB7FzzAFHsFTacersAwZqPC2WnKlgPX3qR8isCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqCwiQnI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/CqxUERT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 19:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755978755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=372pLaahYYJmldtEcJ4oI81lqSmNiu7/wEcN5YmqmXs=;
	b=rqCwiQnI+Vo8G1DyP/9+29utVopncvk/SM/g8s72fyausDi33QlAcR82glTcumKPRbmlI3
	ZVzo0Wwh+gdptcMt0OHJi/C64rpoZa5IUSiBDDukXGkZ2JI0Ni4dJNapFHCVbApPfLSQo2
	9UviUvzeqnF3b/B+qXsKdjJva9RfQ81dKIlarJNVBJ+y0XL5K7UiHcwwOdGDtoI6TFSxk5
	ogne/gnMf4+hS/2cshih8EJmT7pgnAYD+fGlHj0HxmKFnxJxAVdKaaCdw2EnU/Wopyhr7F
	BWIQ7ikl0tQfcz55/wEp7AwfPxcmURZqaH1TKC5MPQ5dp5NCIyLHzZnpyu6nSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755978755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=372pLaahYYJmldtEcJ4oI81lqSmNiu7/wEcN5YmqmXs=;
	b=/CqxUERTfY+jAUZ+fuE399HVXrv2UhhHenJXmTkPKLFpwPIQlqfsOEfmITfjURpay5nvnD
	3ChgbosKQdSCjIBQ==
From: "tip-bot2 for Edgar Bonet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/atmel-aic[5]: Fix incorrect lock guard conversion
Cc: Edgar Bonet <bonet@grenoble.cnrs.fr>, Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597875409.1420.7808650911707523725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c2bac68067bba5edda09112c09f2f670792dcdc8
Gitweb:        https://git.kernel.org/tip/c2bac68067bba5edda09112c09f2f670792=
dcdc8
Author:        Edgar Bonet <bonet@grenoble.cnrs.fr>
AuthorDate:    Thu, 14 Aug 2025 14:59:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 21:41:07 +02:00

irqchip/atmel-aic[5]: Fix incorrect lock guard conversion

Commit b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
replaced calls to irq_gc_lock_irq{save,restore}() with
guard(raw_spinlock_irq).

However, in irq-atmel-aic5.c and irq-atmel-aic.c, the xlate callback is
used in the early boot process, before interrupts are initially enabled.
As its destructor enables interrupts, this triggers the warning in
start_kernel():

    WARNING: CPU: 0 PID: 0 at init/main.c:1024 start_kernel+0x4d0/0x5dc
    Interrupts were enabled early

Fix this by using guard(raw_spinlock_irqsave) instead.

[ tglx: Folded the equivivalent fix for atmel-aic ]

Fixes: b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
Signed-off-by: Edgar Bonet <bonet@grenoble.cnrs.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenob=
le.cnrs.fr

---
 drivers/irqchip/irq-atmel-aic.c  | 2 +-
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 03aeed3..1dcc527 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -188,7 +188,7 @@ static int aic_irq_domain_xlate(struct irq_domain *d,
=20
 	gc =3D dgc->gc[idx];
=20
-	guard(raw_spinlock_irq)(&gc->lock);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	smr =3D irq_reg_readl(gc, AT91_AIC_SMR(*out_hwirq));
 	aic_common_set_priority(intspec[2], &smr);
 	irq_reg_writel(gc, smr, AT91_AIC_SMR(*out_hwirq));
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic=
5.c
index 60b00d2..1f14b40 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -279,7 +279,7 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
 	if (ret)
 		return ret;
=20
-	guard(raw_spinlock_irq)(&bgc->lock);
+	guard(raw_spinlock_irqsave)(&bgc->lock);
 	irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
 	smr =3D irq_reg_readl(bgc, AT91_AIC5_SMR);
 	aic_common_set_priority(intspec[2], &smr);

