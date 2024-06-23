Return-Path: <linux-tip-commits+bounces-1503-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DD913D67
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1991F21F0C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1C18508E;
	Sun, 23 Jun 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1M0JSJ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="im3DH7iT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB7184124;
	Sun, 23 Jun 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165138; cv=none; b=ATEj0xcL5qES7ZIHrrTW7rBva3Dy9p+SBWCXTmJjbPi87sTppYr+Bl0R4UI+yeChVxKn4v+cpPurw1xwGxbxmRiKOqI2z6+E9kKckvM+QiqeKZbrQmM5rAMEgIfE0191V0/KVDcsWPWVH2jccy/LQuhYhB6vdaSiQ9gPv6cm11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165138; c=relaxed/simple;
	bh=YhcySyrULEuTY2Lk6+YsuTDRCgH4fu8Sgt8YC6L4JrY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d3RbSO1BeZMVx2D0NDPs5YKqLf+B9Lch8wIxtUhFb/j81DAaDuJGre9Xmybog7q5mBMlAhTZEUBJIBntsrWkG9HRhdHJ1xvCXwmBsyzOjG7BGN2uBYheyRNuA6T1v7Tr7lUQUtB4hAKFcpvs9/5jEyfPWfK4AENWrF55Qlp/S4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1M0JSJ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=im3DH7iT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:52:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJyyShQGxmA8HNb0GIzL71lYuSzysQT8itJ292vmhtM=;
	b=o1M0JSJ4dMxChKUUuTLqMX2IQiXQJ+WfuD/UGNdYrWWd9U2Ek22ihwKQmAF+bnbbDfLJqK
	hSvcygvEaoCRTQHw84EOSVEAp6ImMRD1+ZJd5mcS+pjWunZlyiUaOKtI9AjlFCcDNd/GRY
	YzTxednkEQXu6W9wUH/a9odkw8m5SDwLgZeD4K/EvEOEX6XVYpLAFul1WrpA3BvAMHXSe9
	1GGhi4Ahleu2g6iHMyDn+/lNDlW37JG4tOyViuEeS/ifsCYCW9bb6aOPMqba8oaigd8QwK
	cjYy/khl1/26+kxdJCW6AnajQ4UtLvjHBI0PJPNyZneprhwYU+kizepsjRdGOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJyyShQGxmA8HNb0GIzL71lYuSzysQT8itJ292vmhtM=;
	b=im3DH7iTygGPogYlAakwUExJiJNZDsQ2oc6z9ZLCtixT2wBPv/vyKHwdDjrZuw68Lwljrn
	hSmEAW0Z8kEwoUBA==
From: "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/dw-apb-ictl: Support building as module
Cc: Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614153449.2083-1-jszhang@kernel.org>
References: <20240614153449.2083-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916513264.10875.1048433576050654803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7cc4f309c933ec5d64eea31066fe86bbf9e48819
Gitweb:        https://git.kernel.org/tip/7cc4f309c933ec5d64eea31066fe86bbf9e48819
Author:        Jisheng Zhang <jszhang@kernel.org>
AuthorDate:    Fri, 14 Jun 2024 23:34:49 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:49:44 +02:00

irqchip/dw-apb-ictl: Support building as module

The driver is now always built in. In some synaptics ARM64 SoCs it is used
as a second level interrupt controller hanging off the ARM GIC and is
therefore loadable during boot.

Enable it to be built as a module and handle built-in usage correctly, so
that it continues working on systems where it is the main interrupt
controller.

[ tglx: Massage changelog ]

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614153449.2083-1-jszhang@kernel.org
---
 drivers/irqchip/Kconfig           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 348f345..aaf8453 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -145,7 +145,7 @@ config DAVINCI_CP_INTC
 	select IRQ_DOMAIN
 
 config DW_APB_ICTL
-	bool
+	tristate "DesignWare APB Interrupt Controller"
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN_HIERARCHY
 
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index d5c1c75..5eda6c4 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -122,7 +122,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
-	if (!parent) {
+	if (!parent && IS_BUILTIN(CONFIG_DW_APB_ICTL)) {
 		/* Used as the primary interrupt controller */
 		parent_irq = 0;
 		domain_ops = &dw_apb_ictl_irq_domain_ops;
@@ -214,5 +214,12 @@ err_release:
 	release_mem_region(r.start, resource_size(&r));
 	return ret;
 }
-IRQCHIP_DECLARE(dw_apb_ictl,
-		"snps,dw-apb-ictl", dw_apb_ictl_init);
+#if IS_BUILTIN(CONFIG_DW_APB_ICTL)
+IRQCHIP_DECLARE(dw_apb_ictl, "snps,dw-apb-ictl", dw_apb_ictl_init);
+#else
+IRQCHIP_PLATFORM_DRIVER_BEGIN(dw_apb_ictl)
+IRQCHIP_MATCH("snps,dw-apb-ictl", dw_apb_ictl_init)
+IRQCHIP_PLATFORM_DRIVER_END(dw_apb_ictl)
+MODULE_DESCRIPTION("DesignWare APB Interrupt Controller");
+MODULE_LICENSE("GPL v2");
+#endif

