Return-Path: <linux-tip-commits+bounces-3655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C574A45C87
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBAE16EE68
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7D216397;
	Wed, 26 Feb 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xm+cWQwk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sg1kjQBQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777721506C;
	Wed, 26 Feb 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567845; cv=none; b=Zk7DPOQFLdeDg4sNgTU1V6Chusrjm95VhfGll27ePgnUtf79fF8aGWGCd/msXH3GCeHifbvdNKlWoJhJhjWakIPjxsx9TxUxc+smnwz7ZqHuST46FZZvaAyHlR5tD7BHew3qH8CMed0CvqiYMV0cPfeX64jttBZNSnKiNGnw+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567845; c=relaxed/simple;
	bh=hVN5fXVdKrisGKReGfEhRX3FCTXy6OnYzYJoj36y5Ow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KrrfE3Els1IbQSnnR7Ghq67BbeSf+QpEXygCBY92q6JJlKyabkoNRHK/vhIv9MBAH6HyHyWSIv2IbFyfAPzVba+0VxZzfnE0heo0eqUimKbkdyh+iSkdT9IKZDnia5rBbMt8ikBAWUc51z+J8Qp6xosHs3UP+umHdaAlsjyQi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xm+cWQwk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sg1kjQBQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe5QTU/ScYez5PSwneOtg+SB7DJnQl30fb5Q4KEc8kQ=;
	b=xm+cWQwkg4IEPEEbP016UlWRlrxD93+jkfM7B6b9tlJS6VKgYfaQKvfCDHcKHVMINm4iIa
	AxmElP2OcbLL6JpKhBUqOcFAWRUTVYqa+rYjyhZPavAQXdNqVNYpOABRTHVrTfqHz/Dw/y
	em2TAePHPJpiOrw8nIxKC7JlJ2Cw+Vh12eXaSIyp/mX2YaZbdmbAPYniIiacFKbKp+7DRx
	OzD7Yol/mqcTRssrJ1sN4u/VLTr/YKinkhJNUdSjDgqS5Dtcf8H4sOkq3Z1p0ech8gIfYg
	ioHPB3OrhNs7hb38qKBwogTvFBOt3Xfx7WrZyZbHwV2f/8nF9DevQ2ZN2fWcLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe5QTU/ScYez5PSwneOtg+SB7DJnQl30fb5Q4KEc8kQ=;
	b=Sg1kjQBQq/7S0MyPAaYcsqK50TcPKfwSq+ZEyk7JcAc8VNTmnaT6iXYsqAFWnRqq8VlWq1
	wKmXgOeGMcauoICw==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Drop irqchip from struct
 rzv2h_icu_priv
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-4-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056784185.10177.17249088022341903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c56cab0c3ee063f30d1e53cca7614574e3c2cbd5
Gitweb:        https://git.kernel.org/tip/c56cab0c3ee063f30d1e53cca7614574e3c2cbd5
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:19 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:49 +01:00

irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv

Use rzv2h_icu_chip directly on irq_domain_set_hwirq_and_chip() and drop
the global variable irqchip from struct rzv2h_icu_priv.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-4-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index f636324..0573062 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -83,13 +83,11 @@
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
- * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
-	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
 };
@@ -390,7 +388,7 @@ static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, unsigne
 	if (hwirq > (ICU_NUM_IRQ - 1))
 		return -EINVAL;
 
-	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzv2h_icu_chip,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -446,8 +444,6 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 		goto put_dev;
 	}
 
-	rzv2h_icu_data->irqchip = &rzv2h_icu_chip;
-
 	rzv2h_icu_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzv2h_icu_data->base)) {
 		ret = PTR_ERR(rzv2h_icu_data->base);

