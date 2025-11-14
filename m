Return-Path: <linux-tip-commits+bounces-7337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDCC5D14F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F8964E3321
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362D304BBC;
	Fri, 14 Nov 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vtarz58/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKTQVFBT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF92253AB;
	Fri, 14 Nov 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122747; cv=none; b=knpPocJaIP0ydLXlPrBMzXcCQFCNB1O8DYMQPXP8NXofENroGxjOx5LT7ElBdUpwRZoCBY1ScXoht8cNfJJPw+B1bdvaj5sMqjnTJ94bHAZzEeiWyRdU37ZwBOhc3mLa1TPOzxp8uyBrVXXIO7Mibclb+WhTpJJGsUooWPZgyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122747; c=relaxed/simple;
	bh=vAzIE/p4lFPvHgcsb3/HIxzYdFihVsANkGJERJtmC7M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fzVVWZeq9qesw743mcBeDCmTay2APF8NO83U1TGLk54ap58SL2XAQDpfzXKO09rSnfBEzzzmyKpziUi/wRzE1o6txScLYbXVcuUPHUn0HUszvqejAR0XWbEC48VTST1YVxH0f07R6UAoXuNftFXHfbvWBKoyYlMvX3wR24iwE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vtarz58/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKTQVFBT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdPdQHAym+93doUBvL8JJBkLYrlUoRzNay54DLhR4+I=;
	b=Vtarz58/Q3eIawiEbedIRuV7X/qmjPvzHkT7cSO36uvX0L+8L2YSbb+/BOW1u2tonnWlfs
	cyLT54dUJzjmhNVhwqA/Wnbcfm6UnLvIA4oXOzfXFLajQy4kXQ/pIE9wfHlOR8oMsEjN8h
	bBN+fhyN64KLH93fo/IQO58O/5LMa0rD+fWpyea2PqoLi6NCjguVl3nfLm/ylEk0TJ4BTT
	dXBsLG3lgZtJ922QD2otGb8J/pyu0q93F5ORldsxyak19qm33KKMq6llDXbx31tswhdNKu
	8ooBHhfRmB0vXwigAszXLojiQPjsTHvrYiu3tSWc2R4VOB/cIJXsZM60PE0m5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122744;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdPdQHAym+93doUBvL8JJBkLYrlUoRzNay54DLhR4+I=;
	b=vKTQVFBTMbO+QXfB29tzSkqToeOMH1mMS+cuudNcUpYRcWPbaYK+5nG5GI4QcJv3oKDX0l
	D5xhBsZHZuUD3/Ag==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Revert max_newidle_lb_cost bump
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Chris Mason <clm@meta.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107161739.406147760@infradead.org>
References: <20251107161739.406147760@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274291.498.4509981768126901496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     63bdc220840d16b370fdf678b7d916552fef046e
Gitweb:        https://git.kernel.org/tip/63bdc220840d16b370fdf678b7d916552fe=
f046e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:07 +01:00

sched/fair: Revert max_newidle_lb_cost bump

Many people reported regressions on their database workloads due to:

  155213a2aed4 ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balanc=
e fails")

For instance Adam Li reported a 6% regression on SpecJBB.

Conversely this will regress schbench again; on my machine from 2.22
Mrps/s down to 2.04 Mrps/s.

Reported-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Reported-by: Adam Li <adamli@os.amperecomputing.com>
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://lkml.kernel.org/r/20250626144017.1510594-2-clm@fb.com
Link: https://lkml.kernel.org/r/006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.c=
om
Link: https://patch.msgid.link/20251107161739.406147760@infradead.org
---
 kernel/sched/fair.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d480e..bfb8935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12229,14 +12229,8 @@ static inline bool update_newidle_cost(struct sched_=
domain *sd, u64 cost)
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
-		 *
-		 * sched_balance_newidle() bumps the cost whenever newidle
-		 * balance fails, and we don't want things to grow out of
-		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost =3D
-			min(cost, sysctl_sched_migration_cost + 200);
+		sd->max_newidle_lb_cost =3D cost;
 		sd->last_decay_max_lb_cost =3D jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -12919,17 +12913,10 @@ static int sched_balance_newidle(struct rq *this_rq=
, struct rq_flags *rf)
=20
 			t1 =3D sched_clock_cpu(this_cpu);
 			domain_cost =3D t1 - t0;
+			update_newidle_cost(sd, domain_cost);
+
 			curr_cost +=3D domain_cost;
 			t0 =3D t1;
-
-			/*
-			 * Failing newidle means it is not effective;
-			 * bump the cost so we end up doing less of it.
-			 */
-			if (!pulled_task)
-				domain_cost =3D (3 * sd->max_newidle_lb_cost) / 2;
-
-			update_newidle_cost(sd, domain_cost);
 		}
=20
 		/*

