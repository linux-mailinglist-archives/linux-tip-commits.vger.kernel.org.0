Return-Path: <linux-tip-commits+bounces-1674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB192D6FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8981289D12
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D991946DE;
	Wed, 10 Jul 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSlRZzFw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZ7Yf8N0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C1BE4E;
	Wed, 10 Jul 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630781; cv=none; b=MY3YERlcD5czM67aM2FT88mtIyQcyE6KNuT8jo8IyRFeawKjfTNoFxf1ndhJDXgI9OcRksqbMOB+1cFUs7OKaJqqhTRdCEn2oLxNLzRGzxUEZTu2VgEbs/tiffF0n6A2HdsYe2WZydO2kQoGE732uS7woV0xZg4L2+SJCjzjdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630781; c=relaxed/simple;
	bh=qrfwUADBafTApWjI2Dp/8d4dDvqt05ByTY98SghRgZc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=m3sGDRkOXV9yOCElmnv+2+FnNMLNLiUGb/8e89XfdwjH7K0UrTbvl2N8vqbcoPfx3/nIIpQ3RZfbvFk4zWXYXRmyTrxi/tRbcTuGcuoS3O0hoNGE0xrylcB/zhU/fgmp7exMcWMV3k2RV1x92osQ+KExj1eVRDHJ75QI06/ZVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSlRZzFw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZ7Yf8N0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:59:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720630776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rWXRBXbcG64wcGr3JcpTsGdx4Lb5my/NMAyiZeWFeHY=;
	b=cSlRZzFw/3UCAar8eOMdaQICy3f95qOv6NV8OPpqihpECWQjTziAfsXsZxTjvdAORZYysI
	9rY9/N8Cw7sYjE+8sE2SmIl5WmQ+H0wQgLDw0luad34OL/dHTe21d9LeUBmJz1uFVP4fGz
	lutWPxbuajYk0y6GEYpgKMiwgm1OZx0EStSPzrdn3nyDrX+0OCxgKIJpdEozgyq52VCCX2
	z7DvGk8r6UrnM5texM2Z+wJj0/lIg4YCyxInfa8HNj+vmvcCDQI3tVAs3ejfqHLCzJUKit
	w9tMhatS/8hvzX1nI/0F1pKZUS5MhYmzf1HVeyZYMfn5N2NckN8s6MVETh4xqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720630776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rWXRBXbcG64wcGr3JcpTsGdx4Lb5my/NMAyiZeWFeHY=;
	b=MZ7Yf8N0EmMM27nbHo+gHIrxYvPIOKqBKobNLM/0fxm/s7fX19HFhu4veix2y2RNfl0TbL
	Ugolnn51+yu/GtAg==
From: "tip-bot2 for Stefan Wahren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Cc: Stefan Wahren <wahrenst@gmx.net>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172063077590.2215.16096583476883655445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     57c1c3f894f0bd4e81c89e3ea0e8c10405de8490
Gitweb:        https://git.kernel.org/tip/57c1c3f894f0bd4e81c89e3ea0e8c10405de8490
Author:        Stefan Wahren <wahrenst@gmx.net>
AuthorDate:    Sun, 30 Jun 2024 17:36:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:52:23 +02:00

irqchip/bcm2835: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

The BCM2835 ARMCTRL interrupt controller doesn't provide any facility to
configure the wakeup sources. That's the reason why the driver lacks the
irq_set_wake() callback for the interrupt chip.

But this prevent to properly enter power management states like "suspend to
idle".

Enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so the
interrupt suspend logic can handle the chip correctly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/irq-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index e94e288..6c20604 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -102,7 +102,9 @@ static void armctrl_unmask_irq(struct irq_data *d)
 static struct irq_chip armctrl_chip = {
 	.name = "ARMCTRL-level",
 	.irq_mask = armctrl_mask_irq,
-	.irq_unmask = armctrl_unmask_irq
+	.irq_unmask = armctrl_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int armctrl_xlate(struct irq_domain *d, struct device_node *ctrlr,

