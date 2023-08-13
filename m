Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE477AA58
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Aug 2023 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHMR0g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Aug 2023 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjHMR0e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Aug 2023 13:26:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398910FC;
        Sun, 13 Aug 2023 10:26:34 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2M4+Zz+hclx+3HMoXT37qiV9uK9lQhfWYFEKNiS29c=;
        b=s8lw9fFk82o+ig56fa+qX/aaCF9fLuktLNnohAEt2QWWzc1r/l2ITx+6tOdDVPuuET6Sdc
        q54VKM+alxHqFFfuaj5Fz2xdI3tuZfoLus6vOLCL1JzFxuWeKP7Z7b8G8fI/AHSnEeKAPV
        9OOMqERj/Uqi+bN5vC08M2+YHRpZVYZG7rqEhIsRZEPhFRXPRf0KH4NM9nHNo8wcFEZk9Q
        6UQf0V06shhRiUvjc790IpFbQRdPeST1iX7k+LKur+myCDa5yfKBZ4RDudMLNrhsxeb0Xg
        CYsieDK7YQlVAcMxoBPC8REZkUtRZd2eNxt4pKHJQ5/x80UCptSuybifSMgcQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691947592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2M4+Zz+hclx+3HMoXT37qiV9uK9lQhfWYFEKNiS29c=;
        b=UtaGLIvQ7hK5zhmHO7TLP8ON6vsBiTwHjwdDsElvV/ePLPkBnTr7IoB5qgZUoKK/GBNWIm
        nVgPdg/2BW0BdBCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Move core specific defines to
 local header
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230812195727.952876381@linutronix.de>
References: <20230812195727.952876381@linutronix.de>
MIME-Version: 1.0
Message-ID: <169194759191.27769.13080345844653532620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d02a0efd0f471a775b9e28ce6593fc8b3cc46e8c
Gitweb:        https://git.kernel.org/tip/d02a0efd0f471a775b9e28ce6593fc8b3cc46e8c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 12 Aug 2023 21:58:47 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 13 Aug 2023 18:42:55 +02:00

x86/microcode: Move core specific defines to local header

There is no reason to expose all of this globally. Move everything which is
not required outside of the microcode specific code to local header files
and into the respective source files.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230812195727.952876381@linutronix.de
---
 arch/x86/include/asm/microcode.h         | 155 ++++++----------------
 arch/x86/include/asm/microcode_amd.h     |  54 +--------
 arch/x86/include/asm/microcode_intel.h   |  63 +---------
 arch/x86/kernel/cpu/microcode/amd.c      |  41 ++++++-
 arch/x86/kernel/cpu/microcode/core.c     |   3 +-
 arch/x86/kernel/cpu/microcode/intel.c    |   3 +-
 arch/x86/kernel/cpu/microcode/internal.h | 131 +++++++++++++++++++-
 7 files changed, 223 insertions(+), 227 deletions(-)
 delete mode 100644 arch/x86/include/asm/microcode_amd.h
 delete mode 100644 arch/x86/include/asm/microcode_intel.h
 create mode 100644 arch/x86/kernel/cpu/microcode/internal.h

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 166a633..bbbe9d7 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -2,138 +2,77 @@
 #ifndef _ASM_X86_MICROCODE_H
 #define _ASM_X86_MICROCODE_H
 
-#include <linux/earlycpio.h>
-#include <linux/initrd.h>
-
-#include <asm/cpu.h>
-#include <asm/microcode_amd.h>
-#include <asm/microcode_intel.h>
-
-struct ucode_patch {
-	struct list_head plist;
-	void *data;		/* Intel uses only this one */
-	unsigned int size;
-	u32 patch_id;
-	u16 equiv_cpu;
-};
-
-extern struct list_head microcode_cache;
-
 struct cpu_signature {
 	unsigned int sig;
 	unsigned int pf;
 	unsigned int rev;
 };
 
-struct device;
-
-enum ucode_state {
-	UCODE_OK	= 0,
-	UCODE_NEW,
-	UCODE_UPDATED,
-	UCODE_NFOUND,
-	UCODE_ERROR,
-};
-
-struct microcode_ops {
-	enum ucode_state (*request_microcode_fw) (int cpu, struct device *);
-
-	void (*microcode_fini_cpu) (int cpu);
-
-	/*
-	 * The generic 'microcode_core' part guarantees that
-	 * the callbacks below run on a target cpu when they
-	 * are being called.
-	 * See also the "Synchronization" section in microcode_core.c.
-	 */
-	enum ucode_state (*apply_microcode) (int cpu);
-	int (*collect_cpu_info) (int cpu, struct cpu_signature *csig);
-};
-
 struct ucode_cpu_info {
 	struct cpu_signature	cpu_sig;
 	void			*mc;
 };
-extern struct ucode_cpu_info ucode_cpu_info[];
-struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa);
 
-#ifdef CONFIG_CPU_SUP_INTEL
-extern struct microcode_ops * __init init_intel_microcode(void);
-#else
-static inline struct microcode_ops * __init init_intel_microcode(void)
-{
-	return NULL;
-}
-#endif /* CONFIG_CPU_SUP_INTEL */
-
-#ifdef CONFIG_CPU_SUP_AMD
-extern struct microcode_ops * __init init_amd_microcode(void);
-extern void __exit exit_amd_microcode(void);
+#ifdef CONFIG_MICROCODE
+void load_ucode_bsp(void);
+void load_ucode_ap(void);
+void microcode_bsp_resume(void);
 #else
-static inline struct microcode_ops * __init init_amd_microcode(void)
-{
-	return NULL;
-}
-static inline void __exit exit_amd_microcode(void) {}
+static inline void load_ucode_bsp(void)	{ }
+static inline void load_ucode_ap(void) { }
+static inline void microcode_bsp_resume(void) { }
 #endif
 
-#define MAX_UCODE_COUNT 128
+#ifdef CONFIG_CPU_SUP_INTEL
+/* Intel specific microcode defines. Public for IFS */
+struct microcode_header_intel {
+	unsigned int	hdrver;
+	unsigned int	rev;
+	unsigned int	date;
+	unsigned int	sig;
+	unsigned int	cksum;
+	unsigned int	ldrver;
+	unsigned int	pf;
+	unsigned int	datasize;
+	unsigned int	totalsize;
+	unsigned int	metasize;
+	unsigned int	reserved[2];
+};
 
-#define QCHAR(a, b, c, d) ((a) + ((b) << 8) + ((c) << 16) + ((d) << 24))
-#define CPUID_INTEL1 QCHAR('G', 'e', 'n', 'u')
-#define CPUID_INTEL2 QCHAR('i', 'n', 'e', 'I')
-#define CPUID_INTEL3 QCHAR('n', 't', 'e', 'l')
-#define CPUID_AMD1 QCHAR('A', 'u', 't', 'h')
-#define CPUID_AMD2 QCHAR('e', 'n', 't', 'i')
-#define CPUID_AMD3 QCHAR('c', 'A', 'M', 'D')
+struct microcode_intel {
+	struct microcode_header_intel	hdr;
+	unsigned int			bits[];
+};
 
-#define CPUID_IS(a, b, c, ebx, ecx, edx)	\
-		(!((ebx ^ (a))|(edx ^ (b))|(ecx ^ (c))))
+#define DEFAULT_UCODE_DATASIZE		(2000)
+#define MC_HEADER_SIZE			(sizeof(struct microcode_header_intel))
+#define MC_HEADER_TYPE_MICROCODE	1
+#define MC_HEADER_TYPE_IFS		2
 
-/*
- * In early loading microcode phase on BSP, boot_cpu_data is not set up yet.
- * x86_cpuid_vendor() gets vendor id for BSP.
- *
- * In 32 bit AP case, accessing boot_cpu_data needs linear address. To simplify
- * coding, we still use x86_cpuid_vendor() to get vendor id for AP.
- *
- * x86_cpuid_vendor() gets vendor information directly from CPUID.
- */
-static inline int x86_cpuid_vendor(void)
+static inline int intel_microcode_get_datasize(struct microcode_header_intel *hdr)
 {
-	u32 eax = 0x00000000;
-	u32 ebx, ecx = 0, edx;
-
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	if (CPUID_IS(CPUID_INTEL1, CPUID_INTEL2, CPUID_INTEL3, ebx, ecx, edx))
-		return X86_VENDOR_INTEL;
-
-	if (CPUID_IS(CPUID_AMD1, CPUID_AMD2, CPUID_AMD3, ebx, ecx, edx))
-		return X86_VENDOR_AMD;
-
-	return X86_VENDOR_UNKNOWN;
+	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
 }
 
-static inline unsigned int x86_cpuid_family(void)
+static inline u32 intel_get_microcode_revision(void)
 {
-	u32 eax = 0x00000001;
-	u32 ebx, ecx = 0, edx;
+	u32 rev, dummy;
+
+	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
 
-	native_cpuid(&eax, &ebx, &ecx, &edx);
+	/* As documented in the SDM: Do a CPUID 1 here */
+	native_cpuid_eax(1);
 
-	return x86_family(eax);
+	/* get the current revision from MSR 0x8B */
+	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
+
+	return rev;
 }
 
-#ifdef CONFIG_MICROCODE
-extern void __init load_ucode_bsp(void);
-extern void load_ucode_ap(void);
-extern bool initrd_gone;
-void microcode_bsp_resume(void);
-#else
-static inline void __init load_ucode_bsp(void)			{ }
-static inline void load_ucode_ap(void)				{ }
-static inline void microcode_bsp_resume(void)			{ }
-#endif
+void show_ucode_info_early(void);
+
+#else /* CONFIG_CPU_SUP_INTEL */
+static inline void show_ucode_info_early(void) { }
+#endif /* !CONFIG_CPU_SUP_INTEL */
 
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
deleted file mode 100644
index febe9bf..0000000
--- a/arch/x86/include/asm/microcode_amd.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MICROCODE_AMD_H
-#define _ASM_X86_MICROCODE_AMD_H
-
-#define UCODE_MAGIC			0x00414d44
-#define UCODE_EQUIV_CPU_TABLE_TYPE	0x00000000
-#define UCODE_UCODE_TYPE		0x00000001
-
-#define SECTION_HDR_SIZE		8
-#define CONTAINER_HDR_SZ		12
-
-struct equiv_cpu_entry {
-	u32	installed_cpu;
-	u32	fixed_errata_mask;
-	u32	fixed_errata_compare;
-	u16	equiv_cpu;
-	u16	res;
-} __attribute__((packed));
-
-struct microcode_header_amd {
-	u32	data_code;
-	u32	patch_id;
-	u16	mc_patch_data_id;
-	u8	mc_patch_data_len;
-	u8	init_flag;
-	u32	mc_patch_data_checksum;
-	u32	nb_dev_id;
-	u32	sb_dev_id;
-	u16	processor_rev_id;
-	u8	nb_rev_id;
-	u8	sb_rev_id;
-	u8	bios_api_rev;
-	u8	reserved1[3];
-	u32	match_reg[8];
-} __attribute__((packed));
-
-struct microcode_amd {
-	struct microcode_header_amd	hdr;
-	unsigned int			mpb[];
-};
-
-#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
-
-#ifdef CONFIG_CPU_SUP_AMD
-extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
-extern int __init save_microcode_in_initrd_amd(unsigned int family);
-void reload_ucode_amd(unsigned int cpu);
-#else
-static inline void load_ucode_amd_early(unsigned int cpuid_1_eax) {}
-static inline int __init
-save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
-static inline void reload_ucode_amd(unsigned int cpu) {}
-#endif
-#endif /* _ASM_X86_MICROCODE_AMD_H */
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
deleted file mode 100644
index 7bd4c29..0000000
--- a/arch/x86/include/asm/microcode_intel.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MICROCODE_INTEL_H
-#define _ASM_X86_MICROCODE_INTEL_H
-
-struct microcode_header_intel {
-	unsigned int            hdrver;
-	unsigned int            rev;
-	unsigned int            date;
-	unsigned int            sig;
-	unsigned int            cksum;
-	unsigned int            ldrver;
-	unsigned int            pf;
-	unsigned int            datasize;
-	unsigned int            totalsize;
-	unsigned int            metasize;
-	unsigned int            reserved[2];
-};
-
-struct microcode_intel {
-	struct microcode_header_intel hdr;
-	unsigned int            bits[];
-};
-
-#define MC_HEADER_SIZE			(sizeof(struct microcode_header_intel))
-#define MC_HEADER_TYPE_MICROCODE	1
-#define MC_HEADER_TYPE_IFS		2
-#define DEFAULT_UCODE_DATASIZE		(2000)
-
-static inline int intel_microcode_get_datasize(struct microcode_header_intel *hdr)
-{
-	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
-}
-
-static inline u32 intel_get_microcode_revision(void)
-{
-	u32 rev, dummy;
-
-	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
-
-	/* As documented in the SDM: Do a CPUID 1 here */
-	native_cpuid_eax(1);
-
-	/* get the current revision from MSR 0x8B */
-	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
-
-	return rev;
-}
-
-#ifdef CONFIG_CPU_SUP_INTEL
-extern void __init load_ucode_intel_bsp(void);
-extern void load_ucode_intel_ap(void);
-extern void show_ucode_info_early(void);
-extern int __init save_microcode_in_initrd_intel(void);
-void reload_ucode_intel(void);
-#else
-static inline __init void load_ucode_intel_bsp(void) {}
-static inline void load_ucode_intel_ap(void) {}
-static inline void show_ucode_info_early(void) {}
-static inline int __init save_microcode_in_initrd_intel(void) { return -EINVAL; }
-static inline void reload_ucode_intel(void) {}
-#endif
-
-#endif /* _ASM_X86_MICROCODE_INTEL_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index dc0a3be..bbd1dc3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -35,6 +35,47 @@
 #include <asm/cpu.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
+#define UCODE_MAGIC			0x00414d44
+#define UCODE_EQUIV_CPU_TABLE_TYPE	0x00000000
+#define UCODE_UCODE_TYPE		0x00000001
+
+#define SECTION_HDR_SIZE		8
+#define CONTAINER_HDR_SZ		12
+
+struct equiv_cpu_entry {
+	u32	installed_cpu;
+	u32	fixed_errata_mask;
+	u32	fixed_errata_compare;
+	u16	equiv_cpu;
+	u16	res;
+} __packed;
+
+struct microcode_header_amd {
+	u32	data_code;
+	u32	patch_id;
+	u16	mc_patch_data_id;
+	u8	mc_patch_data_len;
+	u8	init_flag;
+	u32	mc_patch_data_checksum;
+	u32	nb_dev_id;
+	u32	sb_dev_id;
+	u16	processor_rev_id;
+	u8	nb_rev_id;
+	u8	sb_rev_id;
+	u8	bios_api_rev;
+	u8	reserved1[3];
+	u32	match_reg[8];
+} __packed;
+
+struct microcode_amd {
+	struct microcode_header_amd	hdr;
+	unsigned int			mpb[];
+};
+
+#define PATCH_MAX_SIZE (3 * PAGE_SIZE)
+
 static struct equiv_cpu_table {
 	unsigned int num_entries;
 	struct equiv_cpu_entry *entry;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 75c5bc7..6cc7a2c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -33,11 +33,12 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
-#include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/cmdline.h>
 #include <asm/setup.h>
 
+#include "internal.h"
+
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 9866672..d983a3e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -32,11 +32,12 @@
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
-#include <asm/microcode.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
new file mode 100644
index 0000000..8ee9392
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_MICROCODE_INTERNAL_H
+#define _X86_MICROCODE_INTERNAL_H
+
+#include <linux/earlycpio.h>
+#include <linux/initrd.h>
+
+#include <asm/cpu.h>
+#include <asm/microcode.h>
+
+struct ucode_patch {
+	struct list_head plist;
+	void *data;		/* Intel uses only this one */
+	unsigned int size;
+	u32 patch_id;
+	u16 equiv_cpu;
+};
+
+extern struct list_head microcode_cache;
+
+struct device;
+
+enum ucode_state {
+	UCODE_OK	= 0,
+	UCODE_NEW,
+	UCODE_UPDATED,
+	UCODE_NFOUND,
+	UCODE_ERROR,
+};
+
+struct microcode_ops {
+	enum ucode_state (*request_microcode_fw)(int cpu, struct device *dev);
+
+	void (*microcode_fini_cpu)(int cpu);
+
+	/*
+	 * The generic 'microcode_core' part guarantees that
+	 * the callbacks below run on a target cpu when they
+	 * are being called.
+	 * See also the "Synchronization" section in microcode_core.c.
+	 */
+	enum ucode_state (*apply_microcode)(int cpu);
+	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+};
+
+extern struct ucode_cpu_info ucode_cpu_info[];
+struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa);
+
+#define MAX_UCODE_COUNT 128
+
+#define QCHAR(a, b, c, d) ((a) + ((b) << 8) + ((c) << 16) + ((d) << 24))
+#define CPUID_INTEL1 QCHAR('G', 'e', 'n', 'u')
+#define CPUID_INTEL2 QCHAR('i', 'n', 'e', 'I')
+#define CPUID_INTEL3 QCHAR('n', 't', 'e', 'l')
+#define CPUID_AMD1 QCHAR('A', 'u', 't', 'h')
+#define CPUID_AMD2 QCHAR('e', 'n', 't', 'i')
+#define CPUID_AMD3 QCHAR('c', 'A', 'M', 'D')
+
+#define CPUID_IS(a, b, c, ebx, ecx, edx)	\
+		(!(((ebx) ^ (a)) | ((edx) ^ (b)) | ((ecx) ^ (c))))
+
+/*
+ * In early loading microcode phase on BSP, boot_cpu_data is not set up yet.
+ * x86_cpuid_vendor() gets vendor id for BSP.
+ *
+ * In 32 bit AP case, accessing boot_cpu_data needs linear address. To simplify
+ * coding, we still use x86_cpuid_vendor() to get vendor id for AP.
+ *
+ * x86_cpuid_vendor() gets vendor information directly from CPUID.
+ */
+static inline int x86_cpuid_vendor(void)
+{
+	u32 eax = 0x00000000;
+	u32 ebx, ecx = 0, edx;
+
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	if (CPUID_IS(CPUID_INTEL1, CPUID_INTEL2, CPUID_INTEL3, ebx, ecx, edx))
+		return X86_VENDOR_INTEL;
+
+	if (CPUID_IS(CPUID_AMD1, CPUID_AMD2, CPUID_AMD3, ebx, ecx, edx))
+		return X86_VENDOR_AMD;
+
+	return X86_VENDOR_UNKNOWN;
+}
+
+static inline unsigned int x86_cpuid_family(void)
+{
+	u32 eax = 0x00000001;
+	u32 ebx, ecx = 0, edx;
+
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	return x86_family(eax);
+}
+
+extern bool initrd_gone;
+
+#ifdef CONFIG_CPU_SUP_AMD
+void load_ucode_amd_bsp(unsigned int family);
+void load_ucode_amd_ap(unsigned int family);
+void load_ucode_amd_early(unsigned int cpuid_1_eax);
+int save_microcode_in_initrd_amd(unsigned int family);
+void reload_ucode_amd(unsigned int cpu);
+struct microcode_ops *init_amd_microcode(void);
+void exit_amd_microcode(void);
+#else /* CONFIG_MICROCODE_AMD */
+static inline void load_ucode_amd_bsp(unsigned int family) { }
+static inline void load_ucode_amd_ap(unsigned int family) { }
+static inline void load_ucode_amd_early(unsigned int family) { }
+static inline int save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
+static inline void reload_ucode_amd(unsigned int cpu) { }
+static inline struct microcode_ops *init_amd_microcode(void) { return NULL; }
+static inline void exit_amd_microcode(void) { }
+#endif /* !CONFIG_MICROCODE_AMD */
+
+#ifdef CONFIG_CPU_SUP_INTEL
+void load_ucode_intel_bsp(void);
+void load_ucode_intel_ap(void);
+int save_microcode_in_initrd_intel(void);
+void reload_ucode_intel(void);
+struct microcode_ops *init_intel_microcode(void);
+#else /* CONFIG_CPU_SUP_INTEL */
+static inline void load_ucode_intel_bsp(void) { }
+static inline void load_ucode_intel_ap(void) { }
+static inline int save_microcode_in_initrd_intel(void) { return -EINVAL; }
+static inline void reload_ucode_intel(void) { }
+static inline struct microcode_ops *init_intel_microcode(void) { return NULL; }
+#endif  /* !CONFIG_CPU_SUP_INTEL */
+
+#endif /* _X86_MICROCODE_INTERNAL_H */
