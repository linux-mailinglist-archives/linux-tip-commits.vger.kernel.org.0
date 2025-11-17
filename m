Return-Path: <linux-tip-commits+bounces-7374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68727C65291
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2A0A3656CF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166B2D47F3;
	Mon, 17 Nov 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N57iURAs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGMWtt/m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA02D0C6C;
	Mon, 17 Nov 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396618; cv=none; b=OP+WZfQEi7HFiyqrlQH9GCrRVwvtN8TTdEZymkj+l25o6xWaW9iijM3tIOxM/M8APUYd8uxPtt0yh+5d8ZpgFSOxb9GaHiJ6tuzvnob0NX/C+yaEc0tO/1+jVjyWGM7uYo+RbpBdyy7fDq5kaF9UI/umSqAUVmYXArBI3pja6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396618; c=relaxed/simple;
	bh=8tVeXbg57n+EcFk1oYaSvZNh/2SqTo2YCh/avU3v2ms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PeNBHfyrtLZV6XJuG3VN04ntZHbmnzyLv4aZlgXtqhaMBY/6Xf5koHSvgHFiyjs0HdlEDw0ub64BC0NP21QwPr7jQwVUNyp3K1tsBPsdYENvpvK0HNEhHiXJqipf/7hdRpAL2Erso45W1WFY/SKuPfgPYJVkobbwAxMWfbbAF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N57iURAs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGMWtt/m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V2Rb2jnEXvtpyQK1L9zouehElVeZZKTqLV4HNEG3sY=;
	b=N57iURAsnhFk9NHhjEMyIZovcPycesFMcx6c5L1g3LzZw18bxHXR+hMILW2q+i3K9aS7yH
	rRoCRyge8b/n7gHLrg6uCvVMztBny4EFw2tPyY6KbqqOJiDMBBMf3awa9UebulNAfSAfrj
	LSMPGJEViEmkqokX9NDTaNrKjoRcqJMEqUKy4ToeqPvdv5Dn7UV1JXIIsgRvFKSODivhf4
	hd8h4qATCqCHtdWG98NzdBerf5qlQKyBhrU3cZ8ZVDD0ffIm0WK4LlNV6IOLk2dcjh2OPx
	kxhZ1ww1zTGjbUikAf9Ij0/srNPnsxU/ydAk0WQMYktr+mIyRu3uvC2cC+YcRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V2Rb2jnEXvtpyQK1L9zouehElVeZZKTqLV4HNEG3sY=;
	b=gGMWtt/mlXy71HXhrHebYEsPxvFQ0M88RBIlLgXLOLvzAh5pVFfhMTbfh1zD5HET8JfaH8
	hCkrw1VRm2zvmyBw==
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
Message-ID: <176339661414.498.4916099920274042045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d206fbad9328ddb68ebabd7cf7413392acd38081
Gitweb:        https://git.kernel.org/tip/d206fbad9328ddb68ebabd7cf7413392acd=
38081
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:15 +01:00

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
index c6e5c64..b73af37 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12230,14 +12230,8 @@ static inline bool update_newidle_cost(struct sched_=
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
@@ -12920,17 +12914,10 @@ static int sched_balance_newidle(struct rq *this_rq=
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

