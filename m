Return-Path: <linux-tip-commits+bounces-8050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AED393C1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4572B30116F5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA102ECD14;
	Sun, 18 Jan 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxYt92tK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vc2SIPAZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1332DFA40;
	Sun, 18 Jan 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730584; cv=none; b=OK/DhCu0JBqnLd5iaPPjQk4rZ/xmeoUqmUixnmK8AkJnghVjhJ4XFnTgEbHEnfKiLAckR/fEV016mHConeyf6z95+dUabxHa+y8p4PHoVV/2hqIjvopNflOwgL2TvV8B4tfjvKTaFtws0ZdUW7bEa6vkK8CcaxrDA9MNk5XErrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730584; c=relaxed/simple;
	bh=TXYrHnr5yIzKR+8ptqMV6HVn8fmEqQMoMNARMAoyDas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kJlSNM05IIFgU1xQn6GaeAH+YWsreJm++pHIKNQnH/Dq/Woncp0uyWcwwPRHTHop7qpjNHU3MPEbB0v8VUW+0Q44SRuTczDFnkd16sMjzI+ieVZGwu7Nm5NS7ZMDIgSnj3yJv0DcTTT23/5sxAmwoVawoNGQk3uR995kJTUClXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxYt92tK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vc2SIPAZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:03:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU+GeJWwbnEdypHSl1WMiySpaMMqxxxPu6JnGWCyTvI=;
	b=PxYt92tKNp22NfSzpkj9VXPAxx/LLoMl7i5JIHvNeoDMc7/IWRV930jT9Evi7yhQlG33vp
	xeab+L1rwOjzZpFBtZnN5ZQwWAuiWVjNcCIM3pnCLT6dM3dB3YfFV4FOKJYGo1DO2Ky9zM
	SAfi9ruLookglu+opHjQJGQd/6n3mZg167BHOOp0XO7Q1B8F7wA9bV0k/sVfJ4WsPSNAAN
	6ZNAwqQq7Y2Fx6ZLmJY+LrQVEb+uaf+KixmnyVBr49qTbr0FWWdeYTt3euoBfQtslvAv6X
	SyGBBXMEkeCifWAzIuJl1bj/gLHxVcmo7qkB7C+hqf0wCScb41IYco0W/rU+gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU+GeJWwbnEdypHSl1WMiySpaMMqxxxPu6JnGWCyTvI=;
	b=vc2SIPAZwGPn/rg+B/gEI6z3XIMzTqyy8tZdRn8CGU1psC502LcQgVDOnWa7Cxd1pkHAOZ
	LLzIKt5vQYk42nDw==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-pch-msi: Adjust irqchip driver
 for 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-6-chenhuacai@loongson.cn>
References: <20260113085940.3344837-6-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873058060.510.7471353176927117627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f2d406614b74dd8adad8291a1687357377ff050d
Gitweb:        https://git.kernel.org/tip/f2d406614b74dd8adad8291a1687357377f=
f050d
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:38 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 19:32:02 +01:00

irqchip/loongson-pch-msi: Adjust irqchip driver for 32BIT/64BIT

irq_domain_alloc_fwnode() takes a parameter with the phys_addr_t type.
Currently the code passe acpi_pchmsi->msg_address to it.

This can only work on 64BIT platform because its type is u64, so cast it to
phys_addr_t and then the driver works on both 32BIT and 64BIT platform.

[ tglx: Make the cast explicit and fixup coding style. ]

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-6-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-msi.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index 4aedc9b..91c856c 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -263,12 +263,13 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segmen=
t)
=20
 int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi=
_pic *acpi_pchmsi)
 {
-	int ret;
+	phys_addr_t msg_address =3D (phys_addr_t)acpi_pchmsi->msg_address;
 	struct fwnode_handle *domain_handle;
+	int ret;
=20
-	domain_handle =3D irq_domain_alloc_fwnode(&acpi_pchmsi->msg_address);
-	ret =3D pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
-				acpi_pchmsi->count, parent, domain_handle);
+	domain_handle =3D irq_domain_alloc_fwnode(&msg_address);
+	ret =3D pch_msi_init(msg_address, acpi_pchmsi->start, acpi_pchmsi->count,
+			   parent, domain_handle);
 	if (ret < 0)
 		irq_domain_free_fwnode(domain_handle);
=20

