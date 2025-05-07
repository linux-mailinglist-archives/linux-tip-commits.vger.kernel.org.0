Return-Path: <linux-tip-commits+bounces-5437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ABDAAE120
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B352B1C0587B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469528B50C;
	Wed,  7 May 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0z/Q4u/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiHBymOA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A128B418;
	Wed,  7 May 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625461; cv=none; b=ulKal7ZKszpHTohnIZ4ylYuFTgzSPxv7Sh9RBHIh3FOxPIWn80gr82io2kUmai2lq980jIyAmkxpRTUnIGcGZkMgE+WrRN3vWswDoDB8dBbWxUR+S8OHw2gFT4GuWyU8n26lI3Kkxy9d1rJtrJ0IOnR7u8l7D4mt9ttwK8UBR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625461; c=relaxed/simple;
	bh=xz+mKZROYuqnITqMlggtspHaQ8eHRDitJugocB7nifY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r1uImxN/XHX2tiMMvt1/3ezr4hP4imSAjOoTdKAHV7qlZyO9kloLvlcXT8UaZbpos/wFNKH3FCMrtrrefVPM1G9R5U4D12/zwmeek4zJLtZVke/nO+PslTRS/eAZIcObEwy06sCjLKYNhafoPMv3hp2i5CNHzDrAGOHImm2t0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0z/Q4u/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiHBymOA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWYSRmeeBCssxE7Oni6e+sZdUqJAJaYGQa/x20yU70A=;
	b=j0z/Q4u/r//WyfwoF5rUNmFqvk8noEuY4xe9d7/bpeMTcGmEx/O1wnv+Ip7QPPhUIJ7XWd
	Xx+zcJBg7/cZI8QD608yPVmLexSibGCYhmfrrKykKhUAY9gECk8/0nKOaQqabpRTR08mly
	Itgfe4FwU6lXVi3WiPWOxjUkpu6M5lB/vO3BtUFWNWwb5YrRX3qW41yhrp9QPIHUm9Q1ao
	xF/19/wWdp7blmfYgsg4qogaX/bGi2l4MUrzhMVqxeVA+F+uX//BRhWjQNkRLnsot3FEs5
	xEdQ2fxaGLJV356bXF7GRMp00SCSmcwrPo9Qj38qMlgy8T+SnKT3z/6M4dhs1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWYSRmeeBCssxE7Oni6e+sZdUqJAJaYGQa/x20yU70A=;
	b=HiHBymOAIwaGVOlv6TgQrGVaxVwpCBjHW9jocnanFXrEgPWnND4i9j6bMWL9lrOv9E8nES
	Bkz3UcpmwFqQg9Cg==
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
Message-ID: <174662545488.406.17599656073640083234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     b17e8638c1e5aeb24d82b1a32a108cfa4b40f56f
Gitweb:        https://git.kernel.org/tip/b17e8638c1e5aeb24d82b1a32a108cfa4b40f56f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:40 +02:00

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
 

