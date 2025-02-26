Return-Path: <linux-tip-commits+bounces-3648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B4A45C7B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB0F16EF0F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6321DDA15;
	Wed, 26 Feb 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R34L+UF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oM4jRYmH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE851632E6;
	Wed, 26 Feb 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567841; cv=none; b=jzzWC1w1aYbZFIdvT1QrynJbQGF4wefOObaBWstrDd5kF597Ev/wLVWuzoVqLbrRRpsp1lF2mwVhSjLFoM/t4xCnb9iHA1Gso5N9kisOGz2kxeDQSg5Rl4+ChUmIoemAi5Xt+ivRPsesKX9NtvqG1pQ8X2jyq9otITviofZ566E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567841; c=relaxed/simple;
	bh=WPWJmWvlESOzVnK6HLxjwGY6tM9Py1I+GYc5pBgo1Rc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gGPR2K8HRIPSief7Rimt7UgGxzAr4Fkhj4VFVT9UK4S56pjMneAh0eQGt1IhnhcqOpGao0PxptmDxxNYbo1GS4hUX9ICbj/bErnJ1QD4qiraTAA/hnCD6gWa5gvib6nO1tXrFoeRBUMOL+/fQcDiW4xZFlcUk68v9+/18nmat80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R34L+UF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oM4jRYmH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j9LFd/hXIPuPpYlZXROWWZT+uKnE8tdMeBw/miXAiI=;
	b=1R34L+UF9uKAAxT9sQi+ZivHAApdF1rZWVhJ/kt8JmbOLk+HMwjRPDY3Bo3Nt/FkJPgst3
	jlLueKeVzV9xTBWyEtXMWmFwCbQ6AuKsr+fe3ey++WLt6TkwxuPAdXznuv/4yA2yar35vq
	rHLk7mPU1+Psnay+uKH9b9swAglcD7TVeGh0IizEyovRcVh+RS1KyjjFrlmVGi8FP59ilA
	qpV4R2tZ27X3ttWIFCyrVJ/w/TE3u4LkLKNyvAJQiZfcyhdVojmh0ZcFlfFIIJWKTe7/4f
	HoUAhYt4+5apaL/L1P8ahppaFT6DR7hIq9P0diZH82dlDi/uLrfqziOAhfJk7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+j9LFd/hXIPuPpYlZXROWWZT+uKnE8tdMeBw/miXAiI=;
	b=oM4jRYmHsh9LYbwpWBtIgIKT9Y6thIKYTWurG0/6f9bugWD9iECa4VJDly6FoEP2FQXcdU
	PnEqtGua7tCSFBDg==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Update TSSR_TIEN macro
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-11-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-11-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783807.10177.275390317106058228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     76c3b774734feb8224b78721e0c67a54760a75c5
Gitweb:        https://git.kernel.org/tip/76c3b774734feb8224b78721e0c67a54760a75c5
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:26 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Update TSSR_TIEN macro

On RZ/G3E, TIEN bit position is at 15 compared to 7 on RZ/V2H. Replace the
macro ICU_TSSR_TIEN(n)->ICU_TSSR_TIEN(n, _field_width) for supporting both
these SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-11-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 98a6a7c..8d0bd4d 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -66,7 +66,11 @@
 
 #define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
 #define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
-#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+#define ICU_TSSR_TIEN(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) = (field_width); \
+		BIT((_field_width) - 1) << ((n) * (_field_width)); \
+})
 
 #define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
 #define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
@@ -153,9 +157,9 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	guard(raw_spinlock)(&priv->lock);
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
-		tssr |= ICU_TSSR_TIEN(tssel_n);
+		tssr |= ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	else
-		tssr &= ~ICU_TSSR_TIEN(tssel_n);
+		tssr &= ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
 
@@ -314,7 +318,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	nr_tint = 32 / priv->info->field_width;
 	tssr_k = tint_nr / nr_tint;
 	tssel_n = tint_nr % nr_tint;
-	tien = ICU_TSSR_TIEN(tssel_n);
+	tien = ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 
 	titsr_k = ICU_TITSR_K(tint_nr);
 	titsel_n = ICU_TITSR_TITSEL_N(tint_nr);

