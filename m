Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0847A2D4953
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbgLISqD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLISqB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:46:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB307C0617A7;
        Wed,  9 Dec 2020 10:44:42 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oXlGArNIcJiVj/apzfam6J6e9UjkwrUOdyJf3vg2ulU=;
        b=cHpiBn0oGmcrfAUx047u1XEF9gb0Fu+bRDl9OE/uTuaw1OD0aHA9dcdzAJbDHt4GCHQGEN
        t4pQj7SOMv2O7iIyPn5hf2ANgwAe7aB9Jgb5f+zqVZP8/xUXojiG1m3bzC41XjyAjLi8GA
        vsHPyTYHHYQCtzCCswaXLHMseKsxfRsWQZk354PWdimp6iFdvhMz7wTj4qlYK7ZB3GR4Gs
        g+lKb/EVbF1rxlCrSLE5BYVyMPlQeC8dWx+n9WkN/0KK6I3H7Z4vmivbT5Gm9AZitpFEQo
        zm9Osb8so3pEErLBOMEJg71QaFAVJk/TFMLmz67yzC4QjHe+HLFft3yg90Io9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oXlGArNIcJiVj/apzfam6J6e9UjkwrUOdyJf3vg2ulU=;
        b=cuHc9/OD3BQ0qbO3ylofRGng81Seprdby+GohHxGhDpoMqlsdtZ2wZxSa0Kv4UM9qIyF70
        KRYOpDtOthyzyZCg==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Break deadlock involving exec_update_mutex
Cc:     syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160753948058.3364.18125735729862993179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     78af4dc949daaa37b3fcd5f348f373085b4e858f
Gitweb:        https://git.kernel.org/tip/78af4dc949daaa37b3fcd5f348f373085b4e858f
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Fri, 28 Aug 2020 14:37:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:57 +01:00

perf: Break deadlock involving exec_update_mutex

Syzbot reported a lock inversion involving perf. The sore point being
perf holding exec_update_mutex() for a very long time, specifically
across a whole bunch of filesystem ops in pmu::event_init() (uprobes)
and anon_inode_getfile().

This then inverts against procfs code trying to take
exec_update_mutex.

Move the permission checks later, such that we need to hold the mutex
over less code.

Reported-by: syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a21b0be..19ae6c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11832,24 +11832,6 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_task;
 	}
 
-	if (task) {
-		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
-		if (err)
-			goto err_task;
-
-		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
-		 * We must hold exec_update_mutex across this and any potential
-		 * perf_install_in_context() call for this new event to
-		 * serialize against exec() altering our credentials (and the
-		 * perf_event_exit_task() that could imply).
-		 */
-		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
-			goto err_cred;
-	}
-
 	if (flags & PERF_FLAG_PID_CGROUP)
 		cgroup_fd = pid;
 
@@ -11857,7 +11839,7 @@ SYSCALL_DEFINE5(perf_event_open,
 				 NULL, NULL, cgroup_fd);
 	if (IS_ERR(event)) {
 		err = PTR_ERR(event);
-		goto err_cred;
+		goto err_task;
 	}
 
 	if (is_sampling_event(event)) {
@@ -11976,6 +11958,24 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_context;
 	}
 
+	if (task) {
+		err = mutex_lock_interruptible(&task->signal->exec_update_mutex);
+		if (err)
+			goto err_file;
+
+		/*
+		 * Preserve ptrace permission check for backwards compatibility.
+		 *
+		 * We must hold exec_update_mutex across this and any potential
+		 * perf_install_in_context() call for this new event to
+		 * serialize against exec() altering our credentials (and the
+		 * perf_event_exit_task() that could imply).
+		 */
+		err = -EACCES;
+		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+			goto err_cred;
+	}
+
 	if (move_group) {
 		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
 
@@ -12151,7 +12151,10 @@ err_locked:
 	if (move_group)
 		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
-/* err_file: */
+err_cred:
+	if (task)
+		mutex_unlock(&task->signal->exec_update_mutex);
+err_file:
 	fput(event_file);
 err_context:
 	perf_unpin_context(ctx);
@@ -12163,9 +12166,6 @@ err_alloc:
 	 */
 	if (!event_file)
 		free_event(event);
-err_cred:
-	if (task)
-		mutex_unlock(&task->signal->exec_update_mutex);
 err_task:
 	if (task)
 		put_task_struct(task);
