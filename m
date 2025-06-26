Return-Path: <linux-tip-commits+bounces-5930-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED1AEA020
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B97E4E0A57
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3F2EBDC0;
	Thu, 26 Jun 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LYO7rRiu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tK3ZVWAa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50C2EB5CD;
	Thu, 26 Jun 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947193; cv=none; b=s9Ca7+FEiBrQli5VpftIKUn3JgHsC6vWVhqwnIu6HkUNKhN6QV37A7wYoXuCtCyiCAdOjBkj0UNYjDlbZJ7SMoqaUq4yy4wOGMDMey83kJqtBQIinjfJfEVCZ45hlmPhfUR+u5rMVLmJx2yGO/C3XyqdcHIM/Jh9Uv05dcXd5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947193; c=relaxed/simple;
	bh=8xEBRFgKpXPJaHnjbdgu6yDLQkTBnlPV4BkR1U9A9g8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=agcst8ttAzIeKDP7VJrhMilCcqlmyStPB04z607uDGlJQzQjUDFkOVCVU+iK4AUKM3yYnJDsME/jaZju1mlPcKkfU9vOHl5muH1Fz7jl6BpmITPMMFhx+6lhhMFjsNpraJWLR2bAsj1qkQ5srdBKaGZEoaREM2sRhziJMrCfFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LYO7rRiu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tK3ZVWAa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7CFvuUp7q2WG6Jo0F0RBzM9BmsLgKgd2kmHTjQIKU8=;
	b=LYO7rRiuAhgFKQ6RzTC7Wlt5XNE3vkf5BDnc3E0oleClptHZdYbb9CS4oqCbhjy6iAXvmw
	azDqBh6TOxiihBaeKkTRHZOIiH6/uUR9ATSxjZovd8HB63MTtDXsdruZa81fp015CtPrjU
	9V4rGcLGAiJhynigXtDQpoSahgyFA61OsKAD30ITdOnHSGVPhlXvYSAV6+4stLpLF80FnE
	Sp8VeRkgVSnufk51W4nlvbMeFkyzrKDwUWX+a/mH0xx43Axc2klEuVLBd7cGgiOd63oBQV
	5GitCvW2rhL25F8Lid4rEpk79Vg7hdnVuK/KkyUmpOJNBko+23189hHug08Pvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7CFvuUp7q2WG6Jo0F0RBzM9BmsLgKgd2kmHTjQIKU8=;
	b=tK3ZVWAaHI+uy6i9Sg88eRAFiN33CQgpjMxZ/K+6eniOy5F9HD+YBUBnbvxUB523lF7ffR
	uD7uBe2qIB+5UsCw==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-aplic: Use riscv_get_hart_index()
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-3-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-3-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718959.406.7430394547970625377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     81f335e10605beda222d51d348a1ac058d4bac61
Gitweb:        https://git.kernel.org/tip/81f335e10605beda222d51d348a1ac058d4bac61
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:06 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

irqchip/riscv-aplic: Use riscv_get_hart_index()

Use the global helper function instead of the local implementation.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-3-vladimir.kondratiev@mobileye.com

---
 drivers/irqchip/irq-riscv-aplic-direct.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 205ad61..c2a75bf 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -219,20 +219,6 @@ static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
 	return 0;
 }
 
-static int aplic_direct_get_hart_index(struct device *dev, u32 logical_index,
-				       u32 *hart_index)
-{
-	const char *prop_hart_index = "riscv,hart-indexes";
-	struct device_node *np = to_of_node(dev->fwnode);
-
-	if (!np || !of_property_present(np, prop_hart_index)) {
-		*hart_index = logical_index;
-		return 0;
-	}
-
-	return of_property_read_u32_index(np, prop_hart_index, logical_index, hart_index);
-}
-
 int aplic_direct_setup(struct device *dev, void __iomem *regs)
 {
 	int i, j, rc, cpu, current_cpu, setup_count = 0;
@@ -279,7 +265,7 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 		cpumask_set_cpu(cpu, &direct->lmask);
 
 		idc = per_cpu_ptr(&aplic_idcs, cpu);
-		rc = aplic_direct_get_hart_index(dev, i, &idc->hart_index);
+		rc = riscv_get_hart_index(dev->fwnode, i, &idc->hart_index);
 		if (rc) {
 			dev_warn(dev, "hart index not found for IDC%d\n", i);
 			continue;

