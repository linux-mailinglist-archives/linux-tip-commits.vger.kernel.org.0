Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68D292EB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgJSTph (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 15:45:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbgJSTp1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 15:45:27 -0400
Date:   Mon, 19 Oct 2020 19:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOdik0Y+lrIjbp3po9kuZpanyt1dLCgOmvmW4L9QxXc=;
        b=HRmzgZDKyOscl2E5rHcZd619yq7IuPKQJuooi/XoFySXh+ijo5fVVU5KpZ+0PEX6cxmJxT
        ikADryOZk8awOFYF+KvjXFQB/CmWC/L+1L6zEjSY3nXadTa6HUrOph0wuNyZeueyJVdnBA
        qorWZ0HNGYkxXwwBgBvGqgzwypxvFBzhP3m0HM+apeAcdPau3sstNI9JwK5FsOrellI3wE
        5HOjY/KqJKMGZVONdmJYfLBG/dwlUa4UY0MFMpjvPfxsC5MB0SeUChItiHHjqoLI1Ur4Jk
        On2o74RPEXoVcH8TnTWfhw1lf9wBM2DWFZ6RNgG7J+09ZsUg1FW5sFbOA+VxbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603136685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOdik0Y+lrIjbp3po9kuZpanyt1dLCgOmvmW4L9QxXc=;
        b=vpU8s1Fli+VpX6fb7t7cOVgj91hC4Z7BZD/VWWt7vy5/nffs0/ad5eXkuPGkxvJ7OgdbiR
        X/QdEHJRT7EGBQDA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/64: Explicitly map boot_params and command line
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201016200404.1615994-1-nivedita@alum.mit.edu>
References: <20201016200404.1615994-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160313668395.7002.7778590955397923179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     b17a45b6e53f6613118b2e5cfc4a992cc50deb2c
Gitweb:        https://git.kernel.org/tip/b17a45b6e53f6613118b2e5cfc4a992cc50deb2c
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 16 Oct 2020 16:04:01 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 19 Oct 2020 19:39:50 +02:00

x86/boot/64: Explicitly map boot_params and command line

Commits

  ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
  8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in KASLR code")

set up a new page table in the decompressor stub, but without explicit
mappings for boot_params and the kernel command line, relying on the #PF
handler instead.

This is fragile, as boot_params and the command line mappings are
required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
disabled, a QEMU/OVMF boot never accesses the command line in the
decompressor stub, and so it never gets mapped. The main kernel accesses
it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
crash.

Fix this by adding back the explicit mapping of boot_params and the
command line.

Note: the changes also removed the explicit mapping of the main kernel,
with the result that .bss and .brk may not be in the identity mapping,
but those don't get accessed by the main kernel before it switches to
its own page tables.

 [ bp: Pass boot_params with a MOV %rsp... instead of PUSH/POP. Use
   block formatting for the comment. ]

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20201016200404.1615994-1-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/head_64.S      |  3 +++
 arch/x86/boot/compressed/ident_map_64.c | 23 ++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1c80f17..017de6c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -544,6 +544,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	pushq	%rsi
 	call	set_sev_encryption_mask
 	call	load_stage2_idt
+
+	/* Pass boot_params to initialize_identity_maps() */
+	movq	(%rsp), %rdi
 	call	initialize_identity_maps
 	popq	%rsi
 
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index c6f7aef..a5e5db6 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,6 +33,12 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+extern unsigned long get_cmd_line_ptr(void);
+
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
@@ -101,8 +107,10 @@ static void add_identity_map(unsigned long start, unsigned long end)
 }
 
 /* Locates and clears a region for a new top level page table. */
-void initialize_identity_maps(void)
+void initialize_identity_maps(void *rmode)
 {
+	unsigned long cmdline;
+
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
 
@@ -143,10 +151,19 @@ void initialize_identity_maps(void)
 	}
 
 	/*
-	 * New page-table is set up - map the kernel image and load it
-	 * into cr3.
+	 * New page-table is set up - map the kernel image, boot_params and the
+	 * command line. The uncompressed kernel requires boot_params and the
+	 * command line to be mapped in the identity mapping. Map them
+	 * explicitly here in case the compressed kernel does not touch them,
+	 * or does not touch all the pages covering them.
 	 */
 	add_identity_map((unsigned long)_head, (unsigned long)_end);
+	boot_params = rmode;
+	add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	cmdline = get_cmd_line_ptr();
+	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
+
+	/* Load the new page-table. */
 	write_cr3(top_level_pgt);
 }
 
