Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5981E41275E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Sep 2021 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhITUkb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Sep 2021 16:40:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhITUib (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Sep 2021 16:38:31 -0400
Date:   Mon, 20 Sep 2021 20:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632170222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu7ggJHjJvT9SrlVYGRy+KaXsW4d47NsE5akStQ6pn4=;
        b=omB7cFyu51eUGbJPrPDrP1fHnyFpt41ogmKhOJ5WnklSQCTJ06R7MWj4v6/1bONuNhngQt
        BJwoQo+g54l7ExEJuRQpp4nAMDgBGmharNpyi3qYJDU6ry69C0qY8RJFI35wpnIHfrlRpe
        ypgab/qN+xDKviGc2Sadhki5Dy2sazB1lW9Z4oOI5sxBtFRxdOEfAT/VoXpuvkave6gA0z
        Iiv1EgQN5PaGIvyThiZ2ckBPIm501S1G9CcLNYUCR35X89N9V0mNOGMM+euqT4PYtvXHED
        vnSPOA/rxzwLrWse5kGdHZVVA6GXJvV9JAKbvasUh/cZ1QgTy9MSlmwPHh7cHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632170222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bu7ggJHjJvT9SrlVYGRy+KaXsW4d47NsE5akStQ6pn4=;
        b=ekEJR/JrN12C+BdKCUBX3SVIBnMgY8ZN/DQZwDX8BP/IOQqyRTnb02Zljz2Mfm40p7IQWL
        USJlsqcElTRgGOAw==
From:   "tip-bot2 for Jiashuo Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fault: Fix wrong signal when vsyscall fails with pkey
Cc:     kernel test robot <lkp@intel.com>,
        Jiashuo Liang <liangjs@pku.edu.cn>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730030152.249106-1-liangjs@pku.edu.cn>
References: <20210730030152.249106-1-liangjs@pku.edu.cn>
MIME-Version: 1.0
Message-ID: <163217022114.25758.13735985596257369906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4ffd5df9d18031b6a53f934388726775b4452d3
Gitweb:        https://git.kernel.org/tip/d4ffd5df9d18031b6a53f934388726775b4452d3
Author:        Jiashuo Liang <liangjs@pku.edu.cn>
AuthorDate:    Fri, 30 Jul 2021 11:01:52 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Sep 2021 22:28:47 +02:00

x86/fault: Fix wrong signal when vsyscall fails with pkey

The function __bad_area_nosemaphore() calls kernelmode_fixup_or_oops()
with the parameter @signal being actually @pkey, which will send a
signal numbered with the argument in @pkey.

This bug can be triggered when the kernel fails to access user-given
memory pages that are protected by a pkey, so it can go down the
do_user_addr_fault() path and pass the !user_mode() check in
__bad_area_nosemaphore().

Most cases will simply run the kernel fixup code to make an -EFAULT. But
when another condition current->thread.sig_on_uaccess_err is met, which
is only used to emulate vsyscall, the kernel will generate the wrong
signal.

Add a new parameter @pkey to kernelmode_fixup_or_oops() to fix this.

 [ bp: Massage commit message, fix build error as reported by the 0day
   bot: https://lkml.kernel.org/r/202109202245.APvuT8BX-lkp@intel.com ]

Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210730030152.249106-1-liangjs@pku.edu.cn
---
 arch/x86/include/asm/pkeys.h |  2 --
 arch/x86/mm/fault.c          | 26 ++++++++++++++++++--------
 include/linux/pkeys.h        |  2 ++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 5c7bcaa..1d5f14a 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
-#define ARCH_DEFAULT_PKEY	0
-
 /*
  * If more than 16 keys are ever supported, a thorough audit
  * will be necessary to ensure that the types that store key
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefde..84a2c8c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -710,7 +710,8 @@ oops:
 
 static noinline void
 kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address, int signal, int si_code)
+			 unsigned long address, int signal, int si_code,
+			 u32 pkey)
 {
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -735,8 +736,12 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 
 			set_signal_archinfo(address, error_code);
 
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
+			if (si_code == SEGV_PKUERR) {
+				force_sig_pkuerr((void __user *)address, pkey);
+			} else {
+				/* XXX: hwpoison faults will set the wrong code. */
+				force_sig_fault(signal, si_code, (void __user *)address);
+			}
 		}
 
 		/*
@@ -798,7 +803,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGSEGV, si_code, pkey);
 		return;
 	}
 
@@ -930,7 +936,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 SIGBUS, BUS_ADRERR, ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1396,7 +1403,8 @@ good_area:
 		 */
 		if (!user_mode(regs))
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGBUS, BUS_ADRERR);
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1416,7 +1424,8 @@ good_area:
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address,
+					 0, 0, ARCH_DEFAULT_PKEY);
 		return;
 	}
 
@@ -1424,7 +1433,8 @@ good_area:
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
 			kernelmode_fixup_or_oops(regs, error_code, address,
-						 SIGSEGV, SEGV_MAPERR);
+						 SIGSEGV, SEGV_MAPERR,
+						 ARCH_DEFAULT_PKEY);
 			return;
 		}
 
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 6beb26b..86be8bf 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -4,6 +4,8 @@
 
 #include <linux/mm.h>
 
+#define ARCH_DEFAULT_PKEY	0
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 #include <asm/pkeys.h>
 #else /* ! CONFIG_ARCH_HAS_PKEYS */
