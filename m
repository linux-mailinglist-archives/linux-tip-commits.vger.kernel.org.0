Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E83E856F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhHJVgL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbhHJVgI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BCC061798;
        Tue, 10 Aug 2021 14:35:46 -0700 (PDT)
Date:   Tue, 10 Aug 2021 21:35:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlDxsJFZY2mIHFj+RNDxbKgr4JAGIzjeJClx86J+nAk=;
        b=B+bK425tEKQDQ/3lOiibsnzVzf9qfGDWHA+YPFPjC3U9l0z3hIJCsvoNj3bjnU9h+KmVAo
        JuHYfnvnzf/4gMiE3M6+voJgREZoHufANPJDbfRmZC9RYCIR59N8RF74RUj9VdS65QQEA7
        LIAOJLkndV1Vkg4QEoe1wOJJtXSOtZy4GQSbD+0pwTPwqLhwsTNJmNL9lQQHub1PqLcyN+
        Lk7ACdwZk21L4d3EskIUfAZHYtPZX9KlupV5Ve5QPVZU5x6PefjAlejdZbFBCkz70yO2Xs
        KuNj5B2Cbs9dpPxeaHRE2fLkDxTnDpj6Vld/kZTG12fR8GrbXC3pAXHTZfSY6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlDxsJFZY2mIHFj+RNDxbKgr4JAGIzjeJClx86J+nAk=;
        b=8+GBOwEHjC/VnqIiURCr+oe13GpuLJ5MYy0eInRu6NYZjA+Yen2a5SREUzAl8UWjk4q/TS
        FR8HjWqRV8wov1AQ==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add support for the Intel 82374EB/82374SB
 (ESC) PIRQ router
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107192023450.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107192023450.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134381.395.4799328995052485550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     6b79164f603d14a3ff9c64330c1ca6c05f0b019e
Gitweb:        https://git.kernel.org/tip/6b79164f603d14a3ff9c64330c1ca6c05f0b019e
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:27:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:43 +02:00

x86/PCI: Add support for the Intel 82374EB/82374SB (ESC) PIRQ router

The Intel 82374EB/82374SB EISA System Component (ESC) devices implement 
PCI interrupt steering with a PIRQ router[1] in the form of four PIRQ 
Route Control registers, available in the port I/O space accessible 
indirectly via the index/data register pair at 0x22/0x23, located at 
indices 0x60/0x61/0x62/0x63 for the PIRQ0/1/2/3# lines respectively.  

The semantics is the same as with the PIIX router, however it is not 
clear if BIOSes use register indices or line numbers as the cookie to 
identify PCI interrupts in their routing tables and therefore support 
either scheme.

Accesses to the port I/O space concerned here need to be unlocked by 
writing the value of 0x0f to the ESC ID Register at index 0x02 
beforehand[2].  Do so then and then lock access after use for safety. 

This locking could possibly interfere with accesses to the Intel MP spec 
IMCR register, implemented by the 82374SB variant of the ESC only as the 
PCI/APIC Control Register at index 0x70[3], for which leaving access to 
the configuration space concerned unlocked may have been a requirement 
for the BIOS to remain compliant with the MP spec.  However we only poke 
at the IMCR register if the APIC mode is used, in which case the PIRQ 
router is not, so this arrangement is not going to interfere with IMCR 
access code.

The ESC is implemented as a part of the combined southbridge also made 
of 82375EB/82375SB PCI-EISA Bridge (PCEB) and does itself appear in the 
PCI configuration space.  Use the PCEB's device identification then for
determining the presence of the ESC.

References:

[1] "82374EB/82374SB EISA System Component (ESC)", Intel Corporation, 
    Order Number: 290476-004, March 1996, Section 3.1.12 
    "PIRQ[0:3]#--PIRQ Route Control Registers", pp. 44-45

[2] same, Section 3.1.1 "ESCID--ESC ID Register", p. 36

[3] same, Section 3.1.17 "PAC--PCI/APIC Control Register", p. 47

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107192023450.9461@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 1bccbc4..187e284 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -358,6 +358,74 @@ static int pirq_ali_set(struct pci_dev *router, struct pci_dev *dev, int pirq, i
 }
 
 /*
+ *	PIRQ routing for the 82374EB/82374SB EISA System Component (ESC)
+ *	ASIC used with the Intel 82420 and 82430 PCIsets.  The ESC is not
+ *	decoded in the PCI configuration space, so we identify it by the
+ *	accompanying 82375EB/82375SB PCI-EISA Bridge (PCEB) ASIC.
+ *
+ *	There are four PIRQ Route Control registers, available in the
+ *	port I/O space accessible indirectly via the index/data register
+ *	pair at 0x22/0x23, located at indices 0x60/0x61/0x62/0x63 for the
+ *	PIRQ0/1/2/3# lines respectively.  The semantics is the same as
+ *	with the PIIX router.
+ *
+ *	Accesses to the port I/O space concerned here need to be unlocked
+ *	by writing the value of 0x0f to the ESC ID Register at index 0x02
+ *	beforehand.  Any other value written to said register prevents
+ *	further accesses from reaching the register file, except for the
+ *	ESC ID Register being written with 0x0f again.
+ *
+ *	References:
+ *
+ *	"82374EB/82374SB EISA System Component (ESC)", Intel Corporation,
+ *	Order Number: 290476-004, March 1996
+ *
+ *	"82375EB/82375SB PCI-EISA Bridge (PCEB)", Intel Corporation, Order
+ *	Number: 290477-004, March 1996
+ */
+
+#define PC_CONF_I82374_ESC_ID			0x02u
+#define PC_CONF_I82374_PIRQ_ROUTE_CONTROL	0x60u
+
+#define PC_CONF_I82374_ESC_ID_KEY		0x0fu
+
+static int pirq_esc_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	unsigned long flags;
+	int reg;
+	u8 x;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 4)
+		reg += PC_CONF_I82374_PIRQ_ROUTE_CONTROL - 1;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, PC_CONF_I82374_ESC_ID_KEY);
+	x = pc_conf_get(reg);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return (x < 16) ? x : 0;
+}
+
+static int pirq_esc_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
+		       int irq)
+{
+	unsigned long flags;
+	int reg;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 4)
+		reg += PC_CONF_I82374_PIRQ_ROUTE_CONTROL - 1;
+
+	raw_spin_lock_irqsave(&pc_conf_lock, flags);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, PC_CONF_I82374_ESC_ID_KEY);
+	pc_conf_set(reg, irq);
+	pc_conf_set(PC_CONF_I82374_ESC_ID, 0);
+	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
+	return 1;
+}
+
+/*
  * The Intel PIIX4 pirq rules are fairly simple: "pirq" is
  * just a pointer to the config space.
  */
@@ -687,6 +755,11 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 		return 0;
 
 	switch (device) {
+	case PCI_DEVICE_ID_INTEL_82375:
+		r->name = "PCEB/ESC";
+		r->get = pirq_esc_get;
+		r->set = pirq_esc_set;
+		return 1;
 	case PCI_DEVICE_ID_INTEL_82371FB_0:
 	case PCI_DEVICE_ID_INTEL_82371SB_0:
 	case PCI_DEVICE_ID_INTEL_82371AB_0:
