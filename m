Return-Path: <linux-tip-commits+bounces-5788-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A2CAD846B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8163BB3EA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FEF2E6D32;
	Fri, 13 Jun 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dGCjmuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pl4hmhx9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260942E62B8;
	Fri, 13 Jun 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800236; cv=none; b=chAZtH0f0I/WyP8SJ+Af4xr1P4jfpG6rNhkTg5vDmvV86NIFTbWS/PqcZpvcfm7wxVDL0vOInbHKoRIJJO/0biZNcHKAqHVNDf30EqpcMwdfsLyOwqKonRZvk4P0yeBhVIZOdUgJUEflvJ2fqTdZe89VVSrBUs/4GTy1TbWxkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800236; c=relaxed/simple;
	bh=xHqVOf7sR7yTN4fH1+2WL5Kd1VippEZggYgoYlUDtas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eKeqKhJnZkIPjMhUI/GoT42fn08CaXxjU3ka6nU7vkc9/zW58itte05leIDM0diY80qQvuUTo/QNvVUoAnMYJrnYLuqh6odXwNE+soHF+SgUS+MbhwUU8kCJ2JNimdfto1F500DUlW7lfhzA/p4LsjdwUDTNoR5gUx4CtcvW/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dGCjmuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pl4hmhx9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KImaK3d0N7Q6FIVTzUJj3FWEMFCJkYtn0RnOcXdASgo=;
	b=4dGCjmuBjtZJyRiTIITlm/7+aAv2No+9z5BY5xfn28XtufF6Ntu1oSMTI8SPkEMtt00guE
	Zg5FalW4hPmRnYY7FB5V+hU/ymwLjyFr0dRF5e9fatnaPynEup26iGtQ/FQbweq28Dd5db
	3FglQRkEGkAhZQSwwWopFsoBEOUZPLCiXsh3CPvW1XabuVnGrst3NYKqROdEavLpgat9pb
	Osh9NJFwi4EMFGqlZ9axti/rEUepxmqpzdAieSkYs9d9COkj8xFfeciHHnrpJn1XGO/UTc
	oB1vXIKMX8W7DJjHz/xLj8/GGwVAUcD4JOBUFdkcWRuDfqhzvWNKwOvcTqLn4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KImaK3d0N7Q6FIVTzUJj3FWEMFCJkYtn0RnOcXdASgo=;
	b=Pl4hmhx9D8EYA0Y3h5jC/SZToHskgGAP2DsFUcXqPEJ6wSBqblwZ4BIHa5ZCwWJ6T6rgBH
	d1LWFP79y28TCyDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of the stop-CPU
 scheduling class
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-36-mingo@kernel.org>
References: <20250528080924.2273858-36-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023243.406.520810220477726843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     caf5bde9c542f0cbdf2c91db7ea9743e33941d91
Gitweb:        https://git.kernel.org/tip/caf5bde9c542f0cbdf2c91db7ea9743e33941d91
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:21 +02:00

sched/smp: Use the SMP version of the stop-CPU scheduling class

Simplify the scheduler by making CONFIG_SMP=y code in the stop-CPU
scheduling class unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-36-mingo@kernel.org
---
 kernel/sched/stop_task.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1c1bbc6..2d4e279 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -9,7 +9,6 @@
  */
 #include "sched.h"
 
-#ifdef CONFIG_SMP
 static int
 select_task_rq_stop(struct task_struct *p, int cpu, int flags)
 {
@@ -21,7 +20,6 @@ balance_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	return sched_stop_runnable(rq);
 }
-#endif /* CONFIG_SMP */
 
 static void
 wakeup_preempt_stop(struct rq *rq, struct task_struct *p, int flags)
@@ -107,11 +105,9 @@ DEFINE_SCHED_CLASS(stop) = {
 	.put_prev_task		= put_prev_task_stop,
 	.set_next_task          = set_next_task_stop,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
-#endif
 
 	.task_tick		= task_tick_stop,
 

