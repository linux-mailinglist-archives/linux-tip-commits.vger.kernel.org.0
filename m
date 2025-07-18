Return-Path: <linux-tip-commits+bounces-6142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848DB0A696
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C555A21DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB671C8610;
	Fri, 18 Jul 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqHQmA3j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmQrVCNR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82D72613;
	Fri, 18 Jul 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850171; cv=none; b=gDKTohBTptuxPkvt79rnhXRY3aTrXPTeZWqEcp6GUaWeEmvFaFadPS2O/7gvKYlTvwJVQT/uFbWn+RIaQImADK48R91GMYDJpKtyVxYVmCKddRG6PJzScRvnYlbjQ6o23yXiMA0EuMwe75Iw1fU0GBob1bXmVEIwy27CkEf3fMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850171; c=relaxed/simple;
	bh=34zuXSrp5CVnEfNCyOkmX6NEe1lwc0XDTMVU4OqDgH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RJGgu0iMga3+2jPlVG8RglpzpwZNbSt6jd4r2zAFOOBf3Qe/ZYr+YBDlTN1Bji2Nwjp3LFpEHBoK16z4I7cow6NjNop8n/GoBCTWU/O0Ht/RcuZg5FeV6bhtVe5z2+V2w6NMxZIDb+MGpqFoiXs2GOuBRS91pRxzE5ZRr0ITsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqHQmA3j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmQrVCNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 14:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TlQKhs1OuBAOC41pUc00PRo164vkvpdcXDXF2g0txY=;
	b=NqHQmA3jTwjJK5f7fOZcRrAXHxJzWtbBXYTgvjCR2DiP5DAMhrrLydwoip8gqhxPiZ0C8l
	S0yaIt0ymUGF0Fguyg0uEbFrXogri6HxR3++huXM7nGhxlW+dfF9H9KmGEuC58SdmrKlQe
	OXIhyj5NY8C9/oFxdUyhoCeKuIHxt4XjoYHX1DDXDD1i3X/X3wlmhP6lkybD1LJz1d5KWF
	XvObh3US7QWHCYLIs945guKoZYi4JDxUtXi8GpW5+smdW7LudbfQZexQU4OrwZxDgmdCF7
	iC5FrmjkelddJn50alMSEMK+JgfWssCkQ4aUuzUOSR46HHG9VOqdhZ63Z2s9Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TlQKhs1OuBAOC41pUc00PRo164vkvpdcXDXF2g0txY=;
	b=KmQrVCNRb5Jk+oRNLuqsCg5mg1scQv4OxhZWO4XWzSZKbUVvEgbRKlsfDD/gjAD51cJILe
	YQFUbUZbf/qBGNDQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-intc-irqpin: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C865e5274cc516d8c345048330a46e753e2bda677=2E17520?=
 =?utf-8?q?86656=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C865e5274cc516d8c345048330a46e753e2bda677=2E175208?=
 =?utf-8?q?6656=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175285016598.406.5305761030544097334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bc398dc4f3677ca381d5b64f8e55005131e68650
Gitweb:        https://git.kernel.org/tip/bc398dc4f3677ca381d5b64f8e55005131e68650
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 09 Jul 2025 20:45:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 16:46:09 +02:00

irqchip/renesas-intc-irqpin: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Convert the Renesas INTC External IRQ Pin driver from SIMPLE_DEV_PM_OPS()
to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This allows to drop the
__maybe_unused annotations from its suspend callbacks, and reduces kernel
size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/865e5274cc516d8c345048330a46e753e2bda677.1752086656.git.geert+renesas@glider.be

---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 117b74b..7951292 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -570,7 +570,7 @@ static void intc_irqpin_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int __maybe_unused intc_irqpin_suspend(struct device *dev)
+static int intc_irqpin_suspend(struct device *dev)
 {
 	struct intc_irqpin_priv *p = dev_get_drvdata(dev);
 
@@ -580,7 +580,7 @@ static int __maybe_unused intc_irqpin_suspend(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
 
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
@@ -588,7 +588,7 @@ static struct platform_driver intc_irqpin_device_driver = {
 	.driver		= {
 		.name		= "renesas_intc_irqpin",
 		.of_match_table	= intc_irqpin_dt_ids,
-		.pm		= &intc_irqpin_pm_ops,
+		.pm		= pm_sleep_ptr(&intc_irqpin_pm_ops),
 	}
 };
 

