Return-Path: <linux-tip-commits+bounces-5593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27DABA3F1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FC8A258F7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA67281360;
	Fri, 16 May 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snPfyLpo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIUh0cWb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9528033A;
	Fri, 16 May 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424248; cv=none; b=TTdDoshQgQ+ZPXctAyuOXFL4cz+kec61NWSA7vK8JllxkKxSm3JefuPAhCYnidvV/rN2go4r4dmX/jde4Ub+jgle9GlsG1WWyVWah4uuxfWB32Ql13qp/ccdr+QbK7pjsSwo4Pp37IxxdBNoswAjaRTvg3P04r2NHzkQ6AK2/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424248; c=relaxed/simple;
	bh=lNEidTHnndoWq6kgkrZHpqowrens4HaroSjMpwrVTJw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pEIeFBAX04cmnxAIPHKgefH7garblogpQDrMvoBpNcxem/uU08L8werOM5G5pD1FBavsoFEvL61uuTjaWm+62GX344R5M/RcWPJgYGebVU8C17ZeEWSMXUZkmBfS2TbC+WIiFEV4dn5aHYYDUKHtBlIWqw8pMZeKy4Ju6gJCLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snPfyLpo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIUh0cWb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjzkDM0rSawGX2IBu0Zw4tzKm8jfZH1e7y8Mhll+wmw=;
	b=snPfyLpocVBVy51b5Nltt4yoL1gOGk4BTpDjZov3pB5sylNyNnAlY53SajFO4jiBR1mrvz
	UorANZM2M+N7Is4TI4dEpLU+LdDuymkP/V7uagUlMi5Ec+N8O58aJLJ5UEKcNRrdUGcgpP
	lvT4hD3yVdMkLyx3GbwWSADsUkUf73lf7ghRezeBoH7gcRHqtU1E7cGz6CX+9cleDEnZMQ
	Y6ExTneoxCMsw+65FWe302GfJ1jhXjr5vx4DdXkoM3OQLGHXPadu+OoU3I/lBeASigoy20
	lXjUh8N35Lcmf6BbLPs5gjMsGJCXGlrO4jm7oE6Uo7xHOL0VbfMiPLZIjCVozw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjzkDM0rSawGX2IBu0Zw4tzKm8jfZH1e7y8Mhll+wmw=;
	b=aIUh0cWb9PsOsQiHiOlVzbSK20vY5N7MYhOdr9n2JhRZPg824KjrNECyGqPCAmLo2dF9GB
	ueHRNS/Z/QXHd1Bg==
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
Message-ID: <174742424376.406.10177896946396940724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     609f900ad6093af6f97a313c4bacf4ca3757db4a
Gitweb:        https://git.kernel.org/tip/609f900ad6093af6f97a313c4bacf4ca3757db4a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:12 +02:00

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

