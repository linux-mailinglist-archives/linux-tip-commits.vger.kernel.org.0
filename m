Return-Path: <linux-tip-commits+bounces-2959-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54119E19A5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B958D1667FB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 10:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC21E2840;
	Tue,  3 Dec 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWxyYlbK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7Tt4VXQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6A1E25F8;
	Tue,  3 Dec 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222683; cv=none; b=sCHWdOrzrGLimgECGxo5O6DtURQpNDMSaJyWJaON64f089O0RP0TKZtSFTLXfuv+eiZ3Xhtb0Fu97CgH/0dqWbJeDVUPgN1k0rAjkAbxvKFHHaBUjGufDU0rqAlWu8kYbt1jsEJaKLrWD6AZOn8lK4Ga+Xuay7Yenx+RPvqQ2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222683; c=relaxed/simple;
	bh=C97x5hh/hTMOEYwTxhCMiL3W+rAgq57Xcqc9r4edV7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NCmUoFh/n6s29o3qGmD9VYDcaFks3ARtzFOXGYf+OnkbyZ6fPMBKgOO7+f6GQ+CvmKVSOLcOQyRpfvl75ORd1LflnavzD3Zq9NwzdxSmyfechMRN/LrbLDuoUkDlFAx0mzQVzB3DA79gVCJfX2zXkpODyJQFcUUaaCYQUWWmbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWxyYlbK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7Tt4VXQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 10:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733222679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIJdmTm5Vp2lnu1fjfqPc+F6L/CofxHMN8vvBx3sE3c=;
	b=CWxyYlbKEA7lwtuFfqAZwqZv1fkebaFFZCTSHzINgZQa+ggfnU8Lc2QLXVWeQLDH0h5c7U
	R/bmMTOg2Vow56YRERhpOsNQG8KGVKCBC8n/SiZJHtxyNIUOWz7u/d+n4QcYzlO01ZMidJ
	f2bNNd/82sMomI6Q/k7cRun+ckVsZHEAXl0FM+EyKz2Ee1aalkhhEfr+G/AYy5tWsr4m7T
	aGzZoPwv+RMazdWez3YOpqHw8eyBECOhi8gvFfL5O45gHQHxPaHSvfpT29Z+l4rkeBBFeX
	gp6V/ujhqnHfwewx3B6w55gbxTS/kV4pEn7oGGvKxPdqJraG4vGVti6bkoUxaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733222679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIJdmTm5Vp2lnu1fjfqPc+F6L/CofxHMN8vvBx3sE3c=;
	b=N7Tt4VXQJ6Ng1wlMNEmrmy1J3Ts6U7Xuk0MPcusZzFvgjfsRC/femv2GAV07pjBcdFcN5c
	Xiy15z0D69IVrZBQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove HK_TYPE_SCHED
Cc: Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241030175253.125248-2-longman@redhat.com>
References: <20241030175253.125248-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322267900.412.7469424556416462990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ae5c677729e99b8cb3e6252aaa9b72a92985d203
Gitweb:        https://git.kernel.org/tip/ae5c677729e99b8cb3e6252aaa9b72a92985d203
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 30 Oct 2024 13:52:50 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:24:27 +01:00

sched/core: Remove HK_TYPE_SCHED

The HK_TYPE_SCHED housekeeping type is defined but not set anywhere. So
any code that try to use HK_TYPE_SCHED are essentially dead code. So
remove HK_TYPE_SCHED and any code that use it.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20241030175253.125248-2-longman@redhat.com
---
 include/linux/sched/isolation.h |  1 -
 kernel/sched/fair.c             | 14 --------------
 kernel/sched/isolation.c        |  1 -
 3 files changed, 16 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b46112..499d5e4 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -10,7 +10,6 @@ enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,
 	HK_TYPE_MISC,
-	HK_TYPE_SCHED,
 	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
 	HK_TYPE_WQ,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4283c81..ef30226 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12197,9 +12197,6 @@ static inline int on_null_domain(struct rq *rq)
  * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- *
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
- *   anywhere yet.
  */
 static inline int find_new_ilb(void)
 {
@@ -12444,10 +12441,6 @@ void nohz_balance_enter_idle(int cpu)
 	if (!cpu_active(cpu))
 		return;
 
-	/* Spare idle load balancing on CPUs that don't want to be disturbed: */
-	if (!housekeeping_cpu(cpu, HK_TYPE_SCHED))
-		return;
-
 	/*
 	 * Can be set safely without rq->lock held
 	 * If a clear happens, it will have evaluated last additions because
@@ -12667,13 +12660,6 @@ static void nohz_newidle_balance(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu;
 
-	/*
-	 * This CPU doesn't want to be disturbed by scheduler
-	 * housekeeping
-	 */
-	if (!housekeeping_cpu(this_cpu, HK_TYPE_SCHED))
-		return;
-
 	/* Will wake up very soon. No time for doing anything else*/
 	if (this_rq->avg_idle < sysctl_sched_migration_cost)
 		return;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e71..5345e11 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -12,7 +12,6 @@ enum hk_flags {
 	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
 	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
 	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
-	HK_FLAG_SCHED		= BIT(HK_TYPE_SCHED),
 	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),

