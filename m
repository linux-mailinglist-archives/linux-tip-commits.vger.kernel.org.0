Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7213FEC18
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Nov 2019 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfKPLw3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 Nov 2019 06:52:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfKPLv2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwbq-00026c-Uy; Sat, 16 Nov 2019 12:51:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 97D611C1905;
        Sat, 16 Nov 2019 12:51:22 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:22 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/iopl: Fixup misleading comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508258.12247.14455974974055338537.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     be9afb4b529d9e3a68da1212e33be677bbfc8d2c
Gitweb:        https://git.kernel.org/tip/be9afb4b529d9e3a68da1212e33be677bbfc8d2c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:05 +01:00

x86/iopl: Fixup misleading comment

The comment for the sys_iopl() implementation is outdated and actively
misleading in some parts. Fix it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ioport.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index f82ca1c..3548563 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -41,7 +41,7 @@ void io_bitmap_exit(void)
 }
 
 /*
- * this changes the io permissions bitmap in the current task.
+ * This changes the io permissions bitmap in the current task.
  */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
@@ -136,14 +136,24 @@ SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
 }
 
 /*
- * sys_iopl has to be used when you want to access the IO ports
- * beyond the 0x3ff range: to get the full 65536 ports bitmapped
- * you'd need 8kB of bitmaps/process, which is a bit excessive.
+ * The sys_iopl functionality depends on the level argument, which if
+ * granted for the task is used by the CPU to check I/O instruction and
+ * CLI/STI against the current priviledge level (CPL). If CPL is less than
+ * or equal the tasks IOPL level the instructions take effect. If not a #GP
+ * is raised. The default IOPL is 0, i.e. no permissions.
  *
- * Here we just change the flags value on the stack: we allow
- * only the super-user to do it. This depends on the stack-layout
- * on system-call entry - see also fork() and the signal handling
- * code.
+ * Setting IOPL to level 0-2 is disabling the userspace access. Only level
+ * 3 enables it. If set it allows the user space thread:
+ *
+ * - Unrestricted access to all 65535 I/O ports
+ * - The usage of CLI/STI instructions
+ *
+ * The advantage over ioperm is that the context switch does not require to
+ * update the I/O bitmap which is especially true when a large number of
+ * ports is accessed. But the allowance of CLI/STI in userspace is
+ * considered a major problem.
+ *
+ * IOPL is strictly per thread and inherited on fork.
  */
 SYSCALL_DEFINE1(iopl, unsigned int, level)
 {
@@ -164,9 +174,18 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 		    security_locked_down(LOCKDOWN_IOPORT))
 			return -EPERM;
 	}
+	/*
+	 * Change the flags value on the return stack, which has been set
+	 * up on system-call entry. See also the fork and signal handling
+	 * code how this is handled.
+	 */
 	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
 		(level << X86_EFLAGS_IOPL_BIT);
+	/* Store the new level in the thread struct */
 	t->iopl = level << X86_EFLAGS_IOPL_BIT;
+	/*
+	 * X86_32 switches immediately and XEN handles it via emulation.
+	 */
 	set_iopl_mask(t->iopl);
 
 	return 0;
