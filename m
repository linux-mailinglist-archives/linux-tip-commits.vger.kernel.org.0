Return-Path: <linux-tip-commits+bounces-8066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6441CD39560
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B46AD3027801
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5395132B990;
	Sun, 18 Jan 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0NtRlRgQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4ljM7HP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69001331A59;
	Sun, 18 Jan 2026 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743723; cv=none; b=bxx5sGL1k0zW27gJ/Rd8pjYUpTH1eKMlLpTfzXoDTzTxd0XrBofvhdEOsw8lcur9nJ8Phh+hQ8d6c5/b5RuxRhymPK4Vki4uafuWMsxvloyKuZYQSOlLNyvPa/RiuJr7Iz1cdflQdrGiditKlOzLxkrxWPHvFaysnOdR9jTd25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743723; c=relaxed/simple;
	bh=nXTKy2unTPBdwVRHqFJ6wSYWipsGe/R7Co6+Cm2ZCi4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rh/IGMwFkPBzGlosivcm3esURvaELbFzS76ZI0NQxDR8hFk7d5PYApKUG1my/memBHRcDqh8xZpRV7vNxBSaIV+zQPI9wYvT5piiTRYbu8VG7UY5Ls6qiwtqPy9FxoSmDOf961ZCAePDEMxSGwrys4NJDfevPHXVpbP5RrniXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0NtRlRgQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4ljM7HP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lai+1jwJT3c5xqCiOGGu1wWCnU/+ZQK+kr9wH6vtp+M=;
	b=0NtRlRgQU00dZbPaB2apo4d0Zn7DH9VAdHWQTxBghz3eQdJ9fvBTEADPk8oXohhj/0T5Zj
	G/M16C/ij5QUl31ZH5Hgw5c5DuqgFgo1EcxAbN5U+Zr7e7HhhI+F5tr4lQa5sY2s5JIvQw
	gw+x3QdTnUVlbt9x+MrCdrxPs+XUpVgBvcOAXozZxRklh1e52IrZdnUl6SCJglwJigyqwT
	jVZVWjNcaRzR2BcVgmnJxjosQMtkSfrWYK6ce82PMatK1/xQK087iwSSqLPSux27CC+5R+
	nWtIkOjJIDHWF504axKT76LUxvquZkYBLe/IhL3cARFjEifMjX1W8ek3bhIYPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743717;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lai+1jwJT3c5xqCiOGGu1wWCnU/+ZQK+kr9wH6vtp+M=;
	b=i4ljM7HPOCG7zeVbPTOwjHai+xDB4habf0FSxeoSJcM8UtpppjxCL+Wn7XivveDhLqw4bh
	sWb6B3xXeGOAmoCg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-eiointc: Adjust irqchip driver
 for 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-4-chenhuacai@loongson.cn>
References: <20260113085940.3344837-4-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176874371646.510.14542897108678824117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     61fb5e517ec457c76211f03ab0b379882248706d
Gitweb:        https://git.kernel.org/tip/61fb5e517ec457c76211f03ab0b37988224=
8706d
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:36 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:17 +01:00

irqchip/loongson-eiointc: Adjust irqchip driver for 32BIT/64BIT

iocsr_read64()/iocsr_write64() are only available on 64BIT LoongArch
platform, so add and use a pair of helpers, i.e. read_isr()/write_isr()
instead to make the driver work on both 32BIT and 64BIT platforms.

This makes eoiintc_enable() a no-op for 32-bit as it is only required on
64-bit systems.

[ tglx: Make the helpers inline and fixup the variable declaration order ]

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-4-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 36 ++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index ad21056..37e7e1f 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -37,9 +37,9 @@
 #define  EXTIOI_ENABLE_INT_ENCODE      BIT(2)
 #define  EXTIOI_ENABLE_CPU_ENCODE      BIT(3)
=20
-#define VEC_REG_COUNT		4
-#define VEC_COUNT_PER_REG	64
-#define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
+#define VEC_COUNT		256
+#define VEC_COUNT_PER_REG	BITS_PER_LONG
+#define VEC_REG_COUNT		(VEC_COUNT / BITS_PER_LONG)
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
 #define EIOINTC_ALL_ENABLE	0xffffffff
@@ -85,11 +85,13 @@ static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
=20
 static void eiointc_enable(void)
 {
+#ifdef CONFIG_MACH_LOONGSON64
 	uint64_t misc;
=20
 	misc =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
 	misc |=3D IOCSR_MISC_FUNC_EXT_IOI_EN;
 	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
+#endif
 }
=20
 static int cpu_to_eio_node(int cpu)
@@ -281,12 +283,34 @@ static int eiointc_router_init(unsigned int cpu)
 	return 0;
 }
=20
+#if VEC_COUNT_PER_REG =3D=3D 32
+static inline unsigned long read_isr(int i)
+{
+	return iocsr_read32(EIOINTC_REG_ISR + (i << 2));
+}
+
+static inline void write_isr(int i, unsigned long val)
+{
+	iocsr_write32(val, EIOINTC_REG_ISR + (i << 2));
+}
+#else
+static inline unsigned long read_isr(int i)
+{
+	return iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+}
+
+static inline void write_isr(int i, unsigned long val)
+{
+	iocsr_write64(val, EIOINTC_REG_ISR + (i << 3));
+}
+#endif
+
 static void eiointc_irq_dispatch(struct irq_desc *desc)
 {
 	struct eiointc_ip_route *info =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long pending;
 	bool handled =3D false;
-	u64 pending;
 	int i;
=20
 	chained_irq_enter(chip, desc);
@@ -299,14 +323,14 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 	 * read ISR for these 64 interrupt vectors rather than all vectors
 	 */
 	for (i =3D info->start; i < info->end; i++) {
-		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+		pending =3D read_isr(i);
=20
 		/* Skip handling if pending bitmap is zero */
 		if (!pending)
 			continue;
=20
 		/* Clear the IRQs */
-		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
+		write_isr(i, pending);
 		while (pending) {
 			int bit =3D __ffs(pending);
 			int irq =3D bit + VEC_COUNT_PER_REG * i;

