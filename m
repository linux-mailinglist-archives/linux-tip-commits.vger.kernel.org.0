Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65102285C3F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgJGKCw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgJGKCv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5001BC061755;
        Wed,  7 Oct 2020 03:02:51 -0700 (PDT)
Date:   Wed, 07 Oct 2020 10:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ul1RAJ/EhaQdfhWthF9joh4Cus1PXOwouVzgOP7J7XU=;
        b=cWMeBKiGNmj5PsG/ZBQHPVZw5uEUe7s1ed9JqvqTNwXoE0UGo+5OlGXXlToUeVu9p8FREI
        B7Kp0AOZyADO9+5SRWjBhDk+5dmuutEzTiGKtVQ3n2lIdm/An4V3DOrcCCRuE2DFGByy7V
        0cahMGA8Uz0HSR58eglD51Z7YfH8vCHXthxYXkRHYhYrDeNOLehxaJJWPN8JHEfKDppw7+
        bRaT7OlXxIlFSKImnXzg9KbCs5BnMr2WF/sEuGEcNWEQCTF+Jse7gKkMG8u5LaAJO1yjI4
        VMQPj2LzzegRtuzucNv7GIUZzIK5jPt1h9AIFmevmwkILsYAfztgeV5TrBp2Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ul1RAJ/EhaQdfhWthF9joh4Cus1PXOwouVzgOP7J7XU=;
        b=vQOWv+c/WhcFm7G9UuAMd3o3gGIwCCLwoQnP2ERxILBQzhHPAhfYIIejWY/9B5DcQY39Rm
        TbWTxHarrGz8MwCA==
From:   "tip-bot2 for Youquan Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add _ASM_EXTABLE_CPY for copy user access
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-4-tony.luck@intel.com>
References: <20201006210910.21062-4-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206496903.7002.7626997597671796632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     278b917f8cb9b02923c15249f9d1a5769d2c1976
Gitweb:        https://git.kernel.org/tip/278b917f8cb9b02923c15249f9d1a5769d2c1976
Author:        Youquan Song <youquan.song@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:07 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 11:19:11 +02:00

x86/mce: Add _ASM_EXTABLE_CPY for copy user access

_ASM_EXTABLE_UA is a general exception entry to record the exception fixup
for all exception spots between kernel and user space access.

To enable recovery from machine checks while coping data from user
addresses it is necessary to be able to distinguish the places that are
looping copying data from those that copy a single byte/word/etc.

Add a new macro _ASM_EXTABLE_CPY and use it in place of _ASM_EXTABLE_UA
in the copy functions.

Record the exception reason number to regs->ax at
ex_handler_uaccess which is used to check MCE triggered.

The new fixup routine ex_handler_copy() is almost an exact copy of
ex_handler_uaccess() The difference is that it sets regs->ax to the trap
number. Following patches use this to avoid trying to copy remaining
bytes from the tail of the copy and possibly hitting the poison again.

New mce.kflags bit MCE_IN_KERNEL_COPYIN will be used by mce_severity()
calculation to indicate that a machine check is recoverable because the
kernel was copying from user space.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-4-tony.luck@intel.com
---
 arch/x86/include/asm/asm.h  |  6 ++-
 arch/x86/include/asm/mce.h  | 15 ++++++-
 arch/x86/lib/copy_user_64.S | 96 ++++++++++++++++++------------------
 arch/x86/mm/extable.c       | 14 ++++-
 4 files changed, 82 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5c15f95..0359cbb 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -135,6 +135,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
@@ -160,6 +163,9 @@
 # define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
 
+# define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ba2062d..a0f1478 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -136,9 +136,24 @@
 #define	MCE_HANDLED_NFIT	BIT_ULL(3)
 #define	MCE_HANDLED_EDAC	BIT_ULL(4)
 #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+
+/*
+ * Indicates an MCE which has happened in kernel space but from
+ * which the kernel can recover simply by executing fixup_exception()
+ * so that an error is returned to the caller of the function that
+ * hit the machine check.
+ */
 #define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
 
 /*
+ * Indicates an MCE that happened in kernel space while copying data
+ * from user. In this case fixup_exception() gets the kernel to the
+ * error exit for the copy function. Machine check handler can then
+ * treat it like a fault taken in user mode.
+ */
+#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
+
+/*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
  * debugging tools.  Each entry is only valid when its finished flag
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 816f128..5b68e94 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -36,8 +36,8 @@
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(100b, 103b)
-	_ASM_EXTABLE_UA(101b, 103b)
+	_ASM_EXTABLE_CPY(100b, 103b)
+	_ASM_EXTABLE_CPY(101b, 103b)
 	.endm
 
 /*
@@ -116,26 +116,26 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 30b)
-	_ASM_EXTABLE_UA(2b, 30b)
-	_ASM_EXTABLE_UA(3b, 30b)
-	_ASM_EXTABLE_UA(4b, 30b)
-	_ASM_EXTABLE_UA(5b, 30b)
-	_ASM_EXTABLE_UA(6b, 30b)
-	_ASM_EXTABLE_UA(7b, 30b)
-	_ASM_EXTABLE_UA(8b, 30b)
-	_ASM_EXTABLE_UA(9b, 30b)
-	_ASM_EXTABLE_UA(10b, 30b)
-	_ASM_EXTABLE_UA(11b, 30b)
-	_ASM_EXTABLE_UA(12b, 30b)
-	_ASM_EXTABLE_UA(13b, 30b)
-	_ASM_EXTABLE_UA(14b, 30b)
-	_ASM_EXTABLE_UA(15b, 30b)
-	_ASM_EXTABLE_UA(16b, 30b)
-	_ASM_EXTABLE_UA(18b, 40b)
-	_ASM_EXTABLE_UA(19b, 40b)
-	_ASM_EXTABLE_UA(21b, 50b)
-	_ASM_EXTABLE_UA(22b, 50b)
+	_ASM_EXTABLE_CPY(1b, 30b)
+	_ASM_EXTABLE_CPY(2b, 30b)
+	_ASM_EXTABLE_CPY(3b, 30b)
+	_ASM_EXTABLE_CPY(4b, 30b)
+	_ASM_EXTABLE_CPY(5b, 30b)
+	_ASM_EXTABLE_CPY(6b, 30b)
+	_ASM_EXTABLE_CPY(7b, 30b)
+	_ASM_EXTABLE_CPY(8b, 30b)
+	_ASM_EXTABLE_CPY(9b, 30b)
+	_ASM_EXTABLE_CPY(10b, 30b)
+	_ASM_EXTABLE_CPY(11b, 30b)
+	_ASM_EXTABLE_CPY(12b, 30b)
+	_ASM_EXTABLE_CPY(13b, 30b)
+	_ASM_EXTABLE_CPY(14b, 30b)
+	_ASM_EXTABLE_CPY(15b, 30b)
+	_ASM_EXTABLE_CPY(16b, 30b)
+	_ASM_EXTABLE_CPY(18b, 40b)
+	_ASM_EXTABLE_CPY(19b, 40b)
+	_ASM_EXTABLE_CPY(21b, 50b)
+	_ASM_EXTABLE_CPY(22b, 50b)
 SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -180,8 +180,8 @@ SYM_FUNC_START(copy_user_generic_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 11b)
-	_ASM_EXTABLE_UA(3b, 12b)
+	_ASM_EXTABLE_CPY(1b, 11b)
+	_ASM_EXTABLE_CPY(3b, 12b)
 SYM_FUNC_END(copy_user_generic_string)
 EXPORT_SYMBOL(copy_user_generic_string)
 
@@ -213,7 +213,7 @@ SYM_FUNC_START(copy_user_enhanced_fast_string)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, 12b)
+	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
 EXPORT_SYMBOL(copy_user_enhanced_fast_string)
 
@@ -237,7 +237,7 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	ASM_CLAC
 	ret
 
-	_ASM_EXTABLE_UA(1b, 2b)
+	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
@@ -366,27 +366,27 @@ SYM_FUNC_START(__copy_user_nocache)
 	jmp .Lcopy_user_handle_tail
 	.previous
 
-	_ASM_EXTABLE_UA(1b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(2b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(3b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(4b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(5b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(6b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(7b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(8b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(9b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(10b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(11b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(12b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(13b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(14b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(15b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(16b, .L_fixup_4x8b_copy)
-	_ASM_EXTABLE_UA(20b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(21b, .L_fixup_8b_copy)
-	_ASM_EXTABLE_UA(30b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(31b, .L_fixup_4b_copy)
-	_ASM_EXTABLE_UA(40b, .L_fixup_1b_copy)
-	_ASM_EXTABLE_UA(41b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(3b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(4b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(5b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(6b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(7b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(8b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(9b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(10b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(11b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(12b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(13b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(14b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(15b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(16b, .L_fixup_4x8b_copy)
+	_ASM_EXTABLE_CPY(20b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(21b, .L_fixup_8b_copy)
+	_ASM_EXTABLE_CPY(30b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(31b, .L_fixup_4b_copy)
+	_ASM_EXTABLE_CPY(40b, .L_fixup_1b_copy)
+	_ASM_EXTABLE_CPY(41b, .L_fixup_1b_copy)
 SYM_FUNC_END(__copy_user_nocache)
 EXPORT_SYMBOL(__copy_user_nocache)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index de43525..5829457 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -80,6 +80,18 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
+__visible bool ex_handler_copy(const struct exception_table_entry *fixup,
+			       struct pt_regs *regs, int trapnr,
+			       unsigned long error_code,
+			       unsigned long fault_addr)
+{
+	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
+	regs->ip = ex_fixup_addr(fixup);
+	regs->ax = trapnr;
+	return true;
+}
+EXPORT_SYMBOL(ex_handler_copy);
+
 __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
 				       struct pt_regs *regs, int trapnr,
 				       unsigned long error_code,
@@ -136,7 +148,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
 	handler = ex_fixup_handler(e);
 	if (handler == ex_handler_fault)
 		return EX_HANDLER_FAULT;
-	else if (handler == ex_handler_uaccess)
+	else if (handler == ex_handler_uaccess || handler == ex_handler_copy)
 		return EX_HANDLER_UACCESS;
 	else
 		return EX_HANDLER_OTHER;
