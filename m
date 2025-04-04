Return-Path: <linux-tip-commits+bounces-4653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3DA7B904
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 10:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4701897EEB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07251991DD;
	Fri,  4 Apr 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eeyAbm89";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcN4S+2K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08719994F;
	Fri,  4 Apr 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755858; cv=none; b=CrGgBzf5bhBrIcce6FUq4uH8zkw1/1G1Bed/L5Mf+HggycGqdxGIsCBm1+7mZAyLrgSgCwcAsY6WTyuAOYu9A2t4rbD6nGsyTRXMgOqrRzAiymntcvriTPm9olodVxV7e3j6CyIra/X23lz599M39pXX4hzlTYWBWTvOS1pc3Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755858; c=relaxed/simple;
	bh=7lKQpPKTVw0wqECtAGjx+cKAgoZ/IhDFDDXnVUzCXLE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NTcagKlIrWxPm+O2uoCrtBZgmUP8xPawlT5QIr4uwOnmByptPnRzYzc1F/L/kWSqHJZz265zCFu33xHZfwjRu3eKGwOnFjgSWF0IfL0CqWOh/BLaxe9eYo9U5rIgmJvg2m0MIrAx6p2qhPiuFya4oVHE48btNZ7+P9arEWsk8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eeyAbm89; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcN4S+2K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 08:37:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743755854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAW4Iy6p573QrPBUU9MGrvgfkCxvi9ZQwji3B/2nL1k=;
	b=eeyAbm89dTtoLDzDMwU9pWBX/cDqoZG2js00zWGrPQL16VxIeYmicIyggHiGKgQyBdz0nB
	beYpczpVndCauFSOyFMuDyGxvzGqhfEoVzayrjlwfBgnaUh/beZdF+Vl3L6xS2H5dd8oTI
	bFHSXRv3lxXkmldU/dROrB79XjTfVGASmr32AZcowRIeJeLA3QI+stiTTUOOxB+TR07EzJ
	LRWsOYJkLD3SJQaX+oDK291Sx5xrABePvPpPQpK1w1L4Tfbc/lUBwvBrGnJ+17KS25jvTH
	JxmJFun4BbSt6WUoDj+v+34uVg7GTUnTVsIFpCz2EV0NebUGPqaetwkmZKlgKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743755854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAW4Iy6p573QrPBUU9MGrvgfkCxvi9ZQwji3B/2nL1k=;
	b=JcN4S+2K3PbG4LouIVNCGPIDcj0cxl8x0kSBSqSWQe1fnNiI6ei4hNBmeRwzPDVHfQ2orv
	m3J+Oh1LPwMfuJCw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/tracepoints: Move and extend the
 sched_process_exit() tracepoint
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250402180925.90914-1-andrii@kernel.org>
References: <20250402180925.90914-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174375584977.31282.8985910498663747932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3e816361e94a0e79b1aabf44abec552e9698b196
Gitweb:        https://git.kernel.org/tip/3e816361e94a0e79b1aabf44abec552e9698b196
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:09:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 04 Apr 2025 10:30:19 +02:00

sched/tracepoints: Move and extend the sched_process_exit() tracepoint

It is useful to be able to access current->mm at task exit to, say,
record a bunch of VMA information right before the task exits (e.g., for
stack symbolization reasons when dealing with short-lived processes that
exit in the middle of profiling session). Currently,
trace_sched_process_exit() is triggered after exit_mm() which resets
current->mm to NULL making this tracepoint unsuitable for inspecting
and recording task's mm_struct-related data when tracing process
lifetimes.

There is a particularly suitable place, though, right after
taskstats_exit() is called, but before we do exit_mm() and other
exit_*() resource teardowns. taskstats performs a similar kind of
accounting that some applications do with BPF, and so co-locating them
seems like a good fit. So that's where trace_sched_process_exit() is
moved with this patch.

Also, existing trace_sched_process_exit() tracepoint is notoriously
missing `group_dead` flag that is certainly useful in practice and some
of our production applications have to work around this. So plumb
`group_dead` through while at it, to have a richer and more complete
tracepoint.

Note that we can't use sched_process_template anymore, and so we use
TRACE_EVENT()-based tracepoint definition. But all the field names and
order, as well as assign and output logic remain intact. We just add one
extra field at the end in backwards-compatible way.

Document the dependency to sched_process_template anyway.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250402180925.90914-1-andrii@kernel.org
---
 include/trace/events/sched.h | 34 ++++++++++++++++++++++++++++++----
 kernel/exit.c                |  2 +-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 8994e97..3bec9fb 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -326,11 +326,37 @@ DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_ARGS(p));
 
 /*
- * Tracepoint for a task exiting:
+ * Tracepoint for a task exiting.
+ * Note, it's a superset of sched_process_template and should be kept
+ * compatible as much as possible. sched_process_exits has an extra
+ * `group_dead` argument, so sched_process_template can't be used,
+ * unfortunately, just like sched_migrate_task above.
  */
-DEFINE_EVENT(sched_process_template, sched_process_exit,
-	     TP_PROTO(struct task_struct *p),
-	     TP_ARGS(p));
+TRACE_EVENT(sched_process_exit,
+
+	TP_PROTO(struct task_struct *p, bool group_dead),
+
+	TP_ARGS(p, group_dead),
+
+	TP_STRUCT__entry(
+		__array(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	pid			)
+		__field(	int,	prio			)
+		__field(	bool,	group_dead		)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
+		__entry->pid		= p->pid;
+		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
+		__entry->group_dead	= group_dead;
+	),
+
+	TP_printk("comm=%s pid=%d prio=%d group_dead=%s",
+		  __entry->comm, __entry->pid, __entry->prio,
+		  __entry->group_dead ? "true" : "false"
+	)
+);
 
 /*
  * Tracepoint for waiting on task to unschedule:
diff --git a/kernel/exit.c b/kernel/exit.c
index 1b51dc0..f1db86d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -936,12 +936,12 @@ void __noreturn do_exit(long code)
 
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
+	trace_sched_process_exit(tsk, group_dead);
 
 	exit_mm();
 
 	if (group_dead)
 		acct_process();
-	trace_sched_process_exit(tsk);
 
 	exit_sem(tsk);
 	exit_shm(tsk);

