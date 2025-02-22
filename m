Return-Path: <linux-tip-commits+bounces-3603-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F87A40879
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 13:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B6B3B2710
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDC20B21B;
	Sat, 22 Feb 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVR/IZd2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KiEZZDKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9820B1F3;
	Sat, 22 Feb 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228832; cv=none; b=G+KEwSnnl2CrLRKuONYaPhNKyffD98tQ3qTlsKb1CSo519btoa+ZW+0eA7rXfEjs7YrTLp/C43GdJTmzRdHjN7SvBtt9JVM/Dhyf2RR8ZimFSmVRMUQX2hcX08gMf9w/cCS3DHxWI+YVLN6vNZJTxw50jnl07gWwvEeVNIyz8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228832; c=relaxed/simple;
	bh=L1knR7GIQWVoG2PfV1JvkIg4O0LBpw2QsRKIWO/o/P8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MumYuuuN8WlFraGZC0WBIUdyx+UXAay7URqigsrJDOhpDrzxpexa2tGd9wIW/8PeZekU9RoDsZP5z3wL+OVCiFniELjXbmz7WTFfC7JOVhhAxEi0ftX+0VC17qXFY6ZEcQgyY3qK5TmouXTlwKiNJBv7FtReaD57gZSKG9IDUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVR/IZd2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KiEZZDKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 12:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740228829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg4MSwr1dT0WuWhj7qydt+5DTPpVq3l1eqBmhgLtmoU=;
	b=nVR/IZd2NUhLjve1UOtFrDFeS1TyVT1XTr2SZD0uDhTCNWkohmYDDVoAK0JpK2qw6FJoir
	eylisTuOtcDJgFf2zxWBEWFRqrtbn3I7/JL2C5CLdc+w/r1I3sVKYSkiZxTcFve3YGi/nx
	GyFUztrC/ywHCP9O1XOOwY5OV2WD6Husm8HRpK1S1ctU7LUhr4yz0TX4zqZHXrzblJUReJ
	qBEsth9hGVwnl3MEdfGMkJSe0dBZqBv34i/75duHf+DcZ3bc9oOKk4FqGPcAN7jZ/RhdvC
	Y1QuoMiUVbJJsw4xhLzRIh7H/0OvrUNG6DqTyUSbQO9B5x9NrkEtSDkb+VWryg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740228829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg4MSwr1dT0WuWhj7qydt+5DTPpVq3l1eqBmhgLtmoU=;
	b=KiEZZDKzFyWE1TVBNujHZR5zYPShcszWc4NZFsuJFZIuHTVM/KQHc3TwdxJB4AC4o5uuCS
	n6EBD1cFJcywneBg==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/bts: Allocate bts_ctx only if necessary
Cc: Li RongQing <lirongqing@baidu.com>, Ingo Molnar <mingo@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250122074103.3091-1-lirongqing@baidu.com>
References: <20250122074103.3091-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022882578.10177.16512176167468920583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3acfcefa795c6cfb08c68467060bd7aa30557077
Gitweb:        https://git.kernel.org/tip/3acfcefa795c6cfb08c68467060bd7aa30557077
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Wed, 22 Jan 2025 15:41:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 13:43:35 +01:00

perf/x86/intel/bts: Allocate bts_ctx only if necessary

Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
this can save 12K memory for each CPU

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250122074103.3091-1-lirongqing@baidu.com
---
 arch/x86/events/intel/bts.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8f78b0c..8e09319 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -36,7 +36,7 @@ enum {
 	BTS_STATE_ACTIVE,
 };
 
-static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
+static struct bts_ctx __percpu *bts_ctx;
 
 #define BTS_RECORD_SIZE		24
 #define BTS_SAFETY_MARGIN	4080
@@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
 
 static void __bts_event_start(struct perf_event *event)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf = perf_get_aux(&bts->handle);
 	u64 config = 0;
 
@@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
 static void bts_event_start(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf;
 
 	buf = perf_aux_output_begin(&bts->handle, event);
@@ -290,7 +290,7 @@ fail_stop:
 
 static void __bts_event_stop(struct perf_event *event, int state)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 
 	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
 	WRITE_ONCE(bts->state, state);
@@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
 static void bts_event_stop(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct bts_buffer *buf = NULL;
 	int state = READ_ONCE(bts->state);
 
@@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
 
 void intel_bts_enable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	int state = READ_ONCE(bts->state);
 
 	/*
@@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
 
 void intel_bts_disable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 
 	/*
 	 * Here we transition from ACTIVE to INACTIVE;
@@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 int intel_bts_interrupt(void)
 {
 	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct perf_event *event = bts->handle.event;
 	struct bts_buffer *buf;
 	s64 old_head;
@@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
 
 static int bts_event_add(struct perf_event *event, int mode)
 {
-	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
+	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -605,6 +605,10 @@ static __init int bts_init(void)
 		return -ENODEV;
 	}
 
+	bts_ctx = alloc_percpu(struct bts_ctx);
+	if (!bts_ctx)
+		return -ENOMEM;
+
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
 				  PERF_PMU_CAP_EXCLUSIVE;
 	bts_pmu.task_ctx_nr	= perf_sw_context;

