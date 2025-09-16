Return-Path: <linux-tip-commits+bounces-6648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91E6B59579
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB41B210D1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC68307AEE;
	Tue, 16 Sep 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmD6Entm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ty/aALu1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44499307ACE;
	Tue, 16 Sep 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023015; cv=none; b=U/yv9nlPlh1c+emmnYNNci9ISIhCXeIETf3ooqJ/QOpIZUTRQKtFdPk/OKQaX5eSANPhicPSoWC1RFvzj7Mo0ePRlrjO5Az4TJ2T7Ue6Nmf6D9jn3kfQ6xn5jVW9VhD2sTJ2Yac2TY9ymViV9znLIROCA2hpLlMfgD0BvXGksHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023015; c=relaxed/simple;
	bh=BqZ+Nf/8XzdWYvfCdwH6WZw0HMj4e0zZ2PH2Y3FN/vg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XNBskoq+pY+ge8JOB4YvyMBGPGzgaLBxKXehRAZ/vl9WzvkRui59uYWivbatvsDq8EGuWcYBjJXZQBNRqO+WKeb8c0ZizaxyAKYauSvfQHbmz6nD+5KgQkx2lU82/zGXxtSYCyGVbzzmiZ61czvd527p/wVy/1jcBQTi3HRGtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmD6Entm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ty/aALu1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 11:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758023012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tohj0SGSWqBtfhH2245p/ROLkuac3LRpO+8+oJbX4XA=;
	b=hmD6EntmSNJghAjVuYFVDCwMsk7PsKxvJmukV5MQojqCP0bbq+Q6lJzvRDwrT0QxwDdJMh
	3FQSXIhAvTneskMXkSQxKe4C0cMGI7EEIZfwBy3rR6KkQEvsIihBMMCwY5gGNbtk0qX+6j
	4QGw+0XhfXEdQfoKDaw80DuAC+0ue4tIOyzX59CnRmteugeqrx1QycAEXqfEN7XDSvhn+x
	VqrGDcMDmKshECVOiShHJGVnd5rsMz5XaKg2TTF77OnpsJf7qZwtbQMW4OWh5inRx6hy1D
	b9nXWqgAyyINhE9ZmHlzKgeUARH7Rx8yeW6sK4A1fnMNTfwOxh5Vi1Mj6Qiang==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758023012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tohj0SGSWqBtfhH2245p/ROLkuac3LRpO+8+oJbX4XA=;
	b=Ty/aALu1BjOObNh2AOdHsfrB31s1kkEKr2bVC4SwmpuRPtT5VraA5acpzhMs120LtIVZXB
	QkbjDKiXi7bCbtDQ==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Do not special case tasks in throttled
 hierarchy
Cc: Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910095044.278-4-ziqianlu@bytedance.com>
References: <20250910095044.278-4-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802301110.709179.14103324715089580003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     253b3f587241967a97a971e23b1e2a7d74244fad
Gitweb:        https://git.kernel.org/tip/253b3f587241967a97a971e23b1e2a7d742=
44fad
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Wed, 10 Sep 2025 17:50:43 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:37 +02:00

sched/fair: Do not special case tasks in throttled hierarchy

With the introduction of task based throttle model, task in a throttled
hierarchy is allowed to continue to run till it gets throttled on its
ret2user path.

For this reason, remove those throttled_hierarchy() checks in the
following functions so that those tasks can get their turn as normal
tasks: dequeue_entities(), check_preempt_wakeup_fair() and
yield_to_task_fair().

The benefit of doing it this way is: if those tasks gets the chance to
run earlier and if they hold any kernel resources, they can release
those resources earlier. The downside is, if they don't hold any kernel
resouces, all they can do is to throttle themselves on their way back to
user space so the favor to let them run seems not that useful and for
check_preempt_wakeup_fair(), that favor may be bad for curr.

K Prateek Nayak pointed out prio_changed_fair() can send a throttled
task to check_preempt_wakeup_fair(), further tests showed the affinity
change path from move_queued_task() can also send a throttled task to
check_preempt_wakeup_fair(), that's why the check of task_is_throttled()
in that function.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58f5349..3dbdfaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7081,7 +7081,7 @@ static int dequeue_entities(struct rq *rq, struct sched=
_entity *se, int flags)
 			 * Bias pick_next to pick a task from this cfs_rq, as
 			 * p is sleeping when it is within its sched_slice.
 			 */
-			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
+			if (task_sleep && se)
 				set_next_buddy(se);
 			break;
 		}
@@ -8735,7 +8735,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, st=
ruct task_struct *p, int=20
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
-	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
+	if (task_is_throttled(p))
 		return;
=20
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delaye=
d) {
@@ -9009,8 +9009,8 @@ static bool yield_to_task_fair(struct rq *rq, struct ta=
sk_struct *p)
 {
 	struct sched_entity *se =3D &p->se;
=20
-	/* throttled hierarchies are not runnable */
-	if (!se->on_rq || throttled_hierarchy(cfs_rq_of(se)))
+	/* !se->on_rq also covers throttled task */
+	if (!se->on_rq)
 		return false;
=20
 	/* Tell the scheduler that we'd really like se to run next. */

