Return-Path: <linux-tip-commits+bounces-3144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28489FC189
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AFD1883989
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84C21480D;
	Tue, 24 Dec 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6QmDXrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXIWsLBe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D542135A2;
	Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066486; cv=none; b=DMmZiXIg2shi1w+KzfDUvsJlavICuT6nFfTdWevJ9opfQrW6TU6wOsBfC0//4y/DlDhWq7yMDjtki2F6i5WmBaze0mlaUGwd1W0XJH+9EajB1ZjZc4KTxW1mewAJJN4NSeMys7fiF1lZ287fqyOu3JPPDAYbFzfV6cgojAKznnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066486; c=relaxed/simple;
	bh=/lkUmpEQcT/p/QCzHFfwVg11mCCtOrdrw/mpKcJUgkI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WzURYaLWVWIkvnCpO4mRlNfVfoYk+2LJ5Lp0qEYT0FLGlAVDbYa0BHYgwaj1Q8iJz/FNn2KLywcWP9i+ix0fAr29+UcNc2ggT0RCklC2S+JoN4aZ3E0wWTCWrpYyUN9exb1qCJPLHvA10eus/IwWu4plS+qZfW/x8Ycg2FgL760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6QmDXrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXIWsLBe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIasyv+7AM+SUIOcxIg3/sxYbxXRkWAIPoV2BxDz2eo=;
	b=Y6QmDXrYj5FU99/tvGSIsvqp0rxpUlTqWLfRUTmO7qUj1cnlmu2gX7hxcVBZG/mrbh3sW1
	bcgzix94U3uy9r60DvL3O6zvw9REsi4S0N5zmvYAMVpdIe0D7sSHtaQxvIk9U35rm3DH/s
	2IIUtwQTzs2SQZU7MJtdeYli8EsJkAkIjiAd2d5sY066FVW/BsmwceiZYIfGh2ZlpDD3OB
	nm7JxKLpXnAofmKt1RogCNzaTmUoIHRXgtFyU6sRFusNOO62AXFFxIFJY2/EdudxqYBpe/
	hZLlsbtHT9YekaczW9KjB22/OQU7nunFvQB9vzbc5rzs5htftBbehm98WNELKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIasyv+7AM+SUIOcxIg3/sxYbxXRkWAIPoV2BxDz2eo=;
	b=QXIWsLBedl5QDDlAH28NSmACkuCB1L2cCsm53yaP3vbZa/YMhhZequx+y+v0z8qUF3jVzC
	GB2Z09SCiNpiUfDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix value reported by hot tasks pulled
 in /proc/schedstat
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-2-swapnil.sapkal@amd.com>
References: <20241220063224.17767-2-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506648128.399.9013463536765879031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a430d99e349026d53e2557b7b22bd2ebd61fe12a
Gitweb:        https://git.kernel.org/tip/a430d99e349026d53e2557b7b22bd2ebd61fe12a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Dec 2024 06:32:19 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:16 +01:00

sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat

In /proc/schedstat, lb_hot_gained reports the number hot tasks pulled
during load balance. This value is incremented in can_migrate_task()
if the task is migratable and hot. After incrementing the value,
load balancer can still decide not to migrate this task leading to wrong
accounting. Fix this by incrementing stats when hot tasks are detached.
This issue only exists in detach_tasks() where we can decide to not
migrate hot task even if it is migratable. However, in detach_one_task(),
we migrate it unconditionally.

[Swapnil: Handled the case where nr_failed_migrations_hot was not accounted properly and wrote commit log]

Fixes: d31980846f96 ("sched: Move up affinity check to mitigate useless redoing overhead")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241220063224.17767-2-swapnil.sapkal@amd.com
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b5916be..8c6a2ed 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -937,6 +937,7 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
+	unsigned			sched_task_hot:1;
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae8095a..8fc6648 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9396,6 +9396,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	int tsk_cache_hot;
 
 	lockdep_assert_rq_held(env->src_rq);
+	if (p->sched_task_hot)
+		p->sched_task_hot = 0;
 
 	/*
 	 * We do not migrate tasks that are:
@@ -9472,10 +9474,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	if (tsk_cache_hot <= 0 ||
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1) {
-			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->stats.nr_forced_migrations);
-		}
+		if (tsk_cache_hot == 1)
+			p->sched_task_hot = 1;
 		return 1;
 	}
 
@@ -9490,6 +9490,12 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	if (p->sched_task_hot) {
+		p->sched_task_hot = 0;
+		schedstat_inc(env->sd->lb_hot_gained[env->idle]);
+		schedstat_inc(p->stats.nr_forced_migrations);
+	}
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
@@ -9650,6 +9656,9 @@ static int detach_tasks(struct lb_env *env)
 
 		continue;
 next:
+		if (p->sched_task_hot)
+			schedstat_inc(p->stats.nr_failed_migrations_hot);
+
 		list_move(&p->se.group_node, tasks);
 	}
 

