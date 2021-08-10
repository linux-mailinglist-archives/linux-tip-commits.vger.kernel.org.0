Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9165E3E856B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhHJVgJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhHJVgH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE83C0613D3;
        Tue, 10 Aug 2021 14:35:44 -0700 (PDT)
Date:   Tue, 10 Aug 2021 21:35:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z+ph+QlNWuOY+fVt5/RLJ5og6okBtCNC9UhMcvrzAg=;
        b=2IblL6cmAjTE3tm5vGNuluS4pW70AR+Nag+7/feNLV7axTKgchXtVHhDKV1NyD3lkmWLgS
        lZyWt/wbdhhYZ5oBpJFlgzd0enFrYAg0FEFUHVW2UuKHU5xbIZEfOHH0e+D9ps6a3ys0Vh
        mWRERODsETTUhB61oZ31fImnJu/iw5YTGDVafSYpmNWt7h6GbNOXxO7ZxNbpwjYjIjiuFq
        qkHcGhE7+K7vWUxxuhGGeXMvPoAlfH9TQAVU7/D5HNaCGUz+4r/BnGxD6rIIPMvaGdL2qR
        SFzSsRlaGSTGE6a4K5NFgwHhK1ntRcpwWQAWv9c0qzOApaQXRNHz5SQDa445Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z+ph+QlNWuOY+fVt5/RLJ5og6okBtCNC9UhMcvrzAg=;
        b=oD4Dkd5AEYflafedeNypM3Zpupcd/1BHiTtNoYJLxMjRZHc1PwKSJ4E0qStfXRQshwPB/H
        bY3duhG2mA/Il1BQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86: Avoid magic number with ELCR register accesses
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107200237300.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107200237300.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134181.395.14569451397861222790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d25316616842b593de6f89ce2101f1af62f4d559
Gitweb:        https://git.kernel.org/tip/d25316616842b593de6f89ce2101f1af62f4d559
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:28:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:43 +02:00

x86: Avoid magic number with ELCR register accesses

Define PIC_ELCR1 and PIC_ELCR2 macros for accesses to the ELCR registers 
implemented by many chipsets in their embedded 8259A PIC cores, avoiding 
magic numbers that are difficult to handle, and complementing the macros 
we already have for registers originally defined with discrete 8259A PIC 
implementations.  No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107200237300.9461@angie.orcam.me.uk

---
 arch/x86/include/asm/i8259.h   | 2 ++
 arch/x86/kernel/acpi/boot.c    | 6 +++---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 arch/x86/kernel/apic/vector.c  | 2 +-
 arch/x86/kernel/i8259.c        | 8 ++++----
 arch/x86/kernel/mpparse.c      | 3 ++-
 arch/x86/pci/irq.c             | 3 ++-
 7 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 89789e8..637fa1d 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -19,6 +19,8 @@ extern unsigned int cached_irq_mask;
 #define PIC_MASTER_OCW3		PIC_MASTER_ISR
 #define PIC_SLAVE_CMD		0xa0
 #define PIC_SLAVE_IMR		0xa1
+#define PIC_ELCR1		0x4d0
+#define PIC_ELCR2		0x4d1
 
 /* i8259A PIC related value */
 #define PIC_CASCADE_IR		2
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1..7f59f83 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -570,7 +570,7 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
 	unsigned int old, new;
 
 	/* Real old ELCR mask */
-	old = inb(0x4d0) | (inb(0x4d1) << 8);
+	old = inb(PIC_ELCR1) | (inb(PIC_ELCR2) << 8);
 
 	/*
 	 * If we use ACPI to set PCI IRQs, then we should clear ELCR
@@ -596,8 +596,8 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
 		return;
 
 	pr_warn("setting ELCR to %04x (from %04x)\n", new, old);
-	outb(new, 0x4d0);
-	outb(new >> 8, 0x4d1);
+	outb(new, PIC_ELCR1);
+	outb(new >> 8, PIC_ELCR2);
 }
 
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d5c691a..7846499 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -764,7 +764,7 @@ static bool irq_active_low(int idx)
 static bool EISA_ELCR(unsigned int irq)
 {
 	if (irq < nr_legacy_irqs()) {
-		unsigned int port = 0x4d0 + (irq >> 3);
+		unsigned int port = PIC_ELCR1 + (irq >> 3);
 		return (inb(port) >> (irq & 7)) & 1;
 	}
 	apic_printk(APIC_VERBOSE, KERN_INFO
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fb67ed5..c132daa 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1299,7 +1299,7 @@ static void __init print_PIC(void)
 
 	pr_debug("... PIC  ISR: %04x\n", v);
 
-	v = inb(0x4d1) << 8 | inb(0x4d0);
+	v = inb(PIC_ELCR2) << 8 | inb(PIC_ELCR1);
 	pr_debug("... PIC ELCR: %04x\n", v);
 }
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 282b4ee..15aefa3 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -235,15 +235,15 @@ static char irq_trigger[2];
  */
 static void restore_ELCR(char *trigger)
 {
-	outb(trigger[0], 0x4d0);
-	outb(trigger[1], 0x4d1);
+	outb(trigger[0], PIC_ELCR1);
+	outb(trigger[1], PIC_ELCR2);
 }
 
 static void save_ELCR(char *trigger)
 {
 	/* IRQ 0,1,2,8,13 are marked as reserved */
-	trigger[0] = inb(0x4d0) & 0xF8;
-	trigger[1] = inb(0x4d1) & 0xDE;
+	trigger[0] = inb(PIC_ELCR1) & 0xF8;
+	trigger[1] = inb(PIC_ELCR2) & 0xDE;
 }
 
 static void i8259A_resume(void)
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 8f06449..fed721f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/pci.h>
 
+#include <asm/i8259.h>
 #include <asm/io_apic.h>
 #include <asm/acpi.h>
 #include <asm/irqdomain.h>
@@ -251,7 +252,7 @@ static int __init ELCR_trigger(unsigned int irq)
 {
 	unsigned int port;
 
-	port = 0x4d0 + (irq >> 3);
+	port = PIC_ELCR1 + (irq >> 3);
 	return (inb(port) >> (irq & 7)) & 1;
 }
 
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index b937c96..97b63e3 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/acpi.h>
 
+#include <asm/i8259.h>
 #include <asm/pc-conf-reg.h>
 #include <asm/pci_x86.h>
 
@@ -158,7 +159,7 @@ static void __init pirq_peer_trick(void)
 void elcr_set_level_irq(unsigned int irq)
 {
 	unsigned char mask = 1 << (irq & 7);
-	unsigned int port = 0x4d0 + (irq >> 3);
+	unsigned int port = PIC_ELCR1 + (irq >> 3);
 	unsigned char val;
 	static u16 elcr_irq_mask;
 
