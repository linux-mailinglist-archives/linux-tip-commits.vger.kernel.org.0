Return-Path: <linux-tip-commits+bounces-5277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38AAAC5C2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B452267A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737528313B;
	Tue,  6 May 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MaYXvbZZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="//zjqz2u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907E281530;
	Tue,  6 May 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537623; cv=none; b=AHBGwM9+5AkVSP7R4UJ9wvq5jQjBLzEae+SJ3dVAhsxIe7MVsfNvg3OtnVsbEklmXRHJ8x5993u8011E3kMIhYqy1LmE2Ft6kUh1cBYfrZVzXAcy7UM2ZtzfDZ49jTxheFLEQ7SgzCNQ+6B64FZHfYUgmLCXzdBF20GlkJ3chjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537623; c=relaxed/simple;
	bh=3+W+j+3mk/rLIjQiO+HnDv1V+T57zL+smdN0FbY0l6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XaBrFCaoAOR3TGDzjdyi1HD4It7fLMnHdEgfdfpsh+uf3brK/9xNGMl7C0hZDSE+VSQ4/4M5itfO4wiRSUKOx81yzNLFxAN3MbXxvDfKnppfcvKBzXMSL1BsWWo5qUY1dF6Iw7isqxHm2zGWUFSeYoOrIFko2hlEPuuwN2eqfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MaYXvbZZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=//zjqz2u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNacRRJW1fCdzy+Seiq/T1c/hmPHxTW93hwErx9ahtg=;
	b=MaYXvbZZJCGxNm8SjVo3b4RCAGvsWQOWcg9nABsQDludQJx8yUz3C1eFX0H3oJYjMkavxV
	6sfEXNCKUokbTBimDT3w2qYja77LkXfDHVlt+YyRPhG12ZGiFYnPo++xBbEu2ZWBr48NIJ
	T5saP5pqj7DrRZitxa2btdybuPZcX1H68MxeZg6bPWSNWKmU8fOB4mKbjPI+7A19lg+zb1
	kfzBnpoDkmXMkSDpkFq6XFF8o/rrM1ztXOpfpVBBz7sf3TTOEOYzOzZjdDJkas1LpnYDIk
	IpBZGdlLNAquh2gPcCfbZz7r3hRtRbG88tkb5L9JJERmcr/m0be+7DYw9QTR3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNacRRJW1fCdzy+Seiq/T1c/hmPHxTW93hwErx9ahtg=;
	b=//zjqz2u723bFaGrA8VhXEzuSo6Jkx5LW0zuxpDudIbm50xPykRCeRo3w9Mh/gc5IAJhbt
	WU3AOSSZuxJrY3Bw==
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
Message-ID: <174653761941.406.16332252789419569622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     159111fb9adbc45515bde074969ef651f531c5cf
Gitweb:        https://git.kernel.org/tip/159111fb9adbc45515bde074969ef651f531c5cf
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

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

