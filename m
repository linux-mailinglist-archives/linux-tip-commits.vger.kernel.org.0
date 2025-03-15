Return-Path: <linux-tip-commits+bounces-4227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B5A62A48
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Mar 2025 10:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB5189D240
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Mar 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF771F583A;
	Sat, 15 Mar 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xhUvxzkX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5EGw7KYZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625178F5F;
	Sat, 15 Mar 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031433; cv=none; b=JdCT74ePrUoFzJcZ4cWXx49LztKCurP+OUyDUkl7yiE6OdD/RNQm1345as1CBZY6vVPjg4sFQkXrIQe2VG99CbTKSToLt8hrtIDcbpI0CW80wEaJGp8bLFsZG4vqwWGds921yK3TX5JVnSVIMqFzJMWo/5+eYQEEGdPclv0zMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031433; c=relaxed/simple;
	bh=j/XbGS7DHxjNTQcEmHqHWroYgjesa0I7mYD6mVPAnw0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EVpedCpbKB3WpzyY1BVwUwHTN1ZF9MRs0mJTdeKYhy6YmnHutNSUBt2O/9MlViEIZOIBqOXi/ohDge3btiXlMSthexdebTK4VGxwaZ3DMICiDn1/3AWu2CZLEfdnMAMG8WDoXtIcfoaITZxB+yWLhrgh2+C3o4STHz7Hnl8vo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xhUvxzkX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5EGw7KYZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Mar 2025 09:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742031428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MRsn09X8BiG7g2rllk6FDJI4fvuUBBTbPNjj2Ctieo=;
	b=xhUvxzkX8WNwDJPHeVHT3O7JaVXjNNyMPQ8JZE/dGypczZL3/3lons56y12ttPkVjyp4nO
	SsBjV8EW1HFpG2dUMv3nml27FCueNUL61aXqGtXk60UotUusVoXiYFNIQS5Y+rX8EbMVcZ
	9JbQlKiMveocg7DJ7gsduHaSOJtVqd+c1/5ccTKkvjD+fqUAWZ9rsJbpje8AE6nC8g8o96
	M3xQc1erQFxJKxqumzyQUPjzKaatIjEMLgf+OOIaOh1L7XoEvpPubYaCYzlYbd7BoQHWoo
	rw5Sb3Pg6oYZwN6Xk+1Wdvc9A4i5LEANXrPw4RUXynirxwc6vobO/iJtzhn6AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742031428;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MRsn09X8BiG7g2rllk6FDJI4fvuUBBTbPNjj2Ctieo=;
	b=5EGw7KYZtauqyCUin8i8P57wEEzOw2l0ebQiMYt9Hr6St809NLNVC54VD1mIRnnT7bTsiq
	bTUOU7uEl3R94CBg==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Optimize sched_uclamp_used static key
 enabling
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219093747.2612-2-xuewen.yan@unisoc.com>
References: <20250219093747.2612-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174203142298.14745.10610106009885438181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4bc45824149ea83a1e293c674e7f542b8127afb6
Gitweb:        https://git.kernel.org/tip/4bc45824149ea83a1e293c674e7f542b8127afb6
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Wed, 19 Feb 2025 17:37:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Mar 2025 10:28:50 +01:00

sched/uclamp: Optimize sched_uclamp_used static key enabling

Repeat calls of static_branch_enable() to an already enabled
static key introduce overhead, because it calls cpus_read_lock().

Users may frequently set the uclamp value of tasks, triggering
the repeat enabling of the sched_uclamp_used static key.

Optimize this and avoid repeat calls to static_branch_enable()
by checking whether it's enabled already.

[ mingo: Rewrote the changelog for legibility ]

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250219093747.2612-2-xuewen.yan@unisoc.com
---
 kernel/sched/core.c     |  6 +++---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/syscalls.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45daa41..03d7b63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1941,12 +1941,12 @@ static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
 	}
 
 	if (update_root_tg) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_update_root_tg();
 	}
 
 	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_sync_util_min_rt_default();
 	}
 
@@ -9294,7 +9294,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	guard(mutex)(&uclamp_mutex);
 	guard(rcu)();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8d42d3c..0212a0c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3407,6 +3407,18 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+/*
+ * Enabling static branches would get the cpus_read_lock(),
+ * check whether uclamp_is_used before enable it to avoid always
+ * calling cpus_read_lock(). Because we never disable this
+ * static key once enable it.
+ */
+static inline void sched_uclamp_enable(void)
+{
+	if (!uclamp_is_used())
+		static_branch_enable(&sched_uclamp_used);
+}
+
 static inline unsigned long uclamp_rq_get(struct rq *rq,
 					  enum uclamp_id clamp_id)
 {
@@ -3486,6 +3498,8 @@ static inline bool uclamp_is_used(void)
 	return false;
 }
 
+static inline void sched_uclamp_enable(void) {}
+
 static inline unsigned long
 uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
 {
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 9f40348..c326de1 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -368,7 +368,7 @@ static int uclamp_validate(struct task_struct *p,
 	 * blocking operation which obviously cannot be done while holding
 	 * scheduler locks.
 	 */
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	return 0;
 }

