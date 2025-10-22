Return-Path: <linux-tip-commits+bounces-6982-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B1BFC234
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 15:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C96F3355E86
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC16340A46;
	Wed, 22 Oct 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlGAF1qz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lutNeTqZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5A30E839;
	Wed, 22 Oct 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139736; cv=none; b=KIFsOjL5uF5Xo2FPqWaZ0awHLRAMvh492LyIwKvJMH4+6YD4eyRT0PhFAiSeKzjW/AaWGzuIMT9BhAH+dqZRZaZQYlC0NAOtr9rOUhgNdz57UW/aLAgKDrtEgRqpXrSGmpkqsvhznd8dlKm2R/O5eXpe8Wam//gh0wKvvVtJscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139736; c=relaxed/simple;
	bh=y+yk3fvaO6+evs/kKudiXRsKupRYtgTy7o+DnPU9nBs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R3p0CADAaZg8L1+kABiaw4OByj8WmH4NeXe4rdaP49AxUemmh5KH7C44s6wujF/ew0WsqvMVe0My7/BcGQvOFYWobige5r/z5gd/wXp3Im8KCgTNZxI9wW4t4mk+rF/9yOI/Aym9+A3ArFMuus552tvjHjX1Ps98US5hED92kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlGAF1qz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lutNeTqZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 13:28:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761139733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AfIN0xIo5sEWwKVam1heAXdF0CSC9fulhyasij95KU=;
	b=tlGAF1qzbllL14jueIK0YdU/WS2pJ1bDmO0GRl3HW0DQ+2iDYrOqIqUuLedEx2NVcV0T6P
	m3mpjty9K4jiO6XJ0gRGqoffvy+YzoD77gyC63e384v6zq06Ozna46VJG399NASN1izPh/
	/MlKf5a4SJBPWZl99Fbz895E/dvriKdehg7+9HWZAIM8+WU2rT+el2FFscr21ooG6Qqsen
	9vyOCPV+iQWCkSTNFQQFgeiv3FskF2pL79FoqDtH7rskXedlPWsF9LacLqR6uFgyr+bHuz
	Db5sw2g8RK8ECYrheY9ZDNImMH4SHtvlau+S/OkeSoY3dtxravLBtsHRZviCkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761139733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AfIN0xIo5sEWwKVam1heAXdF0CSC9fulhyasij95KU=;
	b=lutNeTqZkDLpkjo/zQlOM9ZGOHhIFNxJ1cFMamcYEP2leusjrNVyo2+4sNOqM4PaE/kvHb
	62GMIXmyDd6M+GAQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Start a cfs_rq on throttled hierarchy
 with PELT clock throttled
Cc: Matteo Martelli <matteo.martelli@codethink.co.uk>,
 Aaron Lu <ziqianlu@bytedance.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251021053522.37583-1-kprateek.nayak@amd.com>
References: <20251021053522.37583-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113973152.2601451.18222178896894961201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0e4a169d1a2b630c607416d9e3739d80e176ed67
Gitweb:        https://git.kernel.org/tip/0e4a169d1a2b630c607416d9e3739d80e17=
6ed67
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Tue, 21 Oct 2025 05:35:22=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Oct 2025 15:21:52 +02:00

sched/fair: Start a cfs_rq on throttled hierarchy with PELT clock throttled

Matteo reported hitting the assert_list_leaf_cfs_rq() warning from
enqueue_task_fair() post commit fe8d238e646e ("sched/fair: Propagate
load for throttled cfs_rq") which transitioned to using
cfs_rq_pelt_clock_throttled() check for leaf cfs_rq insertions in
propagate_entity_cfs_rq().

The "cfs_rq->pelt_clock_throttled" flag is used to indicate if the
hierarchy has its PELT frozen. If a cfs_rq's PELT is marked frozen, all
its descendants should have their PELT frozen too or weird things can
happen as a result of children accumulating PELT signals when the
parents have their PELT clock stopped.

Another side effect of this is the loss of integrity of the leaf cfs_rq
list. As debugged by Aaron, consider the following hierarchy:

    root(#)
   /    \
  A(#)   B(*)
         |
         C <--- new cgroup
         |
         D <--- new cgroup

  # - Already on leaf cfs_rq list
  * - Throttled with PELT frozen

The newly created cgroups don't have their "pelt_clock_throttled" signal
synced with cgroup B. Next, the following series of events occur:

1. online_fair_sched_group() for cgroup D will call
   propagate_entity_cfs_rq(). (Same can happen if a throttled task is
   moved to cgroup C and enqueue_task_fair() returns early.)

   propagate_entity_cfs_rq() adds the cfs_rq of cgroup C to
   "rq->tmp_alone_branch" since its PELT clock is not marked throttled
   and cfs_rq of cgroup B is not on the list.

   cfs_rq of cgroup B is skipped since its PELT is throttled.

   root cfs_rq already exists on cfs_rq leading to
   list_add_leaf_cfs_rq() returning early.

   The cfs_rq of cgroup C is left dangling on the
   "rq->tmp_alone_branch".

2. A new task wakes up on cgroup A. Since the whole hierarchy is already
   on the leaf cfs_rq list, list_add_leaf_cfs_rq() keeps returning early
   without any modifications to "rq->tmp_alone_branch".

   The final assert_list_leaf_cfs_rq() in enqueue_task_fair() sees the
   dangling reference to cgroup C's cfs_rq in "rq->tmp_alone_branch".

   !!! Splat !!!

Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
enough since the new cfs_rq is not yet enqueued on the hierarchy. A
dequeue on other subtree on the throttled hierarchy can freeze the PELT
clock for the parent hierarchy without setting the indicators for this
newly added cfs_rq which was never enqueued.

Since there are no tasks on the new hierarchy, start a cfs_rq on a
throttled hierarchy with its PELT clock throttled. The first enqueue, or
the distribution (whichever happens first) will unfreeze the PELT clock
and queue the cfs_rq on the leaf cfs_rq list.

While at it, add an assert_list_leaf_cfs_rq() in
propagate_entity_cfs_rq() to catch such cases in the future.

Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethi=
nk.co.uk/
Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Link: https://patch.msgid.link/20251021053522.37583-1-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cee1793..25970db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6437,6 +6437,16 @@ static void sync_throttle(struct task_group *tg, int c=
pu)
=20
 	cfs_rq->throttle_count =3D pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(cpu_rq(cpu));
+
+	/*
+	 * It is not enough to sync the "pelt_clock_throttled" indicator
+	 * with the parent cfs_rq when the hierarchy is not queued.
+	 * Always join a throttled hierarchy with PELT clock throttled
+	 * and leaf it to the first enqueue, or distribution to
+	 * unthrottle the PELT clock.
+	 */
+	if (cfs_rq->throttle_count)
+		cfs_rq->pelt_clock_throttled =3D 1;
 }
=20
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
@@ -13187,6 +13197,8 @@ static void propagate_entity_cfs_rq(struct sched_enti=
ty *se)
 		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
+
+	assert_list_leaf_cfs_rq(rq_of(cfs_rq));
 }
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
 static void propagate_entity_cfs_rq(struct sched_entity *se) { }

