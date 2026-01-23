Return-Path: <linux-tip-commits+bounces-8110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCAgLEpXc2kDuwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 12:11:06 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1A874D40
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3F53046B99
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Jan 2026 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A7320CD9;
	Fri, 23 Jan 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIibv/RA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltdt/v9F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C821ADCB;
	Fri, 23 Jan 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166400; cv=none; b=nszupDCs2+nsI1M/oaGT1bi7O9rMtR4qEgged4DsQ74icSkgyd5kKYBdPfuOUQl8jgu6R2DTbGVssaeSBn88XD0bzJeAnRKXMqA9eM+oFlVfxWeO5g+64Pizwr6tdB4JfBSJDQgwct05q3sNEf4O5HjSFjYJB+tWM946o00FOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166400; c=relaxed/simple;
	bh=xSnRmKz3jDLIXBUeu+AYjBcmkHTmMvA0AsjGNMH/W28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iNB7Iu6SE0RATVqvB0VWnb9r6u/zc6SjQSN6109YwKGG2qV/szPco/QEsRU98oT+PCwtYINTZBb1PyPQB8bhUkTCzyr2NMFNeQBZvbYoPgBZJdeNUhIKZOybSvbc28SPDkEirC0Le6O094zzW8FnVoBGLdw1IvSuKJCJ3W3A5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIibv/RA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ltdt/v9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Jan 2026 11:06:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769166398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z3d4jZchfCm28WHk6qz3M8/+MhQ48NC+ky0PUGJgzo=;
	b=hIibv/RAsS1QHHxiDFpklFRAOuBVr/S1X2UaJRtETFk1FDggGjJN3SMCu4aF+rLzhXsilQ
	pSP5LRGIYg2svha5LyYSGNuEH/sm3oCJOa1vV9PuXWYAyuEI5WdT2D1b7RAumzgqnnoEbC
	B1qG91/lHabXF+ZdtppKegHEcI04h5cJXyS+mrIHsIaZLy3wvGY8ztF47LbwMmy25dAFZc
	gzzC+g9mNJsYS/qXCb05acxXDX3OmN8tLUiccE/1KQahEeEyEJbEqDJO96fG9GynGDsXe5
	CZK9UO1UPg3dV8aN/s70tCDYWa9Yp6+YxXfPyKfpH2f/YMQ8GSOR5p7rJJg1rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769166398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z3d4jZchfCm28WHk6qz3M8/+MhQ48NC+ky0PUGJgzo=;
	b=ltdt/v9FydbsbI1Fu7cCN4dGNI9bVevX1d2Ez0jGV5bkmy6MR9UpPJpUZq50tIMjHbmjzE
	PRDKfgCvC+2/ZMDg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Revert force wakeup preemption
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123102858.52428-1-vincent.guittot@linaro.org>
References: <20260123102858.52428-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176916639187.510.1647095982279283388.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8110-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 1E1A874D40
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     15257cc2f905dbf5813c0bfdd3c15885f28093c4
Gitweb:        https://git.kernel.org/tip/15257cc2f905dbf5813c0bfdd3c15885f28=
093c4
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 23 Jan 2026 11:28:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Jan 2026 11:53:20 +01:00

sched/fair: Revert force wakeup preemption

This agressively bypasses run_to_parity and slice protection with the
assumpiton that this is what waker wants but there is no garantee that
the wakee will be the next to run. It is a better choice to use
yield_to_task or WF_SYNC in such case.

This increases the number of resched and preemption because a task becomes
quickly "ineligible" when it runs; We update the task vruntime periodically
and before the task exhausted its slice or at least quantum.

Example:
2 tasks A and B wake up simultaneously with lag =3D 0. Both are
eligible. Task A runs 1st and wakes up task C. Scheduler updates task
A's vruntime which becomes greater than average runtime as all others
have a lag =3D=3D 0 and didn't run yet. Now task A is ineligible because
it received more runtime than the other task but it has not yet
exhausted its slice nor a min quantum. We force preemption, disable
protection but Task B will run 1st not task C.

Sidenote, DELAY_ZERO increases this effect by clearing positive lag at
wake up.

Fixes: e837456fdca8 ("sched/fair: Reimplement NEXT_BUDDY to align with EEVDF =
goals")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260123102858.52428-1-vincent.guittot@linaro.=
org
---
 kernel/sched/fair.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a148c61..3eaeced 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8828,16 +8828,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, s=
truct task_struct *p, int=20
 	if ((wake_flags & WF_FORK) || pse->sched_delayed)
 		return;
=20
-	/*
-	 * If @p potentially is completing work required by current then
-	 * consider preemption.
-	 *
-	 * Reschedule if waker is no longer eligible. */
-	if (in_task() && !entity_eligible(cfs_rq, se)) {
-		preempt_action =3D PREEMPT_WAKEUP_RESCHED;
-		goto preempt;
-	}
-
 	/* Prefer picking wakee soon if appropriate. */
 	if (sched_feat(NEXT_BUDDY) &&
 	    set_preempt_buddy(cfs_rq, wake_flags, pse, se)) {

