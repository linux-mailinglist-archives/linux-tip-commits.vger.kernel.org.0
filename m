Return-Path: <linux-tip-commits+bounces-6432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A93B41E8A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 14:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E41D1BA428F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023132EC08C;
	Wed,  3 Sep 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XflmhxoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrdFhXW8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A92C178E;
	Wed,  3 Sep 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901651; cv=none; b=uCvPSpwO48PsOdD+I6zm8hpoHqLgFM4ONSjk0CBe9kkZQvCIWVYX1B/IhrdWN8H7wGjzhJIDgJu8CY98qnsD3u+UDZ4/piuLD8kBVQ5qur4PaXRWkU9sOrOOJkUdkgyQOYxI6BYz3NtWYmAYA0GIRzv1I2vx9FBS4ZVnjdiQFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901651; c=relaxed/simple;
	bh=RCSGw7Oac9k13rlqmz1w+pmb/a5qK2yFXmqBqR2yIe0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tB21PXfK8fyaCKaL0lu8SZHHL3e1K2J1xMsoPw070o51bCEE+14PH86cjCrlaGFuSI1YjEwKoG6OWNKv7IsmBeu+YLF6YJaZY7MMcAfa2aZJ7iRoTV7ygwYa9uRKV4bl5qNpF4ZGA+AePL7Tp9Q7kZf62y9Rc2p6HOMOE7h1MXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XflmhxoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrdFhXW8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 12:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756901648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4jRTUbqo3L5LROOHPLvDfcys2WeoG620MR8br0bzJA=;
	b=XflmhxoCWewNpsiHhdN08dAWVuwn5qV7WAyR2s9N56ZAfwrzWjd+UqPrDjgoJ1egFJGeMt
	ZeYy8nJWqdpScdeFAlt904WAPlcp8hvvwQoYElrUhuU+VKuEHhgAM2JXXlSNYu8q0dj9zV
	pWRIfadXzo5rHCYa+CBAfD2SuD9bi0OTioC5F6sE3mljGvx/avh7ZdZnC5xHIUcRoBDjK7
	FWSZ4ZVur9CF8zWkRu8sqqJNQdolrvgMRgY9ZPpJ1jbAYES71wzmx9Jo4yQhvTCLOtKebq
	Cqx3Ylxvbi1bWBD+5TQUdXe4SiWpX2WTK6fnnk77T56/RYrYEWHcmhJINODxVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756901648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4jRTUbqo3L5LROOHPLvDfcys2WeoG620MR8br0bzJA=;
	b=LrdFhXW8QgY7zrTsGkVyDcQteyd3vyiUyM1zNv3vhouovOUq85HJ1uLmj8oOJlnj/WRY+C
	Rh6GA4i2ame38fAQ==
From: "tip-bot2 for Qianfeng Rong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip: Use int type to store negative error codes
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250829132020.82077-1-rongqianfeng@vivo.com>
References: <20250829132020.82077-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175690164738.1920.2236793881137920657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     40c26230a1bfdf46f93e4136dbb96d093744c80d
Gitweb:        https://git.kernel.org/tip/40c26230a1bfdf46f93e4136dbb96d09374=
4c80d
Author:        Qianfeng Rong <rongqianfeng@vivo.com>
AuthorDate:    Fri, 29 Aug 2025 21:20:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 14:10:30 +02:00

irqchip: Use int type to store negative error codes

Change the 'ret' variable from unsigned int to int to store negative error
codes or zero returned by other functions.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but assigning negative error codes to unsigned type may trigger
a compiler warning when the -Wsign-conversion flag is enabled.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250829132020.82077-1-rongqianfeng@vivo.com

---
 drivers/irqchip/irq-gic-v3.c       | 3 ++-
 drivers/irqchip/irq-nvic.c         | 3 ++-
 drivers/irqchip/irq-renesas-rza1.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbeb856..3de351e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1766,8 +1766,9 @@ static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
-	unsigned int type, ret, ppi_idx;
+	unsigned int type, ppi_idx;
 	irq_hw_number_t hwirq;
+	int ret;
=20
 	/* Not for us */
 	if (fwspec->fwnode !=3D d->fwnode)
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 76e11ca..2191a2b 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -73,8 +73,9 @@ static int __init nvic_of_init(struct device_node *node,
 			       struct device_node *parent)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	unsigned int irqs, i, ret, numbanks;
+	unsigned int irqs, i, numbanks;
 	void __iomem *nvic_base;
+	int ret;
=20
 	numbanks =3D (readl_relaxed(V7M_SCS_ICTR) &
 		    V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index a697eb5..6047a52 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -142,11 +142,12 @@ static const struct irq_domain_ops rza1_irqc_domain_ops=
 =3D {
 static int rza1_irqc_parse_map(struct rza1_irqc_priv *priv,
 			       struct device_node *gic_node)
 {
-	unsigned int imaplen, i, j, ret;
 	struct device *dev =3D priv->dev;
+	unsigned int imaplen, i, j;
 	struct device_node *ipar;
 	const __be32 *imap;
 	u32 intsize;
+	int ret;
=20
 	imap =3D of_get_property(dev->of_node, "interrupt-map", &imaplen);
 	if (!imap)

