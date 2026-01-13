Return-Path: <linux-tip-commits+bounces-7902-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1FD181D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9D853015E3A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB3347BA5;
	Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqyf+nR0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3ou9eLM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B444349B1D;
	Tue, 13 Jan 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301010; cv=none; b=Tj4iaTvtabRl1ICkiBDwSagWrGGp9o+Ng9trDakiBuWQEmXehI+ukvxzDBb68qaxuBTSJoFK58L6A7FwQEkzWFi+KM1OpoPgrSyx0/ppnK1zjhY0XtjJlBDYH+K5n3a/jA32sJ7M+E8hQpt9Jc+ekGzr8B5Mo0azMXHs00xtWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301010; c=relaxed/simple;
	bh=0LZRWZHJgtGBGzK7tlCtTiUDyDNKBxxLqhvMuChsR88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YfdXYCGcvwGLwCdwq2Gvd2MfH8vd1xMCLCJqC/6RYlTe+jy/mtYBz+ISSzddNSskXpL2kZ4wvWNm59qeJ4Hg0hbwo2NNmMtbU/rwnJ3QfYTSE/qqpD5eGxBrPmVtnoZf4DCdLvL5TPUmRgUmKO4ZBtKKUYwNZTF5aCJisEErujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqyf+nR0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3ou9eLM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFs1k9AUGI+yIOn7SFNDu8DdZ+HUeCzh4QPOPy2Gy+c=;
	b=dqyf+nR0/WpL6ZsK5N5pq11yBJop1BKh5bN+IH6da68PNZ8mq2HuAwEUZAAwGp34OM1JTw
	Mr7lPgemgF0oEIN1UTLypl87LZcwpBX8uNgLO08Y8qYRuIBNxnaQ2pAtDy18qOITJBd/mn
	v/hMlTVuZKpQknr6I/H1xH3fXQrp+r2O3tK5jn7X7gmgTE/nWarGOOUtKLNiYWecXmyiIs
	CvTy2Te7jl/6vz+t1ww8/5/pPQ8eTUFdt4LClVSqk9gefZq4ZRRr017RBpthQh0gEqnI/a
	OaRuI3P6tex1OCo0DGQA3LITlaNwEU/oeQ0C3rHIot3cQ0uCkgJ6rmCv5kES2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFs1k9AUGI+yIOn7SFNDu8DdZ+HUeCzh4QPOPy2Gy+c=;
	b=R3ou9eLMAX4C0vT4ZXQQEps0vDcb/hW1iWYZmnorxdD82Tlz+uj9iJQyPy0YqgjA8u2yPI
	oA6fqUP3Z4CCyOCA==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Fix server stopping with runnable tasks
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260113085159.114226-3-gmonaco@redhat.com>
References: <20260113085159.114226-3-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830100399.510.2306510229567417762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ca1e8eede4fc68ce85a9fdce1a6c13ad64933318
Gitweb:        https://git.kernel.org/tip/ca1e8eede4fc68ce85a9fdce1a6c13ad649=
33318
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Tue, 13 Jan 2026 09:52:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:52 +01:00

sched/deadline: Fix server stopping with runnable tasks

The deadline server can currently stop due to idle although fair tasks
are runnable. This happens essentially when:

 * the server is set to idle, a task wakes up, the server stops
 * a task wakes up, the server sets itself to idle and stops right away

Address both cases by clearing the server idle flag whenever a fair task
wakes up and accounting also for pending tasks in the definition of idle.

Fixes: f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260113085159.114226-3-gmonaco@redhat.com
---
 kernel/sched/deadline.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e3efc40..b5c19b1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1420,7 +1420,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sch=
ed_dl_entity *dl_se, int=20
=20
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, =
s64 delta_exec)
 {
-	bool idle =3D rq->curr =3D=3D rq->idle;
+	bool idle =3D idle_rq(rq);
 	s64 scaled_delta_exec;
=20
 	if (unlikely(delta_exec <=3D 0)) {
@@ -1603,8 +1603,8 @@ void dl_server_update(struct sched_dl_entity *dl_se, s6=
4 delta_exec)
  * | 8 |       B:zero_laxity-wait       |     |    |
  * |   |                                | <---+    |
  * |   +--------------------------------+          |
- * |     |              ^     ^           2        |
- * |     | 7            | 2   +--------------------+
+ * |     |              ^         ^       2        |
+ * |     | 7            | 2, 1    +----------------+
  * |     v              |
  * |   +-------------+  |
  * +-- | C:idle-wait | -+
@@ -1649,8 +1649,11 @@ void dl_server_update(struct sched_dl_entity *dl_se, s=
64 delta_exec)
  *   dl_defer_idle =3D 0
  *
  *
- * [1] A->B, A->D
+ * [1] A->B, A->D, C->B
  * dl_server_start()
+ *   dl_defer_idle =3D 0;
+ *   if (dl_server_active)
+ *     return; // [B]
  *   dl_server_active =3D 1;
  *   enqueue_dl_entity()
  *     update_dl_entity(WAKEUP)
@@ -1759,6 +1762,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s6=
4 delta_exec)
  *   "B:zero_laxity-wait" -> "C:idle-wait"        [label=3D"7:dl_server_upda=
te_idle"]
  *   "B:zero_laxity-wait" -> "D:running"          [label=3D"3:dl_server_time=
r"]
  *   "C:idle-wait" -> "A:init"                    [label=3D"8:dl_server_time=
r"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label=3D"1:dl_server_star=
t"]
  *   "C:idle-wait" -> "B:zero_laxity-wait"        [label=3D"2:dl_server_upda=
te"]
  *   "C:idle-wait" -> "C:idle-wait"               [label=3D"7:dl_server_upda=
te_idle"]
  *   "D:running" -> "A:init"                      [label=3D"4:pick_task_dl"]
@@ -1784,6 +1788,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq =3D dl_se->rq;
=20
+	dl_se->dl_defer_idle =3D 0;
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
=20

