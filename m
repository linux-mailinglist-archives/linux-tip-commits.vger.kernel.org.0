Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8A1036C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKTJih (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 04:38:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfKTJih (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXMRR-0003z9-Me; Wed, 20 Nov 2019 10:38:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 519951C1998;
        Wed, 20 Nov 2019 10:38:26 +0100 (CET)
Date:   Wed, 20 Nov 2019 09:38:26 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] exit/exec: Seperate mm_release()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.240518241@linutronix.de>
References: <20191106224556.240518241@linutronix.de>
MIME-Version: 1.0
Message-ID: <157424270627.12247.12916249646753950188.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4610ba7ad877fafc0a25a30c6c82015304120426
Gitweb:        https://git.kernel.org/tip/4610ba7ad877fafc0a25a30c6c82015304120426
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Nov 2019 09:40:08 +01:00

exit/exec: Seperate mm_release()

mm_release() contains the futex exit handling. mm_release() is called from
do_exit()->exit_mm() and from exec()->exec_mm().

In the exit_mm() case PF_EXITING and the futex state is updated. In the
exec_mm() case these states are not touched.

As the futex exit code needs further protections against exit races, this
needs to be split into two functions.

Preparatory only, no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.240518241@linutronix.de


---
 fs/exec.c                |  2 +-
 include/linux/sched/mm.h |  6 ++++--
 kernel/exit.c            |  2 +-
 kernel/fork.c            | 12 +++++++++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 555e93c..c272312 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1015,7 +1015,7 @@ static int exec_mmap(struct mm_struct *mm)
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
-	mm_release(tsk, old_mm);
+	exec_mm_release(tsk, old_mm);
 
 	if (old_mm) {
 		sync_mm_rss(old_mm);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e677001..c49257a 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -117,8 +117,10 @@ extern struct mm_struct *get_task_mm(struct task_struct *task);
  * succeeds.
  */
 extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
-/* Remove the current tasks stale references to the old mm_struct */
-extern void mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exit() */
+extern void exit_mm_release(struct task_struct *, struct mm_struct *);
+/* Remove the current tasks stale references to the old mm_struct on exec() */
+extern void exec_mm_release(struct task_struct *, struct mm_struct *);
 
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
diff --git a/kernel/exit.c b/kernel/exit.c
index d11bdca..cd893b5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -437,7 +437,7 @@ static void exit_mm(void)
 	struct mm_struct *mm = current->mm;
 	struct core_state *core_state;
 
-	mm_release(current, mm);
+	exit_mm_release(current, mm);
 	if (!mm)
 		return;
 	sync_mm_rss(mm);
diff --git a/kernel/fork.c b/kernel/fork.c
index bd7c218..096f9d8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1283,7 +1283,7 @@ static int wait_for_vfork_done(struct task_struct *child,
  * restoring the old one. . .
  * Eric Biederman 10 January 1998
  */
-void mm_release(struct task_struct *tsk, struct mm_struct *mm)
+static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	/* Get rid of any futexes when releasing the mm */
 	futex_mm_release(tsk);
@@ -1320,6 +1320,16 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 		complete_vfork_done(tsk);
 }
 
+void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
+void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm_release(tsk, mm);
+}
+
 /**
  * dup_mm() - duplicates an existing mm structure
  * @tsk: the task_struct with which the new mm will be associated.
