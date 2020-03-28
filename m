Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8E219654C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Mar 2020 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgC1K74 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Mar 2020 06:59:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1K74 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9By-0003a6-I0; Sat, 28 Mar 2020 11:59:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 35EF51C0470;
        Sat, 28 Mar 2020 11:59:54 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:53 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: __setup_rt_frame(): consolidate uaccess areas
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319388.28353.11678917713645911809.tip-bot2@tip-bot2>
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

Commit-ID:     ead8e4e7e2c75ced6fcd9a53d3e9a2ecd7368553
Gitweb:        https://git.kernel.org/tip/ead8e4e7e2c75ced6fcd9a53d3e9a2ecd7368553
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 21:22:39 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:57:10 -04:00

x86: __setup_rt_frame(): consolidate uaccess areas

reorder copy_siginfo_to_user() calls a bit

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 38ff834..e37d5a1 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -357,7 +357,6 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 {
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
-	int err = 0;
 	void __user *fp = NULL;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
@@ -393,11 +392,11 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_user(*(__u64 *)set,
+			(__u64 __user *)&frame->uc.uc_sigmask, Efault);
 	user_access_end();
 	
-	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
-	if (err)
+	if (copy_siginfo_to_user(&frame->info, &ksig->info))
 		return -EFAULT;
 
 	/* Set up registers for signal handler */
@@ -439,23 +438,14 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	struct rt_sigframe __user *frame;
 	void __user *fp = NULL;
 	unsigned long uc_flags;
-	int err = 0;
 
 	/* x86-64 should always use SA_RESTORER. */
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
 	uc_flags = frame_uc_flags(regs);
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -468,11 +458,13 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	   already in userspace.  */
 	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0], Efault);
 	user_access_end();
-	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
-	if (err)
-		return -EFAULT;
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
 
 	/* Set up registers for signal handler */
 	regs->di = sig;
