Return-Path: <linux-tip-commits+bounces-7416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11456C73AFA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A81E4E95E6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC7331235;
	Thu, 20 Nov 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhrYLFvo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SdK1Ab73"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97B307AD3;
	Thu, 20 Nov 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637603; cv=none; b=LPX7BSEmDJOvdf87unPL3C6L1UilmbWHEQPZPUsxo31XTSzzrx8xG6+YN/9pKLUmHqkO7eY9RgmHlioOlyEb9D63fYIgVQ6Argf9MqWIa+HRfsKACpnI0FPv+oZ7rUNVTqz8ns19TW8Fy0l7XyKb6htUTg0LinL5uHj1Gx4T80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637603; c=relaxed/simple;
	bh=kBWZ/8gdzJpR7lGKKEq3iGNLzPCyC7zfDGfHHwESUKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HxSnEN/gS2yxPnfHID9KqPldCgqlTjmhcblWNDxAgzlu9CPSnrJzlNpdvfUUtEKX8p1Y5xbys7VLO8Sthlph1DGAtKkL+L+A1IyOdVo/7lVvq3mct1TZVJkfPB7H9f46K9FpI3NoJGPu7J3x1bW2PVYGCNN0w8SgFam9dUPkFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhrYLFvo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SdK1Ab73; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMEU144nXoDZgFYMHVEWIxhmLa+0HY+RI2zC89RP6n8=;
	b=QhrYLFvomcEUfNi3MmCLUchQJzena/BhksYAtmUMN8xjCB8QRZx1W3Ptx/dOSPeYab7R4g
	zT/B9WyJzVjPhmbf6o0dE5hVNISvFmCFITiAyKtiD/CYjd2avdPeQ5Hnwnx8cS9EF8tXmy
	cSg/kLcMBdm+FJoEIJAgjKQDt3Mn3aHdvOCwzI3R1hcFjDgpOEP54st+K09tsAisQoSEPZ
	owbx/Ono/Bx+DvT7lY9cCIhmRjHV18doJL/9lKon3WnTfBwnEsJ/42QjYXpbJekVOlNiec
	+vFzXEWc05InI5YMuEfdtXpOdh7eRdr91MBbljojf0J7qzAvYyx2RIgSoE4Vaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMEU144nXoDZgFYMHVEWIxhmLa+0HY+RI2zC89RP6n8=;
	b=SdK1Ab73NUDE44OBEAHQXKrNBNB4X08BbCd32kq1oZlVlRxGEcxWtwx0etrcL4vNTS/2hS
	P5xyT2PNUNjZ6fBA==
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
Message-ID: <176363759828.498.12395339235718085948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     1497ac189541df3c7c344bca723a7597009a99f4
Gitweb:        https://git.kernel.org/tip/1497ac189541df3c7c344bca723a7597009=
a99f4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:55 +01:00

signal: Move MMCID exit out of sighand lock

There is no need anymore to keep this under sighand lock as the current
code and the upcoming replacement are not depending on the exit state of a
task anymore.

That allows to use a mutex in the exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

