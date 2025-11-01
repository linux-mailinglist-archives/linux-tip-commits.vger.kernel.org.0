Return-Path: <linux-tip-commits+bounces-7129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03786C286B0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E74F1378
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D03009D2;
	Sat,  1 Nov 2025 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxXOxQQL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKi2j5Yu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2541A256B;
	Sat,  1 Nov 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026091; cv=none; b=sGedoC8YZAvf6pgsWVD6nS/Q/GkG8VXp5JqkEu0co/zSTA1GyYlAYyL/CL358Zl3qhzV/+DTMCO/WAxOkOfwZEolMVb4xiBxCCseVrnOr1XCCWfZt8iQzHKK16jwSahVd2+vZoIS+ZuGoEdUXA3x8pXp2n8Z901olKFY94jTIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026091; c=relaxed/simple;
	bh=SB+uqR4RklFumq/SiN0MA5mztX4VnEd0WXJOxTkELcM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ikTJ4pyMpL7obbEgWuNxkVkPCl+35KpETWtu9FRBL1mD9QWnfzfqc9i5xn9B24hIOAMc9G1a+rbvI8suhiEnyN/K5ZmDbiz0VkmKN9cKDae034WnXkBgXKqptss2uxt9w4SO/HPAd2D1lg3sm0RVCBj+AEVC1qNSEevSBr+AbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxXOxQQL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKi2j5Yu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX5Wsd8K4RNfYvMrGQrY1erbJwrSNZaWvBndZa7B9y0=;
	b=AxXOxQQLbh+zLqYGqt6vaIOsSZThfn50dWT9NnFiYc6MDHLzlfhf9LM9AGhgvBAkw9CnMj
	r9U7jfP1Pgbh97Ljj4ZXSqlBUkJxKJC7ft9CY6pceF8fMoat4RP+nlUgPPGyHeFw7uicUZ
	MySp3OJIpLsMWYITdqabWF7/C1V7SNRImzYzMA/pjppalFLTz+WmnLtr7W0SkMGICLkKOM
	2pseWatNRcAmwVHpIH0D3kIngun+aK2P43mFnvAGkz401Yteab9jJ3rhWL8VzVuZiQr4fs
	DIeJCzibk+AMpirMx4tCR/v0KMLPs3Yz8kugBeT+xbySHeKZuRC7Cx/rmsHTog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX5Wsd8K4RNfYvMrGQrY1erbJwrSNZaWvBndZa7B9y0=;
	b=dKi2j5YuA7EnB89bbNFUOw5///tFhqNH92EzLRYf5+LZtiTnWO8W1raTgdp+jfJvEv/sh3
	KxJp5GmVpoP6sLDw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/migration: Remove locking on group connection
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024132536.39841-3-frederic@kernel.org>
References: <20251024132536.39841-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202608661.2601451.1934899095034372531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fa9620355d4192200f15cb3d97c6eb9c02442249
Gitweb:        https://git.kernel.org/tip/fa9620355d4192200f15cb3d97c6eb9c024=
42249
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 24 Oct 2025 15:25:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:38:25 +01:00

timers/migration: Remove locking on group connection

Initializing the tmc's group, the group's number of children and the
group's parent can all be done without locking because:

  1) Reading the group's parent and its group mask is done locklessly.

  2) The connections prepared for a given CPU hierarchy are visible to the
     target CPU once online, thanks to the CPU hotplug enforced memory
     ordering.

  3) In case of a newly created upper level, the new root and its
     connections and initialization are made visible by the CPU which made
     the connections. When that CPUs goes idle in the future, the new link
     is published by tmigr_inactive_up() through the atomic RmW on
     ->migr_state.

  4) If CPUs were still walking up the active hierarchy, they could observe
     the new root earlier. In this case the ordering is enforced by an
     early initialization of the group mask and by barriers that maintain
     address dependency as explained in:

     b729cc1ec21a ("timers/migration: Fix another race between hotplug and id=
le entry/exit")
     de3ced72a792 ("timers/migration: Enforce group initialization visibility=
 to tree walkers")

  5) Timers are propagated by a chain of group locking from the bottom to
     the top. And while doing so, the tree also propagates groups links
     and initialization. Therefore remote expiration, which also relies
     on group locking, will observe those links and initialization while
     holding the root lock before walking the tree remotely and update
     remote timers. This is especially important for migrators in the
     active hierarchy that may observe the new root early.

Therefore the locking is unnecessary at initialization. If anything, it
just brings confusion. Remove it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-3-frederic@kernel.org
---
 kernel/time/timer_migration.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1e371f1..5f8aef9 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1573,9 +1573,6 @@ static void tmigr_connect_child_parent(struct tmigr_gro=
up *child,
 {
 	struct tmigr_walk data;
=20
-	raw_spin_lock_irq(&child->lock);
-	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
 	if (activate) {
 		/*
 		 * @child is the old top and @parent the new one. In this
@@ -1596,9 +1593,6 @@ static void tmigr_connect_child_parent(struct tmigr_gro=
up *child,
 	 */
 	smp_store_release(&child->parent, parent);
=20
-	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
-
 	trace_tmigr_connect_child_parent(child);
=20
 	if (!activate)
@@ -1695,13 +1689,9 @@ static int tmigr_setup_groups(unsigned int cpu, unsign=
ed int node)
 		if (i =3D=3D 0) {
 			struct tmigr_cpu *tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
=20
-			raw_spin_lock_irq(&group->lock);
-
 			tmc->tmgroup =3D group;
 			tmc->groupmask =3D BIT(group->num_children++);
=20
-			raw_spin_unlock_irq(&group->lock);
-
 			trace_tmigr_connect_cpu_parent(tmc);
=20
 			/* There are no children that need to be connected */

