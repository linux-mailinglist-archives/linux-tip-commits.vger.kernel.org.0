Return-Path: <linux-tip-commits+bounces-8376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INDSCgepqmmzVAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:14:31 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49F21E866
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 362A63032892
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C236C0BA;
	Fri,  6 Mar 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TwuuAuEL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhuNoc8f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA936EA86;
	Fri,  6 Mar 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792062; cv=none; b=kz1W7D3LDmsTFAMWUJv8bRctJpyx1TvooYlDLzYtO/hAjxgMIwoXnONjeQSMzVG0crrhnswFcx7/sWVyt84y54e9m6uFw+iddLE+YXqdzzL4Xq9+lp7ikNd+lEbIJC4ILr3yWa5yjk9Oq2ikC3Fg+jkYJ4HdYIEbgu3ItYWSrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792062; c=relaxed/simple;
	bh=IeuDauJ5SsBJQtAFHSxN0qu8vUtqlCIdieoBSSoExOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XTvyCiRESrihQVF+njvxNz6w9+A9NaKrMkJE6WgFTNNN6W9dFFXCZ43dn77JWgQ1aMyEcdY8RKCiKXVXuII9Ds7jiR5W2YFuJleAsES/+5EmE9WDP/EuftXMjZPhTUbTP1NsiAVJXfAN4TxujDaQcTFX3Zj6+O5nIyPtuNwbkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TwuuAuEL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhuNoc8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 10:14:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772792059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5w18OWRFQTe248lEsdqp6f9u+OSnFVKdtQfRjEjPdGI=;
	b=TwuuAuELPvpw+gRaa7PyBUw3/N5XJ7TzweXl5x2i512RhBY4qDlu/3Ex2rVmi0B7+GmikB
	ZOccxDoO5aduqUKAZpssIbJYD3UUcZmzpFK7yvycKANtwso7EqTrxBQkTojngPnDuhJCdj
	EzVUuPt2GTnFmWeRp0+7Lf5K7iLdZzYWQ1qh00zXx80ZTc+xNdbX4614Vdn8m0DafugwWq
	t+iURRbKBaxVu9DFiQhriktWywk8mp7U0tq4g7ri/gcp1A3niO7yQU8MDuOX7AsNaHExbp
	/fSIm4m1o+wFAVCj/NHeyVw/wsMf+UI9aK6prNajb4SpUz2v83JiJS1g+jQ9PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772792059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5w18OWRFQTe248lEsdqp6f9u+OSnFVKdtQfRjEjPdGI=;
	b=lhuNoc8fj442Uoo+VzTzbr6Ts9H6tRffBG2qA8Os+6a1Tl+WUC6LFtZGvQww6SHKKztufw
	QwRaE0W1aMbBheDw==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix missing ENQUEUE_REPLENISH
 during PI de-boosting
Cc: Bruno Goncalves <bgoncalv@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20260302-upstream-fix-deadline-piboost-b4-v3-1-6ba32184a9e0@redhat.com>
References:
 <20260302-upstream-fix-deadline-piboost-b4-v3-1-6ba32184a9e0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177279205842.1647592.16248861554114799173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB49F21E866
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8376-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d658686a1331db3bb108ca079d76deb3208ed949
Gitweb:        https://git.kernel.org/tip/d658686a1331db3bb108ca079d76deb3208=
ed949
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 02 Mar 2026 16:45:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 17:06:08 +01:00

sched/deadline: Fix missing ENQUEUE_REPLENISH during PI de-boosting

Running stress-ng --schedpolicy 0 on an RT kernel on a big machine
might lead to the following WARNINGs (edited).

 sched: DL de-boosted task PID 22725: REPLENISH flag missing

 WARNING: CPU: 93 PID: 0 at kernel/sched/deadline.c:239 dequeue_task_dl+0x15c=
/0x1f8
 ... (running_bw underflow)
 Call trace:
  dequeue_task_dl+0x15c/0x1f8 (P)
  dequeue_task+0x80/0x168
  deactivate_task+0x24/0x50
  push_dl_task+0x264/0x2e0
  dl_task_timer+0x1b0/0x228
  __hrtimer_run_queues+0x188/0x378
  hrtimer_interrupt+0xfc/0x260
  ...

The problem is that when a SCHED_DEADLINE task (lock holder) is
changed to a lower priority class via sched_setscheduler(), it may
fail to properly inherit the parameters of potential DEADLINE donors
if it didn't already inherit them in the past (shorter deadline than
donor's at that time). This might lead to bandwidth accounting
corruption, as enqueue_task_dl() won't recognize the lock holder as
boosted.

The scenario occurs when:
1. A DEADLINE task (donor) blocks on a PI mutex held by another
   DEADLINE task (holder), but the holder doesn't inherit parameters
   (e.g., it already has a shorter deadline)
2. sched_setscheduler() changes the holder from DEADLINE to a lower
   class while still holding the mutex
3. The holder should now inherit DEADLINE parameters from the donor
   and be enqueued with ENQUEUE_REPLENISH, but this doesn't happen

Fix the issue by introducing __setscheduler_dl_pi(), which detects when
a DEADLINE (proper or boosted) task gets setscheduled to a lower
priority class. In case, the function makes the task inherit DEADLINE
parameters of the donoer (pi_se) and sets ENQUEUE_REPLENISH flag to
ensure proper bandwidth accounting during the next enqueue operation.

Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple =
scheduling classes")
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260302-upstream-fix-deadline-piboost-b4-v3-1=
-6ba32184a9e0@redhat.com
---
 kernel/sched/syscalls.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6f10db3..cadb0e9 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -284,6 +284,35 @@ static bool check_same_owner(struct task_struct *p)
 		uid_eq(cred->euid, pcred->uid));
 }
=20
+#ifdef CONFIG_RT_MUTEXES
+static inline void __setscheduler_dl_pi(int newprio, int policy,
+			      struct task_struct *p,
+			      struct sched_change_ctx *scope)
+{
+	/*
+	 * In case a DEADLINE task (either proper or boosted) gets
+	 * setscheduled to a lower priority class, check if it neeeds to
+	 * inherit parameters from a potential pi_task. In that case make
+	 * sure replenishment happens with the next enqueue.
+	 */
+
+	if (dl_prio(newprio) && !dl_policy(policy)) {
+		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
+
+		if (pi_task) {
+			p->dl.pi_se =3D pi_task->dl.pi_se;
+			scope->flags |=3D ENQUEUE_REPLENISH;
+		}
+	}
+}
+#else /* !CONFIG_RT_MUTEXES */
+static inline void __setscheduler_dl_pi(int newprio, int policy,
+			      struct task_struct *p,
+			      struct sched_change_ctx *scope)
+{
+}
+#endif /* !CONFIG_RT_MUTEXES */
+
 #ifdef CONFIG_UCLAMP_TASK
=20
 static int uclamp_validate(struct task_struct *p,
@@ -655,6 +684,7 @@ change:
 			__setscheduler_params(p, attr);
 			p->sched_class =3D next_class;
 			p->prio =3D newprio;
+			__setscheduler_dl_pi(newprio, policy, p, scope);
 		}
 		__setscheduler_uclamp(p, attr);
=20

