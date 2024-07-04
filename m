Return-Path: <linux-tip-commits+bounces-1598-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F432927D1E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1317B2877DB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Jul 2024 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0613C9A1;
	Thu,  4 Jul 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BkIM9vX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zm5WNv5d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7A13848A;
	Thu,  4 Jul 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117979; cv=none; b=SvOM8PTwIoJxDdtd/R5fa4yvFfl2MTStWGk5vCh24J1MQZ1HLc9waRHOGDLmlmb5SRcWOsTVjXLVRlDstpXUj3z43EeGvqbVB9QKGNEz8DKLwMyeI/a8lnDiKt/536z7HHCjG8lTkphkN5Lk6ZLzivzZnko0RG5kfggFGTF6JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117979; c=relaxed/simple;
	bh=eClUC7bcrFi8Ypn25d0HlNYCOWLEnFlOTuIJGxSs11s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Je+BJsgzAcn/h5AveSgrdrtEk8WZ1HBsbhQyGs2RCSANUCBtLJce52x3Jmjn5k5pjjJR2mu0Di1wb+DBF0bfjfg43DqldZc/+vUDzTid/voce8Wy9ieulr0ojz5SEyFf8e0Bmrm2DYTb+XkR+S8bFDAZ5iq5yS3AqW0F9LLGDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BkIM9vX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zm5WNv5d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMo54utIv7n2TdgBb6UCVpMBut793aHiFWLHBLBZE7g=;
	b=4BkIM9vXwwHXHq/SMf1K/ATLAHX7LLHFGkrXDkuE0M8/jhDzlSPrzw8R3sNLVWOgcW81FB
	s1Wj6AVmOvzxg3/3pqqzmFiKJ00lFDAGmePFat6VcMjXyeSoUYGHCf5ZmjcgHKaNSe30pS
	edJMvTSh5a8EVdROkxPbHn91ldZ2DUc512YaATQgXgvC6UAvfgf9CHTE+J1R91OUuIAO95
	OW4+fiGbljUzWQE4m5/SMPijYDO3mX4+Ym6JYQcMFkqyEepjsPJz4hjxXL9qEXuOpo28f5
	FQ+rKTZPZzVcX/A0EE/XYv/R9wVTn//D4uY57RCOn69YPVA3AfQzEKg3YRH88w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMo54utIv7n2TdgBb6UCVpMBut793aHiFWLHBLBZE7g=;
	b=Zm5WNv5dcodtCpOYo4GSgQbv3hKwuq0j2L/WViWKGAc9aWnBqLabyDfSF7jdGfF5Z9p+OB
	/LDALn+IpYFUDACw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Improve tracing
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-tmigr-fixes-v3-3-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-3-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797460.2215.13604076055284232952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6d8a8f54e045e2030eebb53b5ce859c80d9425f6
Gitweb:        https://git.kernel.org/tip/6d8a8f54e045e2030eebb53b5ce859c80d9425f6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 12:18:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:24:57 +02:00

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
Link: https://lore.kernel.org/r/20240701-tmigr-fixes-v3-3-25cd5de318fb@linutronix.de

---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9b86efd..f78258a 100644
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
 

