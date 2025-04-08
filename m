Return-Path: <linux-tip-commits+bounces-4770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7493A8157E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408C41894FE1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79A24293C;
	Tue,  8 Apr 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jY40Ryo0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MpolooP0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511282566CC;
	Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139141; cv=none; b=AHzIgdkHzrzyv6GMZJNjKEmNSOW+SQPRVTjYvPUK5V4Oxw6UAufV4uAA1g0tOMz2jBQ3ACVTv3Qyb0D6DEAHBELtIf0nWSntd4FRR9oirp4o59+wYu360u8u+dw2O4IkDdLVZr13QCjCMJnpFpwR16wodO32qij1HHUvfWmz4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139141; c=relaxed/simple;
	bh=9G2wqLzc4BfInNb+YpTbGKNQ/fJobH5jgUlCk776Yac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LSUstQfpq9n5itKFzPQaTG2mXP6T4XhdcH2T5XjruNaZn3cbwi6hl/xijFOs3IfpA9aEH3RCeFLdSFTBqMgIDUgTNAwrnAuNn9CWofmJ0KrSfkhg2aUdMTrmjsPyb69asCEc5KdIj/Q+GHQY5XR4E9g5EO+ABwZmvMal8IBsn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jY40Ryo0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MpolooP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSwAZSwUxf2Jn80qhHtbiK9Y9hZR3vQqZAQ/mzP58II=;
	b=jY40Ryo0MgyHRecwm2eiwJvGrxQ35lJBb7dKu+B+58X40+SPGSmlT5pSok+viPCkgX2NT5
	tZZ4b/L1UXPVYZLjvSg3j5lgAcx49gtZwmpl4fOiA3ZgXa4xVPCJlqb/HNVpzmD3q4reOT
	DaYBAZY4YigRvNmV1PC+q4PVltjzv6Ot0rJUY4hUwp1xbPSVrqA5/oJSJeIqJ2FYY+4qbk
	0FCdF/f/Pn0XcMqK6B/Wv1JccUQ51jlj/oKiIFJrrOq1ov5pYzhBVbAaDHBRNceVBz+38u
	ANdzZHxZWB6ftFPsm3dkI8Prk7/Dqs3bhQyBbtVEEFb0IeJyxOfx/U+7li/mpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSwAZSwUxf2Jn80qhHtbiK9Y9hZR3vQqZAQ/mzP58II=;
	b=MpolooP0JJedEL42v/8l6fdaYz9G8HQYFHh1mDMBf2amBqeQTItF7ObyGgstKPYfIaWezx
	L/BTKdE1tygAl8Cw==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Always initialize rt_rq's task_group
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-4-mkoutny@suse.com>
References: <20250310170442.504716-4-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913619.31282.1198558368261148151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a5a25b32c08a31c03258ec4960bec26caaf76e9a
Gitweb:        https://git.kernel.org/tip/a5a25b32c08a31c03258ec4960bec26caaf=
76e9a
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:53 +02:00

sched: Always initialize rt_rq's task_group

rt_rq->tg may be NULL which denotes the root task_group.
Store the pointer to root_task_group directly so that callers may use
rt_rq->tg homogenously.

root_task_group exists always with CONFIG_CGROUPS_SCHED,
CONFIG_RT_GROUP_SCHED depends on that.

This changes root level rt_rq's default limit from infinity to the
value of (originally) global RT throttling.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-4-mkoutny@suse.com
---
 kernel/sched/rt.c    | 7 ++-----
 kernel/sched/sched.h | 2 ++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 61ec29b..1af3996 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,6 +89,7 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->rt_throttled =3D 0;
 	rt_rq->rt_runtime =3D 0;
 	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+	rt_rq->tg =3D &root_task_group;
 #endif
 }
=20
@@ -482,9 +483,6 @@ static inline bool rt_task_fits_capacity(struct task_stru=
ct *p, int cpu)
=20
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
 {
-	if (!rt_rq->tg)
-		return RUNTIME_INF;
-
 	return rt_rq->rt_runtime;
 }
=20
@@ -1154,8 +1152,7 @@ inc_rt_group(struct sched_rt_entity *rt_se, struct rt_r=
q *rt_rq)
 	if (rt_se_boosted(rt_se))
 		rt_rq->rt_nr_boosted++;
=20
-	if (rt_rq->tg)
-		start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
+	start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
 }
=20
 static void
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f3..c006348 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -821,6 +821,8 @@ struct rt_rq {
 	unsigned int		rt_nr_boosted;
=20
 	struct rq		*rq;
+#endif
+#ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg;
 #endif
 };

