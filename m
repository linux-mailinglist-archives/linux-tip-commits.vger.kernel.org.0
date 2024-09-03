Return-Path: <linux-tip-commits+bounces-2154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C2969F31
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A8B1F22AD4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A17462;
	Tue,  3 Sep 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KeD0SxsU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8E3NR41p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D152224DC;
	Tue,  3 Sep 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370707; cv=none; b=hh2bpshy879yNZiEEwq8wy8qIP0t7e5Y9/Ks1+mbg/9mWMTrW6kR9bLr/WrhoMHguiFLXSulQS1vyZWrH4OtvIUbqfFv76QO4YhI1+xI0KME1TWwXQhK5W39Rm8HGS24Aq+Nw956yg0igoNKDqDHDBu6kjgkX2jxBRra/CcRy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370707; c=relaxed/simple;
	bh=TE5gjNrBP+vj/QRuC1YR4DNIIgdBOB8GDsuRT/dtFdo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SGI+eJpbFaAgekOQgcV2K4d78PUDoW8AmgR8fgZDCVXlkStDTINTyiDpYD9ArCJYejM32RYIzjF4JSUzXbvz/UIS31FirQzq/lUURckHwH9O2G/Cc9ydTFu/alJM2aA92NHPVT9oZZofZP2dx6hD2qSCjcwEF+IekpHMfLSQJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KeD0SxsU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8E3NR41p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNL1JU5Hwf0yr57OPLCxK+wS8NOUlQMqFMRPuPYCZ+Y=;
	b=KeD0SxsUDCgpEBWw0rOPElbjkFYiQus2DlV9+LtNz9kQ2jC4Jr+p9siXzJxelKq12lfshH
	rYhyMdLq0sUNgsjijoqHkW0JGZCaUdSnj+U5klTm72uQEX/QV68xNzcGGvQfBaSZvbJCiT
	lllZ17nATgLZyI7kfNi8fTgEiL83thmsB37Cw1NoWl6n4LTrleBbeRIbeJaToPzKGTK7Ps
	9HQRe4shmHBFdXNvxSjnTbsjIw6duXqSR7aJra5dRiKzWhVzJ20dQIUBd6B+DIQMsXeSyj
	BBttRvDbR8KbhgY1zdJmhIb1wuRT2BKUmE8Sz9kx9y7Z1Lwfg+aJoDtX708FwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNL1JU5Hwf0yr57OPLCxK+wS8NOUlQMqFMRPuPYCZ+Y=;
	b=8E3NR41pqGN/vDLjCiHGSCeBHrIgkQwK8G1llqnzIoc4y+RNkWFegfx80Q24LzDNmirBM8
	LKTIsQ+ZrufUQJDA==
From: "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix schedstats vs deadline servers
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240829031111.12142-1-shijie@os.amperecomputing.com>
References: <20240829031111.12142-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070289.2215.6361738272320261977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9c602adb799e72ee537c0c7ca7e828c3fe2acad6
Gitweb:        https://git.kernel.org/tip/9c602adb799e72ee537c0c7ca7e828c3fe2acad6
Author:        Huang Shijie <shijie@os.amperecomputing.com>
AuthorDate:    Thu, 29 Aug 2024 11:11:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:30 +02:00

sched/deadline: Fix schedstats vs deadline servers

In dl_server_start(), when schedstats is enabled, the following
happens:

  dl_server_start()
    dl_se->dl_server = 1;
    enqueue_dl_entity()
      update_stats_enqueue_dl()
        __schedstats_from_dl_se()
          dl_task_of()
            BUG_ON(dl_server(dl_se));

Since only tasks have schedstats and internal entries do not, avoid
trying to update stats in this case.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20240829031111.12142-1-shijie@os.amperecomputing.com
---
 kernel/sched/deadline.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f2df67..2e84037 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1896,46 +1896,40 @@ static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
 	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
 }
 
-static inline struct sched_statistics *
+static __always_inline struct sched_statistics *
 __schedstats_from_dl_se(struct sched_dl_entity *dl_se)
 {
+	if (!schedstat_enabled())
+		return NULL;
+
+	if (dl_server(dl_se))
+		return NULL;
+
 	return &dl_task_of(dl_se)->stats;
 }
 
 static inline void
 update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void
 update_stats_enqueue_sleeper_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 {
-	struct sched_statistics *stats;
-
-	if (!schedstat_enabled())
-		return;
-
-	stats = __schedstats_from_dl_se(dl_se);
-	__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
+	struct sched_statistics *stats = __schedstats_from_dl_se(dl_se);
+	if (stats)
+		__update_stats_enqueue_sleeper(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
 
 static inline void

