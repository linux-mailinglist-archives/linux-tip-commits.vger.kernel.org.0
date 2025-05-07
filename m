Return-Path: <linux-tip-commits+bounces-5334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E460DAAD952
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B552B20DAF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BAB223703;
	Wed,  7 May 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPvFiTQV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ctiak5eR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C8223DC4;
	Wed,  7 May 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604677; cv=none; b=jQT3N7nVgjz67aOGQZB+L8oG98aCE5TyYnKu0ZzEPtE4y3b2up6dQI4ymELaySKPpczUthg6eSQ1GwF6AjcOfL0XSo6EfGtQXY7WYC+dIU7U18Blce5I8MPGoJPsAwTximqxpVQ70QXBTmoLk8IB4nqwfMWtqZsKfTF1QRBetQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604677; c=relaxed/simple;
	bh=r5Hj/BHWdDOxOsfoYC1YzmzhE/nqgI+SDq865bZKm+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WLNV3VhgdOIHLFyt9or6dPbkwwGqP+uN/l7cwOhNTnkG1AjDTbbglUrs5KK/b2ovkahJPVE02k/LW+WQyiXPZ3Gf/LxvwEKNRTry7mfaC9eyVdk39wmiryP2a3Lu+kFDIITWq6KC8k9p1146QNogBdMvRxGbTyTbRjj4sYDDRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPvFiTQV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ctiak5eR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwWPnr/G7BEf2VR+QBd45nQLBEPFvMYhPigaT5FMRnQ=;
	b=LPvFiTQV/yk4DravJSEDfunSU8i2oe+xC54WgbPrmUpkbc2g9gMK/qjCJvUuwP9/pkkGEL
	KKxlx/K7Ad+rRR0YLhAUekOXe6RHtKfUgb9XY36701k+RidLP7eP9WvVLYCuK+wYu24Ioa
	lDWTCirY589eqGHNXQ0cp2jjbX8YiFBXMbhEATo1yieNGepJM7qpsf+yjCvSfb7PpT0sAU
	e/+5nWzHWA92JqLUfZhqnsEb2HY2eSBKvAviBC5kGBaeMMbFHZR0st+GYC1OjR+VIxQGgM
	cMkepBiBEQ3CIR/IgOTfGf8RXApgkYChtmokABa2g9ZPUvn9eYGFHznZLx5pBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwWPnr/G7BEf2VR+QBd45nQLBEPFvMYhPigaT5FMRnQ=;
	b=Ctiak5eRCYtfgU3SwyJ2z8S9DBAwNgvyCXkL5yOdgShf3xbgIUdHBkOS2rMNotx6T7YOqR
	bUk/2jLqgDxaGxCQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] pinctrl: keembay: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-48-jirislaby@kernel.org>
References: <20250319092951.37667-48-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660467275.406.16503368364428522592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     219e99b99b848f20eca692cf663c25178c15dd3b
Gitweb:        https://git.kernel.org/tip/219e99b99b848f20eca692cf663c25178c15dd3b
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

pinctrl: keembay: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250319092951.37667-48-jirislaby@kernel.org

---
 drivers/pinctrl/pinctrl-keembay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
index b693f47..0d7cc82 100644
--- a/drivers/pinctrl/pinctrl-keembay.c
+++ b/drivers/pinctrl/pinctrl-keembay.c
@@ -1268,7 +1268,7 @@ static void keembay_gpio_irq_handler(struct irq_desc *desc)
 	for_each_set_clump8(bit, clump, &reg, BITS_PER_TYPE(typeof(reg))) {
 		pin = clump & ~KEEMBAY_GPIO_IRQ_ENABLE;
 		val = keembay_read_pin(kpc->base0 + KEEMBAY_GPIO_DATA_IN, pin);
-		kmb_irq = irq_linear_revmap(gc->irq.domain, pin);
+		kmb_irq = irq_find_mapping(gc->irq.domain, pin);
 
 		/* Checks if the interrupt is enabled */
 		if (val && (clump & KEEMBAY_GPIO_IRQ_ENABLE))

