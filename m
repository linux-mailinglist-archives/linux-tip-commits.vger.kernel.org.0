Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D526C4F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIPQO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4FC0F26FA;
        Wed, 16 Sep 2020 08:17:03 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIP2y3pp+EafYUCYti5vm6KfHc0I5pEhcQCmR3kW1SI=;
        b=pjYA+ojbdvuiPX79hVJa9swKJ7NOUVm+I7LRW+BJL6DKHykYtbtKHTmT5JceRygysi1Z4q
        md5v3Q+Tz8LWsuj5wAVeU69QPW+quwjYzmEdURr9vedg8YYt35YoqAh3Cfa2l7NkFWcNgf
        kuCrISngRlaocoWTwSyXi2UXuo3bMDMi7w3pumWb0yzErShnn/i9w+xjrB2vTIt27J7Rec
        Y/8J8qmxrnGgDQubdXECmDdwdrVX/FzY9bMqQTN/7rm8XL2k1k2/2k0XkMqmMMdWsqG6Hg
        WGgYwSCra2R8NhdZvwLxP3u4ytSPSKZhCAjHxqtZtwlqccgHBjsjaiInF7sYzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIP2y3pp+EafYUCYti5vm6KfHc0I5pEhcQCmR3kW1SI=;
        b=4+WBE3BKhedKdHmz3kIdDKJ5J80Wp3XK21dfGB49kDcb6j+Dt6ggkHBlfuI0nrzCoxRdYw
        8e/DQW8ADZuPTPDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Make most MSI ops XEN private
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112334.198633344@linutronix.de>
References: <20200826112334.198633344@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912386.15536.13334083050941731245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     874a2013a07dd8ec48413db5d06d27d02f7765b5
Gitweb:        https://git.kernel.org/tip/874a2013a07dd8ec48413db5d06d27d02f7765b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:38 +02:00

x86/irq: Make most MSI ops XEN private

Nothing except XEN uses the setup/teardown ops. Hide them there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112334.198633344@linutronix.de

---
 arch/x86/include/asm/x86_init.h |  2 --
 arch/x86/pci/xen.c              | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index d8b597c..397196f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -276,8 +276,6 @@ struct x86_platform_ops {
 struct pci_dev;
 
 struct x86_msi_ops {
-	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index cb90095..c552cd2 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,6 +157,13 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
+struct xen_msi_ops {
+	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_msi_irqs)(struct pci_dev *dev);
+};
+
+static struct xen_msi_ops xen_msi_ops __ro_after_init;
+
 static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
@@ -415,7 +422,7 @@ static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
 	else
 		type = PCI_CAP_ID_MSI;
 
-	return x86_msi.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
 static void xen_msi_domain_free_irqs(struct irq_domain *domain,
@@ -424,7 +431,7 @@ static void xen_msi_domain_free_irqs(struct irq_domain *domain,
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	x86_msi.teardown_msi_irqs(to_pci_dev(dev));
+	xen_msi_ops.teardown_msi_irqs(to_pci_dev(dev));
 }
 
 static struct msi_domain_ops xen_pci_msi_domain_ops = {
@@ -463,16 +470,16 @@ static __init void xen_setup_pci_msi(void)
 {
 	if (xen_pv_domain()) {
 		if (xen_initial_domain()) {
-			x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+			xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 		} else {
-			x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
+			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
 		}
-		x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 		pci_msi_ignore_mask = 1;
 	} else if (xen_hvm_domain()) {
-		x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-		x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+		xen_msi_ops.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
 	} else {
 		WARN_ON_ONCE(1);
 		return;
