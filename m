Return-Path: <linux-tip-commits+bounces-1733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F10F937C01
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36E11F21750
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB21474AF;
	Fri, 19 Jul 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJ/Frbpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lq0gaomX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64C1465A3;
	Fri, 19 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412375; cv=none; b=dj4XViSp7NoVuEUgC2sjaR0PbSTa1aqAKkba8G91o/7mXdhYvb1ahws3Y9W6vJtvW99tE0HegDCqYt7vLCsWemwJUmj6HFgEekof1pEqQa04kqbJvUs7r+vSJTPKHusfOZKn5ruAps6IGo+LTiwktTq9laSVSW0G1jgyVdVsmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412375; c=relaxed/simple;
	bh=MZzIPcpE3wWddMujjSFh8Or+wXCbzbZYDOlZBWO6cak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GfEVwaNMmLytQm3mcThZggKgLziyGsjZJ+thExmlxhZbXcd1teasyOy7NYxhgkDzXRWWpXKVs6V+phg7yPnSOYS3a5YsMoXobUEsyDsMhgmuS9Ld3+Ey5OH/cTEwObNQjs1um0rDIL6Sb1UwUdcm47FhWeCxMmrtpTYquOls/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJ/Frbpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lq0gaomX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jul 2024 18:06:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNpKqvg6VutVjoQDVIKommKmpKDhkwBpnc5snBHDFlQ=;
	b=yJ/Frbpf2PwVEnD5UDFKNyeFqgYb8D0pzpNFILEs/wiPi1vSJX71rBjIVyrvoLybKPQs55
	Tlyg3Ipi5W8UXjQs35lk9sj8BEdx+6JGLBzvysd+3CQNMOvwqgfFYB3aeMyZQcKv079V9t
	v5YxO6HQt/DetDdVW9F20mtP5716jUxAZL5qXvcaVz+1WJZZwamg81n90FoHKuUu6b+M+H
	KIiRuT+Lqz5ODbiZpdgnzCYC4ItzUJgyKITGHPClFwkZcYS3oYE90TGi7VRy3uzh0tqkVg
	pLxWFIJsClr4hPHiGvHtvzUmXnl1Oq3G6qVGQdmXOI/SM5F4C2Z7iGUItJCd8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNpKqvg6VutVjoQDVIKommKmpKDhkwBpnc5snBHDFlQ=;
	b=Lq0gaomXapEpF76ex0D8XElOGgUtKLRE6Exq8OPljQadsMaAqpQbOGggXXxtUpJ03axIjN
	dlpoQ1z2c0TtSABQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Rename childmask by groupmask
 to make naming more obvious
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-6-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-6-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172141237162.2215.13193068753140703904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     eefda06f66b37fb87983ac9cfad35bf0bb4f6cb3
Gitweb:        https://git.kernel.org/tip/eefda06f66b37fb87983ac9cfad35bf0bb4f6cb3
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:02 +02:00

timers/migration: Rename childmask by groupmask to make naming more obvious

childmask in the group reflects the mask that is required to 'reference'
this group in the parent. When reading childmask, this might be confusing,
as this suggests, that this is the mask of the child of the group.

Clarify this by renaming childmask in the tmigr_group and tmc_group by
groupmask.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-6-757baa7803fe@linutronix.de

---
 include/trace/events/timer_migration.h | 16 ++++++++--------
 kernel/time/timer_migration.c          | 24 ++++++++++++------------
 kernel/time/timer_migration.h          | 15 +++++++--------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
index 79f19e7..47db5ea 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -43,7 +43,7 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__field( unsigned int,	lvl		)
 		__field( unsigned int,	numa_node	)
 		__field( unsigned int,	num_children	)
-		__field( u32,		childmask	)
+		__field( u32,		groupmask	)
 	),
 
 	TP_fast_assign(
@@ -52,11 +52,11 @@ TRACE_EVENT(tmigr_connect_child_parent,
 		__entry->lvl		= child->parent->level;
 		__entry->numa_node	= child->parent->numa_node;
 		__entry->num_children	= child->parent->num_children;
-		__entry->childmask	= child->childmask;
+		__entry->groupmask	= child->groupmask;
 	),
 
-	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
-		  __entry->child,  __entry->childmask, __entry->parent,
+	TP_printk("group=%p groupmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->child,  __entry->groupmask, __entry->parent,
 		  __entry->lvl, __entry->numa_node, __entry->num_children)
 );
 
@@ -72,7 +72,7 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__field( unsigned int,	lvl		)
 		__field( unsigned int,	numa_node	)
 		__field( unsigned int,	num_children	)
-		__field( u32,		childmask	)
+		__field( u32,		groupmask	)
 	),
 
 	TP_fast_assign(
@@ -81,11 +81,11 @@ TRACE_EVENT(tmigr_connect_cpu_parent,
 		__entry->lvl		= tmc->tmgroup->level;
 		__entry->numa_node	= tmc->tmgroup->numa_node;
 		__entry->num_children	= tmc->tmgroup->num_children;
-		__entry->childmask	= tmc->childmask;
+		__entry->groupmask	= tmc->groupmask;
 	),
 
-	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
-		  __entry->cpu,	 __entry->childmask, __entry->parent,
+	TP_printk("cpu=%d groupmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->cpu,	 __entry->groupmask, __entry->parent,
 		  __entry->lvl, __entry->numa_node, __entry->num_children)
 );
 
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 6af1f21..66c3437 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -495,7 +495,7 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
  *			outcome is a CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
- * @childmask:		childmask of child group
+ * @childmask:		groupmask of child group
  * @remote:		Is set, when the new timer path is executed in
  *			tmigr_handle_remote_cpu()
  * @basej:		timer base in jiffies
@@ -535,7 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
-		data->childmask = child->childmask;
+		data->childmask = child->groupmask;
 	} while (group);
 }
 
@@ -669,7 +669,7 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 {
 	struct tmigr_walk data;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 
 	trace_tmigr_cpu_active(tmc);
 
@@ -1049,7 +1049,7 @@ void tmigr_handle_remote(void)
 	if (tmigr_is_not_available(tmc))
 		return;
 
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 	data.firstexp = KTIME_MAX;
 
 	/*
@@ -1057,7 +1057,7 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->groupmask)) {
 		/*
 		 * If this CPU was an idle migrator, make sure to clear its wakeup
 		 * value so it won't chase timers that have already expired elsewhere.
@@ -1150,7 +1150,7 @@ bool tmigr_requires_handle_remote(void)
 		return ret;
 
 	data.now = get_jiffies_update(&jif);
-	data.childmask = tmc->childmask;
+	data.childmask = tmc->groupmask;
 	data.firstexp = KTIME_MAX;
 	data.tmc_active = !tmc->idle;
 	data.check = false;
@@ -1310,7 +1310,7 @@ static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
 	struct tmigr_walk data = { .nextexp = nextexp,
 				   .firstexp = KTIME_MAX,
 				   .evt = &tmc->cpuevt,
-				   .childmask = tmc->childmask };
+				   .childmask = tmc->groupmask };
 
 	/*
 	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
@@ -1388,7 +1388,7 @@ u64 tmigr_quick_check(u64 nextevt)
 	if (WARN_ON_ONCE(tmc->idle))
 		return nextevt;
 
-	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->groupmask))
 		return KTIME_MAX;
 
 	do {
@@ -1552,7 +1552,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
 	child->parent = parent;
-	child->childmask = BIT(parent->num_children++);
+	child->groupmask = BIT(parent->num_children++);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
@@ -1586,7 +1586,7 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   the new childmask and parent to subsequent walkers through this
 	 *   @child. Therefore propagate active state unconditionally.
 	 */
-	data.childmask = child->childmask;
+	data.childmask = child->groupmask;
 
 	/*
 	 * There is only one new level per time (which is protected by
@@ -1652,7 +1652,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			raw_spin_lock_irq(&group->lock);
 
 			tmc->tmgroup = group;
-			tmc->childmask = BIT(group->num_children++);
+			tmc->groupmask = BIT(group->num_children++);
 
 			raw_spin_unlock_irq(&group->lock);
 
@@ -1730,7 +1730,7 @@ static int tmigr_cpu_prepare(unsigned int cpu)
 	if (ret < 0)
 		return ret;
 
-	if (tmc->childmask == 0)
+	if (tmc->groupmask == 0)
 		return -EINVAL;
 
 	return ret;
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 494f68c..154accc 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -51,9 +51,8 @@ struct tmigr_event {
  * @num_children:	Counter of group children to make sure the group is only
  *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
  *			only
- * @childmask:		childmask of the group in the parent group; is set
- *			during setup and will never change; can be read
- *			lockless
+ * @groupmask:		mask of the group in the parent group; is set during
+ *			setup and will never change; can be read lockless
  * @list:		List head that is added to the per level
  *			tmigr_level_list; is required during setup when a
  *			new group needs to be connected to the existing
@@ -69,7 +68,7 @@ struct tmigr_group {
 	unsigned int		level;
 	int			numa_node;
 	unsigned int		num_children;
-	u8			childmask;
+	u8			groupmask;
 	struct list_head	list;
 };
 
@@ -89,7 +88,7 @@ struct tmigr_group {
  *			hierarchy
  * @remote:		Is set when timers of the CPU are expired remotely
  * @tmgroup:		Pointer to the parent group
- * @childmask:		childmask of tmigr_cpu in the parent group
+ * @groupmask:		mask of tmigr_cpu in the parent group
  * @wakeup:		Stores the first timer when the timer migration
  *			hierarchy is completely idle and remote expiry was done;
  *			is returned to timer code in the idle path and is only
@@ -102,7 +101,7 @@ struct tmigr_cpu {
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;
-	u8			childmask;
+	u8			groupmask;
 	u64			wakeup;
 	struct tmigr_event	cpuevt;
 };
@@ -118,8 +117,8 @@ union tmigr_state {
 	u32 state;
 	/**
 	 * struct - split state of tmigr_group
-	 * @active:	Contains each childmask bit of the active children
-	 * @migrator:	Contains childmask of the child which is migrator
+	 * @active:	Contains each mask bit of the active children
+	 * @migrator:	Contains mask of the child which is migrator
 	 * @seq:	Sequence counter needs to be increased when an update
 	 *		to the tmigr_state is done. It prevents a race when
 	 *		updates in the child groups are propagated in changed

