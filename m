Return-Path: <linux-tip-commits+bounces-4743-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C4CA7EBB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8C420DD1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE321B191;
	Mon,  7 Apr 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWVAK8VP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jthDZRUk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDD21C163;
	Mon,  7 Apr 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049979; cv=none; b=nHgELjLIoO8rw3St2x8za3q0a5wYQ4NjmGhRDBZXNTaklSmEmvcqwxoHTmoVpnHkAXAljSy/UdSpfKI8O6d+lHDPJgOfj8v5LXuKhKpWCVHXDQ48aRg17ZcbWOLEFhYSsrr3zjbcv9AG08YFZPoslSqv8Xu1cnHfTg4mVEOYCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049979; c=relaxed/simple;
	bh=P4QGkxZBWdfgIubDtGbSlQSwEHeQGTGmvRTU22gHD34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sca17yIhJDzUUvgmclvsWPkO+8k3+s9/qeVEVVI3bDoTYvLTupTEws8VOAb5xe+M2XVykQanC/ZMRTivCFvryYP0WgRJ6bcswOGPJsTlsLkQ7xirZPzlvhfkzkAxl4AddCu7apG6b+ohTiJyArgZIS6Z4Ci2owzko7Aqbxd+8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWVAK8VP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jthDZRUk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 18:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744049975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACDE35xOEMZIgVKQAFsITHonmOmNx3LLOa1wA+CEq2Y=;
	b=MWVAK8VPzxribMiOrsbClEjX55vrH4fLX9CucSb524+oxamBpIVgHzJlTiUqWUFo+E3tIQ
	XgwIi62UbTmumrN6sxto8ugE1S1C20F65N1XKQKmj4l9Wc9tz4Ci7VKwGY1WofHv4avqU5
	tHkMrFDdkTLKqbQ71/fK36Lyq5NshjjjkHxTSydDGh18PH3dmb5c5ANyGVmlLbzGh8ymXw
	/eLMHBgUcGFRYTNeVJQQOif2Yni9yPg5UIiXqgjuXnzPnjygJQeLFjw1kr+jlpn2td7GAF
	425Lx8o7k/BcrnwRRFGOWL6RXtCuP48cPgW9BhclSogxp5lVCHOlw7GPj775zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744049975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACDE35xOEMZIgVKQAFsITHonmOmNx3LLOa1wA+CEq2Y=;
	b=jthDZRUkvSVC23Kb2qXTYSQod1gqnDY2l23iwVOEQC9UO2jboFfnck4mo/9jnIuNoerDfN
	+N39bPZfVL2mZHDA==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Avoid false-positive lockdep splat on
 CONFIG_PREEMPT_RT=y in the ri_timer() uprobe timer callback, use
 raw_write_seqcount_*()
Cc: Alexei Starovoitov <ast@kernel.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, stable@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250404194848.2109539-1-andrii@kernel.org>
References: <20250404194848.2109539-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174404997127.31282.955160325706545600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0cd575cab10e114e95921321f069a08d45bc412e
Gitweb:        https://git.kernel.org/tip/0cd575cab10e114e95921321f069a08d45bc412e
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Fri, 04 Apr 2025 12:48:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Apr 2025 20:15:16 +02:00

uprobes: Avoid false-positive lockdep splat on CONFIG_PREEMPT_RT=y in the ri_timer() uprobe timer callback, use raw_write_seqcount_*()

Avoid a false-positive lockdep warning in the CONFIG_PREEMPT_RT=y
configuration when using write_seqcount_begin() in the uprobe timer
callback by using raw_write_* APIs.

Uprobe's use of timer callback is guaranteed to not race with itself
for a given uprobe_task, and as such seqcount's insistence on having
preemption disabled on the writer side is irrelevant. So switch to
raw_ variants of seqcount API instead of disabling preemption unnecessarily.

Also, point out in the comments more explicitly why we use seqcount
despite our reader side being rather simple and never retrying. We favor
well-maintained kernel primitive in favor of open-coding our own memory
barriers.

Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20250404194848.2109539-1-andrii@kernel.org
---
 kernel/events/uprobes.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 615b4e6..8d783b5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1956,6 +1956,9 @@ static void free_ret_instance(struct uprobe_task *utask,
 	 * to-be-reused return instances for future uretprobes. If ri_timer()
 	 * happens to be running right now, though, we fallback to safety and
 	 * just perform RCU-delated freeing of ri.
+	 * Admittedly, this is a rather simple use of seqcount, but it nicely
+	 * abstracts away all the necessary memory barriers, so we use
+	 * a well-supported kernel primitive here.
 	 */
 	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
 		/* immediate reuse of ri without RCU GP is OK */
@@ -2016,12 +2019,20 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
 
-	write_seqcount_begin(&utask->ri_seqcount);
+	/*
+	 * See free_ret_instance() for notes on seqcount use.
+	 * We also employ raw API variants to avoid lockdep false-positive
+	 * warning complaining about enabled preemption. The timer can only be
+	 * invoked once for a uprobe_task. Therefore there can only be one
+	 * writer. The reader does not require an even sequence count to make
+	 * progress, so it is OK to remain preemptible on PREEMPT_RT.
+	 */
+	raw_write_seqcount_begin(&utask->ri_seqcount);
 
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
-	write_seqcount_end(&utask->ri_seqcount);
+	raw_write_seqcount_end(&utask->ri_seqcount);
 }
 
 static struct uprobe_task *alloc_utask(void)

