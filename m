Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07A26CDEF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIPVH1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E7C0F26FC;
        Wed, 16 Sep 2020 08:17:10 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIwYxw8FsbHqEPAyz/Y5I5hG0wn5tSwTcN+s+UwHIMg=;
        b=TTV7Ej65S5Y4MGj7M/VKaZAh795L5Nb6cygaY6HN7n0tdkYTWdO+ct6l4VFBjkB53JRWGd
        9wS1PvrOjKmkaz9+vrFFjghDteSLJSXNiHiXnixKhfDesMOTtFtz5hUvxnH6JFgKP/5/Rv
        OGF3dT08ljmrr8dSEBqs9iEScAxDuDWLMJWi0uR7Y2L9DYJoi73u5/TyycRF+tYfQClF17
        S9vKfzrJYMv8bnQxjRTPLjfPttuAUQIscJNYh5MYogfD7BqpRwhxodgXxidR5zZu7hLmsR
        aUmuc4QXEwsDXQp6vu6Bunn80clNaHVBi2lse4G6la00ADz4lrKVpYaYPR4vzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIwYxw8FsbHqEPAyz/Y5I5hG0wn5tSwTcN+s+UwHIMg=;
        b=4OsMUzoYjE/fGZahLFRSTV2NOTBHy+ALhPX/Xd53FTN6jlOX0eEL94TmAyKS0UEOal0Wec
        Hb5Mf31f7H7j3OBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/pci: Set default irq domain in pcibios_add_device()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.900423047@linutronix.de>
References: <20200826112333.900423047@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912617.15536.17241577735912869590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2c681e6b37674dc3941869cb262e26c8a6b34047
Gitweb:        https://git.kernel.org/tip/2c681e6b37674dc3941869cb262e26c8a6b34047
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:37 +02:00

x86/pci: Set default irq domain in pcibios_add_device()

Now that interrupt remapping sets the irqdomain pointer when a PCI device
is added it's possible to store the default irq domain in the device struct
in pcibios_add_device().

If the bus to which a device is connected has an irq domain associated then
this domain is used otherwise the default domain (PCI/MSI native or XEN
PCI/MSI) is used. Using the bus domain ensures that special MSI bus domains
like VMD work.

This makes XEN and the non-remapped native case work solely based on the
irq domain pointer in struct device for PCI/MSI and allows to remove the
arch fallback and make most of the x86_msi ops private to XEN in the next
steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112333.900423047@linutronix.de

---
 arch/x86/include/asm/irqdomain.h |  2 ++
 arch/x86/kernel/apic/msi.c       |  2 +-
 arch/x86/pci/common.c            | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index 430486f..cd684d4 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -53,9 +53,11 @@ extern int mp_irqdomain_ioapic_idx(struct irq_domain *domain);
 #ifdef CONFIG_PCI_MSI
 void x86_create_pci_msi_domain(void);
 struct irq_domain *native_create_pci_msi_domain(void);
+extern struct irq_domain *x86_pci_msi_default_domain;
 #else
 static inline void x86_create_pci_msi_domain(void) { }
 #define native_create_pci_msi_domain	NULL
+#define x86_pci_msi_default_domain	NULL
 #endif
 
 #endif
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 39136f7..6fd3337 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
+struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index df1d959..3507f45 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
+#include <asm/irqdomain.h>
 
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
@@ -633,8 +634,9 @@ static void set_dev_domain_options(struct pci_dev *pdev)
 
 int pcibios_add_device(struct pci_dev *dev)
 {
-	struct setup_data *data;
 	struct pci_setup_rom *rom;
+	struct irq_domain *msidom;
+	struct setup_data *data;
 	u64 pa_data;
 
 	pa_data = boot_params.hdr.setup_data;
@@ -661,6 +663,20 @@ int pcibios_add_device(struct pci_dev *dev)
 		memunmap(data);
 	}
 	set_dev_domain_options(dev);
+
+	/*
+	 * Setup the initial MSI domain of the device. If the underlying
+	 * bus has a PCI/MSI irqdomain associated use the bus domain,
+	 * otherwise set the default domain. This ensures that special irq
+	 * domains e.g. VMD are preserved. The default ensures initial
+	 * operation if irq remapping is not active. If irq remapping is
+	 * active it will overwrite the domain pointer when the device is
+	 * associated to a remapping domain.
+	 */
+	msidom = dev_get_msi_domain(&dev->bus->dev);
+	if (!msidom)
+		msidom = x86_pci_msi_default_domain;
+	dev_set_msi_domain(&dev->dev, msidom);
 	return 0;
 }
 
