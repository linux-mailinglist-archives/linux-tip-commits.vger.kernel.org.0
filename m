Return-Path: <linux-tip-commits+bounces-5665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFFABAA22
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209C54A39CC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC61B665;
	Sat, 17 May 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJx5ihLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7Vx/dmX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF41FF7C5;
	Sat, 17 May 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486843; cv=none; b=IeXQxSHVI0sSuqyNTIFriurDAPyIbHBu+9ZJd1u/lK7Znc4jR1z0yYv7BI7RI4+WKpF2WW59keAvVKRcDfZRxZ3YgQKiDQnIoLFMTKDhfWdy7TVeGm0/e9ZJOA2LsZeTCHdEy524TUTHYGTSx2ag6nWLnymrQB6Pf66sHmQhaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486843; c=relaxed/simple;
	bh=LouUTWm5iwPkoDRxot+nYdCu7oeDeuLwOon4ufL0Hv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wlm2K8e5vdO2l05v0jEBWP/xOUO56w77pGi8EFeIV/WCJqlUfj2oRsQ/rBcVEYSB8fXpHJXLvRMLMerEgtbwfVpfedkxZspS6Ejc/NnuW8HoMNwJsXtWDwPd+cgsTZBzTWMK+9fdApUkCQRWNBIXMfD6fFr4+4IT3h3omiqgbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJx5ihLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7Vx/dmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 13:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRxy/Acx67ryLaPkZV7ckCW3YwiA6/vxwUyAMhQSak=;
	b=WJx5ihLE7oRCJJ1aIMcXImgiKyp4P+6zDT2Nlv6evOF7/C4XsTUANGIB6fpnChT/bocL1b
	P5iwrSt0PyXbvICZCQY7kWHeCXEO4O7LVUrC/ZaSTaoSUFTBUWrP/vVTb/3wpz7yzk6mFO
	sLwXvM9BMgOKrNwxc/xY01pDEyiV/lvtA8Q6H54/f/x03P3HqUQo35DnlPldydEhKfgEmb
	aS4mgNnWEBcB/MOFWrY636gdrtB2cswaFjf6ULDvps/Jju5VnjpuaPz/z8qicyulrY22Tx
	txCLf0qpPMIPNt5AcEPmNTwc1iXdN14BkCvczhj0i+bXZUJ7ufUSOXRWt09ArA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWRxy/Acx67ryLaPkZV7ckCW3YwiA6/vxwUyAMhQSak=;
	b=Q7Vx/dmXfGfo0ikpl/eP9iE7tp2j5IJmECZqiCzq+nRbMBdVGvbjrrAUX/L369+Cm/VMBX
	CmtUleTVulvv0uAw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/mm/64: Always use dynamic memory layout
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250516123306.3812286-2-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174748683917.406.13770918924773841870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     1bffe6f6890cb40a8d26aec1ffe5f95e2bd09ac2
Gitweb:        https://git.kernel.org/tip/1bffe6f6890cb40a8d26aec1ffe5f95e2bd09ac2
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 15:33:03 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:33:44 +02:00

x86/mm/64: Always use dynamic memory layout

Dynamic memory layout is used by KASLR and 5-level paging.

CONFIG_X86_5LEVEL is going to be removed, making 5-level paging support
unconditional which requires unconditional support of dynamic memory
layout.

Remove CONFIG_DYNAMIC_MEMORY_LAYOUT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250516123306.3812286-2-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig                        | 8 --------
 arch/x86/include/asm/page_64_types.h    | 4 ----
 arch/x86/include/asm/pgtable_64_types.h | 6 ------
 arch/x86/kernel/head64.c                | 2 --
 scripts/gdb/linux/pgtable.py            | 4 +---
 5 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 90570e3..22c60be 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1467,7 +1467,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select DYNAMIC_MEMORY_LAYOUT
 	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
@@ -2168,17 +2167,10 @@ config PHYSICAL_ALIGN
 
 	  Don't change this unless you know what you are doing.
 
-config DYNAMIC_MEMORY_LAYOUT
-	bool
-	help
-	  This option makes base addresses of vmalloc and vmemmap as well as
-	  __PAGE_OFFSET movable during boot.
-
 config RANDOMIZE_MEMORY
 	bool "Randomize the kernel memory sections"
 	depends on X86_64
 	depends on RANDOMIZE_BASE
-	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	help
 	  Randomizes the base virtual address of kernel memory sections
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 1faa8f8..6b8c816 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -41,11 +41,7 @@
 #define __PAGE_OFFSET_BASE_L5	_AC(0xff11000000000000, UL)
 #define __PAGE_OFFSET_BASE_L4	_AC(0xffff888000000000, UL)
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
-#else
-#define __PAGE_OFFSET           __PAGE_OFFSET_BASE_L4
-#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index e83721d..eee06f7 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -128,15 +128,9 @@ extern unsigned int ptrs_per_p4d;
 #define __VMEMMAP_BASE_L4	0xffffea0000000000UL
 #define __VMEMMAP_BASE_L5	0xffd4000000000000UL
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
 # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
-#else
-# define VMALLOC_START		__VMALLOC_BASE_L4
-# define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
-# define VMEMMAP_START		__VMEMMAP_BASE_L4
-#endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 # define DIRECT_MAP_PHYSMEM_END	direct_map_physmem_end
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 14f7dda..9f617be 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -59,14 +59,12 @@ unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
 #endif
 
-#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
 unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
-#endif
 
 /* Wipe all early page tables except for the kernel symbol map */
 static void __init reset_early_page_tables(void)
diff --git a/scripts/gdb/linux/pgtable.py b/scripts/gdb/linux/pgtable.py
index 30d837f..09aac24 100644
--- a/scripts/gdb/linux/pgtable.py
+++ b/scripts/gdb/linux/pgtable.py
@@ -29,11 +29,9 @@ def page_mask(level=1):
         raise Exception(f'Unknown page level: {level}')
 
 
-#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
-POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
 def _page_offset_base():
     pob_symbol = gdb.lookup_global_symbol('page_offset_base')
-    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
+    pob = pob_symbol.name
     return gdb.parse_and_eval(pob)
 
 

