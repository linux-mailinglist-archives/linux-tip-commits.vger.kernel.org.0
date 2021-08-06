Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC453E2B00
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Aug 2021 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbhHFM6I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Aug 2021 08:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbhHFM6H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Aug 2021 08:58:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A294C061798;
        Fri,  6 Aug 2021 05:57:52 -0700 (PDT)
Date:   Fri, 06 Aug 2021 12:57:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628254670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXnRYru3PUT2Wn4h1hMFC8JEYKBY4GGgj5noxIzwVo0=;
        b=RoGkc6wtChXUUMNq1vuFxFhGeU7cdO9yJupxDPwE963fD9WaORrFU7eQEP+Ll9VChds1tj
        5wxn014vopQx1GIxS6PP/tEEwWPeX5n9OiGicJEvdc+p+mrbrfzUjJHX2S0k5StZ+ht/Up
        Tss4S+x7Ux72OSg/s+/dJoTuvFBEl4tOQTDr+Vppf9Z2U72fV+Gk90IxBunJoovpaM9iT9
        WjCrqPw/Zmvl38Q0utP4367zSYkam59eKtrr0rBpp9UwH1h1CyyYlmQjyVT4MAy9vNvKUm
        AT3vIPViVgrbLKQrpsAYnr++rybKVdgv923wldsfeA9rVbWQSSMbxB8EGC4S6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628254670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXnRYru3PUT2Wn4h1hMFC8JEYKBY4GGgj5noxIzwVo0=;
        b=8T5GxpRNCQ2rL5no9RtTbBkdHMJvHaUCKYjh7Ruw8Jrj30GjwvkvwqpFXzXpk9KnamjwqN
        3eNkNiPlG3wmMzDw==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
Cc:     Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210805102154.590709-3-qperret@google.com>
References: <20210805102154.590709-3-qperret@google.com>
MIME-Version: 1.0
Message-ID: <162825466988.395.169396099784504532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f4dddf90d58d77b48492b775868af4041a217f4c
Gitweb:        https://git.kernel.org/tip/f4dddf90d58d77b48492b775868af4041a217f4c
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Thu, 05 Aug 2021 11:21:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Aug 2021 14:25:25 +02:00

sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS

SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
the call must not touch scheduling parameters (nice or priority). This
is particularly handy for uclamp when used in conjunction with
SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
impacts uclamp values.

However, sched_setattr always checks whether the priorities and nice
values passed in sched_attr are valid first, even if those never get
used down the line. This is useless at best since userspace can
trivially bypass this check to set the uclamp values by specifying low
priorities. However, it is cumbersome to do so as there is no single
expression of this that skips both RT and CFS checks at once. As such,
userspace needs to query the task policy first with e.g. sched_getattr
and then set sched_attr.sched_priority accordingly. This is racy and
slower than a single call.

As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
is specified, simply inherit them in this case to match the policy
inheritance of SCHED_FLAG_KEEP_POLICY.

Reported-by: Wei Wang <wvw@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lore.kernel.org/r/20210805102154.590709-3-qperret@google.com
---
 kernel/sched/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df0480a..433b400 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7328,6 +7328,16 @@ err_size:
 	return -E2BIG;
 }
 
+static void get_params(struct task_struct *p, struct sched_attr *attr)
+{
+	if (task_has_dl_policy(p))
+		__getparam_dl(p, attr);
+	else if (task_has_rt_policy(p))
+		attr->sched_priority = p->rt_priority;
+	else
+		attr->sched_nice = task_nice(p);
+}
+
 /**
  * sys_sched_setscheduler - set/change the scheduler policy and RT priority
  * @pid: the pid in question.
@@ -7389,6 +7399,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_unlock();
 
 	if (likely(p)) {
+		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+			get_params(p, &attr);
 		retval = sched_setattr(p, &attr);
 		put_task_struct(p);
 	}
@@ -7537,12 +7549,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	kattr.sched_policy = p->policy;
 	if (p->sched_reset_on_fork)
 		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-	if (task_has_dl_policy(p))
-		__getparam_dl(p, &kattr);
-	else if (task_has_rt_policy(p))
-		kattr.sched_priority = p->rt_priority;
-	else
-		kattr.sched_nice = task_nice(p);
+	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
