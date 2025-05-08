Return-Path: <linux-tip-commits+bounces-5509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E1AB0420
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19AE5271E9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF328B418;
	Thu,  8 May 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mr5JufV5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vh3FqmX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D724B1E6F;
	Thu,  8 May 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734120; cv=none; b=AF3K7lmu4rz5M7AAka/GdharfvbZPOkaK6OealeaN9xAruR2eLEFr9BlVAOFa0aiYi4QmLGSBUjPKe9FzWyS6BD9tg3tqn7yDXQCSZcRaxO0uM4IfhuoC7Ny+nfuIz25R/QE91rvLcAVnyeT/zoGLk0VH8wihH0Vegl/BOC/IEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734120; c=relaxed/simple;
	bh=13iEzxWM4z9JT0NJ+Z6kURwn94j/7kg8rJor7rNdHR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lvbx8GbhgoNK8IUXKEXl7oPA9/5XYg95PlwZiJrvEo+Nl6TCxoUDpA6Hm8oWbUEJB13Fn2yTY2lv1a1FeYrUkcDZyo6K6L0QdvG4YedFHIiUXMbxqWsbMErn4i1rzKt9kkneCpyon5sIKKcttN3nUyNVY4h3R/A+pBxN9Q8+Ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mr5JufV5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7vh3FqmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 19:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746734117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5ae7IWeE5KoZBrMZYVK4cxIgEHfYDQES88MaJUUJrg=;
	b=Mr5JufV5ih1xSCE6FGpEe7lDn5x2Yxm3GfYsFNZKj2k3LT3OLlFoWD98BLhG4Mf487juVJ
	Z7CD+et06KumiLSZM1L/EDiQ5IA5y9Fqcc6MQEcuibuTQHyfTGAOGVzEkz/J+fsO1y02lu
	5my7mtMQAAlOr9/4zhGifU34onXs5C8uMuxDnJsvHTC1D5TkTAzbYJtQKTXwo+aIO6mn45
	Q68Ul37u3r5Dmo5H7vMgRB2riBpBxRRarbeuHiauU2jXSr7SP8t2HaQAgeqgGvGWeJ9WDN
	BWtj3yqKVn/Ecrsn7o170BbHA8qCrJDz+gSXR82RU1Nd+N/d+uOt8d8M2vXUSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746734117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5ae7IWeE5KoZBrMZYVK4cxIgEHfYDQES88MaJUUJrg=;
	b=7vh3FqmXVJ+O4Ho+ojJK3iA5IK3zgWnjUHHFVxb8QV+VfwSoHvxy8qjlfh3yELcn0yhqCp
	dwRHUXEp6VsogrAQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Remove too early and redundant CPU hotplug handling
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250424161128.29176-4-frederic@kernel.org>
References: <20250424161128.29176-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174673411659.406.17891868589817143242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f400565faa50737ac1d550d2c75128c0dad75765
Gitweb:        https://git.kernel.org/tip/f400565faa50737ac1d550d2c75128c0dad75765
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 May 2025 21:50:19 +02:00

perf: Remove too early and redundant CPU hotplug handling

The CPU hotplug handlers are called twice: at prepare and online stage.

Their role is to:

1) Enable/disable a CPU context. This is irrelevant and even buggy at
   the prepare stage because the CPU is still offline. On early
   secondary CPU up, creating an event attached to that CPU might
   silently fail because the CPU context is observed as online but the
   context installation's IPI failure is ignored.

2) Update the scope cpumasks and re-migrate the events accordingly in
   the CPU down case. This is irrelevant at the prepare stage.

3) Remove the events attached to the context of the offlining CPU. It
   even uses an (unnecessary) IPI for it. This is also irrelevant at the
   prepare stage.

Also none of the *_PREPARE and *_STARTING architecture perf related CPU
hotplug callbacks rely on CPUHP_PERF_PREPARE.

CPUHP_AP_PERF_ONLINE is enough and the right place to perform the work.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250424161128.29176-4-frederic@kernel.org
---
 include/linux/cpuhotplug.h | 1 -
 kernel/cpu.c               | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1987400..df366ee 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -60,7 +60,6 @@ enum cpuhp_state {
 	/* PREPARE section invoked on a control CPU */
 	CPUHP_OFFLINE = 0,
 	CPUHP_CREATE_THREADS,
-	CPUHP_PERF_PREPARE,
 	CPUHP_PERF_X86_PREPARE,
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
 	CPUHP_PERF_POWER,
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b08bb34..a59e009 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2069,11 +2069,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= NULL,
 		.cant_stop		= true,
 	},
-	[CPUHP_PERF_PREPARE] = {
-		.name			= "perf:prepare",
-		.startup.single		= perf_event_init_cpu,
-		.teardown.single	= perf_event_exit_cpu,
-	},
 	[CPUHP_RANDOM_PREPARE] = {
 		.name			= "random:prepare",
 		.startup.single		= random_prepare_cpu,

