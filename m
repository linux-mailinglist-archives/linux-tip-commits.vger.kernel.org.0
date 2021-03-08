Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB2331789
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCHTpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 14:45:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHTpS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 14:45:18 -0500
Date:   Mon, 08 Mar 2021 19:45:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615232717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7mUrlC1VI2Dam+YB5vP4PsbdUDIxzpEbEKAa4UKsZY=;
        b=yuX0bY59P5ovD2U2OEXSXNvJYUop0VppeqjqZeTyXImCr1t1gZh576aBh/VsXEOR/+yb3V
        OVaPo6m/MJ+eDELzbe5/Zhk6W0yYLqoBSqexDB/LegKwwDabDX+uJ4qcsXqHBHN7NB/L6M
        i5fSlmX3Xo77erR7yxACp/eSdbLKn4ZqAvXEMqsCLxdcFpF8+PQTUbekghTVWScx1lVJ31
        JeLwrlt8CHOstnNySWh4vfuUlGSzEzT9Qeies7H8mF0+ZFTB0UwzPCEMHbM9la99uAYp6r
        ggG1DGbeUVyFH6wxxPePJSkSSWBP5EDddNga0MHWCRbGR+Nt+ve6mWwUlFeNmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615232717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7mUrlC1VI2Dam+YB5vP4PsbdUDIxzpEbEKAa4UKsZY=;
        b=D/sovxAy9NLPUrJX+IF9GOR55F9k+iHikCbZx9MlIKNpastThkNokzaJMNQb8fIsb0aXp3
        6uHu6unvd+MmiZAg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/virtio: Have SEV guests enforce restricted
 virtio memory access
Cc:     kernel test robot <lkp@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb46e0211f77ca1831f11132f969d470a6ffc9267=2E16148?=
 =?utf-8?q?97610=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb46e0211f77ca1831f11132f969d470a6ffc9267=2E161489?=
 =?utf-8?q?7610=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <161523271617.398.12783069066955429974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     229164175ff0c61ff581e6bf37fbfcb608b6e9bb
Gitweb:        https://git.kernel.org/tip/229164175ff0c61ff581e6bf37fbfcb608b6e9bb
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 04 Mar 2021 16:40:11 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 20:41:33 +01:00

x86/virtio: Have SEV guests enforce restricted virtio memory access

An SEV guest requires that virtio devices use the DMA API to allow the
hypervisor to successfully access guest memory as needed.

The VIRTIO_F_VERSION_1 and VIRTIO_F_ACCESS_PLATFORM features tell virtio
to use the DMA API. Add arch_has_restricted_virtio_memory_access() for
x86, to fail the device probe if these features have not been set for the
device when running as an SEV guest.

 [ bp: Fix -Wmissing-prototypes warning
   Reported-by: kernel test robot <lkp@intel.com> ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/b46e0211f77ca1831f11132f969d470a6ffc9267.1614897610.git.thomas.lendacky@amd.com
---
 arch/x86/Kconfig          | 1 +
 arch/x86/mm/mem_encrypt.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..e80e726 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1518,6 +1518,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select INSTRUCTION_DECODER
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4b01f7d..f3eb53f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
+#include <linux/virtio_config.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -484,3 +485,8 @@ void __init mem_encrypt_init(void)
 	print_mem_encrypt_feature_info();
 }
 
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return sev_active();
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
