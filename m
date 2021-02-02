Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF630BBBA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhBBKFK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 05:05:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBBKEg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 05:04:36 -0500
Date:   Tue, 02 Feb 2021 10:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRlYEvuMy1ynxF5bxEF4a/gMATOZh4Nc6xuC2aUsC6k=;
        b=HJHp9z1huuOqvXqcBDXJVigiynPN1zXvVqo0VzvaWOuRVnWIcDJTxOIZog3CY2hvCpX05Q
        1qCgdarh1v7CicuXTzIn45j3EQBGGCv9dkMZvNlgtiBQtnxLxmSKMCJF+k9QhRRzey3Gvt
        qf14ozZ93OUVbF3eq/4C++yGtDo6qBj5+rYhhabX/aAs1rwzIv3Zrm+XtXyT2fJnmAXKo9
        BcUEA3aNR+AHTJSPgI4m0VwFkTyxFPGujsGt42wgY/MAdgfa68qPyvm4C81uEjjkzGLk+q
        Q4dCXg9tGTx9+nsXL+9bw4JZaA/AyjO4upP1kFvPO2HHum7GlXDVHugKmT0zjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612260233;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRlYEvuMy1ynxF5bxEF4a/gMATOZh4Nc6xuC2aUsC6k=;
        b=a1FKhKEbWwvv+a7+93wuRD8YUvkzFkvX+HG/fnw54qiJhJgfKeaZcwoqVIYTIePGNgXrMi
        e+CluaSImT+8FRBQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove MAX_USER_RT_PRIO
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-2-dietmar.eggemann@arm.com>
References: <20210128131040.296856-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161226023229.23325.8725751974683460180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4d38ea6a6d93115113fb4c023d5bb15e8ce1589c
Gitweb:        https://git.kernel.org/tip/4d38ea6a6d93115113fb4c023d5bb15e8ce1589c
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:39 +01:00

sched: Remove MAX_USER_RT_PRIO

Commit d46523ea32a7 ("[PATCH] fix MAX_USER_RT_PRIO and MAX_RT_PRIO")
was introduced due to a a small time period in which the realtime patch
set was using different values for MAX_USER_RT_PRIO and MAX_RT_PRIO.

This is no longer true, i.e. now MAX_RT_PRIO == MAX_USER_RT_PRIO.

Get rid of MAX_USER_RT_PRIO and make everything use MAX_RT_PRIO
instead.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-2-dietmar.eggemann@arm.com
---
 include/linux/sched/prio.h |  9 +--------
 kernel/sched/core.c        |  7 +++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index 7d64fea..d111f2f 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -11,16 +11,9 @@
  * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
  * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
  * values are inverted: lower p->prio value means higher priority.
- *
- * The MAX_USER_RT_PRIO value allows the actual maximum
- * RT priority to be separate from the value exported to
- * user-space.  This allows kernel threads to set their
- * priority to a value higher than any user task. Note:
- * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 
-#define MAX_USER_RT_PRIO	100
-#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define MAX_RT_PRIO		100
 
 #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 06b4499..625ec1e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5897,11 +5897,10 @@ recheck:
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
+	 * 1..MAX_RT_PRIO-1, valid priority for SCHED_NORMAL,
 	 * SCHED_BATCH and SCHED_IDLE is 0.
 	 */
-	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
-	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
+	if (attr->sched_priority > MAX_RT_PRIO-1)
 		return -EINVAL;
 	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
@@ -6969,7 +6968,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret = MAX_USER_RT_PRIO-1;
+		ret = MAX_RT_PRIO-1;
 		break;
 	case SCHED_DEADLINE:
 	case SCHED_NORMAL:
