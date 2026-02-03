Return-Path: <linux-tip-commits+bounces-8187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1+rMF5rZgWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB09D829B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8278306EC70
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CCB33469C;
	Tue,  3 Feb 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8ws19XG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkqoNrVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A376334373;
	Tue,  3 Feb 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117519; cv=none; b=d8dyh426Lnbtf8SIiyoV1j3M/o4cIUgBJE++iy6srKcngkq8X87KPVbssKhZo08SGlq7xeGrpPctVc4DxgUYzYre4tnr+8gjv/XjitUgZvHuI0OXT2587L+Kx9uN0khKAITaCaF/PvaKf7x+k3xdY8V3q6aoMipo1a8kEyazKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117519; c=relaxed/simple;
	bh=//8XuYOe9ndgjWNUGHWagrRPBp05FmhncUgPmt4XxUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LRHWKgaEtvxRlYBbCtCXlbuWexQQ5iiPGrhYDkWUPeyawjQ+qjHjzNlrHi5gPVj+X4qweolu4ZzE7lh3Wc1OTZE46losH3LbTg94fnfkqD3rufOroXCzHnUE8UZmoVuUeqgz0nV7ohv2LBMMP5AhD+On2nJJCEHSZuh2b6AX9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R8ws19XG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkqoNrVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USa3b/q/DyfZiCadMHF5hmkPTcOF+KRM5ZHFznfw66U=;
	b=R8ws19XGFg9o/M+EIk7QQR5T++gLjXOwri6kzmTpA7Zf4upCufq0lvLwit417OFsoq2JAE
	QfTzSLeRQ8ElFEd1tZ1qtBTqV2K6bOgxD3DhWU5C+5yWDmM/27F9yLwsweEgDww3ESOR0o
	u4Xnv8aZRBsIhuE1v+KuOM9xdZlCq8QgjhINieIAlGYesK9DhNjhlohtAM7dt4IHOZcMz3
	8BRvwQnY9TR0aVwiEzhegvnFXOAvR6+N9fl04yeeF2xQT+d9xxO6k9Lw9RIzdPaL+MBKj7
	Uu56Toop3WF5cLUWe8HcflrjxelWj9rYcnqzzr4rAryNfyYFNwuE5wa6LclwRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USa3b/q/DyfZiCadMHF5hmkPTcOF+KRM5ZHFznfw66U=;
	b=JkqoNrVmfcBIDr43qy6tn0apMaXKsuboX0jAPpvwpG6IQIu+SIbpIT0j/MhqEkkvBQV+ki
	RytInAWe4t9C0NDQ==
From: "tip-bot2 for Chen Jinghuang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/rt: Skip currently executing CPU in rto_next_cpu()
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Chen Jinghuang <chenjinghuang2@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260122012533.673768-1-chenjinghuang2@huawei.com>
References: <20260122012533.673768-1-chenjinghuang2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751498.2495410.2763756834301063916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8187-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,huawei.com:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,goodmis.org:email]
X-Rspamd-Queue-Id: CCB09D829B
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94894c9c477e53bcea052e075c53f89df3d2a33e
Gitweb:        https://git.kernel.org/tip/94894c9c477e53bcea052e075c53f89df3d=
2a33e
Author:        Chen Jinghuang <chenjinghuang2@huawei.com>
AuthorDate:    Thu, 22 Jan 2026 01:25:33=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:19 +01:00

sched/rt: Skip currently executing CPU in rto_next_cpu()

CPU0 becomes overloaded when hosting a CPU-bound RT task, a non-CPU-bound
RT task, and a CFS task stuck in kernel space. When other CPUs switch from
RT to non-RT tasks, RT load balancing (LB) is triggered; with
HAVE_RT_PUSH_IPI enabled, they send IPIs to CPU0 to drive the execution
of rto_push_irq_work_func. During push_rt_task on CPU0,
if next_task->prio < rq->donor->prio, resched_curr() sets NEED_RESCHED
and after the push operation completes, CPU0 calls rto_next_cpu().
Since only CPU0 is overloaded in this scenario, rto_next_cpu() should
ideally return -1 (no further IPI needed).

However, multiple CPUs invoking tell_cpu_to_push() during LB increments
rd->rto_loop_next. Even when rd->rto_cpu is set to -1, the mismatch between
rd->rto_loop and rd->rto_loop_next forces rto_next_cpu() to restart its
search from -1. With CPU0 remaining overloaded (satisfying rt_nr_migratory
&& rt_nr_total > 1), it gets reselected, causing CPU0 to queue irq_work to
itself and send self-IPIs repeatedly. As long as CPU0 stays overloaded and
other CPUs run pull_rt_tasks(), it falls into an infinite self-IPI loop,
which triggers a CPU hardlockup due to continuous self-interrupts.

The trigging scenario is as follows:

         cpu0                      cpu1                    cpu2
                                pull_rt_task
                              tell_cpu_to_push
                 <------------irq_work_queue_on
rto_push_irq_work_func
       push_rt_task
    resched_curr(rq)                                   pull_rt_task
    rto_next_cpu                                     tell_cpu_to_push
                      <-------------------------- atomic_inc(rto_loop_next)
rd->rto_loop !=3D next
     rto_next_cpu
   irq_work_queue_on
rto_push_irq_work_func

Fix redundant self-IPI by filtering the initiating CPU in rto_next_cpu().
This solution has been verified to effectively eliminate spurious self-IPIs
and prevent CPU hardlockup scenarios.

Fixes: 4bdced5c9a29 ("sched/rt: Simplify the IPI based RT balancing logic")
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Chen Jinghuang <chenjinghuang2@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://patch.msgid.link/20260122012533.673768-1-chenjinghuang2@huawei.=
com
---
 kernel/sched/rt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a9b2cd..a768047 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2106,6 +2106,7 @@ static void push_rt_tasks(struct rq *rq)
  */
 static int rto_next_cpu(struct root_domain *rd)
 {
+	int this_cpu =3D smp_processor_id();
 	int next;
 	int cpu;
=20
@@ -2129,6 +2130,10 @@ static int rto_next_cpu(struct root_domain *rd)
=20
 		rd->rto_cpu =3D cpu;
=20
+		/* Do not send IPI to self */
+		if (cpu =3D=3D this_cpu)
+			continue;
+
 		if (cpu < nr_cpu_ids)
 			return cpu;
=20

