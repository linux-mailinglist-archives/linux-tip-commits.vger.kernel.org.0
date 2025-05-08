Return-Path: <linux-tip-commits+bounces-5487-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2DAAF81C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5471C20F5F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6342222BE;
	Thu,  8 May 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cxMe0CYi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sV9l7M9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D4221FB7;
	Thu,  8 May 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700472; cv=none; b=WtXZ1Hd0DezAsaSxq3fB3rcGzatWMQrmY9GLWab4YsDxVUHkl556X/ywl4ZFW8oFqslFoFhIO4Rp3XZKVlcvzrv1Er5TwyQQJUdWSsZAym+7PhiJvW+dVq/5V2GYA899+AHreDUSyTet3e4j4XdLtJ4zyHrx+r3WFIOnWr5vbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700472; c=relaxed/simple;
	bh=f3sMbTwSXJ1iMUky/pzS2bRip+Z2tKZqocPe3Y5yvDg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gPPM/bRyfSkCW4DIqpdQyyV6HFeeYhaDmEeAUjs+Z51j24XG7uCxEjlAYvF+Lphiyqy6Piu8YgO2tyFWOWf96coegjw8QdhUGlmYs8d+tHGwd47nB/dcbiITA1DOVUtPxu8Kgnst8y4pOljXpgcAnEp+2ZtkPBwV4YfluYUbLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cxMe0CYi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sV9l7M9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:34:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pjwuWKz4D4H8tVb/poxc8rwU6B8H9b9+ACA/FKvUQI=;
	b=cxMe0CYiIEIH3VMcJqkcpsB5LA1lxw3O7IqZMfBf4ESzvR1Tyg7ouoLO5G6QFDfmmcCKz3
	xasWtrsnQjc6qn2w+kI5OIBil9+aOMud692ru1qY1k6Sp0NPDClB3SYy5yCzPumOALLod6
	I+KvSzOB5cZh0EpKSPaJBOWOSU/IhDeMluGNEAM115t6Ip1ckP8RXD/1LGusvnCwNKA1x4
	47MDwbKdVy2a8a9UJ4GrOjs6ljcpxGUfTbvuognlsFMZxADJgG5u295AU002INigyQtgna
	P7FTqLfjummEnsvl56Tqe/hUGXO0U1v4efVa7prpZ4ly6tITGoXbvjPXQFJpug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pjwuWKz4D4H8tVb/poxc8rwU6B8H9b9+ACA/FKvUQI=;
	b=sV9l7M9wnJcCh9dAAmw/VrApIDGwic0/sz/9bGffR9lfSale+viqyg1t5uV/iNcuEaM5Dj
	nnLXhx3wLKfNQBBA==
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
Message-ID: <174670046846.406.16724744697892248650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9d4ea6fdba71e56c7cf0231a0b0c44723f64c3e7
Gitweb:        https://git.kernel.org/tip/9d4ea6fdba71e56c7cf0231a0b0c44723f64c3e7
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 24 Apr 2025 18:11:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 May 2025 12:40:41 +02:00

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

