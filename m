Return-Path: <linux-tip-commits+bounces-5601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622CEABA3FA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D502E1BA885C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D65283FE7;
	Fri, 16 May 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkHepnar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PZLEfOzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67502283C8C;
	Fri, 16 May 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424254; cv=none; b=P6QGJiBUf0r9Op22rkLjaZdzHBDyqEP/iHbW/keY8nxY7pOa7ZMCILGc7ET0EmbpHU8DN4m5vP/8FtKd+QTpitFf1prEXJ2fxi6vEoKAObBHot72D6WbogNkprEIQiAQPKP7EO7r2PbVULzsKwK+8xMj75AhxzFXjqBpArHrIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424254; c=relaxed/simple;
	bh=9C26V1INRnhPjr+1uXQ/vIMIT9vpiECvIwmefIqfOe8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hIzTcOU7Uaqg0BP740lKldtvxm7JhZtYDx6taJKAn2stjgGmXYhvBsckpmmk0nwpCQICcnz2fWqQiC7UR06Q6H9YDqEgi993EXnzAFSiX/SGZt4p0f58sa9rYMxIoNmXb6yCRzRyMlrz9elYY96UCb/DoR36JIVeoZQuz/ZpTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkHepnar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PZLEfOzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y04aPZreBeoWqF66aAqO5nGiKLQjIQukyzUTz6vaTp4=;
	b=pkHepnarwLFlwjIZm6ziNqfM5zT7cc2u5hAYZCNzWK+fZgkusdAI7f9mTktgVMOnPN9uW7
	wD8bpm4L5umyDneae1OQhpUc68ILKpOQJqUmFD93K2C9eynOWLuEE0+S+ai+8RNtE5MY05
	ItsxkqCZoXUpiST5ZxmEV4oa7uP9KYyLliPvQrDaregV7NEsN2DZHo4xl+ov1cMQh02F5Z
	uq8lU7cF3+zK3HfoPljAofo1dBRqsu8UHE890YHAZzkt5vo9hj70fmIt0FPPer3CroxYkN
	iPzjhTTobQEseMsQFBIdwb+f7kLDOqvgypddmo420EsYufOwo6rVhiVPTs1otQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y04aPZreBeoWqF66aAqO5nGiKLQjIQukyzUTz6vaTp4=;
	b=PZLEfOzHTFwySJT6mScjiYxPVolrRFjYaYfkgFPH4Wxm2/0MtT+wV8DTdzFMN3WTccV3J8
	359yJjaYaNvLA9DQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] thermal: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-39-jirislaby@kernel.org>
References: <20250319092951.37667-39-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424975.406.5765085276174363437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     29dea335e3553ca285fc76177a7bbf942c6767a4
Gitweb:        https://git.kernel.org/tip/29dea335e3553ca285fc76177a7bbf942c6767a4
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:11 +02:00

thermal: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fixed up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-39-jirislaby@kernel.org



---
 drivers/thermal/qcom/lmh.c       | 3 ++-
 drivers/thermal/tegra/soctherm.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index d2d4926..991d157 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -209,7 +209,8 @@ static int lmh_probe(struct platform_device *pdev)
 	}
 
 	lmh_data->irq = platform_get_irq(pdev, 0);
-	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
+	lmh_data->domain = irq_domain_create_linear(of_fwnode_handle(np), 1, &lmh_irq_ops,
+						    lmh_data);
 	if (!lmh_data->domain) {
 		dev_err(dev, "Error adding irq_domain\n");
 		return -EINVAL;
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2c5ddf0..926f105 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1234,7 +1234,7 @@ static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
 	soc_irq_cdata.irq_chip.irq_set_type = soctherm_oc_irq_set_type;
 	soc_irq_cdata.irq_chip.irq_set_wake = NULL;
 
-	soc_irq_cdata.domain = irq_domain_add_linear(np, num_irqs,
+	soc_irq_cdata.domain = irq_domain_create_linear(of_fwnode_handle(np), num_irqs,
 						     &soctherm_oc_domain_ops,
 						     &soc_irq_cdata);
 

