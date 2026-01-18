Return-Path: <linux-tip-commits+bounces-8068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11566D39565
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA3330312C5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30002332EC1;
	Sun, 18 Jan 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avAj4LtP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+QkD2Ft"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D460331A4D;
	Sun, 18 Jan 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743724; cv=none; b=dKT990j/+o40LoyApn4Nm/eYUxkBjUd10tezda+v9uL9J/O8wcsPMrhimMYE/xQoCy/DBcQMTGZwOXWFC4TB3TL+6lsJEnVpNo3W7+iE5BUz2K1PLqWLcZC7DZUVSN5D25nWOLLpkSoeYr8ni7QxR4sPq86hrkn5IrIvo/knWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743724; c=relaxed/simple;
	bh=yAHOuiN0lT9Rm5g+O6X+L1fUvh6EG4geRq+qLzZ0a2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kjZUZDuSHyij94OVlP85JzYwTXi5AEvWy1lrKlZd+OKRfWiEf5ol2zpQUMbN4qwCQfTsvOc6KKRauupKjWnu2JNUVEuN09tw+fxZf4YsUI8HWgdUb7WvROrDqgf0KwIUkxilh/K84pj9PuPF/2CwChNuPBrcVAIPcYUgYJ4T4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avAj4LtP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+QkD2Ft; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeEJH8F4+rivjxNKfxqWaVYAkwhYetO64VyP2FK1O2A=;
	b=avAj4LtPuWf40Jf03oZoe+Rc8ydXMn/JCAtl1a12FYIESq4j5kQX+yAVJDFmTciseh+Inz
	OoLJ8nWKkNuoAbUp5vqM5t7Y4l68WeLAMPD7f28rrC3P0SjM0H/Mx3FbV+vYVp3yGCB03S
	g28RSAuL0jMroM/TSLlSGOQCqsNEPMu3moX5axS8q0kb83HVvqIENusBwibRO5UYawEsjv
	sEeCwVrwHVCXZwRpHc9wZ8BfGVJNiD3JaKxUjMGMJAY510xRX+Or3U0uH/K1NZuhl9jysu
	RUly/TLmYUJkIPFjm1HL9DxBefEabcTpYbb6T0RSaujefyX03CF6pk+h0JFtbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeEJH8F4+rivjxNKfxqWaVYAkwhYetO64VyP2FK1O2A=;
	b=A+QkD2FtxFMnV2OPD3movcKIVapUAs5zQFeaoXlTlkKO8qFbuAO5VmtwpIcdxcNzZrQInP
	SNs8alKXb6G/c/Bg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-htvec: Adjust irqchip driver for
 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-5-chenhuacai@loongson.cn>
References: <20260113085940.3344837-5-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176874371539.510.15685571624549112585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     04f1f17d28ce24a7b40039c8d8ee053a777661a7
Gitweb:        https://git.kernel.org/tip/04f1f17d28ce24a7b40039c8d8ee053a777=
661a7
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:37 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:17 +01:00

irqchip/loongson-htvec: Adjust irqchip driver for 32BIT/64BIT

irq_domain_alloc_fwnode() takes a parameter with the phys_addr_t type.
Currently the code passes acpi_htvec->address to it.

This can only work on 64BIT platform because its type is u64, so cast it to
phys_addr_t and then the driver works on both 32BIT and 64BIT platforms.

[ tglx: Dereference _after_ the NULL pointer check, make the cast explicit
  	and use the casted address as argument for htvec_init() which takes
  	a phys_addr_t as well. Sigh... ]

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-5-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-htvec.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loong=
son-htvec.c
index d2be8e9..5a3339d 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -295,19 +295,19 @@ static int __init acpi_cascade_irqdomain_init(void)
 	return 0;
 }
=20
-int __init htvec_acpi_init(struct irq_domain *parent,
-				   struct acpi_madt_ht_pic *acpi_htvec)
+int __init htvec_acpi_init(struct irq_domain *parent, struct acpi_madt_ht_pi=
c *acpi_htvec)
 {
-	int i, ret;
-	int num_parents, parent_irq[8];
+	int i, ret, num_parents, parent_irq[8];
 	struct fwnode_handle *domain_handle;
+	phys_addr_t addr;
=20
 	if (!acpi_htvec)
 		return -EINVAL;
=20
 	num_parents =3D HTVEC_MAX_PARENT_IRQ;
+	addr =3D (phys_addr_t)acpi_htvec->address;
=20
-	domain_handle =3D irq_domain_alloc_fwnode(&acpi_htvec->address);
+	domain_handle =3D irq_domain_alloc_fwnode(&addr);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
@@ -317,9 +317,7 @@ int __init htvec_acpi_init(struct irq_domain *parent,
 	for (i =3D 0; i < HTVEC_MAX_PARENT_IRQ; i++)
 		parent_irq[i] =3D irq_create_mapping(parent, acpi_htvec->cascade[i]);
=20
-	ret =3D htvec_init(acpi_htvec->address, acpi_htvec->size,
-			num_parents, parent_irq, domain_handle);
-
+	ret =3D htvec_init(addr, acpi_htvec->size, num_parents, parent_irq, domain_=
handle);
 	if (ret =3D=3D 0)
 		ret =3D acpi_cascade_irqdomain_init();
 	else

