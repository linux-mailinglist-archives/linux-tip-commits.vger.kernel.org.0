Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5830645A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbhA0Tkm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhA0Tbz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F10C06174A;
        Wed, 27 Jan 2021 11:31:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kSXapSSatlvSkO2NUX8P1H4Z56T3yBa/JM7+mnwKqQY=;
        b=IOvB6AdnqlJpJmuPBig4uvW7a/lj8E1lqAEEXNYJMD+XqcZ5vUAh0u2IlC+8ZYhADACxZE
        sT90CdKxbkOKjUchuQAu8MPVAD6T8Xa2gr8TFiRqQ79dsbZ4HoOLy9KkC+mh9IN3o0xR8W
        QYaGR4hnh4SJXl+NZ/VJY2PmgdDrrX/e+Ab6SLxaYY8Me4AXDY3mBrie1I94TdI8uo8Hws
        1Y+QMG3RUYS4NmLhGbCAJwJHP+ptZB3t9h13lszFfd8fWjBcvXOWeTuCbPa3GeApTcsEAf
        lAUwXqRgUARmWuMUwef1F+27aInRBG28K7VOqUr0ZsEWrsZXoxTCOqWE1MChTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kSXapSSatlvSkO2NUX8P1H4Z56T3yBa/JM7+mnwKqQY=;
        b=FVdD9V/5ui2dCOt8bplMhBVM/DIRked7FcL83rSd4tBO3vl2C9NhiqR7v29ONLrdiNfcPs
        r0g8u0ZdQSwkh0CA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: x86: move mixed mode stack PA variable out of
 'efi_scratch'
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587043.23325.18111554459465233240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     3e1e00c00e2b9b5c9a2f47f1c67720a5d430e4d0
Gitweb:        https://git.kernel.org/tip/3e1e00c00e2b9b5c9a2f47f1c67720a5d430e4d0
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 19 Jan 2021 15:16:27 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 19 Jan 2021 17:57:16 +01:00

efi: x86: move mixed mode stack PA variable out of 'efi_scratch'

As a first step to removing the awkward 'struct efi_scratch' definition
that conveniently combines the storage of the mixed mode stack pointer
with the MM pointer variable that records the task's MM pointer while it
is being replaced with the EFI MM one, move the mixed mode stack pointer
into a separate variable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h           | 3 +--
 arch/x86/platform/efi/efi_64.c       | 2 +-
 arch/x86/platform/efi/efi_thunk_64.S | 6 +++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c98f783..5e37e6d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -12,6 +12,7 @@
 #include <linux/pgtable.h>
 
 extern unsigned long efi_fw_vendor, efi_config_table;
+extern unsigned long efi_mixed_mode_stack_pa;
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -96,11 +97,9 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 
 /*
  * struct efi_scratch - Scratch space used while switching to/from efi_mm
- * @phys_stack: stack used during EFI Mixed Mode
  * @prev_mm:    store/restore stolen mm_struct while switching to/from efi_mm
  */
 struct efi_scratch {
-	u64			phys_stack;
 	struct mm_struct	*prev_mm;
 } __packed;
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e1e8d4e..1d90418 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -256,7 +256,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 1;
 	}
 
-	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
+	efi_mixed_mode_stack_pa = page_to_phys(page + 1); /* stack grows down */
 
 	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 26f0da2..fd3dd17 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -33,7 +33,7 @@ SYM_CODE_START(__efi64_thunk)
 	 * Switch to 1:1 mapped 32-bit stack pointer.
 	 */
 	movq	%rsp, %rax
-	movq	efi_scratch(%rip), %rsp
+	movq	efi_mixed_mode_stack_pa(%rip), %rsp
 	push	%rax
 
 	/*
@@ -70,3 +70,7 @@ SYM_CODE_START(__efi64_thunk)
 	pushl	%ebp
 	lret
 SYM_CODE_END(__efi64_thunk)
+
+	.bss
+	.balign 8
+SYM_DATA(efi_mixed_mode_stack_pa, .quad 0)
