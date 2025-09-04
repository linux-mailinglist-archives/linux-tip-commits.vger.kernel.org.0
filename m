Return-Path: <linux-tip-commits+bounces-6480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2FB43C35
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F31216B05E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0232FDC59;
	Thu,  4 Sep 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0hCZ0TT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5W1JpdO2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B202FD7C3;
	Thu,  4 Sep 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990700; cv=none; b=NLB3Cf9qtu2CFS5vPcjQjyD9y4EJJlLTilmYZDsBgafnvgBbFwj1I26EYKBz1xRz177vd7kP+UnVpHrlNvD3Yoqb/n5+sGyShvn2BuqQ46xqOzUDiA7W2Jih7uUozi0IJ/1znss2ljY/CKuHZgnKxKqVhHOjahPBcxTtnWHUN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990700; c=relaxed/simple;
	bh=PdZa5taNDFhfGE3+tb5yNCVuDul3FtnoroXmImVpr7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CslVF1R5PSv1Vaa9WMU/ihbzZN0tGcztaz4+yVe/+8c0O4g87hh/awJx63lMEyDuokodHGF6gftWCFsLO56JNmk60f7vF/ne8h9WG/uTv0okJxszRoJUgYHJjEgwbQnSZJuQxdPRWkG0Lrt0TUaWvO9HzmYt18qm8XFLMpgLTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0hCZ0TT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5W1JpdO2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 12:58:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756990695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+r6iK9WTRIfqZkbEsN6NGpTz2rUz53IXvxZAk+ReR8=;
	b=x0hCZ0TTt+8qU14NYhiJ3RbRHNvnIi3ZitOdcXHDWm1YJAFS3gFEAQBMkwNWvuXq3uj/XJ
	lshCd1AplZqnFvjCFpgo7jW1agmq8YWfnwLJzlJmJdttGRDHoqixjChLi/+VO56Z6aQ7qz
	C3HnBVnvfne9628E7c3Y8Ft3k5YxUKXlUGzCmbnhu81O70KDsuMaS4qLlT7pdVVrrylWkg
	ct2/Q99xzBBH2grGZXEuBxsz+oyCd0EyOCTM+wkHtRbyTbWJSmayVLQ4FqU8bDxf0lu9jE
	B4tqw+0uUSg173AnK5KQQvp0ZOixpe1dOSadVAiP9CyU8t2bQu3+oWn5P7q3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756990695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+r6iK9WTRIfqZkbEsN6NGpTz2rUz53IXvxZAk+ReR8=;
	b=5W1JpdO2Cojh1Syczz3c2W82bIfkRkYch4WMvl2xzH66i+LuhOELHfZ6IwhMmvtmtODiYp
	xjxiNzBqP2Xv53Ag==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Set irq type according to DT
 configuration
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 Inochi Amaoto <inochiama@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb22d2b0a00a96161253435d17b3c66538f3ba1c2=2E1756953?=
 =?utf-8?q?919=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3Cb22d2b0a00a96161253435d17b3c66538f3ba1c2=2E17569539?=
 =?utf-8?q?19=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175699069345.1920.9646733302815230593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c2616c5696e85efb2679499d7260f7766b93cff6
Gitweb:        https://git.kernel.org/tip/c2616c5696e85efb2679499d7260f7766b9=
3cff6
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Thu, 04 Sep 2025 11:01:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 14:52:48 +02:00

irqchip/sg2042-msi: Set irq type according to DT configuration

Read the device tree configuration and use it to set the interrupt type.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Inochi Amaoto <inochiama@gmail.com> # Sophgo SRD3-10
Link: https://lore.kernel.org/all/b22d2b0a00a96161253435d17b3c66538f3ba1c2.17=
56953919.git.unicorn_wang@outlook.com
---
 drivers/irqchip/irq-sg2042-msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
index 3b13dbb..f7cf0dc 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -30,6 +30,7 @@ struct sg204x_msi_chip_info {
  * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
  * @irq_first:		First vectors number that MSIs starts
  * @num_irqs:		Number of vectors for MSIs
+ * @irq_type:		IRQ type for MSIs
  * @msi_map:		mapping for allocated MSI vectors.
  * @msi_map_lock:	Lock for msi_map
  * @chip_info:		chip specific infomations
@@ -41,6 +42,7 @@ struct sg204x_msi_chipdata {
=20
 	u32					irq_first;
 	u32					num_irqs;
+	unsigned int				irq_type;
=20
 	unsigned long				*msi_map;
 	struct mutex				msi_map_lock;
@@ -137,14 +139,14 @@ static int sg204x_msi_parent_domain_alloc(struct irq_do=
main *domain, unsigned in
 	fwspec.fwnode =3D domain->parent->fwnode;
 	fwspec.param_count =3D 2;
 	fwspec.param[0] =3D data->irq_first + hwirq;
-	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
+	fwspec.param[1] =3D data->irq_type;
=20
 	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (ret)
 		return ret;
=20
 	d =3D irq_domain_get_irq_data(domain->parent, virq);
-	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+	return d->chip->irq_set_type(d, data->irq_type);
 }
=20
 static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigne=
d int virq,
@@ -298,6 +300,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	}
=20
 	data->irq_first =3D (u32)args.args[0];
+	data->irq_type =3D (unsigned int)args.args[1];
 	data->num_irqs =3D (u32)args.args[args.nargs - 1];
=20
 	mutex_init(&data->msi_map_lock);

