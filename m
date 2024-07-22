Return-Path: <linux-tip-commits+bounces-1742-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADDA939454
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447B7282539
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Jul 2024 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68917109B;
	Mon, 22 Jul 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URS7lFOa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjLwmh7U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A716F26C;
	Mon, 22 Jul 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676922; cv=none; b=j9dwgbrX5TK20ufIqMoDYk7+V8M0Z9VWOEB9SIrb67gLCpgol1iRyN3N1aP6OjXyyqE/O4xx4mFGWWs/kgmhyMrtBEsd6VQVG9H8ezRdODC1TCqPNa/CDYeD/8vEovxMcTo4Lmqub1Yp2dC4MKtzGRQF5/5wnBbQNoK0jJ4O2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676922; c=relaxed/simple;
	bh=AzZ1GGaI9MS6dw4foizTUPVu8Y/HuRXBzN92GtGW+Ig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LYxii2OYfceG6nhjhEUHs3Hr5l/hMP46m5NKZcMoY+3wXSXzbI18DEt4hKWBpEXWDxhgzrLwfHc4yxHf/Hx8PPd696R3/R96jtleKMqiVr6j2Pez9MlU5AzERUQ07LOrFJ+qZR8ZDi5FvEYizzUn2R+57MBeh+p2sGGZZJXSueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=URS7lFOa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjLwmh7U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jul 2024 19:35:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8eqUx5LC5QEgpDD+fIr9ODSvBAvLZd21BS1DCzDr9s=;
	b=URS7lFOaHUwrxVrQ91PJUot03QVNu78tN68xJoBp/GAvO8baoDW55keqILOOfE0fKm106g
	sBmQO6COoQnE6FbdVV23VvxPRogOkZ4pp6JORVVQPE2D0LvlKIDxFCZ8ANrr4fiPgkrKva
	+WkdGKDOLuN3hVANX7GzF8t5DVeIhf8+1gdtQPuDX9f8D4M46t8SxnaufkUJg+YsGJEmVB
	Na1CSbwBcv1wUUDGze0jk00D4wkblXewFjIqAwXXuMRNVovjXfvKBAch8JTeJ0LTybXAwv
	zWVJa2NrvKXViwbeopM4QlfhyI86JsZOnxNc19+Ehd31R31sRUfeBuvtmIz2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8eqUx5LC5QEgpDD+fIr9ODSvBAvLZd21BS1DCzDr9s=;
	b=mjLwmh7UTOywO72SQe8v8x+kgZeiEo8QC6f6Mzz3LKe7I0QPVPbk1QkLwAxGFUGxXXm2hE
	3RCuW1Qz8ECnpYBA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Read childmask and parent
 pointer in a single place
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172167691924.2215.2710732679471029604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     d47be589844224a3ef13b55ff6f15211ab20f1d1
Gitweb:        https://git.kernel.org/tip/d47be589844224a3ef13b55ff6f15211ab20f1d1
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Jul 2024 18:03:34 +02:00

timers/migration: Read childmask and parent pointer in a single place

Reading the childmask and parent pointer is required when propagating
changes through the hierarchy. At the moment this reads are spread all over
the place which makes it harder to follow.

Move those reads to a single place to keep code clean.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9f0c284..f5652b0 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -535,6 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
+		data->childmask = child->childmask;
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
 

