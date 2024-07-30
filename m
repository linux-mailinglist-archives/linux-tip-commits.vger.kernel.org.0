Return-Path: <linux-tip-commits+bounces-1830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF59410CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551051C23707
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB71A00E1;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKeZy9dL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXmkT1Oc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641E19EED5;
	Tue, 30 Jul 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=WI6/3AKoxm143WBB7a01jqiA4rh3dssY54pkTFlchE/oa4+5V2O7iwvUdidtMRQJyxD5dnEB6il/QSsY/nsWipnfLesiYfXX9HHS542YIFVgUQ6knl0NjGnI4fm5qbhgwBUng3iQf0mP8NcLcB3mMZVc1IkiYqQVnKZO03jyq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=uX56NDVaZGb47dSMM0aY2Slp02+IDqFToBmXe6LvXSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CqgL5hY7N9ycqeJfsyBj8NikMfV3hDxEFgZwPQVarZ+iFJdazo5c9skSd30jKBXg8UCfWyBvXPRHa4mGut5BC5HGEgx5k+46YGGWehsEmRome62FqnqznNgteLGhRN4pjzcI+8C3aiI5lRvNFaCF7MnGzK1iadC6nQfDCsc9fDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKeZy9dL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXmkT1Oc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tu4naVZtVEBwR/Y7bJ0kvJ1gyKh/Zt0pRK52xx3Vzbc=;
	b=DKeZy9dLRqt5mUUAdjWKsxtYED+J9L+bcdNbwgEvCHyeKMUcd3VH/rzLDrKmgkb0oSLoYN
	lTWcg7IWwZj5AxEYOCRCBibSvHB49/Bybe83KEKPlDSxfaGul9/1ALmaK/AqqnGb3IiSD7
	Mpk1apX/+4WeiNHtSqOb/reJieL8PhPwD7myrnTxnHquJsP7tgSkB5H78p9UA0N8cUFPdc
	C2KyXT/kQDcVZWqPdQgJEjB6t5Uso6F3eTZpU4O9Q+KvQqnMBq2lJh9xsasYxXJfECJIAs
	Mwmc4fl993yYWh7ZHIb/fMuVmRRs4WKX/uUIMQ88KZ2XVqW+ntKYCqjj1GJ9BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tu4naVZtVEBwR/Y7bJ0kvJ1gyKh/Zt0pRK52xx3Vzbc=;
	b=kXmkT1OcEt6mDHW0SAF0n88pZLEwQCpjE1+tC4d08vl3mXO2UIqekUqh+OX4r2N6b5hK04
	hIinoCnc/8vUVUDw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Refactor mpic_handle_msi_irq() code
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-10-kabel@kernel.org>
References: <20240711115748.30268-10-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960004.2215.7060890372007035064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     63697bc7199ee2bacc8324b59951046a7b3ea991
Gitweb:        https://git.kernel.org/tip/63697bc7199ee2bacc8324b59951046a7b3=
ea991
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

irqchip/armada-370-xp: Refactor mpic_handle_msi_irq() code

Refactor the mpic_handle_msi_irq() function to make it simpler:
- drop the function arguments, they are not needed
- rename the variable holding the doorbell cause register to "cause"
- rename the iterating variable to "i"
- use for_each_set_bit() (requires retyping "cause" to unsigned long)

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-10-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 32 ++++++++++------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 179a30a..5c2631f 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -602,29 +602,21 @@ static const struct irq_domain_ops mpic_irq_ops =3D {
 };
=20
 #ifdef CONFIG_PCI_MSI
-static void mpic_handle_msi_irq(struct pt_regs *regs, bool is_chained)
+static void mpic_handle_msi_irq(void)
 {
-	u32 msimask, msinr;
+	unsigned long cause;
+	unsigned int i;
=20
-	msimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
-	msimask &=3D msi_doorbell_mask();
+	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	cause &=3D msi_doorbell_mask();
+	writel(~cause, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
=20
-	writel(~msimask, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
-
-	for (msinr =3D msi_doorbell_start();
-	     msinr < msi_doorbell_end(); msinr++) {
-		unsigned int irq;
-
-		if (!(msimask & BIT(msinr)))
-			continue;
-
-		irq =3D msinr - msi_doorbell_start();
-
-		generic_handle_domain_irq(mpic_msi_inner_domain, irq);
-	}
+	for_each_set_bit(i, &cause, BITS_PER_LONG)
+		generic_handle_domain_irq(mpic_msi_inner_domain,
+					  i - msi_doorbell_start());
 }
 #else
-static void mpic_handle_msi_irq(struct pt_regs *r, bool b) {}
+static void mpic_handle_msi_irq(void) {}
 #endif
=20
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
@@ -647,7 +639,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
=20
 		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
-			mpic_handle_msi_irq(NULL, true);
+			mpic_handle_msi_irq();
 			continue;
 		}
=20
@@ -675,7 +667,7 @@ static void __exception_irq_entry mpic_handle_irq(struct =
pt_regs *regs)
=20
 		/* MSI handling */
 		if (irqnr =3D=3D 1)
-			mpic_handle_msi_irq(regs, false);
+			mpic_handle_msi_irq();
=20
 #ifdef CONFIG_SMP
 		/* IPI Handling */

