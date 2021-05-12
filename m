Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B577637EDE4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhELUz7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbhELUDH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 16:03:07 -0400
Date:   Wed, 12 May 2021 20:01:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620849706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3GfjciUuHctw4hx+yJNNp9+xYEKLhuvs6D678TbFDQ=;
        b=Zzh6YlGksa7d5QI43+plg+5F2RQiPmtaLRFCHFGJwYESeR/iUMHsA3xPevbBC7RtY71jvt
        UzYHUNAoCpRpDuI7nQBcl4s2MrNn8cEtdjfeBVVCiEXPLH4P6mIqKJQDsjffvF3O2KoYaz
        g7mwcEIOUcuuABB/ddl7Aaclo1pMlNprHFObx0jastnTOgDE4DDZF4RyLR95ro0Pq+XCBu
        YdBWaHu7bdBIfcpQel62pAFobiAgnSAnSwi0tzO8Nja6a0wUU29huk0nozQ/p31wHDqeBp
        9XlkHSdgksrkHAGfGXv3TJKkMui958pAr9S6scyy7aq2b999OMn27EIVxvIZOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620849706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3GfjciUuHctw4hx+yJNNp9+xYEKLhuvs6D678TbFDQ=;
        b=PSY/0JFPDL6B7LDD3JlJQ9Oe3+dUagYT9p1w5H7hpiWdPJi9xjP2KazRFjvqoQmMNxhu0B
        sLtLWF7/rP+QW6Cw==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make multiple runqueue task counters 32-bit
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422200228.1423391-4-adobriyan@gmail.com>
References: <20210422200228.1423391-4-adobriyan@gmail.com>
MIME-Version: 1.0
Message-ID: <162084970568.29796.11631457054332313096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e6fe3f422be128b7d65de607f6ae67bedc55f0ca
Gitweb:        https://git.kernel.org/tip/e6fe3f422be128b7d65de607f6ae67bedc55f0ca
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 22 Apr 2021 23:02:28 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 21:34:17 +02:00

sched: Make multiple runqueue task counters 32-bit

Make:

	struct dl_rq::dl_nr_migratory
	struct dl_rq::dl_nr_running

	struct rt_rq::rt_nr_boosted
	struct rt_rq::rt_nr_migratory
	struct rt_rq::rt_nr_total

	struct rq::nr_uninterruptible

32-bit.

If total number of tasks can't exceed 2**32 (and less due to futex pid
limits), then per-runqueue counters can't as well.

This patchset has been sponsored by REX Prefix Eradication Society.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210422200228.1423391-4-adobriyan@gmail.com
---
 kernel/sched/loadavg.c |  2 +-
 kernel/sched/sched.h   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 1c79896..954b229 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -81,7 +81,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (long)this_rq->nr_uninterruptible;
+	nr_active += (int)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 904c52b..8f0194c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -636,8 +636,8 @@ struct rt_rq {
 	} highest_prio;
 #endif
 #ifdef CONFIG_SMP
-	unsigned long		rt_nr_migratory;
-	unsigned long		rt_nr_total;
+	unsigned int		rt_nr_migratory;
+	unsigned int		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
 
@@ -651,7 +651,7 @@ struct rt_rq {
 	raw_spinlock_t		rt_runtime_lock;
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	unsigned long		rt_nr_boosted;
+	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
 	struct task_group	*tg;
@@ -668,7 +668,7 @@ struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
 	struct rb_root_cached	root;
 
-	unsigned long		dl_nr_running;
+	unsigned int		dl_nr_running;
 
 #ifdef CONFIG_SMP
 	/*
@@ -682,7 +682,7 @@ struct dl_rq {
 		u64		next;
 	} earliest_dl;
 
-	unsigned long		dl_nr_migratory;
+	unsigned int		dl_nr_migratory;
 	int			overloaded;
 
 	/*
@@ -960,7 +960,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long		nr_uninterruptible;
+	unsigned int		nr_uninterruptible;
 
 	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
