Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9023626C45A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPPhz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgIPPa3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 11:30:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AECC02C296;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVsfMZTeqSjARJ/XVlg9BJdUpB8racC0MiPYscIPL1I=;
        b=ZnTcgrZRnWIorQfGCnczZEeSy/37FreST6T6jGxx1X2qJ4OO6YmvcQjXrYOYg5D/7nAiis
        ZRUHkLSeYPSAy1l+cbESxYjKQUaDqtZ+AIhb9jHcXzdyCrRbszSqOgRabwJ0VSPjHcVD6H
        BStGVQHM5mEelmlzJiZkawtbbo5rRGskBrpP5LjY86kcsdC9kDz0qW2xeBaVFokDVtOSjC
        QjGsF76MapmNW1KS7iq7FVk8gWYURS+BnNh860bQ7Gw137kZ2aBGGSEHJHoKIVCgn8TXsz
        GKOicRnka6r/FGLnh88iqjRb8xqNlKo6pXE+E7vI6YGa1J/z6FMIWbdBt0sFXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVsfMZTeqSjARJ/XVlg9BJdUpB8racC0MiPYscIPL1I=;
        b=D9s8y6/z0zfRl0tDEnn5Mg+cNSm0Pf6d5OQ8jmMFpaTneka1xCTxPwjV+yviSNWdKZkXg2
        vfoOHcJmxDXj0hCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/xen: Consolidate XEN-MSI init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.420224092@linutronix.de>
References: <20200826112333.420224092@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912988.15536.10846869358266400219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     70b59379efc3c818f48b8037e574654fb29f907c
Gitweb:        https://git.kernel.org/tip/70b59379efc3c818f48b8037e574654fb29f907c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

x86/xen: Consolidate XEN-MSI init

X86 cannot store the irq domain pointer in struct device without breaking
XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
fallbacks.

To achieve this XEN MSI interrupt management needs to be wrapped into an
irq domain.

Move the x86_msi ops setup into a single function to prepare for this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200826112333.420224092@linutronix.de
---
 arch/x86/pci/xen.c | 51 ++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 6a2debe..3a5611b 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -372,7 +372,10 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
 	}
 }
-#endif
+#else /* CONFIG_XEN_DOM0 */
+#define xen_initdom_setup_msi_irqs	NULL
+#define xen_initdom_restore_msi_irqs	NULL
+#endif /* !CONFIG_XEN_DOM0 */
 
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
@@ -404,7 +407,31 @@ static void xen_teardown_msi_irq(unsigned int irq)
 	WARN_ON_ONCE(1);
 }
 
-#endif
+static __init void xen_setup_pci_msi(void)
+{
+	if (xen_pv_domain()) {
+		if (xen_initial_domain()) {
+			x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+		} else {
+			x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
+		}
+		x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		pci_msi_ignore_mask = 1;
+	} else if (xen_hvm_domain()) {
+		x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	} else {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+}
+
+#else /* CONFIG_PCI_MSI */
+static inline void xen_setup_pci_msi(void) { }
+#endif /* CONFIG_PCI_MSI */
 
 int __init pci_xen_init(void)
 {
@@ -421,12 +448,7 @@ int __init pci_xen_init(void)
 	/* Keep ACPI out of the picture */
 	acpi_noirq_set();
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	return 0;
 }
 
@@ -446,10 +468,7 @@ static void __init xen_hvm_msi_init(void)
 		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && boot_cpu_has(X86_FEATURE_APIC)))
 			return;
 	}
-
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_setup_pci_msi();
 }
 #endif
 
@@ -482,13 +501,7 @@ int __init pci_xen_initial_domain(void)
 {
 	int irq;
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_pv_msi_irqs;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	__acpi_register_gsi = acpi_register_gsi_xen;
 	__acpi_unregister_gsi = NULL;
 	/*
