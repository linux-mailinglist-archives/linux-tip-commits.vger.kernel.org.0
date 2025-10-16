Return-Path: <linux-tip-commits+bounces-6848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC88BE2750
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4415A3E2830
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6371324B37;
	Thu, 16 Oct 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rG0HrXlu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6jRR9HyU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C523233E5;
	Thu, 16 Oct 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607231; cv=none; b=rLCT9MaKNJupzEaPYaPTNJT2cLkCti7VghG7hhsnpDoB2u6p090QMl8ewUq+Cbuw3xcZeatqzWNhK0uZIFTm1mSkRnAgVpt4i6PzFj0lGHWxsev2Q1B9GJWVbuSkJ7gWVYFBIwVw3RXXBV21Tf5T3sQabHD44t4JdP5V+oMhtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607231; c=relaxed/simple;
	bh=xTChIEKN8oTH//uTlcqzythXvBvUxNO4b8sJ7dTm3MU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P30xn8D5DGfcfuoWR6aI5OUdMAYzmk96zkL5o7gOQaTLy9ak/AJkGwDPf2c0oHxj8uT0LSTq+ysaM799MDhyGQkmg0UyPfVo1Av+vRGufIm9SqjxbLnWeKwRcZYCKvqiHrgJY8pTIC2dTQ2ekx3l2Ll/VapzBYa8cWOepf5StWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rG0HrXlu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6jRR9HyU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdd/4fWTOAMmXq3ym4xurDuMutO3G2sYRgjIheI1QH8=;
	b=rG0HrXluVQJ0sekuuImTH5daHMw+IKjxACHZlybOe4ck4u5vYXe+xXseMpRIBdN7+dxnIs
	KZeCXEgBui8EAyO38yD82Yuz3Bss1QpZUQr4UV4QVy5MlDi/4oSZGW+2yb76bJH3S0Qp0T
	8CllkO9ELDjc40kRr2jq+ziVpa4q6hidNZZnpXmvWeiufgOmGH88xeQE1C71+QvI9C0NCr
	679utR2tpL4skuMN4930LikwiB4QcXfRrHIQe4QTtgprwACC+wkBUb/5ObikLlROfAGwkH
	JVwz6LCpimao8DMysJtCdOXE3zR71y04gh/PFjo7iQTkM70eyrSHn3Fz8gyZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdd/4fWTOAMmXq3ym4xurDuMutO3G2sYRgjIheI1QH8=;
	b=6jRR9HyU80GBULtxvoVITg5z/06CHtOhWD6eLRUL+CY4uU9WbeGrqW0EM85UfpEJxHKJeY
	4Y3BZIbYVXnLPbBw==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Forfeit vruntime on yield
Cc: Fernand Sieber <sieberf@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250918150528.292620-1-sieberf@amazon.com>
References: <20250918150528.292620-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722706.709179.4726867528904925275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     79104becf42baeeb4a3f2b106f954b9fc7c10a3c
Gitweb:        https://git.kernel.org/tip/79104becf42baeeb4a3f2b106f954b9fc7c=
10a3c
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 18 Sep 2025 17:05:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:49 +02:00

sched/fair: Forfeit vruntime on yield

If a task yields, the scheduler may decide to pick it again. The task in
turn may decide to yield immediately or shortly after, leading to a tight
loop of yields.

If there's another runnable task as this point, the deadline will be
increased by the slice at each loop. This can cause the deadline to runaway
pretty quickly, and subsequent elevated run delays later on as the task
doesn't get picked again. The reason the scheduler can pick the same task
again and again despite its deadline increasing is because it may be the
only eligible task at that point.

Fix this by making the task forfeiting its remaining vruntime and pushing
the deadline one slice ahead. This implements yield behavior more
authentically.

We limit the forfeiting to eligible tasks. This is because core scheduling
prefers running ineligible tasks rather than force idling. As such, without
the condition, we can end up on a yield loop which makes the vruntime
increase rapidly, leading to anomalous run delays later down the line.

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  polic=
y")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250916140228.452231-1-sieberf@amazon.com
---
 kernel/sched/fair.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce..00f9d6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9007,7 +9007,19 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
=20
-	se->deadline +=3D calc_delta_fair(se->slice, se);
+	/*
+	 * Forfeit the remaining vruntime, only if the entity is eligible. This
+	 * condition is necessary because in core scheduling we prefer to run
+	 * ineligible tasks rather than force idling. If this happens we may
+	 * end up in a loop where the core scheduler picks the yielding task,
+	 * which yields immediately again; without the condition the vruntime
+	 * ends up quickly running away.
+	 */
+	if (entity_eligible(cfs_rq, se)) {
+		se->vruntime =3D se->deadline;
+		se->deadline +=3D calc_delta_fair(se->slice, se);
+		update_min_vruntime(cfs_rq);
+	}
 }
=20
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)

