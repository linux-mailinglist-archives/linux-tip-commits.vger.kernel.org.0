Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13286FE708
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 22:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKOVNq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 16:13:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44587 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOVMh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 16:12:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVitJ-0007O6-T1; Fri, 15 Nov 2019 22:12:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 71C371C18CE;
        Fri, 15 Nov 2019 22:12:29 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Remove bitmap if all permissions dropped
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113210104.988865829@linutronix.de>
References: <20191113210104.988865829@linutronix.de>
MIME-Version: 1.0
Message-ID: <157385234943.12247.1722831605467761848.tip-bot2@tip-bot2>
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

Commit-ID:     f16c41c9db8460874662b46f0db5c8af2a568157
Gitweb:        https://git.kernel.org/tip/f16c41c9db8460874662b46f0db5c8af2a568157
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2019 21:42:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Nov 2019 20:15:05 +01:00

x86/ioperm: Remove bitmap if all permissions dropped

If ioperm() results in a bitmap with all bits set (no permissions to any
I/O port), then handling that bitmap on context switch and exit to user
mode is pointless. Drop it.

Move the bitmap exit handling to the ioport code and reuse it for both the
thread exit path and dropping it. This allows to reuse this code for the
upcoming iopl() emulation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191113210104.988865829@linutronix.de

---
 arch/x86/include/asm/io_bitmap.h |  2 ++
 arch/x86/kernel/ioport.c         | 19 ++++++++++++++++++-
 arch/x86/kernel/process.c        | 17 +++--------------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 6d82a37..784a88e 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -11,6 +11,8 @@ struct io_bitmap {
 	unsigned long	bitmap[IO_BITMAP_LONGS];
 };
 
+void io_bitmap_exit(void);
+
 void tss_update_io_bitmap(void);
 
 #endif
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 198bead..f9fc69a 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -16,6 +16,18 @@
 
 static atomic64_t io_bitmap_sequence;
 
+void io_bitmap_exit(void)
+{
+	struct io_bitmap *iobm = current->thread.io_bitmap;
+
+	current->thread.io_bitmap = NULL;
+	clear_thread_flag(TIF_IO_BITMAP);
+	preempt_disable();
+	tss_update_io_bitmap();
+	preempt_enable();
+	kfree(iobm);
+}
+
 /*
  * this changes the io permissions bitmap in the current task.
  */
@@ -61,11 +73,16 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Search for a (possibly new) maximum. This is simple and stupid,
 	 * to keep it obviously correct:
 	 */
-	max_long = 0;
+	max_long = UINT_MAX;
 	for (i = 0; i < IO_BITMAP_LONGS; i++) {
 		if (iobm->bitmap[i] != ~0UL)
 			max_long = i;
 	}
+	/* All permissions dropped? */
+	if (max_long == UINT_MAX) {
+		io_bitmap_exit();
+		return 0;
+	}
 
 	iobm->max = (max_long + 1) * sizeof(unsigned long);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1990011..75f8b13 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -102,21 +102,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct io_bitmap *iobm = t->io_bitmap;
 	struct fpu *fpu = &t->fpu;
-	struct tss_struct *tss;
-
-	if (iobm) {
-		preempt_disable();
-		tss = this_cpu_ptr(&cpu_tss_rw);
-
-		t->io_bitmap = NULL;
-		clear_thread_flag(TIF_IO_BITMAP);
-		/* Invalidate the io bitmap base in the TSS */
-		tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-		preempt_enable();
-		kfree(iobm);
-	}
+
+	if (test_thread_flag(TIF_IO_BITMAP))
+		io_bitmap_exit();
 
 	free_vm86(t);
 
