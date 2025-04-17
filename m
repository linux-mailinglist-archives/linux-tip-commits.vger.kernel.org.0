Return-Path: <linux-tip-commits+bounces-5037-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF3A91D2D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB857AE1FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739F24BBE4;
	Thu, 17 Apr 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvGNn6MK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ur5A0Rx4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB87248863;
	Thu, 17 Apr 2025 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894896; cv=none; b=PffIGy9BuhsQ/ZPtCCgNqEdJQUrWVgWrrV7QMG0tx9nmxJybgWadsCp6Qzm1I/ZJbqiE3C+rGL7r+jkfgEcGPQXqjXmFIzRH/sCyCSmwnHE3ngLxqu511vyTq8PLw0cqOp3YuB4RLKr2+rXXzglYdhbUTv1C25KnjbHaDY7Ojmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894896; c=relaxed/simple;
	bh=1uakOEQoBxX/hlxQngottDN/9Z12Kw/l3rDRG44p8mk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MLIgw54wUHZUWpVDAI26fX1FDlFeXg6ho7kVuswKykckrciOhcKj2Alu2Js0qSlaiOdg3J6H4C7Q6wG2j1WHLdmCI9nk/WRkQWoriCYNYc8jdgHAMpY0/Q1vAIhZxItGge2gVg7dUM4x6crDWLbxj8c5y4gztBKmCZ4sAy0D+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvGNn6MK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ur5A0Rx4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9y4duvw1qhGsidzRYVwFXyAgLwUoJCw+3qK8773YEc=;
	b=VvGNn6MKIeHgHibloWiGTjXFWa/UeHtHaaiU52j5ZWfW6JJMk/ELUxiPBZyw+lMT9TFiWE
	9Vqcjr9NHohfsP2jueOOZg+b9+7tPbIkaNchxvwKj5hE429SL7TVEGY0Dz3g5If/b4pfWO
	EcehxDAuX1dAJOUTFs2roEtuxb89T4aQFkoc3cZOpj8fqbwAWZ5poG8zDVkTcr0IG5UgsM
	JgkMcAHVA+mNJ1MRiCsRc6jTbn5o2NeI4d09d1Mv9VDroYj0E+/UtkINHN4/inEK5GmnLI
	boH7wAuajd/xo/c3y16XcvcZd6aseQfKxO8stsQ5vwmtoKttEb9vstxNtKvbtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9y4duvw1qhGsidzRYVwFXyAgLwUoJCw+3qK8773YEc=;
	b=ur5A0Rx4DZ53xHTGpX1Cz1DMBZv5zpTEB/Q1+f6lrtR5r28v9upBEV1swcm7chqn7FrvZ4
	yPmdZII9DNzXN3BQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix event timekeeping merge
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417080815.GI38216@noisy.programming.kicks-ass.net>
References: <20250417080815.GI38216@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489200.31282.16682025653308067046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b02b41c827de9f4b785f57e82d76d0826cc8398b
Gitweb:        https://git.kernel.org/tip/b02b41c827de9f4b785f57e82d76d0826cc8398b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 11:36:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:15 +02:00

perf/core: Fix event timekeeping merge

Due to an oversight in merging:

  da916e96e2de ("perf: Make perf_pmu_unregister() useable")

on top of:

  a3c3c66670ce ("perf/core: Fix child_total_time_enabled accounting bug at task exit")

the timekeeping fix from this latter patch got undone.

Redo it.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250417080815.GI38216@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 43d87de..07414cb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2500,14 +2500,14 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
-	event->state = min(event->state, state);
-
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 

