Return-Path: <linux-tip-commits+bounces-5760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4785AD4FC1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896AC175A3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8225F960;
	Wed, 11 Jun 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7kX1Xz/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UcE2QNB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA30262FD5;
	Wed, 11 Jun 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634180; cv=none; b=R0kmz6SqYtKV9wTsOu7eLC+dLBrEmZydNLOSC7C7hjPzdXz2znQfmSa2N1AyV+m3y2m+dwrGN7yT1ntymKQSGe1YrU/tJ0PaLg9QaraW+5gv2QO6grDg/bf2l7KYr0fq2FpY6MWf9H96HBxZ9f2/vwcTnq68FMWhShmD/v2/vcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634180; c=relaxed/simple;
	bh=ApP2xVT1JDMhyFDVbwKlugsvaAOTO5ZFwEMrvwDEe4I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EoSzv8htdEL4jsGcmjIis0KQU+QIs5epI/YJeWCxSJgeQ/QBCCYZI9GIeJd6E5Ks7AiTJzg+t7AhPE8+4Q74yponXG7Fj4IXh7iN1yV6NgTCq906fRtAkLjvd9MXugWUhGn675IDmZ84pB6L+SBUXtbUpYdvp0MkvBf8Ih3ejGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7kX1Xz/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UcE2QNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAEPbkdSZWXru0frI7PbKRk+RoOpPTEwTBjv9Z4n4pQ=;
	b=V7kX1Xz/1HZQszzeRgh90RozUQUre8GBYcypLTs4E8Nb4u0Vrkg68gDhVGqMDgotHGzIuz
	aW/4nW5LrZEl5Bzbi1xdhf3rdeqxIoSy8mSe6yuj56XJVggkLaqf/EtrfQCyHohp/wcvMH
	VD4GFQW5qao7y0bZnhOKlQmWrWxptSqW/7xwy4pymKCRr7/yNK66yqY5twaafprd33NN+E
	ZCxOPj5sRn0twpCRXoP0l/GMjvj2Kxab/auD9RnmvQCWHwE8wOxPXgRZcyK1D5B+BKq5Nu
	odydViiOGlsAmoC+kpUinygrKJJ74fRcc+cidEG5MF2lrwfI0MvZiqw7moO6Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAEPbkdSZWXru0frI7PbKRk+RoOpPTEwTBjv9Z4n4pQ=;
	b=2UcE2QNBmPvpt8q/X83rxJq3+ETCQTeGZmDecCbMWhAyYILbcCcAka/NIqlbEHk3i6Ebdi
	czcn8LZfqIxrC1AA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix sample vs do_exit()
Cc: Baisheng Gao <baisheng.gao@unisoc.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250605110815.GQ39944@noisy.programming.kicks-ass.net>
References: <20250605110815.GQ39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963417460.406.17594659379657563345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4f6fc782128355931527cefe3eb45338abd8ab39
Gitweb:        https://git.kernel.org/tip/4f6fc782128355931527cefe3eb45338abd8ab39
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Jun 2025 12:31:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:51 +02:00

perf: Fix sample vs do_exit()

Baisheng Gao reported an ARM64 crash, which Mark decoded as being a
synchronous external abort -- most likely due to trying to access
MMIO in bad ways.

The crash further shows perf trying to do a user stack sample while in
exit_mmap()'s tlb_finish_mmu() -- i.e. while tearing down the address
space it is trying to access.

It turns out that we stop perf after we tear down the userspace mm; a
receipie for disaster, since perf likes to access userspace for
various reasons.

Flip this order by moving up where we stop perf in do_exit().

Additionally, harden PERF_SAMPLE_CALLCHAIN and PERF_SAMPLE_STACK_USER
to abort when the current task does not have an mm (exit_mm() makes
sure to set current->mm = NULL; before commencing with the actual
teardown). Such that CPU wide events don't trip on this same problem.

Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
Reported-by: Baisheng Gao <baisheng.gao@unisoc.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250605110815.GQ39944@noisy.programming.kicks-ass.net
---
 kernel/events/core.c |  7 +++++++
 kernel/exit.c        | 17 +++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f34c99f..26dec1d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7439,6 +7439,10 @@ perf_sample_ustack_size(u16 stack_size, u16 header_size,
 	if (!regs)
 		return 0;
 
+	/* No mm, no stack, no dump. */
+	if (!current->mm)
+		return 0;
+
 	/*
 	 * Check if we fit in with the requested stack size into the:
 	 * - TASK_SIZE
@@ -8150,6 +8154,9 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	if (!current->mm)
+		user = false;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 3864503..1883150 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -944,6 +944,15 @@ void __noreturn do_exit(long code)
 	taskstats_exit(tsk, group_dead);
 	trace_sched_process_exit(tsk, group_dead);
 
+	/*
+	 * Since sampling can touch ->mm, make sure to stop everything before we
+	 * tear it down.
+	 *
+	 * Also flushes inherited counters to the parent - before the parent
+	 * gets woken up by child-exit notifications.
+	 */
+	perf_event_exit_task(tsk);
+
 	exit_mm();
 
 	if (group_dead)
@@ -959,14 +968,6 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
-	/*
-	 * Flush inherited counters to the parent - before the parent
-	 * gets woken up by child-exit notifications.
-	 *
-	 * because of cgroup mode, must be called before cgroup_exit()
-	 */
-	perf_event_exit_task(tsk);
-
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 

