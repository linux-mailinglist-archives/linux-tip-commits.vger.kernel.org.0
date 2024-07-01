Return-Path: <linux-tip-commits+bounces-1555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB291D8AB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999B11C216E1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0C5F876;
	Mon,  1 Jul 2024 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZE2gWH8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSMUdtpO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F459168;
	Mon,  1 Jul 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818095; cv=none; b=c8h8/VifPtdcwyb1W9nH5pC2mlH5mC8Z44lKPsPDjAQvtY2KH36RkX2cP39RufwYgSFI3SpTa4w87vdkyCpk+oxg/s3zKfSfG7Ul1ymPJ+vXOBDjIL5GxtF8UowvLudo+WEdqL+abIRasG1/wVFYV37p4pQnIH+uxwqZmq4eGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818095; c=relaxed/simple;
	bh=aBKD3Uj+bz0fC3jHCQStdgSfgrblCRNumgZ6FJr+Qg4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TGdW/6F8KzhneTXWz2x4PnSOwHUAHOzXQQ6xpCAtLpKxutzkwqTSu5T/pi8sZ+zFCP6lt377X0syfFy8aRczoGAZobT2nUzGDG0AG2XB0ePq+PlF3+KjQfDourae+1Gt2yHhNxq1CQf2hzg5XDeC3IIRZJdsKT471ZWkCNFgJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZE2gWH8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSMUdtpO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 07:14:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719818092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8y7doyPNcQhto4gUcbOsO9PzfLioSsTJraVqqEFPzo=;
	b=zZE2gWH8Ta4XTVNDi/qT7kZ/8t6w2R7CmoErQXWQt4o4/4W5mVZ9MLNHaM0hryfK8EkPsG
	yV05olVQTIV1nZHnkJjWixxpR3DSHXZxywrFstNArpe+VfQTw++AcTN2KKgWQfMMQtu/OV
	rWEGXYQsCqPFfd63Rv+bth7FIARe4vhK2rMOJNE2Prlbja3TYdZEYvdzBfWOcJRh4Ypegm
	KF15GZETcCElMj5p2ne+kjk0JO3ynlCcodtxHujR6nLL6qT2hmbuRrEWP/AuMt6J4m9uAh
	WbIY2EAUNtpK1cyEJ6jFnmy4Stx6vtd3kVJm7SvTzo9qWz3HbRFlxihG2cPoVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719818092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8y7doyPNcQhto4gUcbOsO9PzfLioSsTJraVqqEFPzo=;
	b=uSMUdtpODs3m7FqMhv7dxTVrymrLyQC3dAsnpDmlZzDr5RYY+q+Mj+kuXNAsr2wBb+7A+B
	9zkMzjINT0CZUUDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix event leak upon exit
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-4-frederic@kernel.org>
References: <20240621091601.18227-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171981809242.2215.6810968999368920588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     73caafba7021a97c22bff58c3d123228e03cdc46
Gitweb:        https://git.kernel.org/tip/73caafba7021a97c22bff58c3d123228e03cdc46
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:16:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jun 2024 10:43:38 +02:00

perf: Fix event leak upon exit

When a task is scheduled out, pending sigtrap deliveries are deferred
to the target task upon resume to userspace via task_work.

However failures while adding an event's callback to the task_work
engine are ignored. And since the last call for events exit happen
after task work is eventually closed, there is a small window during
which pending sigtrap can be queued though ignored, leaking the event
refcount addition such as in the following scenario:

    TASK A
    -----

    do_exit()
       exit_task_work(tsk);

       <IRQ>
       perf_event_overflow()
          event->pending_sigtrap = pending_id;
          irq_work_queue(&event->pending_irq);
       </IRQ>
    =========> PREEMPTION: TASK A -> TASK B
       event_sched_out()
          event->pending_sigtrap = 0;
          atomic_long_inc_not_zero(&event->refcount)
          // FAILS: task work has exited
          task_work_add(&event->pending_task)
       [...]
       <IRQ WORK>
       perf_pending_irq()
          // early return: event->oncpu = -1
       </IRQ WORK>
       [...]
    =========> TASK B -> TASK A
       perf_event_exit_task(tsk)
          perf_event_exit_event()
             free_event()
                WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
                // leak event due to unexpected refcount == 2

As a result the event is never released while the task exits.

Fix this with appropriate task_work_add()'s error handling.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240621091601.18227-4-frederic@kernel.org
---
 kernel/events/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f0..7c3218d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2284,18 +2284,15 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 	}
 
 	if (event->pending_sigtrap) {
-		bool dec = true;
-
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
+		    !event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
+			event->pending_work = 1;
+		} else {
 			local_dec(&event->ctx->nr_pending);
+		}
 	}
 
 	perf_event_set_state(event, state);

