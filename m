Return-Path: <linux-tip-commits+bounces-5576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B150AB9DDD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D5507BC0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885E13A258;
	Fri, 16 May 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVfZZcgE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qac2d66Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3A72616;
	Fri, 16 May 2025 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403094; cv=none; b=T0ImQnyNV8sv3W9P9s6sRymECWOn8JabAFcb+WtNJKto1GQNPZzTdoAAFaDzOONednemhzmzmPX2/1Z31Jf15Gj/LOn92p4K7+rv2ndlVhDZ7M4qmDAU+xAJJL30Y6hUaW4mrJgXWLk1AWdERWwvjBxnBa9lSNC0BG9F6dfe9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403094; c=relaxed/simple;
	bh=l/aWwa24fbocLGQ6osUHCJNEALsRmcbjCvgnovqYnWA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sfyeBaUwJVjWOtDeVoJlRz9GpXslOjuHJz738wW66Q3AeLSQABwJIzWXeoR7b5ytjp+S4AaMMWI05Z2u4g0PzjHB4KSfN+fMBKyimHmgXQB4rVynOiau5O746GeS83SW1xvHOp19HQ25HZi3XshDAwotGZhVTtU1Ymbo2LJS70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVfZZcgE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qac2d66Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 13:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747403090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dISG+IfOLu8dj9DnKW3h/g2REo0SUu/yDHlIuAjk3zU=;
	b=EVfZZcgEDiFNvne/RfbVsxig3ZOeGXKGfGOAL53bsjYUsEWdwKeFHP4eIQsFL5etRXR3T0
	a7nF2i8aJW4+7jDlMGiucnNN7lr5RPiAtYN00FpuMIdhKia4E0Q3pHW7+oagU3T/mJFmME
	pZOtqd1ll8bP9FkUgocx0NCDPred1l4vROIxWHnrOcmPucQizOe+jcWFjHbU8R7/nhckWP
	x7NcA8motwFCxddZbWDpYM1RyKTORRxFhZXinvkd2SV0/Ib7YPHPObXxDnyuCuGRDPo2lp
	3Oc6rRtqex94TUVnSfcZ1VaNO/ekrrdWh9kv0UphfOZUAi+94YS+WVc7+/HKCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747403090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dISG+IfOLu8dj9DnKW3h/g2REo0SUu/yDHlIuAjk3zU=;
	b=qac2d66Z9TA4ySCMIlmnSSBhDFh4BMN+lHtWM8Q6WPlTq53p3jZn9sno9NfTgMrxmtOJV/
	aLOLeyHyYkWhK/DQ==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/mm/64: Make SPARSEMEM_VMEMMAP the only memory model
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174740308948.406.5049032669096006008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0ebb63735cd6692c0c65307e9b0d683364dfff67
Gitweb:        https://git.kernel.org/tip/0ebb63735cd6692c0c65307e9b0d683364dfff67
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 15:33:04 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 15:13:03 +02:00

x86/mm/64: Make SPARSEMEM_VMEMMAP the only memory model

5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
being phased out, making 5-level paging support mandatory.

Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
any associated conditional statements.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250516123306.3812286-3-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig      |  2 +-
 arch/x86/mm/init_64.c |  9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 22c60be..27f5d87 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1467,7 +1467,6 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	default y
-	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
@@ -1579,6 +1578,7 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
+	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index bf45c7a..66330fe 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -833,7 +833,6 @@ void __init paging_init(void)
 	zone_sizes_init();
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 #define PAGE_UNUSED 0xFD
 
 /*
@@ -932,7 +931,6 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	if (!IS_ALIGNED(end, PMD_SIZE))
 		unused_pmd_start = end;
 }
-#endif
 
 /*
  * Memory hotplug specific functions
@@ -1152,16 +1150,13 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
-			}
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-			else if (vmemmap_pmd_is_unused(addr, next)) {
+			} else if (vmemmap_pmd_is_unused(addr, next)) {
 					free_hugepage_table(pmd_page(*pmd),
 							    altmap);
 					spin_lock(&init_mm.page_table_lock);
 					pmd_clear(pmd);
 					spin_unlock(&init_mm.page_table_lock);
 			}
-#endif
 			continue;
 		}
 
@@ -1500,7 +1495,6 @@ unsigned long memory_block_size_bytes(void)
 	return memory_block_size_probed;
 }
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
  */
@@ -1647,4 +1641,3 @@ void __meminit vmemmap_populate_print_last(void)
 		node_start = 0;
 	}
 }
-#endif

