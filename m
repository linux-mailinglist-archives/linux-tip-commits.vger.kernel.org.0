Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B929E9AE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgJ2Kwr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgJ2Kvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:47 -0400
Date:   Thu, 29 Oct 2020 10:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I75GHmUsJUewwUxYjXpsYZvU4vW3pEjD7wcg6kHgA6g=;
        b=J1lXyrFmRvdYGL0OG70/EofQx2Fmvae7/g7HaWKQVt6TulHxcxepUgizVZmw7XEwfGwwz4
        I4nd3qAduwyJzzZumtQNa/yY1aLj3cdiPCVoTNYTdXe/ulhRZzVn0LCO4MR6+XPmUug5Vr
        cL+aT95tfW7eiuA2GdzbULi73pHLTS1vwWnA1oTE+bfnat6qiITXIt6yQgF9BK31u6ERPE
        kGYhyUZbmTt2u+r9GeKLy3K2UhgDaQTLPJFgMCTC2u1mfW9tAL/uWIhQ2/sdxP4oXmEN9S
        qpXAKZTr1JwueTpZSH0JLZD7f7faldcmXSyw4twuI9boejSJ8MjYC5d6603YqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I75GHmUsJUewwUxYjXpsYZvU4vW3pEjD7wcg6kHgA6g=;
        b=t0bnrOk4qBOL6GKtb1uHmTKxVUQcRhP5t50Pcrke/fC2Bd0x23pr4VAfVboQerOuPc7t6r
        H8qKRLM0sUPDTrAQ==
From:   "tip-bot2 for Julia Lawall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Check for idle core in wake_affine
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Message-ID: <160396870425.397.4958439509234228998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d8fcb81f1acf651a0e50eacecca43d0524984f87
Gitweb:        https://git.kernel.org/tip/d8fcb81f1acf651a0e50eacecca43d0524984f87
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Thu, 22 Oct 2020 15:15:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:32 +01:00

sched/fair: Check for idle core in wake_affine

In the case of a thread wakeup, wake_affine determines whether a core
will be chosen for the thread on the socket where the thread ran
previously or on the socket of the waker.  This is done primarily by
comparing the load of the core where th thread ran previously (prev)
and the load of the waker (this).

commit 11f10e5420f6 ("sched/fair: Use load instead of runnable load
in wakeup path") changed the load computation from the runnable load
to the load average, where the latter includes the load of threads
that have already blocked on the core.

When a short-running daemon processes happens to run on prev, this
change raised the situation that prev could appear to have a greater
load than this, even when prev is actually idle.  When prev and this
are on the same socket, the idle prev is detected later, in
select_idle_sibling.  But if that does not hold, prev is completely
ignored, causing the waking thread to move to the socket of the waker.
In the case of N mostly active threads on N cores, this triggers other
migrations and hurts performance.

In contrast, before commit 11f10e5420f6, the load on an idle core
was 0, and in the case of a non-idle waker core, the effect of
wake_affine was to select prev as the target for searching for a core
for the waking thread.

To avoid unnecessary migrations, extend wake_affine_idle to check
whether the core where the thread previously ran is currently idle,
and if so simply return that core as the target.

[1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
load in wakeup path")

This particularly has an impact when using the ondemand power manager,
where kworkers run every 0.004 seconds on all cores, increasing the
likelihood that an idle core will be considered to have a load.

The following numbers were obtained with the benchmarking tool
hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
management were used.  Times are in seconds.  All experiments use all
160 hardware threads.

	v5.9/intel-pstate	v5.9+patch/intel-pstate
bt.C.c	24.725724+-0.962340	23.349608+-1.607214
lu.C.x	29.105952+-4.804203	25.249052+-5.561617
sp.C.x	31.220696+-1.831335	30.227760+-2.429792
ua.C.x	26.606118+-1.767384	25.778367+-1.263850

	v5.9/ondemand		v5.9+patch/ondemand
bt.C.c	25.330360+-1.028316	23.544036+-1.020189
lu.C.x	35.872659+-4.872090	23.719295+-3.883848
sp.C.x	32.141310+-2.289541	29.125363+-0.872300
ua.C.x	29.024597+-1.667049	25.728888+-1.539772

On the smaller data sets (A and B) and on the other NAS benchmarks
there is no impact on performance.

This also has a major impact on the splash2x.volrend benchmark of the
parsec benchmark suite that goes from 1m25 without this patch to 0m45,
in active (intel_pstate) mode.

Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f30d35a..52cacfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5813,6 +5813,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
+	if (available_idle_cpu(prev_cpu))
+		return prev_cpu;
+
 	return nr_cpumask_bits;
 }
 
