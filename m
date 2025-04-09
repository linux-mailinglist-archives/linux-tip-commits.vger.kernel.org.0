Return-Path: <linux-tip-commits+bounces-4819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211E5A8336F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9741704BB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FE2135A1;
	Wed,  9 Apr 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M/PjdmfE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ja4+R7Su"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCAF1B0F19;
	Wed,  9 Apr 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234425; cv=none; b=beWrhvunm2eR4DYaaaERa2N+e+HMlwat6NLvYC/er9eK924f1ASKTwdpYZFxG2eX64zWLszW2/vmbKO/8h5bGMXQEoxHtYYuEtj2Qj8J6xlFvL9mIBZ/SwOuQZVtYi0esG1KBdqOpE+6WD1FzVf6g75rbnLNIqhTkA8IJea95fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234425; c=relaxed/simple;
	bh=JdOn39X3FNu5JSNLrDhPgDNrzrELPoHZNHqg7GCpsxw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JILPjIUClmafkrUe46aozSUVwq7sZ2RHbx0reT3YeB9QmYe+zQjh9SAteIvdKKgi7vQgjsFbNwSSRrreX/VJ1FrtmUxUGoP4D+XVtETe9T/HAQpCLLNDPbLqrg8S0XOy13nGAUUBu58M4EOExi7+hsdit7D5fe+j/3OWP4eVJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M/PjdmfE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ja4+R7Su; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 21:33:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744234421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFCJPpeCHLUSc4T0Q6EKmhMjKKHTWdf3JcaA2i/2mqk=;
	b=M/PjdmfEbZ35OPvANYp3MxIuSA5g5jYgH9BVmZ6Ys8qLTUFh9G2FWiII2BEMHUeISiCSs4
	FxalxZ1sMkOqkvkIX29Mvxn/0ELZEdnXprgO5uVJaACEJnUHj6alRYxYk1QI0TX1MDXG6t
	VijWP3AVOmio8CYFsY/h8VEhnmYSoKcXwuS894XL7RhMnPy3Sj85Q1SMEIfoG3wKkL+Gpp
	AwOgbSPfKrWcOapZ0wf26Hv4tu4Lw+VtxB/o8NxxXqVzCP2+C/mMaUoFsEy8xvnYuqcLEp
	S8MdfWOEXf7mTLECYUGvHC4aqSHwHO/tp4DgiXi35OCmRxE3Pyow2+CZAKkH6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744234421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFCJPpeCHLUSc4T0Q6EKmhMjKKHTWdf3JcaA2i/2mqk=;
	b=Ja4+R7Sur/ajGqPAgJq5gzH5M+h5Jymm623IEIcvRpzatwDPGicEal2hexuX+gfyETCbtd
	/bpO04N+RLPBuMDg==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Consolidate initmem_init()
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409122815.420041-1-rppt@kernel.org>
References: <20250409122815.420041-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174423442043.31282.15471928643459038021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     35c3151a98a6e6f56552cff8dc7d59e8ef7aca50
Gitweb:        https://git.kernel.org/tip/35c3151a98a6e6f56552cff8dc7d59e8ef7aca50
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 15:28:15 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 22:02:30 +02:00

x86/mm: Consolidate initmem_init()

There are 4 wariants of initmem_init(), for 32 and 64 bits and for
CONFIG_NUMA enabled and disabled.

After commit bbeb69ce3013 ("x86/mm: Remove CONFIG_HIGHMEM64G support")
NUMA is not supported on 32 bit kernels anymore, and
arch/x86/mm/numa_32.c can be just deleted and setup_bootmem_allocator()
with completely misleading name can be folded into initmem_init().

For 64 bits the NUMA variant calls x86_numa_init() and !NUMA variant
sets all memory to node 0. The later can be split out into inline helper
called x86_numa_init() and then both initmem_init() functions become the
same.

Split out memblock_set_node() from initmem_init() for !NUMA on 64 bit
into x86_numa_init() helper and remove arch/x86/mm/numa_*.c that only
contained initmem_init() variants for NUMA configs.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>
Link: https://lore.kernel.org/r/20250409122815.420041-1-rppt@kernel.org
---
 arch/x86/include/asm/page_32_types.h |  1 +-
 arch/x86/mm/Makefile                 |  2 +-
 arch/x86/mm/init_32.c                |  7 +---
 arch/x86/mm/init_64.c                |  7 ++-
 arch/x86/mm/mm_internal.h            |  4 ++-
 arch/x86/mm/numa.c                   |  3 +-
 arch/x86/mm/numa_32.c                | 61 +---------------------------
 arch/x86/mm/numa_64.c                | 13 +------
 arch/x86/mm/numa_internal.h          | 10 +----
 9 files changed, 13 insertions(+), 95 deletions(-)
 delete mode 100644 arch/x86/mm/numa_32.c
 delete mode 100644 arch/x86/mm/numa_64.c
 delete mode 100644 arch/x86/mm/numa_internal.h

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index a9b62e0..623f1e9 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -73,7 +73,6 @@ extern unsigned int __VMALLOC_RESERVE;
 extern int sysctl_legacy_va_layout;
 
 extern void find_low_pfn_range(void);
-extern void setup_bootmem_allocator(void);
 
 #endif	/* !__ASSEMBLER__ */
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5..1e72f06 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_MMIOTRACE)		+= mmiotrace.o
 mmiotrace-y			:= kmmio.o pf_in.o mmio-mod.o
 obj-$(CONFIG_MMIOTRACE_TEST)	+= testmmiotrace.o
 
-obj-$(CONFIG_NUMA)		+= numa.o numa_$(BITS).o
+obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_AMD_NUMA)		+= amdtopology.o
 obj-$(CONFIG_ACPI_NUMA)		+= srat.o
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index ad662cc..d467f89 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -612,7 +612,6 @@ void __init find_low_pfn_range(void)
 		highmem_pfn_init();
 }
 
-#ifndef CONFIG_NUMA
 void __init initmem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -633,12 +632,6 @@ void __init initmem_init(void)
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
 
-	setup_bootmem_allocator();
-}
-#endif /* !CONFIG_NUMA */
-
-void __init setup_bootmem_allocator(void)
-{
 	printk(KERN_INFO "  mapped low ram: 0 - %08lx\n",
 		 max_pfn_mapped<<PAGE_SHIFT);
 	printk(KERN_INFO "  low ram: 0 - %08lx\n", max_low_pfn<<PAGE_SHIFT);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7c4f6f5..b765539 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -805,12 +805,17 @@ kernel_physical_mapping_change(unsigned long paddr_start,
 }
 
 #ifndef CONFIG_NUMA
-void __init initmem_init(void)
+static inline void x86_numa_init(void)
 {
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
 }
 #endif
 
+void __init initmem_init(void)
+{
+	x86_numa_init();
+}
+
 void __init paging_init(void)
 {
 	sparse_init();
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 3f37b5c..097aadc 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -25,4 +25,8 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
 extern unsigned long tlb_single_page_flush_ceiling;
 
+#ifdef CONFIG_NUMA
+void __init x86_numa_init(void);
+#endif
+
 #endif	/* __X86_MM_INTERNAL_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 64e5cdb..4bf04be 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -19,8 +19,9 @@
 #include <asm/proto.h>
 #include <asm/dma.h>
 #include <asm/amd_nb.h>
+#include <asm/numa.h>
 
-#include "numa_internal.h"
+#include "mm_internal.h"
 
 int numa_off;
 
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
deleted file mode 100644
index 65fda40..0000000
--- a/arch/x86/mm/numa_32.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Written by: Patricia Gaughen <gone@us.ibm.com>, IBM Corporation
- * August 2002: added remote node KVA remap - Martin J. Bligh 
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.          
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/memblock.h>
-#include <linux/init.h>
-#include <linux/vmalloc.h>
-#include <asm/pgtable_areas.h>
-
-#include "numa_internal.h"
-
-extern unsigned long highend_pfn, highstart_pfn;
-
-void __init initmem_init(void)
-{
-	x86_numa_init();
-
-#ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > max_low_pfn)
-		highstart_pfn = max_low_pfn;
-	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-	       pages_to_mb(highend_pfn - highstart_pfn));
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
-#endif
-	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
-			pages_to_mb(max_low_pfn));
-	printk(KERN_DEBUG "max_low_pfn = %lx, highstart_pfn = %lx\n",
-			max_low_pfn, highstart_pfn);
-
-	printk(KERN_DEBUG "Low memory ends at vaddr %08lx\n",
-			(ulong) pfn_to_kaddr(max_low_pfn));
-
-	printk(KERN_DEBUG "High memory starts at vaddr %08lx\n",
-			(ulong) pfn_to_kaddr(highstart_pfn));
-
-	__vmalloc_start_set = true;
-	setup_bootmem_allocator();
-}
diff --git a/arch/x86/mm/numa_64.c b/arch/x86/mm/numa_64.c
deleted file mode 100644
index 59d8016..0000000
--- a/arch/x86/mm/numa_64.c
+++ /dev/null
@@ -1,13 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Generic VM initialization for x86-64 NUMA setups.
- * Copyright 2002,2003 Andi Kleen, SuSE Labs.
- */
-#include <linux/memblock.h>
-
-#include "numa_internal.h"
-
-void __init initmem_init(void)
-{
-	x86_numa_init();
-}
diff --git a/arch/x86/mm/numa_internal.h b/arch/x86/mm/numa_internal.h
deleted file mode 100644
index 11e1ff3..0000000
--- a/arch/x86/mm/numa_internal.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __X86_MM_NUMA_INTERNAL_H
-#define __X86_MM_NUMA_INTERNAL_H
-
-#include <linux/types.h>
-#include <asm/numa.h>
-
-void __init x86_numa_init(void);
-
-#endif	/* __X86_MM_NUMA_INTERNAL_H */

