Return-Path: <linux-tip-commits+bounces-8224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP2dAGYrnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:26:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FD174D87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74B72302BF4C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF34361662;
	Mon, 23 Feb 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zo3f+tY6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzXHDWs3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBC36164A;
	Mon, 23 Feb 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842324; cv=none; b=EliKB79kncPBtHglHjm7ahi6ORNrB+zSRpfDt9ADc7xTuZ3P5yGvsauwMTd4V8saxJW43aa5MbnqDVteH6/I27ihdsXulEXpzWVKS9gwAIu+h/h4Z4xJhok85Fv/2WMQVJ1P1JEfNACwnU79hGk07OwSvMDFRnbmI/seddrUmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842324; c=relaxed/simple;
	bh=AXYzKtyuEAx5SASEB8+OUDwTQYMskNqMJL2cFM5umbU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s5vSvf6K7gKtDs3znQBlnAXIHp/xtb2ATMilh0LMlT0hHTkHHqHit3zYzcWCXgDVW8nc9rW28lQWsWK76BV/acU24i6fZdcJZpFKqsV7I0K2aOvG3jCAi7AXxBJiDU5i1AkY3eAsicjH2QykMSyRks+rpExVlTq+o/N4r3/dZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zo3f+tY6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzXHDWs3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL26lMjojS9JPvzV1aSu02M2Qw/brGFYQKZLSWU3o7w=;
	b=Zo3f+tY6V/1sHJY2NcsKAY6SZXKxERx3UwMsXi8AU8j+eIWO8pFw8USngbQk6aDkh/gf6x
	HEHBU6KI3GY8276cCrJXRjAqiy0P1b77ybWGH9eiM/0RXutNkySvocg6b7qrkfTGybjkE0
	iC25Nxl9QYbxcYtYiSPp5r4rsC1fEdL123ez7dJVnonbtVStvYfgw2xxpY4zBEte+et0Y5
	BYVrdbH485UeOVp0o+ilo55Cb8kW42kooigA8RyRSq3WYv1hm6LA1bK7oBDIeyh8SeAxL6
	sIYcBU+68vqcUTD8e2IfVPSVbzp6DLXad/OMs0F6KvhoL5p83J3koWyiaRV6TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CL26lMjojS9JPvzV1aSu02M2Qw/brGFYQKZLSWU3o7w=;
	b=TzXHDWs3h2hE8fD/HSVM1ZfXkdp+7Fv2yyZFPqLHVh+HEM9y2bd3lCaik0ZmPpy+U+694d
	xcTiKE4QgeY/pjCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/core: Fix wakeup_preempt's next_class tracking
Cc: Sean Christopherson <seanjc@google.com>,
 kernel test robot <oliver.sang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260218163329.GQ1395416@noisy.programming.kicks-ass.net>
References: <20260218163329.GQ1395416@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184231937.1647592.18062966302455812507.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8224-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,intel.com:email,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 954FD174D87
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5324953c06bd929c135d9e04be391ee2c11b5a19
Gitweb:        https://git.kernel.org/tip/5324953c06bd929c135d9e04be391ee2c11=
b5a19
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Feb 2026 17:33:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:19 +01:00

sched/core: Fix wakeup_preempt's next_class tracking

Kernel test robot reported that
tools/testing/selftests/kvm/hardware_disable_test was failing due to
commit 704069649b5b ("sched/core: Rework sched_class::wakeup_preempt()
and rq_modified_*()")

It turns out there were two related problems that could lead to a
missed preemption:

 - when hitting newidle balance from the idle thread, it would elevate
   rb->next_class from &idle_sched_class to &fair_sched_class, causing
   later wakeup_preempt() calls to not hit the sched_class_above()
   case, and not issue resched_curr().

   Notably, this modification pattern should only lower the
   next_class, and never raise it. Create two new helper functions to
   wrap this.

 - when doing schedule_idle(), it was possible to miss (re)setting
   rq->next_class to &idle_sched_class, leading to the very same
   problem.

Cc: Sean Christopherson <seanjc@google.com>
Fixes: 704069649b5b ("sched/core: Rework sched_class::wakeup_preempt() and rq=
_modified_*()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202602122157.4e861298-lkp@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260218163329.GQ1395416@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/core.c  |  1 +
 kernel/sched/ext.c   |  4 ++--
 kernel/sched/fair.c  |  4 ++--
 kernel/sched/sched.h | 11 +++++++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7597776..b7f77c1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6830,6 +6830,7 @@ static void __sched notrace __schedule(int sched_mode)
 		/* SCX must consult the BPF scheduler to tell if rq is empty */
 		if (!rq->nr_running && !scx_enabled()) {
 			next =3D prev;
+			rq->next_class =3D &idle_sched_class;
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62b1f3a..06cc0a4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2460,7 +2460,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bo=
ol force_scx)
 	/* see kick_cpus_irq_workfn() */
 	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
=20
-	rq->next_class =3D &ext_sched_class;
+	rq_modified_begin(rq, &ext_sched_class);
=20
 	rq_unpin_lock(rq, rf);
 	balance_one(rq, prev);
@@ -2475,7 +2475,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bo=
ol force_scx)
 	 * If @force_scx is true, always try to pick a SCHED_EXT task,
 	 * regardless of any higher-priority sched classes activity.
 	 */
-	if (!force_scx && sched_class_above(rq->next_class, &ext_sched_class))
+	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
 		return RETRY_TASK;
=20
 	keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4446cb..bf948db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12982,7 +12982,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 	t0 =3D sched_clock_cpu(this_cpu);
 	__sched_balance_update_blocked_averages(this_rq);
=20
-	this_rq->next_class =3D &fair_sched_class;
+	rq_modified_begin(this_rq, &fair_sched_class);
 	raw_spin_rq_unlock(this_rq);
=20
 	for_each_domain(this_cpu, sd) {
@@ -13049,7 +13049,7 @@ static int sched_balance_newidle(struct rq *this_rq, =
struct rq_flags *rf)
 		pulled_task =3D 1;
=20
 	/* If a higher prio class was modified, restart the pick */
-	if (sched_class_above(this_rq->next_class, &fair_sched_class))
+	if (rq_modified_above(this_rq, &fair_sched_class))
 		pulled_task =3D -1;
=20
 out:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b82fb70..43bbf06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2748,6 +2748,17 @@ static inline const struct sched_class *next_active_cl=
ass(const struct sched_cla
=20
 #define sched_class_above(_a, _b)	((_a) < (_b))
=20
+static inline void rq_modified_begin(struct rq *rq, const struct sched_class=
 *class)
+{
+	if (sched_class_above(rq->next_class, class))
+		rq->next_class =3D class;
+}
+
+static inline bool rq_modified_above(struct rq *rq, const struct sched_class=
 *class)
+{
+	return sched_class_above(rq->next_class, class);
+}
+
 static inline bool sched_stop_runnable(struct rq *rq)
 {
 	return rq->stop && task_on_rq_queued(rq->stop);

