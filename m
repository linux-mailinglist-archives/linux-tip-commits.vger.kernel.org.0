Return-Path: <linux-tip-commits+bounces-5109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B423A9AD68
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D6A194290A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0B238176;
	Thu, 24 Apr 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWaJCOHb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlguRTku"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D4237717;
	Thu, 24 Apr 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497706; cv=none; b=AaVGk4mt8tUJI8HXA9pPYBYnjS10Q4qRj+ry8BDHX0VCNFwU1Ybxo0I9rrL/Cs8yZXbCtZRKuAQse/NaiBG4QGToVb9AOj6rQj4y9wN0tTuApBcZATr7Eio35IIVHjF/lcDAp4Xdkh9hqK7E+BC5DBWAZJp7I9tTJua1pXh3lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497706; c=relaxed/simple;
	bh=K2NLUBHZlL+7AijALPnd9Jx9CbkjgPESOoSS1l9Ps9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DDHspqeULxfvdyhc7/5ozMC8nhKk8rsqWLDjGYmXC3Qzwc5qb6OIwTBAMADuMG7myfxiqG2AZEYLmC0vTFuHUJ9WW3q9mEKMxyn7fWkr1CioGm/3i5ZBet39eS+YTBPVTMM6mkff4pVKVRzM/3/WmRmqY40VT9yISDdaFdz9o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWaJCOHb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlguRTku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 12:28:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745497703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6iuPzbzgFuh7iHgwikBziSzepPghfh1TZz80YBPuu0=;
	b=JWaJCOHbMGaGnNYL5haLPH+9cwA3Iui6JgMH6ZbourWSQM4RyIabAvdXMNNN/kGl9UBeWe
	W8Q7r26GOEzTlbtO3OiBtoGK29wfUhD6ddeX8XORjqYnW/UMtuzae1SavOwwTbGofQwaP+
	oDNvl4/tFVFbsASnakpxmJktdMMsLnyuQGTXeqgKeSFRVbFHfepjz+akH4qwXwfWWR/c/v
	63LX7GyTPVQpTB0dyPp0QDkg4HKvPqZsVYoe0eai5gBpvRV/yK6eFM3cIOfiiBeRZIc74V
	ohb3WSv2Zge1L9oPRTdABaZKc/lQoIemwKH1TclBo/GEn6M9pYsMimC1TZv5gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745497703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6iuPzbzgFuh7iHgwikBziSzepPghfh1TZz80YBPuu0=;
	b=MlguRTku7uLRp9kAnvPWa3s6VqzhRDJWB2UtQ+NN8FDY+kb+b+DKPEMQ2sfsmqxoJPtLKD
	pYqXu4jcRu8t3eCA==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Fix wrong type cast in
 sg2044_msi_irq_ack()
Cc: kernel test robot <lkp@intel.com>, Inochi Amaoto <inochiama@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250422003804.214264-1-inochiama@gmail.com>
References: <20250422003804.214264-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174549769785.31282.8000166567328581653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     76b66e8c9d159eb3d1699e0fa80ceacf9a9ae627
Gitweb:        https://git.kernel.org/tip/76b66e8c9d159eb3d1699e0fa80ceacf9a9ae627
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Tue, 22 Apr 2025 08:38:03 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 14:22:09 +02:00

irqchip/sg2042-msi: Fix wrong type cast in sg2044_msi_irq_ack()

The type cast in sg2044_msi_irq_ack() lost the __iomem attribute, which
makes the pointer type incorrect.

Add it back.

Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250422003804.214264-1-inochiama@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202504211251.B3aesulq-lkp@intel.com/
---
 drivers/irqchip/irq-sg2042-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 8a83c69..a3e2a26 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -98,7 +98,7 @@ static void sg2044_msi_irq_ack(struct irq_data *d)
 {
 	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
 
-	writel(0, (u32 *)data->reg_clr + d->hwirq);
+	writel(0, (u32 __iomem *)data->reg_clr + d->hwirq);
 	irq_chip_ack_parent(d);
 }
 

