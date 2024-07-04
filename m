Return-Path: <linux-tip-commits+bounces-1597-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8728927D19
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 20:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A86B22FAB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925313A252;
	Thu,  4 Jul 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdrNNqBZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRfNvXYJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB753389;
	Thu,  4 Jul 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117978; cv=none; b=DDsL1M9OW91NFLO/OIfYAH8i5m5RmFvxzy4UXJcCoA85mEB/MYLwcAXF0DqeknswzpH94gXSHKzh7wgazwVwtZGhXcGMGiuTYljoMzeu9AkfkplYX3/aiKt7cTEl+DDx4CFSopRHZd8gf3u1/zJLPQt0r96Wmb+L4fDwms/papc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117978; c=relaxed/simple;
	bh=+Y60s2VvL8X1HfFgIy9Avia87RHRepDNsI3LU9cn+qI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T42wQgYX1+EmUiTaG5iwTkNIBUfuoGY6i3ovGAS1bUzgBTevQnwHLksZk4JyM/TfA1lAsfcoczfBU94yvnwD5jFUX2av80fmpmRljOL1sMH64rYyOq1aGg2jOaOl8FJijkR25oPcKGjkbuNnA+OdHeyvROMCacG0DTAypM4E6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KdrNNqBZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRfNvXYJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9e/edFNh0DkHwfMy+hhYMI8CxcKyRFfWMbVxcvpWZR4=;
	b=KdrNNqBZEaJVJhBU/gO2VF7RTp2qn+3xMOQOfH9+u0UpmnkJmaJKMlR/LMFAvvMf383wLD
	kD8tmBtHTHKWIJ0KWP9ooS1Bn2bhDjXndVuxZZD8cyg1dqKQSGZEqnAx+Hh0qr7UZyJOGd
	2ujLsulHey16UAVoy2YSviheU93QGKxMKTb1b9oBzoik6zHt/XUYOrjr66Au6eieS5YeHg
	jb5oFkEm76f7ELkMZWadJJ6LoUAP1kmeO39dw5PLWcE/ysuGfccDJIiETkOaEsdj2noERC
	2zcg6o+ckiUIbWX6PrNWJSblVxMVHrvHMm1Ncle1eZVou4cDeq9Li3hxK3r1ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9e/edFNh0DkHwfMy+hhYMI8CxcKyRFfWMbVxcvpWZR4=;
	b=wRfNvXYJ0VMGudnSnMT0e4+4ykyvPxHgIBe65mZtc9pYVVFiGdlP4y+eepvFaeNaGMf+oc
	vmajV/Xm/jtdT+BA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Use a single struct for
 hierarchy walk data
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797427.2215.9432866375692645538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6dbb59418c5c7b014e542db76595417c9b95ccde
Gitweb:        https://git.kernel.org/tip/6dbb59418c5c7b014e542db76595417c9b95ccde
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 12:18:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:24:57 +02:00

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
Link: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de

---
 kernel/time/timer_migration.c | 126 ++++++++++++++-------------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index f78258a..39eb77e 100644
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
 

