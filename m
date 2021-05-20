Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A374738AFE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbhETNZI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241122AbhETNZC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:02 -0400
Date:   Thu, 20 May 2021 13:23:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MD+RRM2Hf8d1p6G4wp3yGy1qQGNWhOfXaby141LBubw=;
        b=a8cIvaJN8TtUM6/7zyM8zhdYgH8GYM+YnPTnYhoYBO05afvPwjQvGhbwtnNUKpdyu4bP1T
        on+qyZSdFxlh1I7hlcfhVpN4UWOwhf8mupl7R/mZ0MrclSJtnQ/WRcDxmNo3DivqGAjM8a
        yzyk3grMEcKnxxY2vpJ5O1DKk3SWAXvNlxqcqcmwr7R0JtVBr1w5lsJdnMGdfRgNPIErjc
        nfBoMluILwmW7Fd0C3ODoGhGm2WGTfi4DRmo6wbO4tvpR6Df3s9L60sljSgM/X6syLvom0
        CBiHLEwo02JREhjf0nVPAafQWYHnBszB76vFJW15tdUgX6P5QxvfokrEdiW7pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MD+RRM2Hf8d1p6G4wp3yGy1qQGNWhOfXaby141LBubw=;
        b=jLXk1WPlthqJFbihkW3sZlasJF/Ikc5O1wJbnOAHJerjZ/IWxLGEFaKs5GUURx7swA4n9o
        fRVs4wBPcgTflfAw==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/x32: Rename __x32_compat_sys_* to
 __x64_compat_sys_*
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517073815.97426-2-masahiroy@kernel.org>
References: <20210517073815.97426-2-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <162151701543.29796.4894705972127916050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     2e958a8a510d956ec8528f0bd20e309b5bb5156c
Gitweb:        https://git.kernel.org/tip/2e958a8a510d956ec8528f0bd20e309b5bb5156c
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 17 May 2021 16:38:09 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:03:58 +02:00

x86/entry/x32: Rename __x32_compat_sys_* to __x64_compat_sys_*

The SYSCALL macros are mapped to symbols as follows:

  __SYSCALL_COMMON(nr, sym)  -->  __x64_<sym>
  __SYSCALL_X32(nr, sym)     -->  __x32_<sym>

Originally, the syscalls in the x32 special range (512-547) were all
compat.

This assumption is now broken after the following commits:

  55db9c0e8534 ("net: remove compat_sys_{get,set}sockopt")
  5f764d624a89 ("fs: remove the compat readv/writev syscalls")
  598b3cec831f ("fs: remove compat_sys_vmsplice")
  c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")

Those commits redefined __x32_sys_* to __x64_sys_* because there is no stub
like __x32_sys_*.

Defining them as follows is more sensible and cleaner.

  __SYSCALL_COMMON(nr, sym)  -->  __x64_<sym>
  __SYSCALL_X32(nr, sym)     -->  __x64_<sym>

This works because both x86_64 and x32 use the same ABI (RDI, RSI, RDX,
R10, R8, R9)

The ugly #define __x32_sys_* will go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210517073815.97426-2-masahiroy@kernel.org

---
 arch/x86/entry/syscall_x32.c           | 16 ++--------------
 arch/x86/include/asm/syscall_wrapper.h | 10 +++++-----
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index f2fe0a3..3fea8fb 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,27 +8,15 @@
 #include <asm/unistd.h>
 #include <asm/syscall.h>
 
-/*
- * Reuse the 64-bit entry points for the x32 versions that occupy different
- * slots in the syscall table.
- */
-#define __x32_sys_readv		__x64_sys_readv
-#define __x32_sys_writev	__x64_sys_writev
-#define __x32_sys_getsockopt	__x64_sys_getsockopt
-#define __x32_sys_setsockopt	__x64_sys_setsockopt
-#define __x32_sys_vmsplice	__x64_sys_vmsplice
-#define __x32_sys_process_vm_readv	__x64_sys_process_vm_readv
-#define __x32_sys_process_vm_writev	__x64_sys_process_vm_writev
-
 #define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON
 
-#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
+#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
 #define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 80c08c7..6a2827d 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * __x64_sys_*()         - 64-bit native syscall
  * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
  * __ia32_compat_sys_*() - 32-bit compat syscall
- * __x32_compat_sys_*()  - 64-bit X32 compat syscall
+ * __x64_compat_sys_*()  - 64-bit X32 compat syscall
  *
  * The registers are decoded according to the ABI:
  * 64-bit: RDI, RSI, RDX, R10, R8, R9
@@ -166,17 +166,17 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
  * with x86_64 obviously do not need such care.
  */
 #define __X32_COMPAT_SYS_STUB0(name)					\
-	__SYS_STUB0(x32, compat_sys_##name)
+	__SYS_STUB0(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	__SYS_STUBx(x32, compat_sys##name,				\
+	__SYS_STUBx(x64, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __X32_COMPAT_COND_SYSCALL(name)					\
-	__COND_SYSCALL(x32, compat_sys_##name)
+	__COND_SYSCALL(x64, compat_sys_##name)
 
 #define __X32_COMPAT_SYS_NI(name)					\
-	__SYS_NI(x32, compat_sys_##name)
+	__SYS_NI(x64, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
