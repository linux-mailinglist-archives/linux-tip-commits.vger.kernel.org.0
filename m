Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D2451611
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Nov 2021 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhKOVLi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 16:11:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349373AbhKOUMI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:12:08 -0500
Date:   Mon, 15 Nov 2021 20:09:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637006949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7C3j6qNV9EvpK1L15B+3dts8d/yyelFHxK1xl+UHaU=;
        b=GII00Hrr0wXIn2OkkBwsVJcoAkWgsbQc24UiIYt9UV+gEhCmN3ExrGFYrywgbTT0eT2HnX
        ZDWOzIRO7MW2gH7Z5ck6Op71/YnsbMX9QK9zdQnd0jmJwRo2RmDHLluzoEGhK4tGhckvqE
        YJtP827wjYK+/I9KoYVi74KBnYyfeLDFJHiBSkOzBzwIvr2YZULJtp6HLpfV5pO9sE7zEy
        3MbXNaTQeI80Ub88YuyJ5kTOAELk3VyZlbYDFqNI1/+2vRBhB/IpTj0OTSttZzwj9xxSIp
        2GkQsamLP1zqQUTiXEy6wWUtejRwd0xtv9mpJjvgIhYT0ZvPDWZV6IoK+echlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637006949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7C3j6qNV9EvpK1L15B+3dts8d/yyelFHxK1xl+UHaU=;
        b=W34EfPflln7RLZNkaKxnGx01+hiczVY+Nf1E/YmEsciUUi71RG6Rcg7JHyFCmEh8EuZFOG
        SKtL1DmSwpeAFeDw==
From:   "tip-bot2 for Lucas De Marchi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Nuke PAGE_KERNEL_IO
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021181511.1533377-3-lucas.demarchi@intel.com>
References: <20211021181511.1533377-3-lucas.demarchi@intel.com>
MIME-Version: 1.0
Message-ID: <163700694839.414.7021126134852690042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     27dff0f58bdef4bcafdad8a8c2217d561bcf9506
Gitweb:        https://git.kernel.org/tip/27dff0f58bdef4bcafdad8a8c2217d561bcf9506
Author:        Lucas De Marchi <lucas.demarchi@intel.com>
AuthorDate:    Thu, 21 Oct 2021 11:15:11 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 10:57:55 -08:00

x86/mm: Nuke PAGE_KERNEL_IO

PAGE_KERNEL_IO is only defined for x86 and nowadays is the same as
PAGE_KERNEL. It was different for some time, OR'ing a `_PAGE_IOMAP` flag
in commit be43d72835ba ("x86: add _PAGE_IOMAP pte flag for IO
mappings").  This got removed in commit f955371ca9d3 ("x86: remove the
Xen-specific _PAGE_IOMAP PTE flag"), so today they are just the same.

With the last users outside arch/x86 being remove we can now remove
PAGE_KERNEL_IO.

[ dhansen: dropped arch/x86/xen/setup.c hunk.  This
	   9a58b352e9e8 ("xen/x86: restrict PV Dom0 identity mapping")
	   already axed its use of PAGE_KERNEL_IO ]

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20211021181511.1533377-3-lucas.demarchi@intel.com
---
 arch/x86/include/asm/fixmap.h        | 2 +-
 arch/x86/include/asm/pgtable_types.h | 7 -------
 arch/x86/mm/ioremap.c                | 2 +-
 include/asm-generic/fixmap.h         | 2 +-
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb..5e186a6 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
  * supported for MMIO addresses, so make sure that the memory encryption
  * mask is not part of the page attributes.
  */
-#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_IO_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
 
 /*
  * Early memremap routines used for in-place encryption. The mappings created
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9..a872247 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -199,10 +199,6 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
 
 
-#define __PAGE_KERNEL_IO		__PAGE_KERNEL
-#define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
-
-
 #ifndef __ASSEMBLY__
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
@@ -223,9 +219,6 @@ enum page_cache_mode {
 #define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
 #define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
 
-#define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
-#define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
-
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b..3102dda 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
 	 */
-	prot = PAGE_KERNEL_IO;
+	prot = PAGE_KERNEL;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09..f1b0c6f 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -54,7 +54,7 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
 #endif
 #ifndef FIXMAP_PAGE_IO
-#define FIXMAP_PAGE_IO PAGE_KERNEL_IO
+#define FIXMAP_PAGE_IO PAGE_KERNEL
 #endif
 #ifndef FIXMAP_PAGE_CLEAR
 #define FIXMAP_PAGE_CLEAR __pgprot(0)
