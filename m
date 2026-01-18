Return-Path: <linux-tip-commits+bounces-8049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0BD393BF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B9963010FB9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A027CB0A;
	Sun, 18 Jan 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDDGrz6W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwC0vGlm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C022DEA93;
	Sun, 18 Jan 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730584; cv=none; b=QcHdIq2oSSHjqzil5EjGoZ9Nft1PyqsXKRwGOSCjLME4oUFDxpsVgbvxfAgjek0CuDRK2UmNZQ2dTek/8SaSF6O7ov5rcHGeR6Qp1tbaC5STq6kD5uIZ2PflQeb+40GIcbHH2n1dc14M22e8yEdk++A5z9nlI0MjBt3ofoR++Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730584; c=relaxed/simple;
	bh=C9cVqCPoI8lhrckrn/u+0nLWJtdHtCKmIuB6G0JHtdA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O1NN+E77p2NmZETa79y6CUgUKXdOqoWLUf7rOpcjfHkUFzLdNZXib2kd496y7q48X/CwfI7Vu+5QgUf+D7T4sZPF6UDP8cndsnbDfI9hWiA0UKwAKIR7h30+rS1DO8qIOUc7/bokhtEoOmsUPfyZpiQWIIZSWF1H413o0c3+ptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDDGrz6W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwC0vGlm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50HaUfi5jurnORP+2gAPjZT5NNyofwBagazt+YmN/7A=;
	b=iDDGrz6W6d4Nblr2j1exTUjmIt/nYxzbGa2VAqQpI5A/f+tX5XKoEBlFzWm69HiXKk65Gd
	2Rf5whNy1EsciyTU5tuw675tIJh6Nhypr0R5mqKJv7P9xdZRpaVzNEBeV6vDESUoleaxUX
	xGC25jnInR1JaNEZMJMRkuk4k8yIpgqcZV/mcujIow9hK3w5X5YJtH2tTaVOi2020xu3lQ
	yFlHqOSCGZm2EONxEEKRlCTq85oBBLeZe93OtDOPN3E/o2I8RFOTtifD6hormZIY4Dpmsj
	/soEUykO9HEiSYojApc072OrED7cFRDL43TwNlD8Tuuts5mneE4ZeDEKZH4ABg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50HaUfi5jurnORP+2gAPjZT5NNyofwBagazt+YmN/7A=;
	b=GwC0vGlm12nKdtk0nupWp/h7ifSGn88b9Xs9K5rbRvx5s1D7OfZEoRHW6U1ax4IqIAmcHU
	a5HHaVO8SqvDKnDw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-pch-pic: Adjust irqchip driver
 for 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-7-chenhuacai@loongson.cn>
References: <20260113085940.3344837-7-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873057949.510.16070096863396286674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     6e419473461bda5be6888de436d89753c1d260b3
Gitweb:        https://git.kernel.org/tip/6e419473461bda5be6888de436d89753c1d=
260b3
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:39 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 19:32:02 +01:00

irqchip/loongson-pch-pic: Adjust irqchip driver for 32BIT/64BIT

irq_domain_alloc_fwnode() takes a parameter with the phys_addr_t type.
Currently we pass acpi_pchpic->address to it. This can only work on
64BIT platform because its type is u64, so cast it to phys_addr_t and
then the driver works on both 32BIT and 64BIT platforms.

Also use readl() to read vec_count because readq() is only available on
64BIT platform.

[ tglx: Make the cast explicit and use the casted address as argument for
  	pch_pic_init() which takes a phys_addr_t as well. Fixup coding
  	style. More sigh... ]

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-7-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index c6b369a..23f94cd 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -343,7 +343,7 @@ static int pch_pic_init(phys_addr_t addr, unsigned long s=
ize, int vec_base,
 		priv->table[i] =3D PIC_UNDEF_VECTOR;
=20
 	priv->ht_vec_base =3D vec_base;
-	priv->vec_count =3D ((readq(priv->base) >> 48) & 0xff) + 1;
+	priv->vec_count =3D ((readl(priv->base + 4) >> 16) & 0xff) + 1;
 	priv->gsi_base =3D gsi_base;
=20
 	priv->pic_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
@@ -446,23 +446,23 @@ static int __init acpi_cascade_irqdomain_init(void)
 	return 0;
 }
=20
-int __init pch_pic_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_bio_pic *acpi_pchpic)
+int __init pch_pic_acpi_init(struct irq_domain *parent, struct acpi_madt_bio=
_pic *acpi_pchpic)
 {
-	int ret;
+	phys_addr_t addr =3D (physaddr_t)acpi_pchpic->address;
 	struct fwnode_handle *domain_handle;
+	int ret;
=20
 	if (find_pch_pic(acpi_pchpic->gsi_base) >=3D 0)
 		return 0;
=20
-	domain_handle =3D irq_domain_alloc_fwnode(&acpi_pchpic->address);
+	domain_handle =3D irq_domain_alloc_fwnode(&addr);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
 	}
=20
-	ret =3D pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
-				0, parent, domain_handle, acpi_pchpic->gsi_base);
+	ret =3D pch_pic_init(addr, acpi_pchpic->size, 0, parent,
+			   domain_handle, acpi_pchpic->gsi_base);
=20
 	if (ret < 0) {
 		irq_domain_free_fwnode(domain_handle);

