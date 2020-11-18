Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66B62B82EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgKRRSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgKRRSb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:31 -0500
Date:   Wed, 18 Nov 2020 17:18:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utu8mXfJMoOQe4yyZ6T8G2N/JDq5vuFbnFVK382uGMU=;
        b=YAxMFXB0ensIMzhg8jwn0GaSaAsDOCNiiRh4xXqXo0pRm1/0IvcpZ76QHINs5zE0Vih3oF
        VC9X05Hf6HAdwZfCCw4R991JNd8hs2tOaGN7rahRtdhehMfiDz2nljx3aIiw+J4L7k5FjN
        LSZKpnmhbjGlNdliVjvvpGg4MHJXHMkHas31X2unGfiRFHGwIeGR8V4OAn2JSxOFqHZtgZ
        KhH8qiilzeYkYQgpBawhDgT4r7vZ0+pDVTbRrUkXe2Fgw2nlD+9s5wBiLm0UKhpwU1FSyI
        yBZuuGr8Y2J/2YUQoEo++K47Z6EN1tlSg2cVT7OMvZafIr6c3ikEwvzJfSjvPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=utu8mXfJMoOQe4yyZ6T8G2N/JDq5vuFbnFVK382uGMU=;
        b=fEz2L5jeNYad6PCliqlJjyWyOk3fXy1AwpiRmijU7JPav8i6/T58i7RsN3U1fzvKk/71AS
        3jCHlTNBJv3Q/gCw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Initialize metadata for Enclave Page Cache
 (EPC) sections
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-6-jarkko@kernel.org>
References: <20201112220135.165028-6-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990772.11244.15200375874379034363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     e7e0545299d8cb0fd6fe3ba50401b7f5c3937362
Gitweb:        https://git.kernel.org/tip/e7e0545299d8cb0fd6fe3ba50401b7f5c39=
37362
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections

Although carved out of normal DRAM, enclave memory is marked in the
system memory map as reserved and is not managed by the core mm.  There
may be several regions spread across the system.  Each contiguous region
is called an Enclave Page Cache (EPC) section.  EPC sections are
enumerated via CPUID

Enclave pages can only be accessed when they are mapped as part of an
enclave, by a hardware thread running inside the enclave.

Parse CPUID data, create metadata for EPC pages and populate a simple
EPC page allocator.  Although much smaller, =E2=80=98struct sgx_epc_page=E2=
=80=99
metadata is the SGX analog of the core mm =E2=80=98struct page=E2=80=99.

Similar to how the core mm=E2=80=99s page->flags encode zone and NUMA
information, embed the EPC section index to the first eight bits of
sgx_epc_page->desc.  This allows a quick reverse lookup from EPC page to
EPC section.  Existing client hardware supports only a single section,
while upcoming server hardware will support at most eight sections.
Thus, eight bits should be enough for long term needs.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-6-jarkko@kernel.org
---
 arch/x86/Kconfig                 |  17 +++-
 arch/x86/kernel/cpu/Makefile     |   1 +-
 arch/x86/kernel/cpu/sgx/Makefile |   2 +-
 arch/x86/kernel/cpu/sgx/main.c   | 190 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h    |  60 +++++++++-
 5 files changed, 270 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/Makefile
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b8..618d1aa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1930,6 +1930,23 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=3Dauto command line parameter.
 endchoice
=20
+config X86_SGX
+	bool "Software Guard eXtensions (SGX)"
+	depends on X86_64 && CPU_SUP_INTEL
+	depends on CRYPTO=3Dy
+	depends on CRYPTO_SHA256=3Dy
+	select SRCU
+	select MMU_NOTIFIER
+	help
+	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
+	  that can be used by applications to set aside private regions of code
+	  and data, referred to as enclaves. An enclave's private memory can
+	  only be accessed by code running within the enclave. Accesses from
+	  outside the enclave, including other enclaves, are disallowed by
+	  hardware.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 93792b4..637b499 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_X86_MCE)			+=3D mce/
 obj-$(CONFIG_MTRR)			+=3D mtrr/
 obj-$(CONFIG_MICROCODE)			+=3D microcode/
 obj-$(CONFIG_X86_CPU_RESCTRL)		+=3D resctrl/
+obj-$(CONFIG_X86_SGX)			+=3D sgx/
=20
 obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
=20
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makef=
ile
new file mode 100644
index 0000000..79510ce
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -0,0 +1,2 @@
+obj-y +=3D \
+	main.o
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
new file mode 100644
index 0000000..187a237
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
+
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include "encls.h"
+
+struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+static int sgx_nr_epc_sections;
+static struct task_struct *ksgxd_tsk;
+
+/*
+ * Reset dirty EPC pages to uninitialized state. Laundry can be left with SE=
CS
+ * pages whose child pages blocked EREMOVE.
+ */
+static void sgx_sanitize_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+	LIST_HEAD(dirty);
+	int ret;
+
+	while (!list_empty(&section->laundry_list)) {
+		if (kthread_should_stop())
+			return;
+
+		spin_lock(&section->lock);
+
+		page =3D list_first_entry(&section->laundry_list,
+					struct sgx_epc_page, list);
+
+		ret =3D __eremove(sgx_get_epc_virt_addr(page));
+		if (!ret)
+			list_move(&page->list, &section->page_list);
+		else
+			list_move_tail(&page->list, &dirty);
+
+		spin_unlock(&section->lock);
+
+		cond_resched();
+	}
+
+	list_splice(&dirty, &section->laundry_list);
+}
+
+static int ksgxd(void *p)
+{
+	int i;
+
+	set_freezable();
+
+	/*
+	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
+	 * required for SECS pages, whose child pages blocked EREMOVE.
+	 */
+	for (i =3D 0; i < sgx_nr_epc_sections; i++)
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+	for (i =3D 0; i < sgx_nr_epc_sections; i++) {
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+		/* Should never happen. */
+		if (!list_empty(&sgx_epc_sections[i].laundry_list))
+			WARN(1, "EPC section %d has unsanitized pages.\n", i);
+	}
+
+	return 0;
+}
+
+static bool __init sgx_page_reclaimer_init(void)
+{
+	struct task_struct *tsk;
+
+	tsk =3D kthread_run(ksgxd, NULL, "ksgxd");
+	if (IS_ERR(tsk))
+		return false;
+
+	ksgxd_tsk =3D tsk;
+
+	return true;
+}
+
+static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
+					 unsigned long index,
+					 struct sgx_epc_section *section)
+{
+	unsigned long nr_pages =3D size >> PAGE_SHIFT;
+	unsigned long i;
+
+	section->virt_addr =3D memremap(phys_addr, size, MEMREMAP_WB);
+	if (!section->virt_addr)
+		return false;
+
+	section->pages =3D vmalloc(nr_pages * sizeof(struct sgx_epc_page));
+	if (!section->pages) {
+		memunmap(section->virt_addr);
+		return false;
+	}
+
+	section->phys_addr =3D phys_addr;
+	spin_lock_init(&section->lock);
+	INIT_LIST_HEAD(&section->page_list);
+	INIT_LIST_HEAD(&section->laundry_list);
+
+	for (i =3D 0; i < nr_pages; i++) {
+		section->pages[i].section =3D index;
+		list_add_tail(&section->pages[i].list, &section->laundry_list);
+	}
+
+	return true;
+}
+
+/**
+ * A section metric is concatenated in a way that @low bits 12-31 define the
+ * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
+ * metric.
+ */
+static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+static bool __init sgx_page_cache_init(void)
+{
+	u32 eax, ebx, ecx, edx, type;
+	u64 pa, size;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
+		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, &ebx, &ecx, &edx);
+
+		type =3D eax & SGX_CPUID_EPC_MASK;
+		if (type =3D=3D SGX_CPUID_EPC_INVALID)
+			break;
+
+		if (type !=3D SGX_CPUID_EPC_SECTION) {
+			pr_err_once("Unknown EPC section type: %u\n", type);
+			break;
+		}
+
+		pa   =3D sgx_calc_section_metric(eax, ebx);
+		size =3D sgx_calc_section_metric(ecx, edx);
+
+		pr_info("EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
+
+		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i])) {
+			pr_err("No free memory for an EPC section\n");
+			break;
+		}
+
+		sgx_nr_epc_sections++;
+	}
+
+	if (!sgx_nr_epc_sections) {
+		pr_err("There are zero EPC sections.\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void __init sgx_init(void)
+{
+	int i;
+
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return;
+
+	if (!sgx_page_cache_init())
+		return;
+
+	if (!sgx_page_reclaimer_init())
+		goto err_page_cache;
+
+	return;
+
+err_page_cache:
+	for (i =3D 0; i < sgx_nr_epc_sections; i++) {
+		vfree(sgx_epc_sections[i].pages);
+		memunmap(sgx_epc_sections[i].virt_addr);
+	}
+}
+
+device_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
new file mode 100644
index 0000000..02afa84
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_SGX_H
+#define _X86_SGX_H
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include "arch.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "sgx: " fmt
+
+#define SGX_MAX_EPC_SECTIONS		8
+
+struct sgx_epc_page {
+	unsigned int section;
+	struct list_head list;
+};
+
+/*
+ * The firmware can define multiple chunks of EPC to the different areas of =
the
+ * physical memory e.g. for memory areas of the each node. This structure is
+ * used to store EPC pages for one EPC section and virtual memory area where
+ * the pages have been mapped.
+ */
+struct sgx_epc_section {
+	unsigned long phys_addr;
+	void *virt_addr;
+	struct list_head page_list;
+	struct list_head laundry_list;
+	struct sgx_epc_page *pages;
+	spinlock_t lock;
+};
+
+extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+
+static inline unsigned long sgx_get_epc_phys_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
+	unsigned long index;
+
+	index =3D ((unsigned long)page - (unsigned long)section->pages) / sizeof(*p=
age);
+
+	return section->phys_addr + index * PAGE_SIZE;
+}
+
+static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section =3D &sgx_epc_sections[page->section];
+	unsigned long index;
+
+	index =3D ((unsigned long)page - (unsigned long)section->pages) / sizeof(*p=
age);
+
+	return section->virt_addr + index * PAGE_SIZE;
+}
+
+#endif /* _X86_SGX_H */
