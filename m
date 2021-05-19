Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37538891B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbhESIKa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbhESIK3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CCC06175F;
        Wed, 19 May 2021 01:09:10 -0700 (PDT)
Date:   Wed, 19 May 2021 08:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EqMt3HmWa/96mZiJBqtVTeiSTPz/2kjA+Gz/DhtsODo=;
        b=kmLVL/p+Yx1PdHHdRYa5jrIb3de+urn+HD+NvIbmzfxjSmpgojDVS9Y0u5TtE7sCWjnHLv
        GZumkrKWc4kRKsWznCJVfjSRB0kZ4g+MidfA9FY3MaytIldJ01aH4/iNdvaM3gSreobnvi
        bBVHAg+JQ7T3ZGJtBkGJn6uN0UE5d8bbqRQ8v+bnLQiQal7p64BusMPe8W6LMmXFEsVCxi
        382yS0GMBTzxMeOcnJJuWDBV4daEmrm29XsmgqcjNBDzku/H6l8+ACaRIBTVnO7X0zoXsi
        QjWD8a2FxgLHRBzhx/xuQQDsDlNvGPLUAEozPEnOGDAvr8BRoIvY666ExlEjkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EqMt3HmWa/96mZiJBqtVTeiSTPz/2kjA+Gz/DhtsODo=;
        b=fP/mQFmmegk5bmIIQbFxjyLMoqhj7WJIEl/hQQgpRt3I8lznE0o8gaol5PLF6aNuzRuxiA
        shcC3d0WkmhWggCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,stats: Further simplify sched_info
Cc:     Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162141174766.29796.8595133657860805490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     90a0ff4ec9c65cae3085d23301933172cea3f38a
Gitweb:        https://git.kernel.org/tip/90a0ff4ec9c65cae3085d23301933172cea3f38a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 May 2021 13:32:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:53 +02:00

sched,stats: Further simplify sched_info

There's no point doing delta==0 updates.

Suggested-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/stats.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 33ffd41..111072e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -160,10 +160,11 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 {
 	unsigned long long delta = 0;
 
-	if (t->sched_info.last_queued) {
-		delta = rq_clock(rq) - t->sched_info.last_queued;
-		t->sched_info.last_queued = 0;
-	}
+	if (!t->sched_info.last_queued)
+		return;
+
+	delta = rq_clock(rq) - t->sched_info.last_queued;
+	t->sched_info.last_queued = 0;
 	t->sched_info.run_delay += delta;
 
 	rq_sched_info_dequeue(rq, delta);
@@ -176,12 +177,14 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
  */
 static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long now = rq_clock(rq), delta = 0;
+	unsigned long long now, delta = 0;
 
-	if (t->sched_info.last_queued) {
-		delta = now - t->sched_info.last_queued;
-		t->sched_info.last_queued = 0;
-	}
+	if (!t->sched_info.last_queued)
+		return;
+
+	now = rq_clock(rq);
+	delta = now - t->sched_info.last_queued;
+	t->sched_info.last_queued = 0;
 	t->sched_info.run_delay += delta;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
