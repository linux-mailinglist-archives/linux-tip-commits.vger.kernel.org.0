Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94029F690
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 22:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJ2VCP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2VCP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 17:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA76C0613CF;
        Thu, 29 Oct 2020 14:02:14 -0700 (PDT)
Date:   Thu, 29 Oct 2020 21:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604005333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tL8bniZ04qgr2+EFSyLjgTh3uZrTgGBOuVW8tbZgez8=;
        b=iKUghlnwQrxUrRfn5QsK9EyduGtrpojr+TJguC4L/6WRqG3VtgK+lNAoatuI85F4i7rpOQ
        0RpGNU9LzUF49bkA87ecMEtrw6K1L9oP/y/2pG157KBYwxM8x+24vdJVN5AAokzuBzsgm7
        ejqt7YtzC53mTieeIdkPmbUyAHXTZOF4hV2w9mg4YCoseJGImF0pqWRq+2uqLHCTn5ggOz
        JyOWt+yzxvUuvo/ryx6dizpNGfRdJuY7v3cKJFfO95d9R9Z5ijoukfoq41NoEdGOHkrn8f
        ab5eCpQchMYLYlGG7QWHo/Gpr/axbSnfoXdM6fuWUkjLOcDSpEoaY28t9kE8jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604005333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tL8bniZ04qgr2+EFSyLjgTh3uZrTgGBOuVW8tbZgez8=;
        b=TrP3VwjbRN15dQL/3n2irnVfPkE/PRJol0emRjRxF7TXaapn8QVS8dZRRN5sLMMgFny4go
        QoIlnhswptopUTBA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Fix vmlinux size check on 64-bit
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201029161903.2553528-1-nivedita@alum.mit.edu>
References: <20201029161903.2553528-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160400533170.397.11715757902925239172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     ea3186b9572a1b0299448697cfc44920061872cf
Gitweb:        https://git.kernel.org/tip/ea3186b9572a1b0299448697cfc44920061872cf
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 29 Oct 2020 12:19:03 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 21:54:35 +01:00

x86/build: Fix vmlinux size check on 64-bit

Commit

  b4e0409a36f4 ("x86: check vmlinux limits, 64-bit")

added a check that the size of the 64-bit kernel is less than
KERNEL_IMAGE_SIZE.

The check uses (_end - _text), but this is not enough. The initial
PMD used in startup_64() (level2_kernel_pgt) can only map upto
KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text, and the
modules area (MODULES_VADDR) starts at KERNEL_IMAGE_SIZE.

The correct check is what is currently done for 32-bit, since
LOAD_OFFSET is defined appropriately for the two architectures. Just
check (_end - LOAD_OFFSET) against KERNEL_IMAGE_SIZE unconditionally.

Note that on 32-bit, the limit is not strict: KERNEL_IMAGE_SIZE is not
really used by the main kernel. The higher the kernel is located, the
less the space available for the vmalloc area. However, it is used by
KASLR in the compressed stub to limit the maximum address of the kernel
to a safe value.

Clean up various comments to clarify that despite the name,
KERNEL_IMAGE_SIZE is not a limit on the size of the kernel image, but a
limit on the maximum virtual address that the image can occupy.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201029161903.2553528-1-nivedita@alum.mit.edu
---
 arch/x86/include/asm/page_32_types.h |  8 +++++++-
 arch/x86/include/asm/page_64_types.h |  6 ++++--
 arch/x86/include/asm/pgtable_32.h    | 18 ++++++------------
 arch/x86/kernel/head_64.S            | 20 +++++++++-----------
 arch/x86/kernel/vmlinux.lds.S        | 12 +++---------
 5 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index f462895..faf9cc1 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -53,7 +53,13 @@
 #define STACK_TOP_MAX		STACK_TOP
 
 /*
- * Kernel image size is limited to 512 MB (see in arch/x86/kernel/head_32.S)
+ * In spite of the name, KERNEL_IMAGE_SIZE is a limit on the maximum virtual
+ * address for the kernel image, rather than the limit on the size itself. On
+ * 32-bit, this is not a strict limit, but this value is used to limit the
+ * link-time virtual address range of the kernel, and by KASLR to limit the
+ * randomized address from which the kernel is executed. A relocatable kernel
+ * can be loaded somewhat higher than KERNEL_IMAGE_SIZE as long as enough space
+ * remains for the vmalloc area.
  */
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 3f49dac..645bd1d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -98,8 +98,10 @@
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
 /*
- * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
- * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
+ * In spite of the name, KERNEL_IMAGE_SIZE is a limit on the maximum virtual
+ * address for the kernel image, rather than the limit on the size itself.
+ * This can be at most 1 GiB, due to the fixmap living in the next 1 GiB (see
+ * level2_kernel_pgt in arch/x86/kernel/head_64.S).
  *
  * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
  * page tables are fully set up.
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index d7acae4..7c9c968 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -57,19 +57,13 @@ do {						\
 #endif
 
 /*
- * This is how much memory in addition to the memory covered up to
- * and including _end we need mapped initially.
- * We need:
- *     (KERNEL_IMAGE_SIZE/4096) / 1024 pages (worst case, non PAE)
- *     (KERNEL_IMAGE_SIZE/4096) / 512 + 4 pages (worst case for PAE)
+ * This is used to calculate the .brk reservation for initial pagetables.
+ * Enough space is reserved to allocate pagetables sufficient to cover all
+ * of LOWMEM_PAGES, which is an upper bound on the size of the direct map of
+ * lowmem.
  *
- * Modulo rounding, each megabyte assigned here requires a kilobyte of
- * memory, which is currently unreclaimed.
- *
- * This should be a multiple of a page.
- *
- * KERNEL_IMAGE_SIZE should be greater than pa(_end)
- * and small than max_low_pfn, otherwise will waste some page table entries
+ * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
+ * the PMD's in addition to the pages required for the last level pagetables.
  */
 #if PTRS_PER_PMD > 1
 #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c..d41fa5b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -524,21 +524,19 @@ SYM_DATA_END(level3_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_kernel_pgt)
 	/*
-	 * 512 MB kernel mapping. We spend a full page on this pagetable
-	 * anyway.
+	 * Kernel high mapping.
 	 *
-	 * The kernel code+data+bss must not be bigger than that.
+	 * The kernel code+data+bss must be located below KERNEL_IMAGE_SIZE in
+	 * virtual address space, which is 1 GiB if RANDOMIZE_BASE is enabled,
+	 * 512 MiB otherwise.
 	 *
-	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
-	 *  If you want to increase this then increase MODULES_VADDR
-	 *  too.)
+	 * (NOTE: after that starts the module area, see MODULES_VADDR.)
 	 *
-	 *  This table is eventually used by the kernel during normal
-	 *  runtime.  Care must be taken to clear out undesired bits
-	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
+	 * This table is eventually used by the kernel during normal runtime.
+	 * Care must be taken to clear out undesired bits later, like _PAGE_RW
+	 * or _PAGE_GLOBAL in some cases.
 	 */
-	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
-		KERNEL_IMAGE_SIZE/PMD_SIZE)
+	PMDS(0, __PAGE_KERNEL_LARGE_EXEC, KERNEL_IMAGE_SIZE/PMD_SIZE)
 SYM_DATA_END(level2_kernel_pgt)
 
 SYM_DATA_START_PAGE_ALIGNED(level2_fixmap_pgt)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bf9e0ad..efd9e9e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -454,13 +454,13 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
-#ifdef CONFIG_X86_32
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-#else
+
+#ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
@@ -470,18 +470,12 @@ INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-/*
- * Build-time check on the image size:
- */
-. = ASSERT((_end - _text <= KERNEL_IMAGE_SIZE),
-	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-
 #ifdef CONFIG_SMP
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#endif /* CONFIG_X86_32 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
