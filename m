Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 798E11036C9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 10:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfKTJio (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 04:38:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfKTJii (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 04:38:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXMRR-0003yj-NB; Wed, 20 Nov 2019 10:38:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 292C81C1A01;
        Wed, 20 Nov 2019 10:38:26 +0100 (CET)
Date:   Wed, 20 Nov 2019 09:38:26 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Split futex_mm_release() for exit/exec
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.332094221@linutronix.de>
References: <20191106224556.332094221@linutronix.de>
MIME-Version: 1.0
Message-ID: <157424270611.12247.2096187298144761175.tip-bot2@tip-bot2>
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

Commit-ID:     150d71584b12809144b8145b817e83b81158ae5f
Gitweb:        https://git.kernel.org/tip/150d71584b12809144b8145b817e83b81158ae5f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Nov 2019 09:40:08 +01:00

futex: Split futex_mm_release() for exit/exec

To allow separate handling of the futex exit state in the futex exit code
for exit and exec, split futex_mm_release() into two functions and invoke
them from the corresponding exit/exec_mm_release() callsites.

Preparatory only, no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.332094221@linutronix.de


---
 include/linux/futex.h | 6 ++++--
 kernel/fork.c         | 5 ++---
 kernel/futex.c        | 7 ++++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 025ad96..6414cfa 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -93,14 +93,16 @@ static inline void futex_exit_done(struct task_struct *tsk)
 	tsk->futex_state = FUTEX_STATE_DEAD;
 }
 
-void futex_mm_release(struct task_struct *tsk);
+void futex_exit_release(struct task_struct *tsk);
+void futex_exec_release(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
-static inline void futex_mm_release(struct task_struct *tsk) { }
 static inline void futex_exit_done(struct task_struct *tsk) { }
+static inline void futex_exit_release(struct task_struct *tsk) { }
+static inline void futex_exec_release(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
diff --git a/kernel/fork.c b/kernel/fork.c
index 096f9d8..f1eb4d1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1285,9 +1285,6 @@ static int wait_for_vfork_done(struct task_struct *child,
  */
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
-	/* Get rid of any futexes when releasing the mm */
-	futex_mm_release(tsk);
-
 	uprobe_free_utask(tsk);
 
 	/* Get rid of any cached register state */
@@ -1322,11 +1319,13 @@ static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 
 void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	futex_exit_release(tsk);
 	mm_release(tsk, mm);
 }
 
 void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
+	futex_exec_release(tsk);
 	mm_release(tsk, mm);
 }
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 41c7527..909e4d3 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3661,7 +3661,7 @@ static void exit_robust_list(struct task_struct *curr)
 	}
 }
 
-void futex_mm_release(struct task_struct *tsk)
+void futex_exec_release(struct task_struct *tsk)
 {
 	if (unlikely(tsk->robust_list)) {
 		exit_robust_list(tsk);
@@ -3679,6 +3679,11 @@ void futex_mm_release(struct task_struct *tsk)
 		exit_pi_state_list(tsk);
 }
 
+void futex_exit_release(struct task_struct *tsk)
+{
+	futex_exec_release(tsk);
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
