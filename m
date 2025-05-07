Return-Path: <linux-tip-commits+bounces-5427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C6AAE10C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BC9A05BC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C328A1F2;
	Wed,  7 May 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgCDLJoM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gs7WbrTa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27E7289E12;
	Wed,  7 May 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625453; cv=none; b=W5GgztgUGunoG8KncOYE/wim9cYwCxoU0fiz2I0gV5+Jf/ZFprCFy84SVRPwBZyp1/C7i+o+5XkjtKNusMA79Hd3tdu9KlA4yUAj0REDsUILZwaTaq/rZRANpQ74PthBIbUSQVkEjXM7yZwaoKWpmyl5skByr7ZCuJr0W1jgqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625453; c=relaxed/simple;
	bh=LNl4AV2GBai4uPtVa5PfE4upJ9/Vr2dXpYIi6NbwmJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kxbtayHghCvqzNdUCUpfY91RHg9LfWeMNpQfAW3PLasc/6m++whSDAiDbNNb4O/6fJjU6w+QM/naeCaL5YIV9C6L+7Wnm1OrwqWIonjkn4+vAJHJM8TrOaB9klAgYj47sK7FrdYeXovaJs1nYcJI8gMfFD3siMOI8ESJ3WCdkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgCDLJoM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gs7WbrTa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxgLMppyu1aYGYg8WD00WgeQaEaFdmztN1gy6brFHpk=;
	b=TgCDLJoMNpNESwHJUwbyyokXybjpJm3Is+YH0RtWk7SQxdqNI9V0Fmna6qCl5grFOFDaQK
	wno9ptVCVdLZAbrJ+NCylc0T5oKNAh7s03jlr+xbzRWnIQLWwxAQ+8Ivz9K8IpPyo2+WvM
	QEEInDrqTzXvTdAE2wjSEPZEqXc4rUqQ4g8r5DJ+gZ9uQIQCh1FgvS1s8RqvcyYqhx75P3
	ROqJn8kLcVMvL98CaPDbgPZDaObTK97IFtKkw8vjseqHqsH11afmghP+YI/1aC89HZuldR
	wWPhBFdj0lp2wVoEhb7A6Tkt6MplSp5gmPX24Oe9B8IhU52GzBmxXPCgo7BEtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxgLMppyu1aYGYg8WD00WgeQaEaFdmztN1gy6brFHpk=;
	b=gs7WbrTaagI8cPLYzK1jBwuM3zh+J5MeeZPAbKXftWwCNiGmcNgl9j1Jp+8ANZuuLxIYvJ
	Vn5257SARg53nrBw==
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
Message-ID: <174662544939.406.13642716952371563212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     377c6a8184bd97b6ea7c6a15ea6561008d710b15
Gitweb:        https://git.kernel.org/tip/377c6a8184bd97b6ea7c6a15ea6561008d710b15
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

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

