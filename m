Return-Path: <linux-tip-commits+bounces-2958-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB69E19A4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F45285F8D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68031E2827;
	Tue,  3 Dec 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJZIGJW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ILSaHwt3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FA1E1C17;
	Tue,  3 Dec 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222682; cv=none; b=AmL4PVPUerjMrQMeqQ0REPh3Sxg7VvPloa6FpDf7WZTQDbaZOXxiG6cBnNbYiilCndxeFpJFGfXJcrU+neSh8H+36vARYiq6X/Tzl3b6/1sd8cEL4G+g0duNPibpDjB4hxU3Gc8VPW5dfcxIUvD4e//cMBJSclMiuRkP25ViTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222682; c=relaxed/simple;
	bh=zpUT1RUZ4a+b2shQQxjjW9jm1zJYf93+9GetzzPeOhA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a7Dmaye0ff1p3td7kQaWGQHK7J1tiGCLmULf1+IwQF1y3/8ztu+eYHZk5etmReI19+juJmRncLrVjQUb5EIq/tNH24YfPa6YMA98cyzefBkGJoVYAZz/FiGLy42eueMvHOoQFB27+R6zz11cPUsPhz+EENFtL19FNIaPwlogA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJZIGJW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ILSaHwt3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 10:44:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733222678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huiztSccd7ME6r7/B1ze6xdJ8hqFcYvv1+yZmLRAeYQ=;
	b=wJZIGJW+OPnwuLUgzhlDiwa042ujeIpI2qBhGWVjlP7M7j1hLen6sQpj0sCMZbpMwXDia0
	ZnIJ6yC0fVNvy1i0aav++RTqeRIf8Uc0FPYSy4eSvukwM4VlpYhsCAKgdGNW3oFIcdJiu2
	M2lrdwZqSUIBindfeSU1a3w6oiHhJMIr3pf2oo5jrFyjZo3HFj4kL5kGNKwjDs51p5JFIN
	UoSPCG87gMHFws765fpQhCKn83JXtfcrn9R5bhxOMs+rvRFrzzFufD29c9ydAZmMH8Bd/N
	XxJn/uDv10IxkJyY+ZrmkhLG+/hwOc9zNprY/TpTAHgaHTQeZvAC7GlyM+KqAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733222678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huiztSccd7ME6r7/B1ze6xdJ8hqFcYvv1+yZmLRAeYQ=;
	b=ILSaHwt32QPAiGBTRdOool6F5QaiL6DfmRl7YqWayDN4yZaCE89YBEuEwYNr80MDt5LmEY
	DZ0yX/MFguYz7XCA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Consolidate housekeeping cpumasks
 that are always identical
Cc: Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241030175253.125248-4-longman@redhat.com>
References: <20241030175253.125248-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322267731.412.2437726225719171102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6010d245ddc9f463bbf0311ac49073a78f444755
Gitweb:        https://git.kernel.org/tip/6010d245ddc9f463bbf0311ac49073a78f444755
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 30 Oct 2024 13:52:52 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:24:28 +01:00

sched/isolation: Consolidate housekeeping cpumasks that are always identical

The housekeeping cpumasks are only set by two boot commandline
parameters: "nohz_full" and "isolcpus". When there is more than one of
"nohz_full" or "isolcpus", the extra ones must have the same CPU list
or the setup will fail partially.

The HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are settable by
"isolcpus" only and their settings can be independent of the other
types. The other housekeeping types are all set by "nohz_full" or
"isolcpus=nohz" without a way to set them individually. So they all
have identical cpumasks.

There is actually no point in having different cpumasks for these
"nohz_full" only housekeeping types. Consolidate these types to use the
same cpumask by aliasing them to the same value. If there is a need to
set any of them independently in the future, we can break them out to
their own cpumasks again.

With this change, the number of cpumasks in the housekeeping structure
drops from 9 to 3. Other than that, there should be no other functional
change.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20241030175253.125248-4-longman@redhat.com
---
 include/linux/sched/isolation.h | 20 +++++++++++++-------
 kernel/sched/isolation.c        | 19 ++++++-------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 499d5e4..d8501f4 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,15 +7,21 @@
 #include <linux/tick.h>
 
 enum hk_type {
-	HK_TYPE_TIMER,
-	HK_TYPE_RCU,
-	HK_TYPE_MISC,
-	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
-	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KTHREAD,
-	HK_TYPE_MAX
+	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MAX,
+
+	/*
+	 * The following housekeeping types are only set by the nohz_full
+	 * boot commandline option. So they can share the same value.
+	 */
+	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 6a68632..81bc8b3 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,14 +9,9 @@
  */
 
 enum hk_flags {
-	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
-	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
-	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
-	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -96,7 +91,7 @@ void __init housekeeping_init(void)
 
 	static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping.flags & HK_FLAG_TICK)
+	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
 		sched_tick_offload_init();
 
 	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
@@ -120,7 +115,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	unsigned int first_cpu;
 	int err = 0;
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 			pr_warn("Housekeeping: nohz unsupported."
 				" Build with CONFIG_NO_HZ_FULL\n");
@@ -176,7 +171,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			housekeeping_setup_type(type, housekeeping_staging);
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE))
 		tick_nohz_full_setup(non_housekeeping_mask);
 
 	housekeeping.flags |= flags;
@@ -194,8 +189,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+	flags = HK_FLAG_KERNEL_NOISE;
 
 	return housekeeping_setup(str, flags);
 }
@@ -214,8 +208,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
-				 HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD;
+			flags |= HK_FLAG_KERNEL_NOISE;
 			continue;
 		}
 

