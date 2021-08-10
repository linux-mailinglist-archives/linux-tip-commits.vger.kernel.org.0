Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7388D3E8571
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhHJVgM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhHJVgJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:09 -0400
Date:   Tue, 10 Aug 2021 21:35:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH7gjyv/58xtBBoU8oMtOEm7SycVaijeDYFbB/ShNrg=;
        b=3UONZP9P0JbY/3j6Oiz8bIf2Mxoq4yTmlaU1lJztdFZLK1u88fTcFnAxeD97nqksC4nTYb
        zrxQDDsCIkQxUePzPitw2J+EW+WBQAoNWRVa5bcm3ru5J1Qto0Re7tNx6YkYSo4O4Uieud
        5RiunV/88A1Xa4c62BrbFACPLBRWuGssMiUiTUq4eTGwZLbCuaQS93Its9UnkhXXJJS7N6
        hZnonWeWLF/SENKyXggwAMm0qMdQU9tjwkRJJQHLkFFWdubhlNBPXnjOfEbe5S4pu8DZR+
        eZQXFh+HC00pRtHgXBo3pFoC5FiYzLIQw2BimFaJLz4C9YLmlYjNZMTDdY30iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH7gjyv/58xtBBoU8oMtOEm7SycVaijeDYFbB/ShNrg=;
        b=EpLYfY+j+EOUMwk/1BVB7N7D2fbz6wOJCFsJGiqD0TS5Ad8N/C2ieDgqc4dJLPXrQtoWBn
        RfC6gUS0RrwPE+DA==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86: Add support for 0x22/0x23 port I/O configuration space
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107182353140.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107182353140.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134527.395.3797936629649708326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     fb6a0408eac284688d5262519cbb3be0250e4caf
Gitweb:        https://git.kernel.org/tip/fb6a0408eac284688d5262519cbb3be0250e4caf
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:27:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:43 +02:00

x86: Add support for 0x22/0x23 port I/O configuration space

Define macros and accessors for the configuration space addressed 
indirectly with an index register and a data register at the port I/O 
locations of 0x22 and 0x23 respectively.

This space is defined by the Intel MultiProcessor Specification for the 
IMCR register used to switch between the PIC and the APIC mode[1], by 
Cyrix processors for their configuration[2][3], and also some chipsets.

Given the lack of atomicity with the indirect addressing a spinlock is 
required to protect accesses, although for Cyrix processors it is enough 
if accesses are executed with interrupts locally disabled, because the 
registers are local to the accessing CPU, and IMCR is only ever poked at 
by the BSP and early enough for interrupts not to have been configured 
yet.  Therefore existing code does not have to change or use the new 
spinlock and neither it does.

Put the spinlock in a library file then, so that it does not get pulled 
unnecessarily for configurations that do not refer it.

Convert Cyrix accessors to wrappers so as to retain the brevity and 
clarity of the `getCx86' and `setCx86' calls.

References:

[1] "MultiProcessor Specification", Version 1.4, Intel Corporation, 
    Order Number: 242016-006, May 1997, Section 3.6.2.1 "PIC Mode", pp. 
    3-7, 3-8

[2] "5x86 Microprocessor", Cyrix Corporation, Order Number: 94192-00, 
    July 1995, Section 2.3.2.4 "Configuration Registers", p. 2-23

[3] "6x86 Processor", Cyrix Corporation, Order Number: 94175-01, March 
    1996, Section 2.4.4 "6x86 Configuration Registers", p. 2-23

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107182353140.9461@angie.orcam.me.uk

---
 arch/x86/include/asm/pc-conf-reg.h     | 33 +++++++++++++++++++++++++-
 arch/x86/include/asm/processor-cyrix.h |  8 +++---
 arch/x86/kernel/apic/apic.c            |  9 ++-----
 arch/x86/lib/Makefile                  |  1 +-
 arch/x86/lib/pc-conf-reg.c             | 13 ++++++++++-
 5 files changed, 54 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/include/asm/pc-conf-reg.h
 create mode 100644 arch/x86/lib/pc-conf-reg.c

diff --git a/arch/x86/include/asm/pc-conf-reg.h b/arch/x86/include/asm/pc-conf-reg.h
new file mode 100644
index 0000000..56bcece
--- /dev/null
+++ b/arch/x86/include/asm/pc-conf-reg.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Support for the configuration register space at port I/O locations
+ * 0x22 and 0x23 variously used by PC architectures, e.g. the MP Spec,
+ * Cyrix CPUs, numerous chipsets.
+ */
+#ifndef _ASM_X86_PC_CONF_REG_H
+#define _ASM_X86_PC_CONF_REG_H
+
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define PC_CONF_INDEX		0x22
+#define PC_CONF_DATA		0x23
+
+#define PC_CONF_MPS_IMCR	0x70
+
+extern raw_spinlock_t pc_conf_lock;
+
+static inline u8 pc_conf_get(u8 reg)
+{
+	outb(reg, PC_CONF_INDEX);
+	return inb(PC_CONF_DATA);
+}
+
+static inline void pc_conf_set(u8 reg, u8 data)
+{
+	outb(reg, PC_CONF_INDEX);
+	outb(data, PC_CONF_DATA);
+}
+
+#endif /* _ASM_X86_PC_CONF_REG_H */
diff --git a/arch/x86/include/asm/processor-cyrix.h b/arch/x86/include/asm/processor-cyrix.h
index df700a6..efe3e46 100644
--- a/arch/x86/include/asm/processor-cyrix.h
+++ b/arch/x86/include/asm/processor-cyrix.h
@@ -5,14 +5,14 @@
  * Access order is always 0x22 (=offset), 0x23 (=value)
  */
 
+#include <asm/pc-conf-reg.h>
+
 static inline u8 getCx86(u8 reg)
 {
-	outb(reg, 0x22);
-	return inb(0x23);
+	return pc_conf_get(reg);
 }
 
 static inline void setCx86(u8 reg, u8 data)
 {
-	outb(reg, 0x22);
-	outb(data, 0x23);
+	pc_conf_set(reg, data);
 }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d262811..b70344b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -38,6 +38,7 @@
 
 #include <asm/trace/irq_vectors.h>
 #include <asm/irq_remapping.h>
+#include <asm/pc-conf-reg.h>
 #include <asm/perf_event.h>
 #include <asm/x86_init.h>
 #include <linux/atomic.h>
@@ -132,18 +133,14 @@ static int enabled_via_apicbase __ro_after_init;
  */
 static inline void imcr_pic_to_apic(void)
 {
-	/* select IMCR register */
-	outb(0x70, 0x22);
 	/* NMI and 8259 INTR go through APIC */
-	outb(0x01, 0x23);
+	pc_conf_set(PC_CONF_MPS_IMCR, 0x01);
 }
 
 static inline void imcr_apic_to_pic(void)
 {
-	/* select IMCR register */
-	outb(0x70, 0x22);
 	/* NMI and 8259 INTR go directly to BSP */
-	outb(0x00, 0x23);
+	pc_conf_set(PC_CONF_MPS_IMCR, 0x00);
 }
 #endif
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index bad4dee..c6506c6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 lib-y := delay.o misc.o cmdline.o cpu.o
 lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
 lib-y += memcpy_$(BITS).o
+lib-y += pc-conf-reg.o
 lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
diff --git a/arch/x86/lib/pc-conf-reg.c b/arch/x86/lib/pc-conf-reg.c
new file mode 100644
index 0000000..febb527
--- /dev/null
+++ b/arch/x86/lib/pc-conf-reg.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for the configuration register space at port I/O locations
+ * 0x22 and 0x23 variously used by PC architectures, e.g. the MP Spec,
+ * Cyrix CPUs, numerous chipsets.  As the space is indirectly addressed
+ * it may have to be protected with a spinlock, depending on the context.
+ */
+
+#include <linux/spinlock.h>
+
+#include <asm/pc-conf-reg.h>
+
+DEFINE_RAW_SPINLOCK(pc_conf_lock);
