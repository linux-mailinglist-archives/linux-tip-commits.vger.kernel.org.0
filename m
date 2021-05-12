Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BDB37BA56
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELK3c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhELK3a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:30 -0400
Date:   Wed, 12 May 2021 10:28:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKj4s/2h/zoKBpQUjnXl+w1D+vQ/RabymJcO+lNmrsk=;
        b=a0H+dP9rksfs4XUGUCZ5liwu8lrSw/cJxepx9jdWS9YSILOKsDXMl7IivOYEtE1ikT5ONC
        Ee4v+ikttlpXps9fv1jtOxIPwIs0idt+eH6VmWTg0fpXoYmcsjgXMgIl5zAouleBNhHrxU
        PschMnhCYBFSnoaR/7pMVvKo0lDQoH9cM/X+Sax73zi+gFMhT4+9pRS8YS56SDXCf4O6K8
        OJA7tNjxPjBeDdi0b1gywaw8siJ0O8/x/tmg4PXVVzgrMs6mNvby+Cp/vu+qi2ewI+ghUX
        ++2hRbRErxpvlebHPdqCXgfTzKzRPr51+pnj58lCKRSe4TX1q4BiCi6dGHH3QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKj4s/2h/zoKBpQUjnXl+w1D+vQ/RabymJcO+lNmrsk=;
        b=ERjBmAzgMnIPVbrk8cujjHfkX/vcGnZQ8a/wGZXDY/hEP8aejvoJE/Jwipkzf41Xvd9BM4
        b/CSyBoy0LnQA8Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Inherit task cookie on fork()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.980003687@infradead.org>
References: <20210422123308.980003687@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530126.29796.16157476950875886548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     85dd3f61203c5cfa72b308ff327b5fbf3fc1ce5e
Gitweb:        https://git.kernel.org/tip/85dd3f61203c5cfa72b308ff327b5fbf3fc1ce5e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 29 Mar 2021 15:18:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:31 +02:00

sched: Inherit task cookie on fork()

Note that sched_core_fork() is called from under tasklist_lock, and
not from sched_fork() earlier. This avoids a few races later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.980003687@infradead.org
---
 include/linux/sched.h     | 2 ++
 kernel/fork.c             | 3 +++
 kernel/sched/core_sched.c | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eab3f7c..fba47e5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2181,8 +2181,10 @@ const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
+extern void sched_core_fork(struct task_struct *p);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
+static inline void sched_core_fork(struct task_struct *p) { }
 #endif
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index d16c60c..e7fd928 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2251,6 +2251,8 @@ static __latent_entropy struct task_struct *copy_process(
 
 	klp_copy_process(p);
 
+	sched_core_fork(p);
+
 	spin_lock(&current->sighand->siglock);
 
 	/*
@@ -2338,6 +2340,7 @@ static __latent_entropy struct task_struct *copy_process(
 	return p;
 
 bad_fork_cancel_cgroup:
+	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 8d0869a..dcbbeae 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -103,6 +103,12 @@ static unsigned long sched_core_clone_cookie(struct task_struct *p)
 	return cookie;
 }
 
+void sched_core_fork(struct task_struct *p)
+{
+	RB_CLEAR_NODE(&p->core_node);
+	p->core_cookie = sched_core_clone_cookie(current);
+}
+
 void sched_core_free(struct task_struct *p)
 {
 	sched_core_put_cookie(p->core_cookie);
