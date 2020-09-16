Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4692326CDC1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIPVE4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIPQPB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E816C0F26F6;
        Wed, 16 Sep 2020 08:17:03 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rQ4J50vquClX1Tm+Vm8n6Nag29cjCXzpMOHkpkMaRI=;
        b=YP+N4sO9sbaJ4Mwk+TRtKOuE6Uq4Gx/gS9Es16wYQMs6244Ogl/29TbxI5F8khsZcFKKA8
        uURdGdohu+nuHN6aYohSR3QWctSPW5YRPsYKqu6EC78TPP02TnUdlCprGEi09AA6K9yKAh
        6pii6u0qvSVhux8AwjeJ6Cjs2QCgT4qL763GX4Qc+Bjr1MBNqlIm3/3vMBxRRa8Ws+l/Pz
        R4kF0autyJbqW1DQ1wP4jnO55fVcOJXn6NyrLTClD3hgvR4eXlC/ezg0SDTkhHq2wLzmRM
        oZzLW7JWaQLER9uBpEsI9rAqxH+J1G3vxESfdk26xHBG2TGF2IjxxZ/OjlbvYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rQ4J50vquClX1Tm+Vm8n6Nag29cjCXzpMOHkpkMaRI=;
        b=A9xZ8D2ixWiaxyzk0OCfZDr22QmYzEYjjUSu6jt6cu9Cl8XakVogiXDKh71qknf2fcfmpe
        mJUtzg1d4LZkrxAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Cleanup the arch_*_msi_irqs() leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112334.086003720@linutronix.de>
References: <20200826112334.086003720@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912459.15536.8539118022868227152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     7ca435cf857dd63d29d5e0b785807f6988788d2f
Gitweb:        https://git.kernel.org/tip/7ca435cf857dd63d29d5e0b785807f6988788d2f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:38 +02:00

x86/irq: Cleanup the arch_*_msi_irqs() leftovers

Get rid of all the gunk and remove the 'select PCI_MSI_ARCH_FALLBACK' from
the x86 Kconfig so the weak functions in the PCI core are replaced by stubs
which emit a warning, which ensures that any fail to set the irq domain
pointer results in a warning when the device is used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112334.086003720@linutronix.de
---
 arch/x86/Kconfig                |  1 -
 arch/x86/include/asm/pci.h      | 11 -----------
 arch/x86/include/asm/x86_init.h |  1 -
 arch/x86/kernel/apic/msi.c      | 22 ----------------------
 arch/x86/kernel/x86_init.c      | 18 ------------------
 arch/x86/pci/xen.c              |  7 -------
 6 files changed, 60 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 196e068..7101ac6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -225,7 +225,6 @@ config X86
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
-	select PCI_MSI_ARCH_FALLBACKS
 	select PERF_EVENTS
 	select RTC_LIB
 	select RTC_MC146818_LIB
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 7ccb338..d2c76c8 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -105,17 +105,6 @@ static inline void early_quirks(void) { }
 
 extern void pci_iommu_alloc(void);
 
-#ifdef CONFIG_PCI_MSI
-/* implemented in arch/x86/kernel/apic/io_apic. */
-struct msi_desc;
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void native_teardown_msi_irq(unsigned int irq);
-void native_restore_msi_irqs(struct pci_dev *dev);
-#else
-#define native_setup_msi_irqs		NULL
-#define native_teardown_msi_irq		NULL
-#endif
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index f96d600..d8b597c 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -277,7 +277,6 @@ struct pci_dev;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irq)(unsigned int irq);
 	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6fd3337..3b522b0 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -181,28 +181,6 @@ static struct irq_chip pci_msi_controller = {
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
-
-	domain = irq_remapping_get_irq_domain(&info);
-	if (domain == NULL)
-		domain = x86_pci_msi_default_domain;
-	if (domain == NULL)
-		return -ENOSYS;
-
-	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-}
-
-void native_teardown_msi_irq(unsigned int irq)
-{
-	irq_domain_free_irqs(irq, 1);
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index bb44ad8..a3038d8 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -146,28 +146,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi __ro_after_init = {
-	.setup_msi_irqs		= native_setup_msi_irqs,
-	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
 
 /* MSI arch specific hooks */
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-
 void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 161f397..cb90095 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -402,11 +402,6 @@ static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
 	xen_teardown_msi_irqs(dev);
 }
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	WARN_ON_ONCE(1);
-}
-
 static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 				     struct device *dev,  int nvec)
 {
@@ -483,8 +478,6 @@ static __init void xen_setup_pci_msi(void)
 		return;
 	}
 
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-
 	/*
 	 * Override the PCI/MSI irq domain init function. No point
 	 * in allocating the native domain and never use it.
