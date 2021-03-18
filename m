Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D26340E4D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCRTeq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCRTef (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:35 -0400
Date:   Thu, 18 Mar 2021 19:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpVjiATltRvVPhRpOuJ+mLUICuUlsPZZUeCmWK8CXrk=;
        b=05/mGiX5XnEVhiWRe/4CbToJHJuvofreayfuFy2En42EaAOMQHtWVCjE3AoOMFCaUhf3o0
        TbAM0SyhqLxqobplIUsE5/gQQBgXuTskwSfUCJCh3Ty1BqNa7RnABYzNWntGe6bYSYLrpJ
        qTOjkwwkQWADNP8BcPfdOzWYZ7PqhGOoGMvtt0tGnTbm+/nvOzU4FBKQYZ5cv211QEhREh
        6tmK801aKBJ3wSwPp8iVB1CMPHCz2Vg9FGIGQb0BvvU2gm5doIwrYR3erKLbLIus/KDiH/
        qqK4MAJvAx6g0ASj87r8g7M89LeS0dnsK/JakzYEmddYmcGIZpPn5HTU+AMoyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpVjiATltRvVPhRpOuJ+mLUICuUlsPZZUeCmWK8CXrk=;
        b=7QsBlahhGeEWfV+Sura0U2JqEh2iB6z2H3einyPlZZFHLAK8cV1GNmMzFUG1ACXax2kDXn
        7V6UTpoYpSi42jBg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Check SEV encryption in the
 32-bit boot-path
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-8-joro@8bytes.org>
References: <20210312123824.306-8-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607349.398.15617322156439823956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     769eb023aa77062cf15c2a179fc8d13b43422c9b
Gitweb:        https://git.kernel.org/tip/769eb023aa77062cf15c2a179fc8d13b43422c9b
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:54 +01:00

x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path

Check whether the hypervisor reported the correct C-bit when running
as an SEV guest. Using a wrong C-bit position could be used to leak
sensitive data from the guest to the hypervisor.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-8-joro@8bytes.org
---
 arch/x86/boot/compressed/head_64.S | 83 +++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index ee448ae..91ea0d5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -183,11 +183,21 @@ SYM_FUNC_START(startup_32)
 	 */
 	call	get_sev_encryption_bit
 	xorl	%edx, %edx
+#ifdef	CONFIG_AMD_MEM_ENCRYPT
 	testl	%eax, %eax
 	jz	1f
 	subl	$32, %eax	/* Encryption bit is always above bit 31 */
 	bts	%eax, %edx	/* Set encryption mask for page tables */
+	/*
+	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
+	 * will do a check. The sev_status memory will be fully initialized
+	 * with the contents of MSR_AMD_SEV_STATUS later in
+	 * set_sev_encryption_mask(). For now it is sufficient to know that SEV
+	 * is active.
+	 */
+	movl	$1, rva(sev_status)(%ebp)
 1:
+#endif
 
 	/* Initialize Page tables to 0 */
 	leal	rva(pgtable)(%ebx), %edi
@@ -272,6 +282,9 @@ SYM_FUNC_START(startup_32)
 	movl	%esi, %edx
 1:
 #endif
+	/* Check if the C-bit position is correct when SEV is active */
+	call	startup32_check_sev_cbit
+
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
@@ -872,6 +885,76 @@ SYM_FUNC_START(startup32_load_idt)
 SYM_FUNC_END(startup32_load_idt)
 
 /*
+ * Check for the correct C-bit position when the startup_32 boot-path is used.
+ *
+ * The check makes use of the fact that all memory is encrypted when paging is
+ * disabled. The function creates 64 bits of random data using the RDRAND
+ * instruction. RDRAND is mandatory for SEV guests, so always available. If the
+ * hypervisor violates that the kernel will crash right here.
+ *
+ * The 64 bits of random data are stored to a memory location and at the same
+ * time kept in the %eax and %ebx registers. Since encryption is always active
+ * when paging is off the random data will be stored encrypted in main memory.
+ *
+ * Then paging is enabled. When the C-bit position is correct all memory is
+ * still mapped encrypted and comparing the register values with memory will
+ * succeed. An incorrect C-bit position will map all memory unencrypted, so that
+ * the compare will use the encrypted random data and fail.
+ */
+SYM_FUNC_START(startup32_check_sev_cbit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	pushl	%eax
+	pushl	%ebx
+	pushl	%ecx
+	pushl	%edx
+
+	/* Check for non-zero sev_status */
+	movl	rva(sev_status)(%ebp), %eax
+	testl	%eax, %eax
+	jz	4f
+
+	/*
+	 * Get two 32-bit random values - Don't bail out if RDRAND fails
+	 * because it is better to prevent forward progress if no random value
+	 * can be gathered.
+	 */
+1:	rdrand	%eax
+	jnc	1b
+2:	rdrand	%ebx
+	jnc	2b
+
+	/* Store to memory and keep it in the registers */
+	movl	%eax, rva(sev_check_data)(%ebp)
+	movl	%ebx, rva(sev_check_data+4)(%ebp)
+
+	/* Enable paging to see if encryption is active */
+	movl	%cr0, %edx			 /* Backup %cr0 in %edx */
+	movl	$(X86_CR0_PG | X86_CR0_PE), %ecx /* Enable Paging and Protected mode */
+	movl	%ecx, %cr0
+
+	cmpl	%eax, rva(sev_check_data)(%ebp)
+	jne	3f
+	cmpl	%ebx, rva(sev_check_data+4)(%ebp)
+	jne	3f
+
+	movl	%edx, %cr0	/* Restore previous %cr0 */
+
+	jmp	4f
+
+3:	/* Check failed - hlt the machine */
+	hlt
+	jmp	3b
+
+4:
+	popl	%edx
+	popl	%ecx
+	popl	%ebx
+	popl	%eax
+#endif
+	ret
+SYM_FUNC_END(startup32_check_sev_cbit)
+
+/*
  * Stack and heap for uncompression
  */
 	.bss
