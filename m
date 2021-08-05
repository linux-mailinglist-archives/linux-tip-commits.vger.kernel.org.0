Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A116B3E1165
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhHEJfA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbhHEJev (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC88C0613C1;
        Thu,  5 Aug 2021 02:34:37 -0700 (PDT)
Date:   Thu, 05 Aug 2021 09:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9WRBUMtBoYfXioaizP5f2jsYoHz9q8AWTTghhG/5Ew=;
        b=Lw+17yidTvh/eT9S3aSuZcqb92dPWGrmGwiyxTKjdnfSn7cj/JqAWRX5k4XWwP0YU/42JU
        pidzYgr4Lgm50FX+R/cKXsUkbdE2P/oqf9oEZrchb/UqzxRnWwzDqzPfkzJJYl6Wl6XP7u
        HNc27vORXN+IHEW4SayhP9zev7nuiouuVo7fe9qEMbbR8v9xG0NY5iIp09eCo+VsofGdtH
        eyw4pDR2RNVrOHicVA4imPHqaJAEvffgN057lth+4UpQoFydGto6xfLuYQkVLTKokuyvfi
        t5tdabWCIW/k8ZSrXYzUS7zZh89Iz9IU+GL6XWx6KTwiNtpYeGGmrgqw9i1L+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9WRBUMtBoYfXioaizP5f2jsYoHz9q8AWTTghhG/5Ew=;
        b=fDMEP2SytJcOcNua+UgRkV6BSy9jSY0teKT4u2JQ9wce4xhy9PErMmNz2QhdvktI/WZIG9
        /5G/Jv9btqxE86Cg==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix reset_on_fork reporting of DL tasks
Cc:     Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210727101103.2729607-2-qperret@google.com>
References: <20210727101103.2729607-2-qperret@google.com>
MIME-Version: 1.0
Message-ID: <162815607584.395.2105740795160497458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f95091536f78971b269ec321b057b8d630b0ad8a
Gitweb:        https://git.kernel.org/tip/f95091536f78971b269ec321b057b8d630b0ad8a
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Tue, 27 Jul 2021 11:11:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:43 +02:00

sched/deadline: Fix reset_on_fork reporting of DL tasks

It is possible for sched_getattr() to incorrectly report the state of
the reset_on_fork flag when called on a deadline task.

Indeed, if the flag was set on a deadline task using sched_setattr()
with flags (SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_KEEP_PARAMS), then
p->sched_reset_on_fork will be set, but __setscheduler() will bail out
early, which means that the dl_se->flags will not get updated by
__setscheduler_params()->__setparam_dl(). Consequently, if
sched_getattr() is then called on the task, __getparam_dl() will
override kattr.sched_flags with the now out-of-date copy in dl_se->flags
and report the stale value to userspace.

To fix this, make sure to only copy the flags that are relevant to
sched_deadline to and from the dl_se->flags field.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210727101103.2729607-2-qperret@google.com
---
 kernel/sched/deadline.c | 7 ++++---
 kernel/sched/sched.h    | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6c..5cafc64 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2741,7 +2741,7 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
 	dl_se->dl_runtime = attr->sched_runtime;
 	dl_se->dl_deadline = attr->sched_deadline;
 	dl_se->dl_period = attr->sched_period ?: dl_se->dl_deadline;
-	dl_se->flags = attr->sched_flags;
+	dl_se->flags = attr->sched_flags & SCHED_DL_FLAGS;
 	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
@@ -2754,7 +2754,8 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 	attr->sched_runtime = dl_se->dl_runtime;
 	attr->sched_deadline = dl_se->dl_deadline;
 	attr->sched_period = dl_se->dl_period;
-	attr->sched_flags = dl_se->flags;
+	attr->sched_flags &= ~SCHED_DL_FLAGS;
+	attr->sched_flags |= dl_se->flags;
 }
 
 /*
@@ -2851,7 +2852,7 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 	if (dl_se->dl_runtime != attr->sched_runtime ||
 	    dl_se->dl_deadline != attr->sched_deadline ||
 	    dl_se->dl_period != attr->sched_period ||
-	    dl_se->flags != attr->sched_flags)
+	    dl_se->flags != (attr->sched_flags & SCHED_DL_FLAGS))
 		return true;
 
 	return false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a1c6ae..75a5c12 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -227,6 +227,8 @@ static inline void update_avg(u64 *avg, u64 sample)
  */
 #define SCHED_FLAG_SUGOV	0x10000000
 
+#define SCHED_DL_FLAGS (SCHED_FLAG_RECLAIM | SCHED_FLAG_DL_OVERRUN | SCHED_FLAG_SUGOV)
+
 static inline bool dl_entity_is_special(struct sched_dl_entity *dl_se)
 {
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
