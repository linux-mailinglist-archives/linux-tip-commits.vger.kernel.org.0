Return-Path: <linux-tip-commits+bounces-3326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D9A25B11
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05A51885284
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B0205510;
	Mon,  3 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22TWEOUv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHyJy6U+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C205512;
	Mon,  3 Feb 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589826; cv=none; b=jRZpI+KuugV5qDGRew9oJh8QWO3GGSu6e/p+62HXpnbjeu3y+ENDabfc/e314JtIUBA42a02pLF/Ef0kyY1EozCciGTH+nypf5QUAZxt/oL0ITpXFV3ef8ElrcXAVpCFVtHNxv9QM6FiwtVaM4375i8ymhmFXoO+4YuAScGULAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589826; c=relaxed/simple;
	bh=vVOw+7KeYHRLhyhH0FUXDxqoxS/HcqfT/xnQ+f8N67c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SgN8nDu/RgyUQQ7HP+7gd41Lh4k5i1ctexvYedqNPo5oQDdZ5O1FI+4Roct0BO1GC8X3Zl8R4RQKD6O8CHYlH1xT4UXV9X5B2sG7anP2IqGU89ab8H3g84IJM6ssWQEhQB+kDYOsJc8/dPHAwyWLZZzb4oNnMGT6YOpq2uQmAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22TWEOUv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHyJy6U+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 13:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738589823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=523eUV4XYBcTn/IlGHH6XT2FZYtQ/ZAWRUNKy2UDBMo=;
	b=22TWEOUv2pl9/phEyjyOaLIKVVBeDTU1rnXj6aeG2VFYp02ye7EKAVQQ4Oqdx2HLug7xHK
	xrUuyUUP+p/fkiixfZ4wZ9WHLD/xsB1AVGeY5oho9i6JX7QQ2biaX79QX01NRkXiiOWfBG
	z/ODCqZI1WPRIJtzIihM40gv/OnPEWBhgJtlO05W9TYy3UoqWJQXrbZTgeUGw/DvzF+Xge
	umGe6Z35AsqwkH5nzd04b74RBJ4NX2zTDTRIZVHct+weehwwQEYuSAq092PVk+pF6Tpxao
	h3Fkw0J9PkdVYFoHxZGHoYlf6HdfCB+PyTRCyn60KeKaIpcr1tdCRAfRGuBkFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738589823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=523eUV4XYBcTn/IlGHH6XT2FZYtQ/ZAWRUNKy2UDBMo=;
	b=LHyJy6U+g+Oc1CPBedld+62Yev58u0OQkogzOyrBOlj8q39CnNa14UlR9vgarw7d+zBMh6
	UO761Ijh0NL2hgCw==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-aplic: Add support for hart indexes
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250129091637.1667279-3-vladimir.kondratiev@mobileye.com>
References: <20250129091637.1667279-3-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858982178.10177.3135949933325527742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b93afe8a3ac53ae52296d65acfaa9c5f582a48cc
Gitweb:        https://git.kernel.org/tip/b93afe8a3ac53ae52296d65acfaa9c5f582=
a48cc
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Wed, 29 Jan 2025 11:16:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Feb 2025 14:27:39 +01:00

irqchip/riscv-aplic: Add support for hart indexes

RISC-V APLIC specification defines "hart index" in:

  https://github.com/riscv/riscv-aia

Within a given interrupt domain, each of the domain=E2=80=99s harts has a uni=
que
index number in the range 0 to 2^14 =E2=88=92 1 (=3D 16,383). The index numbe=
r a
domain associates with a hart may or may not have any relationship to the
unique hart identifier (=E2=80=9Chart ID=E2=80=9D) that the RISC-V Privileged=
 Architecture
assigns to the hart. Two different interrupt domains may employ entirely
different index numbers for the same set of harts.

Further, this document says in "4.5 Memory-mapped control region for an
interrupt domain":

The array of IDC structures may include some for potential hart index
numbers that are not actual hart index numbers in the domain. For example,
the first IDC structure is always for hart index 0, but 0 is not
necessarily a valid index number for any hart in the domain.

Support arbitrary hart indices specified in an optional APLIC property
"riscv,hart-indexes" which is specified as an array of u32 elements, one
per interrupt target. If this property is not specified, fallback to use
logical hart indices within the domain.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/all/20250129091637.1667279-3-vladimir.kondratie=
v@mobileye.com
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 24 ++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
index 7cd6b64..205ad61 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -31,7 +31,7 @@ struct aplic_direct {
 };
=20
 struct aplic_idc {
-	unsigned int		hart_index;
+	u32			hart_index;
 	void __iomem		*regs;
 	struct aplic_direct	*direct;
 };
@@ -219,6 +219,20 @@ static int aplic_direct_parse_parent_hwirq(struct device=
 *dev, u32 index,
 	return 0;
 }
=20
+static int aplic_direct_get_hart_index(struct device *dev, u32 logical_index,
+				       u32 *hart_index)
+{
+	const char *prop_hart_index =3D "riscv,hart-indexes";
+	struct device_node *np =3D to_of_node(dev->fwnode);
+
+	if (!np || !of_property_present(np, prop_hart_index)) {
+		*hart_index =3D logical_index;
+		return 0;
+	}
+
+	return of_property_read_u32_index(np, prop_hart_index, logical_index, hart_=
index);
+}
+
 int aplic_direct_setup(struct device *dev, void __iomem *regs)
 {
 	int i, j, rc, cpu, current_cpu, setup_count =3D 0;
@@ -265,8 +279,12 @@ int aplic_direct_setup(struct device *dev, void __iomem =
*regs)
 		cpumask_set_cpu(cpu, &direct->lmask);
=20
 		idc =3D per_cpu_ptr(&aplic_idcs, cpu);
-		idc->hart_index =3D i;
-		idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		rc =3D aplic_direct_get_hart_index(dev, i, &idc->hart_index);
+		if (rc) {
+			dev_warn(dev, "hart index not found for IDC%d\n", i);
+			continue;
+		}
+		idc->regs =3D priv->regs + APLIC_IDC_BASE + idc->hart_index * APLIC_IDC_SI=
ZE;
 		idc->direct =3D direct;
=20
 		aplic_idc_set_delivery(idc, true);

