Return-Path: <linux-tip-commits+bounces-2931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178029E0093
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7DAB2D313
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8820A5C9;
	Mon,  2 Dec 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbJq8lXZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/072CaO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF6209F29;
	Mon,  2 Dec 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138094; cv=none; b=OIAMj34XjLKs1v/uxhU9Z1f3/C6keAk7TbjZ2NnycogkdmYLgC8W0DLnXGlA4W05TM+MAU+ZFxTtuYtqD4kqNNfjQizLvm5Oe+Iy2l71qqXXaAmdxBniig4kHtnCauNztdP1avqEfvcqhIeREa7IPC9B7VTKOMtqYzHsF6+qe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138094; c=relaxed/simple;
	bh=IVCe9+c0wjapHnkt7PorsAjp7ezkOxu/V54VFq7RMAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UKGO3HdSggoaEMfkRX+8bn8QdfTe6rD9N7GWIjIFuhTt38zxPqsIRxyCT6FtNA1K35sE005jB+h77yli/phgx7B5cfxwLrrIZbFVOCl09Tf5vlZ0iycw3tGnRnH/XfOP6YVvwoTAbuCPNgX6syJSBkTR7Z28CZ5xjcYYrapx7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbJq8lXZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/072CaO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbNEbnibqVaq3nPAxHOWD3WTCGDLVeeZqJdN4MrHubY=;
	b=GbJq8lXZKz0C/AUAYJUH5r3DilvqmJQucn2IvHnlUCGCoguVHRHDohFHaplLKAFaRQ1hHC
	vStV1oF3+UgPJblWxymkHxjiOMg9Gaqa/hFEflMVFifZYC2QWzw9cDJu5Ecov7IPGu16AS
	viZm15YOBa7zum5E9o7sQ1wkht14k748tNBHARn8Cwi86dqtrXVG/+2KfaYItoxG0jFNu5
	YNWTqFkL+H1HiYO7NmLZUpJMSTKtTWl0t4PgqScROa4Jm9MGanbX6ZiG/vGiN2hyGlPN12
	pz+iTbYaa4fn7wDT0wXSnDrVD+LzILjL6noY9kfkL3kHVGVo+TqJspTT/LoUXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbNEbnibqVaq3nPAxHOWD3WTCGDLVeeZqJdN4MrHubY=;
	b=o/072CaOWe63pxisz/SEENycVttMsKZi8yEpyfqSWQoFWNm9KG1tZHXpw1jUWrBW3i+5mv
	gXxuvVR/lwC8e8DA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] softirq: Allow raising SCHED_SOFTIRQ from
 SMP-call-function on RT kernel
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119054432.6405-2-kprateek.nayak@amd.com>
References: <20241119054432.6405-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313809048.412.3314545139102206149.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6675ce20046d149e1e1ffe7e9577947dee17aad5
Gitweb:        https://git.kernel.org/tip/6675ce20046d149e1e1ffe7e9577947dee17aad5
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Tue, 19 Nov 2024 05:44:29 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:27 +01:00

softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with preempt disabled,
raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
longer preempt disabled sections.

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") IPIs to an idle CPU in
TIF_POLLING_NRFLAG mode can be optimized out by instead setting
TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
flush_smp_call_function_queue() in the idle-exit path to run the
SMP-call-function.

To trigger an idle load balancing, the scheduler queues
nohz_csd_function() responsible for triggering an idle load balancing on
a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
out and the SMP-call-function is executed from
flush_smp_call_function_queue() in do_idle() which can raise a
SCHED_SOFTIRQ to trigger the balancing.

So far, this went undetected since, the need_resched() check in
nohz_csd_function() would make it bail out of idle load balancing early
as the idle thread does not clear TIF_POLLING_NRFLAG before calling
flush_smp_call_function_queue(). The need_resched() check was added with
the intent to catch a new task wakeup, however, it has recently
discovered to be unnecessary and will be removed in the subsequent
commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
flush_smp_call_function_queue() to trigger an idle load balance on an
idle target in TIF_POLLING_NRFLAG mode.

nohz_csd_function() bails out early if "idle_cpu()" check for the
target CPU, and does not lock the target CPU's rq until the very end,
once it has found tasks to run on the CPU and will not inhibit the
wakeup of, or running of a newly woken up higher priority task. Account
for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised from
flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@amd.com
---
 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8b41bd1..4dae6ac 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -280,17 +280,24 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 }
 
+#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
+
 /*
  * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
+ * call. On RT kernels this is undesired and the only known functionalities
+ * are in the block layer which is disabled on RT, and in the scheduler for
+ * idle load balancing. If soft interrupts get raised which haven't been
+ * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can be
  * investigated.
  */
 void do_softirq_post_smp_call_flush(unsigned int was_pending)
 {
-	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+	unsigned int is_pending = local_softirq_pending();
+
+	if (unlikely(was_pending != is_pending)) {
+		WARN_ON_ONCE(was_pending != (is_pending & ~SCHED_SOFTIRQ_MASK));
 		invoke_softirq();
+	}
 }
 
 #else /* CONFIG_PREEMPT_RT */

