Return-Path: <linux-tip-commits+bounces-2165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9F96C6B0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717C81C21F81
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24091E4118;
	Wed,  4 Sep 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLTnW/ps";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bp89f1+B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B831E2007;
	Wed,  4 Sep 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475698; cv=none; b=WSfkpTv6lJ75pg54qGMVryjGcif8PrXLg76pZLcgiuED4TKFXZMBOZ5IInsSW74E1G/Gf5KXwLxVeKjeGq2g9VixXvHVveZ4LpvxQxP2dIHBEu1OoF+IaiQQ5Aq+hDpRVmDzNQOrsLb1MS8O4AtHHPTqVYQNzoAbXz8OJTMlTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475698; c=relaxed/simple;
	bh=5h/NKLquMhEenE5o0FR6yszrtPYNE6CHZQ960teMt34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BylyPb6EgUe8XzafXPiWqs3cf8HV5NOoBhfvMamxvJhslRa+8BB8BAbtE5ADB3MPvcElg4QqoiGdOSNFuMIQqydksmCxMuK/O3XJx5BkynOOmrjXOA0Xa8oyb5yalzDjaW+ixB3dkmIuv2PgJ8Ff++9DS0cHeeTHpocnGdm269s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VLTnW/ps; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bp89f1+B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 18:48:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725475695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4MDQt2lHUWu1r/Vx0ML9deh7p4+BuBe+/ODamYCqGs=;
	b=VLTnW/psFaRjHT/hWbR4h1N53V97Jcyry+FtdyO/o3nk7yHO/GRRHYt4qfEDbe5cDugE9D
	jH6LYynMdnUy+vtEL+g4WCBRMX83NZhe1mJOCS500fk0123SbffmmL2tmLV/sZxZBcYdIW
	ZD5AK00C+ghmu5AfehZoINCcvy3x096o9Plpq9pBs6dGMcgcRdGDHyuvk6CS4yW2XGI8ET
	ZZihxJByr2gGr85hpTFLLiitc2HmzAT80cnz5P9cbyB1FuGGh79Ct6WAwoNWdxfdLb7re0
	qnsGLvN70k49pInl3n9tjsC7doimiPtfIQKr8H+P9d0NUUMcYYHxSB+PCs5IHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725475695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4MDQt2lHUWu1r/Vx0ML9deh7p4+BuBe+/ODamYCqGs=;
	b=Bp89f1+BKqyRP/vfVxZr0v8E+k+HTfUZ6GTxjGWv5TbklBmiuRavWBnRJklkk6Bql9Psjj
	y/McxrYiiBmh37Dg==
From: "tip-bot2 for Nick Chan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/apple-aic: Skip unnecessary enabling of use_fast_ipi
Cc: Nick Chan <towinchenmi@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sven Peter <sven@svenpeter.dev>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240901034143.12731-3-towinchenmi@gmail.com>
References: <20240901034143.12731-3-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172547569469.2215.8885468459533683081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5527b06c96715518bc58d1ebb29efc3653f66c5e
Gitweb:        https://git.kernel.org/tip/5527b06c96715518bc58d1ebb29efc3653f66c5e
Author:        Nick Chan <towinchenmi@gmail.com>
AuthorDate:    Sun, 01 Sep 2024 11:40:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 20:43:30 +02:00

irqchip/apple-aic: Skip unnecessary enabling of use_fast_ipi

use_fast_ipi is true by default and there is no need to "enable" it.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Link: https://lore.kernel.org/all/20240901034143.12731-3-towinchenmi@gmail.com
---
 drivers/irqchip/irq-apple-aic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5c534d9..8d81d5f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -987,9 +987,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
 
-	if (irqc->info.fast_ipi)
-		static_branch_enable(&use_fast_ipi);
-	else
+	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
 	irqc->info.die_stride = off - start_off;

