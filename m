Return-Path: <linux-tip-commits+bounces-6834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00889BE26AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5541A60DF7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3031BC90;
	Thu, 16 Oct 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwDSw4Y9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErFJiyZb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CB31AF38;
	Thu, 16 Oct 2025 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607213; cv=none; b=EjZIYA8zuQZsQvs77KTv02/u0x2XXIydM+S/FB4O2t22n3oYncDNkbjAz2ALcq3zedGM1v/J6eLmMi22uhllnGkBPHktduPm6XljuO7fM8je31mP2zGof4/rb3CLrYgvQP2eQkexCs0kiBzSbpqpcUS7i1tcbf1XFx5Mgh2y0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607213; c=relaxed/simple;
	bh=Rorz0Fvx1JykB8n6qjr5d/UmGwl6cvaXRKFf216HWrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BT/5nbzPXIWHarkBkxHRLhWSmPd5NvpRpnEhT5TIifbF7IRp2vBZaYWtw/5R8Jo4ecXLQhujIIWhNDVNs6hkP2JOphX7NDHadkjq4NgT1QSyiEzFhdtmG8IVDYLMSor68qCxlXoMC1Kg2PNuSc9xmsadSZr9Hh9oSnw6CoSs5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwDSw4Y9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErFJiyZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/cqJl6D/f6w83EKptbg9G6mFNygGFl+VcQRh9gs6ew=;
	b=cwDSw4Y9h4LXGFtRYcHihPZXNBAiNfZAnuwHMk9FHV3y+0EmdVKaUaGpzD1iXCfBhtgmsB
	9VCSUvrhU7uE1VZKaU0f3CXWpex6KCjxdHNooq2AtVSS5kwj65t289lRp4yWmyECOXyI8m
	uwMpmBHe/M0yfnkMb1ZUjQIJpejIhzW2wwscE8xAdJGl6rKr/oYpvbvwcflEHAy6z+deEb
	o1DINS6koL0h+iclFbhsSqaC6JjPTrvWliS7E7JoMfuANWWQx3eo8xHuYIjICXTALH5sSF
	/4DRyFvQGF1LH16IXoPkZX960KkV0HRnz1fbzR3aF2ltr/lwSy0u/4cioQzlIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/cqJl6D/f6w83EKptbg9G6mFNygGFl+VcQRh9gs6ew=;
	b=ErFJiyZb1XhatHQSYZ6ZAgct0Unk6d5yLlfqo/e6TGG1CWX/vdZhN1Hipm7Z7gkQmG//XY
	VFbgNbEYlilxOvDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make __do_set_cpus_allowed() use the
 sched_change pattern
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.574803551@infradead.org>
References: <20251006104527.574803551@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720861.709179.11187545832839968651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     650952d3fb3889b04cbda722351b5d6090a1c10b
Gitweb:        https://git.kernel.org/tip/650952d3fb3889b04cbda722351b5d6090a=
1c10b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Sep 2025 13:16:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:53 +02:00

sched: Make __do_set_cpus_allowed() use the sched_change pattern

Now that do_set_cpus_allowed() holds all the regular locks, convert it
to use the sched_change pattern helper.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 638bffd..e932439 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2664,28 +2664,12 @@ void set_cpus_allowed_common(struct task_struct *p, s=
truct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	struct rq *rq =3D task_rq(p);
-	bool queued, running;
-
-	lockdep_assert_held(&p->pi_lock);
-	lockdep_assert_rq_held(rq);
-
-	queued =3D task_on_rq_queued(p);
-	running =3D task_current_donor(rq, p);
-
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	u32 flags =3D DEQUEUE_SAVE | DEQUEUE_NOCLOCK;
=20
-	if (running)
-		put_prev_task(rq, p);
-
-	p->sched_class->set_cpus_allowed(p, ctx);
-	mm_set_cpus_allowed(p->mm, ctx->new_mask);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	scoped_guard (sched_change, p, flags) {
+		p->sched_class->set_cpus_allowed(p, ctx);
+		mm_set_cpus_allowed(p->mm, ctx->new_mask);
+	}
 }
=20
 /*

