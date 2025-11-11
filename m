Return-Path: <linux-tip-commits+bounces-7309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC2C4F0D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DEC4F0F5B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19263730C2;
	Tue, 11 Nov 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVUc1kUa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3rq6NcF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6C274B48;
	Tue, 11 Nov 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878786; cv=none; b=NWYdC3hQ1dJUA2SQ7yO59CHjZETnOvSHh/jlSpi7l22Xt4Aj/cKYY7/SvIJ96fG5qLxooKilovRwnTupn+rexGeLjYuxgYJnAKVMJpJVfDGZ0RyBjcwh1dP1wnVDHVIkuFo284kpYe3SzcOeMogKs/pHDqiljqppHXEpn/4cdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878786; c=relaxed/simple;
	bh=fgEBa+2ljKVAUWu8Ak91pji2K1058E44SeMEhkhxd2U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Q+fbJm+sOZb3DBLOEFJqgVTfhD6z6gW5gOfnNcJhZdDdSq2Wfdy1qtwq/89gFX/IHKxnwNVsnwnAzFxzpqriNU6jnRLite8ebfGjpRUS1+KzipOOYnBxlA56/o1KCDxlxmBBmJynecgEyP3gbMm+SJMZd+68tSuIIKmeaLsSloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVUc1kUa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X3rq6NcF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 16:33:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762878783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=er4demuavKyIkUj7zp5Id11j531DnvRcPCRTi0S8mVo=;
	b=JVUc1kUa0pXO6DYDhBOEHtYFDc5w8mAR52n2nmDgAeFopFK603Ty4xp4zQV5U2z27p1mqb
	lv0vA2Whh7/Uq+EhTiNzqThbVdi472xeg9FlZFGWX+nDAGmN+Bgy2FkNeHHlR+vb5VV5Ve
	N/zQmPLYBSG/SqtfwDylQo7tgck7koDeOy5l/Md+hNbgQP3KhrPINJ9ILdh8MpTo+GK77S
	mWv7jJBls3vl+nrgwt6B9MUxU+qjpaakkc6M7l5RDTHBBaj9KLaqhaGQqwLiU0rt95K5XY
	8fP7W4hfmT1IAw3lfmxNUeMEiu0VzXpiZFi8jnW1b6z0B4yzSDKIWuEltxRWfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762878783;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=er4demuavKyIkUj7zp5Id11j531DnvRcPCRTi0S8mVo=;
	b=X3rq6NcFIRxOxk78LfthAn2PV63018Rx7hddoveK3JkU1xSYwKgt661pv/jAt6F6EwZt4p
	scEkq9Xn8hj5e2Dg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Document dl_server
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176287878215.498.2975441853821192130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2614069c5912e9d6f1f57c262face1b368fb8c93
Gitweb:        https://git.kernel.org/tip/2614069c5912e9d6f1f57c262face1b368f=
b8c93
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 03 Nov 2025 11:25:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 17:27:50 +01:00

sched/deadline: Document dl_server

Place the notes that resulted from going through the dl_server code in a
comment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c | 194 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 194 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8307f24..e958cf9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1595,6 +1595,200 @@ void dl_server_update(struct sched_dl_entity *dl_se, =
s64 delta_exec)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
 }
=20
+/*
+ * dl_server && dl_defer:
+ *
+ *                                        6
+ *                            +--------------------+
+ *                            v                    |
+ *     +-------------+  4   +-----------+  5     +------------------+
+ * +-> |   A:init    | <--- | D:running | -----> | E:replenish-wait |
+ * |   +-------------+      +-----------+        +------------------+
+ * |     |         |    1     ^    ^               |
+ * |     | 1       +----------+    | 3             |
+ * |     v                         |               |
+ * |   +--------------------------------+   2      |
+ * |   |                                | ----+    |
+ * | 8 |       B:zero_laxity-wait       |     |    |
+ * |   |                                | <---+    |
+ * |   +--------------------------------+          |
+ * |     |              ^     ^           2        |
+ * |     | 7            | 2   +--------------------+
+ * |     v              |
+ * |   +-------------+  |
+ * +-- | C:idle-wait | -+
+ *     +-------------+
+ *       ^ 7       |
+ *       +---------+
+ *
+ *
+ * [A] - init
+ *   dl_server_active =3D 0
+ *   dl_throttled =3D 0
+ *   dl_defer_armed =3D 0
+ *   dl_defer_running =3D 0/1
+ *   dl_defer_idle =3D 0
+ *
+ * [B] - zero_laxity-wait
+ *   dl_server_active =3D 1
+ *   dl_throttled =3D 1
+ *   dl_defer_armed =3D 1
+ *   dl_defer_running =3D 0
+ *   dl_defer_idle =3D 0
+ *
+ * [C] - idle-wait
+ *   dl_server_active =3D 1
+ *   dl_throttled =3D 1
+ *   dl_defer_armed =3D 1
+ *   dl_defer_running =3D 0
+ *   dl_defer_idle =3D 1
+ *
+ * [D] - running
+ *   dl_server_active =3D 1
+ *   dl_throttled =3D 0
+ *   dl_defer_armed =3D 0
+ *   dl_defer_running =3D 1
+ *   dl_defer_idle =3D 0
+ *
+ * [E] - replenish-wait
+ *   dl_server_active =3D 1
+ *   dl_throttled =3D 1
+ *   dl_defer_armed =3D 0
+ *   dl_defer_running =3D 1
+ *   dl_defer_idle =3D 0
+ *
+ *
+ * [1] A->B, A->D
+ * dl_server_start()
+ *   dl_server_active =3D 1;
+ *   enqueue_dl_entity()
+ *     update_dl_entity(WAKEUP)
+ *       if (!dl_defer_running)
+ *         dl_defer_armed =3D 1;
+ *         dl_throttled =3D 1;
+ *     if (dl_throttled && start_dl_timer())
+ *       return; // [B]
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // deplete server runtime from client-class
+ * [2] B->B, C->B, E->B
+ * dl_server_update()
+ *   update_curr_dl_se() // idle =3D false
+ *     if (dl_defer_idle)
+ *       dl_defer_idle =3D 0;
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       dl_defer_running =3D 0;
+ *       hrtimer_try_to_cancel();   // stop timer
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled =3D 1;
+ *         dl_defer_armed =3D 1;
+ *       start_dl_timer();        // restart timer
+ *       // [B]
+ *
+ * // timer actually fires means we have runtime
+ * [3] B->D
+ * dl_server_timer()
+ *   if (dl_defer_armed)
+ *     dl_defer_running =3D 1;
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       // fwd period
+ *       if (dl_throttled)
+ *         dl_throttled =3D 0;
+ *       if (dl_defer_armed)
+ *         dl_defer_armed =3D 0;
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // schedule server
+ * [4] D->A
+ * pick_task_dl()
+ *   p =3D server_pick_task();
+ *   if (!p)
+ *     dl_server_stop()
+ *       dequeue_dl_entity();
+ *       hrtimer_try_to_cancel();
+ *       dl_defer_armed =3D 0;
+ *       dl_throttled =3D 0;
+ *       dl_server_active =3D 0;
+ *       // [A]
+ *   return p;
+ *
+ * // server running
+ * [5] D->E
+ * update_curr_dl_se()
+ *   if (dl_runtime_exceeded())
+ *     dl_throttled =3D 1;
+ *     dequeue_dl_entity();
+ *     start_dl_timer();
+ *     // [E]
+ *
+ * // server replenished
+ * [6] E->D
+ * dl_server_timer()
+ *   enqueue_dl_entity(REPLENISH)
+ *     replenish_dl_entity()
+ *       fwd-period
+ *       if (dl_throttled)
+ *         dl_throttled =3D 0;
+ *     __enqueue_dl_entity();
+ *     // [D]
+ *
+ * // deplete server runtime from idle
+ * [7] B->C, C->C
+ * dl_server_update_idle()
+ *   update_curr_dl_se() // idle =3D true
+ *     if (dl_defer && dl_throttled && dl_runtime_exceeded())
+ *       if (dl_defer_idle)
+ *         return;
+ *       dl_defer_running =3D 0;
+ *       hrtimer_try_to_cancel();
+ *       replenish_dl_new_period()
+ *         // fwd period
+ *         dl_throttled =3D 1;
+ *         dl_defer_armed =3D 1;
+ *       dl_defer_idle =3D 1;
+ *       start_dl_timer();        // restart timer
+ *       // [C]
+ *
+ * // stop idle server
+ * [8] C->A
+ * dl_server_timer()
+ *   if (dl_defer_idle)
+ *     dl_server_stop();
+ *     // [A]
+ *
+ *
+ * digraph dl_server {
+ *   "A:init" -> "B:zero_laxity-wait"             [label=3D"1:dl_server_star=
t"]
+ *   "A:init" -> "D:running"                      [label=3D"1:dl_server_star=
t"]
+ *   "B:zero_laxity-wait" -> "B:zero_laxity-wait" [label=3D"2:dl_server_upda=
te"]
+ *   "B:zero_laxity-wait" -> "C:idle-wait"        [label=3D"7:dl_server_upda=
te_idle"]
+ *   "B:zero_laxity-wait" -> "D:running"          [label=3D"3:dl_server_time=
r"]
+ *   "C:idle-wait" -> "A:init"                    [label=3D"8:dl_server_time=
r"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label=3D"2:dl_server_upda=
te"]
+ *   "C:idle-wait" -> "C:idle-wait"               [label=3D"7:dl_server_upda=
te_idle"]
+ *   "D:running" -> "A:init"                      [label=3D"4:pick_task_dl"]
+ *   "D:running" -> "E:replenish-wait"            [label=3D"5:update_curr_dl=
_se"]
+ *   "E:replenish-wait" -> "B:zero_laxity-wait"   [label=3D"2:dl_server_upda=
te"]
+ *   "E:replenish-wait" -> "D:running"            [label=3D"6:dl_server_time=
r"]
+ * }
+ *
+ *
+ * Notes:
+ *
+ *  - When there are fair tasks running the most likely loop is [2]->[2].
+ *    the dl_server never actually runs, the timer never fires.
+ *
+ *  - When there is actual fair starvation; the timer fires and starts the
+ *    dl_server. This will then throttle and replenish like a normal DL
+ *    task. Notably it will not 'defer' again.
+ *
+ *  - When idle it will push the actication forward once, and then wait
+ *    for the timer to hit or a non-idle update to restart things.
+ */
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq =3D dl_se->rq;

