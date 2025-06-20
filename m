Return-Path: <linux-tip-commits+bounces-5878-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3118AE22F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E6E4A2063
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A64223DED;
	Fri, 20 Jun 2025 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFwwRKSV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="530aEQ/I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16F8632B;
	Fri, 20 Jun 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448609; cv=none; b=uzJLdOnmgnHPl7BJ9xcBxUKKUqARaSk8hlrJIGDn5LNeSmsUsVh+DcdT/OxYbezFnc3eI2lXOBWS6D4Y2KRUIWRA5MFKU0kaa97HcI5tJ1bBo8Qq+tJuc/+HaVtdP+0SgoyIWnjBRcxWp4HePVFO1qij8rCrXV1n/F8pEFfvA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448609; c=relaxed/simple;
	bh=Vn04240d5roup5lAOzj/uWJQhcDCcVYzP7kpu/cRnpI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hdUMrQD+mCUwaDZohcChq3QGia45UVjyGzY6bCZQWEsnWfNbt0CT+Txb5KAZDfLRixK0U+l8A2rgi26jMyZasHrvAowDNYufP7lTHDZio5xT8nNcoOS4JvPdTkzyDErQtJ2vykRu4WNJvMMVztsQLVqVcOnFPEKM6VbO5/aNFQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFwwRKSV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=530aEQ/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 19:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750448605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e55sKE469KobyG9ZhdGPSlZ6apftrG5cmANWoEHT6s=;
	b=aFwwRKSVoHFZIH8maT1ulNcNPDjBWOp6J5IHBbjiYQPY5XB3idI3upgh3Tz4yfH9CH//nB
	tQZnUYAdnqKBiibry7U1M2/lOcnZ5UG3P3AMiydiw3DxJW5X8Y0b1p0lcogbrgWbfKHail
	WAdv/pwA+YjzCJSygL4ujcQDz9sGL1knA9FNPbymmT3xDL+dSuUGVamYZk2Elay0GaQGhD
	GXbsHH0ZunFdRdjS9Blquk8FuzUdvLR//7Fwgy/vbT5VepfDGttGF/D+yyrta0UNnZY5K6
	b9P+EjW3sm2Zg2jV1G7G5M/P6MU6inIFQRFcoqCFrGSFauCybcgYGzxY384xxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750448605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3e55sKE469KobyG9ZhdGPSlZ6apftrG5cmANWoEHT6s=;
	b=530aEQ/IkqTarLlzTJ50lGlvIlXgo8ADHyuA8shSeshfvUiPnuEbQo1M0/7i0K3axMNqWy
	o+2tPUo3Kyn3eIDA==
From: "tip-bot2 for Shiji Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ath79-misc: Fix missing prototypes warnings
Cc: Shiji Yang <yangshiji66@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3COSBPR01MB167032D2017645200787AAEBBC72A=40OSBPR01MB?=
 =?utf-8?q?1670=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3COSBPR01MB167032D2017645200787AAEBBC72A=40OSBPR01M?=
 =?utf-8?q?B1670=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175044860452.406.10816988292954394942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     3085ef9d9e7ab5ae4cddbe809e2e3b8dc11cdc75
Gitweb:        https://git.kernel.org/tip/3085ef9d9e7ab5ae4cddbe809e2e3b8dc11cdc75
Author:        Shiji Yang <yangshiji66@outlook.com>
AuthorDate:    Wed, 18 Jun 2025 23:07:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 20 Jun 2025 21:38:52 +02:00

irqchip/ath79-misc: Fix missing prototypes warnings

ath79_misc_irq_init() was defined but unused since commit 51fa4f8912c0
("MIPS: ath79: drop legacy IRQ code"), so it's time to drop it.

The build also warns about a missing prototype of get_c0_perfcount_int().

Remove the stale leftover function and add the missing include.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/OSBPR01MB167032D2017645200787AAEBBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com
---
 drivers/irqchip/irq-ath79-misc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 268cc18..258b8e9 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -15,6 +15,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/time.h>
+
 #define AR71XX_RESET_REG_MISC_INT_STATUS	0
 #define AR71XX_RESET_REG_MISC_INT_ENABLE	4
 
@@ -177,21 +179,3 @@ static int __init ar7240_misc_intc_of_init(
 
 IRQCHIP_DECLARE(ar7240_misc_intc, "qca,ar7240-misc-intc",
 		ar7240_misc_intc_of_init);
-
-void __init ath79_misc_irq_init(void __iomem *regs, int irq,
-				int irq_base, bool is_ar71xx)
-{
-	struct irq_domain *domain;
-
-	if (is_ar71xx)
-		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	else
-		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
-
-	domain = irq_domain_create_legacy(NULL, ATH79_MISC_IRQ_COUNT,
-			irq_base, 0, &misc_irq_domain_ops, regs);
-	if (!domain)
-		panic("Failed to create MISC irqdomain");
-
-	ath79_misc_intc_domain_init(domain, irq);
-}

