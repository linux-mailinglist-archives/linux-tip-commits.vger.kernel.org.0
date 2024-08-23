Return-Path: <linux-tip-commits+bounces-2100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDA95D56E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B068C1C2162E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1A192586;
	Fri, 23 Aug 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1D0R8ex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Nm3dL65"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D2139D13;
	Fri, 23 Aug 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438710; cv=none; b=T3VHPTSabzvRUYLHH1NZwgzfeSaSBnWcCCa3JDHcs5jsWkQJnThxEIzWUgp6HjOcA/8XD9e4OymwjSnXh9QEnFnFXxZN0IBh+Bdn7Y4elGRAmtKa/TiMytGBIGIFnHffM39Z0Qq/YMEKLzaPOD+GYDSbnDSfiWbh/brDJGJWxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438710; c=relaxed/simple;
	bh=r4jsmpsA1dCpKWJM+R6+Fr7/aoaSLJmHIfM10kiKR5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WLODLgI/4r7P6lX8JSU8Mp95wSLQdORagDhLrW/FRt0IXmI3Y4eppCZ3UWaUZfY+k24DhPXYf4VlpCEl2iz+Kdu4FN2gNXLhfNr635vbCYuu1hKxr5LCuBdwNw/c6ilZDq/vgJ3/jDrInSAIDXCeGYk1JZOsMoTrumC6O/7T1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1D0R8ex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Nm3dL65; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:45:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLSsiYXrsUjBeyHX97HxYgxnm6It0sTnqlfe58L5dI=;
	b=B1D0R8exJu2OhcEjab157ljk2qI9/W0SQbcWbEq2P1UO9wvWwqEJ6SzSU9mbnjalItvZrG
	uMoc2EFPvMMAKeE3HQIpodgQuGUsErM5+pXUpEOSmgW3I+FDhSkAvQyo3kLZGAtsr171HP
	ejE0tYldCO8haWeO6V3usaZFaSg5Kieneak9Drojjndg4IdcYTpHp+ndWsq7vPLYNp/Tq3
	HPzoztQcGJ0K1lCC1AyrcHSmoe775BAVHew2KMp0uaeM4R/Xy2VNu6siDVp+VkpJ52eZBA
	1rjo0dWh6h+kmiX/pyaQ06UNEgcBuAcawby5vpBodJGwZUDMz+Qo32xbYnEWvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTLSsiYXrsUjBeyHX97HxYgxnm6It0sTnqlfe58L5dI=;
	b=9Nm3dL65+jyKQuKAz86GvYIArfFE46G9rzHI+d5v8cdSc/qHb0rFvmgBpjunIivjrNUel+
	sxmvoi5ABxFsEFDQ==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] LoongArch: Move irqchip function prototypes to irq-loongson.h
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240823103936.25092-1-zhangtianyang@loongson.cn>
References: <20240823103936.25092-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443870625.2215.11571029248709863143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     06fac729a6d54e2c6650b38734f84383aafb3acc
Gitweb:        https://git.kernel.org/tip/06fac729a6d54e2c6650b38734f84383aafb3acc
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Fri, 23 Aug 2024 18:39:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:40:27 +02:00

LoongArch: Move irqchip function prototypes to irq-loongson.h

Some irqchip functions are only for internal use by irqchip drivers, so
move their prototypes from asm/irq.h to drivers/irqchip/irq-loongson.h.

All related driver files include the new irq-loongson.h.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240823103936.25092-1-zhangtianyang@loongson.cn

---
 arch/loongarch/include/asm/irq.h       | 14 +--------------
 drivers/irqchip/irq-loongarch-cpu.c    |  2 ++-
 drivers/irqchip/irq-loongson-eiointc.c |  2 ++-
 drivers/irqchip/irq-loongson-htvec.c   |  2 ++-
 drivers/irqchip/irq-loongson-liointc.c |  2 ++-
 drivers/irqchip/irq-loongson-pch-lpc.c |  2 ++-
 drivers/irqchip/irq-loongson-pch-msi.c |  1 +-
 drivers/irqchip/irq-loongson-pch-pic.c |  2 ++-
 drivers/irqchip/irq-loongson.h         | 25 +++++++++++++++++++++++++-
 9 files changed, 38 insertions(+), 14 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongson.h

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 480418b..65503c9 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -88,20 +88,6 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
 
-int liointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lio_pic *acpi_liointc);
-int eiointc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_eio_pic *acpi_eiointc);
-
-int htvec_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_ht_pic *acpi_htvec);
-int pch_lpc_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_lpc_pic *acpi_pchlpc);
-int pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi);
-int pch_pic_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_bio_pic *acpi_pchpic);
-int find_pch_pic(u32 gsi);
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
 extern struct acpi_madt_lio_pic *acpi_liointc;
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 9d8f2c4..83f7492 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -13,6 +13,8 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
 
+#include "irq-loongson.h"
+
 static struct irq_domain *irq_domain;
 struct fwnode_handle *cpuintc_handle;
 
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index b1f2080..34b5ca2 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -17,6 +17,8 @@
 #include <linux/syscore_ops.h>
 #include <asm/numa.h>
 
+#include "irq-loongson.h"
+
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
 #define EIOINTC_REG_ENABLE	0x1600
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 0bff728..5da02c7 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 7c4fe7a..2b1bd4a 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -22,6 +22,8 @@
 #include <asm/loongson.h>
 #endif
 
+#include "irq-loongson.h"
+
 #define LIOINTC_CHIP_IRQ	32
 #define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
index 9b35492..2d4c3ec 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define LPC_INT_CTL		0x00
 #define LPC_INT_ENA		0x04
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 2242f63..d437318 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "irq-msi-lib.h"
+#include "irq-loongson.h"
 
 static int nr_pics;
 
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index cbaef65..69efda3 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 
+#include "irq-loongson.h"
+
 /* Registers */
 #define PCH_PIC_MASK		0x20
 #define PCH_PIC_HTMSI_EN	0x40
diff --git a/drivers/irqchip/irq-loongson.h b/drivers/irqchip/irq-loongson.h
new file mode 100644
index 0000000..b155f12
--- /dev/null
+++ b/drivers/irqchip/irq-loongson.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+#define _DRIVERS_IRQCHIP_IRQ_LOONGSON_H
+
+int find_pch_pic(u32 gsi);
+
+int liointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lio_pic *acpi_liointc);
+int eiointc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_eio_pic *acpi_eiointc);
+
+int htvec_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_ht_pic *acpi_htvec);
+int pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc);
+int pch_pic_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic);
+int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_LOONGSON_H */

