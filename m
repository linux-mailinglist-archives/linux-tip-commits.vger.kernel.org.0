Return-Path: <linux-tip-commits+bounces-4038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A286A55925
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 22:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B0A3A3C30
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3927603F;
	Thu,  6 Mar 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfJDu03/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Au7ecFd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1282702B8;
	Thu,  6 Mar 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298046; cv=none; b=EaaRu94sEF1VNzEHZgAv/gYS8verTZSMXTbgggmjpCWnwgoYpJ1yThJUxtGFsyrMIru9+Gi6iBRt1bJFL8cij7Bn/NCy72P6FwNTAheoXHKMXvycTGdeik04NwfydRf03QHQHAwFJRu2tNtC/EFyfuHULrooEayo2VeVAUyQe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298046; c=relaxed/simple;
	bh=0MxTVhkkqUJm8NYR6Rhvn3k8STzYB9/KQ8s+JjzPUL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZKy4r76xF1gj7L66xhGYLrAc7mjdO6K4BjtntIn6AG2DRv2I1Ej1ZhmfD3V+Fr4M6GMtrRs9UgPU0Z+rXUqACI9AZMcVTqRZdd0CZL0NsfNj6yvv0hdAqwKdfE3S/KO5GWCu27QXWWAaREG6YfwSl7wWT6siTpO0wkyOCtRyGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfJDu03/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Au7ecFd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 21:54:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741298042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsV/qOj1S2gyLzpiAdU+wKdYkU8ijPMIXpcYVkegI3o=;
	b=JfJDu03/OQxbdbNyoRL+qz0Rk6XqHoxzn9s2IWbdHqO3seQh8ms/EJq24M8T/nAEHyiYsL
	nF9VJ78OpBvVQKRloahEzCRGcwk9ABGY3Gr7a2TYQnZtjm0/EBPa+yrXtVlSGycP4iptqX
	mf3/wPz7yFk48na3Wgw7N8FvnNeva/kzwkVS1tpUu87Mu1Vv7LQtvFZ4cZKJJtcoAATOfY
	iizucM5dFMbFL1vllYzXfwm96IgbWWVeJamYwOJEdM/f8XgSW7OxxsS87A5KiHRRlNTPbX
	p2tymo1Yg7LO9DFbqSzRsPWN+71W756gNTJ8IX1Qj654n4NgVfHA+o83LbZWqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741298042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsV/qOj1S2gyLzpiAdU+wKdYkU8ijPMIXpcYVkegI3o=;
	b=1Au7ecFdWnpoTdWCo69KVnRQd7SKkz/4yeeC25kibiQBw2ycT1R0ltiGlEa6zO/Al5aIkv
	3SzLa4pagSU6NoBA==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/bts: Check if bts_ctx is allocated
 when calling BTS functions
Cc: Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Li RongQing <lirongqing@baidu.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306051102.2642-1-lirongqing@baidu.com>
References: <20250306051102.2642-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174129804137.14745.8636756193763878398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7a310c644cf571fbdb1d447a1dc39cf048634589
Gitweb:        https://git.kernel.org/tip/7a310c644cf571fbdb1d447a1dc39cf048634589
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Thu, 06 Mar 2025 13:11:02 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 22:42:26 +01:00

perf/x86/intel/bts: Check if bts_ctx is allocated when calling BTS functions

bts_ctx might not be allocated, for example if the CPU has X86_FEATURE_PTI,
but intel_bts_disable/enable_local() and intel_bts_interrupt() are called
unconditionally from intel_pmu_handle_irq() and crash on bts_ctx.

So check if bts_ctx is allocated when calling BTS functions.

Fixes: 3acfcefa795c ("perf/x86/intel/bts: Allocate bts_ctx only if necessary")
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250306051102.2642-1-lirongqing@baidu.com
---
 arch/x86/events/intel/bts.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 953868d..39a987d 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -338,9 +338,14 @@ static void bts_event_stop(struct perf_event *event, int flags)
 
 void intel_bts_enable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	int state = READ_ONCE(bts->state);
+	struct bts_ctx *bts;
+	int state;
 
+	if (!bts_ctx)
+		return;
+
+	bts = this_cpu_ptr(bts_ctx);
+	state = READ_ONCE(bts->state);
 	/*
 	 * Here we transition from INACTIVE to ACTIVE;
 	 * if we instead are STOPPED from the interrupt handler,
@@ -358,7 +363,12 @@ void intel_bts_enable_local(void)
 
 void intel_bts_disable_local(void)
 {
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
+	struct bts_ctx *bts;
+
+	if (!bts_ctx)
+		return;
+
+	bts = this_cpu_ptr(bts_ctx);
 
 	/*
 	 * Here we transition from ACTIVE to INACTIVE;
@@ -450,12 +460,17 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 int intel_bts_interrupt(void)
 {
 	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
-	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	struct perf_event *event = bts->handle.event;
+	struct bts_ctx *bts;
+	struct perf_event *event;
 	struct bts_buffer *buf;
 	s64 old_head;
 	int err = -ENOSPC, handled = 0;
 
+	if (!bts_ctx)
+		return 0;
+
+	bts = this_cpu_ptr(bts_ctx);
+	event = bts->handle.event;
 	/*
 	 * The only surefire way of knowing if this NMI is ours is by checking
 	 * the write ptr against the PMI threshold.

