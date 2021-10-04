Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8176420A3C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJDLna (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 07:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhJDLnV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 07:43:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB67C061787;
        Mon,  4 Oct 2021 04:41:32 -0700 (PDT)
Date:   Mon, 04 Oct 2021 11:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633347691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/2nUQqQP456lA0ThNchQbBNwrAfaQwVGLUvEFyJAJo=;
        b=jC3VL+SnVf8gaBknHyEgxH2IxIuxYHTVZHbicXFAagMvW45di60ZSr2RbGgCpMk/l+ce8I
        TqoPELP84Aql4RXmeOjTnNkq7LsHutKPGd+0zWX8EPU5OTV78MQjXDKqmV88Osg6j2isPK
        MfqEEivWzDULZGwZF1YpOj2SaJTUiCf6ZiUQdfa/JHoGWjy9LHOChLmBfKuH6FhwSxk3vh
        Se1w9+W6m/TrY9bNoqWCozMYDwyPtorn7RMnGebRzcPE/BHhMT4ASmugSA2yk4nCj+UITI
        qHZGIafDr//ubyjeROVAjpN8jAX+dWZPGj9kIYUT7fpZ/m/CLAvEx9TRyitOjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633347691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/2nUQqQP456lA0ThNchQbBNwrAfaQwVGLUvEFyJAJo=;
        b=Mdvk1BiVatEcahjc7syal8tqtgD2MVoarL/wxGX2YMZCufYnfc3EXy5iSRJiKhMV3k+wU6
        3VVqinxdOlSg57DQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/ioremap: Selectively build arch override encryption
 functions
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928191009.32551-2-bp@alien8.de>
References: <20210928191009.32551-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163334769058.25758.12669979789529692829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     402fe0cb71032c4bc931ac70a6b024408e09f817
Gitweb:        https://git.kernel.org/tip/402fe0cb71032c4bc931ac70a6b024408e09f817
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 08 Sep 2021 17:58:32 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:45:49 +02:00

x86/ioremap: Selectively build arch override encryption functions

In preparation for other uses of the cc_platform_has() function
besides AMD's memory encryption support, selectively build the
AMD memory encryption architecture override functions only when
CONFIG_AMD_MEM_ENCRYPT=y. These functions are:

- early_memremap_pgprot_adjust()
- arch_memremap_can_ram_remap()

Additionally, routines that are only invoked by these architecture
override functions can also be conditionally built. These functions are:

- memremap_should_map_decrypted()
- memremap_is_efi_data()
- memremap_is_setup_data()
- early_memremap_is_setup_data()

And finally, phys_mem_access_encrypted() is conditionally built as well,
but requires a static inline version of it when CONFIG_AMD_MEM_ENCRYPT is
not set.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210928191009.32551-2-bp@alien8.de
---
 arch/x86/include/asm/io.h | 8 ++++++++
 arch/x86/mm/ioremap.c     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 841a5d1..5c6a4af 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -391,6 +391,7 @@ extern void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 #define arch_io_reserve_memtype_wc arch_io_reserve_memtype_wc
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 					unsigned long size,
 					unsigned long flags);
@@ -398,6 +399,13 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset,
 
 extern bool phys_mem_access_encrypted(unsigned long phys_addr,
 				      unsigned long size);
+#else
+static inline bool phys_mem_access_encrypted(unsigned long phys_addr,
+					     unsigned long size)
+{
+	return true;
+}
+#endif
 
 /**
  * iosubmit_cmds512 - copy data to single MMIO location, in 512-bit units
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7d..ccff76c 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -508,6 +508,7 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 	memunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * Examine the physical address to determine if it is an area of memory
  * that should be mapped decrypted.  If the memory is not part of the
@@ -746,7 +747,6 @@ bool phys_mem_access_encrypted(unsigned long phys_addr, unsigned long size)
 	return arch_memremap_can_ram_remap(phys_addr, size, 0);
 }
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 /* Remap memory with encryption */
 void __init *early_memremap_encrypted(resource_size_t phys_addr,
 				      unsigned long size)
