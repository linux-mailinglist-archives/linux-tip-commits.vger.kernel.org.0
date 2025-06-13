Return-Path: <linux-tip-commits+bounces-5792-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA910AD8467
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450AC165672
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC692E7F19;
	Fri, 13 Jun 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="en0zLxj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9w+zZmT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1232E7642;
	Fri, 13 Jun 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800240; cv=none; b=gAtIaRe3CTpu0lSeTbHM+590UTUTQ4h4mtPQrzVj30PZ52RFEztN8OQGsBjGu9IYzhYCOhKeb3ZWNFZxdwJ/oyBaubS4ULxTSCSaisfELyfFoyWwI0fps6F4Wj08hMbLWOoapdMV1gIKO0B8uETHe7/BdF12ZPBkfANPQxpOS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800240; c=relaxed/simple;
	bh=ABwc1kj0xrksNlvBDjXyxDkEoXd4XXUG8vUPBaEVhYs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bf3wgjg9CEJcEaUI4DK3CfZNDzm2cN1qoWUuozM65tlNfaDnPE+Lpa3cTsJkMkvh45prX7naa/RCgmdf+lQ0Z7iTti9o8QQmsgiXdbdoJNhAe+GIz2+GhHyCYxZeYdtNwAfaboyKjTGMLXKX4zOIftKoci2LAmz/dPAOeBK/sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=en0zLxj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9w+zZmT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJRI5XrIwhTtuJo8/GrlGuHaUV7m6DL5YsFUEXYLrU4=;
	b=en0zLxj/2lzzNWX7O67txjU2lYeXighmONP+GbdvTp0CjCoAJVmxLfuIGU3doArNSZnhXe
	0+SK5ZyG0CFBciqsvVQgiInDc3OIOGGwWq4uQPGWAcipDlgoSiQpEh9qiGBI/0Dt5mZp9G
	Fvgfmu8F6MPjyQwmUyKDmgXwpp4g6ifzbvgZfwvLOLY7qDrWU8K6O2V4SLX5HxW01ik1nt
	B7ZemLs1przv81dm/zRixQzo4J6D8CstuXoknYR1bUTag6CkOmWEtMgwiwmdzm9f/rzPZI
	DOvmQwMe3ViGxtp9KGcDinQapSdoYL6C9eimcSFYVbzlG6vuxVAw59Jg/UTQvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800237;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJRI5XrIwhTtuJo8/GrlGuHaUV7m6DL5YsFUEXYLrU4=;
	b=L9w+zZmT20nhiy4q0WD4+YgpMiUm6PRIB4ozbBLS16Sxw+YCuaq5PPkOENfHPTFlVumico
	cXW1QhGy1FluRxDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of schedstats
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-32-mingo@kernel.org>
References: <20250528080924.2273858-32-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023595.406.16508743799112441499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d9af2372f2a46242fd5e827973235f40f31a706
Gitweb:        https://git.kernel.org/tip/9d9af2372f2a46242fd5e827973235f40f31a706
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:21 +02:00

sched/smp: Use the SMP version of schedstats

Simplify the scheduler by making CONFIG_SMP=y schedstats
debugging output unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-32-mingo@kernel.org
---
 kernel/sched/stats.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 86acd37..d1c9429 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -115,10 +115,8 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		seq_printf(seq, "timestamp %lu\n", jiffies);
 	} else {
 		struct rq *rq;
-#ifdef CONFIG_SMP
 		struct sched_domain *sd;
 		int dcount = 0;
-#endif
 		cpu = (unsigned long)(v - 2);
 		rq = cpu_rq(cpu);
 
@@ -133,7 +131,6 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		seq_printf(seq, "\n");
 
-#ifdef CONFIG_SMP
 		/* domain-specific stats */
 		rcu_read_lock();
 		for_each_domain(cpu, sd) {
@@ -164,7 +161,6 @@ static int show_schedstat(struct seq_file *seq, void *v)
 			    sd->ttwu_move_balance);
 		}
 		rcu_read_unlock();
-#endif /* CONFIG_SMP */
 	}
 	return 0;
 }

