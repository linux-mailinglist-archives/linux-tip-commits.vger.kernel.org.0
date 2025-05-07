Return-Path: <linux-tip-commits+bounces-5430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6322AAE111
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7161BC81CA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1128A70E;
	Wed,  7 May 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1PzrAUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMpSAuUx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9028A1EB;
	Wed,  7 May 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625455; cv=none; b=ukpqCwHtNhAlIb85TFnfNeYittJGBCI9iGc/uCsmiwyyuV7ngpg14HCvTT7bkJVh7TbIpIk3ID/6WHnefC2UthRbmpzrT4JG/cLEoIEhZoSxGurSLNPsLiHP060LJwPZXYMT+cMUtKPtQyw8Vjmh/2lb71BYc3HFViUoR9eL0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625455; c=relaxed/simple;
	bh=Wjl+SkR/SxX+AIVcaPgLdJmXF4a9sNBooxH+C3+DTLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YkQbvfHjS08tRdjvWr1WGiucZ7jzehcGcnQHN915GEob5W97EH8sgcTxZjbuuCt5tzIcchbN6UB5HF5CyJFbgMcCAVUepE5IztpMEyRhNaU8aUOEOlgzrjmN8/qsmr6mDvRC8LmQ+l2wLMIt41sreLFjvLImb4jKmuZmEUQu6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q1PzrAUo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMpSAuUx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTlDhgqcZYO6xusiJbtG5I2fWScFtxk631KHpFIWYs4=;
	b=q1PzrAUoNuWO1FgpGf9N4y/iXOjkc+7djbI11hCaETa7vsDivLihffvyMSLS06d9u8aX9o
	WzLRBbeqO8EM5J1m+yNRPJm4NgpDIhqWiqkNuH6vjzBD1C1Pl81DaSgqXYMoO2Mg7fw/v2
	9pccvbKXGX7xio06MY0/WSqE7bntJukMkb2VZi9lqOidYWt1vTSFFEF/PH1kNnDf1cmWN7
	uFKSTy/eSx0o1m/Tdx936PSvjnNTHQ0N9PeycWKHSwnF80iyWhnZRY/dtBACozvVl2NLVt
	5py5djqXE8KuliLu42HRCcNYl+ZPY5DlYHDXscITc+yBTr/vyWsCHbgDgp46Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTlDhgqcZYO6xusiJbtG5I2fWScFtxk631KHpFIWYs4=;
	b=GMpSAuUxZhqvo3Gp8YCvxrBNMC2xZMEPu6Uf5T6pq69Ck6qiKo6UzTJCUGxHrfBXLHCm5Q
	h9bY027q7OkUHsCg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpio: idt3243x: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-44-jirislaby@kernel.org>
References: <20250319092951.37667-44-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545147.406.8512192227619791789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     0b2f024f813c8996500636011b848d1bdedd8990
Gitweb:        https://git.kernel.org/tip/0b2f024f813c8996500636011b848d1bdedd8990
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

gpio: idt3243x: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250319092951.37667-44-jirislaby@kernel.org


---
 drivers/gpio/gpio-idt3243x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
index 00f547d..535f255 100644
--- a/drivers/gpio/gpio-idt3243x.c
+++ b/drivers/gpio/gpio-idt3243x.c
@@ -37,7 +37,7 @@ static void idt_gpio_dispatch(struct irq_desc *desc)
 	pending = readl(ctrl->pic + IDT_PIC_IRQ_PEND);
 	pending &= ~ctrl->mask_cache;
 	for_each_set_bit(bit, &pending, gc->ngpio) {
-		virq = irq_linear_revmap(gc->irq.domain, bit);
+		virq = irq_find_mapping(gc->irq.domain, bit);
 		if (virq)
 			generic_handle_irq(virq);
 	}

