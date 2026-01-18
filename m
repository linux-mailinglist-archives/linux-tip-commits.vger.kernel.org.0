Return-Path: <linux-tip-commits+bounces-8067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15336D39563
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CBEC302CDD9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47A332EA5;
	Sun, 18 Jan 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XSU9DGAk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8JiPC1r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC073321A7;
	Sun, 18 Jan 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743723; cv=none; b=EtNDhkhaM6sIqWsqx+Peq1daMTHUraTYUMsBiSN/qxSUF30RIBDPwrToktZsT8JEC0Q9T29kSN/L2gW3f79k4J6unY5p4EozXrIgqUKWH7ob31wmEyIaRODyWqoti96afen1XlW5SABUDgGjwTdMV9mCfIaAaO5f2upWeKaI89c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743723; c=relaxed/simple;
	bh=D91uAn+lcwxQ3f9QP0Ujaei6Lkq2GY0K76H33lp8r9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b+UQDIG8Rm/IojSxwPEHWdzZRrRXNwVM1rmxfcOoD8Hc9NpuBffiEYGa9UwPOWoU07y7UBKKHbKSRvUTCLkDqhF3VmASYQRRNPKOGWMpKXmQ1ZlYLURahC4PPxhlyJY11w4joztbPbdGiBFYyOOt5uqknCS5f25kPTxvVFnzy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XSU9DGAk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8JiPC1r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1P2DnmgKHx/FoTwbL5m2s5ihqmzQLZBwdZjbLuCI7M=;
	b=XSU9DGAkXEsyv8lL6T6Ixebi3zgE4iuU3mmBcXASBwZuYLs5wiEqvS8LrNYQyIWKwAMVqV
	a8JsC1WC9wkPcyO2M6I8SSpUWGdQP68js/59b8Z0z0ZjozqhV/Tr8tXmj6X68XhwvpHBi3
	yS78B7LfR2QLFjrj540Q4Kb3fh6HPl/i9qtBJlQ75RBckSwCUqNXyTaUvYOTqiUzLt2mTJ
	k89tIB7dKbIK+rEmAfuYpKN68HUSPzsjwcjU69pwzya/snlhIuhgXYH9uw4B02mb0bSBiU
	ZmUEytkc+0MLxu+rzAQZp/hahPYPU6AYe3Y/TV97pAByMpHP9NuXPIsjXYt0fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1P2DnmgKHx/FoTwbL5m2s5ihqmzQLZBwdZjbLuCI7M=;
	b=N8JiPC1r/hpF+s1/PgBQAgFMLZ4Tcajc4lLUOrsEIrHY17/W9jDFkHUmvXrNlz0h3ztQ6o
	oBq+CbZk3zh86fCA==
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
Message-ID: <176874371440.510.2342321794029480196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     4093b0e55b39422bbdae108a1be06292714a994d
Gitweb:        https://git.kernel.org/tip/4093b0e55b39422bbdae108a1be06292714=
a994d
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:38 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:17 +01:00

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

