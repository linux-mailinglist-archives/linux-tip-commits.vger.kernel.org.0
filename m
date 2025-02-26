Return-Path: <linux-tip-commits+bounces-3652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E7A45C83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113533A7042
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA5215170;
	Wed, 26 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FfgH1sv4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kY7qxfkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9532139C7;
	Wed, 26 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567844; cv=none; b=SigD/fRdMjXezvnsduTykL+195Lv0oCcwgsFvZ52Ml7ULCDuHd42fnCHH/gc5uUCpU22FWVx0tiJ9BPZforZR+o/EcqZo4jxfMXO2lMd/i8VEovuVi1Qrx40QS8h5Ng+E+V7wDvwmTIaDZhWAKakOiGGQnBHWkZUWUKI26m1qKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567844; c=relaxed/simple;
	bh=oqfXfpxrvr0OU2IRiv1PoIC4IXuc5tVBF7Y4Tm3tc58=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pR0/mkWppE4QeBFBdMP+X+iJgyiM1RTE+PGEkT3ozXsXER/Ff6Aql7Yw8BlHeVEcZUACZTai7OYkBuVk2TLRlJhcdI1T3BWecMO37A7Kcw7d64ESavH+Q71IXT9vXfpbGnEv/gpZOAQ/F58usX4RIXJw8JuvHcDvmhrd1pheYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FfgH1sv4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kY7qxfkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhQoBX6muvswlAyWc4hFiQIz4dKPUEePI/jYaEeTosk=;
	b=FfgH1sv4CDCOGwhSsW66OWseThFeZGo+TDacSOx080dMPvknUQPh/5sg82pUz0xnbnNr4Y
	c/zZYojyKws/T8oXcr48kB1kAPMHe69o4jqqybF+y5XPRzZpgZQ2TVUa/pvVdT2DESWNFE
	WVT1lIgvTHveFD0XsXX/O9q+l1p6re0iuRAUNhhtTRfCgiojtgxXFAeSWNK9I5dGM6BwGX
	oi+KY5kCBaqpcL/S7ITPzKxYEHRL3pPxF+L7Pu4fEjbBXRylv99o+WfpAt0IM2ozHRHxrF
	5bzc1TZnAGM7HYfIpxqTdTg0OWzzFIEPti4fYWpLfpyTUASrzw6zh7WVW07aBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhQoBX6muvswlAyWc4hFiQIz4dKPUEePI/jYaEeTosk=;
	b=kY7qxfkKhgZur6O/HgF5++t2ZYAcrofFFIudbU2riZ06Lpfd+8GjP7cIp1BOQIMiBLh12T
	73+8uorlVsFbZ0BQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Use
 devm_reset_control_get_exclusive_deasserted()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Philipp Zabel <p.zabel@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-6-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-6-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056784045.10177.11051015421435876494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     ad773ebc6e41f0004487726e432b86795ae426d9
Gitweb:        https://git.kernel.org/tip/ad773ebc6e41f0004487726e432b86795ae426d9
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:21 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:49 +01:00

irqchip/renesas-rzv2h: Use devm_reset_control_get_exclusive_deasserted()

Use devm_reset_control_get_exclusive_deasserted() to simplify
rzv2h_icu_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/all/20250224131253.134199-6-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index d724f32..edae54f 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -461,13 +461,10 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 		return ret;
 	}
 
-	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn))
-		return PTR_ERR(resetn);
-
-	ret = reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+	resetn = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
+	if (IS_ERR(resetn)) {
+		ret = PTR_ERR(resetn);
+		dev_err(&pdev->dev, "failed to acquire deasserted reset: %d\n", ret);
 		return ret;
 	}
 
@@ -498,7 +495,6 @@ pm_put:
 	pm_runtime_put(&pdev->dev);
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	reset_control_assert(resetn);
 
 	return ret;
 }

