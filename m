Return-Path: <linux-tip-commits+bounces-2769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0D9BE4C5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A101F26F34
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC551DFE38;
	Wed,  6 Nov 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="owmsYzb5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5v6sJbMf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9B1DEFD3;
	Wed,  6 Nov 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890131; cv=none; b=kasP6oHJSH4fWnMfFpAj5pZ6/aeMbLzNFP43KbxpZwbilNpC3oMRljidhUXZ9ngZDeBx7neWA33Z7t2lt7tqmbS1o4TydGdodAdoxWGHojShwRWNa/qLJh44mMSuQlJEAJwP4FByf4Id6ZpbYpdKJ3+dNqcv0S0LaYToaE23W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890131; c=relaxed/simple;
	bh=qa+B8nCF4PW86PQLU8Srv1iWAECV4pKUTjIeZB0+kFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F6aNcPPOELgOWgLHOVVrOaTYfPrjT4yZ5wNIq1FY+51ZDuBLzCC3Iuiwnse07F25kZ2zVJhxsrxP8eexhCbLy+GjVLZXDz54u4HyZQ5wDCCmPmslUddcKXtP9fjbboca9EGziQyF+ibM6gAlEgyZV3AkGWTvfZzlfeIAwSjr59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=owmsYzb5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5v6sJbMf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6FPDWXerZOtQO20SBsVbcLBeMHfgC94FliWv8qNHiA=;
	b=owmsYzb5UBfeg40ExsmOc5m9LQBlBLOH+1ZvEn2rN2fMiWwmMa+hB6rvC7RJGY6OHRm27i
	bO8fnYgYAWnIW2buc8MDCzx+t7lFs4bIYkrqz0aBKFVyDc7qbb3vpxDyT14LQvbRE7jPkU
	bLM6LOecNROw/fkJGVflEsDgFi3vHkGCDe9kqDICH+J7fji+ghjmqDm4L7+WAcoBnk1AxW
	hWPempP8l/gopJ/AVyNnTKa7ubw032C95Zlge23HB7vUGkCigWUJKzeywEJkf6vIRZ1ilP
	T6v9m8RP4daBioxFvGlglZSBMIrfQcAfjOjUTRUGfr9gedTD1FN5YteK9sDTZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890127;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6FPDWXerZOtQO20SBsVbcLBeMHfgC94FliWv8qNHiA=;
	b=5v6sJbMfgWtWB6u7f/6nzvRtZawz/fHGdkORIlm/Er2Tn/Iq875FwyujSeEaN/ez79vee3
	RcKBC9LOEWRn8KBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007075055.441622332@infradead.org>
References: <20241007075055.441622332@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012636.32228.10876330075623941280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     35772d627b55cc7fb4f33bae57c564a25b3121a9
Gitweb:        https://git.kernel.org/tip/35772d627b55cc7fb4f33bae57c564a25b3121a9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 04 Oct 2024 14:46:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:38 +01:00

sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT

In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
not a change in how preemption works, but rather it makes a ton more
code preemptible.

Notably, take away NONE and VOLUNTARY options for PREEMPT_RT, they make
no sense (but are techincally possible).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20241007075055.441622332@infradead.org
---
 kernel/Kconfig.preempt | 12 +++++++-----
 kernel/sched/core.c    |  2 ++
 kernel/sched/debug.c   |  4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 09f06d8..7c1b29a 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -20,6 +20,7 @@ choice
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
+	depends on !PREEMPT_RT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -35,6 +36,7 @@ config PREEMPT_NONE
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	depends on !PREEMPT_RT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
@@ -54,7 +56,7 @@ config PREEMPT_VOLUNTARY
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_BUILD
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -74,7 +76,7 @@ config PREEMPT_LAZY
 	bool "Scheduler controlled preemption model"
 	depends on !ARCH_NO_PREEMPT
 	depends on ARCH_HAS_PREEMPT_LAZY
-	select PREEMPT_BUILD
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option provides a scheduler driven preemption model that
 	  is fundamentally similar to full preemption, but is less
@@ -82,6 +84,8 @@ config PREEMPT_LAZY
 	  reduce lock holder preemption and recover some of the performance
 	  gains seen from using Voluntary preemption.
 
+endchoice
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
@@ -99,8 +103,6 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
 
-endchoice
-
 config PREEMPT_COUNT
        bool
 
@@ -110,7 +112,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df6a34d..5c47d70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7450,11 +7450,13 @@ int preempt_dynamic_mode = preempt_dynamic_undefined;
 
 int sched_dynamic_mode(const char *str)
 {
+#ifndef CONFIG_PREEMPT_RT
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
 		return preempt_dynamic_voluntary;
+#endif
 
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 44a49f9..a48b2a7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -248,9 +248,9 @@ static int sched_dynamic_show(struct seq_file *m, void *v)
 		"none", "voluntary", "full", "lazy",
 	};
 	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
-	int i;
+	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
 
-	for (i = 0; i < j; i++) {
+	for (; i < j; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);

