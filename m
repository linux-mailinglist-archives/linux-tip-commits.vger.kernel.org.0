Return-Path: <linux-tip-commits+bounces-5664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158F9ABAA1F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 15:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F54A2D28
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA9200BB8;
	Sat, 17 May 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YZd8fF8Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9Bx4AKZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B971E6DC5;
	Sat, 17 May 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486842; cv=none; b=prHjFz7EI7aw00PlvgJLk6/NP+r/WIfUjn0n9b5ZiLuKxOfmakoXbdLEWBz6UuD8uidLCCGLwKYdNbqZSl8fbHJ9k2I6CLDrKAWtTOvNdTltz6gqk/jRlv4vk4yh3SZlHsadgemyA8KNjCHZkurgq7T8rsfwC+qePTIniEYYVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486842; c=relaxed/simple;
	bh=DScK2WjVK4VqVUJ5qnpyaMErf/H3lQrj0XjnQ9g2W0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W0DLDAZfqU9s682RHyZKizTAcZ1pdLZ3mSnR9S7BbWbZGrlkFoCgCBnHSrkk84RCfS+xLAeUcs5SVOLvbFrO1JosFrOekGecgRPbq/SUBqqrlzNp3vnkPR0CPFFJygs9I/GJ+usNWdcFqbAlup2bw/CebVTyaHw/sMEoyabFWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YZd8fF8Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9Bx4AKZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 13:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ14EVZbqljMAiOXDcwgZkw1pGg2Uscp2uKKIMNteI0=;
	b=YZd8fF8YU4gT5FgFXlZaR25tKoFm6f5XOQauXMX3ulkYh55HAX4jr6hshpEUgYZ+zF9AhZ
	8HSQLoEHIcAPDGY06koo1WGlNnUZZQ1QT/oxgkO9TLK7pY9zxQOtlXSBbCIrwbS+RXCvD4
	K/Qfr22e9baSdA8KwWQJtVc3rCItPu7CGnPD1w2+Vn10z+Hxqh++K99hPGPcodWgklJ8Xm
	I4RHiQYPawyu8RHIp252nFqgHkISnrfdqN8eIrwnBZAZNiETlTp9vMYSTamQP3qVNvq5Pd
	vE1s2uC+wE2g2Um2plLA7Gd5kBpcrdZblCiDYBPbo5eW8jabXnMhI2x116Wfpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ14EVZbqljMAiOXDcwgZkw1pGg2Uscp2uKKIMNteI0=;
	b=z9Bx4AKZvhi4UFe/wKgMUpTUHRZ1DRhGrhbYoXZyQUmuNLKua6J5VZyhsNyCP+lLSvn3l9
	0GXQNm0LtlucOuCA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/merge] x86/mm/64: Make SPARSEMEM_VMEMMAP the only memory model
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
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
Message-ID: <174748683804.406.11521945321481191771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     cba5d9b3e99d6268d7909a65c2bd78f4d195aead
Gitweb:        https://git.kernel.org/tip/cba5d9b3e99d6268d7909a65c2bd78f4d195aead
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 15:33:04 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:34:11 +02:00

x86/mm/64: Make SPARSEMEM_VMEMMAP the only memory model

5-level paging only supports SPARSEMEM_VMEMMAP. CONFIG_X86_5LEVEL is
being phased out, making 5-level paging support mandatory.

Make CONFIG_SPARSEMEM_VMEMMAP mandatory for x86-64 and eliminate
any associated conditional statements.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
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

