Return-Path: <linux-tip-commits+bounces-8246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAkaA8trnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:47 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FACC18459D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505CC301617E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4F3451BB;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrNSYSqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aj4MJ/NJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0B36B052;
	Tue, 24 Feb 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924404; cv=none; b=lQkLBvo6Wk34YUeOr1dNkai3bI2lAt4pCPkPyWlUwMF3g1j0bZRWM5KTnL0bIM2idZTuVlJgUrmYekpMfkeHBJ0kD4V5YWs5azuPbD6sZQGz8uq/jGO4bTfnXF0rXsg1i/tEkTOmyk+d4U/bACQWVAcdDsToc5t5GTySCRECkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924404; c=relaxed/simple;
	bh=ijgtOyKSCunYvpmV5Ytjm45BPDSuwaLsQcPbxO/eirU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IhKkq+uZhCHNN+/MSXjTIYvBLrYyUmIH8+1Cp9GYIPfjY1UrMw07GM6MuoFoGHwJkMiJTjm0odcMwkANYEOOJWplOFoGod66dJyK8EUkbOHkmrlyZoEU1q2CZhi0+aDyal609yHEblQN28tCej1cJeE+8YBaTP0hQnUkTI9Z174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrNSYSqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aj4MJ/NJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSYC1n62QUgdAnxEZcaKYmhdYsMa3+uKvX5CUZVCD0o=;
	b=yrNSYSqoStQwanu8g3TPKmF6jjKoADoo/jUQbsf4tH43hDpxvMqIEKJuCLxG7iwUUO8RI1
	USDdDEL0Oe86iiKmlqdHFKg13sAAyinjVCWpGimRhVdAFkCq6welp/17bcrAz46HLdYl2z
	5U45KVJyKCTEafZysQLrjLOG6H2Z1VjWAx8rkkTomzHn73z/Lf38zim2HhDxi9eL3gSTCd
	dEoDAfMRzOVkszJolMO8sGH8YbzpsXcpcQnMWUfuffQH9NvXd/H4EHXVPBD8gS+4YwYeo3
	HsDYemaYuTFxw9Y86hI+DpSH74dBQFMvwt4DEB1AEKbrwnExzYUCAWwQY2FUVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSYC1n62QUgdAnxEZcaKYmhdYsMa3+uKvX5CUZVCD0o=;
	b=aj4MJ/NJTL1OS2YWjXxBetBP99Q0NZJv5S9ywwobXtHVu+ZMHuv45AsBVgDL46XFNidrEG
	e+6cIGmAsj6jtXDw==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Skip SCHED_IDLE rq for SCHED_IDLE task
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203184939.2138022-1-christian.loehle@arm.com>
References: <20260203184939.2138022-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192439433.1647592.14120998907172166033.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8246-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email,linaro.org:email,arm.com:email]
X-Rspamd-Queue-Id: 4FACC18459D
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fd54d81c2c0e6cffd5470c2c27fbb04d0ebe7da0
Gitweb:        https://git.kernel.org/tip/fd54d81c2c0e6cffd5470c2c27fbb04d0eb=
e7da0
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 03 Feb 2026 18:49:39=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:12 +01:00

sched/fair: Skip SCHED_IDLE rq for SCHED_IDLE task

CPUs whose rq only have SCHED_IDLE tasks running are considered to be
equivalent to truly idle CPUs during wakeup path. For fork and exec
SCHED_IDLE is even preferred.
This is based on the assumption that the SCHED_IDLE CPU is not in an
idle state and might be in a higher P-state, allowing the task/wakee
to run immediately without sharing the rq.

However this assumption doesn't hold if the wakee has SCHED_IDLE policy
itself, as it will share the rq with existing SCHED_IDLE tasks. In this
case, we are better off continuing to look for a truly idle CPU.

On a Intel Xeon 2-socket with 64 logical cores in total this yields
for kernel compilation using SCHED_IDLE:

+---------+----------------------+----------------------+--------+
| workers | mainline (seconds)   | patch (seconds)      | delta% |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+
|       1 | 4384.728 =C2=B1 21.085    | 3843.250 =C2=B1 16.235    | -12.35 |
|       2 | 2242.513 =C2=B1 2.099     | 1971.696 =C2=B1 2.842     | -12.08 |
|       4 | 1199.324 =C2=B1 1.823     | 1033.744 =C2=B1 1.803     | -13.81 |
|       8 |  649.083 =C2=B1 1.959     |  559.123 =C2=B1 4.301     | -13.86 |
|      16 |  370.425 =C2=B1 0.915     |  325.906 =C2=B1 4.623     | -12.02 |
|      32 |  234.651 =C2=B1 2.255     |  217.266 =C2=B1 0.253     |  -7.41 |
|      64 |  202.286 =C2=B1 1.452     |  197.977 =C2=B1 2.275     |  -2.13 |
|     128 |  217.092 =C2=B1 1.687     |  212.164 =C2=B1 1.138     |  -2.27 |
+---------+----------------------+----------------------+--------+

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20260203184939.2138022-1-christian.loehle@arm.=
com
---
 kernel/sched/fair.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 966e252..d57c02e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7064,9 +7064,15 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
=20
-static int sched_idle_cpu(int cpu)
+static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
 {
-	return sched_idle_rq(cpu_rq(cpu));
+	return sched_idle_rq(rq) && !task_has_idle_policy(p);
+}
+
+static int choose_idle_cpu(int cpu, struct task_struct *p)
+{
+	return available_idle_cpu(cpu) ||
+	       choose_sched_idle_rq(cpu_rq(cpu), p);
 }
=20
 static void
@@ -7631,7 +7637,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *gr=
oup, struct task_struct *
 		if (!sched_core_cookie_match(rq, p))
 			continue;
=20
-		if (sched_idle_cpu(i))
+		if (choose_sched_idle_rq(rq, p))
 			return i;
=20
 		if (available_idle_cpu(i)) {
@@ -7722,8 +7728,7 @@ static inline int sched_balance_find_dst_cpu(struct sch=
ed_domain *sd, struct tas
=20
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
-	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
-	    sched_cpu_cookie_match(cpu_rq(cpu), p))
+	if (choose_idle_cpu(cpu, p) && sched_cpu_cookie_match(cpu_rq(cpu), p))
 		return cpu;
=20
 	return -1;
@@ -7796,7 +7801,8 @@ static int select_idle_core(struct task_struct *p, int =
core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle =3D false;
 			if (*idle_cpu =3D=3D -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
+				if (choose_sched_idle_rq(cpu_rq(cpu), p) &&
+				    cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu =3D cpu;
 					break;
 				}
@@ -7831,7 +7837,7 @@ static int select_idle_smt(struct task_struct *p, struc=
t sched_domain *sd, int t
 		 */
 		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		if (choose_idle_cpu(cpu, p))
 			return cpu;
 	}
=20
@@ -7953,7 +7959,7 @@ select_idle_capacity(struct task_struct *p, struct sche=
d_domain *sd, int target)
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap =3D capacity_of(cpu);
=20
-		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
+		if (!choose_idle_cpu(cpu, p))
 			continue;
=20
 		fits =3D util_fits_cpu(task_util, util_min, util_max, cpu);
@@ -8024,7 +8030,7 @@ static int select_idle_sibling(struct task_struct *p, i=
nt prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
=20
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if (choose_idle_cpu(target, p) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
=20
@@ -8032,7 +8038,7 @@ static int select_idle_sibling(struct task_struct *p, i=
nt prev, int target)
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev !=3D target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    choose_idle_cpu(prev, p) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
=20
 		if (!static_branch_unlikely(&sched_cluster_active) ||
@@ -8064,7 +8070,7 @@ static int select_idle_sibling(struct task_struct *p, i=
nt prev, int target)
 	if (recent_used_cpu !=3D prev &&
 	    recent_used_cpu !=3D target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)=
) &&
+	    choose_idle_cpu(recent_used_cpu, p) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
=20
@@ -12531,7 +12537,7 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 {
 	int continue_balancing =3D 1;
 	int cpu =3D rq->cpu;
-	int busy =3D idle !=3D CPU_IDLE && !sched_idle_cpu(cpu);
+	int busy =3D idle !=3D CPU_IDLE && !sched_idle_rq(rq);
 	unsigned long interval;
 	struct sched_domain *sd;
 	/* Earliest time when we have to do rebalance again */
@@ -12569,7 +12575,7 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 				 * state even if we migrated tasks. Update it.
 				 */
 				idle =3D idle_cpu(cpu);
-				busy =3D !idle && !sched_idle_cpu(cpu);
+				busy =3D !idle && !sched_idle_rq(rq);
 			}
 			sd->last_balance =3D jiffies;
 			interval =3D get_sd_balance_interval(sd, busy);

