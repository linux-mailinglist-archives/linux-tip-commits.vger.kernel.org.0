Return-Path: <linux-tip-commits+bounces-5874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709FAE183D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 11:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358ED5A708B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904428368C;
	Fri, 20 Jun 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ug87VqJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ofPknW3M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F230E830;
	Fri, 20 Jun 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412997; cv=none; b=u26P9v7eqt6Yv6taHhcMdfIam8rRK143RuCRV24d7BHV9MJM/TjrryWPzfQNxB4vTTucvt0XP0blP+RazjxsJtw8v4wOa1BcwZScM9ezUIygO/mJEn5g5i4oHHGFhKMouadiwou/mdcjJz7qLPkBnCio8dDjpkhM4f54QdPWIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412997; c=relaxed/simple;
	bh=4af39J/JEpYYrTyH1+2tKMnr3lVlUhb2ZJfuDSTxZw4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iFxF+mn9PBZjv7R93W0IU46/SU6/7L0N9kBxpTfGpV7tXaxoe3D4vuyoep1RtC8lzOS1Kpg0UxMOKmp2gdtHIUyXJiqhh66PoBvn2nVU892iSmmcZAIxxvYm33TlKBR/YpRcOu6EqzFJ2D/fa4DDN6Ll+KOUSJDPd2ahAcNppa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ug87VqJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ofPknW3M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 09:49:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750412992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3Uyr+o98Xh8z0luL0PCKeo2NIL1UrKTVvxgaKb0bo=;
	b=Ug87VqJGEyKYUd9AUfqN/mLHCME/Ipla9fOBxqR28tQOw1428kNHsHS5AOe6L7jGm18jns
	FN9uXPY1SpQzh7zgmXa3OoR63iPMEc9HyAIdt8NQKXqk0FpbXpehuVLf0c0+AHhrTlSDWm
	t2jF28MHqXdIiXrrN6vUVu9pp4/2Qml0Zrn3syHzdoWlhFhWVh82cB860mENmjb52BVxV3
	rqeMPn+blx+7OEeXYii7Fm7jDw884HlVHiqgc8Jbwj2ELSoVhdYeZFkTmoSY5lVXdlD/fr
	zwBCFFCWWp+ojiniEYcanURyunU+y7z+yUaesljZDzib2tLMkuAT18J+2kHJPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750412992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3Uyr+o98Xh8z0luL0PCKeo2NIL1UrKTVvxgaKb0bo=;
	b=ofPknW3MkvgtHyyAjCjUHSySLaO5EBh6u3Ao1WwUXt5rAxmT8GCDM9dTSgkCoaJB6ytREF
	CoM8xZFAi/hVT7Bw==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Reorganize cgroup bandwidth control
 interface file writes
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614012346.2358261-5-tj@kernel.org>
References: <20250614012346.2358261-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175041299139.406.1283400728227172786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5bc34be478d09c4d16009e665e020ad0fcd0deea
Gitweb:        https://git.kernel.org/tip/5bc34be478d09c4d16009e665e020ad0fcd0deea
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 15:23:30 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Jun 2025 13:59:57 +02:00

sched/core: Reorganize cgroup bandwidth control interface file writes

- Move input parameter validation from tg_set_cfs_bandwidth() to the new
  outer function tg_set_bandwidth(). The outer function handles parameters
  in usecs, validates them and calls tg_set_cfs_bandwidth() which converts
  them into nsecs. This matches tg_bandwidth() on the read side.

- max/min_cfs_* consts are now used by tg_set_bandwidth(). Relocate, convert
  into usecs and drop "cfs" from the names.

- Reimplement cpu_cfs_{period|quote|burst}_write_*() using tg_bandwidth()
  and tg_set_bandwidth() and replace "cfs" in the names with "bw".

- Update cpu_max_write() to use tg_set_bandiwdth(). cpu_period_quota_parse()
  is updated to drop nsec conversion accordingly. This aligns the behavior
  with cfs_period_quota_print().

- Drop now unused tg_set_cfs_{period|quota|burst}().

- While at it, for consistency, rename default_cfs_period() to
  default_bw_period_us() and make it return usecs.

This is to prepare for adding bandwidth control support to sched_ext.
tg_set_bandwidth() will be used as the muxing point. No functional changes
intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250614012346.2358261-5-tj@kernel.org
---
 kernel/sched/core.c  | 205 ++++++++++++++++++++----------------------
 kernel/sched/fair.c  |   4 +-
 kernel/sched/sched.h |  10 +-
 3 files changed, 106 insertions(+), 113 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8de93a3..2f8caa9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9309,47 +9309,23 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
-const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
-static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
-/* More than 203 days if BW_SHIFT equals 20. */
-static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
-
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
-				u64 burst)
+static int tg_set_cfs_bandwidth(struct task_group *tg,
+				u64 period_us, u64 quota_us, u64 burst_us)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+	u64 period, quota, burst;
 
-	if (tg == &root_task_group)
-		return -EINVAL;
-
-	/*
-	 * Ensure we have at some amount of bandwidth every period.  This is
-	 * to prevent reaching a state of large arrears when throttled via
-	 * entity_tick() resulting in prolonged exit starvation.
-	 */
-	if (quota < min_cfs_quota_period || period < min_cfs_quota_period)
-		return -EINVAL;
+	period = (u64)period_us * NSEC_PER_USEC;
 
-	/*
-	 * Likewise, bound things on the other side by preventing insane quota
-	 * periods.  This also allows us to normalize in computing quota
-	 * feasibility.
-	 */
-	if (period > max_cfs_quota_period)
-		return -EINVAL;
-
-	/*
-	 * Bound quota to defend quota against overflow during bandwidth shift.
-	 */
-	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
-		return -EINVAL;
+	if (quota_us == RUNTIME_INF)
+		quota = RUNTIME_INF;
+	else
+		quota = (u64)quota_us * NSEC_PER_USEC;
 
-	if (quota != RUNTIME_INF && (burst > quota ||
-				     burst + quota > max_cfs_runtime))
-		return -EINVAL;
+	burst = (u64)burst_us * NSEC_PER_USEC;
 
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
@@ -9437,50 +9413,6 @@ static u64 tg_get_cfs_burst(struct task_group *tg)
 	return burst_us;
 }
 
-static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
-{
-	u64 quota, period, burst;
-
-	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	period = (u64)cfs_period_us * NSEC_PER_USEC;
-	quota = tg->cfs_bandwidth.quota;
-	burst = tg->cfs_bandwidth.burst;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
-static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
-{
-	u64 quota, period, burst;
-
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
-		quota = RUNTIME_INF;
-	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
-		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
-	else
-		return -EINVAL;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
-static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
-{
-	u64 quota, period, burst;
-
-	if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
-		return -EINVAL;
-
-	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	quota = tg->cfs_bandwidth.quota;
-
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
-}
-
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -9614,6 +9546,11 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+const u64 max_bw_quota_period_us = 1 * USEC_PER_SEC; /* 1s */
+static const u64 min_bw_quota_period_us = 1 * USEC_PER_MSEC; /* 1ms */
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_bw_runtime_us = MAX_BW;
+
 static void tg_bandwidth(struct task_group *tg,
 			 u64 *period_us_p, u64 *quota_us_p, u64 *burst_us_p)
 {
@@ -9634,6 +9571,50 @@ static u64 cpu_period_read_u64(struct cgroup_subsys_state *css,
 	return period_us;
 }
 
+static int tg_set_bandwidth(struct task_group *tg,
+			    u64 period_us, u64 quota_us, u64 burst_us)
+{
+	const u64 max_usec = U64_MAX / NSEC_PER_USEC;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	/* Values should survive translation to nsec */
+	if (period_us > max_usec ||
+	    (quota_us != RUNTIME_INF && quota_us > max_usec) ||
+	    burst_us > max_usec)
+		return -EINVAL;
+
+	/*
+	 * Ensure we have some amount of bandwidth every period. This is to
+	 * prevent reaching a state of large arrears when throttled via
+	 * entity_tick() resulting in prolonged exit starvation.
+	 */
+	if (quota_us < min_bw_quota_period_us ||
+	    period_us < min_bw_quota_period_us)
+		return -EINVAL;
+
+	/*
+	 * Likewise, bound things on the other side by preventing insane quota
+	 * periods.  This also allows us to normalize in computing quota
+	 * feasibility.
+	 */
+	if (period_us > max_bw_quota_period_us)
+		return -EINVAL;
+
+	/*
+	 * Bound quota to defend quota against overflow during bandwidth shift.
+	 */
+	if (quota_us != RUNTIME_INF && quota_us > max_bw_runtime_us)
+		return -EINVAL;
+
+	if (quota_us != RUNTIME_INF && (burst_us > quota_us ||
+					burst_us + quota_us > max_bw_runtime_us))
+		return -EINVAL;
+
+	return tg_set_cfs_bandwidth(tg, period_us, quota_us, burst_us);
+}
+
 static s64 cpu_quota_read_s64(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
@@ -9652,22 +9633,37 @@ static u64 cpu_burst_read_u64(struct cgroup_subsys_state *css,
 	return burst_us;
 }
 
-static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
-				    struct cftype *cftype, u64 cfs_period_us)
+static int cpu_period_write_u64(struct cgroup_subsys_state *css,
+				struct cftype *cftype, u64 period_us)
 {
-	return tg_set_cfs_period(css_tg(css), cfs_period_us);
+	struct task_group *tg = css_tg(css);
+	u64 quota_us, burst_us;
+
+	tg_bandwidth(tg, NULL, &quota_us, &burst_us);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 
-static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, s64 cfs_quota_us)
+static int cpu_quota_write_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cftype, s64 quota_us)
 {
-	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
+	struct task_group *tg = css_tg(css);
+	u64 period_us, burst_us;
+
+	if (quota_us < 0)
+		quota_us = RUNTIME_INF;
+
+	tg_bandwidth(tg, &period_us, NULL, &burst_us);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 
-static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, u64 cfs_burst_us)
+static int cpu_burst_write_u64(struct cgroup_subsys_state *css,
+			       struct cftype *cftype, u64 burst_us)
 {
-	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+	struct task_group *tg = css_tg(css);
+	u64 period_us, quota_us;
+
+	tg_bandwidth(tg, &period_us, &quota_us, NULL);
+	return tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
 
@@ -9733,17 +9729,17 @@ static struct cftype cpu_legacy_files[] = {
 	{
 		.name = "cfs_period_us",
 		.read_u64 = cpu_period_read_u64,
-		.write_u64 = cpu_cfs_period_write_u64,
+		.write_u64 = cpu_period_write_u64,
 	},
 	{
 		.name = "cfs_quota_us",
 		.read_s64 = cpu_quota_read_s64,
-		.write_s64 = cpu_cfs_quota_write_s64,
+		.write_s64 = cpu_quota_write_s64,
 	},
 	{
 		.name = "cfs_burst_us",
 		.read_u64 = cpu_burst_read_u64,
-		.write_u64 = cpu_cfs_burst_write_u64,
+		.write_u64 = cpu_burst_write_u64,
 	},
 	{
 		.name = "stat",
@@ -9940,22 +9936,20 @@ static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
 }
 
 /* caller should put the current value in *@periodp before calling */
-static int __maybe_unused cpu_period_quota_parse(char *buf,
-						 u64 *periodp, u64 *quotap)
+static int __maybe_unused cpu_period_quota_parse(char *buf, u64 *period_us_p,
+						 u64 *quota_us_p)
 {
 	char tok[21];	/* U64_MAX */
 
-	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
+	if (sscanf(buf, "%20s %llu", tok, period_us_p) < 1)
 		return -EINVAL;
 
-	*periodp *= NSEC_PER_USEC;
-
-	if (sscanf(tok, "%llu", quotap))
-		*quotap *= NSEC_PER_USEC;
-	else if (!strcmp(tok, "max"))
-		*quotap = RUNTIME_INF;
-	else
-		return -EINVAL;
+	if (sscanf(tok, "%llu", quota_us_p) < 1) {
+		if (!strcmp(tok, "max"))
+			*quota_us_p = RUNTIME_INF;
+		else
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -9975,14 +9969,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 			     char *buf, size_t nbytes, loff_t off)
 {
 	struct task_group *tg = css_tg(of_css(of));
-	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg->cfs_bandwidth.burst;
-	u64 quota;
+	u64 period_us, quota_us, burst_us;
 	int ret;
 
-	ret = cpu_period_quota_parse(buf, &period, &quota);
+	tg_bandwidth(tg, &period_us, NULL, &burst_us);
+	ret = cpu_period_quota_parse(buf, &period_us, &quota_us);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
+		ret = tg_set_bandwidth(tg, period_us, quota_us, burst_us);
 	return ret ?: nbytes;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10019,7 +10012,7 @@ static struct cftype cpu_files[] = {
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_burst_read_u64,
-		.write_u64 = cpu_cfs_burst_write_u64,
+		.write_u64 = cpu_burst_write_u64,
 	},
 #endif /* CONFIG_CFS_BANDWIDTH */
 #ifdef CONFIG_UCLAMP_TASK_GROUP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 707be45..7e2963e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6422,7 +6422,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			 * to fail.
 			 */
 			new = old * 2;
-			if (new < max_cfs_quota_period) {
+			if (new < max_bw_quota_period_us * NSEC_PER_USEC) {
 				cfs_b->period = ns_to_ktime(new);
 				cfs_b->quota *= 2;
 				cfs_b->burst *= 2;
@@ -6456,7 +6456,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 	raw_spin_lock_init(&cfs_b->lock);
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
-	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->period = us_to_ktime(default_bw_period_us());
 	cfs_b->burst = 0;
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e00b80c..105190b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -403,15 +403,15 @@ static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 extern struct list_head task_groups;
 
 #ifdef CONFIG_CFS_BANDWIDTH
-extern const u64 max_cfs_quota_period;
+extern const u64 max_bw_quota_period_us;
 
 /*
- * default period for cfs group bandwidth.
- * default: 0.1s, units: nanoseconds
+ * default period for group bandwidth.
+ * default: 0.1s, units: microseconds
  */
-static inline u64 default_cfs_period(void)
+static inline u64 default_bw_period_us(void)
 {
-	return 100000000ULL;
+	return 100000ULL;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
 

