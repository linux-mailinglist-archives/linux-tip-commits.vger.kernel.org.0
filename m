Return-Path: <linux-tip-commits+bounces-8245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB+MII1snWkkQAQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:17:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F29184698
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D3E30B8494
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249736683E;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btQq3WGs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVwiADza"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794436A007;
	Tue, 24 Feb 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924403; cv=none; b=FvP7aHhQ5Moo7AcbBM82mwyQdjlUENcon3PHLv90OUhXEXpjhbXudu4Z9fqb8fspa+cKl1d63uk80GZ/bLJUrIa3l5R7igrTX6hyWKlI4v2+P4cb2uNLZaMXCeuKyt1mOBrRvisSq0ug9E55G2Dpi5eOtPFkEQWihyG+18GDte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924403; c=relaxed/simple;
	bh=YQw2m4iQuU40cBobNOq9xrEhnV5jJo/Rmx8Nq2XAjYE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cbKr1mfM84P6KMuTKUXGE3A+nFidFqIvfF466RFZ/p5lrPEWfuG7NwV0VShd94EIgMBWG4lmyv4mU8uJj7LwTUVrPmJn+hqyzygv97OBxIj6PdHz0tLNYkbpwIuWCCsZKbOtV2T5tHrbCCmDo+WUYTkLM9MzvCOa9JLytPS5rkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btQq3WGs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVwiADza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/B67+41kscKaFk7KbnTp0KE2Q9CnCyX5K6hvPfBk+z4=;
	b=btQq3WGstyhdErb9xHFJTPTTbarrQYDlMruuvnkY6VWVba6VBLlGCaDtX3D4gWRPOLELZR
	wr3Ie7Fcru9HrHm2Fx6M5G5IOYz6QS/fNCgzDKZXhzyXv7fI2tTMajcP2PBDWkJLBbN8cV
	y0wQ+pMo1EMtnIF6z+Sw9impYGxdSwSU4S0cVZCMdU8eEpNlAyLzq6CVFk4p7pHHwG6B97
	J/CQ2+xXeVlQpToKJ49ZqSfl9k1LH2UW6V5H6v/DnrnyS2CmI3KrRh6br2n3dSeGkNqW5J
	o+fwqaSz9Bqh61UELr/ByH0bjrf/ftNrwPRknYzWAavpbFP5SVqy6OTULI7/yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/B67+41kscKaFk7KbnTp0KE2Q9CnCyX5K6hvPfBk+z4=;
	b=TVwiADza66vsqT9FVidnFsTAwegLzf6eVzih1lRNhP97C+1V1fsJYgsRNFxC84S6zlWmkY
	A/14RtiCrXSnVDDw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Filter false overloaded_group case for EAS
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Pierre Gondois <pierre.gondois@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260206095454.1520619-1-vincent.guittot@linaro.org>
References: <20260206095454.1520619-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439776.1647592.4598836280323193808.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8245-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,linaro.org:email,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D5F29184698
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d3d663faa1d4e86491b77ab72eabc3ea2f58b197
Gitweb:        https://git.kernel.org/tip/d3d663faa1d4e86491b77ab72eabc3ea2f5=
8b197
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 06 Feb 2026 10:54:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:11 +01:00

sched/fair: Filter false overloaded_group case for EAS

With EAS, a group should be set overloaded if at least 1 CPU in the group
is overutilized but it can happen that a CPU is fully utilized by tasks
because of clamping the compute capacity of the CPU. In such case, the CPU
is not overutilized and as a result should not be set overloaded as well.

group_overloaded being a higher priority than group_misfit, such group can
be selected as the busiest group instead of a group with a mistfit task
and prevents load_balance to select the CPU with the misfit task to pull
the latter on a fitting CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://patch.msgid.link/20260206095454.1520619-1-vincent.guittot@linar=
o.org
---
 kernel/sched/fair.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8b052b..966e252 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10211,6 +10211,7 @@ struct sg_lb_stats {
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU =
*/
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its c=
apacity */
+	unsigned int group_overutilized;	/* At least one CPU is overutilized in the=
 group */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -10443,6 +10444,13 @@ group_has_capacity(unsigned int imbalance_pct, struc=
t sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
+	/*
+	 * With EAS and uclamp, 1 CPU in the group must be overutilized to
+	 * consider the group overloaded.
+	 */
+	if (sched_energy_enabled() && !sgs->group_overutilized)
+		return false;
+
 	if (sgs->sum_nr_running <=3D sgs->group_weight)
 		return false;
=20
@@ -10626,14 +10634,12 @@ sched_reduced_capacity(struct rq *rq, struct sched_=
domain *sd)
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
  * @sg_overloaded: sched_group is overloaded
- * @sg_overutilized: sched_group is overutilized
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
-				      bool *sg_overloaded,
-				      bool *sg_overutilized)
+				      bool *sg_overloaded)
 {
 	int i, nr_running, local_group, sd_flags =3D env->sd->flags;
 	bool balancing_at_rd =3D !env->sd->parent;
@@ -10655,7 +10661,7 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
 		sgs->sum_nr_running +=3D nr_running;
=20
 		if (cpu_overutilized(i))
-			*sg_overutilized =3D 1;
+			sgs->group_overutilized =3D 1;
=20
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
@@ -11326,13 +11332,15 @@ static inline void update_sd_lb_stats(struct lb_env=
 *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
=20
-		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded, &sg_overutilized);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_overloaded);
=20
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest =3D sg;
 			sds->busiest_stat =3D *sgs;
 		}
=20
+		sg_overutilized |=3D sgs->group_overutilized;
+
 		/* Now, start updating sd_lb_stats */
 		sds->total_load +=3D sgs->group_load;
 		sds->total_capacity +=3D sgs->group_capacity;

