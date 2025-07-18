Return-Path: <linux-tip-commits+bounces-6140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE6B0A5E5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 16:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121015A5858
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E69196C7C;
	Fri, 18 Jul 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUPjqywQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+bhBjco"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A215E5C2;
	Fri, 18 Jul 2025 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847960; cv=none; b=k9a3dmZgHK7eK6CeWR/zPWOGhKLfsJUiQ28phFWBHNCyZUgSxDJrrBXEwgBurZ5gs+Qh/JGqJLwkAT8oggtzVfBc6cshwalskRu+WXgeg+DA+nJvwEsGwIYJXT+Z3VLLvKuOrtlagypTrNOYFD2mMac5gvXOdk4J8fFLi4ejR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847960; c=relaxed/simple;
	bh=IuWMOo4oGKSGP0ul2Cr2J3HfUAeIqcuOljlhj8UQgMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JpsV7XoLzuvjkbFgRFwSH+mGNjF91Xh7XOaI3JVxQPFpb/Yv1p1DWvI9ug7Nh9lG77KoEK1K0YffwD7vuXWxpTtuGTWDa/e2/H9WzVxP8FxUEqkFSgOWmmuRM0rovCTV3aH5i4y2Cz9/q5ZmQRQ7QzHRquw1Lv4CcZdSMS1w6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUPjqywQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+bhBjco; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 14:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752847955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S4AmmTtlX0Swce59vcrO3qOkgqkgROhzRuBm/aMKzU=;
	b=cUPjqywQcgoY4oIL55njH2osxJX1aDQlUggJGx5qvfs76yhxz+BrKOzVPjN7LOGh8visxe
	mPakos4PET1/G99teCHoapUG8tQc1Hqp701/S1+g4C39zFwm2nNVR54JzgxlJVYrRG7Mdp
	b2Yr/uCJU1m/NB7ERf5uxNXjHSnlLf+idDd1Y6ZwCxwBuQ062WE92DvulGTkyPnrgGx79F
	hLwEyHnP95d6chD/+MNI1L96zEZWk8o2fix4qjHUHtG4h2lUeVfmV6S6JzY62bG8OAvUXg
	2sUAzeuQiGRs2S1AnPhPusfkHGjo5Wa/ywkUO9H4zP4tJGka6UCSYEnZOH62uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752847955;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S4AmmTtlX0Swce59vcrO3qOkgqkgROhzRuBm/aMKzU=;
	b=J+bhBjcoaPbv+apg+LBm27CfLn+nwecbB0MrTWDyObyj1ADTAOl7YoqM7XoEFFsBZT70rR
	zrS5ydxykKD4AjCw==
From: "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v3: Fix GICD_CTLR register naming
Cc: Zenghui Yu <yuzenghui@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250709130046.1354-1-yuzenghui@huawei.com>
References: <20250709130046.1354-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175284795468.406.17930543130512326496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     97c03ec2c0e0621bbd7a56f5be19bd2de552e6f4
Gitweb:        https://git.kernel.org/tip/97c03ec2c0e0621bbd7a56f5be19bd2de552e6f4
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Wed, 09 Jul 2025 21:00:46 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 14:56:39 +02:00

irqchip/gic-v3: Fix GICD_CTLR register naming

It was incorrectly named as GICD_CTRL in a pr_info() and comments. Fix
them.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250709130046.1354-1-yuzenghui@huawei.com

---
 drivers/irqchip/irq-gic-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index efc791c..dbeb856 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -190,12 +190,12 @@ static void __init gic_prio_init(void)
 
 	/*
 	 * How priority values are used by the GIC depends on two things:
-	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
+	 * the security state of the GIC (controlled by the GICD_CTLR.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
 	 * way priorities are presented in ICC_PMR_EL1 and in the distributor:
 	 *
-	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
+	 * GICD_CTLR.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
 	 * -------------------------------------------------------
 	 *      1       |      -      |  unchanged  |  unchanged
 	 * -------------------------------------------------------
@@ -223,7 +223,7 @@ static void __init gic_prio_init(void)
 		dist_prio_nmi = __gicv3_prio_to_ns(dist_prio_nmi);
 	}
 
-	pr_info("GICD_CTRL.DS=%d, SCR_EL3.FIQ=%d\n",
+	pr_info("GICD_CTLR.DS=%d, SCR_EL3.FIQ=%d\n",
 		cpus_have_security_disabled,
 		!cpus_have_group0);
 }

