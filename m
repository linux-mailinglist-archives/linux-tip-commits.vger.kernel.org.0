Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1106574C3D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jul 2022 13:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiGNLfg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jul 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiGNLfg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5EA5A2DE;
        Thu, 14 Jul 2022 04:35:33 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657798532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dw5dKPMBF5qgiL0iVEeFmaNXlyBwXMe/WNaUeMeWCig=;
        b=AB1CtqAg02nkJfhKCJlYBhDZsFTOh+ZWV5O9JZouHgEhysqH0c4IdGSIT81QIiIpSMjxCU
        HBs7s6CkkzXWW+hWGte11Jd2DIueE0okrzXsT8IGcXENprtb8rIW7fZDrMqvgAwZoqfmoW
        fcIoe3CGEMgXu2CB5+04kpBifVlvaf2C0J0wukjvxDwIJADRJStIMhl2PO7RzOLvftUlYg
        ZBAaZboFNOQcJyi28no0vm/16eITQzpY108TqtB/vCnye+7YIdzQg5yRgfc+2tUEcbeyzy
        SQAjITj19Xjf1jGRnZ/xOqzPSGntK/4t0uUCbQlgRryg8msmdiiMAP5K7F8z8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657798532;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dw5dKPMBF5qgiL0iVEeFmaNXlyBwXMe/WNaUeMeWCig=;
        b=bkBgjlcQWZQ9X3mqQfCJ3NUzoHpsZK8KGuxjvRbjfVVyiZxwJBC7QqDxVNfKm0ZzLXeQ3V
        BaaxmjQKk0nar3Aw==
From:   "tip-bot2 for John Keeping" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Always flush pending blk_plug
Cc:     John Keeping <john@metanate.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220708162702.1758865-1-john@metanate.com>
References: <20220708162702.1758865-1-john@metanate.com>
MIME-Version: 1.0
Message-ID: <165779853104.15455.16915451211318324333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     401e4963bf45c800e3e9ea0d3a0289d738005fd4
Gitweb:        https://git.kernel.org/tip/401e4963bf45c800e3e9ea0d3a0289d738005fd4
Author:        John Keeping <john@metanate.com>
AuthorDate:    Fri, 08 Jul 2022 17:27:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 13 Jul 2022 11:29:17 +02:00

sched/core: Always flush pending blk_plug

With CONFIG_PREEMPT_RT, it is possible to hit a deadlock between two
normal priority tasks (SCHED_OTHER, nice level zero):

	INFO: task kworker/u8:0:8 blocked for more than 491 seconds.
	      Not tainted 5.15.49-rt46 #1
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	task:kworker/u8:0    state:D stack:    0 pid:    8 ppid:     2 flags:0x00000000
	Workqueue: writeback wb_workfn (flush-7:0)
	[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
	[<c08a3d84>] (schedule) from [<c08a65a0>] (rt_mutex_slowlock_block.constprop.0+0xb8/0x174)
	[<c08a65a0>] (rt_mutex_slowlock_block.constprop.0) from [<c08a6708>]
	+(rt_mutex_slowlock.constprop.0+0xac/0x174)
	[<c08a6708>] (rt_mutex_slowlock.constprop.0) from [<c0374d60>] (fat_write_inode+0x34/0x54)
	[<c0374d60>] (fat_write_inode) from [<c0297304>] (__writeback_single_inode+0x354/0x3ec)
	[<c0297304>] (__writeback_single_inode) from [<c0297998>] (writeback_sb_inodes+0x250/0x45c)
	[<c0297998>] (writeback_sb_inodes) from [<c0297c20>] (__writeback_inodes_wb+0x7c/0xb8)
	[<c0297c20>] (__writeback_inodes_wb) from [<c0297f24>] (wb_writeback+0x2c8/0x2e4)
	[<c0297f24>] (wb_writeback) from [<c0298c40>] (wb_workfn+0x1a4/0x3e4)
	[<c0298c40>] (wb_workfn) from [<c0138ab8>] (process_one_work+0x1fc/0x32c)
	[<c0138ab8>] (process_one_work) from [<c0139120>] (worker_thread+0x22c/0x2d8)
	[<c0139120>] (worker_thread) from [<c013e6e0>] (kthread+0x16c/0x178)
	[<c013e6e0>] (kthread) from [<c01000fc>] (ret_from_fork+0x14/0x38)
	Exception stack(0xc10e3fb0 to 0xc10e3ff8)
	3fa0:                                     00000000 00000000 00000000 00000000
	3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
	3fe0: 00000000 00000000 00000000 00000000 00000013 00000000

	INFO: task tar:2083 blocked for more than 491 seconds.
	      Not tainted 5.15.49-rt46 #1
	"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
	task:tar             state:D stack:    0 pid: 2083 ppid:  2082 flags:0x00000000
	[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
	[<c08a3d84>] (schedule) from [<c08a41b0>] (io_schedule+0x14/0x24)
	[<c08a41b0>] (io_schedule) from [<c08a455c>] (bit_wait_io+0xc/0x30)
	[<c08a455c>] (bit_wait_io) from [<c08a441c>] (__wait_on_bit_lock+0x54/0xa8)
	[<c08a441c>] (__wait_on_bit_lock) from [<c08a44f4>] (out_of_line_wait_on_bit_lock+0x84/0xb0)
	[<c08a44f4>] (out_of_line_wait_on_bit_lock) from [<c0371fb0>] (fat_mirror_bhs+0xa0/0x144)
	[<c0371fb0>] (fat_mirror_bhs) from [<c0372a68>] (fat_alloc_clusters+0x138/0x2a4)
	[<c0372a68>] (fat_alloc_clusters) from [<c0370b14>] (fat_alloc_new_dir+0x34/0x250)
	[<c0370b14>] (fat_alloc_new_dir) from [<c03787c0>] (vfat_mkdir+0x58/0x148)
	[<c03787c0>] (vfat_mkdir) from [<c0277b60>] (vfs_mkdir+0x68/0x98)
	[<c0277b60>] (vfs_mkdir) from [<c027b484>] (do_mkdirat+0xb0/0xec)
	[<c027b484>] (do_mkdirat) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)
	Exception stack(0xc2e1bfa8 to 0xc2e1bff0)
	bfa0:                   01ee42f0 01ee4208 01ee42f0 000041ed 00000000 00004000
	bfc0: 01ee42f0 01ee4208 00000000 00000027 01ee4302 00000004 000dcb00 01ee4190
	bfe0: 000dc368 bed11924 0006d4b0 b6ebddfc

Here the kworker is waiting on msdos_sb_info::s_lock which is held by
tar which is in turn waiting for a buffer which is locked waiting to be
flushed, but this operation is plugged in the kworker.

The lock is a normal struct mutex, so tsk_is_pi_blocked() will always
return false on !RT and thus the behaviour changes for RT.

It seems that the intent here is to skip blk_flush_plug() in the case
where a non-preemptible lock (such as a spinlock) has been converted to
a rtmutex on RT, which is the case covered by the SM_RTLOCK_WAIT
schedule flag.  But sched_submit_work() is only called from schedule()
which is never called in this scenario, so the check can simply be
deleted.

Looking at the history of the -rt patchset, in fact this change was
present from v5.9.1-rt20 until being dropped in v5.13-rt1 as it was part
of a larger patch [1] most of which was replaced by commit b4bfa3fcfe3b
("sched/core: Rework the __schedule() preempt argument").

As described in [1]:

   The schedule process must distinguish between blocking on a regular
   sleeping lock (rwsem and mutex) and a RT-only sleeping lock (spinlock
   and rwlock):
   - rwsem and mutex must flush block requests (blk_schedule_flush_plug())
     even if blocked on a lock. This can not deadlock because this also
     happens for non-RT.
     There should be a warning if the scheduling point is within a RCU read
     section.

   - spinlock and rwlock must not flush block requests. This will deadlock
     if the callback attempts to acquire a lock which is already acquired.
     Similarly to being preempted, there should be no warning if the
     scheduling point is within a RCU read section.

and with the tsk_is_pi_blocked() in the scheduler path, we hit the first
issue.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0022-locking-rtmutex-Use-custom-scheduling-function-for-s.patch?h=linux-5.10.y-rt-patches

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20220708162702.1758865-1-john@metanate.com
---
 include/linux/sched/rt.h | 8 --------
 kernel/sched/core.c      | 8 ++++++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index e5af028..994c256 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -39,20 +39,12 @@ static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *p)
 }
 extern void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return tsk->pi_blocked_on != NULL;
-}
 #else
 static inline struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
 	return NULL;
 }
 # define rt_mutex_adjust_pi(p)		do { } while (0)
-static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
-{
-	return false;
-}
 #endif
 
 extern void normalize_rt_tasks(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c703d17..a463dbc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6470,8 +6470,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 			io_wq_worker_sleeping(tsk);
 	}
 
-	if (tsk_is_pi_blocked(tsk))
-		return;
+	/*
+	 * spinlock and rwlock must not flush block requests.  This will
+	 * deadlock if the callback attempts to acquire a lock which is
+	 * already acquired.
+	 */
+	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
 
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
