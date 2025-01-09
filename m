Return-Path: <linux-tip-commits+bounces-3181-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E8A0713B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8FD7A3F07
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341682036ED;
	Thu,  9 Jan 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NBeH27oW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwOq6V79"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B418215779;
	Thu,  9 Jan 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414146; cv=none; b=GYqQQHGcCsHUWPAHjojNWQMGtJXU8pK+nheba9SC2WXM3DWOG3pusX9hq8ukQLfW+hZkkq2mnZ/KqBHJzSpvmH5zfuMlmwJXxDLysYRtRA83WFdjUEtIxXVQhBrQnkPESs+AHn1V227w6oDcbFLXiMPtYqg0lgW6Au9IuDLd7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414146; c=relaxed/simple;
	bh=a2lQLh6b7gcW9+fWY3frLesVOlXMmzGk2sGt3d3ZRM4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pjvAyIjwPIpzBIL4bOuveR8mFS2zpTreWkI3GrRIsgtGqYnirfmGrsCaOcbs/FqZBctHLK2OUn/qh/nb0uzl0NAaNxnGGPBxYqg3SJ/5g4ZeMlVFn11dt2kaCbkRng3i9M+6JS85AIAaBSojK8K/Qw25hLKzKT2zSnqyunVyiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NBeH27oW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwOq6V79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cdAO698SdhXWwZZt1agsLWXpWIF8YW1n8Q8M59Po8A=;
	b=NBeH27oWvuT7Lr7YPdLqc3f8eE1Tjqqa8D4QImCWfOmwHnWSxkjVWU+thCQYmeMJEDCke+
	8fM6Cxq7zZMtqNuNeS4QyDpuPU9qzvWEwwmarTwj1r1qQEI3f6CfCQnArJnbS2+4kOr9D/
	FIekBV7miyPNc08HYZ+wzFoUZqF3F4ojzijzrapuIQFqBLecbVoYsHD4Nr9W9K6SDGUZga
	Vp86HLH1JPtyImyPPJ0oRT0kt0nsfJ2b7tXBhUetwtm1FMpHYlrrIWqK3eBb8lgghLrKJr
	Vafu7XRZuc5PbTIyS2YwmHkZ2P89jQX5N9TJqC8BaY6bzqsLQxeJvsUrF/piIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736414142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cdAO698SdhXWwZZt1agsLWXpWIF8YW1n8Q8M59Po8A=;
	b=qwOq6V791uSa+AxgUb21xu/AySbLaPthoL6Eg+sbNYrQ1NRe5WLKmW13VdWyrLOUdacVMt
	PlTRo36CSFHKznDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Simplify root device search
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206161210.163701-7-yazen.ghannam@amd.com>
References: <20241206161210.163701-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641414187.399.16998861730227074293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     40a5f6ffdfc8f8ed0d8c535dfa3733b31c66a88c
Gitweb:        https://git.kernel.org/tip/40a5f6ffdfc8f8ed0d8c535dfa3733b31c66a88c
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 06 Dec 2024 16:11:59 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 08 Jan 2025 10:48:03 +01:00

x86/amd_nb: Simplify root device search

The "root" device search was introduced to support SMN access for Zen
systems. This device represents a PCIe root complex. It is not the
same as the "CPU/node" devices found at slots 0x18-0x1F.

There may be multiple PCIe root complexes within an AMD node. Such is
the case with server or High-end Desktop (HEDT) systems, etc. Therefore
it is not enough to assume "root <-> AMD node" is a 1-to-1 association.

Currently, this is handled by skipping "extra" root complexes during the
search. However, the hardware provides the PCI bus number of an AMD
node's root device.

Use the hardware info to get the root device's bus and drop the extra
search code and PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-7-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_node.h |  1 +-
 arch/x86/kernel/amd_nb.c        | 80 +-------------------------------
 arch/x86/kernel/amd_node.c      | 56 ++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 76 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 622bd30..3f097dd 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -23,5 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
 
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
+struct pci_dev *amd_node_get_root(u16 node);
 
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7a62c5a..6218a04 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -15,44 +15,11 @@
 #include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 
-#define PCI_DEVICE_ID_AMD_17H_ROOT		0x1450
-#define PCI_DEVICE_ID_AMD_17H_M10H_ROOT		0x15d0
-#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT		0x1480
-#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT		0x1630
-#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT		0x14a4
-#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT		0x14b5
-#define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
-#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
-#define PCI_DEVICE_ID_AMD_1AH_M00H_ROOT		0x153a
-#define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT		0x1507
-#define PCI_DEVICE_ID_AMD_1AH_M60H_ROOT		0x1122
-#define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
-#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
 static u32 *flush_words;
 
-static const struct pci_device_id amd_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
-	{}
-};
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -85,11 +52,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_root_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
-	{}
-};
-
 static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
@@ -222,19 +184,15 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc;
+	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
-	u16 root_count = 0;
-	u16 i, j;
+	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
 	}
 
@@ -245,23 +203,6 @@ static int amd_cache_northbridges(void)
 	if (!misc_count)
 		return -ENODEV;
 
-	root = NULL;
-	while ((root = next_northbridge(root, root_ids)))
-		root_count++;
-
-	if (root_count) {
-		roots_per_misc = root_count / misc_count;
-
-		/*
-		 * There should be _exactly_ N roots for each DF/SMN
-		 * interface.
-		 */
-		if (!roots_per_misc || (root_count % roots_per_misc)) {
-			pr_info("Unsupported AMD DF/PCI configuration found\n");
-			return -ENODEV;
-		}
-	}
-
 	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
@@ -269,25 +210,12 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	misc = root = NULL;
+	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, root_ids);
+		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
-
-		/*
-		 * If there are more PCI root devices than data fabric/
-		 * system management network interfaces, then the (N)
-		 * PCI roots per DF/SMN interface are functionally the
-		 * same (for DF/SMN access) and N-1 are redundant.  N-1
-		 * PCI roots should be skipped per DF/SMN interface so
-		 * the following DF/SMN interfaces get mapped to
-		 * correct PCI roots.
-		 */
-		for (j = 1; j < roots_per_misc; j++)
-			root = next_northbridge(root, root_ids);
 	}
 
 	if (amd_gart_present())
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index e825cd4..4eea8c7 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -32,3 +32,59 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
 }
+
+#define DF_BLK_INST_CNT		0x040
+#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
+#define	DF_CFG_ADDR_CNTL_DF4	0xC04
+
+#define DF_MAJOR_REVISION	GENMASK(27, 24)
+
+static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
+{
+	u32 reg;
+
+	/*
+	 * Revision fields added for DF4 and later.
+	 *
+	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
+	 */
+	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
+		return 0;
+
+	if (reg & DF_MAJOR_REVISION)
+		return DF_CFG_ADDR_CNTL_DF4;
+
+	return DF_CFG_ADDR_CNTL_LEGACY;
+}
+
+struct pci_dev *amd_node_get_root(u16 node)
+{
+	struct pci_dev *root;
+	u16 cntl_off;
+	u8 bus;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return NULL;
+
+	/*
+	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
+	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
+	 * this Data Fabric instance. The segment, device, and function will be 0.
+	 */
+	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
+	if (!df_f0)
+		return NULL;
+
+	cntl_off = get_cfg_addr_cntl_offset(df_f0);
+	if (!cntl_off)
+		return NULL;
+
+	if (pci_read_config_byte(df_f0, cntl_off, &bus))
+		return NULL;
+
+	/* Grab the pointer for the actual root device instance. */
+	root = pci_get_domain_bus_and_slot(0, bus, 0);
+
+	pci_dbg(root, "is root for AMD node %u\n", node);
+	return root;
+}

