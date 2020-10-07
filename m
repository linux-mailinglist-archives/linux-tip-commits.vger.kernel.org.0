Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B37285C40
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgJGKCw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgJGKCv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BDCC0613D2;
        Wed,  7 Oct 2020 03:02:51 -0700 (PDT)
Date:   Wed, 07 Oct 2020 10:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KixaGlkvXzdX2BYmeSzi0CSJIpQwUE8wulsHgqcZu4=;
        b=EkaPctlmMPRAWv2oGKNiySRWYRc82V8CFq/xYp41zayROfXbY7OmuRjiYIu93tnYbbvkV3
        zzc40DaPUHfp8M3EVNIA+U9U9SypYoJNQNvllc8Yy6oLicvpsT7YI6NCDe+5ZcgQk4qb5o
        4dB+l5x+u1q/AeO8+HvPdEXpfAkXJo8hHIiiOImRCpPiD8WI/1MrqMqusz+D5TVwuf689J
        4wIQFsiR575xOH68hZRsLcDTJJfC0Vcn7ixI67ZS+y5juTa+ISb+PPH4Y+MhpMhYNOXXhI
        VZ71f4TX/nih5LQ4ErVo4rVb7bEnxuQJ9rFOcKmPMSmvv48HwONt7sKK8Pn2Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KixaGlkvXzdX2BYmeSzi0CSJIpQwUE8wulsHgqcZu4=;
        b=5I20jcFEGsqxLlswxPZYfnvvPN4vu3TxUt9tFMs2Uu/P0vTW9+YRjjBPIDbMGC217nJ1Eo
        0itGv5RuMEczG0Cg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Recover from poison found while copying from
 user space
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-6-tony.luck@intel.com>
References: <20201006210910.21062-6-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206496812.7002.8407534676801412666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c0ab7ffce275d3f83bd253c70889c28821d4a41d
Gitweb:        https://git.kernel.org/tip/c0ab7ffce275d3f83bd253c70889c28821d4a41d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:09 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 11:29:41 +02:00

x86/mce: Recover from poison found while copying from user space

Existing kernel code can only recover from a machine check on code that
is tagged in the exception table with a fault handling recovery path.

Add two new fields in the task structure to pass information from
machine check handler to the "task_work" that is queued to run before
the task returns to user mode:

+ mce_vaddr: will be initialized to the user virtual address of the fault
  in the case where the fault occurred in the kernel copying data from
  a user address.  This is so that kill_me_maybe() can provide that
  information to the user SIGBUS handler.

+ mce_kflags: copy of the struct mce.kflags needed by kill_me_maybe()
  to determine if mce_vaddr is applicable to this error.

Add code to recover from a machine check while copying data from user
space to the kernel. Action for this case is the same as if the user
touched the poison directly; unmap the page and send a SIGBUS to the task.

Use a new helper function to share common code between the "fault
in user mode" case and the "fault while copying from user" case.

New code paths will be activated by the next patch which sets
MCE_IN_KERNEL_COPYIN.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-6-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 27 ++++++++++++++++++++-------
 include/linux/sched.h          |  2 ++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2d6caf0..5c423c4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1260,6 +1260,21 @@ static void kill_me_maybe(struct callback_head *cb)
 	kill_me_now(cb);
 }
 
+static void queue_task_work(struct mce *m, int kill_it)
+{
+	current->mce_addr = m->addr;
+	current->mce_kflags = m->kflags;
+	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
+	current->mce_whole_page = whole_page(m);
+
+	if (kill_it)
+		current->mce_kill_me.func = kill_me_now;
+	else
+		current->mce_kill_me.func = kill_me_maybe;
+
+	task_work_add(current, &current->mce_kill_me, true);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1401,13 +1416,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
-		current->mce_addr = m.addr;
-		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
-		current->mce_whole_page = whole_page(&m);
-		current->mce_kill_me.func = kill_me_maybe;
-		if (kill_it)
-			current->mce_kill_me.func = kill_me_now;
-		task_work_add(current, &current->mce_kill_me, true);
+		queue_task_work(&m, kill_it);
+
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
@@ -1422,6 +1432,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
+
+		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+			queue_task_work(&m, kill_it);
 	}
 out:
 	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd93..2cbba3e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1308,6 +1308,8 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_X86_MCE
+	void __user			*mce_vaddr;
+	__u64				mce_kflags;
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
 					mce_whole_page : 1,
