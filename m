Return-Path: <linux-tip-commits+bounces-1533-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71091602E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512F6282CCE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34874146A7D;
	Tue, 25 Jun 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sYxy+oXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfLtxt66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A411369AE;
	Tue, 25 Jun 2024 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301283; cv=none; b=sqh92FiPM0vvt89HlmDN4m99AFD0HxtXmDXBm1iwMakBIOcypC0V6v4+Se2iHh1xGgS9PljJVD+J2r9Z40gsa+u8OHkh2COauxYajMl/615wbS66OBOvQaBybHs7/4/6DSxCqevbAOH3qh9D7WmRALsZe6Mjvh2kLnQBcEqRS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301283; c=relaxed/simple;
	bh=/d1QknNJCK80px7GytL/ySI5xd8arxrhFCKgkpVUN58=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qe3ZkOw0XlyuED40EWx7LmfVNuqNx/9HgEaMyk3UTZT3Y4LFnQaTlLmzqXauxioDMGmCDXAU8iyvsm6jD9u4rblvntOj7K70193TbD2k0BK4gcoXeWV5G2uayhhYqRnX1nS1kDcEtHDsFZvl7AGl3J2JJnoG8cLJAGzKmo9PfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sYxy+oXs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfLtxt66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 07:41:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719301279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsYoyx+bQNzcfWB006C/QWVfonHFmOc0t52b9kG0/YI=;
	b=sYxy+oXsX2a+4p1mn5ojKggckSgRPq+6p6HD7paE/B+GSG06vku2/Ve47KCQs2IHGvAXqP
	i+U+Z1Ms5GQPCRVXWV81b+h2QG/BpwfK6ZeZdbk2Vb15SrMceP07YHtChnuGcpJt5OMcde
	vmPjf/jgSkOg9bB/5vVDK7ZVZhfJAvnvlNr41Z6qcFTtQThgKfVFc0gXD0co/mXrcL8x+0
	6PlT+amwoNp0N5UK8GZ94Qd4qu+cWvDIJQMTjqjCMK79154iX4gwVj45fIrDq5ngV3THSk
	FSTgTB6TZA8uxnF0ifagDL4HYbIMuLGXBjXwX3vgNtSC/G1pS/j9DoqyMaokEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719301279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BsYoyx+bQNzcfWB006C/QWVfonHFmOc0t52b9kG0/YI=;
	b=KfLtxt66LMlJdyfAkVZw5HD/kmG3MqnlZD1A8LjEFOcvuFkmYRaiH4CtX4TJlAu4Mfyt8Y
	Z+dzMvWt4gBVrjAw==
From: "tip-bot2 for Song Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/loongson-eiointc: Add extioi virt extension support
Cc: Song Gao <gaosong@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240624084410.1026648-1-gaosong@loongson.cn>
References: <20240624084410.1026648-1-gaosong@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171930127860.2215.261263980041397611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aab92ac8a72d538cead496367add227dd9edbab8
Gitweb:        https://git.kernel.org/tip/aab92ac8a72d538cead496367add227dd9e=
dbab8
Author:        Song Gao <gaosong@loongson.cn>
AuthorDate:    Mon, 24 Jun 2024 16:44:10 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Jun 2024 09:38:07 +02:00

irqchip/loongson-eiointc: Add extioi virt extension support

Interrupts can be routed to maximal four virtual CPUs with one external
hardware interrupt.

Add the extioi virt extension support so that interrupts can be routed to
256 virtual CPUs in hypervisor mode.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240624084410.1026648-1-gaosong@loongson.cn
---
 Documentation/arch/loongarch/irq-chip-model.rst                    |  32 +++=
+++++++++++++++++++-
 Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst |  29 +++=
+++++++++++++++++-
 arch/loongarch/include/asm/irq.h                                   |   1 +-
 drivers/irqchip/irq-loongson-eiointc.c                             | 104 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 4 files changed, 146 insertions(+), 20 deletions(-)

diff --git a/Documentation/arch/loongarch/irq-chip-model.rst b/Documentation/=
arch/loongarch/irq-chip-model.rst
index 7988f41..36435f2 100644
--- a/Documentation/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/arch/loongarch/irq-chip-model.rst
@@ -85,6 +85,38 @@ to CPUINTC directly::
     | Devices |
     +---------+
=20
+Virtual extended IRQ model
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer interrupt
+go to CPUINTC directly, CPU UARTS interrupts go to PCH-PIC, while all other
+devices interrupts go to PCH-PIC/PCH-MSI and gathered by V-EIOINTC (Virtual
+Extended I/O Interrupt Controller), and then go to CPUINTC directly::
+
+       +-----+    +-------------------+     +-------+
+       | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
+       +-----+    +-------------------+     +-------+
+                            ^
+                            |
+                      +-----------+
+                      | V-EIOINTC |
+                      +-----------+
+                       ^         ^
+                       |         |
+                +---------+ +---------+
+                | PCH-PIC | | PCH-MSI |
+                +---------+ +---------+
+                  ^      ^          ^
+                  |      |          |
+           +--------+ +---------+ +---------+
+           | UARTs  | | Devices | | Devices |
+           +--------+ +---------+ +---------+
+
+
+V-EIOINTC (Virtual Extended I/O Interrupt Controller) is an extension of EIO=
INTC,
+it only works in hypervior mode. Interrupts can be routed to up to four virt=
ual
+cpus via EIOINTC, but interrupts can be routed to up to 256 virtual cpus via=
 V-EIOINTC.
+
 ACPI-related definitions
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.r=
st b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
index f1e9ab1..f211ed1 100644
--- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
+++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
@@ -87,6 +87,35 @@ PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=ABEIOINTC=
=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=A5=E5=
=88=B0=E8=BE=BECPUINTC::
     | Devices |
     +---------+
=20
+=E8=99=9A=E6=8B=9F=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2, IPI(Inter-P=
rocessor Interrupt) =E5=92=8CCPU=E6=9C=AC=E5=9C=B0=E6=97=B6=E9=92=9F=E4=B8=AD=
=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=80=81=E5=88=B0CPUINTC,
+CPU=E4=B8=B2=E5=8F=A3 (UARTs) =E4=B8=AD=E6=96=AD=E5=8F=91=E9=80=81=E5=88=B0P=
CH-PIC, =E8=80=8C=E5=85=B6=E4=BB=96=E6=89=80=E6=9C=89=E8=AE=BE=E5=A4=87=E7=9A=
=84=E4=B8=AD=E6=96=AD=E5=88=99=E5=88=86=E5=88=AB=E5=8F=91=E9=80=81=E5=88=B0=
=E6=89=80=E8=BF=9E=E6=8E=A5=E7=9A=84PCH_PIC/
+PCH-MSI, =E7=84=B6=E5=90=8EV-EIOINTC=E7=BB=9F=E4=B8=80=E6=94=B6=E9=9B=86=EF=
=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=A5=E5=88=B0=E8=BE=BECPUINTC::
+
+        +-----+    +-------------------+     +-------+
+        | IPI |--> | CPUINTC(0-255vcpu)| <-- | Timer |
+        +-----+    +-------------------+     +-------+
+                             ^
+                             |
+                       +-----------+
+                       | V-EIOINTC |
+                       +-----------+
+                        ^         ^
+                        |         |
+                 +---------+ +---------+
+                 | PCH-PIC | | PCH-MSI |
+                 +---------+ +---------+
+                   ^      ^          ^
+                   |      |          |
+            +--------+ +---------+ +---------+
+            | UARTs  | | Devices | | Devices |
+            +--------+ +---------+ +---------+
+
+V-EIOINTC =E6=98=AFEIOINTC=E7=9A=84=E6=89=A9=E5=B1=95, =E4=BB=85=E5=B7=A5=E4=
=BD=9C=E5=9C=A8hyperisor=E6=A8=A1=E5=BC=8F=E4=B8=8B, =E4=B8=AD=E6=96=AD=E7=BB=
=8FEIOINTC=E6=9C=80=E5=A4=9A=E5=8F=AF=E4=B8=AA=E8=B7=AF=E7=94=B1=E5=88=B0=EF=
=BC=94=E4=B8=AA
+=E8=99=9A=E6=8B=9Fcpu. =E4=BD=86=E4=B8=AD=E6=96=AD=E7=BB=8FV-EIOINTC=E6=9C=
=80=E5=A4=9A=E5=8F=AF=E4=B8=AA=E8=B7=AF=E7=94=B1=E5=88=B0256=E4=B8=AA=E8=99=
=9A=E6=8B=9Fcpu.
+
 ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/ir=
q.h
index 480418b..c97a7ab 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -53,6 +53,7 @@ struct acpi_vector_group {
 extern struct acpi_vector_group pch_group[MAX_IO_PICS];
 extern struct acpi_vector_group msi_group[MAX_IO_PICS];
=20
+#define MAX_CORES_PER_EIO_NODE	256
 #define CORES_PER_EIO_NODE	4
=20
 #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index c7ddebf..891cb27 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -23,15 +23,43 @@
 #define EIOINTC_REG_ISR		0x1800
 #define EIOINTC_REG_ROUTE	0x1c00
=20
+#define EXTIOI_VIRT_FEATURES           0x40000000
+#define  EXTIOI_HAS_VIRT_EXTENSION     BIT(0)
+#define  EXTIOI_HAS_ENABLE_OPTION      BIT(1)
+#define  EXTIOI_HAS_INT_ENCODE         BIT(2)
+#define  EXTIOI_HAS_CPU_ENCODE         BIT(3)
+#define EXTIOI_VIRT_CONFIG             0x40000004
+#define  EXTIOI_ENABLE                 BIT(1)
+#define  EXTIOI_ENABLE_INT_ENCODE      BIT(2)
+#define  EXTIOI_ENABLE_CPU_ENCODE      BIT(3)
+
 #define VEC_REG_COUNT		4
 #define VEC_COUNT_PER_REG	64
 #define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
 #define EIOINTC_ALL_ENABLE	0xffffffff
+#define EIOINTC_ALL_ENABLE_VEC_MASK(vector) 	\
+	(EIOINTC_ALL_ENABLE & ~BIT(vector & 0x1F))
+#define EIOINTC_REG_ENABLE_VEC(vector)		\
+	(EIOINTC_REG_ENABLE + ((vector >> 5) << 2))
=20
 #define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
=20
+/*
+ * Routing registers contain four vectors and have an offset of four to
+ * the base. The routing information is 8 bit wide.
+ */
+
+#define EIOINTC_REG_ROUTE_VEC(vector)		\
+	(EIOINTC_REG_ROUTE + (vector & ~0x03))
+
+#define EIOINTC_REG_ROUTE_VEC_SHIFT(vector) 	\
+	((vector & 0x03) << 3)
+
+#define EIOINTC_REG_ROUTE_VEC_MASK(vector)	\
+	(0xff << EIOINTC_REG_ROUTE_VEC_SHIFT(vector))
+
 static int nr_pics;
=20
 struct eiointc_priv {
@@ -41,6 +69,7 @@ struct eiointc_priv {
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
 	struct irq_domain	*eiointc_domain;
+	bool			cpu_encoded;
 };
=20
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -56,7 +85,9 @@ static void eiointc_enable(void)
=20
 static int cpu_to_eio_node(int cpu)
 {
-	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	int cores =3D cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_N=
ODE;
+
+	return cpu_logical_map(cpu) / cores;
 }
=20
 #ifdef CONFIG_SMP
@@ -88,6 +119,16 @@ static void eiointc_set_irq_route(int pos, unsigned int c=
pu, unsigned int mnode,
=20
 static DEFINE_RAW_SPINLOCK(affinity_lock);
=20
+static void virt_extioi_set_irq_route(unsigned int vector, unsigned int cpu)
+{
+	unsigned long reg =3D EIOINTC_REG_ROUTE_VEC(vector);
+	u32 data =3D iocsr_read32(reg);
+
+	data &=3D ~EIOINTC_REG_ROUTE_VEC_MASK(vector);
+	data |=3D cpu_logical_map(cpu) << EIOINTC_REG_ROUTE_VEC_SHIFT(vector);
+	iocsr_write32(data, reg);
+}
+
 static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask=
 *affinity, bool force)
 {
 	unsigned int cpu;
@@ -104,18 +145,24 @@ static int eiointc_set_irq_affinity(struct irq_data *d,=
 const struct cpumask *af
 	}
=20
 	vector =3D d->hwirq;
-	regaddr =3D EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
-
-	/* Mask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)),
-			0x0, priv->node * CORES_PER_EIO_NODE);
-
-	/* Set route for target vector */
-	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
-
-	/* Unmask target vector */
-	csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
-			0x0, priv->node * CORES_PER_EIO_NODE);
+	regaddr =3D EIOINTC_REG_ENABLE_VEC(vector);
+
+	if (priv->cpu_encoded) {
+		iocsr_write32(EIOINTC_ALL_ENABLE_VEC_MASK(vector), regaddr);
+		virt_extioi_set_irq_route(vector, cpu);
+		iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
+	} else {
+		/* Mask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE_VEC_MASK(vector),
+			     0x0, priv->node * CORES_PER_EIO_NODE);
+
+		/* Set route for target vector */
+		eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+
+		/* Unmask target vector */
+		csr_any_send(regaddr, EIOINTC_ALL_ENABLE,
+			     0x0, priv->node * CORES_PER_EIO_NODE);
+	}
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
@@ -139,17 +186,20 @@ static int eiointc_index(int node)
=20
 static int eiointc_router_init(unsigned int cpu)
 {
-	int i, bit;
-	uint32_t data;
-	uint32_t node =3D cpu_to_eio_node(cpu);
-	int index =3D eiointc_index(node);
+	int i, bit, cores, index;
+	uint32_t data, node;
+
+	node =3D cpu_to_eio_node(cpu);
+	index =3D eiointc_index(node);
=20
 	if (index < 0) {
 		pr_err("Error: invalid nodemap!\n");
-		return -1;
+		return -EINVAL;
 	}
=20
-	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) =3D=3D 0) {
+	cores =3D (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PER_EIO_NODE=
);
+
+	if ((cpu_logical_map(cpu) % cores) =3D=3D 0) {
 		eiointc_enable();
=20
 		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32; i++) {
@@ -165,7 +215,9 @@ static int eiointc_router_init(unsigned int cpu)
=20
 		for (i =3D 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
-			if (index =3D=3D 0)
+			if (eiointc_priv[index]->cpu_encoded)
+				bit =3D cpu_logical_map(0);
+			else if (index =3D=3D 0)
 				bit =3D BIT(cpu_logical_map(0));
 			else
 				bit =3D (eiointc_priv[index]->node << 4) | 1;
@@ -369,6 +421,7 @@ static int __init acpi_cascade_irqdomain_init(void)
 static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
 			       u64 node_map)
 {
+	u32 val;
 	int i;
=20
 	node_map =3D node_map ? node_map : -1ULL;
@@ -389,6 +442,17 @@ static int __init eiointc_init(struct eiointc_priv *priv=
, int parent_irq,
 		return -ENOMEM;
 	}
=20
+	if (cpu_has_hypervisor) {
+		val =3D iocsr_read32(EXTIOI_VIRT_FEATURES);
+		if (val & BIT(EXTIOI_HAS_CPU_ENCODE)) {
+			val =3D iocsr_read32(EXTIOI_VIRT_CONFIG);
+			val |=3D BIT(EXTIOI_ENABLE_CPU_ENCODE);
+			iocsr_write32(val, EXTIOI_VIRT_CONFIG);
+			priv->cpu_encoded =3D true;
+			pr_info("loongson-extioi: enable cpu encodig \n");
+		}
+	}
+
 	eiointc_priv[nr_pics++] =3D priv;
 	eiointc_router_init(0);
 	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);

