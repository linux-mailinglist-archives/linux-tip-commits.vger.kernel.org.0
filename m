Return-Path: <linux-tip-commits+bounces-6143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D7B0A698
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B56A4250F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9B2DCF77;
	Fri, 18 Jul 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YLcND+Ie";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8weIswf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EA1865EE;
	Fri, 18 Jul 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850171; cv=none; b=M2FH3E7ohYdZIUvOfVtZuWnidS5h+PnWKutYOP8b+IVE2JP/ZdAm8xC4q3w3IncmToZkjA/bYz8PkQtkjvpKEq5LDDk6RFu+Pr4AvjKRD/LMu07CucdNFD+3FvpvjPuzSUEAsERDMhKsQgMWTrIoVDc8vL+Jy+Cr60yW1Etd9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850171; c=relaxed/simple;
	bh=+blt8HNQfzYoYwRZlrMBRFb/+nKoNp/PTtYKuDrBsok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d4YB8ENmR/13PZgSH+kJS+X4jGUIXjIdkbulv9rBbRg7+ch131lMAb9AknzZbMSeJdTCzYK+VyQc8S7Z3QC/N9g3aU+pGRUqa8jnczbJc9irITlzXzKZs7+Uy3MAeQuLRqfrbZO1OHtZ4h30G6mcH0PF/A2yjVsUlx9/UOVEnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YLcND+Ie; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8weIswf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 14:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Jzc8YIbYAYAj5BlZud5jGa+wK+NtVC+tDVndGEJSeY=;
	b=YLcND+Ie0g4Bt6+Xy+r5UUcxnZtutvv5wzZFI431quYmFfwkd12oekvrs+6t3/KOuYn7cr
	+shyLNqp1i32LVyPFgeDA5Zd1149RAyHe6JhdCId/sPDOhsIwDG6HhzoZWRP8htcGp8CsF
	OO2Ysl/jzMVOEJZpy4lkNpc+JrCVxmMwvzkBxtjRj8e3yyoJwY5azc0txLt27bnL/i8aUU
	hg5VzFFJ49qnShkp/5uRJdpVu8Wf0qjTQXaUtXKn77Bt64A1s8DRWDbX0fBTHrvs70VJGO
	+wGE3ZJ7BEj+1vmhU2TkTHAWaBz/OcfSMMGTP7d+gjWiUoVPdtwLJbYXiXG3fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Jzc8YIbYAYAj5BlZud5jGa+wK+NtVC+tDVndGEJSeY=;
	b=i8weIswf27VxdAg/p8CmNJiTaoEc2fuVOx4bBmaXaPwj+ZEHxSiz786DQFjKH7db6VOmnv
	MYYAWOQJy4Yq79Bg==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Add kernel parameter to disable IPIs
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250716123745.557585-1-apatel@ventanamicro.com>
References: <20250716123745.557585-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175285016711.406.12383282846563275165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     ea92b6046d352740c15f35e703c1b13a47dd99b0
Gitweb:        https://git.kernel.org/tip/ea92b6046d352740c15f35e703c1b13a47dd99b0
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Wed, 16 Jul 2025 18:07:45 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 16:46:09 +02:00

irqchip/riscv-imsic: Add kernel parameter to disable IPIs

When injecting IPIs to a set of harts, the IMSIC IPI support will do a
separate MMIO write to the SETIPNUM_LE register of each target hart. This
means on a platform where IMSIC is trap-n-emulated, there will be N MMIO
traps when injecting IPI to N target harts hence IMSIC IPIs will be slow on
such platforms compared to the SBI IPI extension.

Unfortunately, there is no DT, ACPI, or any other way of discovering
whether the underlying IMSIC is trap-n-emulated. Using MMIO write to the
SETIPNUM_LE register for injecting IPI is purely a software choice in the
IMSIC driver hence add a kernel parameter to allow users to disable IMSIC
IPIs on platforms with trap-n-emulated IMSIC.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250716123745.557585-1-apatel@ventanamicro.com

---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++++++-
 drivers/irqchip/irq-riscv-imsic-early.c         | 20 +++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.c         |  7 +++---
 drivers/irqchip/irq-riscv-imsic-state.h         |  1 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c08..7f0e12d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2538,6 +2538,13 @@
 			requires the kernel to be built with
 			CONFIG_ARM64_PSEUDO_NMI.
 
+	irqchip.riscv_imsic_noipi
+			[RISC-V,EARLY]
+			Force the kernel to not use IMSIC software injected MSIs
+			as IPIs. Intended for system where IMSIC is trap-n-emulated,
+			and thus want to reduce MMIO traps when triggering IPIs
+			to multiple harts.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index d9ae878..2709cac 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -21,6 +22,14 @@
 #include "irq-riscv-imsic-state.h"
 
 static int imsic_parent_irq;
+bool imsic_noipi __ro_after_init;
+
+static int __init imsic_noipi_cfg(char *buf)
+{
+	imsic_noipi = true;
+	return 0;
+}
+early_param("irqchip.riscv_imsic_noipi", imsic_noipi_cfg);
 
 #ifdef CONFIG_SMP
 static void imsic_ipi_send(unsigned int cpu)
@@ -32,12 +41,18 @@ static void imsic_ipi_send(unsigned int cpu)
 
 static void imsic_ipi_starting_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Enable IPIs for current CPU. */
 	__imsic_id_set_enable(IMSIC_IPI_ID);
 }
 
 static void imsic_ipi_dying_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Disable IPIs for current CPU. */
 	__imsic_id_clear_enable(IMSIC_IPI_ID);
 }
@@ -46,6 +61,9 @@ static int __init imsic_ipi_domain_init(void)
 {
 	int virq;
 
+	if (imsic_noipi)
+		return 0;
+
 	/* Create IMSIC IPI multiplexing */
 	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
 	if (virq <= 0)
@@ -88,7 +106,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
 		local_id >>= TOPEI_ID_SHIFT;
 
-		if (local_id == IMSIC_IPI_ID) {
+		if (!imsic_noipi && local_id == IMSIC_IPI_ID) {
 			if (IS_ENABLED(CONFIG_SMP))
 				ipi_mux_process();
 			continue;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 77670dd..dc95ad8 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -134,7 +134,7 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 	lockdep_assert_held(&lpriv->lock);
 
 	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
-		if (!i || i == IMSIC_IPI_ID)
+		if (!i || (!imsic_noipi && i == IMSIC_IPI_ID))
 			goto skip;
 		vec = &lpriv->vectors[i];
 
@@ -419,7 +419,7 @@ void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int i
 	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
 	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
 	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
-		   (vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
+		   (!imsic_noipi && vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
 	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", is_enabled ? 1 : 0);
 	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", mvec ? 1 : 0);
 	if (mvec) {
@@ -583,7 +583,8 @@ static int __init imsic_matrix_init(void)
 	irq_matrix_assign_system(imsic->matrix, 0, false);
 
 	/* Reserve IPI ID because it is special and used internally */
-	irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
+	if (!imsic_noipi)
+		irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 3202ffa..57f9519 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -61,6 +61,7 @@ struct imsic_priv {
 	struct irq_domain			*base_domain;
 };
 
+extern bool imsic_noipi;
 extern struct imsic_priv *imsic;
 
 void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, bool val);

