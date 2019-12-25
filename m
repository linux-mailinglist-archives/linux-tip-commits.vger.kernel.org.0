Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F112A781
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Dec 2019 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLYKjH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Dec 2019 05:39:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfLYKjG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44D-0008Bh-Ss; Wed, 25 Dec 2019 11:39:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 976021C2B24;
        Wed, 25 Dec 2019 11:39:01 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:01 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove unused variable from set_user_nice()
Cc:     Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191219140314.1252-1-cai@lca.pw>
References: <20191219140314.1252-1-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <157727034142.30329.18157750547564791762.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     53a23364b6b0c679a8ecfc48e74d652f18e3631f
Gitweb:        https://git.kernel.org/tip/53a23364b6b0c679a8ecfc48e74d652f18e3631f
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Thu, 19 Dec 2019 09:03:14 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:06 +01:00

sched/core: Remove unused variable from set_user_nice()

This commit left behind an unused variable:

  5443a0be6121 ("sched: Use fair:prio_changed() instead of ad-hoc implementation") left behind an unused variable.

  kernel/sched/core.c: In function 'set_user_nice':
  kernel/sched/core.c:4507:16: warning: variable 'delta' set but not used
    int old_prio, delta;
                ^~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 5443a0be6121 ("sched: Use fair:prio_changed() instead of ad-hoc implementation")
Link: https://lkml.kernel.org/r/20191219140314.1252-1-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15508c2..1f6c094 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4504,7 +4504,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio, delta;
+	int old_prio;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -4538,7 +4538,6 @@ void set_user_nice(struct task_struct *p, long nice)
 	set_load_weight(p, true);
 	old_prio = p->prio;
 	p->prio = effective_prio(p);
-	delta = p->prio - old_prio;
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
