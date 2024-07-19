Return-Path: <linux-tip-commits+bounces-1735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF2937C06
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21681C20F13
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jul 2024 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118D148316;
	Fri, 19 Jul 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrb6uvgZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sCIjIH6Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495731474BF;
	Fri, 19 Jul 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412377; cv=none; b=Bfj8PVMvwza+/q9HkUK1q3nGDS2rUTHioUFZD2kZZ7Wt9UTlES9fKiU9FYA8bhC5EBQqh5ST6iQyAuiQWcLWGvc0nrvZguQ7vDx9HBKdhCfxh4E5x5ug77O4UHaYkSSMRjPBgjqxE+wci0dp7V0dlqEUc7qpkeT2GVfmmDMP7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412377; c=relaxed/simple;
	bh=kxuR/n3vlqosafYBnRn7uFiooeMtFVt7r3AMBFQeuJU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Axo324GuOgIjBAMjxqdZMENArI2aQsZqWjHzPQgYvyZlPXvpxrHCTo4v7uMhgfnLpVrbKDb9XZAaIMwHe4UB01uZXYOXJdfpcWL/c5jhmlQUh9220GYM9r7jIG+QWzcCRtbt9Q7SUZo2rezlwE5tQM/MYgv1jUnlDectU1cs10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrb6uvgZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sCIjIH6Z; arc=none smtp.client-ip=193.142.43.55
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
	bh=96sPhq7CN+BBcWkLqqEynQ9f4r1SME+qPYqyx7TLv+M=;
	b=yrb6uvgZ8e527L6KOjvITtcyXdjYgQK37mgvhvJaUz5w5ZkWkBqCw2em7r8yvWBna76g02
	dJofhPFND6RMEZI2YyYLjgSOAjcjLM/+PpXN2JL/cxIavmoFkAOe3Zw/PSaU3GSLY+cYEn
	rOrQqx1N8/rtCyVOR4sPfvrkRV2RQmnDn6oE21sApsPGh4sKp3T+MvECKiIZYqljFCSjyr
	HaChw+hxf1p07Hdc60F0SWzmUE28LOHA0nGtCPWXh1RzJnfE6GmWIN24qe5PTM+iMVwHvh
	ozitNPDvqaNJzxSPFAZo9uOplOM29FeK2hIVIQt1CZ9Zqe0O9w8SJ0sUQC7gRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721412372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96sPhq7CN+BBcWkLqqEynQ9f4r1SME+qPYqyx7TLv+M=;
	b=sCIjIH6ZFxB3AOwBn/CRuZB3+aI0CEjnBEsU8RlOWhhNUf3QE8YqW1U/XZBQMOmSn8RvAM
	lrSVmzxHkP0JGZDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Improve tracing
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-tmigr-fixes-v4-3-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-3-757baa7803fe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172141237250.2215.9502135617012880283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     96c402145563872aff452efd37c6833440e6d096
Gitweb:        https://git.kernel.org/tip/96c402145563872aff452efd37c6833440e6d096
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 16 Jul 2024 16:19:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jul 2024 19:58:01 +02:00

timers/migration: Improve tracing

Trace points of inactive and active propagation are located at the end of
the related functions. The interesting information of those trace points is
the updated group state. When trace points are not located directly at the
place where group state changed, order of trace points in traces could be
confusing.

Move inactive and active propagation trace points directly after update of
group state values.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240716-tmigr-fixes-v4-3-757baa7803fe@linutronix.de

---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d077fa5..e618ea3 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -656,6 +656,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
@@ -673,8 +675,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
-
 	return walk_done;
 }
 
@@ -1306,9 +1306,10 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 
 		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
 
-		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
-				       newstate.state))
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+			trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 			break;
+		}
 
 		/*
 		 * The memory barrier is paired with the cmpxchg() in
@@ -1327,8 +1328,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
-
 	return walk_done;
 }
 

