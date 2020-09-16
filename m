Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4326CDED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIPVHU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAFCC02C281;
        Wed, 16 Sep 2020 08:17:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUa5SG4zuWpyeTAKCQUiksMiIprv1LP01EUoOWth5vQ=;
        b=i3NTJhqxaC3nSrtwsR7yjmER01qjpYSe3oUFGGy+rCLxRSbDKX19Md+HsSI5QjmChAl0I/
        i6+qibNJ1mmR6y/cFotB4UCiG0BKNZ6Xr58QKEcGof0Ut9na/5rsYbajLq8ZfMHXInVAcw
        uSzaawFK9cEi6URPG2O5/tdICtXz62tkAPdlgx5yaBR2Us+r3+9Q9T6wvbbH1v1Rb/XMHq
        G8Hwce57ZyirqhFpDbXmuLrwW1WPpAWLK4Q7RP98YSfIw2RArap9AA/ZyVC7Ag0IkY4sK4
        7jgCMHA10K1B0QW7FBUoMTl+aUtucxWwQo8D04R1hlVjdier4fGBHflRFaFPpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUa5SG4zuWpyeTAKCQUiksMiIprv1LP01EUoOWth5vQ=;
        b=GrxQTK/SDbkrsu5y+/Qcj2wGpsa7om2jIqPtke+vIwoJjYchycZJmxC8vYlATST/6UAGW/
        bXIDH4qGYJoVtVCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Initialize PCI/MSI domain at PCI init time
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.859209894@linutronix.de>
References: <20200826112332.859209894@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913427.15536.15229364838165709457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     6b15ffa07dc325f4e4dd98c877bfa970202c378b
Gitweb:        https://git.kernel.org/tip/6b15ffa07dc325f4e4dd98c877bfa970202c378b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:35 +02:00

x86/irq: Initialize PCI/MSI domain at PCI init time

No point in initializing the default PCI/MSI interrupt domain early and no
point to create it when XEN PV/HVM/DOM0 are active.

Move the initialization to pci_arch_init() and convert it to init ops so
that XEN can override it as XEN has it's own PCI/MSI management. The XEN
override comes in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112332.859209894@linutronix.de

---
 arch/x86/include/asm/irqdomain.h |  6 ++++--
 arch/x86/include/asm/x86_init.h  |  3 +++-
 arch/x86/kernel/apic/msi.c       | 31 +++++++++++++++++++------------
 arch/x86/kernel/apic/vector.c    |  2 +--
 arch/x86/kernel/x86_init.c       |  4 +++-
 arch/x86/pci/init.c              |  3 +++-
 6 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index c066ffa..430486f 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -51,9 +51,11 @@ extern int mp_irqdomain_ioapic_idx(struct irq_domain *domain);
 #endif /* CONFIG_X86_IO_APIC */
 
 #ifdef CONFIG_PCI_MSI
-extern void arch_init_msi_domain(struct irq_domain *domain);
+void x86_create_pci_msi_domain(void);
+struct irq_domain *native_create_pci_msi_domain(void);
 #else
-static inline void arch_init_msi_domain(struct irq_domain *domain) { }
+static inline void x86_create_pci_msi_domain(void) { }
+#define native_create_pci_msi_domain	NULL
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 7cc32e7..f96d600 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -8,6 +8,7 @@ struct mpc_bus;
 struct mpc_cpu;
 struct mpc_table;
 struct cpuinfo_x86;
+struct irq_domain;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
@@ -42,12 +43,14 @@ struct x86_init_resources {
  * @intr_init:			interrupt init code
  * @intr_mode_select:		interrupt delivery mode selection
  * @intr_mode_init:		interrupt delivery mode setup
+ * @create_pci_msi_domain:	Create the PCI/MSI interrupt domain
  */
 struct x86_init_irqs {
 	void (*pre_vector_init)(void);
 	void (*intr_init)(void);
 	void (*intr_mode_select)(void);
 	void (*intr_mode_init)(void);
+	struct irq_domain *(*create_pci_msi_domain)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 378c692..39136f7 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *msi_default_domain;
+static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
@@ -191,7 +191,7 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	domain = irq_remapping_get_irq_domain(&info);
 	if (domain == NULL)
-		domain = msi_default_domain;
+		domain = x86_pci_msi_default_domain;
 	if (domain == NULL)
 		return -ENOSYS;
 
@@ -234,25 +234,32 @@ static struct msi_domain_info pci_msi_domain_info = {
 	.handler_name	= "edge",
 };
 
-void __init arch_init_msi_domain(struct irq_domain *parent)
+struct irq_domain * __init native_create_pci_msi_domain(void)
 {
 	struct fwnode_handle *fn;
+	struct irq_domain *d;
 
 	if (disable_apic)
-		return;
+		return NULL;
 
 	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (fn) {
-		msi_default_domain =
-			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-						  parent);
-	}
-	if (!msi_default_domain) {
+	if (!fn)
+		return NULL;
+
+	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
+				      x86_vector_domain);
+	if (!d) {
 		irq_domain_free_fwnode(fn);
-		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
 	} else {
-		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
+	return d;
+}
+
+void __init x86_create_pci_msi_domain(void)
+{
+	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
 #ifdef CONFIG_IRQ_REMAP
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 66516d8..1eac536 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -714,8 +714,6 @@ int __init arch_early_irq_init(void)
 	BUG_ON(x86_vector_domain == NULL);
 	irq_set_default_host(x86_vector_domain);
 
-	arch_init_msi_domain(x86_vector_domain);
-
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
 	/*
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index cec6f6a..bb44ad8 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -24,6 +24,7 @@
 #include <asm/tsc.h>
 #include <asm/iommu.h>
 #include <asm/mach_traps.h>
+#include <asm/irqdomain.h>
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
@@ -76,7 +77,8 @@ struct x86_init_ops x86_init __initdata = {
 		.pre_vector_init	= init_ISA_irqs,
 		.intr_init		= native_init_IRQ,
 		.intr_mode_select	= apic_intr_mode_select,
-		.intr_mode_init		= apic_intr_mode_init
+		.intr_mode_init		= apic_intr_mode_init,
+		.create_pci_msi_domain	= native_create_pci_msi_domain,
 	},
 
 	.oem = {
diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
index bf66909..00bfa1e 100644
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <asm/pci_x86.h>
 #include <asm/x86_init.h>
+#include <asm/irqdomain.h>
 
 /* arch_initcall has too random ordering, so call the initializers
    in the right sequence from here. */
@@ -10,6 +11,8 @@ static __init int pci_arch_init(void)
 {
 	int type;
 
+	x86_create_pci_msi_domain();
+
 	type = pci_direct_probe();
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))
