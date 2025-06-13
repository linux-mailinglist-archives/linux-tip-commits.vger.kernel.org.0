Return-Path: <linux-tip-commits+bounces-5808-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29DAD849C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BBE189A978
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14B2ECE8A;
	Fri, 13 Jun 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aiqXfTAY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtds2qsP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C22EA482;
	Fri, 13 Jun 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800254; cv=none; b=EV63h3AcACT+HWkptiThLuwQpMuc1+xhy4DeZf3hNHBIUbbg87aJuWIegz+vi/8XS67ZAaTW4ajj7Dl/q+yD95M9MxXjTKACsnnIQycfiVm09sNm3IwSFR4RYPuYXFTOo9aD5n5F53MjHtGxGfY/sBbWyzX/mfGUJGY2Cg7sGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800254; c=relaxed/simple;
	bh=+yID+p2AmDaDG8/h14jt5Vi/qY0o9o70/l24msCtmtE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YRtN7Qvi9Y1C/CB/cQcWi6lkjNxsqz5CYxnPS9DZAGZshzrLfQUdEOtnOz4wkRyVkfmupFCbrTe4A+cSSRTqW06ld8YuX1Z+jW1NCnmPQntFNQhcyvCVQvLTXk3caN0pPj+/zd4OqkGXNdbyFky3v1Bl283D6hEd5H5xwFbduNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aiqXfTAY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtds2qsP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtkWWAYnIBV4pe2GL8tdKpC2HiVZZuC/aN7dshWP8GA=;
	b=aiqXfTAYiMQXz/LdbqxOv7rT09ra8JCPM+Z9zqu39/UpA8X+9PVMV4HSdkkzA4JY7Ctv6k
	QHIDfEJBA5o53mXmasXKrxJ/vq8wQ3L4xV1My/bLtkQhtBI/QvraBlNqzvkJLgsQ/JIe9Y
	IdzeTNHxpaCAkYS3UD3C0qRjWGsbJxtErR7hBqZbNlPeD8rbZvkPdyFhE4AKr7JpNk2SIk
	sN8uGBDE8QQYOvYR6fo/X3dxrtsoA9DbutlDnzW95m8nqOHxqhlGNOSGO886OH2+ZSpl/E
	w/7sV/HgqsoS9RDW6QWMc4w9VbWGSM9Be2TPyLeDrNU3vTAlJkoWvx4/ANvOpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtkWWAYnIBV4pe2GL8tdKpC2HiVZZuC/aN7dshWP8GA=;
	b=rtds2qsP2qhbL+43dbQjbcSSclfIUIcOYwPi6Hb28onEDDqgpbKO82xgCYN9cXPGjHfWVl
	wszTTVRQ6TWCbqDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/stats.[ch]
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-17-mingo@kernel.org>
References: <20250528080924.2273858-17-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024894.406.8029323946106579128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     91433cd6e46828044a64520dd1dce817be41940e
Gitweb:        https://git.kernel.org/tip/91433cd6e46828044a64520dd1dce817be41940e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:17 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/stats.[ch]

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
Link: https://lore.kernel.org/r/20250528080924.2273858-17-mingo@kernel.org
---
 kernel/sched/stats.c |  2 +-
 kernel/sched/stats.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 1faea87..86acd37 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -164,7 +164,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 			    sd->ttwu_move_balance);
 		}
 		rcu_read_unlock();
-#endif
+#endif /* CONFIG_SMP */
 	}
 	return 0;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 452826d..26f3fd4 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -112,10 +112,10 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
-#else
+#else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
 				       struct task_struct *prev) {}
-#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
+#endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
@@ -220,7 +220,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	psi_task_switch(prev, next, sleep);
 }
 
-#else /* CONFIG_PSI */
+#else /* !CONFIG_PSI: */
 static inline void psi_enqueue(struct task_struct *p, bool migrate) {}
 static inline void psi_dequeue(struct task_struct *p, bool migrate) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
@@ -229,7 +229,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 				    bool sleep) {}
 static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
 				       struct task_struct *prev) {}
-#endif /* CONFIG_PSI */
+#endif /* !CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
 /*
@@ -334,6 +334,6 @@ sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *n
 # define sched_info_enqueue(rq, t)	do { } while (0)
 # define sched_info_dequeue(rq, t)	do { } while (0)
 # define sched_info_switch(rq, t, next)	do { } while (0)
-#endif /* CONFIG_SCHED_INFO */
+#endif /* !CONFIG_SCHED_INFO */
 
 #endif /* _KERNEL_STATS_H */

