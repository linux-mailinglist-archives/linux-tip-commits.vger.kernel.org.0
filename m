Return-Path: <linux-tip-commits+bounces-8053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3DCD393C4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A40F300F6A1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0231A7E1;
	Sun, 18 Jan 2026 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHhmee7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKQ+JuL4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857153128C9;
	Sun, 18 Jan 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730588; cv=none; b=g3KBvWxb71hsUQSqC56YqXDnNeVafFkkdtyFV31uCmrks8HfWvUoPx7u+p+IBL0WKfxH8/+uzQlslhQmrtu3B8SrT4/+yKhJrVNoQM8fYL0ajwhuxe0jXt9fe3TfYacn4xc7h30kI57xGa/4UCIKYVl56J2jdKLHu/iMPDKNFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730588; c=relaxed/simple;
	bh=II9KnhBPtm7VqH832CqlsqGTsS7m4COK7/xWUVAelw0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A9J4DcBmebDyNrwJPoO0ga87uN5t7qSoaymlbQ8QSzWmNxDOjAr4aX2ps6YfoRID7yw+tBhkA3vVyB+bCVFgsruLwwozbACpiQfN/wu4tX4qhvvmUyURJ3pnF/8KZdUcEKjKe1IGO+Tb64PyeWfjZmhJ5ithDzAjmYPmOeTaQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHhmee7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKQ+JuL4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eham00FcAKWndznALuX0rR1sZARb8x+AJ7yyQrQBv8c=;
	b=EHhmee7G+2o7gCDI1KKq1i213yCK0ae8U6rNFIOzQ6kQA0PhnBaHu+zIF+NwhisMasvitb
	VTgHkfV1bt/3DvgDGcU11RHwCMY4uqnaq3mHDS6z6pXRLsv+QaLZiLrWcRpxb3DFY9Ef0q
	P6U//IOp1u7ch3FY09kHC092ly1SFz4qyasUlVu4AZcO0R1IydaBRDa2ri3jVLjGzozwh0
	91jV6PQKKd33oAVzfcBmhJFz7MAUT5AipPKZKtOKHGPW3AfRq6RCmjoGYKtluyDy/+eVHP
	DgmXMwTT8MV8WZ6CybdcBT1o2cfnaaK6EL5pMgj4gwFKsNsPs0Y2gb7IhqezBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eham00FcAKWndznALuX0rR1sZARb8x+AJ7yyQrQBv8c=;
	b=RKQ+JuL4yo6PlDK98c6Xk4WH2qeec0iewapd0ClcPoY8hCXAw7Pb11prSTPhMEj91c9b3Q
	32FgI9dpchpP3VDQ==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irq_domain_alloc_fwnode() takes a parameter with
 the phys_addr_t type.
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-3-chenhuacai@loongson.cn>
References: <20260113085940.3344837-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873058404.510.14511430905691553279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     2d12143e5983b9f037f439ae994c454337ef889b
Gitweb:        https://git.kernel.org/tip/2d12143e5983b9f037f439ae994c454337e=
f889b
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:35 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 19:32:01 +01:00

irq_domain_alloc_fwnode() takes a parameter with the phys_addr_t type.
Currently the code passes acpi_liointc->address to it.

This can only work on 64BIT platforms because its type is u64, so cast it to
phys_addr_t and then the driver works on both 32BIT and 64BIT platform.

[ tglx: Make the cast explicit and use the casted address as argument for
  	liointc_init() which takes a phys_addr_t as well. Sigh... ]

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-3-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 0033c21..551597e 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -394,8 +394,9 @@ static int __init acpi_cascade_irqdomain_init(void)
=20
 int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio=
_pic *acpi_liointc)
 {
-	int ret;
+	phys_addr_t addr =3D (phys_addr_t)acpi_liointc->address;
 	struct fwnode_handle *domain_handle;
+	int ret;
=20
 	parent_int_map[0] =3D acpi_liointc->cascade_map[0];
 	parent_int_map[1] =3D acpi_liointc->cascade_map[1];
@@ -403,14 +404,13 @@ int __init liointc_acpi_init(struct irq_domain *parent,=
 struct acpi_madt_lio_pic
 	parent_irq[0] =3D irq_create_mapping(parent, acpi_liointc->cascade[0]);
 	parent_irq[1] =3D irq_create_mapping(parent, acpi_liointc->cascade[1]);
=20
-	domain_handle =3D irq_domain_alloc_fwnode(&acpi_liointc->address);
+	domain_handle =3D irq_domain_alloc_fwnode(&addr);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
 	}
=20
-	ret =3D liointc_init(acpi_liointc->address, acpi_liointc->size,
-			   1, domain_handle, NULL);
+	ret =3D liointc_init(addr, acpi_liointc->size, 1, domain_handle, NULL);
 	if (ret =3D=3D 0)
 		ret =3D acpi_cascade_irqdomain_init();
 	else

