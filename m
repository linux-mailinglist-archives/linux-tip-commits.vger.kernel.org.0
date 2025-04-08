Return-Path: <linux-tip-commits+bounces-4775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BFA81584
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4438A1BC26E3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C2257AF9;
	Tue,  8 Apr 2025 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpn6trbb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dSCAbm+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0E257438;
	Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139145; cv=none; b=uBXbRllqs76a1+s/s1Z430nWI1mdumdq+KlDAu/UPeF/XfFDzTu5oXdW6qho5S6RgWPto1sYqO0NWNJNLgGYn3NSDdPBcrwJM67NyhjvyK2ZK1qa+AB8mKb6Eqsua24Fnx/Jfl47KjfF6DzAol0nZ3XcCgQfCHSFlHmSfi0hAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139145; c=relaxed/simple;
	bh=k7VJ+rSbKtDCn+k68r/QXX8U+WVtjgStAxLUMzEpmiI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oIujRv654wA5a1CCxEgsEOHRE45mGAvr1HzmoOO3AIIfwBnixCb+eLPX8qFcPM3I5wz3h4ihV8U/qRSQSbJT+ma0yaUQsLgsLv6mqUatH5MAM7750MtZVhna5aNJAaNLRASa0jirnvdFMpZid3saHEhyokPL/VV+fpFrU8nNhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpn6trbb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+dSCAbm+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vi4etpp4A366YblE3HzWuXAq3RRxtIf1GqK8/nKZrR0=;
	b=lpn6trbbDMO/lNvPM2fyE3vb/6vT9WVNZCfBZJ9m4wTgqtURPzsLbS2fEtUhhlccurWbGU
	mQgR0MjsMSquZ3mEEq1xULOlx9SMqGJFgdKtnvLgqEaFeKZPIY/3ATvxz4D42VBGEIe5qV
	2uQ+fjgL4fbAgC5KxLeX7siv5UdUPbd0KJE4xHDcIKoQEFJFy0wF0gZw/zq2nYiYJMex35
	gqNCAMYGYW5RhsgOrOUpG6DWgpvh/R5VcIo3WMK2WNSPZElAITnm8noe3qwhekz25bvDS0
	rvp/UXrPOFAmBeMB7VPi0oBNSxA2bf/DQI5GdnemojvIfc+HOJnyyZpjPRYOvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vi4etpp4A366YblE3HzWuXAq3RRxtIf1GqK8/nKZrR0=;
	b=+dSCAbm+Iy8lM4dLbuvFbuOeoqSQBL5+tAvj5zqamb58zf1wylXlCcrlES0axdw0pEL37T
	MZTB0PMV3hSirdAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix trace_sched_switch(.prev_state)
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413914101.31282.6876925851363406689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8feb053d53194382fcfb68231296fdc220497ea6
Gitweb:        https://git.kernel.org/tip/8feb053d53194382fcfb68231296fdc220497ea6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 19 Mar 2025 22:23:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:51 +02:00

sched: Fix trace_sched_switch(.prev_state)

Gabriele noted that in case of signal_pending_state(), the tracepoint
sees a stale task-state.

Fixes: fa2c3254d7cf ("sched/tracing: Don't re-read p->state when emitting sched_switch event")
Reported-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cfaca30..042c978 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6571,12 +6571,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long task_state)
+			      unsigned long *task_state_p)
 {
+	unsigned long task_state = *task_state_p;
 	int flags = DEQUEUE_NOCLOCK;
 
 	if (signal_pending_state(task_state, p)) {
 		WRITE_ONCE(p->__state, TASK_RUNNING);
+		*task_state_p = TASK_RUNNING;
 		return false;
 	}
 
@@ -6713,7 +6715,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, prev_state);
+		try_to_block_task(rq, prev, &prev_state);
 		switch_count = &prev->nvcsw;
 	}
 

