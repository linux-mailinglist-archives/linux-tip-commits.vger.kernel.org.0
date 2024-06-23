Return-Path: <linux-tip-commits+bounces-1490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4417913C5A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794951F218B1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C82C181D0B;
	Sun, 23 Jun 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="roCeXAV9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4b/DgJHv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B47181339;
	Sun, 23 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156632; cv=none; b=SXU4zEAqIlsQJ0MkutWf8GBCsWnJU40wCguEpRLUstSOCmGnTae1UPj7q78EjRowHbLS4V3To2bpDndiE3i2/vpmRqIYKwJqRtbRW0PJWk0l+70D9Q/92eOcNAwDLxwPqiBjxrrzrhaGj2Ff3jt6q901BJu0qyqanLYkCIocBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156632; c=relaxed/simple;
	bh=aawrE75p4FuFiOOSOXCeUFCKXhLcsvhjKYZu2fz6CiQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PsUhuuXFSp7dCaEAlOm04C0boBQZBmiNXozkZ8XOklr3rnLMCWIIIqfTVgmiykyRjKboKOeQWNRWGFnRBZL5q1OBpN60cE36AAJ9twNteEZ/TgDHdjXejvwMlj8oQwP7y2hDwVsRdVBufjjIFprl5JaaxLATlPdEeVf7Oz0VNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=roCeXAV9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4b/DgJHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7VAySAt0cIvCHU3YiYZZnvYYxoBW3xGbFfwDuq5+Y5I=;
	b=roCeXAV9JeDakSdyNUVHxYa30uS8LBUnnEU9KAMMXa1eHUZbyBtB4L7y7WFYPOhHdo2x61
	AjJgkupk824v1xZ8gHX/qrDejPUggZV3D5nK3xJoQVAT2zhp+hveMuHRdfAm7fkRnzhaN8
	VC4oONrpOZjx3AazjaN9fFQaYgFD1fRbjUc2qMkOtZRMIlKSPyUjEjL+wbpG5Ku2/GRyMg
	TIeZd+qjQX7PZ+lBMNBvfjNBMNi6HdHokkTeq9ecrqJ+cBiclzErZLcTyCyR48xTBWLcmU
	XiiGtbb8sF+YG0dI9BgnJMMdTmhCi5U6TQ2LvKOSXqj4Tx0kSmmplDTVSPoMHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7VAySAt0cIvCHU3YiYZZnvYYxoBW3xGbFfwDuq5+Y5I=;
	b=4b/DgJHve5Wr8UIX9RLw9L4+LzqMq4kQMzgO0Q8xiEEx2H5a/a5RuzuUxNGUvUEDk1Ppoo
	hPjYP6I1ZNtN/SCA==
From: tip-bot2 for Pali =?utf-8?q?Roh=C3=A1r?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Only call ipi_resume() if IPI
 is available
Cc: pali@kernel.org, kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662884.10875.17342495395410962795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     de796fc184179de86fb87f94178459b5b20b1b1b
Gitweb:        https://git.kernel.org/tip/de796fc184179de86fb87f94178459b5b20=
b1b1b
Author:        Pali Roh=C3=A1r <pali@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:38:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/armada-370-xp: Only call ipi_resume() if IPI is available

IPI is available only on systems where the mpic controller does not have a
parent interrupt defined (e.g. on Armada XP). If a parent interrupt is
defined, inter-processor interrupts are handled by an interrupt controller
higher in the hierarchy (most probably a parent GIC).

Only call ipi_resume() on systems where IPI is available in the mpic
controller.

Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

[ refactored a little and changed commit message ]
---
 drivers/irqchip/irq-armada-370-xp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 526077d..deb4c9b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/msi.h>
+#include <linux/types.h>
 #include <asm/mach/arch.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
@@ -156,6 +157,17 @@ static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
=20
+static inline bool is_ipi_available(void)
+{
+	/*
+	 * We distinguish IPI availability in the IC by the IC not having a
+	 * parent irq defined. If a parent irq is defined, there is a parent
+	 * interrupt controller (e.g. GIC) that takes care of inter-processor
+	 * interrupts.
+	 */
+	return parent_irq <=3D 0;
+}
+
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
 	if (irq <=3D ARMADA_370_XP_MAX_PER_CPU_IRQS)
@@ -521,7 +533,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 		armada_370_xp_irq_unmask(data);
 	}
=20
-	ipi_resume();
+	if (is_ipi_available())
+		ipi_resume();
=20
 	armada_370_xp_msi_reenable_percpu();
 }
@@ -744,7 +757,8 @@ static void armada_370_xp_mpic_resume(void)
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
=20
-	ipi_resume();
+	if (is_ipi_available())
+		ipi_resume();
 }
=20
 static struct syscore_ops armada_370_xp_mpic_syscore_ops =3D {

