Return-Path: <linux-tip-commits+bounces-5796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C42AD8483
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9645B1894D36
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081D2E92A0;
	Fri, 13 Jun 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlmPdLn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="94vZeA28"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2B2E8892;
	Fri, 13 Jun 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800243; cv=none; b=XaIu3Kg6caADkFuSusW+SsYIEqVMmpFuJmzzuhD2RklvC3vPU2ZOhnJXlwsPIYIa7pj/Kska0Ip5IZmmViaI4RuDeiKXMdZhORqLPJWjK2y4cRrOLojRVKvO8qZ13poh/RKty/GAIEn7plvHXJ+152wukHL+ZVfG68BDmOZCS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800243; c=relaxed/simple;
	bh=XgP/B73AmY/SnyNKeXqKgSvCUgXkLQ7PnrSrxElGcd0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E5Mb4YgiG1AlAixdpfwiuCKgJcSJpW7PF9G9QXap0gqBa88fg0DG1STISZDtPqqjLttx7OPZAz8FJqYfJLMLf4SMg34tiFNN5bqU2cyJ5vnSUsYBUpUfnf7k7QASL6Q6/J47QPprWcCX/K7VC8bZe3gzUYNZvdXH8HmvcxvmL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlmPdLn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=94vZeA28; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kzxm4lJtGZzovjd9XEiVm2qV27BFFTf35lFhghH74=;
	b=SlmPdLn3B7I6f8hiA3FJlXPfCNfz4lvbRvU49JCNeogtR3U/+9+pLOrIvEnxfNS5ewiso+
	NvceF+y2LElNtYmsMndru7ulkmHifLmHe5NR2wGRlJUL67yYLMY/GIPGoVupdbk96jvABd
	1UZhMvlvYWrMU5iio/B/0ndEWijGHIqQoO3tjWplUeIMkWgow3FwSqQvimv52/jh4+W7ij
	Y0B8mrq0qVvqpDPo0DK7biwDnEmiAkTj8bG51V/inlTIwLsccf40Ya1IV62sEnqObIkCkm
	4GHSJdm8lqThbgeEntuf9QDHhqkG4WxyIvJeyHsCBdOvmaRbLiVGi8U6Pa9qow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85kzxm4lJtGZzovjd9XEiVm2qV27BFFTf35lFhghH74=;
	b=94vZeA28ji8WXcISQMr6R8SH9J/9eSNZS9Dz5WSm7dZt/yMq5LutAOd6ZHXkP2QEavMgdl
	5/PAgI5JcMC3RCAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of
 idle_thread_set_boot_cpu()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-28-mingo@kernel.org>
References: <20250528080924.2273858-28-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023951.406.15333350398522300812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     74063c1755ca990440a9c61c91bb7a873a40deeb
Gitweb:        https://git.kernel.org/tip/74063c1755ca990440a9c61c91bb7a873a40deeb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:20 +02:00

sched/smp: Use the SMP version of idle_thread_set_boot_cpu()

Simplify the scheduler by making the CONFIG_SMP=y version of
idle_thread_set_boot_cpu() unconditional.

Note that idle_thread_set_boot_cpu() is already conditional
on CONFIG_GENERIC_SMP_IDLE_THREAD, which most architectures
select unconditionally on both UP and SMP kernels.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-28-mingo@kernel.org
---
 kernel/sched/core.c | 2 --
 kernel/smpboot.c    | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa89006..a03c3c1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8582,9 +8582,7 @@ void __init sched_init(void)
 
 	calc_load_update = jiffies + LOAD_FREQ;
 
-#ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-#endif
 
 	balance_push_set(smp_processor_id(), false);
 	init_sched_fair_class();
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 1992b62..4503b60 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -18,8 +18,6 @@
 
 #include "smpboot.h"
 
-#ifdef CONFIG_SMP
-
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
 /*
  * For the hotplug case we keep the task structs around and reuse
@@ -76,8 +74,6 @@ void __init idle_threads_init(void)
 }
 #endif
 
-#endif /* #ifdef CONFIG_SMP */
-
 static LIST_HEAD(hotplug_threads);
 static DEFINE_MUTEX(smpboot_threads_lock);
 

