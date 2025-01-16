Return-Path: <linux-tip-commits+bounces-3272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4772A1398D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 12:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676A63A6C94
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026B1DE4E7;
	Thu, 16 Jan 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVAJ98XQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrD8tMQt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102031DE4E0;
	Thu, 16 Jan 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028763; cv=none; b=bVq6eXaUGUMF+HXfkMRxgL9w2ohdiAtyv7v5O7fuWMJJf8g4cquAiLpLtqAe1zfWD9mDeIJSr2XJ5wk6rgE5bDe/8s3NOeMqh3Mm/Z1w3wbnI0F2g05JUEmm0xnowYwnqHOFjhxIX8mvWjqPjBKAD/twG1FukWOKRCB9X58BuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028763; c=relaxed/simple;
	bh=cmCnU3RkbyUcFgd+DhzLX4G8jl1jAmr8haEItWx2c/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b0hKtZ5gcMvipg5qGMY+0mGd6M4cpK1RrgJnDVLFdQqJz4VmomWoGeVLWJSF5ZiQSsVO/YsFRSAiU3n+PtdMuB/BpTqgcfyT7MfXsgR9MgtzONRZfHmMTZ2d1wLZA0YxFWD7kX1Vny70neEdpJHiWe80dt2h7uyznfYVypTEX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVAJ98XQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrD8tMQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 11:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737028759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW44LGp0CjeZbAvtY6QgnQOLtRfjjLfhiXUJkxqEaCg=;
	b=jVAJ98XQK/AuedX83YfxpMxnlHcSCydFbkAvQ6IJKKpNY37RFdeu55Z0R19U7jqJOB4ne1
	Dke6atWVqvN7tY3+HQ4Zm4NxOaWRm/+glmpH0W7dpnfGV4fUVA/JDqowv1IWChtsn4r6b6
	ELBFv2RrNuRBdhhrjyBOSeBxYcJzd7b/zxXy/smdrLdwzjQGqZ/JatGdXM55hAISZrr1iB
	vP7HimTs4tSEYW5C/DKl4EbpdFMhvTqnkk+xmzWiomG8Ej9zNd7ZNQcsQIzD9fQ/gBT9rz
	p5xFW5xP4rIeDI54phbiL6GMMoWbuME/ygdRHUXmRo76VK8aqB1dLiRALwawgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737028759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW44LGp0CjeZbAvtY6QgnQOLtRfjjLfhiXUJkxqEaCg=;
	b=wrD8tMQtLI9x+cpG+FRCxahQjUX4OqOHtOsolpq5cNL7F2ha+QOkQawGSNEencL53qYs5E
	8qfdbR0NRpIvM9Bw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/migration: Annotate accesses to ignore flag
Cc: kernel test robot <oliver.sang@intel.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114231507.21672-4-frederic@kernel.org>
References: <20250114231507.21672-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173702875843.31546.4059031387893041725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     922efd298bb2636880408c00942dbd54d8bf6e0d
Gitweb:        https://git.kernel.org/tip/922efd298bb2636880408c00942dbd54d8bf6e0d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 00:15:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 12:47:11 +01:00

timers/migration: Annotate accesses to ignore flag

The group's ignore flag is:

_ read under the group's lock (idle entry, remote expiry)
_ turned on/off under the group's lock (idle entry, remote expiry)
_ turned on locklessly on idle exit

When idle entry or remote expiry clear the "ignore" flag of a group, the
operation must be synchronized against other concurrent idle entry or
remote expiry to make sure the related group timer is never missed. To
enforce this synchronization, both "ignore" clear and read are
performed under the group lock.

On the contrary, whether idle entry or remote expiry manage to observe
the "ignore" flag turned on by a CPU exiting idle is a matter of
optimization. If that flag set is missed or cleared concurrently, the
worst outcome is a migrator wasting time remotely handling a "ghost"
timer. This is why the ignore flag can be set locklessly.

Unfortunately, the related lockless accesses are bare and miss
appropriate annotations. KCSAN rightfully complains:

		 BUG: KCSAN: data-race in __tmigr_cpu_activate / print_report

		 write to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 0:
		 __tmigr_cpu_activate
		 tmigr_cpu_activate
		 timer_clear_idle
		 tick_nohz_restart_sched_tick
		 tick_nohz_idle_exit
		 do_idle
		 cpu_startup_entry
		 kernel_init
		 do_initcalls
		 clear_bss
		 reserve_bios_regions
		 common_startup_64

		 read to 0xffff88842fc28004 of 1 bytes by task 0 on cpu 1:
		 print_report
		 kcsan_report_known_origin
		 kcsan_setup_watchpoint
		 tmigr_next_groupevt
		 tmigr_update_events
		 tmigr_inactive_up
		 __walk_groups+0x50/0x77
		 walk_groups
		 __tmigr_cpu_deactivate
		 tmigr_cpu_deactivate
		 __get_next_timer_interrupt
		 timer_base_try_to_set_idle
		 tick_nohz_stop_tick
		 tick_nohz_idle_stop_tick
		 cpuidle_idle_call
		 do_idle

Although the relevant accesses could be marked as data_race(), the
"ignore" flag being read several times within the same
tmigr_update_events() function is confusing and error prone. Prefer
reading it once in that function and make use of similar/paired accesses
elsewhere with appropriate comments when necessary.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-4-frederic@kernel.org
Closes: https://lore.kernel.org/oe-lkp/202501031612.62e0c498-lkp@intel.com
---
 kernel/time/timer_migration.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 371a62a..066c9dd 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -569,7 +569,7 @@ static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
 	while ((node = timerqueue_getnext(&group->events))) {
 		evt = container_of(node, struct tmigr_event, nextevt);
 
-		if (!evt->ignore) {
+		if (!READ_ONCE(evt->ignore)) {
 			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
 			return evt;
 		}
@@ -665,7 +665,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 * lock is held while updating the ignore flag in idle path. So this
 	 * state change will not be lost.
 	 */
-	group->groupevt.ignore = true;
+	WRITE_ONCE(group->groupevt.ignore, true);
 
 	return walk_done;
 }
@@ -726,6 +726,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	union tmigr_state childstate, groupstate;
 	bool remote = data->remote;
 	bool walk_done = false;
+	bool ignore;
 	u64 nextexp;
 
 	if (child) {
@@ -744,11 +745,19 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		nextexp = child->next_expiry;
 		evt = &child->groupevt;
 
-		evt->ignore = (nextexp == KTIME_MAX) ? true : false;
+		/*
+		 * This can race with concurrent idle exit (activate).
+		 * If the current writer wins, a useless remote expiration may
+		 * be scheduled. If the activate wins, the event is properly
+		 * ignored.
+		 */
+		ignore = (nextexp == KTIME_MAX) ? true : false;
+		WRITE_ONCE(evt->ignore, ignore);
 	} else {
 		nextexp = data->nextexp;
 
 		first_childevt = evt = data->evt;
+		ignore = evt->ignore;
 
 		/*
 		 * Walking the hierarchy is required in any case when a
@@ -774,7 +783,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		 * first event information of the group is updated properly and
 		 * also handled properly, so skip this fast return path.
 		 */
-		if (evt->ignore && !remote && group->parent)
+		if (ignore && !remote && group->parent)
 			return true;
 
 		raw_spin_lock(&group->lock);
@@ -788,7 +797,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+		if ((evt->nextevt.expires == nextexp) && !ignore) {
 			/* Make sure not to miss a new CPU event with the same expiry */
 			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
@@ -798,7 +807,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);
 	}
 
-	if (evt->ignore) {
+	if (ignore) {
 		/*
 		 * When the next child event could be ignored (nextexp is
 		 * KTIME_MAX) and there was no remote timer handling before or

