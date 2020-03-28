Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95219656A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Mar 2020 12:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgC1LAt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Mar 2020 07:00:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55513 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1K76 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C0-0003b7-Bs; Sat, 28 Mar 2020 11:59:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE4731C03A9;
        Sat, 28 Mar 2020 11:59:55 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:55 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: ia32_setup_rt_frame(): consolidate uaccess areas
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319563.28353.4352506749925674731.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     57d563c8292569f2849569853e846bf740df5032
Gitweb:        https://git.kernel.org/tip/57d563c8292569f2849569853e846bf740df5032
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 19:42:40 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:41:10 -04:00

x86: ia32_setup_rt_frame(): consolidate uaccess areas

__copy_siginfo_to_user32() call reordered a bit.  The rest folds
nicely.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 7018c2c..f9d8804 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -302,10 +302,9 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 {
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fp = NULL;
 
-	/* __copy_to_user optimizes that into a single 8 byte store */
+	/* unsafe_put_user optimizes that into a single 8 byte store */
 	static const struct {
 		u8 movl;
 		u32 val;
@@ -347,17 +346,11 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	 * versions need it.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
-	user_access_end();
-
-	if (__copy_siginfo_to_user32(&frame->info, &ksig->info, false))
-		return -EFAULT;
-	if (!user_access_begin(&frame->uc.uc_mcontext, sizeof(struct sigcontext_32)))
-		return -EFAULT;
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_user(*(__u64 *)set, (__u64 *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
-	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
-	if (err)
+	if (__copy_siginfo_to_user32(&frame->info, &ksig->info, false))
 		return -EFAULT;
 
 	/* Set up registers for signal handler */
