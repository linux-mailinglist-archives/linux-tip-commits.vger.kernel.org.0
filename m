Return-Path: <linux-tip-commits+bounces-4762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F1A81567
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D9E7B81E9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F468245020;
	Tue,  8 Apr 2025 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lM+qOySN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQoOU5in"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92001244EA1;
	Tue,  8 Apr 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139135; cv=none; b=AxbyvEhLUpK7Jz0dZLdogstEsH3HhtYdHM+7WYe1U5mYF1lpWTXHZHqdEgu9vJzy31S2nF2z8lX5GQ+sNVDDEVh2kpUa3SqhJrZPyd9GZpNnlhChhFylh7/fcdFEaQ0hoX7vGKTEiThwbIrk//68Zt/N9bJV6t9ACrvrUDqfSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139135; c=relaxed/simple;
	bh=Xv0FjXKuwu34ASaATMpKyf6tN0az2g+m4WiJn32Uo78=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nYJLoPOAVMGIq7nAoK+TTpKXNOVh8qHHfXJaO5xMyxxPn5y0Fagmle2n/4aCJM9AuxHcjtsDgoNxcP+MlnSVg2E7CLvMDx4qmdM8ojXtcHLoAH9dvYgKMkvx5m1MgaUhySsjP0sFJaFK/Oro1dlHDLFfjWIgn3CumSFkHsOhNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lM+qOySN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQoOU5in; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hTONwpnheu+TbCwJZx1Bn2lhv10zXsrzHHi1Tyw8XE=;
	b=lM+qOySNRaGZF+3paQN9NY8ppwGO8YNdr9T3IdBVP5PP5A/VOxPl/yAhhzsB78NHCcyJKn
	bJZ2la2vHFrt4Aaj+C0cK357f09DQpI+LG74fy4frdQ7sXoegy8mp9C8lmZzTVQqVZkLgC
	EtkFcoWuMrOi9FDItLyFQLKrRq6medVrez0tkq8+bM7CPFT8fiQEY8nuGVksNGgmVuVHHj
	8E4cf/WZgxoyvxTofaanmasIvr+Gb083a43WvRKsvEI+oI8kNhwQp4LhyCrii79EzpYNvj
	UTEyldw6OApWfSD+6hzeulDbpX010Pe15yBOFiWNiJr72zMCex+9JJZB9k4VEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hTONwpnheu+TbCwJZx1Bn2lhv10zXsrzHHi1Tyw8XE=;
	b=IQoOU5in5MAZLQIw7Db2xLj34IJktCkrZ54WdJ2qvjw0FM9Peoy6AhKx70zn0Xp5q5ZqOs
	YLZgpLGJgNqKYRAA==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add annotations to RT_GROUP_SCHED fields
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-10-mkoutny@suse.com>
References: <20250310170442.504716-10-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913152.31282.321178145303822403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ab94c3242742bfb540abeedb6bb98440146ac5b
Gitweb:        https://git.kernel.org/tip/0ab94c3242742bfb540abeedb6bb9844014=
6ac5b
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:55 +02:00

sched: Add annotations to RT_GROUP_SCHED fields

Update comments to ease RT throttling understanding.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-10-mkoutny@suse.com
---
 kernel/sched/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 898aab7..c5a6a50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -813,17 +813,17 @@ struct rt_rq {
=20
 #ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
-	u64			rt_time;
-	u64			rt_runtime;
+	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
+	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharin=
g/balancing */
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
=20
 	unsigned int		rt_nr_boosted;
=20
-	struct rq		*rq;
+	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	struct task_group	*tg;
+	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnabl=
e entities */
 #endif
 };
=20

