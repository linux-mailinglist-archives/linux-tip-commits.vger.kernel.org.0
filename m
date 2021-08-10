Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2F3E856D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 23:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhHJVgK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 17:36:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhHJVgI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 17:36:08 -0400
Date:   Tue, 10 Aug 2021 21:35:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628631343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uJXpsZoV9RsyIg8jRtfvGk6p6Mi0WhzD8L1WcH2duM=;
        b=iKpekTQNRa/VYLy7TLjc6B61q+BZAxYl/d0nf8aZL1KpPMBJTwIr/Byg/qurKR7t3G1AMH
        xD8tnyBb5qZ8IrfBXhlPcDayiS0vv7nmISetlF+MMRNUcuvpAl3Aex5NHYLIonz3QNHz7y
        jkso+EX2WU/owqXtUIMhVfkTrtYHP5Et15T4TSahtACl+1a6Nga/4obss/NbNJkH3Kndx4
        FHIui6r72mSPV7qpdWBwPd/TGfSWYxuBn9QQAcjCSIxIKSJ7QCU2nXkahQnyhlEx1ZMgkQ
        MHDmdNR1LOGgkag+T4BMHp1P8zWL733asecVfcIJxUNnTdfgS7ZzYDd3M2yOjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628631343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uJXpsZoV9RsyIg8jRtfvGk6p6Mi0WhzD8L1WcH2duM=;
        b=4K2iiNZlSwNHLylPGRWYYqxdAPrNzzcqRVZMmA9affKZwu+ktKUCTVd5EP94P1I9a9K4Qg
        H5SgN8De8eV0BDCw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add support for the Intel 82426EX PIRQ router
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2107200213490.9461@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107200213490.9461@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <162863134254.395.17843871893060930638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     0e8c6f56fab3af3ef9f78f486e198792d3af0fa1
Gitweb:        https://git.kernel.org/tip/0e8c6f56fab3af3ef9f78f486e198792d3af0fa1
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Tue, 20 Jul 2021 05:28:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 23:31:43 +02:00

x86/PCI: Add support for the Intel 82426EX PIRQ router

The Intel 82426EX ISA Bridge (IB), a part of the Intel 82420EX PCIset, 
implements PCI interrupt steering with a PIRQ router in the form of two 
PIRQ Route Control registers, available in the PCI configuration space 
at locations 0x66 and 0x67 for the PIRQ0# and PIRQ1# lines respectively.

The semantics is the same as with the PIIX router, however it is not
clear if BIOSes use register indices or line numbers as the cookie to
identify PCI interrupts in their routing tables and therefore support
either scheme.

The IB is directly attached to the Intel 82425EX PCI System Controller 
(PSC) component of the chipset via a dedicated PSC/IB Link interface 
rather than the host bus or PCI.  Therefore it does not itself appear in 
the PCI configuration space even though it responds to configuration 
cycles addressing registers it implements.  Use 82425EX's identification 
then for determining the presence of the IB.

References:

[1] "82420EX PCIset Data Sheet, 82425EX PCI System Controller (PSC) and 
    82426EX ISA Bridge (IB)", Intel Corporation, Order Number: 
    290488-004, December 1995, Section 3.3.18 "PIRQ1RC/PIRQ0RC--PIRQ 
    Route Control Registers", p. 61

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2107200213490.9461@angie.orcam.me.uk

---
 arch/x86/pci/irq.c      | 49 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci_ids.h |  1 +-
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 187e284..b937c96 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -444,6 +444,50 @@ static int pirq_piix_set(struct pci_dev *router, struct pci_dev *dev, int pirq, 
 }
 
 /*
+ *	PIRQ routing for the 82426EX ISA Bridge (IB) ASIC used with the
+ *	Intel 82420EX PCIset.
+ *
+ *	There are only two PIRQ Route Control registers, available in the
+ *	combined 82425EX/82426EX PCI configuration space, at 0x66 and 0x67
+ *	for the PIRQ0# and PIRQ1# lines respectively.  The semantics is
+ *	the same as with the PIIX router.
+ *
+ *	References:
+ *
+ *	"82420EX PCIset Data Sheet, 82425EX PCI System Controller (PSC)
+ *	and 82426EX ISA Bridge (IB)", Intel Corporation, Order Number:
+ *	290488-004, December 1995
+ */
+
+#define PCI_I82426EX_PIRQ_ROUTE_CONTROL	0x66u
+
+static int pirq_ib_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	int reg;
+	u8 x;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 2)
+		reg += PCI_I82426EX_PIRQ_ROUTE_CONTROL - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	return (x < 16) ? x : 0;
+}
+
+static int pirq_ib_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
+		       int irq)
+{
+	int reg;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 2)
+		reg += PCI_I82426EX_PIRQ_ROUTE_CONTROL - 1;
+
+	pci_write_config_byte(router, reg, irq);
+	return 1;
+}
+
+/*
  * The VIA pirq rules are nibble-based, like ALI,
  * but without the ugly irq number munging.
  * However, PIRQD is in the upper instead of lower 4 bits.
@@ -805,6 +849,11 @@ static __init int intel_router_probe(struct irq_router *r, struct pci_dev *route
 		r->get = pirq_piix_get;
 		r->set = pirq_piix_set;
 		return 1;
+	case PCI_DEVICE_ID_INTEL_82425:
+		r->name = "PSC/IB";
+		r->get = pirq_ib_get;
+		r->set = pirq_ib_set;
+		return 1;
 	}
 
 	if ((device >= PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN && 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 256fa4d..60e2101 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2644,6 +2644,7 @@
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
+#define PCI_DEVICE_ID_INTEL_82425	0x0486
 #define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
 #define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
 #define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820
