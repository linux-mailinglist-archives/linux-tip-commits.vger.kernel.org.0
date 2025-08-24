Return-Path: <linux-tip-commits+bounces-6333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51BB32F21
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D41C1B237FB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90577275846;
	Sun, 24 Aug 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zJP3goB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dG3lH7LK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894F275AE6;
	Sun, 24 Aug 2025 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032922; cv=none; b=aayXWIzyk/qo5kITzCaDGhbGdo9AnK8+m3PQXJ2241Q9eF8zStI2GMWieCNNE412gJAwoewFCPY9vBeG6PE5tqJtFGXcNCUT+JDPvDVDWv0r6iUxj8fTLdpThN4JzvrR8oE1sPQ63AvFc6LvxoWrSA52nNviFxToA86tTwa5+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032922; c=relaxed/simple;
	bh=CHD1BWuYmK4Bd9BKrUCAupeCheBxVwGwDvoAw8RHe5k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vdvtta25DA16hU/OWRCUNghXpz0vrdeF+YfKgFcpFI6hu6A2ydk0LeENIxwOCSyPedIqtEMsUGK7i8N4YpcrprEvGeXeNFpFd7NCTATJ2udiF0hPlSkesVi8qPmr4LtdKLrZhaN244x4Pob0+sASb75WzW69QK4nDrll6azn7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zJP3goB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dG3lH7LK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756032918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jPlC9bD8QpjfS1myisX/2fFrSsT+XqXOrnDTHhLAdg=;
	b=3zJP3goBWkyWT8++VRb3k3OgJJ7cQ8pxshu6CUk+jTQW+UbLYaENpmebEWvwqyqOWcas8K
	bMF0u6IMuk+GIiDzsE22xgytr1Yn/A1PG/CPgW5jk1x6ahrmTrbHSpliAOD/i2Vr+1suGu
	k5Z4AWu2Vt2E9HQCpZtc7V1IpvfxwmvhR+bvlS6x2DZysuZhHUFOkL/QkxAjJmUASbIpFf
	PUmN5tFgceZnyOjb+htjuzZvZfQ0VjyvqW81T+byoC3A6haF4uQbS0KfjMhlFf3TbFCvzp
	H0pYeZcD0oW7gosOVYJOIxgyzVh0CgKUkeVUWqUhqNkU/N4JAcXSml0xBlbtfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756032918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jPlC9bD8QpjfS1myisX/2fFrSsT+XqXOrnDTHhLAdg=;
	b=dG3lH7LK8rXROa9qhvcXpEg9EH9Glg+GGY5X1bc4E5beoqDlyaEqHofhJdXS6+Mo8P8hkp
	8VdCpboI6KY4EfDg==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-eiointc: Add multiple interrupt
 pin routing support
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250804081946.1456573-3-maobibo@loongson.cn>
References: <20250804081946.1456573-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603291668.1420.4658443638751505549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8ff1c16c753e293c3ba20583cb64f81ea7b9a451
Gitweb:        https://git.kernel.org/tip/8ff1c16c753e293c3ba20583cb64f81ea7b=
9a451
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Mon, 04 Aug 2025 16:19:46 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:51:04 +02:00

irqchip/loongson-eiointc: Add multiple interrupt pin routing support

The eiointc interrupt controller supports 256 interrupt vectors at most,
and the interrupt handler gets the interrupt status from the base register
group EIOINTC_REG_ISR at the interrupt specific offset.

It needs to read the register group EIOINTC_REG_ISR four times to get all
256 interrupt vectors status.

Eiointc registers including EIOINTC_REG_ISR are software emulated for
VMs, so there will be VM-exits when accessing eiointc registers.

Introduce a method to make the eiointc interrupt controller route
to different CPU interrupt pins for every 64 interrupt vectors.

The interrupt handler can then reduce the read to one specific
EIOINTC_REG_ISR register instead of all four, which reduces VM exits.

[ tglx: Massage change log ]

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250804081946.1456573-3-maobibo@loongson.cn

---
 drivers/irqchip/irq-loongson-eiointc.c | 88 ++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index baa4069..39e5a72 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -46,6 +46,7 @@
 #define EIOINTC_ALL_ENABLE_VEC_MASK(vector)	(EIOINTC_ALL_ENABLE & ~BIT(vecto=
r & 0x1f))
 #define EIOINTC_REG_ENABLE_VEC(vector)		(EIOINTC_REG_ENABLE + ((vector >> 5)=
 << 2))
 #define EIOINTC_USE_CPU_ENCODE			BIT(0)
+#define EIOINTC_ROUTE_MULT_IP			BIT(1)
=20
 #define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
=20
@@ -59,6 +60,14 @@
 #define EIOINTC_REG_ROUTE_VEC_MASK(vector)	(0xff << EIOINTC_REG_ROUTE_VEC_SH=
IFT(vector))
=20
 static int nr_pics;
+struct eiointc_priv;
+
+struct eiointc_ip_route {
+	struct eiointc_priv	*priv;
+	/* Offset Routed destination IP */
+	int			start;
+	int			end;
+};
=20
 struct eiointc_priv {
 	u32			node;
@@ -69,6 +78,7 @@ struct eiointc_priv {
 	struct irq_domain	*eiointc_domain;
 	int			flags;
 	irq_hw_number_t		parent_hwirq;
+	struct eiointc_ip_route	route_info[VEC_REG_COUNT];
 };
=20
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -189,6 +199,7 @@ static int eiointc_router_init(unsigned int cpu)
 {
 	int i, bit, cores, index, node;
 	unsigned int data;
+	int hwirq, mask;
=20
 	node =3D cpu_to_eio_node(cpu);
 	index =3D eiointc_index(node);
@@ -198,6 +209,13 @@ static int eiointc_router_init(unsigned int cpu)
 		return -EINVAL;
 	}
=20
+	/* Enable cpu interrupt pin from eiointc */
+	hwirq =3D eiointc_priv[index]->parent_hwirq;
+	mask =3D BIT(hwirq);
+	if (eiointc_priv[index]->flags & EIOINTC_ROUTE_MULT_IP)
+		mask |=3D BIT(hwirq + 1) | BIT(hwirq + 2) | BIT(hwirq + 3);
+	set_csr_ecfg(mask);
+
 	if (!(eiointc_priv[index]->flags & EIOINTC_USE_CPU_ENCODE))
 		cores =3D CORES_PER_EIO_NODE;
 	else
@@ -215,10 +233,28 @@ static int eiointc_router_init(unsigned int cpu)
 			/*
 			 * Route to interrupt pin, relative offset used here
 			 * Offset 0 means routing to IP0 and so on
-			 * Every 32 vector routing to one interrupt pin
+			 *
+			 * If flags is set with EIOINTC_ROUTE_MULT_IP,
+			 * every 64 vector routes to different consecutive
+			 * IPs, otherwise all vector routes to the same IP
 			 */
-			bit =3D BIT(eiointc_priv[index]->parent_hwirq - INT_HWI0);
-			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			if (eiointc_priv[index]->flags & EIOINTC_ROUTE_MULT_IP) {
+				/* The first 64 vectors route to hwirq */
+				bit =3D BIT(hwirq++ - INT_HWI0);
+				data =3D bit | (bit << 8);
+
+				/* The second 64 vectors route to hwirq + 1 */
+				bit =3D BIT(hwirq++ - INT_HWI0);
+				data |=3D (bit << 16) | (bit << 24);
+
+				/*
+				 * Route to hwirq + 2/hwirq + 3 separately
+				 * in next loop
+				 */
+			} else  {
+				bit =3D BIT(hwirq - INT_HWI0);
+				data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			}
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
=20
@@ -247,15 +283,22 @@ static int eiointc_router_init(unsigned int cpu)
=20
 static void eiointc_irq_dispatch(struct irq_desc *desc)
 {
-	int i;
-	u64 pending;
-	bool handled =3D false;
+	struct eiointc_ip_route *info =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	struct eiointc_priv *priv =3D irq_desc_get_handler_data(desc);
+	bool handled =3D false;
+	u64 pending;
+	int i;
=20
 	chained_irq_enter(chip, desc);
=20
-	for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
+	/*
+	 * If EIOINTC_ROUTE_MULT_IP is set, every 64 interrupt vectors in
+	 * eiointc interrupt controller routes to different cpu interrupt pins
+	 *
+	 * Every cpu interrupt pin has its own irq handler, it is ok to
+	 * read ISR for these 64 interrupt vectors rather than all vectors
+	 */
+	for (i =3D info->start; i < info->end; i++) {
 		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
=20
 		/* Skip handling if pending bitmap is zero */
@@ -268,7 +311,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 			int bit =3D __ffs(pending);
 			int irq =3D bit + VEC_COUNT_PER_REG * i;
=20
-			generic_handle_domain_irq(priv->eiointc_domain, irq);
+			generic_handle_domain_irq(info->priv->eiointc_domain, irq);
 			pending &=3D ~BIT(bit);
 			handled =3D true;
 		}
@@ -468,8 +511,33 @@ static int __init eiointc_init(struct eiointc_priv *priv=
, int parent_irq,
 	}
=20
 	eiointc_priv[nr_pics++] =3D priv;
+	/*
+	 * Only the first eiointc device on VM supports routing to
+	 * different CPU interrupt pins. The later eiointc devices use
+	 * generic method if there are multiple eiointc devices in future
+	 */
+	if (cpu_has_hypervisor && (nr_pics =3D=3D 1)) {
+		priv->flags |=3D EIOINTC_ROUTE_MULT_IP;
+		priv->parent_hwirq =3D INT_HWI0;
+	}
+
+	if (priv->flags & EIOINTC_ROUTE_MULT_IP) {
+		for (i =3D 0; i < priv->vec_count / VEC_COUNT_PER_REG; i++) {
+			priv->route_info[i].start  =3D priv->parent_hwirq - INT_HWI0 + i;
+			priv->route_info[i].end    =3D priv->route_info[i].start + 1;
+			priv->route_info[i].priv   =3D priv;
+			parent_irq =3D get_percpu_irq(priv->parent_hwirq + i);
+			irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch,
+							 &priv->route_info[i]);
+		}
+	} else {
+		priv->route_info[0].start  =3D 0;
+		priv->route_info[0].end    =3D priv->vec_count / VEC_COUNT_PER_REG;
+		priv->route_info[0].priv   =3D priv;
+		irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch,
+						 &priv->route_info[0]);
+	}
 	eiointc_router_init(0);
-	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
=20
 	if (nr_pics =3D=3D 1) {
 		register_syscore_ops(&eiointc_syscore_ops);

