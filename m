Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55A26CDEC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIPVHU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC4C02C282;
        Wed, 16 Sep 2020 08:17:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zL3ElABjLkm4bVdXYgrFM0x9ZFPwQSgfZnxEaAEkGc=;
        b=1AGJW1Xs61isOi+14PfVoqUffT+t33rMIHRJYv9GNcz0CtnM5sijWEEMDMC1XZn9qDg/8R
        WQRAV1Uv+H276T1CAqCsmLCCLB2+e5MbA6fvkCLv+EMEcNrj7YtSG8gLwTNKJKSyJre+tm
        ClXg+cMH+krjW4bl8pyd0CNuNZzk0TKNJRA0Jx6Tgtk2X0iCAIYUSJsnWnnMH1ZSZbsA+q
        6RCSdmwwhStScFQ52L8RneSbGy4DNWAwM5d4/hxTGtEk/LBBw5vQ7Zvz1qgbRk35qkaibN
        vUK/pvTCxBHx90nnuTw9AUUUBFUDeH3yMlH/U/PeQ3za0FAV8NZ46wr134IMOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zL3ElABjLkm4bVdXYgrFM0x9ZFPwQSgfZnxEaAEkGc=;
        b=xhIKMmWhevnZI5YxXH5wCNJ370jqARDj5LGM6GpUfwYrkp7xIoMc/doJWjjSfXUEsgdcXV
        BVA0PtnQkSSJQYCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/pci: Reducde #ifdeffery in PCI init code
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.767707340@linutronix.de>
References: <20200826112332.767707340@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913496.15536.1930227378334662971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     445d3595ab290ba16ca5f202c7a67d71460cb39f
Gitweb:        https://git.kernel.org/tip/445d3595ab290ba16ca5f202c7a67d71460cb39f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:35 +02:00

x86/pci: Reducde #ifdeffery in PCI init code

Adding a function call before the first #ifdef in arch_pci_init() triggers
a 'mixed declarations and code' warning if PCI_DIRECT is enabled.

Use stub functions and move the #ifdeffery to the header file where it is
not in the way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112332.767707340@linutronix.de

---
 arch/x86/include/asm/pci_x86.h | 11 +++++++++++
 arch/x86/pci/init.c            | 10 +++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 73bb404..490411d 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -114,9 +114,20 @@ extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
 
 /* arch_initcall level */
+#ifdef CONFIG_PCI_DIRECT
 extern int pci_direct_probe(void);
 extern void pci_direct_init(int type);
+#else
+static inline int pci_direct_probe(void) { return -1; }
+static inline  void pci_direct_init(int type) { }
+#endif
+
+#ifdef CONFIG_PCI_BIOS
 extern void pci_pcbios_init(void);
+#else
+static inline void pci_pcbios_init(void) { }
+#endif
+
 extern void __init dmi_check_pciprobe(void);
 extern void __init dmi_check_skip_isa_align(void);
 
diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
index 5fc617e..bf66909 100644
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -8,11 +8,9 @@
    in the right sequence from here. */
 static __init int pci_arch_init(void)
 {
-#ifdef CONFIG_PCI_DIRECT
-	int type = 0;
+	int type;
 
 	type = pci_direct_probe();
-#endif
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))
 		pci_mmcfg_early_init();
@@ -20,18 +18,16 @@ static __init int pci_arch_init(void)
 	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
 		return 0;
 
-#ifdef CONFIG_PCI_BIOS
 	pci_pcbios_init();
-#endif
+
 	/*
 	 * don't check for raw_pci_ops here because we want pcbios as last
 	 * fallback, yet it's needed to run first to set pcibios_last_bus
 	 * in case legacy PCI probing is used. otherwise detecting peer busses
 	 * fails.
 	 */
-#ifdef CONFIG_PCI_DIRECT
 	pci_direct_init(type);
-#endif
+
 	if (!raw_pci_ops && !raw_pci_ext_ops)
 		printk(KERN_ERR
 		"PCI: Fatal: No config space access function found\n");
