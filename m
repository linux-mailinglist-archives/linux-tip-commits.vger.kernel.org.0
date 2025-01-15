Return-Path: <linux-tip-commits+bounces-3211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96EA11D1F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412D0168751
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5791EEA47;
	Wed, 15 Jan 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Au8h6WFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5V+rJIzx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2118488;
	Wed, 15 Jan 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932585; cv=none; b=cqHmvbLfyCHFF0jJK3X+dYUvFBqRVwY6tU25p1fpeZ4u17RiXyH7DuzeXiK7rh7wgQ5wida1m/jsPtG7lhFTBUtrxl2DT1vDdpf1kG/SMUS5L0HfJVwOmK0AXErVFXAzM6uaiMNFwcShfmKB59+EkzeyxkjYxDf1aOdhbuoNSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932585; c=relaxed/simple;
	bh=iSLC4BOOnoAgvfZ2iQIlDSFMrps6Krtl0lwkdsA/A1U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TDMsVZcTyt+1GLdUXFe6lagdj8VAjbahYAO2absknJaTZbeYvOvGd8FoD+OcEdZEOPoB1In7sWg1eZSt6auGrVICx7pTXbkuhTxi4LM76NZCVhUrZPnCFQmHGhh5Zep+QdtEHozgtgkF4+RffMHJeYbEpKiyu19fphPzuMDFEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Au8h6WFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5V+rJIzx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DwssOWoTa72TTtwaAsGA2Dash9LxFazueqDCXy8c2M=;
	b=Au8h6WFvgcjLbtenY14rMpcbOECyGZgcWRrViDj3UBGwU2wB/w3WQt1Y4LBUh+1fmhaTOI
	Bh9/9vcZ8wbPLmcNlUolGmuA/19Mrf5+yTaDd8jdz31UL6y6ZxPFjB3GuuC5S1eS+vyFSm
	RimIqsypNX9IqU4YNiohgoslI1Wnka66y6zegE4GveBNBT1vyqSflk/EIvR/3DHcV30sM0
	clw9H5AsEs/TT3+DG+dpsuaKeUivUId8uWXJG3JyVrzwMGgrCiyIM09rS0Qot5e/DkQeVR
	XZfLo9tEJx3W81cIcYJgmbnjIaGv6AlqkX7UevGbqD51ZU9h94OPF3ApB3QPYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DwssOWoTa72TTtwaAsGA2Dash9LxFazueqDCXy8c2M=;
	b=5V+rJIzxsGNnE7VQtq7OklaZILOm5q79fxwUGLyALaYwFJek6fcGW20AMJVEgJva3AC8tj
	Ylr6m9adHA6ZxrCA==
From: "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip: keystone: Use syscon_regmap_lookup_by_phandle_args
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250111185414.183971-1-krzysztof.kozlowski@linaro.org>
References: <20250111185414.183971-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257602.31546.8894556818847637622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     877c76dbb98b164f58d328c246ad33ec2db1030f
Gitweb:        https://git.kernel.org/tip/877c76dbb98b164f58d328c246ad33ec2db1030f
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Sat, 11 Jan 2025 19:54:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:47:46 +01:00

irqchip: keystone: Use syscon_regmap_lookup_by_phandle_args

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250111185414.183971-1-krzysztof.kozlowski@linaro.org

---
 drivers/irqchip/irq-keystone.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 808c781..37e1a03 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -141,18 +141,11 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	if (!kirq)
 		return -ENOMEM;
 
-	kirq->devctrl_regs =
-		syscon_regmap_lookup_by_phandle(np, "ti,syscon-dev");
+	kirq->devctrl_regs = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-dev",
+								  1, &kirq->devctrl_offset);
 	if (IS_ERR(kirq->devctrl_regs))
 		return PTR_ERR(kirq->devctrl_regs);
 
-	ret = of_property_read_u32_index(np, "ti,syscon-dev", 1,
-					 &kirq->devctrl_offset);
-	if (ret) {
-		dev_err(dev, "couldn't read the devctrl_offset offset!\n");
-		return ret;
-	}
-
 	kirq->irq = platform_get_irq(pdev, 0);
 	if (kirq->irq < 0)
 		return kirq->irq;

