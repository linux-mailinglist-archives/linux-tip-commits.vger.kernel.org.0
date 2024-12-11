Return-Path: <linux-tip-commits+bounces-3053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104319ED6B6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Dec 2024 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D901884032
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Dec 2024 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA07202F88;
	Wed, 11 Dec 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/rSrIFh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzjvPjNt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781101C303E;
	Wed, 11 Dec 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946160; cv=none; b=cWaVmatvdud9Y63LmFQTdI9PgHHKJaTE0tlzzgY7UpI2RRM2C3pNSW5EaDqKIu7jR2HLiKOV/v/pNxlwvJCD8UfgvZhOWBVdwiwzpNTvIk14N2lcCw9iLXwFmrPf1LCe+Ozmi5aPIpwQRPeXX8L4IILpySZkFTpl0S8M4qepSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946160; c=relaxed/simple;
	bh=+dDPu/GXBL909b/WWV+MxkrEoWGlI93vY7xuZm+MU8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S/l57mIEmm7kVTWMsOnlFSQznumhnhVOv29xvQckG1YGmHYRYuAMCE73xSN8Y2rUm7mcNiR/EsDY77VkyEwzrheuB58Lc1M2zYKLi89tlg9Yy4P/ki/4uzzCeFLxWnZ8kX9KmzXhRT4rszBjKinfVnjkg6O5dF5AQ4ICaa5WXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/rSrIFh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzjvPjNt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Dec 2024 19:42:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733946156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeL5IFw7EX6PX5PbU4+Oly1SKx5ycGDg/axodGqS0u8=;
	b=a/rSrIFhKeJ6OJm4iOPVFmP5DW9RfPSwFwl6ghIqs0ppKOPzVs7MU4TTmxZpTbf13tMyk9
	4RcRfgFwq87I7XPtzi+A8RQi9d0wSKy0JD24PeahobDfYd1RI6jGIhwSqTXZHEPYW8/Hw+
	/8aanVzD5j2Viv+l0X+q220bpYOmaF6ocS0KknmrGaRRXKtOc9OAjWxASBugkhLcEB4f37
	/m+HtBMWajzYzyvwt4KhriPC31KUX1+8i8tIwSrfvQNTiEIxYQOsv3X/nC/4HHos6R4Mti
	zqjCYZaDQWVjKE3C7zIG21whlU6UiiOfHFCkVtjtmH663zR53Fy7H8jjwa1zEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733946156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeL5IFw7EX6PX5PbU4+Oly1SKx5ycGDg/axodGqS0u8=;
	b=FzjvPjNtdplvZ0YLcHA7gw4tOy5nX0UXrsga78pRXzKlLKz3UqZQJ/vv8YSoRmBs7ctRwC
	i7fFNQKUREIoFcAg==
From: "tip-bot2 for Eliav Farber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] kexec: Consolidate machine_kexec_mask_interrupts()
 implementation
Cc: Eliav Farber <farbere@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241204142003.32859-2-farbere@amazon.com>
References: <20241204142003.32859-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173394615569.412.14549389930277757733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bad6722e478f5b17a5ceb039dfb4c680cf2c0b48
Gitweb:        https://git.kernel.org/tip/bad6722e478f5b17a5ceb039dfb4c680cf2c0b48
Author:        Eliav Farber <farbere@amazon.com>
AuthorDate:    Wed, 04 Dec 2024 14:20:02 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Dec 2024 20:32:34 +01:00

kexec: Consolidate machine_kexec_mask_interrupts() implementation

Consolidate the machine_kexec_mask_interrupts implementation into a common
function located in a new file: kernel/irq/kexec.c. This removes duplicate
implementations from architecture-specific files in arch/arm, arch/arm64,
arch/powerpc, and arch/riscv, reducing code duplication and improving
maintainability.

The new implementation retains architecture-specific behavior for
CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD, which was previously implemented
for ARM64. When enabled (currently for ARM64), it clears the active state
of interrupts forwarded to virtual machines (VMs) before handling other
interrupt masking operations.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241204142003.32859-2-farbere@amazon.com

---
 arch/arm/kernel/machine_kexec.c   | 23 +-----------------
 arch/arm64/Kconfig                |  1 +-
 arch/arm64/kernel/machine_kexec.c | 31 +-----------------------
 arch/powerpc/include/asm/kexec.h  |  1 +-
 arch/powerpc/kexec/core.c         | 22 +-----------------
 arch/powerpc/kexec/core_32.c      |  1 +-
 arch/riscv/kernel/machine_kexec.c | 23 +-----------------
 include/linux/irq.h               |  3 ++-
 kernel/irq/Kconfig                |  6 +++++-
 kernel/irq/Makefile               |  2 +-
 kernel/irq/kexec.c                | 40 ++++++++++++++++++++++++++++++-
 11 files changed, 52 insertions(+), 101 deletions(-)
 create mode 100644 kernel/irq/kexec.c

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 80ceb5b..dd43047 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -127,29 +127,6 @@ void crash_smp_send_stop(void)
 	cpus_stopped = 1;
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	local_irq_disable();
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a..dcc3551 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -149,6 +149,7 @@ config ARM64
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 82e2203..6f121a0 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -207,37 +207,6 @@ void machine_kexec(struct kimage *kimage)
 	BUG(); /* Should never get here. */
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-		int ret;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		/*
-		 * First try to remove the active state. If this
-		 * fails, try to EOI the interrupt.
-		 */
-		ret = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
-
-		if (ret && irqd_irq_inprogress(&desc->irq_data) &&
-		    chip->irq_eoi)
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 /**
  * machine_crash_shutdown - shutdown non-crashing cpus and save registers
  */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 270ee93..601e569 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -61,7 +61,6 @@ struct pt_regs;
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
 extern void default_machine_kexec(struct kimage *image);
-extern void machine_kexec_mask_interrupts(void);
 
 void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_code_buffer,
 			 unsigned long start_address) __noreturn;
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index b8333a4..58a930a 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -22,28 +22,6 @@
 #include <asm/setup.h>
 #include <asm/firmware.h>
 
-void machine_kexec_mask_interrupts(void) {
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 #ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kexec/core_32.c b/arch/powerpc/kexec/core_32.c
index c95f968..deb28eb 100644
--- a/arch/powerpc/kexec/core_32.c
+++ b/arch/powerpc/kexec/core_32.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2005 IBM Corporation.
  */
 
+#include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/string.h>
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 3c830a6..2306ce3 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -114,29 +114,6 @@ void machine_shutdown(void)
 #endif
 }
 
-static void machine_kexec_mask_interrupts(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-
-	for_each_irq_desc(i, desc) {
-		struct irq_chip *chip;
-
-		chip = irq_desc_get_chip(desc);
-		if (!chip)
-			continue;
-
-		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
-			chip->irq_eoi(&desc->irq_data);
-
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
-	}
-}
-
 /*
  * machine_crash_shutdown - Prepare to kexec after a kernel crash
  *
diff --git a/include/linux/irq.h b/include/linux/irq.h
index fa711f8..25f51bf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -694,6 +694,9 @@ extern int irq_chip_request_resources_parent(struct irq_data *data);
 extern void irq_chip_release_resources_parent(struct irq_data *data);
 #endif
 
+/* Disable or mask interrupts during a kernel kexec */
+extern void machine_kexec_mask_interrupts(void);
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 529adb1..875f25e 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -141,6 +141,12 @@ config GENERIC_IRQ_DEBUGFS
 
 	  If you don't know what to do here, say N.
 
+# Clear forwarded VM interrupts during kexec.
+# This option ensures the kernel clears active states for interrupts
+# forwarded to virtual machines (VMs) during a machine kexec.
+config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
+	bool
+
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index f19d308..c0f44c0 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o
+obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o kexec.o
 obj-$(CONFIG_IRQ_TIMINGS) += timings.o
 ifeq ($(CONFIG_TEST_IRQ_TIMINGS),y)
 	CFLAGS_timings.o += -DDEBUG
diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
new file mode 100644
index 0000000..0f9548c
--- /dev/null
+++ b/kernel/irq/kexec.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/irqnr.h>
+
+#include "internals.h"
+
+void machine_kexec_mask_interrupts(void)
+{
+	struct irq_desc *desc;
+	unsigned int i;
+
+	for_each_irq_desc(i, desc) {
+		struct irq_chip *chip;
+		int check_eoi = 1;
+
+		chip = irq_desc_get_chip(desc);
+		if (!chip)
+			continue;
+
+		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD)) {
+			/*
+			 * First try to remove the active state from an interrupt which is forwarded
+			 * to a VM. If the interrupt is not forwarded, try to EOI the interrupt.
+			 */
+			check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
+		}
+
+		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
+			chip->irq_eoi(&desc->irq_data);
+
+		if (chip->irq_mask)
+			chip->irq_mask(&desc->irq_data);
+
+		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
+			chip->irq_disable(&desc->irq_data);
+	}
+}

