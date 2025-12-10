Return-Path: <linux-tip-commits+bounces-7624-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3DCB1C70
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 04:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8673014DBC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940B27A469;
	Wed, 10 Dec 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b5IT9XdL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3XNuwKKl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BB1B87C0;
	Wed, 10 Dec 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336500; cv=none; b=liYXbQkIdIy8pId58wpY+Y4fYAO3zz9DCElE+gBGXgyW21SAtdCByK80/SsABQmtcZWpHNzeUVE1wikehEEJF1nSmSPzHUbakPaPZ2d1N7XTssnImxp3qTAy5I6hbJjcUJuirUAlGy7oTbUGnnxIju42LQMs3kfy5SMuBHX2Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336500; c=relaxed/simple;
	bh=nU4hbgcZNgi3iNchaUwY/av4sAnNk/WkDSSF6fNBeDo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YDL4rCA8Jv4Y9AEM96YChUFBZ6VqP/m1uvXXi4maW9icxseXAes51zZgM0GqqI+0o+o1IiFbjNHWnPS8/e09C1arNagELjne3CuRsfPQBI/WzK1IMUJjycbAQp8OjgOOoMqe2uFrj/A6lq6pD4iEP564GXpCbYK10XzF/6a8sXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b5IT9XdL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3XNuwKKl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 03:14:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765336494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9btgBF9wR2TBQQUuzl+S1BzKCIIBl2pqy/q4RxRBuI=;
	b=b5IT9XdLd88XitDtnZ1bt2kPCduL/hfDA81bN+tPKjXKAMwookeyh5NA5EqWScpZcZ7st3
	WI52FkMd4lfkVTL7qn1qZp1CJpyxIAz8J4K0pXsrcJjBApK46qEl4fb+IJSVRx3tALYUrp
	vWswUGZlYGom5fKJZtPEbU7i9h8/xgo7P7Rzkt3AQRruP+BpDJkDDVE8LK7tV8ynqXBuqf
	UUKN71kpUg4lEKnTROQpUUveHWeuA6JtCRqBd2WJkGZYbaUbQu8yTPAqIZMsQ9YWAZ3Mi2
	tXGSFUPFpI7PqJd2FCyB2CgiC6t/qCOmCtM60nwPSCH+9YYHOUA4ZRM8nmm9UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765336494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9btgBF9wR2TBQQUuzl+S1BzKCIIBl2pqy/q4RxRBuI=;
	b=3XNuwKKllIiP5No130Fw4gYRDKtj6n24KVHJILQvRnBBnodj2gIBdcyVg7ruP1LqIDdzxi
	tAhhRufYMi7rAQAw==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <aTfHmOz6IBpTIPU5@stanley.mountain>
References: <aTfHmOz6IBpTIPU5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176533649129.498.12013031719621583485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7dbc0d40d8347bd9de55c904f59ea44bcc8dedb7
Gitweb:        https://git.kernel.org/tip/7dbc0d40d8347bd9de55c904f59ea44bcc8=
dedb7
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Tue, 09 Dec 2025 09:54:16 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Dec 2025 12:11:06 +09:00

irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()

If irq_domain_translate_twocell() sets "hwirq" to >=3D MCHP_EIC_NIRQ (2) then
it results in an out of bounds access.

The code checks for invalid values, but doesn't set the error code.  Return
-EINVAL in that case, instead of returning success.

Fixes: 00fa3461c86d ("irqchip/mchp-eic: Add support for the Microchip EIC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Link: https://patch.msgid.link/aTfHmOz6IBpTIPU5@stanley.mountain
---
 drivers/irqchip/irq-mchp-eic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 2474fa4..31093a8 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -170,7 +170,7 @@ static int mchp_eic_domain_alloc(struct irq_domain *domai=
n, unsigned int virq,
=20
 	ret =3D irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
 	if (ret || hwirq >=3D MCHP_EIC_NIRQ)
-		return ret;
+		return ret ?: -EINVAL;
=20
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:

