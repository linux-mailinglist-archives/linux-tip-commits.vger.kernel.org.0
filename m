Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6E2A3ECE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Nov 2020 09:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKCIWf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Nov 2020 03:22:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCIWf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Nov 2020 03:22:35 -0500
Date:   Tue, 03 Nov 2020 08:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604391752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGmEXxoC5+8X1wzAfB3whBFlDni8ICsiEU+Qx32qLAc=;
        b=TXQICX1LQ0mI/Mg4qa4DPwrhHc6qLFuv/DNN+X+Wwxbez8ArlBm3JcshR+x/RwIkws33sJ
        B6vfeaTH6/gxC4t6b3Z+IbBWMen7uGu1cRX9LZ76diK/1Dee0arZrn+RO98h8NdhmASyOL
        P8vk1aWs55ckg+8OmVFv2HB7/QLsKTLHYqFtTasppDQ46bqpWjZoDmBiIOikoJi1oyexw2
        5uU5zD6BAHHJD6e/WN0Dfetg4Rik6Lckyvt1irjvsNw8UPcJt0SeUUGukZWGzvm4D/vh4z
        jmKlfeepvKi7Yl6wy0QyPVxA9JvAvh2tfsj+qwszZ39GM20n8sgQSnLCFTN2/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604391752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGmEXxoC5+8X1wzAfB3whBFlDni8ICsiEU+Qx32qLAc=;
        b=5Dl1f0Y1TowtzU8DBGkPXF+/3GCrGNG/TMc0Qh9m46CRNOqWy7zTL14Kv15VmluI/pxZp0
        pGelDHBZa/zy2xAA==
From:   "tip-bot2 for Dexuan Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/hyperv: Enable 15-bit APIC ID if the hypervisor
 supports it
Cc:     Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103011136.59108-1-decui@microsoft.com>
References: <20201103011136.59108-1-decui@microsoft.com>
MIME-Version: 1.0
Message-ID: <160439175109.397.2766842993612981452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     af2abc92c5ddf5fc5a2036bc106c4d9a80a4d5f7
Gitweb:        https://git.kernel.org/tip/af2abc92c5ddf5fc5a2036bc106c4d9a80a4d5f7
Author:        Dexuan Cui <decui@microsoft.com>
AuthorDate:    Mon, 02 Nov 2020 17:11:36 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Nov 2020 09:16:46 +01:00

x86/hyperv: Enable 15-bit APIC ID if the hypervisor supports it

When a Linux VM runs on Hyper-V, if the VM has CPUs with >255 APIC IDs,
the CPUs can't be the destination of IOAPIC interrupts, because the
IOAPIC RTE's Dest Field has only 8 bits. Currently the hackery driver
drivers/iommu/hyperv-iommu.c is used to ensure IOAPIC interrupts are
only routed to CPUs that don't have >255 APIC IDs. However, there is
an issue with kdump, because the kdump kernel can run on any CPU, and
hence IOAPIC interrupts can't work if the kdump kernel run on a CPU
with a >255 APIC ID.

The kdump issue can be fixed by the Extended Dest ID, which is introduced
recently by David Woodhouse (for IOAPIC, see the field virt_destid_8_14 in
struct IO_APIC_route_entry). Of course, the Extended Dest ID needs the
support of the underlying hypervisor. The latest Hyper-V has added the
support recently: with this commit, on such a Hyper-V host, Linux VM
does not use hyperv-iommu.c because hyperv_prepare_irq_remapping()
returns -ENODEV; instead, Linux kernel's generic support of Extended Dest
ID from David is used, meaning that Linux VM is able to support up to
32K CPUs, and IOAPIC interrupts can be routed to all the CPUs.

On an old Hyper-V host that doesn't support the Extended Dest ID, nothing
changes with this commit: Linux VM is still able to bring up the CPUs with
can not go to such CPUs, and the kdump kernel still can not work properly
on such CPUs.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>                                                                                                                                                                                                                                  
Link: https://lore.kernel.org/r/20201103011136.59108-1-decui@microsoft.com

---
 arch/x86/include/asm/hyperv-tlfs.h |  7 +++++++-
 arch/x86/kernel/cpu/mshyperv.c     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0ed20e8..6bf42ae 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -23,6 +23,13 @@
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
+#define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
+#define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
+
+#define HYPERV_CPUID_VIRT_STACK_PROPERTIES	0x40000082
+/* Support for the extended IOAPIC RTE format */
+#define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	BIT(2)
+
 #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
 #define HYPERV_CPUID_MIN			0x40000005
 #define HYPERV_CPUID_MAX			0x4000ffff
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 05ef1f4..cc4037d 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -366,9 +366,39 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 }
 
+static bool __init ms_hyperv_x2apic_available(void)
+{
+	return x2apic_supported();
+}
+
+/*
+ * If ms_hyperv_msi_ext_dest_id() returns true, hyperv_prepare_irq_remapping()
+ * returns -ENODEV and the Hyper-V IOMMU driver is not used; instead, the
+ * generic support of the 15-bit APIC ID is used: see __irq_msi_compose_msg().
+ *
+ * Note: For a VM on Hyper-V, no emulated legacy device supports PCI MSI/MSI-X,
+ * and PCI MSI/MSI-X only come from the assigned physical PCIe device, and the
+ * PCI MSI/MSI-X interrupts are handled by the pci-hyperv driver. Here despite
+ * the word "msi" in the name "msi_ext_dest_id", actually the callback only
+ * affects how IOAPIC interrupts are routed.
+ */
+static bool __init ms_hyperv_msi_ext_dest_id(void)
+{
+	u32 eax;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
+	if (eax != HYPERV_VS_INTERFACE_EAX_SIGNATURE)
+		return false;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
+	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
 	.type			= X86_HYPER_MS_HYPERV,
+	.init.x2apic_available	= ms_hyperv_x2apic_available,
+	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
 };
