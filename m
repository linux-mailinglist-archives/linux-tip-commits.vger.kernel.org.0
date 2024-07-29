Return-Path: <linux-tip-commits+bounces-1763-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697ED93F1A1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29FA2811CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749D144D16;
	Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="epD7JgI3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdSdOPUu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B6143C45;
	Mon, 29 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246588; cv=none; b=aAjk+g3KhkiqOgBnkBMUV6hpW71BlbERxu3g62oCW5abHHy+iUP0TkzOuzeFuNcrl8Y3DOF5+KOgmKSe3gwiVfFVtYRmREpEwYJ78eLMeSrxF+2KNuUWtM3R07s07lskL5Y32zVqjFh/ESjWU10zSfdunFqpBVolEIaIh7B1sK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246588; c=relaxed/simple;
	bh=ridIkPBFyKtWrRf4/EXlw6uYZ7nLJXDfY6eZesIXaEQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O2q568HWtHHk3pa2MhP1uMyx6DhMRdWlCrA7uVb7rCUTQcl4X3Iocj1OPeHGaiKVsnBorNgctwgww/vjkhCjOoGeQre4QkIfBT7roMb+jFS32SnjzAo7PK1HoPbWpzgsuvkg1tKdTNGc10y9NNrpzkTbj3RiG4ZNxzh4Nk2mXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=epD7JgI3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdSdOPUu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVSs12xces9Q/18E3X3cZscAk6ZyjGqx8788Qo/1/fs=;
	b=epD7JgI35uydaNPiiQND8wy1co7z0jnMDjhLVOhK/nmiRuIaGP4Seu7j3kdWo0FFQNz3EZ
	OQvFtUFvRcOSvHSpoK0TyiA8j/XIxztcIGdm3vnR9/IwZTRuV63nZ7OIn103hUgXZL9Apq
	D0XOkDAebcB/Jnd194+GhugJwGTrAHfJaM1bFWSD3FWIk3TtSfeBL+zDdFNguQrsQkDUOv
	WCi1NX33ukUL41L/hlQzd7swm5WfIIzEpVOXVem+ldNYeqoDQf/oFlI8AlW0OUQHXjyLSv
	0fzSn2ISCVJZE3HO3rnW9XSfw1ovUNayIU0YyTtohORnXE73cOWZEQDkvqi+2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVSs12xces9Q/18E3X3cZscAk6ZyjGqx8788Qo/1/fs=;
	b=bdSdOPUuSGuRIPXN1Efe7jR7w7+b9bJNiikhsFhQ2idRV6NOlhEDwYT38GbAkUPzR6H6z4
	mkUbuwSpkfSTKQDQ==
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
Message-ID: <172224658330.2215.1102865417261876573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     03a1e74fc0506bb236b5d921f6d5482b152a95b9
Gitweb:        https://git.kernel.org/tip/03a1e74fc0506bb236b5d921f6d5482b152=
a95b9
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

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

