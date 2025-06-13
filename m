Return-Path: <linux-tip-commits+bounces-5811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0FAAD848E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BE71779C3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0852ECEB9;
	Fri, 13 Jun 2025 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwp2Xiuy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGZp6vkG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B92ECE87;
	Fri, 13 Jun 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800256; cv=none; b=IRnUsOoa/tkS93r+fOI9vm/hC7rbdpKgFzP6AFuGwEaMzYYXGqBgqbpm4wCxDURV10i5lDnI/6cIW6Mx5zZBkgwHQJN+lLSEAqWV4sDtswwbX8cbSEYLemZCcQBKWWk2rF1mFMsd82umkliHEDMRbL9Iu+A/8tgJnJ1fL/31fDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800256; c=relaxed/simple;
	bh=00NIIfZ7+keM4UV9r3DcW46o5InN5EA9WABgV6amQn0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qpKQyAArPczqtloPsgdTjlI5fkujNd5BCsMtORfJjatXxrJECkJRzUBfOKfs22D/GKB3cQq18u1T+fcZ15i5YeCJQWPJxUa2xC9T5neAOtiAZUz7xvBx5dtTqRoTE6E5zw7/cgHokgVYaXUZMfYA+vKQnHmWeMr+oUy9eAPsXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jwp2Xiuy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGZp6vkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNjH+GVsWmk7ViGikQ1YzStVw8QAYUsFELZTb0pdKr4=;
	b=jwp2XiuyiKJKhnpMHKXdLkpMr9/ppETJzG7UkUCwK/B8VsM51TqEnOstbwJsWqKqh72Cps
	bwOnVrn/LubIvmpEgkZCdVa/Jq4UEEnb3ylTNai3oIlKAN8vVDczat7XxbTSV0PS+IKkiL
	NyhoJg0NaVZ/3PwGhNLB6Jx2mSYT+tOniWkU4hxCVS1/fpcn+8Xglfnqe8LvKOiJUW+xsN
	c/mKzh/0rJ/9rU1yfvwNcXpUaNcp7V0WmjP8SFuoV1jY2fj6QZrZoDqHjHJp8ZJMJL0V0W
	uHTYp2LpcOsGC5099Uus16MZqaCiMd9vMWAMGENfpXY2iWVzuu7sw2xoccx9vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNjH+GVsWmk7ViGikQ1YzStVw8QAYUsFELZTb0pdKr4=;
	b=QGZp6vkGzKiCe2NZ0fMWiEjkpTBSChf/8EHMvFtncrVCspsNjO7lGOJktFaZn25RG1uVDp
	0StTGCr/N7EUZPDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/pelt.[ch]
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-13-mingo@kernel.org>
References: <20250528080924.2273858-13-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025213.406.826763060822088939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     311bb3f7b78e944e831ffb07cb58455b47bf2269
Gitweb:        https://git.kernel.org/tip/311bb3f7b78e944e831ffb07cb58455b47bf2269
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:17 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/pelt.[ch]

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-13-mingo@kernel.org
---
 kernel/sched/pelt.c |  4 ++--
 kernel/sched/pelt.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 09be6a8..fa83bba 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -414,7 +414,7 @@ int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_SCHED_HW_PRESSURE */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
@@ -467,7 +467,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 
 	return ret;
 }
-#endif
+#endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
 
 /*
  * Load avg and utiliztion metrics need to be updated periodically and before
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1959207..a5d4933 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -20,7 +20,7 @@ static inline u64 hw_load_avg(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_hw.load_avg);
 }
-#else
+#else /* !CONFIG_SCHED_HW_PRESSURE: */
 static inline int
 update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
@@ -31,7 +31,7 @@ static inline u64 hw_load_avg(struct rq *rq)
 {
 	return 0;
 }
-#endif
+#endif /* !CONFIG_SCHED_HW_PRESSURE */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -179,15 +179,15 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 
 	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
 }
-#else
+#else /* !CONFIG_CFS_BANDWIDTH: */
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
 	return rq_clock_pelt(rq_of(cfs_rq));
 }
-#endif
+#endif /* !CONFIG_CFS_BANDWIDTH */
 
-#else
+#else /* !CONFIG_SMP: */
 
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
@@ -236,6 +236,6 @@ static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
-#endif
+#endif /* !CONFIG_SMP */
 
 #endif /* _KERNEL_SCHED_PELT_H */

