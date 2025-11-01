Return-Path: <linux-tip-commits+bounces-7128-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B835BC286AD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDFBD4F0EA8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FF22FFFA5;
	Sat,  1 Nov 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KERgkEDi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buSVJAmy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75303202F9C;
	Sat,  1 Nov 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026090; cv=none; b=kuKnF1c5gYGIEDiwfYfQZ2z1tXJqw7kKikWGucCgdSqMRn2lexGUgSNnSmt+7wglTa9b6eabERiH3d85ppDlAHxxSEBHnh0gEBM13o4qugyQNUBCl9OTVe9d+Jq8vDRlzL+gF5cxeqPRHv+7w6OWqm5r9+jcfI53+anKw1zF1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026090; c=relaxed/simple;
	bh=bj6wtKDABvd5HhdQ6Ao7SF74VL+tNubM63BtznMpo+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aWp5vCjS7NI1LDYwbPo191B1KP6AdtPjr4yLN9/ICUtG9qLdcE1xYn9voeQHfEupQQSsNYsYH2x54lEEcNrCjmvkdv3LtITVcWw0+fN9Y/4AYNEfihREUFonxQJblKCD6Yd9Satk7ESj++E36ZUuWfq3mKrAAoXbkunibhtZt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KERgkEDi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buSVJAmy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq2hzhmOjZuQAVck6fsVE+8vSIzN6K6KVDjK5uFo3XI=;
	b=KERgkEDiwdwnn1BD1Ke8f/2dMBuQ8IoshgI6MbIAG/N3H7lXt61pAA8a532DoaQ9z2yv1Q
	YqNwKjB/gZfOzSEHjNo5HhWvxJtM4uAhlfwExYLmDWZnwHkWNmieBUQTMLxxxn/E5EMNdm
	+7REFZbm9izj3qhM1CwJtap6xQUNaDVRUNcp2JRIAl+leNBlq0lZRZQCkqiSDVMboPDsSm
	pPTsa5sIQoti6FT7D+SeIZV1ujIETULVm0aooQDAnZf6ACGO0J9PLfq1dkn/9pDtaSRWkl
	GTyPJU4GdthNQaiLgpAXac2WmJ08nMqMaGJu4EdyQjk70Wo14MpWRGTNVRRuaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq2hzhmOjZuQAVck6fsVE+8vSIzN6K6KVDjK5uFo3XI=;
	b=buSVJAmy29/6lp5frPDyv7cv9YZS09I3jAdzSXMI58Pm8qBRPpeOpVUDUN1wlgmGkNfocn
	s+exRrdn7OZ5zmDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Fix imbalanced NUMA trees
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-4-frederic@kernel.org>
References: <20251024132536.39841-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608528.2601451.8358442454198361093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5eb579dfd46b4949117ecb0f1ba2f12d3dc9a6f2
Gitweb:        https://git.kernel.org/tip/5eb579dfd46b4949117ecb0f1ba2f12d3dc=
9a6f2
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:25 +01:00

timers/migration: Fix imbalanced NUMA trees

When a CPU from a new node boots, the old root may happen to be
connected to the new root even if their node mismatch, as depicted in
the following scenario:

1) CPU 0 boots and creates the first group for node 0.

   [GRP0:0]
    node 0
      |
    CPU 0

2) CPU 1 from node 1 boots and creates a new top that corresponds to
   node 1, but it also connects the old root from node 0 to the new root
   from node 1 by mistake.

             [GRP1:0]
              node 1
            /        \
           /          \
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0                CPU 1

3) This eventually leads to an imbalanced tree where some node 0 CPUs
   migrate node 1 timers (and vice versa) way before reaching the
   crossnode groups, resulting in more frequent remote memory accesses
   than expected.

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 1               node 0
            /        \                |
           /          \             [...]
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0...              CPU 1...

A balanced tree should only contain groups having children that belong
to the same node:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:0]
              node 0               node 1
            /        \             /      \
           /          \           /        \
   [GRP0:0]          [...]      [...]    [GRP0:1]
    node 0                                node 1
      |                                     |
    CPU 0...                              CPU 1...

In order to fix this, the hierarchy must be unfolded up to the crossnode
level as soon as a node mismatch is detected. For example the stage 2
above should lead to this layout:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 0               node 1
              /                         \
             /                           \
        [GRP0:0]                        [GRP0:1]
        node 0                           node 1
          |                                |
       CPU 0                             CPU 1

This means that not only GRP1:0 must be created but also GRP1:1 and
GRP2:0 in order to prepare a balanced tree for next CPUs to boot.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-4-frederic@kernel.org
---
 kernel/time/timer_migration.c | 231 ++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 104 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5f8aef9..49635a2 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -420,6 +420,8 @@ static struct list_head *tmigr_level_list __read_mostly;
 static unsigned int tmigr_hierarchy_levels __read_mostly;
 static unsigned int tmigr_crossnode_level __read_mostly;
=20
+static struct tmigr_group *tmigr_root;
+
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
=20
 #define TMIGR_NONE	0xFF
@@ -522,11 +524,9 @@ struct tmigr_walk {
=20
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmig=
r_walk *);
=20
-static void __walk_groups(up_f up, struct tmigr_walk *data,
-			  struct tmigr_cpu *tmc)
+static void __walk_groups_from(up_f up, struct tmigr_walk *data,
+			       struct tmigr_group *child, struct tmigr_group *group)
 {
-	struct tmigr_group *child =3D NULL, *group =3D tmc->tmgroup;
-
 	do {
 		WARN_ON_ONCE(group->level >=3D tmigr_hierarchy_levels);
=20
@@ -544,6 +544,12 @@ static void __walk_groups(up_f up, struct tmigr_walk *da=
ta,
 	} while (group);
 }
=20
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	__walk_groups_from(up, data, NULL, tmc->tmgroup);
+}
+
 static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *=
tmc)
 {
 	lockdep_assert_held(&tmc->lock);
@@ -1498,21 +1504,6 @@ static void tmigr_init_group(struct tmigr_group *group=
, unsigned int lvl,
 	s.seq =3D 0;
 	atomic_set(&group->migr_state, s.state);
=20
-	/*
-	 * If this is a new top-level, prepare its groupmask in advance.
-	 * This avoids accidents where yet another new top-level is
-	 * created in the future and made visible before the current groupmask.
-	 */
-	if (list_empty(&tmigr_level_list[lvl])) {
-		group->groupmask =3D BIT(0);
-		/*
-		 * The previous top level has prepared its groupmask already,
-		 * simply account it as the first child.
-		 */
-		if (lvl > 0)
-			group->num_children =3D 1;
-	}
-
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires =3D KTIME_MAX;
@@ -1567,22 +1558,51 @@ static struct tmigr_group *tmigr_get_group(unsigned i=
nt cpu, int node,
 	return group;
 }
=20
+static bool tmigr_init_root(struct tmigr_group *group, bool activate)
+{
+	if (!group->parent && group !=3D tmigr_root) {
+		/*
+		 * This is the new top-level, prepare its groupmask in advance
+		 * to avoid accidents where yet another new top-level is
+		 * created in the future and made visible before this groupmask.
+		 */
+		group->groupmask =3D BIT(0);
+		WARN_ON_ONCE(activate);
+
+		return true;
+	}
+
+	return false;
+
+}
+
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent,
 				       bool activate)
 {
-	struct tmigr_walk data;
+	if (tmigr_init_root(parent, activate)) {
+		/*
+		 * The previous top level had prepared its groupmask already,
+		 * simply account it in advance as the first child. If some groups
+		 * have been created between the old and new root due to node
+		 * mismatch, the new root's child will be intialized accordingly.
+		 */
+		parent->num_children =3D 1;
+	}
=20
-	if (activate) {
+	/* Connecting old root to new root ? */
+	if (!parent->parent && activate) {
 		/*
-		 * @child is the old top and @parent the new one. In this
-		 * case groupmask is pre-initialized and @child already
-		 * accounted, along with its new sibling corresponding to the
-		 * CPU going up.
+		 * @child is the old top, or in case of node mismatch, some
+		 * intermediate group between the old top and the new one in
+		 * @parent. In this case the @child must be pre-accounted above
+		 * as the first child. Its new inactive sibling corresponding
+		 * to the CPU going up has been accounted as the second child.
 		 */
-		WARN_ON_ONCE(child->groupmask !=3D BIT(0) || parent->num_children !=3D 2);
+		WARN_ON_ONCE(parent->num_children !=3D 2);
+		child->groupmask =3D BIT(0);
 	} else {
-		/* Adding @child for the CPU going up to @parent. */
+		/* Common case adding @child for the CPU going up to @parent. */
 		child->groupmask =3D BIT(parent->num_children++);
 	}
=20
@@ -1594,56 +1614,28 @@ static void tmigr_connect_child_parent(struct tmigr_g=
roup *child,
 	smp_store_release(&child->parent, parent);
=20
 	trace_tmigr_connect_child_parent(child);
-
-	if (!activate)
-		return;
-
-	/*
-	 * To prevent inconsistent states, active children need to be active in
-	 * the new parent as well. Inactive children are already marked inactive
-	 * in the parent group:
-	 *
-	 * * When new groups were created by tmigr_setup_groups() starting from
-	 *   the lowest level (and not higher then one level below the current
-	 *   top level), then they are not active. They will be set active when
-	 *   the new online CPU comes active.
-	 *
-	 * * But if a new group above the current top level is required, it is
-	 *   mandatory to propagate the active state of the already existing
-	 *   child to the new parent. So tmigr_connect_child_parent() is
-	 *   executed with the formerly top level group (child) and the newly
-	 *   created group (parent).
-	 *
-	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
-	 *   already connected and !idle CPU. Even if all other CPUs go idle,
-	 *   the CPU executing the setup will be responsible up to current top
-	 *   level group. And the next time it goes inactive, it will release
-	 *   the new childmask and parent to subsequent walkers through this
-	 *   @child. Therefore propagate active state unconditionally.
-	 */
-	data.childmask =3D child->groupmask;
-
-	/*
-	 * There is only one new level per time (which is protected by
-	 * tmigr_mutex). When connecting the child and the parent and set the
-	 * child active when the parent is inactive, the parent needs to be the
-	 * uppermost level. Otherwise there went something wrong!
-	 */
-	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
=20
-static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
+			      struct tmigr_group *start, bool activate)
 {
 	struct tmigr_group *group, *child, **stack;
-	int i, top =3D 0, err =3D 0;
-	struct list_head *lvllist;
+	int i, top =3D 0, err =3D 0, start_lvl =3D 0;
+	bool root_mismatch =3D false;
=20
 	stack =3D kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
=20
-	for (i =3D 0; i < tmigr_hierarchy_levels; i++) {
+	if (start) {
+		stack[start->level] =3D start;
+		start_lvl =3D start->level + 1;
+	}
+
+	if (tmigr_root)
+		root_mismatch =3D tmigr_root->numa_node !=3D node;
+
+	for (i =3D start_lvl; i < tmigr_hierarchy_levels; i++) {
 		group =3D tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err =3D PTR_ERR(group);
@@ -1656,23 +1648,25 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
=20
 		/*
 		 * When booting only less CPUs of a system than CPUs are
-		 * available, not all calculated hierarchy levels are required.
+		 * available, not all calculated hierarchy levels are required,
+		 * unless a node mismatch is detected.
 		 *
 		 * The loop is aborted as soon as the highest level, which might
 		 * be different from tmigr_hierarchy_levels, contains only a
-		 * single group.
+		 * single group, unless the nodes mismatch below tmigr_crossnode_level
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i]))
+		if (group->parent)
+			break;
+		if ((!root_mismatch || i >=3D tmigr_crossnode_level) &&
+		    list_is_singular(&tmigr_level_list[i]))
 			break;
 	}
=20
 	/* Assert single root without parent */
 	if (WARN_ON_ONCE(i >=3D tmigr_hierarchy_levels))
 		return -EINVAL;
-	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_l=
ist[top])))
-		return -EINVAL;
=20
-	for (; i >=3D 0; i--) {
+	for (; i >=3D start_lvl; i--) {
 		group =3D stack[i];
=20
 		if (err < 0) {
@@ -1692,48 +1686,63 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
 			tmc->tmgroup =3D group;
 			tmc->groupmask =3D BIT(group->num_children++);
=20
+			tmigr_init_root(group, activate);
+
 			trace_tmigr_connect_cpu_parent(tmc);
=20
 			/* There are no children that need to be connected */
 			continue;
 		} else {
 			child =3D stack[i - 1];
-			/* Will be activated at online time */
-			tmigr_connect_child_parent(child, group, false);
+			tmigr_connect_child_parent(child, group, activate);
 		}
+	}
=20
-		/* check if uppermost level was newly created */
-		if (top !=3D i)
-			continue;
-
-		WARN_ON_ONCE(top =3D=3D 0);
+	if (err < 0)
+		goto out;
=20
-		lvllist =3D &tmigr_level_list[top];
+	if (activate) {
+		struct tmigr_walk data;
=20
 		/*
-		 * Newly created root level should have accounted the upcoming
-		 * CPU's child group and pre-accounted the old root.
+		 * To prevent inconsistent states, active children need to be active in
+		 * the new parent as well. Inactive children are already marked inactive
+		 * in the parent group:
+		 *
+		 * * When new groups were created by tmigr_setup_groups() starting from
+		 *   the lowest level, then they are not active. They will be set active
+		 *   when the new online CPU comes active.
+		 *
+		 * * But if new groups above the current top level are required, it is
+		 *   mandatory to propagate the active state of the already existing
+		 *   child to the new parents. So tmigr_active_up() activates the
+		 *   new parents while walking up from the old root to the new.
+		 *
+		 * * It is ensured that @start is active, as this setup path is
+		 *   executed in hotplug prepare callback. This is executed by an
+		 *   already connected and !idle CPU. Even if all other CPUs go idle,
+		 *   the CPU executing the setup will be responsible up to current top
+		 *   level group. And the next time it goes inactive, it will release
+		 *   the new childmask and parent to subsequent walkers through this
+		 *   @child. Therefore propagate active state unconditionally.
 		 */
-		if (group->num_children =3D=3D 2 && list_is_singular(lvllist)) {
-			/*
-			 * The target CPU must never do the prepare work, except
-			 * on early boot when the boot CPU is the target. Otherwise
-			 * it may spuriously activate the old top level group inside
-			 * the new one (nevertheless whether old top level group is
-			 * active or not) and/or release an uninitialized childmask.
-			 */
-			WARN_ON_ONCE(cpu =3D=3D raw_smp_processor_id());
-
-			lvllist =3D &tmigr_level_list[top - 1];
-			list_for_each_entry(child, lvllist, list) {
-				if (child->parent)
-					continue;
+		WARN_ON_ONCE(!start->parent);
+		data.childmask =3D start->groupmask;
+		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
+	}
=20
-				tmigr_connect_child_parent(child, group, true);
-			}
+	/* Root update */
+	if (list_is_singular(&tmigr_level_list[top])) {
+		group =3D list_first_entry(&tmigr_level_list[top],
+					 typeof(*group), list);
+		WARN_ON_ONCE(group->parent);
+		if (tmigr_root) {
+			/* Old root should be the same or below */
+			WARN_ON_ONCE(tmigr_root->level > top);
 		}
+		tmigr_root =3D group;
 	}
-
+out:
 	kfree(stack);
=20
 	return err;
@@ -1741,12 +1750,26 @@ static int tmigr_setup_groups(unsigned int cpu, unsig=
ned int node)
=20
 static int tmigr_add_cpu(unsigned int cpu)
 {
+	struct tmigr_group *old_root =3D tmigr_root;
 	int node =3D cpu_to_node(cpu);
 	int ret;
=20
-	mutex_lock(&tmigr_mutex);
-	ret =3D tmigr_setup_groups(cpu, node);
-	mutex_unlock(&tmigr_mutex);
+	guard(mutex)(&tmigr_mutex);
+
+	ret =3D tmigr_setup_groups(cpu, node, NULL, false);
+
+	/* Root has changed? Connect the old one to the new */
+	if (ret >=3D 0 && old_root && old_root !=3D tmigr_root) {
+		/*
+		 * The target CPU must never do the prepare work, except
+		 * on early boot when the boot CPU is the target. Otherwise
+		 * it may spuriously activate the old top level group inside
+		 * the new one (nevertheless whether old top level group is
+		 * active or not) and/or release an uninitialized childmask.
+		 */
+		WARN_ON_ONCE(cpu =3D=3D raw_smp_processor_id());
+		ret =3D tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
+	}
=20
 	return ret;
 }

