Return-Path: <linux-tip-commits+bounces-6141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603EFB0A694
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD617B4C50
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D488B137750;
	Fri, 18 Jul 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42boo6fm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8/0UmadF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD686344;
	Fri, 18 Jul 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850169; cv=none; b=rgqS0PSifdi4iTywv/0g57OuQokcDRN/hBKuEHYCepuV43IxWuiVrRfccgJx9L+XrMgnwYZ9HXf8sIGszMeTQ3pc9RtC+syI7ONSPAget250Qm686HuynJVX1UXfYarVAS7tCRREUOtszs9xKy8D2XPKDeBLM47EtCSE3HS5Eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850169; c=relaxed/simple;
	bh=jGtrWAqcIV6bA/KgT8tbcb3OSIL/cyoGFAYzfcF7V6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bh/M5+8RzvG/vbjUN29qvsuz0F2GH4gFxyDDKzBFvhAK8hkpXg0h9/IzPOwjBQMUx5r0HRQQ1v3qLuyM0qEvyJMRHu8YLe+CbNQyxZC+KF13zMRzfZA+n49+KxKDrnuN/oMMMw2JjLxS+wb3oUvsZ71oigi/ai/6bskuXPqJ+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=42boo6fm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8/0UmadF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 14:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j34bMoAM1qC1DCBqrnDnW2GZlGmuG4XcN1cA8PHBa9w=;
	b=42boo6fmpKZMgN4gw54WzSqH1JXwmGRRLsuXJsgrUMSlhWa6NQIpusWSGhBu7/Ceh6bl8C
	AWOTBhBKL+ReH/058HAfW+YOFnrHlpgRtuC+BwKuDSgd+KlkYhofJXDjPOdXDOAb5kjG+p
	UElFiwMH7AQ2kEgjoMcrE9jUrFRxRJpWs37/hI1OA11+X65HEVLe4hu0SbXXsKOJD52zsM
	e2x4zm1hQl+fIUqNLqpOFHt3R7DsR8Za0q2cDmhk4dA2a8XrTDkdyyIhhcqEhT7ogjyE4Z
	M3TjM7lcpj5gawhWx+Y4CkOy3ElqbSS0bzPFq1v2DqnQ+ACFR4oTM52R2QdM5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j34bMoAM1qC1DCBqrnDnW2GZlGmuG4XcN1cA8PHBa9w=;
	b=8/0UmadFPnpw599LBx40Itf9Jp9ZjI3/TvW6u8A6jnxMQEhIXnL13mcmrN7kqTOMm7dfs2
	147qPQ+61FomJpBQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-irqc: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5a14f9932da20ec46cde27f314414474072755ed=2E17520?=
 =?utf-8?q?86718=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C5a14f9932da20ec46cde27f314414474072755ed=2E175208?=
 =?utf-8?q?6718=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175285016494.406.2967524821801967162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     2aad477b5b734f52825f7c31780222a5a17c06d3
Gitweb:        https://git.kernel.org/tip/2aad477b5b734f52825f7c31780222a5a17c06d3
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 09 Jul 2025 20:45:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 16:46:09 +02:00

irqchip/renesas-irqc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Convert the Renesas IRQC driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This allows to drop the
__maybe_unused annotations from its suspend callback, and reduces kernel
size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/5a14f9932da20ec46cde27f314414474072755ed.1752086718.git.geert+renesas@glider.be

---
 drivers/irqchip/irq-renesas-irqc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index b46bbb6..a20a647 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -227,7 +227,7 @@ static void irqc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int __maybe_unused irqc_suspend(struct device *dev)
+static int irqc_suspend(struct device *dev)
 {
 	struct irqc_priv *p = dev_get_drvdata(dev);
 
@@ -237,7 +237,7 @@ static int __maybe_unused irqc_suspend(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
 
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
@@ -251,7 +251,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name		= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
-		.pm		= &irqc_pm_ops,
+		.pm		= pm_sleep_ptr(&irqc_pm_ops),
 	}
 };
 

