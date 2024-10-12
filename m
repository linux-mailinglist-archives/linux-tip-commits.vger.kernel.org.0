Return-Path: <linux-tip-commits+bounces-2400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EB699B567
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C5B226C0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AA194124;
	Sat, 12 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="farGe83i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fa9Umb5b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE82152160;
	Sat, 12 Oct 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742569; cv=none; b=qatarkkexqSymv7mfDsm9tmeQui7e2bqPnxP54xFvEb+2HnUL7LWL/EifsgDnJmxKef98K2Q/rEem2N+4VttAylGr0B6mQzV2oBqQhM7H0Im7Ar2S2GqcpjLoViT1dK/6EDgI+89zmPWmB+aKzuc0IeDPY8rC9bQM7mF22L/74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742569; c=relaxed/simple;
	bh=2NhU/bsxUDYa+IuCA2vLBGTft4AQO49A7BCp4ClkIPY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=l+KORSB7S/bcoRcCPltGn1Q/VmrMyrwHhq9KJSGLdmmtYXXi60M32YFZcSTgw0tikQW4WRoaXEY848S8k5vRGrMltJiSDUoXHdzWFyAtuZo0tzkw+oe8W0SQOMx0IkYQZmXNITUMN237gUEZwa/z3usx5LjOEQC7Gqiw30wgSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=farGe83i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fa9Umb5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=C2ORr7yuWAWHDq9XFvicHZv24tlNY1ajXbsffimgOhk=;
	b=farGe83ijzeZri1QZSfov1NHYVHNITaj/MqViS6XyUnSxbZH6LxY10eXWSbwFBw2+EG4DI
	kwmzHazuHS81dZF02PH0bsZSVl9rxTnxxhXWI1BKdFp29HYbTb6+YPjP2Aed0Nm2GId1SX
	aLNvEYlvD1zQ6e4EK6FlcTN/lG4rIXr3qkfe6p3WfTWHrnD4JmGEH5yJwU3JPBwQgABadY
	/Vvf1tPhMU4/wLPjWKRV9siIINUCSCNfd18vcXwtEwBOwBMz/85MKBATFYrSiehitLPuhw
	PfyNnGQXDAPVB++LRx/I7DhgYnxG4dDlqR5ZJZ+y1bSBJtY+hzcYV5zKTZSccA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=C2ORr7yuWAWHDq9XFvicHZv24tlNY1ajXbsffimgOhk=;
	b=Fa9Umb5bHu4nqeWhkzkKANKPeVQQlhgmIV4oUZ+tz6T0aHdlabQhnlGE2WgOa0D0uZTmXG
	oehYA2ZpD6cr4wBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Dequeue PSI signals for blocked tasks
 that are delayed
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874255961.1442.979470319617499321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f5aaff7bfa11fb0b2ee6b8fd7bbc16cfceea2ad3
Gitweb:        https://git.kernel.org/tip/f5aaff7bfa11fb0b2ee6b8fd7bbc16cfceea2ad3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Oct 2024 08:28:36 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:33 +02:00

sched/core: Dequeue PSI signals for blocked tasks that are delayed

psi_dequeue() in for blocked task expects psi_sched_switch() to clear
the TSK_.*RUNNING PSI flags and set the TSK_IOWAIT flags however
psi_sched_switch() uses "!task_on_rq_queued(prev)" to detect if the task
is blocked or still runnable which is no longer true with DELAY_DEQUEUE
since a blocking task can be left queued on the runqueue.

This can lead to PSI splats similar to:

    psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=0 set=4

when the task is requeued since the TSK_RUNNING flag was not cleared
when the task was blocked.

Explicitly communicate that the task was blocked to psi_sched_switch()
even if it was delayed and is still on the runqueue.

  [ prateek: Broke off the relevant part from [1], commit message ]

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/lkml/20241004123506.GR18071@noisy.programming.kicks-ass.net/ [1]
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a860996..9e09140 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
+	bool block = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
 			 * After this, schedule() must not care about p->state any more.
 			 */
 			block_task(rq, prev, flags);
+			block = true;
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -6667,7 +6669,7 @@ picked:
 
 		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+		psi_sched_switch(prev, next, block);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 

