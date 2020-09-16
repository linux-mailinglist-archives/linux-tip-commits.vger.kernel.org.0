Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9E726CDBE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIPVET (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIPQPB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA77FC0F26FD;
        Wed, 16 Sep 2020 08:17:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rm8vnO9L1e7jgH9w2iGj8KLEv55R9idxeQTHElIqT94=;
        b=jxBHD+Rgqzj8O+odEd2gmLnCpzLAVVrc+aYWak3cAs0GsZ4SeNmrfh79T2THFKBkkQB9Az
        FJa5/GwXUYubSQm0/7IIoauBiPDNom9AWNddSr9WrRh+AG+k4w0djrpLEnCIb4VY/3pOcx
        DPuOZu2SWNRR8hIUG1cebkQruMUvT6vSpk+cwj2LjuUGYo7rMUvz4Q0EB3NpDk6xA7gb+v
        uFoEiBODiAl40Xo6XxEl3X9MGFm3TdM0nzAmhSx2/Vqof3tp5rxu+ulDby2sgnCkGelCMz
        JT+F9NV0O3JYu75Iv5Jd0kcmp3IAuF7IWyGIrI48Oj+/ui5xyV1wpVHjtkTQaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rm8vnO9L1e7jgH9w2iGj8KLEv55R9idxeQTHElIqT94=;
        b=3qem2x6JJvPllg0KiynfZDLG6Fr8dx4Fg8VHvgI3wYxbqRgyxgJewD79tOqhkigS0O0ebf
        e52GBzYwMW7+OLCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/xen: Rework MSI teardown
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.326841410@linutronix.de>
References: <20200826112333.326841410@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913063.15536.6848092694829422460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     7d4d892de6e74194fcfd4ff69f21ba3da97ae282
Gitweb:        https://git.kernel.org/tip/7d4d892de6e74194fcfd4ff69f21ba3da97ae282
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

x86/xen: Rework MSI teardown

X86 cannot store the irq domain pointer in struct device without breaking
XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
fallbacks.

XENs MSI teardown relies on default_teardown_msi_irqs() which invokes
arch_teardown_msi_irq(). default_teardown_msi_irqs() is a trivial iterator
over the msi entries associated to a device.

Implement this loop in xen_teardown_msi_irqs() to prepare for removal of
the fallbacks for X86.

This is a preparatory step to wrap XEN MSI alloc/free into a irq domain
which in turn allows to store the irq domain pointer in struct device and
to use the irq domain functions directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200826112333.326841410@linutronix.de

---
 arch/x86/pci/xen.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index ba8dc94..6a2debe 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -377,20 +377,31 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
+	int i;
+
+	for_each_pci_msi_entry(msidesc, dev) {
+		if (msidesc->irq) {
+			for (i = 0; i < msidesc->nvec_used; i++)
+				xen_destroy_irq(msidesc->irq + i);
+		}
+	}
+}
+
+static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *msidesc = first_pci_msi_entry(dev);
 
-	msidesc = first_pci_msi_entry(dev);
 	if (msidesc->msi_attrib.is_msix)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
 
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
+	xen_teardown_msi_irqs(dev);
 }
 
 static void xen_teardown_msi_irq(unsigned int irq)
 {
-	xen_destroy_irq(irq);
+	WARN_ON_ONCE(1);
 }
 
 #endif
@@ -413,7 +424,7 @@ int __init pci_xen_init(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -437,6 +448,7 @@ static void __init xen_hvm_msi_init(void)
 	}
 
 	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 }
 #endif
@@ -473,6 +485,7 @@ int __init pci_xen_initial_domain(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	x86_msi.teardown_msi_irqs = xen_teardown_pv_msi_irqs;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 	pci_msi_ignore_mask = 1;
 #endif
