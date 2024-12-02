Return-Path: <linux-tip-commits+bounces-2928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B089E00A6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BBB2CABD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275EE209698;
	Mon,  2 Dec 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2qFqBOG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yw0gzk4J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAB208998;
	Mon,  2 Dec 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138092; cv=none; b=F9baT3hfVeZ0Br5EKamgCHnaBehdQ30XxDuUu3R5quiVFuDlpkYyUd7YE2PL2iZNoYCmr+b7cbOeWWOTtJeiXl+HTfjTO3p1NyEwoV9kUcoXvx2fDCIfV6bUd39xCAn4Umlk0PHd8Sytfu9/Td8UaHseisesBTSLX1jBrUCGgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138092; c=relaxed/simple;
	bh=d9vIAERBPGSf4tcKRkqbW5991dzhPObvzY2mTvsgkSM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=huSlj+bToKYopdXC+4nzrqpHI75vow2s1on6E52pPwO4hB5Yjjl5i3bWinLGfcg1gxHr6DR0K+wMHzlrUtTVsBSEm6m2DjI+V0AfPBzh+Q4i4tCeen+UEyW/icwOSUDk7oKUxlm34IYjH30nNttRAsnUrO25GvfzcMXxOK086Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2qFqBOG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yw0gzk4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUmMzgoNng+eeMZc/KLTJZP+upNMCB6hRTHIGB1/IHI=;
	b=t2qFqBOGCSxg8rKRjRkFRSnOFSonlOHYk2w786OnFMXIbZ3ePBp85SnwvHZ4E12sPnDSY4
	Kcwwnf3QZpultBLPPDWp7hO6mS89gJOJZJw0jh3aeqa9MRwPUlTf+O6oWZaQ1agmTs6oiz
	zg1Xehh7pWL9y1NzpXLu9hopEwFmQqBbIl0/z6TuO0yLVYNpuSe5L2GIwdCkoSGS4duFHW
	r/tFdtbRC+Qjf+x4q/W9+e8eePh/ydOI27N6EjDhaq9RYVlzVjvBGvUyOLIfFNioTbXqQu
	l6ofCoVVg7stWexEXn0ft5KXv1GOuYNUKJ+P4dh1UiIUiwN4WPM2Ma8MbuBERA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUmMzgoNng+eeMZc/KLTJZP+upNMCB6hRTHIGB1/IHI=;
	b=Yw0gzk4JNqFiaiNWnhYAgK9XjG22iWpfGYKoqglNnfO+uIBhwAcFUnDawiC39Jbr34gILf
	C2+0QGuWFH1UMpDA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Prevent wakeup of ksoftirqd during idle
 load balance
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119054432.6405-5-kprateek.nayak@amd.com>
References: <20241119054432.6405-5-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808824.412.3339188414358925845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e932c4ab38f072ce5894b2851fea8bc5754bb8e5
Gitweb:        https://git.kernel.org/tip/e932c4ab38f072ce5894b2851fea8bc5754bb8e5
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Tue, 19 Nov 2024 05:44:32 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:28 +01:00

sched/core: Prevent wakeup of ksoftirqd during idle load balance

Scheduler raises a SCHED_SOFTIRQ to trigger a load balancing event on
from the IPI handler on the idle CPU. If the SMP function is invoked
from an idle CPU via flush_smp_call_function_queue() then the HARD-IRQ
flag is not set and raise_softirq_irqoff() needlessly wakes ksoftirqd
because soft interrupts are handled before ksoftirqd get on the CPU.

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

       <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
       <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
       <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
       <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
  ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
       ...

Use __raise_softirq_irqoff() to raise the softirq. The SMP function call
is always invoked on the requested CPU in an interrupt handler. It is
guaranteed that soft interrupts are handled at the end.

Following are the observations with the changes when enabling the same
set of events:

       <idle>-0       [000] dN.1.: nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
       <idle>-0       [000] dN.1.: softirq_raise: vec=7 [action=SCHED]
       <idle>-0       [000] .Ns1.: softirq_entry: vec=7 [action=SCHED]

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20241119054432.6405-5-kprateek.nayak@amd.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 803b238..c6d8232 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,7 +1285,7 @@ static void nohz_csd_func(void *info)
 	rq->idle_balance = idle_cpu(cpu);
 	if (rq->idle_balance) {
 		rq->nohz_idle_balance = flags;
-		raise_softirq_irqoff(SCHED_SOFTIRQ);
+		__raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 }
 

