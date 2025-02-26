Return-Path: <linux-tip-commits+bounces-3651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBDA45C82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18D016FCC6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD4215166;
	Wed, 26 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GcUNrHaR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mhzlHAPe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8CF2139A2;
	Wed, 26 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567844; cv=none; b=Ws9bhEA0nAnHWCEH09Hxy2OzVxbwfgfkF2c6IxvfI7BkaXILkrSVhec1vEslsq0a9QghzM9qf2DhousaC5J5xvUicHWKgdYYVrQO3Qmw4tO27jkeUxYS5ZPi5spgy40U0NCd7h0qVKGAfidZ+cJBbwHT4kwoRQd8nyDsuSE8sHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567844; c=relaxed/simple;
	bh=8dBxGIqYlqnqgZ5UZUQ9rqFCZ0oTXzCihAABO56r43g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V92QlIc5oAF4l9uZ61wanr1FeUyTUB+OrgEmd4SAORaXDuJwW/h5VNqx2vcbIr/01XfpKyFnILZ05Xtof4uMpbPYCNjbOPQDv8vZrcSFx4V0vpKwCXklQMewOvs/gzANruMBG/wrdoSICeiTgTl5HDSoAjXFU4DhJfn8TU+/cC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GcUNrHaR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mhzlHAPe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lF0GpGVOc8MpElj6bPSB9T4tGuRWVTgQ1zSdhGvgGho=;
	b=GcUNrHaRxtH6mhrLz0Mklfyk+/DO5glvxkROWE3RX2LjZhdjN7hR48TFFhv0ovzRtyA8JG
	bjHU4NyFOf/DIaTTiJDFJBs0FSETCcumCL/tW3Gfl0gCdmwPwx0SXPpgMRpOeyl8jV/Xmp
	mksF8DXhgu4mnE+1In5/gCKyCOGB+C8I+uhUfLKcYnKwsIcnht1nWf2KgzpPrVneSDPeYe
	0sC/qiWwThfm7DVA1x9LZRTl8QmBpWFxrdDpBAJPQuY1kjj347a5fO6K2mx3qaoQlQ7MIA
	2eNAOwxpPGDoZAvHvBayLuss4fn9mcvocNgl4DKL4SEbA3wrPoxfXo+oz3Wing==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lF0GpGVOc8MpElj6bPSB9T4tGuRWVTgQ1zSdhGvgGho=;
	b=mhzlHAPe6O/XqwE5PrjYiD2seDU6RS4161U03VDlEJagfRWQDHPObD3K+nIIxanB1r9wUC
	U2GCN2gnAQCgJuAg==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-7-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783995.10177.8290609097099086622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     5ec8cabc3b8622f95de973c1a245245c65e3337b
Gitweb:        https://git.kernel.org/tip/5ec8cabc3b8622f95de973c1a245245c65e3337b
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:22 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()

Simplify rzv2h_icu_init() by using devm_pm_runtime_enable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-7-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index edae54f..10b9b63 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -468,11 +468,16 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "devm_pm_runtime_enable failed, %d\n", ret);
+		return ret;
+	}
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
+		return ret;
 	}
 
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
@@ -493,8 +498,6 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 
 pm_put:
 	pm_runtime_put(&pdev->dev);
-pm_disable:
-	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }

