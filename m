Return-Path: <linux-tip-commits+bounces-1745-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01F93945A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DE128253B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1117279E;
	Mon, 22 Jul 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYlZb4c0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rLMtTJgO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BCA171663;
	Mon, 22 Jul 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676925; cv=none; b=kEN+cyiieazGaG9rOH5LK+0h82Oed9J7yJqHT4xRvxleFFaJGc1taSuuFCd76uY7qmaroV2IYKz5KPzDt+kyN8dtrJPiJrWoRt3u4dT3Ou54bmLTpA/Qc5Nlge1ILKkQS0ucNB0F8Hy6pZep5jxJnu8ER8NB1MR3UuoExDYocPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676925; c=relaxed/simple;
	bh=3gCC/zb7Q2ZKErJ2fHH46DZ15IXxO5H1HbLrz1h6MyM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jm3DrlWHvhwrRAWcOhYCT08IC2QKVK057HsuKkW28wAWOeDg4uXvVHYyhaSP2MYK60OpEl6liF9VAwHGJU8xKjJOt6glBvOKQSoFvMU1y8gvUPyUQGA1XGtCpv+oHKcDwaYgkZMMxgiXIKt7cgSOSsdSvxxlzpsJuOYg8PYgCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYlZb4c0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rLMtTJgO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jul 2024 19:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgghQD1GS5y+CxRBtbJFzg5oxb70LW+yetBybG8bpNs=;
	b=xYlZb4c0xOgRyX2TG2A6yyI/3dK/9AV4IUPD0vhIcSvYkbU8gBMpn7BwW0+nH0rYL43rzh
	OpAJT2lc19r0qIvS4ONSSpBORElOQdCVE+hCvVHor7BHy+qbzpg3zEt6pgeW0G8IbMtpP9
	PcDZN2Cpd18NfE3gA5JJleYMDjxMCex0hiFdMsFlbFOTvwFJjUYIOM3i9bNEDlThh/O+dw
	9qnMMA8tP5xn/3qKhT2zsT0RIiVCYPHyjxo035q0Xwh1WQsTaVCcLLNI90+AVLYa/7D8cn
	DpXfxveL+xU4wMUJlXPDUD0ZO5/SA5basdOYUwGmKKHpd4Olzx87rCYXl/e1IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgghQD1GS5y+CxRBtbJFzg5oxb70LW+yetBybG8bpNs=;
	b=rLMtTJgORTL1ldXIB0wAjjzPNelad3k9SKx7Iyabp3d4BfanTZcyyVDl3h/BfhVt5V848C
	aVT2SQTc8Ur0M8CQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/migration: Do not rely always on group->parent
Cc: Borislav Petkov <bp@alien8.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-1-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-1-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172167692099.2215.7713754687045913875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     facd40aa5c4699f94014012e4e58414c082f2c01
Gitweb:        https://git.kernel.org/tip/facd40aa5c4699f94014012e4e58414c082f2c01
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Jul 2024 18:03:33 +02:00

timers/migration: Do not rely always on group->parent

When reading group->parent without holding the group lock it is racy
against CPUs coming online the first time and thereby creating another
level of the hierarchy. This is not a problem when this value is read once
to decide whether to abort a propagation or not. The worst outcome is an
unnecessary/early CPU wake up. But it is racy when reading it several times
during a single 'action' (like activation, deactivation, checking for
remote timer expiry,...) and relying on the consitency of this value
without holding the lock. This happens at the moment e.g. in
tmigr_inactive_up() which is also calling tmigr_udpate_events(). Code relys
on group->parent not to change during this 'action'.

Update parent struct member description to explain the above only
once. Remove parent pointer checks when they are not mandatory (like update
of data->childmask). Remove a warning, which would be nice but the trigger
of this warning is not reliable and add expand the data structure member
description instead. Expand a comment, why it is safe to rely on parent
pointer here (inside hierarchy update).

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-1-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 33 +++++++++++++++------------------
 kernel/time/timer_migration.h | 12 +++++++++++-
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8441311..d91efe1 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -507,7 +507,14 @@ static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
  *			(get_next_timer_interrupt())
  * @firstexp:		Contains the first event expiry information when last
  *			active CPU of hierarchy is on the way to idle to make
- *			sure CPU will be back in time.
+ *			sure CPU will be back in time. It is updated in top
+ *			level group only. Be aware, there could occur a new top
+ *			level of the hierarchy between the 'top level call' in
+ *			tmigr_update_events() and the check for the parent group
+ *			in walk_groups(). Then @firstexp might contain a value
+ *			!= KTIME_MAX even if it was not the final top
+ *			level. This is not a problem, as the worst outcome is a
+ *			CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
  * @childmask:		childmask of child group
@@ -649,7 +656,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
 
-	if ((walk_done == false) && group->parent)
+	if (walk_done == false)
 		data->childmask = group->childmask;
 
 	/*
@@ -1317,20 +1324,9 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	/* Event Handling */
 	tmigr_update_events(group, child, data);
 
-	if (group->parent && (walk_done == false))
+	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	/*
-	 * data->firstexp was set by tmigr_update_events() and contains the
-	 * expiry of the first global event which needs to be handled. It
-	 * differs from KTIME_MAX if:
-	 * - group is the top level group and
-	 * - group is idle (which means CPU was the last active CPU in the
-	 *   hierarchy) and
-	 * - there is a pending event in the hierarchy
-	 */
-	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
-
 	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 
 	return walk_done;
@@ -1552,10 +1548,11 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 		data.childmask = child->childmask;
 
 		/*
-		 * There is only one new level per time. When connecting the
-		 * child and the parent and set the child active when the parent
-		 * is inactive, the parent needs to be the uppermost
-		 * level. Otherwise there went something wrong!
+		 * There is only one new level per time (which is protected by
+		 * tmigr_mutex). When connecting the child and the parent and
+		 * set the child active when the parent is inactive, the parent
+		 * needs to be the uppermost level. Otherwise there went
+		 * something wrong!
 		 */
 		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 	}
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 6c37d94..494f68c 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -22,7 +22,17 @@ struct tmigr_event {
  * struct tmigr_group - timer migration hierarchy group
  * @lock:		Lock protecting the event information and group hierarchy
  *			information during setup
- * @parent:		Pointer to the parent group
+ * @parent:		Pointer to the parent group. Pointer is updated when a
+ *			new hierarchy level is added because of a CPU coming
+ *			online the first time. Once it is set, the pointer will
+ *			not be removed or updated. When accessing parent pointer
+ *			lock less to decide whether to abort a propagation or
+ *			not, it is not a problem. The worst outcome is an
+ *			unnecessary/early CPU wake up. But do not access parent
+ *			pointer several times in the same 'action' (like
+ *			activation, deactivation, check for remote expiry,...)
+ *			without holding the lock as it is not ensured that value
+ *			will not change.
  * @groupevt:		Next event of the group which is only used when the
  *			group is !active. The group event is then queued into
  *			the parent timer queue.

