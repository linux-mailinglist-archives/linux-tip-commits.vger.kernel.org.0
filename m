Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71B411309
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Sep 2021 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhITKoO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Sep 2021 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhITKoK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Sep 2021 06:44:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4FC061766;
        Mon, 20 Sep 2021 03:42:43 -0700 (PDT)
Date:   Mon, 20 Sep 2021 10:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632134560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0V+QQL9VyuOkSc42xJV2bFPNvouhdN6olxPqBCM2QmA=;
        b=edK9XsTm3t8Lj/7TrP7LJ7HsOK/W5RD/l10vsAzkYmJ1wSBz3yIJAlUYl0qTB0P0kcmn1r
        Fn59Uxo/SkpngV7jpKu8PUrlhtLAf1cr51lORzEtKUOj/RmtGpjo0XDJXOE058oNmHPHk1
        nvyUOpFQ7cUrhXXHbC8WJ6OUM6DZ8keekQzeEzNFyjckcsKUFSeIVJclTlQN//LeR5Szkj
        y8jzL9rp/ku+9bHGqChExgLDYvsqt2sPX8vzwLaVqWb/O68xX7YmEt0BD6ad3RKg4FAdFN
        AG9y6Q7tAdmhcuF5NnHKqyvcePgrmozK0Tv/vJSfgSpCcUu3ve2YRv6ZB/8xRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632134560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0V+QQL9VyuOkSc42xJV2bFPNvouhdN6olxPqBCM2QmA=;
        b=Hc+vfinaC9YAFEw3NmUWYJwPT++73YCBJtE4VfyojeLrtST6MUZBfKSbU8acDXMXpYh0+u
        sv2B/m5+as3TPeBQ==
From:   "tip-bot2 for Jiashuo Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fault: Fix wrong signal when vsyscall fails with pkey
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730030152.249106-1-liangjs@pku.edu.cn>
References: <20210730030152.249106-1-liangjs@pku.edu.cn>
MIME-Version: 1.0
Message-ID: <163213455900.25758.11915876484367505676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0829d0b6bf0fb3453608798442deaf00c4a1abec
Gitweb:        https://git.kernel.org/tip/0829d0b6bf0fb3453608798442deaf00c4a1abec
Author:        Jiashuo Liang <liangjs@pku.edu.cn>
AuthorDate:    Fri, 30 Jul 2021 11:01:52 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Sep 2021 12:31:06 +02:00

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

 [ bp: Massage commit message. ]

Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel faults from usermode")
Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210730030152.249106-1-liangjs@pku.edu.cn
---
 arch/x86/mm/fault.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

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
 
