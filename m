Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8526CCC2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIPUs4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIPRAl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1928C02C291;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4W66X9vT4ZasibPwcKebQcLDgO1s4Fxc+gXyaS9LLuI=;
        b=SnsHJAJjDZlyT238qKF1Ag09Qkb5fOTfS+XCJkBw/UZOy6vrOgmay3Bp5y5yTSpl1IRU75
        3ndRXN8EuOAESfSOIx81zDroB66xwXTRv79Pa3kBnLHajFnRwrXC8JZd4do1z/p5zLaYfZ
        lPTnEAyhaBcfxyqe1+qNkpHwYQB507T8ruM+fk4Gs0CVjDgs4VauUi5opOAGB27F9p25oQ
        /GU67O1Xr3H7iEuahXCzxdndxa3Vr51EtxyLPgcPz6j/cSNs+TO0uH9G9Bpxh0wOCBDRpo
        nWc+zspbOk1vo9/RZ7Id7RTzDC4j75HEMesAXa7mJvs4xoEgn8U0wtIpA5D9TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4W66X9vT4ZasibPwcKebQcLDgO1s4Fxc+gXyaS9LLuI=;
        b=U/mX5IqTelBizCZHLsXiYEylXc4az/jxY/Ws8Ofmo82VdHiJdluZlArnh8StHomOioYwnr
        LpUyb1TIQ2gzVmAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/xen: Wrap XEN MSI management into irqdomain
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.622352798@linutronix.de>
References: <20200826112333.622352798@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912842.15536.9228669080202517710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2e4386eba0c0830becc5c88848b765950970533d
Gitweb:        https://git.kernel.org/tip/2e4386eba0c0830becc5c88848b765950970533d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:37 +02:00

x86/xen: Wrap XEN MSI management into irqdomain

To allow utilizing the irq domain pointer in struct device it is necessary
to make XEN/MSI irq domain compatible.

While the right solution would be to truly convert XEN to irq domains, this
is an exercise which is not possible for mere mortals with limited XENology.

Provide a plain irqdomain wrapper around XEN. While this is blatant
violation of the irqdomain design, it's the only solution for a XEN igorant
person to make progress on the issue which triggered this change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200826112333.622352798@linutronix.de

---
 arch/x86/pci/xen.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 3a5611b..161f397 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -407,6 +407,63 @@ static void xen_teardown_msi_irq(unsigned int irq)
 	WARN_ON_ONCE(1);
 }
 
+static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
+				     struct device *dev,  int nvec)
+{
+	int type;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return -EINVAL;
+
+	if (first_msi_entry(dev)->msi_attrib.is_msix)
+		type = PCI_CAP_ID_MSIX;
+	else
+		type = PCI_CAP_ID_MSI;
+
+	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+}
+
+static void xen_msi_domain_free_irqs(struct irq_domain *domain,
+				     struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+static struct msi_domain_ops xen_pci_msi_domain_ops = {
+	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
+	.domain_free_irqs	= xen_msi_domain_free_irqs,
+};
+
+static struct msi_domain_info xen_pci_msi_domain_info = {
+	.ops			= &xen_pci_msi_domain_ops,
+};
+
+/*
+ * This irq domain is a blatant violation of the irq domain design, but
+ * distangling XEN into real irq domains is not a job for mere mortals with
+ * limited XENology. But it's the least dangerous way for a mere mortal to
+ * get rid of the arch_*_msi_irqs() hackery in order to store the irq
+ * domain pointer in struct device. This irq domain wrappery allows to do
+ * that without breaking XEN terminally.
+ */
+static __init struct irq_domain *xen_create_pci_msi_domain(void)
+{
+	struct irq_domain *d = NULL;
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
+	if (fn)
+		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
+
+	/* FIXME: No idea how to survive if this fails */
+	BUG_ON(!d);
+
+	return d;
+}
+
 static __init void xen_setup_pci_msi(void)
 {
 	if (xen_pv_domain()) {
@@ -427,6 +484,12 @@ static __init void xen_setup_pci_msi(void)
 	}
 
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+
+	/*
+	 * Override the PCI/MSI irq domain init function. No point
+	 * in allocating the native domain and never use it.
+	 */
+	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
 }
 
 #else /* CONFIG_PCI_MSI */
