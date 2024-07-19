Return-Path: <linux-tip-commits+bounces-1732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F76937C00
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE141F216EF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE2146D78;
	Fri, 19 Jul 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGTVctp+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N+VVD7et"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16A146587;
	Fri, 19 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412375; cv=none; b=DjIaZtcEJZpIwIsziskR5la5Qe3Y1Cp+IrEudyEtJk8sKsidYBpkOU6IZBVnh0r3G0guHxEotawRZ7USvK0WvWHlSgMjXPGbv1Fi/UXBWNmv+zTEPvr/INuryRLhyz6mWCSF+YPk6sdk3KMiagVmYw6TfOu8UdmAWp00vF+irBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412375; c=relaxed/simple;
	bh=f7NIIrOeaLFWkOd8kAhxEyXO+3yNSus6NWgZMkgQh64=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BWHk0mOKisQ0TmNJja99AJF608yPzUXeQPeRDrYLR9sCr82XG6+qxPw11nrK/hVi7Z9zdLoiELElhba1P78J8tf6k8gHqWPUF3fcP51/k/thPEEeoZio3sgiPMRsQdbidAEM147DGwHakfIsPoIdPPfsndOULthfIgwspAcUzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGTVctp+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N+VVD7et; arc=none smtp.client-ip=193.142.43.55
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
	bh=Mv0wwxRcdQSs23Q+CM/oxDB8AY2PAoE3XQmRw+UHY1M=;
	b=rGTVctp+R+PnAMcuRfEryFATPVIhLyVUzJM7BLfd701g8Ck5UwzQXKpG+/GpEkbnxWLl55
	f5UoFMDt5/yjq6HyZfQBdsUDX0ZQ56yOJxRQ81usUw+1L9+yhv8+bstPCn73p800hiZuL3
	qPZ8xIbyeDdUNTqsGKUySGdu9dd6I/Hc9wRCvNFTqFn2/QRedRt1lgl08sIavKE0wUaWnm
	A9/xemCbAXbZM7Ekd5a1+3QxInAeSU3nPonGojhXxIP4VvlVbaT0GBk1R8iBUe6N9aHwh8
	IIcB0JuPFxRqjV6rt+0XRaCHMO/j0bsMIFxnkxPP5dtgWCt2G94bNJUb4H/YJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv0wwxRcdQSs23Q+CM/oxDB8AY2PAoE3XQmRw+UHY1M=;
	b=N+VVD7etnimgKFGuim14YkEUVwBZO0N9HVQ4BTm2Mvn/+WMKEzqMb9QaY5a6eB7YkHWitx
	Ar9NdOP5dQEC4RCQ==
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
Message-ID: <172141237192.2215.3980137557769778526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c9b3f0871f535e0ccbe34e5e7a15567e73bec806
Gitweb:        https://git.kernel.org/tip/c9b3f0871f535e0ccbe34e5e7a15567e73bec806
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:01 +02:00

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
index a32c8a7..6af1f21 100644
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
 

