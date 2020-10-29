Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1079629EB69
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgJ2MPf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ2MPe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C328C0613CF;
        Thu, 29 Oct 2020 05:15:34 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnNqxEoili0aF+9MIzy6cIRn0Mt2KRVQTp1d4qd5/kc=;
        b=WZgpU6s+8ylxYkFUjnnOR3rLGMC/YBEqSqp5Aj9c4TM90DpAhObLqMlBnmHSmNTFmeFDEk
        Xn9gow7rOkVBkGoIWd9Iunl1NCWq8Cb/4z+dplCRa1MFsQg85st7j7hhguFk/7JgnIQQ6+
        nQ/ZZn/HQ0Ua/EFSYgWZ43gvIw8KOFTOvDkdIbwTXPs0lON793Ry23AFV52y/iFRpGBWMA
        fr72ZIfAQkUEll1QqSK5DQrqnUu4CwWVAt83JlkoBzwKNRMxtXRWuU/RttPU+cGHzTmXlo
        V+6sXmfUCOEPR6H6snLyJMflJtPseoLGt/T/QqMhleLJugHvJh2/fsc9F8TFoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnNqxEoili0aF+9MIzy6cIRn0Mt2KRVQTp1d4qd5/kc=;
        b=hwnJtfnKBNvoLIez+KTFAauMcG08cwnI3yFctXMZ1XG/0kDyF9a7KKXWIIXpP2KmqpZG4v
        GladPVf4kbCS/KAw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Support 15 bits of APIC ID in MSI where available
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-33-dwmw2@infradead.org>
References: <20201024213535.443185-33-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397372999.397.419905060879528202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ab0f59c6f135289c7ea90b0e2471674bf289d884
Gitweb:        https://git.kernel.org/tip/ab0f59c6f135289c7ea90b0e2471674bf289d884
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:29 +01:00

x86/apic: Support 15 bits of APIC ID in MSI where available

Some hypervisors can allow the guest to use the Extended Destination ID
field in the MSI address to address up to 32768 CPUs.

This applies to all downstream devices which generate MSI cycles,
including HPET, I/O-APIC and PCI MSI.

HPET and PCI MSI use the same __irq_msi_compose_msg() function, while
I/O-APIC generates its own and had support for the extended bits added in
a previous commit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-33-dwmw2@infradead.org

---
 arch/x86/include/asm/msi.h      |  3 ++-
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/apic/apic.c     | 26 ++++++++++++++++++++++++--
 arch/x86/kernel/x86_init.c      |  1 +
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 322fd90..b85147d 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -29,7 +29,8 @@ typedef struct x86_msi_addr_lo {
 			u32	reserved_0		:  2,
 				dest_mode_logical	:  1,
 				redirect_hint		:  1,
-				reserved_1		:  8,
+				reserved_1		:  1,
+				virt_destid_8_14	:  7,
 				destid_0_7		:  8,
 				base_address		: 12;
 		};
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index dde5b3f..5c69f7e 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -116,6 +116,7 @@ struct x86_init_pci {
  * @init_platform:		platform setup
  * @guest_late_init:		guest late init
  * @x2apic_available:		X2APIC detection
+ * @msi_ext_dest_id:		MSI supports 15-bit APIC IDs
  * @init_mem_mapping:		setup early mappings during init_mem_mapping()
  * @init_after_bootmem:		guest init after boot allocator is finished
  */
@@ -123,6 +124,7 @@ struct x86_hyper_init {
 	void (*init_platform)(void);
 	void (*guest_late_init)(void);
 	bool (*x2apic_available)(void);
+	bool (*msi_ext_dest_id)(void);
 	void (*init_mem_mapping)(void);
 	void (*init_after_bootmem)(void);
 };
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f7196ee..6bd20c0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -94,6 +94,11 @@ static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
 static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
 
 /*
+ * Hypervisor supports 15 bits of APIC ID in MSI Extended Destination ID
+ */
+static bool virt_ext_dest_id __ro_after_init;
+
+/*
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
@@ -1841,6 +1846,8 @@ static __init void try_to_enable_x2apic(int remap_mode)
 		return;
 
 	if (remap_mode != IRQ_REMAP_X2APIC_MODE) {
+		u32 apic_limit = 255;
+
 		/*
 		 * Using X2APIC without IR is not architecturally supported
 		 * on bare metal but may be supported in guests.
@@ -1852,11 +1859,21 @@ static __init void try_to_enable_x2apic(int remap_mode)
 		}
 
 		/*
+		 * If the hypervisor supports extended destination ID in
+		 * MSI, that increases the maximum APIC ID that can be
+		 * used for non-remapped IRQ domains.
+		 */
+		if (x86_init.hyper.msi_ext_dest_id()) {
+			virt_ext_dest_id = 1;
+			apic_limit = 32767;
+		}
+
+		/*
 		 * Without IR, all CPUs can be addressed by IOAPIC/MSI only
 		 * in physical mode, and CPUs with an APIC ID that cannnot
 		 * be addressed must not be brought online.
 		 */
-		x2apic_set_max_apicid(255);
+		x2apic_set_max_apicid(apic_limit);
 		x2apic_phys = 1;
 	}
 	x2apic_enable();
@@ -2497,10 +2514,15 @@ void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 	 * Only the IOMMU itself can use the trick of putting destination
 	 * APIC ID into the high bits of the address. Anything else would
 	 * just be writing to memory if it tried that, and needs IR to
-	 * address higher APIC IDs.
+	 * address APICs which can't be addressed in the normal 32-bit
+	 * address range at 0xFFExxxxx. That is typically just 8 bits, but
+	 * some hypervisors allow the extended destination ID field in bits
+	 * 5-11 to be used, giving support for 15 bits of APIC IDs in total.
 	 */
 	if (dmar)
 		msg->arch_addr_hi.destid_8_31 = cfg->dest_apicid >> 8;
+	else if (virt_ext_dest_id && cfg->dest_apicid < 0x8000)
+		msg->arch_addr_lo.virt_destid_8_14 = cfg->dest_apicid >> 8;
 	else
 		WARN_ON_ONCE(cfg->dest_apicid > 0xFF);
 }
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a3038d8..8b39582 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -110,6 +110,7 @@ struct x86_init_ops x86_init __initdata = {
 		.init_platform		= x86_init_noop,
 		.guest_late_init	= x86_init_noop,
 		.x2apic_available	= bool_x86_init_noop,
+		.msi_ext_dest_id	= bool_x86_init_noop,
 		.init_mem_mapping	= x86_init_noop,
 		.init_after_bootmem	= x86_init_noop,
 	},
