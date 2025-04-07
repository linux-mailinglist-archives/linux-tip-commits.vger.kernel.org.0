Return-Path: <linux-tip-commits+bounces-4719-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67886A7D6E7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E6F16ACA5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD84225A3D;
	Mon,  7 Apr 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgKIJXFJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRlXsgeh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A46225761;
	Mon,  7 Apr 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012434; cv=none; b=MmCrh5TFCi7je/edMLJ43BxIgSz7EPzG+m/xLa6mAy+JhKaufaK6QaX6K9urfKy6NbC8ESQdFO9nFCf6Gv+RYrK9jHodbW9cK2V+HGbH5dQeLB00LUaHaXuOvXb5uKbV3mIXluxfLlZLgMURnoSC/eQwad/WzZgHBf5Uvaz1Oew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012434; c=relaxed/simple;
	bh=80o0wpi7dZDZ5zv0QL/ljjjr1EOd48HgrLhWegmwSck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gYmnMTCatxaANcgbMjpbDy8w0jzGJ9lQdy5AeEIxaKYkEUFKIEtHaxmGobIByF58mx5lNhzav1RrHgeSAPnp3eTLcOr/5EDd7Kcn64Bk2mMlLLkmFAMLxC37ze42ofqaSS3/dG2hbDXtRqN9bk1fnxjK6ZU2cWPmDiGo7hlR0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgKIJXFJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRlXsgeh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b9MK+6Fx7C4cDe+LfgJq5bsmK4kbCO4erJwly3DPVY=;
	b=TgKIJXFJTca59nomAiV2kx9mmyvQ7h6+e7gTCKPGQBHzRLcl+sTBgeoweCxlG/IXCuD1Xp
	zQ6WeNvssrb8bSiCXtnMAzV5M3JoXYVGEjXiFPKp6jRVlV90cron1hCBo2OhqlHR3BSM/8
	gEkdm9fmwoImfsIyJWLl/LKQg5Hz3AOpaH5G6XWTOfWRBkigtaZlCiOxCX4B2QrcKMdIyD
	Q6mWDC1AXFBn9VJ9ftWj47j7F56CQmSJsEwxSak6aK9PFKRr8LKzgvCTnoBSSbkurhgNwF
	7xt8qcdp9Yxx+k7dYU5Mc5lkd5llMFA+Vx8ln4KNBS+zd46EPCLVWkMh/N1sFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b9MK+6Fx7C4cDe+LfgJq5bsmK4kbCO4erJwly3DPVY=;
	b=gRlXsgehdj8zqtziNOE4W95GRMR09ZugzbDQb6HhK8capJCN2aH+33Sn69hUjVKFF7cCci
	mX/gadLrwXmDkgBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] gpio: mvebu: Convert generic irqchip locking to guard()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.262678485@linutronix.de>
References: <20250313142524.262678485@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401243064.31282.13006765449893061189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9949aec666eb3e55522409f243fa6e873424fdc5
Gitweb:        https://git.kernel.org/tip/9949aec666eb3e55522409f243fa6e873424fdc5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:20 +02:00

gpio: mvebu: Convert generic irqchip locking to guard()

Conversion was done with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250313142524.262678485@linutronix.de

---
 drivers/gpio/gpio-mvebu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3604abc..2581fbb 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -408,9 +408,8 @@ static void mvebu_gpio_irq_ack(struct irq_data *d)
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	mvebu_gpio_write_edge_cause(mvchip, ~mask);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
@@ -420,10 +419,9 @@ static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv &= ~mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
@@ -433,11 +431,10 @@ static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	mvebu_gpio_write_edge_cause(mvchip, ~mask);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_mask(struct irq_data *d)
@@ -447,10 +444,9 @@ static void mvebu_gpio_level_irq_mask(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv &= ~mask;
 	mvebu_gpio_write_level_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
@@ -460,10 +456,9 @@ static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_level_mask(mvchip, ct->mask_cache_priv);
-	irq_gc_unlock(gc);
 }
 
 /*****************************************************************************

