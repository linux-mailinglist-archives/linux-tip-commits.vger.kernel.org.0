Return-Path: <linux-tip-commits+bounces-2964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A809E1ABD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CF8161E59
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E41E2854;
	Tue,  3 Dec 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXXDAkNX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38XtkRoD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A51E0E12;
	Tue,  3 Dec 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224835; cv=none; b=cKIjrqWNX1SRL3mRSdvqGU1m+/vERfml8oTOt8uBuuTTILntfhBUNyoOaiS6IKDd0Nn3r51rvsluRgb+ouk+Z61+scbBXlZP83HBn56tgYTkdizA9LfpkmRUp8EjmELNRCGeqq26/vrvU3vNzJzh9RdHkmn7AkEaLr7osMCGHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224835; c=relaxed/simple;
	bh=j4bKtx7hzCLylzhawaimKevDbk5AAVA2ASEi0UQi2tM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mPuD70BbLNivb8Cz+TDa8n72zB3vuScNX8t78D13tSzuYHFmX2J7zbZcv/oYmcIpbFbN+/roNWZfZrNWDzQv2POQ47Ki/+fMDOH/HnufZPEKP3x8gq93LivvOKl8nICWs/b6jtG0CqCvY/lR9xDoYqsb7sL7EKTfUloGSc72peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXXDAkNX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38XtkRoD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 11:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733224830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcywyoQ3lz2rMkuzxcfI6HPMyMvSngMAeHCWGrcoWgU=;
	b=GXXDAkNXuZ/fg/Cs7JH9bp4aAzi1rrGwMl5qzvThwS6gln3AKO/aDKM+8VsY7eWKjEmVkF
	JOgqVfIrQwvek33oRQhtxJ1Fq4FxjcsKMsuacRg7nUBZfK5vHViqVvFwcAvOi7OdTCk9Gc
	at5wUX1Hn1/Fh4B/HH0OO4wqWCQB5TSkprZS2f5tA3HCCL5x8ef9X41xJqdO3YhB4ah0xX
	n4V/8fuaQcHP37UGhYmKBRrnInxwG++S940L0AHhgCA3s4HOVB/mFQ8k7MpeGsWP49JaxN
	gXKTA2zdn/xu1PPQoJevdglZ3KQSzi8Dyb4MVQJZ7YkDB2ROx0tNsPXdygH2EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733224830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcywyoQ3lz2rMkuzxcfI6HPMyMvSngMAeHCWGrcoWgU=;
	b=38XtkRoDwgL9Bs0Lt/YPpanAX2V4/mVp+X+4wa40CIobOifSTAwegTC9hDQl9oOsI0OK9+
	mHkwiRLftc2v+DBA==
From: "tip-bot2 for Stefan Wahren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/bcm2836: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Cc: Stefan Wahren <wahrenst@gmx.net>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241202115437.33552-1-wahrenst@gmx.net>
References: <20241202115437.33552-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322482945.412.10685677629877028916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ee3878b84cc27ee62cdf78d2842830f4dcdab117
Gitweb:        https://git.kernel.org/tip/ee3878b84cc27ee62cdf78d2842830f4dcdab117
Author:        Stefan Wahren <wahrenst@gmx.net>
AuthorDate:    Mon, 02 Dec 2024 12:54:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 12:15:42 +01:00

irqchip/bcm2836: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

The BCM2836 interrupt controller doesn't provide any facility to configure
the wakeup sources. That's the reason why the driver lacks the
irq_set_wake() callback for the interrupt chip.

Enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so the
interrupt suspend logic can handle the chip correctly equivalently to the
corresponding bcm2835 change (9a58480e5e53 ("irqchip/bcm2835: Enable
SKIP_SET_WAKE and MASK_ON_SUSPEND").

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/all/20241202115437.33552-1-wahrenst@gmx.net
---
 drivers/irqchip/irq-bcm2836.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index e5f1059..e366257 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -58,6 +58,7 @@ static struct irq_chip bcm2836_arm_irqchip_timer = {
 	.name		= "bcm2836-timer",
 	.irq_mask	= bcm2836_arm_irqchip_mask_timer_irq,
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_timer_irq,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static void bcm2836_arm_irqchip_mask_pmu_irq(struct irq_data *d)
@@ -74,6 +75,7 @@ static struct irq_chip bcm2836_arm_irqchip_pmu = {
 	.name		= "bcm2836-pmu",
 	.irq_mask	= bcm2836_arm_irqchip_mask_pmu_irq,
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_pmu_irq,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static void bcm2836_arm_irqchip_mask_gpu_irq(struct irq_data *d)
@@ -88,6 +90,7 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.name		= "bcm2836-gpu",
 	.irq_mask	= bcm2836_arm_irqchip_mask_gpu_irq,
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static void bcm2836_arm_irqchip_dummy_op(struct irq_data *d)

