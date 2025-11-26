Return-Path: <linux-tip-commits+bounces-7536-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC7C88123
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A43B4516
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937A3128CA;
	Wed, 26 Nov 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JX6T5p9l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FAlB9IR1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9593126AF;
	Wed, 26 Nov 2025 04:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131779; cv=none; b=k/dUyktuqa9KJc8ZWiv/1Gsb8j9XsD95CX1VeAEugrZ0yHYeFDdzG3dC5y4CJCbdf5Hy0MVMrdyxRuoefO+CyXm4UknvX4i4hTeIJX/2FHxVDsYG6CJFq9R8CnH5AJvUes9/gXj+5H8bF6ZqhDbdHfbUt55/rS+OPnhlwxUcHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131779; c=relaxed/simple;
	bh=w/0WTy/ddx6xilR/zqv647JNgbk/6GTXZyuKyrza+T8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kJXdIIqS41ur6XwVlsvX6fnEITw6bhEc2vdulwNJ0BGAU1mWXuGljC3c2PgBgmAy2/3h9yM/LybGcTg2zkqTVoLs5WL1+ZwLsD+sX++zrn9yPrX/YC1PYZsqI8J1pnvTDs+jkJ69PMA5MAoo8savABfIk/9ZAbP1T8yqxVsT7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JX6T5p9l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FAlB9IR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaU7OGInG/jq129g63bpK04o1MeIHyd15MQOB4G6AGc=;
	b=JX6T5p9lpwsnXqgV9alQq9pOixdP/I6BXlhoF3TkRNtfFC8VPPURzkrq8N4vroj6wF41aF
	yL1ujT/uF0RmAnWru34J/duTCAoLqLR5xYmkia3ff1QR1dKiVxNjN186q/X/vo9hmGdzKe
	mV3Usq6k907gAD+lKyz5fJN72g0abeH0nN3nLKGhf9ZmWC6C1z862x0bdvfVgSvLXxohr7
	F4oxdizmcs4CoriWx6n25R1xs+BqXikkLhsLjRZKuGKsYbxRIul3h/KbpIwAMQg4gpkQuL
	Zlv6BZ2M9tWehK4pnex/QI0s/pMqy0F5KosRKaR5WvH5POJwnxWGbd2OQ1g3RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131775;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaU7OGInG/jq129g63bpK04o1MeIHyd15MQOB4G6AGc=;
	b=FAlB9IR1oikeS+tdzigVXjs9u5y4zULgqnaJbKofeHkAd9huhM/gQ5KKyK+kyTzj3rYsx7
	MbCn/EGyQToIr6Dg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] signal: Move MMCID exit out of sighand lock
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.706439391@linutronix.de>
References: <20251119172549.706439391@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176413177436.498.8070641045058361452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2b1642b881088bbf73fcb1147c474a198ec46729
Gitweb:        https://git.kernel.org/tip/2b1642b881088bbf73fcb1147c474a198ec=
46729
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:40 +01:00

signal: Move MMCID exit out of sighand lock

There is no need anymore to keep this under sighand lock as the current
code and the upcoming replacement are not depending on the exit state of a
task anymore.

That allows to use a mutex in the exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.706439391@linutronix.de
---
 include/linux/sched.h | 4 ++--
 kernel/exit.c         | 1 +
 kernel/sched/core.c   | 4 ++--
 kernel/signal.c       | 2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 64f080d..c411ae0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2298,7 +2298,7 @@ static __always_inline void alloc_tag_restore(struct al=
loc_tag *tag, struct allo
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
+void sched_mm_cid_exit(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid.cid;
@@ -2307,7 +2307,7 @@ static inline int task_mm_cid(struct task_struct *t)
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
-static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static inline int task_mm_cid(struct task_struct *t)
 {
 	/*
diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f..324616f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -910,6 +910,7 @@ void __noreturn do_exit(long code)
 	user_events_exit(tsk);
=20
 	io_uring_files_cancel();
+	sched_mm_cid_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
=20
 	seccomp_filter_release(tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a114b6..3fdf90a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10392,7 +10392,7 @@ static inline void mm_update_cpus_allowed(struct mm_s=
truct *mm, const struct cpu
 	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
=20
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm =3D t->mm;
=20
@@ -10410,7 +10410,7 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 /* Deactivate MM CID allocation across execve() */
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
-	sched_mm_cid_exit_signals(t);
+	sched_mm_cid_exit(t);
 }
=20
 /* Reactivate MM CID after successful execve() */
diff --git a/kernel/signal.c b/kernel/signal.c
index fe9190d..e42b8bd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3125,7 +3125,6 @@ void exit_signals(struct task_struct *tsk)
 	cgroup_threadgroup_change_begin(tsk);
=20
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
-		sched_mm_cid_exit_signals(tsk);
 		tsk->flags |=3D PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -3136,7 +3135,6 @@ void exit_signals(struct task_struct *tsk)
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
-	sched_mm_cid_exit_signals(tsk);
 	tsk->flags |=3D PF_EXITING;
=20
 	cgroup_threadgroup_change_end(tsk);

