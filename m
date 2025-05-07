Return-Path: <linux-tip-commits+bounces-5341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A2AAD959
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFEE178B6E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DA22B8D1;
	Wed,  7 May 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WFV9a+EV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOTZPKqU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620122A4F6;
	Wed,  7 May 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604683; cv=none; b=Y1QtUG/lq4D4+piQ0qCSZHkJ791E0cuD6wpmMzEppm8dcR2IlJvVVxK1boYLcmM6DHBa47VwFpfDP1bcYNXXnkjIgpfjnjziVwavAsGm5qxzmnl/jKInmN4HUt8spoXHyFxZz4bY0RNjydFmXF24teDxwvH9HcGb1ggpyMpRK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604683; c=relaxed/simple;
	bh=nBgRJJgd4bvMMNHDWfe6RhkS4YJvrAZk381KoL4L8Bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=awqMWvGDvOoWBiDa+lUcUKmYvUAReEq5sg2/jMZW0w5Ped1//UjAlJjEasX/l6z1tKa2fQW5Qbq24OI8O9morAm3V9BKBTRw9FUX2ZATrDM3jVGDnuAGurg2kl1qiQhEGiZmqyJHxCHxXad6ro3v45rzT3YB4/vvE/TqK4Vn1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WFV9a+EV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WOTZPKqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFc+P+c6zY2jJ9/xgyHtrFTs7ExbsLaknziwZ+GW/6k=;
	b=WFV9a+EVHjj/eFGVB8S3VseOAdTJrkmu8UqeYNsNSMrQ/dlpT35kzCK1Flm95OM3TC+JSy
	zsS3OL/kolYe8L6yvhixZMnEHeDUCuRVBBqBs9muHc6YA77hcwpKRngqb+YU7gTYXtVTAu
	iAnSLaEmDFLhKGcN1WJvAN1Yt6ii62o+tqq29tUCYcU3L/Ms/p0U4v1IV83g/ZqcXutpi5
	h6KgxHZ5Me946diLTJWSWbxX3IqXeY+f+K//OAOudfLYza/e9pPEnolSs84JcNXc4+5vm7
	Ys/3KmhI8AyrKJbqRV23KGV66S08DJT3xts5CvmG9qKxfY/7FvXbf2u+YBp86A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFc+P+c6zY2jJ9/xgyHtrFTs7ExbsLaknziwZ+GW/6k=;
	b=WOTZPKqU9fPkRRgseQ7ZCW3Ft6TatCojtaxHN/kXfNCUqVvl1SE047PO0cdb7YudNej7gE
	84ej1XvwqWW4fwBw==
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
Message-ID: <174660467875.406.10478100245543551334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     04f60198608422bac71db63cee0d2a480e6015ba
Gitweb:        https://git.kernel.org/tip/04f60198608422bac71db63cee0d2a480e6015ba
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

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
 

