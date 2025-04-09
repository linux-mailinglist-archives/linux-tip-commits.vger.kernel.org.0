Return-Path: <linux-tip-commits+bounces-4817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511DFA8330A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 23:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7754A0EBE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AE2147ED;
	Wed,  9 Apr 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OmtFaNPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mj60UDye"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F912147F7;
	Wed,  9 Apr 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233142; cv=none; b=PMlPBp5v4cEmpHHFbEFlEMhq4E2svv2i74mhQISYcBimbZeePG8HbwjeRJ870eg/+qLochY7gIYfNugAi9JdGPZ7QzIZA9xs69lCTfxy/trf7uzWvuWldoHb5ltDiPoaltG5VAoOSPrWcbNK02Iw9FCeOJolctQE/IXz5LohQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233142; c=relaxed/simple;
	bh=CIcEj47j7D9sJ6Vfzua7+dlSs0YPaM4cccnDm1gu3xo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JJQuIr/fWhpiXpIyRf0lruwNGqyCqsAiH35I4j97bjCPApSjm1pvDc6SHpH1B/m/xJl+Ag6LRH9B+HDPkPDuvJ7cscD+RYZzSaeDrAgpECZ56nNHptT6l5n602IAqTx7q3oD+sgE4wcwWd5uC+PwbbmNk1iTOmcSugoAlNd+PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OmtFaNPb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mj60UDye; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 21:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744233136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZcQYVb/1gtOZBb+Bo9eTmIOgqSQzQz4ZcTZVzAUOCQ=;
	b=OmtFaNPbxklxga3hQ0t72WuCO8hBRRgI8La2oxqqVoPVWLkDHtkrOTdJA/Oda0hPq0QDhx
	2nX9RJo1pc6uChtPjhCGQ5ybbdJzNZyxtR4FUQe+nFRH/C6LQVSL+VxZMZ1nlE+t9sWwA5
	xyiDTN4aa2+jjwDlgQwKtiH1zD3fqVtks5fnHIYcNTw2a/tTKBXcGsVBQbOX/uIEFlaaEQ
	DGBZskVE/wM3aZ2M6j15w6xnOB2nCFkdPHo8xd5oedCCbflXCtqkaEWrDl7VqWHsdstg2h
	XqBisLBFyIYCfFgshE1YHe5JAUc2s8SvLL6/DwzqLsXXZrYcYaqeEIMh4LUtTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744233136;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZcQYVb/1gtOZBb+Bo9eTmIOgqSQzQz4ZcTZVzAUOCQ=;
	b=Mj60UDyeD7qQCUkNFsoUsQpkDieLVQpdsrQloBVIASDr8MIYWagHusNHn0TjqJA+gORP5Z
	6BizbF/gmDWngSCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timekeeping: Add a lockdep override in tick_freeze()
Cc: Borislav Petkov <bp@alien8.de>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250404133429.pnAzf-eF@linutronix.de>
References: <20250404133429.pnAzf-eF@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174423313221.31282.12756480935760918765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     92e250c624ea37fde64bfd624fd2556f0d846f18
Gitweb:        https://git.kernel.org/tip/92e250c624ea37fde64bfd624fd2556f0d846f18
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 04 Apr 2025 15:34:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 22:30:39 +02:00

timekeeping: Add a lockdep override in tick_freeze()

tick_freeze() acquires a raw spinlock (tick_freeze_lock). Later in the
callchain (timekeeping_suspend() -> mc146818_avoid_UIP()) the RTC driver
acquires a spinlock which becomes a sleeping lock on PREEMPT_RT.  Lockdep
complains about this lock nesting.

Add a lockdep override for this special case and a comment explaining
why it is okay.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250404133429.pnAzf-eF@linutronix.de
Closes: https://lore.kernel.org/all/20250330113202.GAZ-krsjAnurOlTcp-@fat_crate.local/
Closes: https://lore.kernel.org/all/CAP-bSRZ0CWyZZsMtx046YV8L28LhY0fson2g4EqcwRAVN1Jk+Q@mail.gmail.com/
---
 kernel/time/tick-common.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a47bcf7..9a38594 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -509,6 +509,7 @@ void tick_resume(void)
 
 #ifdef CONFIG_SUSPEND
 static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
+static DEFINE_WAIT_OVERRIDE_MAP(tick_freeze_map, LD_WAIT_SLEEP);
 static unsigned int tick_freeze_depth;
 
 /**
@@ -528,9 +529,22 @@ void tick_freeze(void)
 	if (tick_freeze_depth == num_online_cpus()) {
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), true);
+		/*
+		 * All other CPUs have their interrupts disabled and are
+		 * suspended to idle. Other tasks have been frozen so there
+		 * is no scheduling happening. This means that there is no
+		 * concurrency in the system at this point. Therefore it is
+		 * okay to acquire a sleeping lock on PREEMPT_RT, such as a
+		 * spinlock, because the lock cannot be held by other CPUs
+		 * or threads and acquiring it cannot block.
+		 *
+		 * Inform lockdep about the situation.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		system_state = SYSTEM_SUSPEND;
 		sched_clock_suspend();
 		timekeeping_suspend();
+		lock_map_release(&tick_freeze_map);
 	} else {
 		tick_suspend_local();
 	}
@@ -552,8 +566,16 @@ void tick_unfreeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	if (tick_freeze_depth == num_online_cpus()) {
+		/*
+		 * Similar to tick_freeze(). On resumption the first CPU may
+		 * acquire uncontended sleeping locks while other CPUs block on
+		 * tick_freeze_lock.
+		 */
+		lock_map_acquire_try(&tick_freeze_map);
 		timekeeping_resume();
 		sched_clock_resume();
+		lock_map_release(&tick_freeze_map);
+
 		system_state = SYSTEM_RUNNING;
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);

