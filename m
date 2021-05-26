Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110B391140
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhEZHR4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 03:17:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhEZHRz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 03:17:55 -0400
Date:   Wed, 26 May 2021 07:16:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622013383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXiHf0c0cn4Kt1ZIBJQ7JRuAP5ixFIuY0yaPsrcQRMU=;
        b=zUaqO1+mcNXWI3RtMX17rLXa8hMlRUqvDckrkWsfUcbn39iv4gZWOTREoG0Y9e6K9USYQ+
        pEmN+t3Dov2VH1w0qyyz9R5tWeApM22rMQGrFp/IFT6eOiK5+mJwC0SGFjNidjIVyzs3eJ
        k2nSQLAG0VcYizoAWEMotuIurcoPj9wbuim9ShyX9q0hbXD17BVpS3p4x5z2koZ94fB4qG
        6eMicfyFG9QBb+gBjwRTxdCNrHrinASQuyQl7+IadQnp/ITYjrPE8fRvxkBYcuDlewlPdV
        EKmVelvA0Ba2rRk3mO+2RvFv/PikP57rmPK+plvr3KAB43G9E7wIzWbs+dTN1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622013383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXiHf0c0cn4Kt1ZIBJQ7JRuAP5ixFIuY0yaPsrcQRMU=;
        b=Hmsj3CqJkoalw6itCOeD7073VJtg1DBNJ4ROmpV46x7zfPyKWqD2U+K+qaAkoiDx/5nqSS
        cRS5xIElFGft2xAQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Stop PF_NO_SETAFFINITY from being inherited
 by various init system threads
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525235849.441842-1-frederic@kernel.org>
References: <20210525235849.441842-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162201338266.29796.17056048859247477492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a8ea6fc9b089156d9230bfeef964dd9be101a4a9
Gitweb:        https://git.kernel.org/tip/a8ea6fc9b089156d9230bfeef964dd9be101a4a9
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 26 May 2021 01:58:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 May 2021 08:58:53 +02:00

sched: Stop PF_NO_SETAFFINITY from being inherited by various init system threads

Commit:

  00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")

... added PF_KTHREAD | PF_NO_SETAFFINITY to the idle kernel threads.

Unfortunately these properties are inherited to the init/0 children
through kernel_thread() calls: init/1 and kthreadd. There are several
side effects to that:

1) kthreadd affinity can not be reset anymore from userspace. Also
   PF_NO_SETAFFINITY propagates to all kthreadd children, including
   the unbound kthreads Therefore it's not possible anymore to overwrite
   the affinity of any of them. Here is an example of warning reported
   by rcutorture:

		WARNING: CPU: 0 PID: 116 at kernel/rcu/tree_nocb.h:1306 rcu_bind_current_to_nocb+0x31/0x40
		Call Trace:
		 rcu_torture_fwd_prog+0x62/0x730
		 kthread+0x122/0x140
		 ret_from_fork+0x22/0x30

2) init/1 does an exec() in the end which clears both
   PF_KTHREAD and PF_NO_SETAFFINITY so we are fine once kernel_init()
   escapes to userspace. But until then, no initcall or init code can
   successfully call sched_setaffinity() to init/1.

   Also PF_KTHREAD looks legit on init/1 before it calls exec() but
   we better be careful with unknown introduced side effects.

One way to solve the PF_NO_SETAFFINITY issue is to not inherit this flag
on copy_process() at all. The cases where it matters are:

* fork_idle(): explicitly set the flag already.
* fork() syscalls: userspace tasks that shouldn't be concerned by that.
* create_io_thread(): the callers explicitly attribute the flag to the
                      newly created tasks.
* kernel_thread():
	- Fix the issues on init/1 and kthreadd
	- Fix the issues on kthreadd children.
	- Usermode helper created by an unbound workqueue. This shouldn't
	  matter. In the worst case it gives more control to userspace
	  on setting affinity to these short living tasks although this can
	  be tuned with inherited unbound workqueues affinity already.

Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20210525235849.441842-1-frederic@kernel.org
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ace4631..e595e77 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2000,7 +2000,7 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
+	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
