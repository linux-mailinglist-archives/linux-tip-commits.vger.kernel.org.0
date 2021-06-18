Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35E3AC9C1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhFRL0P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhFRL0O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:14 -0400
Date:   Fri, 18 Jun 2021 11:24:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVZLg8fmjHB0S2arhyQJRP9x6GTrH755/mwVbYBp7d0=;
        b=b+yrGuJ5gSMTJ89J1nH/RiV4t1PtxoezEZM6FMwtRThgeqWzwEFeD/z9iCyc0XWfL0Inyn
        Uj7wllibCOg5L5O/l041ew5BuwvAvBGYBlUikJEI6wtYPGcElgIN/TbiKsIAw5LgOlP5ID
        4nofuEEWhGfA/4ojRtECfQr7JYnLC1CpU+hfSe1+yRA7XrjKaTdIM3cD2P8E8u34y3CTeS
        U1kLd5hGm/SxCjyJ7OkqkLqCtyFshzKiHFF6mwkiyJ/EvW8oTSlSkD250q2OaawNn8QcYF
        f0Q2yFfyqD29CRhYc8IE5vLJ60NY3LTJaokHYqEce7g2dfyGKa3CfhB7TQwKSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EVZLg8fmjHB0S2arhyQJRP9x6GTrH755/mwVbYBp7d0=;
        b=DdhODpYp3+T7zGp0ctgHMBt+ycRJvGPN9IClhv4kLwZzwi5C6aUuvcaQOFEIBvsYi1R6LJ
        8VCRiy8pxXXfI/CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add get_current_state()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.347475156@infradead.org>
References: <20210611082838.347475156@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544338.19906.292740293969092340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d6c23bb3a2ad2f8f7dd46292b8bc54d27f2fb3f1
Gitweb:        https://git.kernel.org/tip/d6c23bb3a2ad2f8f7dd46292b8bc54d27f2fb3f1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:08 +02:00

sched: Add get_current_state()

Remove yet another few p->state accesses.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20210611082838.347475156@infradead.org
---
 block/blk-mq.c        | 2 +-
 include/linux/sched.h | 2 ++
 kernel/freezer.c      | 2 +-
 kernel/sched/core.c   | 6 +++---
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 655db5f..56270bb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3910,7 +3910,7 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 
 	hctx->poll_considered++;
 
-	state = current->state;
+	state = get_current_state();
 	do {
 		int ret;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2cd5635..395c890 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -213,6 +213,8 @@ struct task_group;
 
 #endif
 
+#define get_current_state()	READ_ONCE(current->state)
+
 /* Task command name length: */
 #define TASK_COMM_LEN			16
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f0..45ab36f 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -58,7 +58,7 @@ bool __refrigerator(bool check_kthr_stop)
 	/* Hmm, should we be allowed to suspend when there are realtime
 	   processes around? */
 	bool was_frozen = false;
-	long save = current->state;
+	unsigned int save = get_current_state();
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 618c2b5..45ebb3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9098,15 +9098,15 @@ static inline int preempt_count_equals(int preempt_offset)
 
 void __might_sleep(const char *file, int line, int preempt_offset)
 {
+	unsigned int state = get_current_state();
 	/*
 	 * Blocking primitives will set (and therefore destroy) current->state,
 	 * since we will exit with TASK_RUNNING make sure we enter with it,
 	 * otherwise we will destroy state.
 	 */
-	WARN_ONCE(current->state != TASK_RUNNING && current->task_state_change,
+	WARN_ONCE(state != TASK_RUNNING && current->task_state_change,
 			"do not call blocking ops when !TASK_RUNNING; "
-			"state=%lx set at [<%p>] %pS\n",
-			current->state,
+			"state=%x set at [<%p>] %pS\n", state,
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
