Return-Path: <linux-tip-commits+bounces-1734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F2937C05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0931F217F5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B05147C8B;
	Fri, 19 Jul 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHK69dR4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHPM3XXu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A522145A09;
	Fri, 19 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412376; cv=none; b=ZC4EjX9YKcUUAnZ52BKaNNT12hR58/s959WKrffFH1AOw8SCgYlOIsNAKXzVXUUT+6C6WiX7FakwbAm4MMVrfR22AG836miiVlZ00Yw6oJfdZ+WzHLOtX6XH/Ixqyevy0MKTu9GzyjkzqGs5xGhJMPqMxVxKqObAG8QKcgK+Hgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412376; c=relaxed/simple;
	bh=yUOsBavnFa6Ua0qEBVezuJKtYHq58K6fSjGvWHyybIs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IcttPgB9sGNvs3LioJ2IcesA1vuY+bn46zZybN6nfKa1eh0DIWFnbYFCFeSI4lIG9BOzIdSwI9NTL1vMDVlD9YdrkRVCjID2I995s5AT/aDVTTK18uDtTJ0lsUk1DWDNn5awmVBdlLr070fqA8zjMxqQ7TDeQy8vJ3c2Hw2qAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHK69dR4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHPM3XXu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jul 2024 18:06:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC5k40Hcof0M3JyAuI1ocpmgO5BrVqoq0yEIYql1JUE=;
	b=mHK69dR4qgYITNRAEkocRI/UerSuf3NK97dOxrn5jjC3nmQZVxp+lQGwIBtuo8OUkY0skY
	BQNEYjDayAVXHME9vTg1MOJ+VttPouhiwT1w2WhjnLB1RMdflYPkrIrjcJESAiSDVHbNBj
	loG6i2ng654fbNe19H9xlcYGUs+7LoyzRCO5xrl7IerPtHu0Xy7NMch7y7UbUkzD7u/i9m
	avNOw99GM8Ss0DTKmEVzD+WmUSRj5IkW5iNyN/SAexs2XotWp7erX7jWdV7+5D+iU8mXuk
	M5szsM2DufE94Ezhsv8k0PUeZWcLyx/v3qTTRRwofXlVqP3U2vaJrld+6T0FnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC5k40Hcof0M3JyAuI1ocpmgO5BrVqoq0yEIYql1JUE=;
	b=EHPM3XXucw65OJFAOBbgcI01XKyTfl22JTpgs4r3Qu7K6o8AU21YUeX970QrY9M6MuKD/F
	m3miS0gJHCp2dbBg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Use a single struct for
 hierarchy walk data
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-4-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-4-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172141237217.2215.7593190001868690214.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     6d588c29e100592c0f4eab71a87c36165cf8d0bc
Gitweb:        https://git.kernel.org/tip/6d588c29e100592c0f4eab71a87c36165cf8d0bc
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:01 +02:00

timers/migration: Use a single struct for hierarchy walk data

Two different structs are defined for propagating data from one to another
level when walking the hierarchy. Several struct members exist in both
structs which makes generalization harder.

Merge those two structs into a single one and use it directly in
walk_groups() and the corresponding function pointers instead of
introducing pointer casting all over the place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-4-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 126 ++++++++++++++-------------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index e618ea3..a32c8a7 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -475,69 +475,31 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
 	return bitmap_weight(&active, BIT_CNT) <= 1;
 }
 
-typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
-
-static void __walk_groups(up_f up, void *data,
-			  struct tmigr_cpu *tmc)
-{
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
-	do {
-		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
-
-		if (up(group, child, data))
-			break;
-
-		child = group;
-		group = group->parent;
-	} while (group);
-}
-
-static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
-{
-	lockdep_assert_held(&tmc->lock);
-
-	__walk_groups(up, data, tmc);
-}
-
 /**
  * struct tmigr_walk - data required for walking the hierarchy
  * @nextexp:		Next CPU event expiry information which is handed into
  *			the timer migration code by the timer code
  *			(get_next_timer_interrupt())
- * @firstexp:		Contains the first event expiry information when last
- *			active CPU of hierarchy is on the way to idle to make
- *			sure CPU will be back in time. It is updated in top
- *			level group only. Be aware, there could occur a new top
- *			level of the hierarchy between the 'top level call' in
- *			tmigr_update_events() and the check for the parent group
- *			in walk_groups(). Then @firstexp might contain a value
- *			!= KTIME_MAX even if it was not the final top
- *			level. This is not a problem, as the worst outcome is a
- *			CPU which might wake up a little early.
+ * @firstexp:		Contains the first event expiry information when
+ *			hierarchy is completely idle.  When CPU itself was the
+ *			last going idle, information makes sure, that CPU will
+ *			be back in time. When using this value in the remote
+ *			expiry case, firstexp is stored in the per CPU tmigr_cpu
+ *			struct of CPU which expires remote timers. It is updated
+ *			in top level group only. Be aware, there could occur a
+ *			new top level of the hierarchy between the 'top level
+ *			call' in tmigr_update_events() and the check for the
+ *			parent group in walk_groups(). Then @firstexp might
+ *			contain a value != KTIME_MAX even if it was not the
+ *			final top level. This is not a problem, as the worst
+ *			outcome is a CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
  * @childmask:		childmask of child group
  * @remote:		Is set, when the new timer path is executed in
  *			tmigr_handle_remote_cpu()
- */
-struct tmigr_walk {
-	u64			nextexp;
-	u64			firstexp;
-	struct tmigr_event	*evt;
-	u8			childmask;
-	bool			remote;
-};
-
-/**
- * struct tmigr_remote_data - data required for remote expiry hierarchy walk
  * @basej:		timer base in jiffies
  * @now:		timer base monotonic
- * @firstexp:		returns expiry of the first timer in the idle timer
- *			migration hierarchy to make sure the timer is handled in
- *			time; it is stored in the per CPU tmigr_cpu struct of
- *			CPU which expires remote timers
- * @childmask:		childmask of child group
  * @check:		is set if there is the need to handle remote timers;
  *			required in tmigr_requires_handle_remote() only
  * @tmc_active:		this flag indicates, whether the CPU which triggers
@@ -546,15 +508,43 @@ struct tmigr_walk {
  *			idle, only the first event of the top level has to be
  *			considered.
  */
-struct tmigr_remote_data {
-	unsigned long	basej;
-	u64		now;
-	u64		firstexp;
-	u8		childmask;
-	bool		check;
-	bool		tmc_active;
+struct tmigr_walk {
+	u64			nextexp;
+	u64			firstexp;
+	struct tmigr_event	*evt;
+	u8			childmask;
+	bool			remote;
+	unsigned long		basej;
+	u64			now;
+	bool			check;
+	bool			tmc_active;
 };
 
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
+
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
+
+	do {
+		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
+
+		if (up(group, child, data))
+			break;
+
+		child = group;
+		group = group->parent;
+	} while (group);
+}
+
+static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
+{
+	lockdep_assert_held(&tmc->lock);
+
+	__walk_groups(up, data, tmc);
+}
+
 /*
  * Returns the next event of the timerqueue @group->events
  *
@@ -625,10 +615,9 @@ static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
 
 static bool tmigr_active_up(struct tmigr_group *group,
 			    struct tmigr_group *child,
-			    void *ptr)
+			    struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate;
-	struct tmigr_walk *data = ptr;
 	bool walk_done;
 	u8 childmask;
 
@@ -867,10 +856,8 @@ unlock:
 
 static bool tmigr_new_timer_up(struct tmigr_group *group,
 			       struct tmigr_group *child,
-			       void *ptr)
+			       struct tmigr_walk *data)
 {
-	struct tmigr_walk *data = ptr;
-
 	return tmigr_update_events(group, child, data);
 }
 
@@ -1002,9 +989,8 @@ unlock:
 
 static bool tmigr_handle_remote_up(struct tmigr_group *group,
 				   struct tmigr_group *child,
-				   void *ptr)
+				   struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data = ptr;
 	struct tmigr_event *evt;
 	unsigned long jif;
 	u8 childmask;
@@ -1062,7 +1048,7 @@ again:
 void tmigr_handle_remote(void)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
 
 	if (tmigr_is_not_available(tmc))
 		return;
@@ -1104,9 +1090,8 @@ void tmigr_handle_remote(void)
 
 static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 					    struct tmigr_group *child,
-					    void *ptr)
+					    struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data = ptr;
 	u8 childmask;
 
 	childmask = data->childmask;
@@ -1164,7 +1149,7 @@ out:
 bool tmigr_requires_handle_remote(void)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
 	unsigned long jif;
 	bool ret = false;
 
@@ -1252,10 +1237,9 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 
 static bool tmigr_inactive_up(struct tmigr_group *group,
 			      struct tmigr_group *child,
-			      void *ptr)
+			      struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate, childstate;
-	struct tmigr_walk *data = ptr;
 	bool walk_done;
 	u8 childmask;
 

