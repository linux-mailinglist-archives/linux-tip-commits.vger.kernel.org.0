Return-Path: <linux-tip-commits+bounces-3219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B774A11D31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C457D163925
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50622FAE3;
	Wed, 15 Jan 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1JsIPhd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsfh8zR8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E51EEA3B;
	Wed, 15 Jan 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932638; cv=none; b=nFyJxJtvWrJyrSuZw3SirhQfD8pIFgSHwkcAHcz5ZeF2Cy67FAqMoXE9EpEYYGsbWaYpE620sM5fYKnlhb2ZTrH/TtkXjwFQ7ZX+kGPAgvhfjbayu9ylg7leQsi6UGwkZWhEGucAAVC9qmuQLLCwIvFjKtvSRkNtYA7gtnAAKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932638; c=relaxed/simple;
	bh=nVj5X3ixTup9EtpeUSE+YYAQrpqvYTasbVQJVF3Ku60=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c8uuisWA9kU0cmHxwN83oik4fpcJ/bC5hzQNVV4LsBBA3eWd6HYTXWUXYYzmwuRaxFWP7e6QvwK5w1zTUsEiUFkqaNrfXYEOtMH4LonP0CzpTK4BN8ffrF5hodQPODlLXLzLWQbscs9CjunW6R64k3/hrgroNOuzMW7vsaTP0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1JsIPhd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsfh8zR8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Udm7kv6MT9K0cCDIjdTbPp+Im46cxWEHXXwRyLGyxE=;
	b=G1JsIPhdv9M6JS802CEF+JD6pdYfxy76Xwdy+geSVFW69/d9CHVIXkGQSlKZ6MTcoF4eKc
	TdM2JEqMyKVVjw1esQYpkzuZdFIrh55os7u61NQAe7GmsKu980k9ZLzgFiKMVKT7y5DaC1
	x/sWFKknalu0CrIEHL9UfcNVzrQuGCuVmFvu4xc7RZPOMy9P0S9gBs4GkRiIUzXxbYPeW7
	0+HCBtE75hNyWk2eUfcX7bVEkZzdt7y5nIi/p3Q3IjlsCZF9IWvHFsH6TYz63aw9ghaYLQ
	JhU5nHUfisOaIRUlBzCu8p/qQGp50g/NXnZQfiyBeyKLKFB7v896N7d9npg6Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Udm7kv6MT9K0cCDIjdTbPp+Im46cxWEHXXwRyLGyxE=;
	b=rsfh8zR8Rlqt6sFs77qyfam3G+w5vSHFp+b2KDGgOjZ0PyIkTw47pJt3JLcSkKIwaU4GGt
	uanVKapJEXg31SDA==
From: "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't account irq time if
 sched_clock_irqtime is disabled
Cc: Yafang Shao <laoar.shao@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, mkoutny@suse.com,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250103022409.2544-3-laoar.shao@gmail.com>
References: <20250103022409.2544-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263425.31546.8534211192244236490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     763a744e24a8cfbcc13f699dcdae13a627b8588e
Gitweb:        https://git.kernel.org/tip/763a744e24a8cfbcc13f699dcdae13a627b=
8588e
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Fri, 03 Jan 2025 10:24:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:25 +01:00

sched: Don't account irq time if sched_clock_irqtime is disabled

sched_clock_irqtime may be disabled due to the clock source, in which case
IRQ time should not be accounted. Let's add a conditional check to avoid
unnecessary logic.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250103022409.2544-3-laoar.shao@gmail.com
---
 kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8490293..22dfcd3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -740,29 +740,31 @@ static void update_rq_clock_task(struct rq *rq, s64 del=
ta)
 	s64 __maybe_unused steal =3D 0, irq_delta =3D 0;
=20
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-	irq_delta =3D irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
+	if (irqtime_enabled()) {
+		irq_delta =3D irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
=20
-	/*
-	 * Since irq_time is only updated on {soft,}irq_exit, we might run into
-	 * this case when a previous update_rq_clock() happened inside a
-	 * {soft,}IRQ region.
-	 *
-	 * When this happens, we stop ->clock_task and only update the
-	 * prev_irq_time stamp to account for the part that fit, so that a next
-	 * update will consume the rest. This ensures ->clock_task is
-	 * monotonic.
-	 *
-	 * It does however cause some slight miss-attribution of {soft,}IRQ
-	 * time, a more accurate solution would be to update the irq_time using
-	 * the current rq->clock timestamp, except that would require using
-	 * atomic ops.
-	 */
-	if (irq_delta > delta)
-		irq_delta =3D delta;
+		/*
+		 * Since irq_time is only updated on {soft,}irq_exit, we might run into
+		 * this case when a previous update_rq_clock() happened inside a
+		 * {soft,}IRQ region.
+		 *
+		 * When this happens, we stop ->clock_task and only update the
+		 * prev_irq_time stamp to account for the part that fit, so that a next
+		 * update will consume the rest. This ensures ->clock_task is
+		 * monotonic.
+		 *
+		 * It does however cause some slight miss-attribution of {soft,}IRQ
+		 * time, a more accurate solution would be to update the irq_time using
+		 * the current rq->clock timestamp, except that would require using
+		 * atomic ops.
+		 */
+		if (irq_delta > delta)
+			irq_delta =3D delta;
=20
-	rq->prev_irq_time +=3D irq_delta;
-	delta -=3D irq_delta;
-	delayacct_irq(rq->curr, irq_delta);
+		rq->prev_irq_time +=3D irq_delta;
+		delta -=3D irq_delta;
+		delayacct_irq(rq->curr, irq_delta);
+	}
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {

