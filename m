Return-Path: <linux-tip-commits+bounces-1699-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E501931598
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C601F22176
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C8118E752;
	Mon, 15 Jul 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="adJGwFlP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wyaR/pqA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A218D4D9;
	Mon, 15 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049642; cv=none; b=fs7ovf+b2Hlkm/WsUcxZzlbuHUAXh9wEKAHGRVc8ATKIuf7NG8CZCrgTfkp51T+VusH57w1zck6nlkQSSdQEZrvYZ9w2i5R3aLjdWSVSwOf4fqfedXKD24uI9TYrR6p9K+UOYD6SiJ04iGEGjB0HmghXGIsGNVHqIuRSsF2oQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049642; c=relaxed/simple;
	bh=QGvqShbDP8fgb1L2IbHMK+cojEDrL/OBEUZizErJpXc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OtoduMCJqsdR5yqFUE8GUZMvukBR3TY8eeb51wnk3f3v45QnHkP4ML0SRQXIiuWUjgmnSEoDinnFcL/kjRsMxLE2uNK3DXtyiz9BCV/qgtQ9xLGa0Ge/bcBFzyRRsUvYKnTi7TQJ0Lg9OgBCgKn/i0guFHs1jqO8NyOyzoWgQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=adJGwFlP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wyaR/pqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sf1VJbIsNYY7iNPSjdvMEHPvQajqKQESdZSm9NiB9ZM=;
	b=adJGwFlPYL5HVasMykWCyFyRjsMUjgNPE74eWYk2WwsiDOCT0UHbpFyRLZq/CDS2K3t/h9
	hOBY+VB9e+JuUnLRAMI+Xjfjfo2GLkuEFuwjtJua0av79nzqdTyRsDA5IR3vpBRyd2ZGi4
	QM+1ACBn0Ly/IA9qAEhDzMg7ap/gL90n40IFvdDGKWYv204xicrfYVnsaFXyfR6eIwJR+V
	ekYkhROPheSKQdrq/ADH3+4cQiKMKRJym4wSHvtC/qUPsYWfPMPYafZTpZ5xUDv1MfSf8D
	l4lUAIjRpLWXmMvrEnVBPk/9bIoggCrfA+TzAFEGEYx1XhRFtMeQAUdJWBpgNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sf1VJbIsNYY7iNPSjdvMEHPvQajqKQESdZSm9NiB9ZM=;
	b=wyaR/pqAfeBsKGYFYFPN9pxoDBK8H1yxdT1CbrLTlzzJq23B8Hf3GAbplkBctuQK2LOb1c
	yvYhwj9Fow2Dn8Bw==
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
Message-ID: <172104963840.2215.4537609073625389371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9a58480e5e532903f08b2a34f05076d3ec3a5c00
Gitweb:        https://git.kernel.org/tip/9a58480e5e532903f08b2a34f05076d3ec3a5c00
Author:        Stefan Wahren <wahrenst@gmx.net>
AuthorDate:    Sun, 30 Jun 2024 17:36:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:55 +02:00

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

