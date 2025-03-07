Return-Path: <linux-tip-commits+bounces-4043-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8FBA562FA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 09:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB18D3AB5FF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C31AF4C1;
	Fri,  7 Mar 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAG/w4vI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ikro9N4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7F14D283;
	Fri,  7 Mar 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337527; cv=none; b=c6G63SqpBlOOFiqneZE7krtgVzlMGgTd9LkdUQeE5viNMJpjxx73mny5s9eDKNiAfJJBLfXcUM9q9slG9PDWqbWjznqiWhxrI2+enpu3WZvVCbQTig7kR2lmTudA0AQ2mXHOyM+YLEPVERvxXQ8SbpYL4X/PZJZ0Da9i1NLKHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337527; c=relaxed/simple;
	bh=hQfwJhsHr4CVUi0qKhXrIyhGMy24OKMPo63dqahohSs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GLkVKx6xAIlYRhNDcvquGgKibJcB7vZm3l2Es9FhJ5VOCYpxZpS/eBZGgQpVeIworhl0JgYQYrsfI982rhOkd4is0KgsVOCg87TF1PR/hlGyl59oFNXm4Cw275iuUb6IyL2C9Hkoylpk7jvcMcVGR8ksGADxI+4GGPHY5wuzufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAG/w4vI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ikro9N4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 08:51:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741337522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtKkUi0W48B0wBvZKOzYOBZ4voGfhG5b2Iwp2Q0xCo=;
	b=UAG/w4vIJp2Cte7DKidQQMLByTRm7UBMKJoLIYB/e21u/0OfcddHRMkf2PkdHudBe5fXtB
	540TkuyLO2DXvLsjT2quS2HkN1BlvLJ7opuS1yzTIoRKHPJKelW8+xt+B/LvQzd69SRUaf
	ajy8mt3lQQ9AgT44Zliq6yrbzP752vt8buWWB+KSl7mrDgE8lTlp76DCtrEkmCQk0x6hVB
	KWUKX01p/rEvsFEInSdtGvqoz/8RoHhrzyGBptZponeyWdzzLpQ/bX+C69gacIKq67SVhy
	/owWLzEz3pU6RcsVxmj2KSZrUyOn4RVIfuqaTbJzZIEChWnbFzrPwNDM+RslnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741337522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtKkUi0W48B0wBvZKOzYOBZ4voGfhG5b2Iwp2Q0xCo=;
	b=Ikro9N4G5VqxccWN+caeh0cWaTkEx+TZS4fa7ltkjB9Onmzzpi4Fzu7KpOi+hQGM8mGCyc
	Jam7HiuHG1mOCNAA==
From: "tip-bot2 for Shengjiu Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/imx-irqsteer: Support up to 960 input interrupts
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305095522.2177843-1-ping.bai@nxp.com>
References: <20250305095522.2177843-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174133751827.14745.2072440373199317211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7db5fd6b751fbcaca253efc4de68f4346299948f
Gitweb:        https://git.kernel.org/tip/7db5fd6b751fbcaca253efc4de68f4346299948f
Author:        Shengjiu Wang <shengjiu.wang@nxp.com>
AuthorDate:    Wed, 05 Mar 2025 17:55:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Mar 2025 09:42:46 +01:00

irqchip/imx-irqsteer: Support up to 960 input interrupts

The irqsteer IP routes groups of input interrupts to a dedicated system
interrupt per group. Each group handles 64 input interrupts.

The current driver is limited to 8 groups, i.e. 512 input interrupts, which
is sufficient for the existing i.MX SoCs. The upcoming i.MX94 family
extends the irqsteer IP to 15 groups, i.e. 960 interrupts.

Extending the group limit to 15 enables this, but the new SoCs are not
guaranteed to utilize all 15 groups. Unused groups have no mapping for the
underlying output interrupt, which makes the probe function fail as it
expects a valid mapping for each group output.

Remove this limitation and stop the mapping loop, when no valid mapping is
detected.

[ tglx: Massage change log ]

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/all/20250305095522.2177843-1-ping.bai@nxp.com
---
 drivers/irqchip/irq-imx-irqsteer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index b0e9788..afbfcce 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -24,7 +24,7 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
 
-#define CHAN_MAX_OUTPUT_INT	0x8
+#define CHAN_MAX_OUTPUT_INT	0xF
 
 struct irqsteer_data {
 	void __iomem		*regs;
@@ -228,10 +228,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	for (i = 0; i < data->irq_count; i++) {
 		data->irq[i] = irq_of_parse_and_map(np, i);
-		if (!data->irq[i]) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!data->irq[i])
+			break;
 
 		irq_set_chained_handler_and_data(data->irq[i],
 						 imx_irqsteer_irq_handler,
@@ -254,9 +252,13 @@ static void imx_irqsteer_remove(struct platform_device *pdev)
 	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < irqsteer_data->irq_count; i++)
+	for (i = 0; i < irqsteer_data->irq_count; i++) {
+		if (!irqsteer_data->irq[i])
+			break;
+
 		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
 						 NULL, NULL);
+	}
 
 	irq_domain_remove(irqsteer_data->domain);
 

