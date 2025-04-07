Return-Path: <linux-tip-commits+bounces-4720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5062A7D6DC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060EF18839E1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D2D226D09;
	Mon,  7 Apr 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nMhfPit";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lgi59hee"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78164642D;
	Mon,  7 Apr 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012435; cv=none; b=cHafAvr42NPF9K2yfKYNay/l+mWBgg9xjMW9kCIdgu99nFrm1eSLnSsUk+JpJMEH5Oym90Yo5M+gF/HxAOifKX/zFQq87YLTsxadwfi7b0hKJjPNoYtiYuWuWOK1moK8e0OI7++/+OtawSvhh+W91vlfskCutJzwGfQziuT7HQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012435; c=relaxed/simple;
	bh=FbOgH1D07BMDuKtg3EnFRzbc84ghYkAjqSKQjginBZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZeDWeO52Rux27vwU/wRac+b4HSMkFnXJh6aQmQ7htuMGR6DiAYo4KIdN7WiBuBJW51QuRrm65q2PbGzdbmPg5oHlI5krjQWQoBm2w7C2O8Arg/bruLY7Qb2kGMeVwlgLbN2JJsOW17u9FRAAHLc2elphq1pWLeWMDiEhDZ7zc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nMhfPit; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lgi59hee; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJnP7fiDlWSALe1AcbMKnVNM6p8+E+ki4OutLoNi8gU=;
	b=1nMhfPitG7rxdvCv5eGqXbGdllTJ7qKCgAZKOfTSfgoUNc9nydkp2GLDonoes+YuVgRKJD
	ptta4X160D6jnkwTt8Onqf5Nw9CuIYg/fRADpWxMpeHb5IFasxYXKrGngFVmzDlMN8Nh2m
	UPhlB9BqiA2uinqd3T8i5sfVdXY9gPuKkaVQ+u6b8feVtNvlXY8IukYnFfJeN5pFVJFWWP
	R5XTpzd2LYG/ILY50kInyy7CNhYfFjW+J+yyZesFbDCOPXccg3757OOzXlCIUwjaeXOdip
	27CpdjHtzwRmYnIQuGLKCBXr3/YB2oUD5L7ELaNdXnJtB8p2KDGtgEjvwv+Vtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJnP7fiDlWSALe1AcbMKnVNM6p8+E+ki4OutLoNi8gU=;
	b=Lgi59heehwKYWU7aXuZauugRMHipNmW7n1n9H5BdLY2Ir0XBw6+oCBsqwI4jr+xO0/bK+L
	vxXQVQmGkLziLkAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] ARM: orion/gpio:: Convert generic irqchip locking
 to guard()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.200515896@linutronix.de>
References: <20250313142524.200515896@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401243126.31282.8050622441540714138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     73989a38268dd80f7f2c945b8e3097b7c9ee95f5
Gitweb:        https://git.kernel.org/tip/73989a38268dd80f7f2c945b8e3097b7c9ee95f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:20 +02:00

ARM: orion/gpio:: Convert generic irqchip locking to guard()

Conversion was done with Coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250313142524.200515896@linutronix.de

---
 arch/arm/plat-orion/gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 595e9cb..47d411d 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -496,11 +496,10 @@ static void orion_gpio_unmask_irq(struct irq_data *d)
 	u32 reg_val;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val |= mask;
 	irq_reg_writel(gc, reg_val, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 
 static void orion_gpio_mask_irq(struct irq_data *d)
@@ -510,11 +509,10 @@ static void orion_gpio_mask_irq(struct irq_data *d)
 	u32 mask = d->mask;
 	u32 reg_val;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	reg_val = irq_reg_readl(gc, ct->regs.mask);
 	reg_val &= ~mask;
 	irq_reg_writel(gc, reg_val, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 
 void __init orion_gpio_init(int gpio_base, int ngpio,

