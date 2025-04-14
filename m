Return-Path: <linux-tip-commits+bounces-4972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D40A879FC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AD13B11FD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40625C6EC;
	Mon, 14 Apr 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QwQ5VPp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BUOgVBzz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF325A356;
	Mon, 14 Apr 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618518; cv=none; b=b/lZi9dWJyp3wIUabMWps3FQouYBEYli8J1xkwqt2k/E02PAnpel0d9k+DbAG7/NKHE/pl1z3pmxRxOO3N7RjIN6GFLlIDgK/Knme1o5RxDgW+3L1gpm6WCvb5FDNMFFILX8ilwgjKVlcTYdehe8xj720ookv1fSkjBhhvUqcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618518; c=relaxed/simple;
	bh=SrpbiCXAqMyMUcDf1sJ5vnGHipQ5tOGJ5cj6W3kTo7A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RDpH9Q8/1S8nSNDZrIv+/WYWLm0FtZQMZ3nS12gVKSfibH/+yFyOlhowb9Hkfev9G3rm8SK4pelBSqDlnjemwbKsLl5ShF7rXIS8HuLFkybWfnbKfxX2wF2Jx6v/fOsYmfG+YzMbymioxGxVbEFIY9X4cdHIPDEpffgr6Nnpcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QwQ5VPp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BUOgVBzz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 08:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744618514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdXyAZzPT0i9GmnLaiycJl+PMT2o9NpXdroPlwwQFpI=;
	b=4QwQ5VPp/v76UZmh9nrqHVIBGcWnGL5NE7uA40vQmJnWZGONabBQ5sAmORRw5fISAeUMiV
	NX0wJTiM/HV5qWv/BZBUkYY7vW/5LCcsWWkuqNLa2vM6En4giOuaYl6yA21tbQgQeK7BcJ
	+T42+Jm3uoCc2swVVLUie5YdUL61xJa2OwLP+wCJwZRsNUsiHLfku762Rd8zYzpRAsgudT
	rAU6jFctx+ZtveyrwjV/BlHPT+AumNxGifXnRPAEO2xUTcTDc1xb4C/LvRYdK574IdH+tf
	AjwxNQgJAWAZEZ37KegzPDS4KBcPgvj7sZJF7b+/rsDwG67Kb32GP6WjJEai5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744618514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdXyAZzPT0i9GmnLaiycJl+PMT2o9NpXdroPlwwQFpI=;
	b=BUOgVBzzKYGrYn0rum8HufZcspmx5o2QqvYCuLOkGEUHbdU5orM7LNcBNFRYPvoP/icI//
	FTu1DgiXGxKbZyBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/platform/amd: Move the <asm/amd_nb.h> header to
 <asm/amd/nb.h>
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mario Limonciello <superm1@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250413084144.3746608-4-mingo@kernel.org>
References: <20250413084144.3746608-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461851346.31282.14244298779117666231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     bcbb65559532891148d990527e9df6b8fc98e98d
Gitweb:        https://git.kernel.org/tip/bcbb65559532891148d990527e9df6b8fc98e98d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 14 Apr 2025 09:32:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:34:14 +02:00

x86/platform/amd: Move the <asm/amd_nb.h> header to <asm/amd/nb.h>

Collect AMD specific platform header files in <asm/amd/*.h>.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mario Limonciello <superm1@kernel.org>
Link: https://lore.kernel.org/r/20250413084144.3746608-4-mingo@kernel.org
---
 arch/x86/include/asm/amd/nb.h           | 77 ++++++++++++++++++++++++-
 arch/x86/include/asm/amd_nb.h           | 77 +------------------------
 arch/x86/kernel/amd_gart_64.c           |  2 +-
 arch/x86/kernel/amd_nb.c                |  2 +-
 arch/x86/kernel/aperture_64.c           |  2 +-
 arch/x86/kernel/cpu/amd_cache_disable.c |  2 +-
 arch/x86/kernel/cpu/cacheinfo.c         |  2 +-
 arch/x86/kernel/cpu/mce/inject.c        |  2 +-
 arch/x86/mm/amdtopology.c               |  2 +-
 arch/x86/mm/numa.c                      |  2 +-
 arch/x86/pci/amd_bus.c                  |  2 +-
 drivers/char/agp/amd64-agp.c            |  2 +-
 drivers/edac/amd64_edac.c               |  2 +-
 drivers/platform/x86/amd/pmc/mp1_stb.c  |  2 +-
 drivers/pnp/quirks.c                    |  2 +-
 drivers/ras/amd/atl/internal.h          |  2 +-
 16 files changed, 91 insertions(+), 91 deletions(-)
 create mode 100644 arch/x86/include/asm/amd/nb.h
 delete mode 100644 arch/x86/include/asm/amd_nb.h

diff --git a/arch/x86/include/asm/amd/nb.h b/arch/x86/include/asm/amd/nb.h
new file mode 100644
index 0000000..adfa085
--- /dev/null
+++ b/arch/x86/include/asm/amd/nb.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_AMD_NB_H
+#define _ASM_X86_AMD_NB_H
+
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <asm/amd_node.h>
+
+struct amd_nb_bus_dev_range {
+	u8 bus;
+	u8 dev_base;
+	u8 dev_limit;
+};
+
+extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
+
+extern bool early_is_amd_nb(u32 value);
+extern struct resource *amd_get_mmconfig_range(struct resource *res);
+extern void amd_flush_garts(void);
+extern int amd_numa_init(void);
+extern int amd_get_subcaches(int);
+extern int amd_set_subcaches(int, unsigned long);
+
+struct amd_l3_cache {
+	unsigned indices;
+	u8	 subcaches[4];
+};
+
+struct amd_northbridge {
+	struct pci_dev *misc;
+	struct pci_dev *link;
+	struct amd_l3_cache l3_cache;
+};
+
+struct amd_northbridge_info {
+	u16 num;
+	u64 flags;
+	struct amd_northbridge *nb;
+};
+
+#define AMD_NB_GART			BIT(0)
+#define AMD_NB_L3_INDEX_DISABLE		BIT(1)
+#define AMD_NB_L3_PARTITIONING		BIT(2)
+
+#ifdef CONFIG_AMD_NB
+
+u16 amd_nb_num(void);
+bool amd_nb_has_feature(unsigned int feature);
+struct amd_northbridge *node_to_amd_nb(int node);
+
+static inline bool amd_gart_present(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;
+
+	/* GART present only on Fam15h, up to model 0fh */
+	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
+	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
+		return true;
+
+	return false;
+}
+
+#else
+
+#define amd_nb_num(x)		0
+#define amd_nb_has_feature(x)	false
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
+#define amd_gart_present(x)	false
+
+#endif
+
+
+#endif /* _ASM_X86_AMD_NB_H */
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
deleted file mode 100644
index adfa085..0000000
--- a/arch/x86/include/asm/amd_nb.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_AMD_NB_H
-#define _ASM_X86_AMD_NB_H
-
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <asm/amd_node.h>
-
-struct amd_nb_bus_dev_range {
-	u8 bus;
-	u8 dev_base;
-	u8 dev_limit;
-};
-
-extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
-
-extern bool early_is_amd_nb(u32 value);
-extern struct resource *amd_get_mmconfig_range(struct resource *res);
-extern void amd_flush_garts(void);
-extern int amd_numa_init(void);
-extern int amd_get_subcaches(int);
-extern int amd_set_subcaches(int, unsigned long);
-
-struct amd_l3_cache {
-	unsigned indices;
-	u8	 subcaches[4];
-};
-
-struct amd_northbridge {
-	struct pci_dev *misc;
-	struct pci_dev *link;
-	struct amd_l3_cache l3_cache;
-};
-
-struct amd_northbridge_info {
-	u16 num;
-	u64 flags;
-	struct amd_northbridge *nb;
-};
-
-#define AMD_NB_GART			BIT(0)
-#define AMD_NB_L3_INDEX_DISABLE		BIT(1)
-#define AMD_NB_L3_PARTITIONING		BIT(2)
-
-#ifdef CONFIG_AMD_NB
-
-u16 amd_nb_num(void);
-bool amd_nb_has_feature(unsigned int feature);
-struct amd_northbridge *node_to_amd_nb(int node);
-
-static inline bool amd_gart_present(void)
-{
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
-		return false;
-
-	/* GART present only on Fam15h, up to model 0fh */
-	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
-	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
-		return true;
-
-	return false;
-}
-
-#else
-
-#define amd_nb_num(x)		0
-#define amd_nb_has_feature(x)	false
-static inline struct amd_northbridge *node_to_amd_nb(int node)
-{
-	return NULL;
-}
-#define amd_gart_present(x)	false
-
-#endif
-
-
-#endif /* _ASM_X86_AMD_NB_H */
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index c884dec..3485d41 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -39,7 +39,7 @@
 #include <asm/gart.h>
 #include <asm/set_memory.h>
 #include <asm/dma.h>
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/x86_init.h>
 
 static unsigned long iommu_bus_base;	/* GART remapping area (physical) */
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 5a8cc48..ffaad17 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -14,7 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci_ids.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/cpuid.h>
 
 static u32 *flush_words;
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 89c0c8a..7693211 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -29,7 +29,7 @@
 #include <asm/gart.h>
 #include <asm/pci-direct.h>
 #include <asm/dma.h>
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/x86_init.h>
 #include <linux/crash_dump.h>
 
diff --git a/arch/x86/kernel/cpu/amd_cache_disable.c b/arch/x86/kernel/cpu/amd_cache_disable.c
index d860ad3..8843b95 100644
--- a/arch/x86/kernel/cpu/amd_cache_disable.c
+++ b/arch/x86/kernel/cpu/amd_cache_disable.c
@@ -9,7 +9,7 @@
 #include <linux/pci.h>
 #include <linux/sysfs.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 
 #include "cpu.h"
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index cc7ae2b..f866d94 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -13,7 +13,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/stop_machine.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/cpuid.h>
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 06e3cf7..bb060f8 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/apic.h>
 #include <asm/irq_vectors.h>
 #include <asm/mce.h>
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 628833a..f980b0e 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -25,7 +25,7 @@
 #include <asm/numa.h>
 #include <asm/mpspec.h>
 #include <asm/apic.h>
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 
 static unsigned char __initdata nodeids[8];
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 64e5cdb..fed02d1 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -18,7 +18,7 @@
 #include <asm/e820/api.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 
 #include "numa_internal.h"
 
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 631512f..95ae197 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -5,7 +5,7 @@
 #include <linux/cpu.h>
 #include <linux/range.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/pci_x86.h>
 
 #include <asm/pci-direct.h>
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 8e41731..bf49096 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -16,7 +16,7 @@
 #include <linux/mmzone.h>
 #include <asm/page.h>		/* PAGE_SIZE */
 #include <asm/e820/api.h>
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/gart.h>
 #include "agp.h"
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 90f0eb7..417940f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2,7 +2,7 @@
 #include <linux/ras.h>
 #include <linux/string_choices.h>
 #include "amd64_edac.h"
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/amd_node.h>
 
 static struct edac_pci_ctl_info *pci_ctl;
diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index c005f00..3b9b9f3 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -11,7 +11,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index 6085a14..6e1d4bf 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -290,7 +290,7 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 
 #ifdef CONFIG_AMD_NB
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 
 static void quirk_amd_mmconfig_area(struct pnp_dev *dev)
 {
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index f9be26d..c63fee3 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -17,7 +17,7 @@
 #include <linux/bitops.h>
 #include <linux/ras.h>
 
-#include <asm/amd_nb.h>
+#include <asm/amd/nb.h>
 #include <asm/amd_node.h>
 
 #include "reg_fields.h"

