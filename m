Return-Path: <linux-tip-commits+bounces-7004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8BC0F5AB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA11466FF5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8533314B69;
	Mon, 27 Oct 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDOUTE25";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZV7WrM+S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6C31327B;
	Mon, 27 Oct 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582659; cv=none; b=Cwh+PI9di5mj0cpnNoqdnOKv0oHmH8A67+sDihnlkQTcMLkfhBTlD+2OIE+naBW0yoOmTq59OQGm1P1Z+kE4UYdiSns82fNW6eKGEi85whj/+YIuN9jiBIg/C7x+kIa2ZZBuosJinCQAExv5BYRdNhXSN5poZxnsvPD1gOZt8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582659; c=relaxed/simple;
	bh=WrjJI7+ERdTDGsW78kzXYPB55t0V9oW40vEmP7zsqaA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PpHmgcqEQ0INIJTr0dGee/9Mf3C6kmZvfzd3s6yiwwrjmVW8pNmie5o37nZMZfRLiSrEHZY4S/cabRsSqKyp7AiyFRS+De6nk/IfPzmVYI+p0dvYmUEvpvJAY8eewMLzI3ykz5lgvaXXBG5re4JA6DAn81Oqqw/y9IrSu3rXHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDOUTE25; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZV7WrM+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mMeoKodPFmrdWnf/uX7RD4Ztc4wrRmubUia7AZuzL4=;
	b=mDOUTE25BHaIQo1wmOJJKNVmUW9b8lNlMyfYz2vVXipwQE09zzAq9ERFVoA/DnRdwfU18x
	Kw+wUSrMPYFL8F62QIqFtiw3fXK4km5YKKKz7NnUEmSWnAWmRPQTQUMN/Ma1W2Rf64zJnd
	6L3AygvenYgqMYrI7UKU8XWAEfibyPKOsUCE7zodpOKDxIq4R4Wryb1+g+LBdGviarOulD
	/0x++6TG3Z8QmniLDck3vOwXSLIK0T101VvGK7lGTGxSRmTOsRG29EBTHyLuRm+Fnps1aD
	e3o03/11dnkKJjAll7x3UFbDHVNEWFsjhlnj9xuhp21ZHJg/05YWlnWA6JbQog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mMeoKodPFmrdWnf/uX7RD4Ztc4wrRmubUia7AZuzL4=;
	b=ZV7WrM+Sd1ZOPu0An1oRJ2WM9uizV+yyw8V4XrMl2O5e+H/BBeoedU7VuJ+iKcSI/ywAF/
	I6Tx9bbdiee3CdBA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Kill irq-partition-percpu
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-24-maz@kernel.org>
References: <20251020122944.3074811-24-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265502.2601451.6654676472313258236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c620438ef2ac80b09269a9ae3c0b4fe5add19bfe
Gitweb:        https://git.kernel.org/tip/c620438ef2ac80b09269a9ae3c0b4fe5add=
19bfe
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:36 +01:00

irqchip: Kill irq-partition-percpu

This code is now completely unused, and nobody will ever miss it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-24-maz@kernel.org
---
 drivers/irqchip/Kconfig                      |   3 +-
 drivers/irqchip/Makefile                     |   1 +-
 drivers/irqchip/irq-partition-percpu.c       | 241 +------------------
 include/linux/irqchip/irq-partition-percpu.h |  53 +----
 4 files changed, 298 deletions(-)
 delete mode 100644 drivers/irqchip/irq-partition-percpu.c
 delete mode 100644 include/linux/irqchip/irq-partition-percpu.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 648b361..5dddb4c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -450,9 +450,6 @@ config LS_SCFG_MSI
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
=20
-config PARTITION_PERCPU
-	bool
-
 config STM32MP_EXTI
 	tristate "STM32MP extended interrupts and event controller"
 	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 3de083f..6a22944 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-mbi.=
o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_ITS_PARENT)	+=3D irq-gic-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
-obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
 obj-$(CONFIG_ARM_GIC_V5)		+=3D irq-gic-v5.o irq-gic-v5-irs.o irq-gic-v5-its.=
o \
 					   irq-gic-v5-iwb.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+=3D irq-mbigen.o
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-par=
tition-percpu.c
deleted file mode 100644
index 4441ffe..0000000
--- a/drivers/irqchip/irq-partition-percpu.c
+++ /dev/null
@@ -1,241 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2016 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/interrupt.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqchip/irq-partition-percpu.h>
-#include <linux/irqdomain.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-
-struct partition_desc {
-	int				nr_parts;
-	struct partition_affinity	*parts;
-	struct irq_domain		*domain;
-	struct irq_desc			*chained_desc;
-	unsigned long			*bitmap;
-	struct irq_domain_ops		ops;
-};
-
-static bool partition_check_cpu(struct partition_desc *part,
-				unsigned int cpu, unsigned int hwirq)
-{
-	return cpumask_test_cpu(cpu, &part->parts[hwirq].mask);
-}
-
-static void partition_irq_mask(struct irq_data *d)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_mask)
-		chip->irq_mask(data);
-}
-
-static void partition_irq_unmask(struct irq_data *d)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_unmask)
-		chip->irq_unmask(data);
-}
-
-static int partition_irq_set_irqchip_state(struct irq_data *d,
-					   enum irqchip_irq_state which,
-					   bool val)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_set_irqchip_state)
-		return chip->irq_set_irqchip_state(data, which, val);
-
-	return -EINVAL;
-}
-
-static int partition_irq_get_irqchip_state(struct irq_data *d,
-					   enum irqchip_irq_state which,
-					   bool *val)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	if (partition_check_cpu(part, smp_processor_id(), d->hwirq) &&
-	    chip->irq_get_irqchip_state)
-		return chip->irq_get_irqchip_state(data, which, val);
-
-	return -EINVAL;
-}
-
-static int partition_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	if (chip->irq_set_type)
-		return chip->irq_set_type(data, type);
-
-	return -EINVAL;
-}
-
-static void partition_irq_print_chip(struct irq_data *d, struct seq_file *p)
-{
-	struct partition_desc *part =3D irq_data_get_irq_chip_data(d);
-	struct irq_chip *chip =3D irq_desc_get_chip(part->chained_desc);
-	struct irq_data *data =3D irq_desc_get_irq_data(part->chained_desc);
-
-	seq_printf(p, "%5s-%lu", chip->name, data->hwirq);
-}
-
-static struct irq_chip partition_irq_chip =3D {
-	.irq_mask		=3D partition_irq_mask,
-	.irq_unmask		=3D partition_irq_unmask,
-	.irq_set_type		=3D partition_irq_set_type,
-	.irq_get_irqchip_state	=3D partition_irq_get_irqchip_state,
-	.irq_set_irqchip_state	=3D partition_irq_set_irqchip_state,
-	.irq_print_chip		=3D partition_irq_print_chip,
-};
-
-static void partition_handle_irq(struct irq_desc *desc)
-{
-	struct partition_desc *part =3D irq_desc_get_handler_data(desc);
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int cpu =3D smp_processor_id();
-	int hwirq;
-
-	chained_irq_enter(chip, desc);
-
-	for_each_set_bit(hwirq, part->bitmap, part->nr_parts) {
-		if (partition_check_cpu(part, cpu, hwirq))
-			break;
-	}
-
-	if (unlikely(hwirq =3D=3D part->nr_parts))
-		handle_bad_irq(desc);
-	else
-		generic_handle_domain_irq(part->domain, hwirq);
-
-	chained_irq_exit(chip, desc);
-}
-
-static int partition_domain_alloc(struct irq_domain *domain, unsigned int vi=
rq,
-				  unsigned int nr_irqs, void *arg)
-{
-	int ret;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct irq_fwspec *fwspec =3D arg;
-	struct partition_desc *part;
-
-	BUG_ON(nr_irqs !=3D 1);
-	ret =3D domain->ops->translate(domain, fwspec, &hwirq, &type);
-	if (ret)
-		return ret;
-
-	part =3D domain->host_data;
-
-	set_bit(hwirq, part->bitmap);
-	irq_set_chained_handler_and_data(irq_desc_get_irq(part->chained_desc),
-					 partition_handle_irq, part);
-	irq_set_percpu_devid_partition(virq, &part->parts[hwirq].mask);
-	irq_domain_set_info(domain, virq, hwirq, &partition_irq_chip, part,
-			    handle_percpu_devid_irq, NULL, NULL);
-	irq_set_status_flags(virq, IRQ_NOAUTOEN);
-
-	return 0;
-}
-
-static void partition_domain_free(struct irq_domain *domain, unsigned int vi=
rq,
-				  unsigned int nr_irqs)
-{
-	struct irq_data *d;
-
-	BUG_ON(nr_irqs !=3D 1);
-
-	d =3D irq_domain_get_irq_data(domain, virq);
-	irq_set_handler(virq, NULL);
-	irq_domain_reset_irq_data(d);
-}
-
-int partition_translate_id(struct partition_desc *desc, void *partition_id)
-{
-	struct partition_affinity *part =3D NULL;
-	int i;
-
-	for (i =3D 0; i < desc->nr_parts; i++) {
-		if (desc->parts[i].partition_id =3D=3D partition_id) {
-			part =3D &desc->parts[i];
-			break;
-		}
-	}
-
-	if (WARN_ON(!part)) {
-		pr_err("Failed to find partition\n");
-		return -EINVAL;
-	}
-
-	return i;
-}
-
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops)
-{
-	struct partition_desc *desc;
-	struct irq_domain *d;
-
-	BUG_ON(!ops->select || !ops->translate);
-
-	desc =3D kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return NULL;
-
-	desc->ops =3D *ops;
-	desc->ops.free =3D partition_domain_free;
-	desc->ops.alloc =3D partition_domain_alloc;
-
-	d =3D irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
-	if (!d)
-		goto out;
-	desc->domain =3D d;
-
-	desc->bitmap =3D bitmap_zalloc(nr_parts, GFP_KERNEL);
-	if (WARN_ON(!desc->bitmap))
-		goto out;
-
-	desc->chained_desc =3D irq_to_desc(chained_irq);
-	desc->nr_parts =3D nr_parts;
-	desc->parts =3D parts;
-
-	return desc;
-out:
-	if (d)
-		irq_domain_remove(d);
-	kfree(desc);
-
-	return NULL;
-}
-
-struct irq_domain *partition_get_domain(struct partition_desc *dsc)
-{
-	if (dsc)
-		return dsc->domain;
-
-	return NULL;
-}
diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irq=
chip/irq-partition-percpu.h
deleted file mode 100644
index b35ee22..0000000
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#ifndef __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
-#define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
-
-#include <linux/fwnode.h>
-#include <linux/cpumask_types.h>
-#include <linux/irqdomain.h>
-
-struct partition_affinity {
-	cpumask_t			mask;
-	void				*partition_id;
-};
-
-struct partition_desc;
-
-#ifdef CONFIG_PARTITION_PERCPU
-int partition_translate_id(struct partition_desc *desc, void *partition_id);
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops);
-struct irq_domain *partition_get_domain(struct partition_desc *dsc);
-#else
-static inline int partition_translate_id(struct partition_desc *desc,
-					 void *partition_id)
-{
-	return -EINVAL;
-}
-
-static inline
-struct partition_desc *partition_create_desc(struct fwnode_handle *fwnode,
-					     struct partition_affinity *parts,
-					     int nr_parts,
-					     int chained_irq,
-					     const struct irq_domain_ops *ops)
-{
-	return NULL;
-}
-
-static inline
-struct irq_domain *partition_get_domain(struct partition_desc *dsc)
-{
-	return NULL;
-}
-#endif
-
-#endif /* __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H */

