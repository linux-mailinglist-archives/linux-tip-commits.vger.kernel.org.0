Return-Path: <linux-tip-commits+bounces-6970-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D96BF5CAB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E957134E8FA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA662F12DA;
	Tue, 21 Oct 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sp/2Z6ow";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5r6gWn7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9903F2EC57F;
	Tue, 21 Oct 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042927; cv=none; b=pZmYZoDbXIzgNiDxw8MqvIbhdxy1XlZKxlsCc6FgmH/GhX8VSNsRkdFlQx1J4ibpDArG7L3ttTbaKSHtkkMvNHZYqfdjbgq28rzEtHKsoKRgldxcoJCAoApy4vxVfUU6dmu7Q9tkkZZhZjAxkvb7DtZz7zPLLHohK0I9f19YM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042927; c=relaxed/simple;
	bh=oZoyGOAbpu3DyUesH1x8gB75EvHrBA+4MpYmKOt7fvA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mVjbKK3gerkNF/rZfhoxONnJBFDd4DJn6wgF4MCgzPHsbm/7qLieLUNQOshbmSWxur/UlCkdIeamnYoc9dNR+MjjVAkysV8YXF13vXXEKeL4R40fBAm2Wg2NTC6LuA7Ag/P1SuV3mpzoOxj8Exf6kqQxV5l0qGb4WgNCDuRDlR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sp/2Z6ow; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5r6gWn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yJMCu/4DUMclMPcwuZQ3FMeNO3GqG6lTMfJCoMnrYs=;
	b=Sp/2Z6ow7j/RFRuoK4M+C28eEnOMUAtpsT7vEBKP9SwDeHj6Auu3SIl++0Ea6HN2/32kjP
	qm8hnOOUgwVsc4RqBQtyWEX2xKZekc9QjKNwaV1b/DBqA6PtEY3IHMd5flns1/zsil1VmD
	OyQiLCFWHXNsPhroIzim6TE4kcHTUipfj/w5KOsH3EkYGiyfk2Hl7eHh817dOavQJyDf84
	Y3HMXACewQi9AVT/uSfww0675VXJgec1ZTKJJR3ovlrhtGErp2XaX7Ow4TXrGqhztO41g/
	EpIKMPAeQvGyfvALpv00e8JHVNisRKBeCj6nFSbp7X9pH4h8Gyb7XS1VXyG3/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yJMCu/4DUMclMPcwuZQ3FMeNO3GqG6lTMfJCoMnrYs=;
	b=v5r6gWn7urVqOr/8mkzvhI7tcsNQXClvCvPQGMsllNuaO506TZENChj/LGF0y8jEctnORW
	TOWBKfuigr+GjnAA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Change thread_group_cputime() to use
 scoped_seqlock_read()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251008123052.GA20443@redhat.com>
References: <20251008123052.GA20443@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292247.2601451.8573715124838251042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     488f48b32654dc6be04d9cc12f75ce030c9cb21b
Gitweb:        https://git.kernel.org/tip/488f48b32654dc6be04d9cc12f75ce030c9=
cb21b
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Wed, 08 Oct 2025 14:30:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:57 +02:00

seqlock: Change thread_group_cputime() to use scoped_seqlock_read()

To simplify the code and make it more readable.

While at it, change thread_group_cputime() to use __for_each_thread(sig).

[peterz: update to new interface]
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cputime.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2..4f97896 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -313,10 +313,8 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *time=
s)
 {
 	struct signal_struct *sig =3D tsk->signal;
-	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
-	unsigned long flags;
+	u64 utime, stime;
=20
 	/*
 	 * Update current task runtime to account pending time since last
@@ -329,27 +327,19 @@ void thread_group_cputime(struct task_struct *tsk, stru=
ct task_cputime *times)
 	if (same_thread_group(current, tsk))
 		(void) task_sched_runtime(current);
=20
-	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq =3D 0;
-	do {
-		seq =3D nextseq;
-		flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	guard(rcu)();
+	scoped_seqlock_read (&sig->stats_lock, ss_lock_irqsave) {
 		times->utime =3D sig->utime;
 		times->stime =3D sig->stime;
 		times->sum_exec_runtime =3D sig->sum_sched_runtime;
=20
-		for_each_thread(tsk, t) {
+		__for_each_thread(sig, t) {
 			task_cputime(t, &utime, &stime);
 			times->utime +=3D utime;
 			times->stime +=3D stime;
 			times->sum_exec_runtime +=3D read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq =3D 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
-	rcu_read_unlock();
+	}
 }
=20
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING

