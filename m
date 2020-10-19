Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE2292EB3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 21:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgJSTp3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbgJSTp0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 15:45:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830DC0613CE;
        Mon, 19 Oct 2020 12:44:47 -0700 (PDT)
Date:   Mon, 19 Oct 2020 19:44:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTuNdage0WBYVvdQKrTjSQ+VVq/d9cKEAOBNhVywkew=;
        b=EocJ2sSttykz9hS/dn7AjIhyrG6/p2B3E9FvLg2AKhkCy93QuHRKrc4mxZxSL+55r1rRpu
        b268yJvw5q1ky5QuvEdBPth7ErBZ9/aM1p0fwuH1zSCahIRTxUEnAxG7djONSSNGZ1pj81
        LObITPtvAhJAm8r/OqiNbgcwR5burKKo/kq22soqcSe2osgC/1ow8LGXlDx1rMb67uLdJ4
        GM2yC44ooDxUXzSekQZZpAr5+X19PVOi6d+/ok+HJLuoBcSBt9BrNd8VwBqJx+KkYvJizy
        dQmCtMJNV1LtAOfft1/F25m+tanMbsCCX7Axisvp8sXgsEdK065GVyo9MfOi4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTuNdage0WBYVvdQKrTjSQ+VVq/d9cKEAOBNhVywkew=;
        b=HV22sEM33dDQWM1YY1+fFs1mHwBM5jRR2PnDERYayduyAwaRzD/N+nUo+ODBFvxUvY87K4
        DEpetjG+NjdowKCg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/64: Initialize 5-level paging variables earlier
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201010191110.4060905-1-nivedita@alum.mit.edu>
References: <20201010191110.4060905-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160313668501.7002.10607211582490063283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     e5ceb9a02402b984feecb95a82239be151c9f4e2
Gitweb:        https://git.kernel.org/tip/e5ceb9a02402b984feecb95a82239be151c9f4e2
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Sat, 10 Oct 2020 15:11:10 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 19 Oct 2020 12:47:21 +02:00

x86/boot/64: Initialize 5-level paging variables earlier

Commit

  ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")

started using a new set of pagetables even without KASLR.

After that commit, initialize_identity_maps() is called before the
5-level paging variables are setup in choose_random_location(), which
will not work if 5-level paging is actually enabled.

Fix this by moving the initialization of __pgtable_l5_enabled,
pgdir_shift and ptrs_per_p4d into cleanup_trampoline(), which is called
immediately after the finalization of whether the kernel is executing
with 4- or 5-level paging. This will be earlier than anything that might
require those variables, and keeps the 4- vs 5-level paging code all in
one place.

Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lkml.kernel.org/r/20201010191110.4060905-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/ident_map_64.c |  6 ------
 arch/x86/boot/compressed/kaslr.c        |  8 --------
 arch/x86/boot/compressed/pgtable_64.c   | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 063a60e..c6f7aef 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,12 +33,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled;
-unsigned int pgdir_shift = 39;
-unsigned int ptrs_per_p4d = 1;
-#endif
-
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b59547c..b92fffb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -840,14 +840,6 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-#ifdef CONFIG_X86_5LEVEL
-	if (__read_cr4() & X86_CR4_LA57) {
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
-	}
-#endif
-
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 7d0394f..5def167 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -8,6 +8,13 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
+#ifdef CONFIG_X86_5LEVEL
+/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
+unsigned int __section(.data) __pgtable_l5_enabled;
+unsigned int __section(.data) pgdir_shift = 39;
+unsigned int __section(.data) ptrs_per_p4d = 1;
+#endif
+
 struct paging_config {
 	unsigned long trampoline_start;
 	unsigned long l5_required;
@@ -198,4 +205,13 @@ void cleanup_trampoline(void *pgtable)
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
+
+	/* Initialize variables for 5-level paging */
+#ifdef CONFIG_X86_5LEVEL
+	if (__read_cr4() & X86_CR4_LA57) {
+		__pgtable_l5_enabled = 1;
+		pgdir_shift = 48;
+		ptrs_per_p4d = 512;
+	}
+#endif
 }
