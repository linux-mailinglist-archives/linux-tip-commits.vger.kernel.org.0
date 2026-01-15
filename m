Return-Path: <linux-tip-commits+bounces-8009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE7D2892C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0B42300C34B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15B323416;
	Thu, 15 Jan 2026 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ba6LCdXI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="am/DUrgX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852C2836B1;
	Thu, 15 Jan 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510863; cv=none; b=gtsYngufCh6tHapmqGIslTPUJh4+B3t+DxUnUfy3cR802TYs9LACOyynIovvEJDoub5z7l88WUG7osUm1xv6l4Jf+Ih8aLDzy4IacqfVcgmBm6KCF2HaYwMGQcCiDbCzhxluG++/gCkgycIEVBGYE0qes+Qa0kiEBqCoBi+L1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510863; c=relaxed/simple;
	bh=7KxJf/gBRcdt7xjvWnIlSA1+X0yBvYju2eGdCLp+YEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VaXVc+mbuBnFFsVqKcaRrvOpuZkWX6Ngq6t1MIbvgfMX0Nr5OrVGppYo1E0n7NkwYds3KDGZ3bswens3sQmt37ZkZoXJmrKtC6ldpHaOeYii1mc/9DZU9STfs2uTtfZzp7FDUF7rRerCSbQb26dqLw14QeaS/i0PXRez4OmPJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ba6LCdXI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=am/DUrgX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hn8lkQ4Ui3N3nbj/7JRN3slEyyrXGCLj7AmoFQf8BQQ=;
	b=ba6LCdXID/W1f+kmeQY+OTRA6nExytx1I5rdbNn9PEm+zTILugXJ1W8e2WNxxZ2DhedgQg
	WjOD3QgKZFMxd9qbmHJri2/PChl2zOWlrDcHIZiaJZGFHIhIJNQyMWgceB7gjvx6UFY+XS
	fNNFauWYHvMpc9yj+lfhZkGZFRuWbAacvqOJFBubmdCl3yYYEuUGaudWBy55r01mapeFBf
	50uitSAUQse6YFo0s1QfciUXjgRgVlJ7AfjeUDAU/vqUZ4ULv7aOU81v7rfqpsfDyq6KT3
	qrm+E3XntYQdPnC+Hfy1/pm4yFvfQkXUHG0csuS/podAlNSlcptocVYUk0GeXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hn8lkQ4Ui3N3nbj/7JRN3slEyyrXGCLj7AmoFQf8BQQ=;
	b=am/DUrgXSFoK/h7AeBF4CZ/UqEHmT45rRBC0Sm9xRoOc+cC/VJ8QYzxZgn4Ez1lEe5o2sv
	vKUIWAoE64CNsBDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Deadline has dynamic priority
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851085911.510.8234553422899032318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e008ec6c7904ed99d3b2cb634b6545b008a99288
Gitweb:        https://git.kernel.org/tip/e008ec6c7904ed99d3b2cb634b6545b008a=
99288
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Jan 2026 09:25:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:53 +01:00

sched: Deadline has dynamic priority

While FIFO/RR have static priority, DEADLINE is a dynamic priority
scheme. Notably it has static priority -1. Do not assume the priority
doesn't change for deadline tasks just because the static priority
doesn't change.

This ensures DL always sees {DE,EN}QUEUE_MOVE where appropriate.

Fixes: ff77e4685359 ("sched/rt: Fix PI handling vs. sched_setscheduler()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260114130528.GB831285@noisy.programming.kick=
s-ass.net
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/syscalls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d925d7..045f83a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7320,7 +7320,7 @@ void rt_mutex_setprio(struct task_struct *p, struct tas=
k_struct *pi_task)
 	trace_sched_pi_setprio(p, pi_task);
 	oldprio =3D p->prio;
=20
-	if (oldprio =3D=3D prio)
+	if (oldprio =3D=3D prio && !dl_prio(prio))
 		queue_flag &=3D ~DEQUEUE_MOVE;
=20
 	prev_class =3D p->sched_class;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index cb337de..6f10db3 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -639,7 +639,7 @@ change:
 		 * itself.
 		 */
 		newprio =3D rt_effective_prio(p, newprio);
-		if (newprio =3D=3D oldprio)
+		if (newprio =3D=3D oldprio && !dl_prio(newprio))
 			queue_flags &=3D ~DEQUEUE_MOVE;
 	}
=20

