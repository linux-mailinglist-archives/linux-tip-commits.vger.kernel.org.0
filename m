Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BF2BBE3A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Nov 2020 10:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKUJiN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Nov 2020 04:38:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKUJiM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Nov 2020 04:38:12 -0500
Date:   Sat, 21 Nov 2020 09:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605951489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMSdUI6XS0tsUduJbOS41qb9ms4EeL+JhqDmIUyDRq0=;
        b=VIqwWEQrY/+Oeof1rC9jSqo+eq4wUsXZox0CGPwj2SFlzo5AbPeqWtGDmOKys+Moy5TPj8
        W/Oq5BJ/Qj2+wCRuRh9RCCwwCMcJk1yh1nX+APLMNSkFl8PqUYeN9ETkiLXiOw967wFZ/p
        0Odc+xK0i6pvULdjh9ICjmVBz1qHgzT30nxTUqZDBSzMZKrIPAa0W59qKyBhWH1gGR4a8E
        MxXJxUpCIRsFuPoeCm3ktQ+GgHZdA2GdK73UNB/cysKtlqjiBvrGNyXDzyZg6lNg3nKQIK
        Yr8DS+17+7YKu4DXig0afV793q2ehuGfQtwej3Dbj0e8jDFGvva95C+zX1ggmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605951489;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMSdUI6XS0tsUduJbOS41qb9ms4EeL+JhqDmIUyDRq0=;
        b=4UtOABd5/oYNN+mV8cZPulhubHBvtoKp3LA/grnB0On5w6A1szmGKjoG0FFkJp2ijekCnL
        Zaz9cbjrP1OIv7CQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot/compressed/64: Use TEST %reg,%reg
 instead of CMP $0,%reg
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029160258.139216-1-ubizjak@gmail.com>
References: <20201029160258.139216-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <160595148786.11244.5880484462586450663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ab09b58e4bdfdbcec425e54ebeaf6e209a96318f
Gitweb:        https://git.kernel.org/tip/ab09b58e4bdfdbcec425e54ebeaf6e209a96318f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 29 Oct 2020 17:02:58 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 21 Nov 2020 10:26:25 +01:00

x86/boot/compressed/64: Use TEST %reg,%reg instead of CMP $0,%reg

Use TEST %reg,%reg which sets the zero flag in the same way as CMP
$0,%reg, but the encoding uses one byte less.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20201029160258.139216-1-ubizjak@gmail.com
---
 arch/x86/boot/compressed/head_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 017de6c..e94874f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -241,12 +241,12 @@ SYM_FUNC_START(startup_32)
 	leal	rva(startup_64)(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	rva(efi32_boot_args)(%ebp), %edi
-	cmp	$0, %edi
+	testl	%edi, %edi
 	jz	1f
 	leal	rva(efi64_stub_entry)(%ebp), %eax
 	movl	rva(efi32_boot_args+4)(%ebp), %esi
 	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jnz	1f
 	/*
 	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
@@ -592,7 +592,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Check what paging mode we want to be in after the trampoline */
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jz	1f
 
 	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
@@ -622,7 +622,7 @@ SYM_CODE_START(trampoline_32bit_src)
 
 	/* Enable PAE and LA57 (if required) paging modes */
 	movl	$X86_CR4_PAE, %eax
-	cmpl	$0, %edx
+	testl	%edx, %edx
 	jz	1f
 	orl	$X86_CR4_LA57, %eax
 1:
