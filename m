Return-Path: <linux-tip-commits+bounces-1969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E394A650
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE80828591D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B11E2138;
	Wed,  7 Aug 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Euy/L9OW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="59qZ2zlX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EA1E2102;
	Wed,  7 Aug 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027919; cv=none; b=AOV1GN6g2XPVxlyY3/fAELX0TjCmjYOWSzkGio2mKg+rObBfz1J3xvw/mVMZhqaKfx2TRHEEFSgLVKzCif++fQRlpH0bCPLHM5wtObnchUu8Mh2lv7DsLrcF1wt618jwp+C6J1eGlM4z/In0VAg9zxHz6Ofpj37hSk6hXdKL3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027919; c=relaxed/simple;
	bh=0mnB2uadFzZz4dd4/pOjxXYngaIJNZ3kLDmof9vE8Gg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D0y5yaSCGL35pei0KG5NKzlk2+1Sl9WWeWw8EU0gw6DbGQnK+uE2PBefywkq1HUD+IILpVMRJy9tK/MqIHvgkYr1byk0umKlMK+YBS6RpHDWgD1LXYdEnXYx+F5F5qUCqAxw8iJdjhNA1bMDMYseUhpqs5CWq3R/WpecE8VEZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Euy/L9OW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=59qZ2zlX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 10:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siqKHSlT5K/Mdxsb02oB4atj+hD6H7BthO5ZFqRaVeE=;
	b=Euy/L9OWKEv2SJtB6Z9KtOF6Q+SzfsLuzIZpXpPHEGK1fngKIDiiMhDSrL3p5az8mt1jp8
	Xr2rIcHsIFIwDOO9gPAw+Dp8gtobIZx0Fny5UjJdzh+M2JtPI6XX04PoxR7M82Q66pPJpg
	nhcJwYGwNaxOtJbU9MnLIGn1nR3doXYIa8hve3OCLnxVA22cCEnSr3LX1g4ygFz2sqBpl/
	KEKOmTd2jACzAIEuqSHcSK1A3gwRl778N2MioHVJKkJpJWSNzIhHxr98265JHMMhGdpYn9
	v8e1VO3WEvl6kONWfVYurJfQIFoHrvl+8q/bRWS8E4QiNWO3NYvQcGiFE6fmRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723027916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siqKHSlT5K/Mdxsb02oB4atj+hD6H7BthO5ZFqRaVeE=;
	b=59qZ2zlX3uhtsuFK13SxU6Y1sa6DqIAqh6VZV2cH8LrexZDIu20XHfpo3G9sjxB4bV1lP+
	nF7PP8raSDfvTBCg==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make balance_fair() test
 sched_fair_runnable() instead of rq->nr_running
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
References: <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172302791567.2215.7719117741391881278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     924e2904da9b5edec61611918b98ab1f7fccc461
Gitweb:        https://git.kernel.org/tip/924e2904da9b5edec61611918b98ab1f7fccc461
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Mon, 05 Aug 2024 12:39:10 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Aug 2024 12:44:16 +02:00

sched/fair: Make balance_fair() test sched_fair_runnable() instead of rq->nr_running

balance_fair() skips newidle balancing if rq->nr_running - there are already
tasks on the rq, so no need to try to pull tasks. This tests the total
number of queued tasks on the CPU instead of only the fair class, but is
still correct as the rq can currently only have fair class tasks while
balance_fair() is running.

However, with the addition of sched_ext below the fair class, this will not
hold anymore and make put_prev_task_balance() skip sched_ext's balance()
incorrectly as, when a CPU has only lower priority class tasks,
rq->nr_running would still be positive and balance_fair() would return 1
even when fair doesn't have any tasks to run.

Update balance_fair() to use sched_fair_runnable() which tests
rq->cfs.nr_running which is updated by bandwidth throttling. Note that
pick_next_task_fair() already uses sched_fair_runnable() in its optimized
path for the same purpose.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/ZrFUjlCf7x3TNXB8@slm.duckdns.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 795ceef..6d39a82 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8355,7 +8355,7 @@ static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	if (rq->nr_running)
+	if (sched_fair_runnable(rq))
 		return 1;
 
 	return sched_balance_newidle(rq, rf) != 0;

