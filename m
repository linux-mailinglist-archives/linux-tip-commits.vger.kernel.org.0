Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08229F4C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 20:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJ2TSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJ2TRn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 15:17:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EBC0613D2;
        Thu, 29 Oct 2020 12:17:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:17:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603999062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkqToFXTr1pty8DNnNcAnmlConn1CI6sNFyoQjf30pQ=;
        b=bhbNrdrj5Ka9CHK34RdnB6xG08Erl2zY+YdyL3lwoN5slk/nEa+TCv1tuT+QSOOh81XE7k
        ZpLO8Njg09GzKoferf10fQGNSQ/LStZwLcMEbGSCGxPjVV2KY+uHXwg9rsiOgMvQrLwC53
        bl2dZbBif/AaIl5kr+6nGep0ewEqG+Dm5gIU5+XXUZ2k6qX6RVrm8JHAOlAJ2FSXUHfQVf
        rwZWnv+Jlba/o10v/uiZX9duxtuGy46kUU0DjxvEuW5qMzSa2JrLrQII9698twRSfAGNQK
        LNtAwkFaGgKyJ0I6D/9aqhNJnHeMzn/b3XcUiS0LoNTxkiJhIUiRnygP9dgxLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603999062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkqToFXTr1pty8DNnNcAnmlConn1CI6sNFyoQjf30pQ=;
        b=f21FwK6dlJQUQ8ynO2LFBxGXAZBH9MHXABnjSBijSVNbfB/s8e1ZLNs0+6eRmGa2u0Jpot
        Usq4CQfXeagPCMCQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028164659.27002-4-joro@8bytes.org>
References: <20201028164659.27002-4-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <160399906120.397.18408048076155835864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     86ce43f7dde81562f58b24b426cef068bd9f7595
Gitweb:        https://git.kernel.org/tip/86ce43f7dde81562f58b24b426cef068bd9f7595
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 28 Oct 2020 17:46:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 18:06:52 +01:00

x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path

Check whether the hypervisor reported the correct C-bit when running as
an SEV guest. Using a wrong C-bit position could be used to leak
sensitive data from the guest to the hypervisor.

The check function is in a separate file:

  arch/x86/kernel/sev_verify_cbit.S

so that it can be re-used in the running kernel image.

 [ bp: Massage. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201028164659.27002-4-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c |  1 +-
 arch/x86/boot/compressed/mem_encrypt.S  |  4 +-
 arch/x86/boot/compressed/misc.h         |  2 +-
 arch/x86/kernel/sev_verify_cbit.S       | 89 ++++++++++++++++++++++++-
 4 files changed, 96 insertions(+)
 create mode 100644 arch/x86/kernel/sev_verify_cbit.S

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index a5e5db6..39b2ede 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -164,6 +164,7 @@ void initialize_identity_maps(void *rmode)
 	add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
 	/* Load the new page-table. */
+	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 3092ae1..aa56179 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -68,6 +68,9 @@ SYM_FUNC_START(get_sev_encryption_bit)
 SYM_FUNC_END(get_sev_encryption_bit)
 
 	.code64
+
+#include "../../kernel/sev_verify_cbit.S"
+
 SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
@@ -111,4 +114,5 @@ SYM_FUNC_END(set_sev_encryption_mask)
 	.balign	8
 SYM_DATA(sme_me_mask,		.quad 0)
 SYM_DATA(sev_status,		.quad 0)
+SYM_DATA(sev_check_data,	.quad 0)
 #endif
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b..d9a631c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -159,4 +159,6 @@ void boot_page_fault(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
+unsigned long sev_verify_cbit(unsigned long cr3);
+
 #endif /* BOOT_COMPRESSED_MISC_H */
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
new file mode 100644
index 0000000..ee04941
--- /dev/null
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *	sev_verify_cbit.S - Code for verification of the C-bit position reported
+ *			    by the Hypervisor when running with SEV enabled.
+ *
+ *	Copyright (c) 2020  Joerg Roedel (jroedel@suse.de)
+ *
+ * sev_verify_cbit() is called before switching to a new long-mode page-table
+ * at boot.
+ *
+ * Verify that the C-bit position is correct by writing a random value to
+ * an encrypted memory location while on the current page-table. Then it
+ * switches to the new page-table to verify the memory content is still the
+ * same. After that it switches back to the current page-table and when the
+ * check succeeded it returns. If the check failed the code invalidates the
+ * stack pointer and goes into a hlt loop. The stack-pointer is invalidated to
+ * make sure no interrupt or exception can get the CPU out of the hlt loop.
+ *
+ * New page-table pointer is expected in %rdi (first parameter)
+ *
+ */
+SYM_FUNC_START(sev_verify_cbit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* First check if a C-bit was detected */
+	movq	sme_me_mask(%rip), %rsi
+	testq	%rsi, %rsi
+	jz	3f
+
+	/* sme_me_mask != 0 could mean SME or SEV - Check also for SEV */
+	movq	sev_status(%rip), %rsi
+	testq	%rsi, %rsi
+	jz	3f
+
+	/* Save CR4 in %rsi */
+	movq	%cr4, %rsi
+
+	/* Disable Global Pages */
+	movq	%rsi, %rdx
+	andq	$(~X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4
+
+	/*
+	 * Verified that running under SEV - now get a random value using
+	 * RDRAND. This instruction is mandatory when running as an SEV guest.
+	 *
+	 * Don't bail out of the loop if RDRAND returns errors. It is better to
+	 * prevent forward progress than to work with a non-random value here.
+	 */
+1:	rdrand	%rdx
+	jnc	1b
+
+	/* Store value to memory and keep it in %rdx */
+	movq	%rdx, sev_check_data(%rip)
+
+	/* Backup current %cr3 value to restore it later */
+	movq	%cr3, %rcx
+
+	/* Switch to new %cr3 - This might unmap the stack */
+	movq	%rdi, %cr3
+
+	/*
+	 * Compare value in %rdx with memory location. If C-bit is incorrect
+	 * this would read the encrypted data and make the check fail.
+	 */
+	cmpq	%rdx, sev_check_data(%rip)
+
+	/* Restore old %cr3 */
+	movq	%rcx, %cr3
+
+	/* Restore previous CR4 */
+	movq	%rsi, %cr4
+
+	/* Check CMPQ result */
+	je	3f
+
+	/*
+	 * The check failed, prevent any forward progress to prevent ROP
+	 * attacks, invalidate the stack and go into a hlt loop.
+	 */
+	xorq	%rsp, %rsp
+	subq	$0x1000, %rsp
+2:	hlt
+	jmp 2b
+3:
+#endif
+	/* Return page-table pointer */
+	movq	%rdi, %rax
+	ret
+SYM_FUNC_END(sev_verify_cbit)
