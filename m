Return-Path: <linux-tip-commits+bounces-8069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4CD39566
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C15303178D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F30332ED1;
	Sun, 18 Jan 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMm7mTn9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9s/9gVW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61B331A62;
	Sun, 18 Jan 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743724; cv=none; b=VMoJoB3x/JGhMN1vhRdXLI3+6k/qNrNjQT9ZZkuP2FKUY8728gWnCofTVMWTWvjbjMuFJUDoSDgFG5Yu4MsEhuCdmJbSigCeLUrtMVS1HW9kx1k0j4pvQuYAyMIpFgoga16WGhf9wvHV2GC6MWKQ+CRNDW1yBOfFsSCw82txjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743724; c=relaxed/simple;
	bh=nnCsnpvzmLhrzdCODAGizak3wY8lpASeDBK4H0+FDKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eKFFfY0sXNfP9ID4Ly6qXnexc+yP/dLuF6q6uOOslEe6vmJ4DjoO0zDsXIsAATfa9OvKlcaTOVJORC/h6u6TnwaNcSFKocPaNnTxjW4E3cz9ZZqXAkEGrsrCGe7SsVsshNw1ikEbyu/PP9ThnB9XKQcMLKnQMKMOJt5G0Paq84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMm7mTn9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9s/9gVW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THn04SJLzK58KURzvxQqXKj6Im/wy2bczbEdOolvk+0=;
	b=zMm7mTn9JdG8aqMSsuSisQ4+ioU7LWRb4kUtNtMqHpEhniSF5SHIGOxrH7o8V+urRe2//e
	FBilDgxgXB1LwI5G1PkeEy5o7S/iL9bjRpvrmQQYYVJeknqwi90e3/TOJHz6wFc/+1QvFn
	lhPpSuAA5yiQr2fIunAM70vCAawaR0yrwczd7e403w/tEwz5wXyV4tHRCjFwVAFsZK21R9
	CTAGyG8PMbOC6XQbe1PplwM9hdde9HMGdjCwHfELF2mMMykjTFps9eWdX76UaTv3imW0Mw
	sE8G+QQaRtiwD7OfSAThSQlLur5JajV7qwx9uqj8SovLX4uDagIHWhyV9Z2IoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THn04SJLzK58KURzvxQqXKj6Im/wy2bczbEdOolvk+0=;
	b=k9s/9gVWkmFPW0QBfi3pgFqSgkQIHMWqGldoeVhViHtl23tokNvkKK42FGWal+10FU349W
	qBpCBQCNHJ+7LBAw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-liointc: Adjust irqchip driver
 for 32BIT/64BIT
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
Message-ID: <176874371746.510.14846575748482085530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     57e05137ac3b37fd9b7b8714839d25b924073aef
Gitweb:        https://git.kernel.org/tip/57e05137ac3b37fd9b7b8714839d25b9240=
73aef
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:35 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:17 +01:00

irqchip/loongson-liointc: Adjust irqchip driver for 32BIT/64BIT

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

