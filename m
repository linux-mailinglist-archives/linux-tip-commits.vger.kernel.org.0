Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654FA86074
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfHHK4p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:56:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfHHK4o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:56:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AuUBs3127504
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:56:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AuUBs3127504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261790;
        bh=roVLySAD0N/pZmT2piLY3SP6E2Nwc2F6XVYG7/bN4kI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Z5PyraY5oPcAoX8/i+Hwzf8S05hFWG/KY38K4nl/UBnmQnz3lMCb8LjMQmClil2Ou
         IXOJx0rHefitV28VLtF+i8GpLJvlXaSDJcc2y8w306e745m00nJ4A659Eddn1X9HiD
         MjHpLA+hkx7OCkHIgfC7yD4gm2wGKk/AMobp/Qtk3wIAeC0n+Rp/XWjYMsru39em1S
         2uULe2UC3xrjtnzyDZHG0IbgLZOxQ03LpMkUFlS1tK3YjfdnxRlglmmf8LDDxMVxgH
         CqwLAkK//MQE+FDjlCFMmklefrbZQCj6p0MI+BzVERTeN1uEBIIyb7B3O0iPo9xD/z
         4GFfH5Vv/vD/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AuThr3127501;
        Thu, 8 Aug 2019 03:56:29 -0700
Date:   Thu, 8 Aug 2019 03:56:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-10e7071b2f491b0fb981717ea0a585c441906ede@git.kernel.org>
Cc:     aaron.lwe@gmail.com, peterz@infradead.org, hpa@zytor.com,
        naravamudan@digitalocean.com, valentin.schneider@arm.com,
        pauld@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        jdesfossez@digitalocean.com
Reply-To: jdesfossez@digitalocean.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, pauld@redhat.com,
          naravamudan@digitalocean.com, valentin.schneider@arm.com,
          hpa@zytor.com, aaron.lwe@gmail.com, peterz@infradead.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Rework CPU hotplug task selection
Git-Commit-ID: 10e7071b2f491b0fb981717ea0a585c441906ede
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  10e7071b2f491b0fb981717ea0a585c441906ede
Gitweb:     https://git.kernel.org/tip/10e7071b2f491b0fb981717ea0a585c441906ede
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 6 Aug 2019 15:13:17 +0200
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

sched: Rework CPU hotplug task selection

The CPU hotplug task selection is the only place where we used
put_prev_task() on a task that is not current. While looking at that,
it occured to me that we can simplify all that by by using a custom
pick loop.

Since we don't need to put current, we can do away with the fake task
too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
---
 kernel/sched/core.c  | 32 ++++++++++++++------------------
 kernel/sched/sched.h |  1 +
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a821ff68502..364b6d7da2be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6082,21 +6082,22 @@ static void calc_load_migrate(struct rq *rq)
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
-static void put_prev_task_fake(struct rq *rq, struct task_struct *prev)
+static struct task_struct *__pick_migrate_task(struct rq *rq)
 {
-}
+	const struct sched_class *class;
+	struct task_struct *next;
 
-static const struct sched_class fake_sched_class = {
-	.put_prev_task = put_prev_task_fake,
-};
+	for_each_class(class) {
+		next = class->pick_next_task(rq, NULL, NULL);
+		if (next) {
+			next->sched_class->put_prev_task(rq, next);
+			return next;
+		}
+	}
 
-static struct task_struct fake_task = {
-	/*
-	 * Avoid pull_{rt,dl}_task()
-	 */
-	.prio = MAX_PRIO + 1,
-	.sched_class = &fake_sched_class,
-};
+	/* The idle class should always have a runnable task */
+	BUG();
+}
 
 /*
  * Migrate all tasks from the rq, sleeping tasks will be migrated by
@@ -6139,12 +6140,7 @@ static void migrate_tasks(struct rq *dead_rq, struct rq_flags *rf)
 		if (rq->nr_running == 1)
 			break;
 
-		/*
-		 * pick_next_task() assumes pinned rq->lock:
-		 */
-		next = pick_next_task(rq, &fake_task, rf);
-		BUG_ON(!next);
-		put_prev_task(rq, next);
+		next = __pick_migrate_task(rq);
 
 		/*
 		 * Rules for changing task_struct::cpus_mask are holding
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ea48aa5daeee..b3449d0dd7f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1751,6 +1751,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
+	WARN_ON_ONCE(rq->curr != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
