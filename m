Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C02AA135
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgKFX2f (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:28:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKFX1S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:18 -0500
Date:   Fri, 06 Nov 2020 23:27:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWTzib6KkNgcZv7eTt7hwL8IT2P5IL4ct43pcSl5+xY=;
        b=Y4Ou30qMELR3u45q7sqO6LIHk53TjNc96ZvBDRcLxzuZuuvBaT4qbNzIc85jT5aCSl/I5q
        h8RnhpW5T0h1NpWviS8pPHShfdnS3Icvn8nc0gmJhv29FhBnptYy/Fin0OTYCPqjoHLeuA
        QcAW+3UIYRA48F8jgCirCsvuFuIokr/V/wx5YPPhW/Z81AdzBZDgfsLFwxnF2ugGjFb/3S
        CK8Cmns15Oe3AOuAG1bUeovsG8VfmULaq3jxrKtliq2+43uRE+2rJ8bNPHtuw8xoFqx/ZF
        psDC+GOhCZUSxvDoOjtrnC0Ag5aeBQCO44uN5avvbzUX30L0o8rSTQkO68PG3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705235;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWTzib6KkNgcZv7eTt7hwL8IT2P5IL4ct43pcSl5+xY=;
        b=jR6GTFZq2UHVRjt8Ow37CWXu85U0hWH9PBj/D57q7Cmn4z6WGYrm8ig9Vh0Ay9ow93ogYg
        //HkoGX8scGPDuDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] highmem: Get rid of kmap_types.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.422094352@linutronix.de>
References: <20201103095858.422094352@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523441.397.11074334360961161824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     d7029e4549691ecaf1ead536d3322a00bda85659
Gitweb:        https://git.kernel.org/tip/d7029e4549691ecaf1ead536d3322a00bda85659
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:58 +01:00

highmem: Get rid of kmap_types.h

The header is not longer used and on alpha, ia64, openrisc, parisc and um
it was completely unused anyway as these architectures have no highmem
support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20201103095858.422094352@linutronix.de

---
 arch/alpha/include/asm/kmap_types.h  | 15 ---------------
 arch/ia64/include/asm/kmap_types.h   | 13 -------------
 arch/openrisc/mm/init.c              |  1 -
 arch/openrisc/mm/ioremap.c           |  1 -
 arch/parisc/include/asm/kmap_types.h | 13 -------------
 arch/um/include/asm/fixmap.h         |  1 -
 arch/um/include/asm/kmap_types.h     | 13 -------------
 include/asm-generic/Kbuild           |  1 -
 include/asm-generic/kmap_types.h     | 11 -----------
 include/linux/highmem.h              |  2 --
 10 files changed, 71 deletions(-)
 delete mode 100644 arch/alpha/include/asm/kmap_types.h
 delete mode 100644 arch/ia64/include/asm/kmap_types.h
 delete mode 100644 arch/parisc/include/asm/kmap_types.h
 delete mode 100644 arch/um/include/asm/kmap_types.h
 delete mode 100644 include/asm-generic/kmap_types.h

diff --git a/arch/alpha/include/asm/kmap_types.h b/arch/alpha/include/asm/kmap_types.h
deleted file mode 100644
index 651714b..0000000
--- a/arch/alpha/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/ia64/include/asm/kmap_types.h b/arch/ia64/include/asm/kmap_types.h
deleted file mode 100644
index 5c268cf..0000000
--- a/arch/ia64/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_KMAP_TYPES_H
-#define _ASM_IA64_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_IA64_KMAP_TYPES_H */
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 8348fea..bf9b231 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index a978590..5aed97a 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/bug.h>
 #include <linux/sched.h>
diff --git a/arch/parisc/include/asm/kmap_types.h b/arch/parisc/include/asm/kmap_types.h
deleted file mode 100644
index 3e70b5c..0000000
--- a/arch/parisc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
diff --git a/arch/um/include/asm/fixmap.h b/arch/um/include/asm/fixmap.h
index 2c697a1..2efac58 100644
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -3,7 +3,6 @@
 #define __UM_FIXMAP_H
 
 #include <asm/processor.h>
-#include <asm/kmap_types.h>
 #include <asm/archparam.h>
 #include <asm/page.h>
 #include <linux/threads.h>
diff --git a/arch/um/include/asm/kmap_types.h b/arch/um/include/asm/kmap_types.h
deleted file mode 100644
index b0bd12d..0000000
--- a/arch/um/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#ifndef __UM_KMAP_TYPES_H
-#define __UM_KMAP_TYPES_H
-
-/* No more #include "asm/arch/kmap_types.h" ! */
-
-#define KM_TYPE_NR 14
-
-#endif
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index ed62d38..4365b9a 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -30,7 +30,6 @@ mandatory-y += irq.h
 mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
-mandatory-y += kmap_types.h
 mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
diff --git a/include/asm-generic/kmap_types.h b/include/asm-generic/kmap_types.h
deleted file mode 100644
index 9f95b7b..0000000
--- a/include/asm-generic/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_KMAP_TYPES_H
-#define _ASM_GENERIC_KMAP_TYPES_H
-
-#ifdef __WITH_KM_FENCE
-# define KM_TYPE_NR 41
-#else
-# define KM_TYPE_NR 20
-#endif
-
-#endif
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 1222a31..de78869 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -29,8 +29,6 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 }
 #endif
 
-#include <asm/kmap_types.h>
-
 /*
  * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
  */
