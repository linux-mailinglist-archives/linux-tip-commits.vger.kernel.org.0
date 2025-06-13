Return-Path: <linux-tip-commits+bounces-5818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17CAD84AE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799257B0954
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D8272803;
	Fri, 13 Jun 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENuFzEHR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbRQB2Km"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A212F2C6F;
	Fri, 13 Jun 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800264; cv=none; b=k7yBMueX1fa10I3X3YjSj7NbPRlH5KK0hVh9mkxCqDnUyrRCp8CzqhNyPtzS1YLryFturiUTbrUBEV4zECreg+NnhxZjJUAzU/7w4gKoD+4NPJzTZz0rhXHV3y6Wdma0VFc+us94hjg/lkBzqRyCrU1ADnOtQoSIOt68GNgkPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800264; c=relaxed/simple;
	bh=Q73yOLQlVIS6OiC/W8GPANJukbKUs96du6dF4LBRFn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xy95BOBVHPdXEogMqCCJdAmnjT8NADRw3N5XSVfrWUobxi/CJVnrLZVPVT34p8iLbCfiQecNMxLpmDABopQf1dsy36ygNExHCAb9oUgX7sIvb2oUCRLHoCVdiVL0vFBCVLFCrLsicfyM5bjIkEeLOv8NhnWvuli15/UfOSyfYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENuFzEHR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbRQB2Km; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0d0WdsswS/ZAhTi5m15Z62fN2YBiMGYIsIv+bvMkD6I=;
	b=ENuFzEHRek9AFHqiWaqzsnWQG3kvglUfUMnGs9Fdjpftiu9MuHYWA5cC+8AFl9Dqpu8unp
	vluHcOL5bWkZAEpDlcxsJV5Kt0DyIcVZEE+5ElnMWWvJqaG0ZaU4hTV2mWDdsjlPba3flX
	QIKdR6RgKCIGyP9hhhxiZZlnRGk4X9kGIMtXJakKFgG8uLkab0LfaY8dBajzmTPBJYWjPR
	7nCpOOIi9SF0QjA/R3Axz1lIBO/+6UOCy7O6xM28ExVTNjEEy539Z1+mC0AdCg4boo0jRW
	QMzbIXc1Ud0lRkdSH9jxzxbe2fKAYro9PPkUEF6k9cvcxlH4/0DNZ3RdU9dgAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0d0WdsswS/ZAhTi5m15Z62fN2YBiMGYIsIv+bvMkD6I=;
	b=BbRQB2KmQUy6Hgr8fuPPTye2XAJcnz7nfS7KOMxnOBljK3TjboqBtKgWxUbDt2w6ztqsCF
	z2KleH3xWiev6xCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/cputime.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-7-mingo@kernel.org>
References: <20250528080924.2273858-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025724.406.16811415050982520847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4aec8669ff3c7ea7ab62c10bb6442c70c0d1b1eb
Gitweb:        https://git.kernel.org/tip/4aec8669ff3c7ea7ab62c10bb6442c70c0d1b1eb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:15 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/cputime.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

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
Link: https://lore.kernel.org/r/20250528080924.2273858-7-mingo@kernel.org
---
 kernel/sched/cputime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index f01f17a..7097de2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -91,7 +91,7 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 	return delta;
 }
 
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
+#else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 
 static u64 irqtime_tick_accounted(u64 dummy)
 {
@@ -244,7 +244,7 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
 
 	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
 }
-#endif
+#endif /* CONFIG_SCHED_CORE */
 
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
@@ -265,7 +265,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
 
 		return steal;
 	}
-#endif
+#endif /* CONFIG_PARAVIRT */
 	return 0;
 }
 
@@ -291,7 +291,7 @@ static inline u64 read_sum_exec_runtime(struct task_struct *t)
 {
 	return t->se.sum_exec_runtime;
 }
-#else
+#else /* !CONFIG_64BIT: */
 static u64 read_sum_exec_runtime(struct task_struct *t)
 {
 	u64 ns;
@@ -304,7 +304,7 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 
 	return ns;
 }
-#endif
+#endif /* !CONFIG_64BIT */
 
 /*
  * Accumulate raw cputime values of dead tasks (sig->[us]time) and live
@@ -414,11 +414,11 @@ static void irqtime_account_idle_ticks(int ticks)
 {
 	irqtime_account_process_tick(current, 0, ticks);
 }
-#else /* CONFIG_IRQ_TIME_ACCOUNTING */
+#else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 static inline void irqtime_account_idle_ticks(int ticks) { }
 static inline void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 						int nr_ticks) { }
-#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
+#endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
 /*
  * Use precise platform statistics if available:

