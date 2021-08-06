Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B93E2B01
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Aug 2021 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhHFM6I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Aug 2021 08:58:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbhHFM6I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Aug 2021 08:58:08 -0400
Date:   Fri, 06 Aug 2021 12:57:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628254671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2idvsD2lqlCRupIROj9rsnljoApBJGnd/H3NSPAFnyY=;
        b=1YHshLTX4J51sxEN2rNj9pu22nUt4onxVbkRgC0XM3TdzWxY/oTmN23tjvLR+TBu9HKydt
        Smh7lOXE0LmlPx+lGFPHD+h3sn3Foa+ZndE6SU0lZycJDygDzA1Ds5Q3oeAByekY28Mr8G
        hHq3codqXySYuAw0HLo/o3KbJROWBYAp17ewDbgvuEfBkZV4akpGK0ujUIkdE9Fj4/t8bX
        GRQ0/0Ot3RMDtJZ6DZDMCgbx2WGAU8JxtYej+qjrMhCWUhoqM/gUgJ/UXyBXo+sxl8Xh0I
        URzVzMYVaKnR0kUcXuybbYkiywO1hjqR1k2g+bqk0PYhOy3jjsgZz4R4X7jBvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628254671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2idvsD2lqlCRupIROj9rsnljoApBJGnd/H3NSPAFnyY=;
        b=pxCyk1xvh2K9uO5Sr24QY134hqBCmsT+U8iwncGXXD8uTJAerqWESQBGXxEoIIjv/vhIFl
        TXh/TydOno+fbbBQ==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix UCLAMP_FLAG_IDLE setting
Cc:     Rick Yiu <rickyiu@google.com>, Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210805102154.590709-2-qperret@google.com>
References: <20210805102154.590709-2-qperret@google.com>
MIME-Version: 1.0
Message-ID: <162825467066.395.3955621672709689514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ca4984a7dd863f3e1c0df775ae3e744bff24c303
Gitweb:        https://git.kernel.org/tip/ca4984a7dd863f3e1c0df775ae3e744bff24c303
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Thu, 05 Aug 2021 11:21:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Aug 2021 14:25:25 +02:00

sched: Fix UCLAMP_FLAG_IDLE setting

The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
uclamp active task (that is, when buckets.tasks reaches 0 for all
buckets) to maintain the last uclamp.max and prevent blocked util from
suddenly becoming visible.

However, there is an asymmetry in how the flag is set and cleared which
can lead to having the flag set whilst there are active tasks on the rq.
Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
called at enqueue time, but set in uclamp_rq_dec_id() which is called
both when dequeueing a task _and_ in the update_uclamp_active() path. As
a result, when both uclamp_rq_{dec,ind}_id() are called from
update_uclamp_active(), the flag ends up being set but not cleared,
hence leaving the runqueue in a broken state.

Fix this by clearing the flag in update_uclamp_active() as well.

Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20210805102154.590709-2-qperret@google.com
---
 kernel/sched/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 314f70d..df0480a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1621,6 +1621,23 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
+				      enum uclamp_id clamp_id)
+{
+	if (!p->uclamp[clamp_id].active)
+		return;
+
+	uclamp_rq_dec_id(rq, p, clamp_id);
+	uclamp_rq_inc_id(rq, p, clamp_id);
+
+	/*
+	 * Make sure to clear the idle flag if we've transiently reached 0
+	 * active tasks on rq.
+	 */
+	if (clamp_id == UCLAMP_MAX && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+}
+
 static inline void
 uclamp_update_active(struct task_struct *p)
 {
@@ -1644,12 +1661,8 @@ uclamp_update_active(struct task_struct *p)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	for_each_clamp_id(clamp_id) {
-		if (p->uclamp[clamp_id].active) {
-			uclamp_rq_dec_id(rq, p, clamp_id);
-			uclamp_rq_inc_id(rq, p, clamp_id);
-		}
-	}
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_reinc_id(rq, p, clamp_id);
 
 	task_rq_unlock(rq, p, &rf);
 }
