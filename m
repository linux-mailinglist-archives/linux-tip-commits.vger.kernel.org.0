Return-Path: <linux-tip-commits+bounces-6797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58826BD91A7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B99542B33
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47553101AB;
	Tue, 14 Oct 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2b2KFOvP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Ahw4dCi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AE3093CE;
	Tue, 14 Oct 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442474; cv=none; b=VeCvqswjzgtkLtwbfMrb9MmHgVZo/YpVcVSC9kXGCFFuMmWhwfirpNwAcDqVxyyRtYCawI8wNfFICio9cYm5ik4Bwn8zNY0IlYh4AsIvdDWECyiwwP6WalsvKkaclkr31QrVZcspSw4IftolWTzszzk1IBqfxJQym1XkFcGXBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442474; c=relaxed/simple;
	bh=yOjZ8E80CuYTsEek3Pcp8mMOQO4lmPzPY0znhtMsDqk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I3gZT2if9mfz/cXbpMwTOB9a3CakrXaqf79L2CiAiUBz1WXKI6cBvW8fTH9JzophEdZv3RiH6pk0+w9Mjy16E0699KZkhAxkjWpg8lXml46J61rvJxmOJ0ixp/mgCG2HHMg88CNsAUf22Juqig7vieoN+OhUsYYJERA6keSjbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2b2KFOvP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Ahw4dCi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 11:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760442470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlhUeiTWT0+OW46U8WA6ls7dqsH/FX3re/rGqLHw7M4=;
	b=2b2KFOvPfgQFz5MZ2n+iYZ4SFuk6vGDpZubpTvBgQ5EUpzTj0WLcPWg7JvIk7KCo06PNm6
	GbT5lIrcK3kaEBdnbsP6ysk6gTGQ7q3tavGynCohtuYNzBJKdIP7YkWHJf/eCfiVaRZSw1
	lZGRb+hUKUiqRSxUATGI5ViBuIcvrHWnBaMt6tCu+yJY1OcSi0dOFiVbHMGjzMfJ6za/rI
	MhRCfnvPr6pd0F4pw9TboSu1WKG6TCh7Oy9X2zYDTho/4eitNPgYcERixBJzzunkV1nFsf
	2pFJ2dlOze6u3xIlxyyhT7wLBEdJiL5e36+y/QE7eI39zLlaWWl7nBO7DMWH7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760442470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlhUeiTWT0+OW46U8WA6ls7dqsH/FX3re/rGqLHw7M4=;
	b=/Ahw4dCiqXR5kasRoX6Azp+BwuDpJySFfIPiOEsnoQ9SfsO7MGJBlh0Obs75g37boUUoGn
	YjVbMge97DNN07Dg==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix pelt lost idle time detection
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251008131214.3759798-1-vincent.guittot@linaro.org>
References: <20251008131214.3759798-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176044246908.709179.8655968194210096389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     17e3e88ed0b6318fde0d1c14df1a804711cab1b5
Gitweb:        https://git.kernel.org/tip/17e3e88ed0b6318fde0d1c14df1a804711c=
ab1b5
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 08 Oct 2025 15:12:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 13:43:08 +02:00

sched/fair: Fix pelt lost idle time detection

The check for some lost idle pelt time should be always done when
pick_next_task_fair() fails to pick a task and not only when we call it
from the fair fast-path.

The case happens when the last running task on rq is a RT or DL task. When
the latter goes to sleep and the /Sum of util_sum of the rq is at the max
value, we don't account the lost of idle time whereas we should.

Fixes: 67692435c411 ("sched: Rework pick_next_task() slow-path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce..cee1793 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8920,21 +8920,21 @@ simple:
 	return p;
=20
 idle:
-	if (!rf)
-		return NULL;
-
-	new_tasks =3D sched_balance_newidle(rq, rf);
+	if (rf) {
+		new_tasks =3D sched_balance_newidle(rq, rf);
=20
-	/*
-	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it =
is
-	 * possible for any higher priority task to appear. In that case we
-	 * must re-start the pick_next_entity() loop.
-	 */
-	if (new_tasks < 0)
-		return RETRY_TASK;
+		/*
+		 * Because sched_balance_newidle() releases (and re-acquires)
+		 * rq->lock, it is possible for any higher priority task to
+		 * appear. In that case we must re-start the pick_next_entity()
+		 * loop.
+		 */
+		if (new_tasks < 0)
+			return RETRY_TASK;
=20
-	if (new_tasks > 0)
-		goto again;
+		if (new_tasks > 0)
+			goto again;
+	}
=20
 	/*
 	 * rq is about to be idle, check if we need to update the

