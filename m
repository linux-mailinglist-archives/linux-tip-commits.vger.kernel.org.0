Return-Path: <linux-tip-commits+bounces-5279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12514AAC5C7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B351B4A11F3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AA2836B9;
	Tue,  6 May 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUiXYflR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlYrRsDw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A2283146;
	Tue,  6 May 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537625; cv=none; b=obEVstBI1oMKwkb/8WIkjqGHPvPX0tf4iJPt2+hxRp+OgW5eOaRo8uMpgXYytZb2sTfTZqLahtMclO1dXaO2jxNKcCgM6jdYfunYNUp79KZjItzhYfkycSdAB5mmI8n6azQ7gAL2CCS1zBJDy2Qub6lsYcNiQrP4v9z7XxNIK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537625; c=relaxed/simple;
	bh=HwBbb7v4CaC60xJfhOg3/HAuVSHhZbUf87q6qLBS9OY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b0h9sQ8lpblferfc5Dnualy4V5FEgM+lsdx692fIptCSUaEJXa0TQS+8vgh+Lj6q8uRQg9FK1ezaNzsOiKpkFcJpUovEp3UE4vKK/w2dy/XHcuTe0hHYvqitwVWBQIrPskEsPqYMfnRi0bDPzO1OSBcPGozDWehWMqzsLC/uj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pUiXYflR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlYrRsDw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+98RKLOUkH/JyykvK+D1V53xgu/BjR1TVWGWwyh1Yew=;
	b=pUiXYflRWzWU7OeRrXPHCKg94CRF6doWSDLDcskNW5HCB3msmy83x7J97a46zizfzNk7cQ
	xUj/Qkx7UUBv5wMrbfIO+4QbxpmFQC0/wD4d2bW3ny/gHhnNiier5XyLD2W9aaFcYb+JQs
	F7HT9WdVO4uqSnJzln1u0FaJnC1OODO2kkPuY8OOqPm6kKS1xCxjJG0lTq2MEH4dj2DMbK
	TaED4sNCaUj2NIPFFEsUT+kEqPQuX/wVz9XhjOw5VauYzZsrU1KEOk4YymlVjESMt1WSNM
	qclAx1knt0Z1Iq22KMQUS2NPEfCR/RW5xBe/skZYlnDT0tbt95a4biouOMq58Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+98RKLOUkH/JyykvK+D1V53xgu/BjR1TVWGWwyh1Yew=;
	b=LlYrRsDwwcySwMualjPJBKVO2vqlr3E4WYP8ab0RwItV0zxWglzQap6VIsRTktOAoTFBSU
	6FUsiiZjqBK85GAg==
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
Message-ID: <174653762145.406.2415571167933957224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     709457a648ec7e6b2513b948b1b592c08c00d3f6
Gitweb:        https://git.kernel.org/tip/709457a648ec7e6b2513b948b1b592c08c00d3f6
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

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

