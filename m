Return-Path: <linux-tip-commits+bounces-8026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B761D28D1C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83F22301B5AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7743314A9;
	Thu, 15 Jan 2026 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8NDzoOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFzoC4+f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2B330D29;
	Thu, 15 Jan 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513462; cv=none; b=YlNoHCj4t6V0uPCA/VDSpaLy0hUugHigAb2Dq16U4UEIw8JMYzstVomG0aPNzBGfKUqMx+j2CCbfeVYt8ZU/ofsJrEKfA77QB4dwXsi55pApXhLzh4BCewyymBTQj3LiJKpZdqqh2ZljdTbVzsy43xwxN0Ei3zTHCgqUd9HgX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513462; c=relaxed/simple;
	bh=xwT3BnQRotMcefoVIz2FN3/2sXfl6mODqRYC+Nf1jxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T07xk0RXYOPsuWymWL5vpKv3B814tYfCaDi0+le7SkRzK7nyr+kbfqJjLfDHS4c2joOayR90O6wngA2ntuLo/hk+hT0J80P6+ZrBF16j9Op3AEQxh8n0iDljdmZvIAix7SyPK/kYarB87kHWue32KaREkxYNMF9iZbWcBQ2CQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8NDzoOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFzoC4+f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaTkyoavW8zwWpD1EkkKbE3pkDOZe/fMwr7uqztsgfs=;
	b=y8NDzoOrmq+JC8AokgIKZU0UY1zo7ze+OhdMo4defnYg7nkcfwnDDhnDjtRKnUny5kfwWp
	srOKvxp5zVNTAycFkw8K/qr5U3DmRwBzkEYW5yL75entTe8vJcuTaB+VhRYs1x9+RFJs7e
	WlBuZWUXFNfSLxa7Rs9FbSqUJZkjdtmQ9MU9wkKnX+YTWV26/4p4rcgHpj/z5ujqclr+tk
	/r2enFZgpKx5fXVy8rlsczhjP73TbmZcXSgRtAVUl/YJwvG0Tey8BMaG0JHoj1JGr1x4O9
	MT5S4DCMPQgmShZ4g8VeTJLp7wWzB9qDpKkbY502CllobE8LFq8FC9mopQoHEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaTkyoavW8zwWpD1EkkKbE3pkDOZe/fMwr7uqztsgfs=;
	b=KFzoC4+f2Dx6CKlZGzG1i1kQscAs0D83JKwmis5QAK7OtNxAou3uM2P8TWfCgjw975OMNx
	Pa1m7NdF+Ss2XQBQ==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Move checking for nohz cpus after time check
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115073524.376643-2-sshegde@linux.ibm.com>
References: <20260115073524.376643-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345770.510.484552731470077965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6b67c8a72e56041f91f70ae5995bdb769761869a
Gitweb:        https://git.kernel.org/tip/6b67c8a72e56041f91f70ae5995bdb76976=
1869a
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 15 Jan 2026 13:05:22 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 22:41:26 +01:00

sched/fair: Move checking for nohz cpus after time check

Current code does.
- Read nohz.nr_cpus
- Check if the time has passed to do NOHZ idle balance

Instead do this.
- Check if the time has passed to do NOHZ idle balance
- Read nohz.nr_cpus

This will skip the read most of the time in normal system usage.
i.e when there are nohz.nr_cpus (system is not 100% busy).

Note that when there are no idle CPUs(100% busy), even if the flag gets
set to NOHZ_STATS_KICK | NOHZ_NEXT_KICK, find_new_ilb will fail and
there will be no NOHZ idle balance. In such cases there will be a very
narrow window where, kick_ilb will be called un-necessarily.
However current functionality is still retained.

Note: This patch doesn't solve any cacheline overheads. No improvement
in performance apart from saving a few cycles of reading nohz.nr_cpus

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20260115073524.376643-2-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index af120e8..9afe0c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12441,20 +12441,29 @@ static void nohz_balancer_kick(struct rq *rq)
 	 */
 	nohz_balance_exit_idle(rq);
=20
-	/*
-	 * None are in tickless mode and hence no need for NOHZ idle load
-	 * balancing:
-	 */
-	if (likely(!atomic_read(&nohz.nr_cpus)))
-		return;
-
 	if (READ_ONCE(nohz.has_blocked_load) &&
 	    time_after(now, READ_ONCE(nohz.next_blocked)))
 		flags =3D NOHZ_STATS_KICK;
=20
+	/*
+	 * Most of the time system is not 100% busy. i.e nohz.nr_cpus > 0
+	 * Skip the read if time is not due.
+	 *
+	 * If none are in tickless mode, there maybe a narrow window
+	 * (28 jiffies, HZ=3D1000) where flags maybe set and kick_ilb called.
+	 * But idle load balancing is not done as find_new_ilb fails.
+	 * That's very rare. So read nohz.nr_cpus only if time is due.
+	 */
 	if (time_before(now, nohz.next_balance))
 		goto out;
=20
+	/*
+	 * None are in tickless mode and hence no need for NOHZ idle load
+	 * balancing:
+	 */
+	if (likely(!atomic_read(&nohz.nr_cpus)))
+		return;
+
 	if (rq->nr_running >=3D 2) {
 		flags =3D NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 		goto out;

