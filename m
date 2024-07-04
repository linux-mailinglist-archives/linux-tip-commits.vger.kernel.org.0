Return-Path: <linux-tip-commits+bounces-1594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96E7927D15
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF10B22D1A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAE78C94;
	Thu,  4 Jul 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H5o38hFI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Waf3v04d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992745979;
	Thu,  4 Jul 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117977; cv=none; b=ALfamyveNm5I9lYJMQK1odAxdn4Nk3sxRx/T4ARb931WB720WgHTcYO2Gx+4cY0yYzbW9pGSiNcmeWYLIqcu5cJYVPB//cKfnPwS8V4L2pMGYgfd3PmKqsfkfX7ydXU7y43+vzm0mfQavNaBWGjftwAFbcXUG2LzwykKzPYPFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117977; c=relaxed/simple;
	bh=67ax5KtiplvNKwdZ32Fz4pfYVvLtxesNRF3kHiQMprM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qb00h6RbcrfTwakrTn0b09FRdOrcy+lsB4s86osaznhoqrI4ugQN3TzfQZIGtcPZQNdypHNWChAnFUK9q2NxWx+M3eHD9lzvQRevMk6aEc0+KEll0XH7kox4XidJuBvp9LzcV24KUAxIg65XrF55mqFL9ah1uHZSA1zAPvzV25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H5o38hFI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Waf3v04d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EegP8wk+ESjNjVqYmn4/YRv1bWV0Q19mRNx9OIou07E=;
	b=H5o38hFII5swiVItItWBZrnayZel+TzTAhkP9DqSdkccGLw90XImDZR2lkC4HOl6uG8NhR
	mxg8tpyuHrz4+GbQwlXS+DuWTtgeEGVjDM9rpbZ3j1naIo0hACI6T/tD5iXc78Irx1o6JW
	StyHbd4HNuXpOnSh9LdnpiOduoLnD+3OubDdTdNLtPt7Wbrp8fqTJCdmw/FNgv3EXRrRty
	lOmx9mdBEjjMI85LY6brgPEhBBYsLi694tYF07OotvhJyP2JgMZ029ly3ogLInwgVPgvcI
	Ok1C0MD4f/cIc1ldBKZSw31CDPi2JyF9YuSeHymHO+4daLsOHzB6k3su476lsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EegP8wk+ESjNjVqYmn4/YRv1bWV0Q19mRNx9OIou07E=;
	b=Waf3v04dIWaY+kkwApXuvZohMcGhXU13a/hehwsVLcx2ixy1JseQnKuKTZCU3qkrJyd1eu
	1PjnGygEUILJYFDQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Read childmask and parent
 pointer in a single place
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797394.2215.6645440287912174819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56f9a5fd69eae92d7051a228ee192452248a6bdc
Gitweb:        https://git.kernel.org/tip/56f9a5fd69eae92d7051a228ee192452248a6bdc
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 12:18:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:24:57 +02:00

timers/migration: Read childmask and parent pointer in a single place

Reading the childmask and parent pointer is required when propagating
changes through the hierarchy. At the moment this reads are spread all over
the place which makes it harder to follow.

Move those reads to a single place to keep code clean.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de

---
 kernel/time/timer_migration.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 39eb77e..1fb9305 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -535,6 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
+		data->childmask = group->childmask;
 	} while (group);
 }
 
@@ -647,9 +648,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
 
-	if (walk_done == false)
-		data->childmask = group->childmask;
-
 	/*
 	 * The group is active (again). The group event might be still queued
 	 * into the parent group's timerqueue but can now be handled by the
@@ -1027,12 +1025,10 @@ again:
 	}
 
 	/*
-	 * Update of childmask for the next level and keep track of the expiry
-	 * of the first event that needs to be handled (group->next_expiry was
-	 * updated by tmigr_next_expired_groupevt(), next was set by
-	 * tmigr_handle_remote_cpu()).
+	 * Keep track of the expiry of the first event that needs to be handled
+	 * (group->next_expiry was updated by tmigr_next_expired_groupevt(),
+	 * next was set by tmigr_handle_remote_cpu()).
 	 */
-	data->childmask = group->childmask;
 	data->firstexp = group->next_expiry;
 
 	raw_spin_unlock_irq(&group->lock);
@@ -1110,7 +1106,7 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 	 * group before reading the next_expiry value.
 	 */
 	if (group->parent && !data->tmc_active)
-		goto out;
+		return false;
 
 	/*
 	 * The lock is required on 32bit architectures to read the variable
@@ -1135,9 +1131,6 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 		raw_spin_unlock(&group->lock);
 	}
 
-out:
-	/* Update of childmask for the next level */
-	data->childmask = group->childmask;
 	return false;
 }
 
@@ -1309,9 +1302,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	/* Event Handling */
 	tmigr_update_events(group, child, data);
 
-	if (walk_done == false)
-		data->childmask = group->childmask;
-
 	return walk_done;
 }
 

