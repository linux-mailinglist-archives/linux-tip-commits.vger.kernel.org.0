Return-Path: <linux-tip-commits+bounces-5803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FFCAD8491
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E3189E5D9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863D2EB5D7;
	Fri, 13 Jun 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXCMpAmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nqr9iXWV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82002EAD1F;
	Fri, 13 Jun 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800251; cv=none; b=r7ovcP6eRlhi78ZWHj7fWm1zoryidi1sMWD0s73926GVfdrJrtK7xsKoLivC6J2TQVVJ2K32YZ2+Dv+JnL+FwgftkCuRi2a5WC3/FMs6BL9ORJtR3rtkXijpJZB8yQeCmZO68vND8qXClMX6n+scfNe0Ibp63UNgSqvSLVzul9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800251; c=relaxed/simple;
	bh=VgOEVvwJc1U61G3yDBRy0ONSA1uVlNxoO+87mM3AaDA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CIRNFiKjFU1qe5s7xwm03433kUHIDl3e6Rh7aAGxBbgOR4U95mUWpxHGNH5L+Flf8R31Zc39tiJmKmPSfSfb9tWXsUOv782DFq2WNuj0w+qZw0hch3xbqeasf5PgD/CbXGZLXSAmw/au1NZ632FgQNb8ZguDGkbrnAtgn/zQ1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXCMpAmz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nqr9iXWV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4sOpJ8rT9YXF0Syuk5y5TL1oIU1K9gPjgwGaHSjxsA=;
	b=eXCMpAmzPkN2LX169pTYiY8zElKKKS4XfHa1Hy3kZQ3FwZ9FLaWV4Q/0Gcs52wgC+o8YRp
	GYoWB+xhx/I3Dr6bOhqY/ZQopFPTEKsml/g3Tz+y8UjFEUDW2lrZD9CMFAYHTBP45+hKVN
	yI6N4hvVSafm/ETtRaAhO5NlovfMCZVIv15r1WXf1xj+GYSXy8Dy9XTp0H4a+Mr19T2mUB
	vR8aiZAtii4LTKqOJ3mYCIK3rBQggfJcXFNo1f/cxaawlNVFeUI/njTaRqhqpFzpdcZhMI
	/D+8rURumhXhNjmiNp0nJnv6/w4LgYW3AqXvt3E9kaTAdICe+p3asrxCxdXGVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4sOpJ8rT9YXF0Syuk5y5TL1oIU1K9gPjgwGaHSjxsA=;
	b=Nqr9iXWVZ3pjy5Ixa1nKWqnQnIMtTmUIyFOP3QsKJ4j9TSJTq47PTTWX7O6woQ3MKYK9OC
	BWV0NGqCpa2OpcAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/topology.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-19-mingo@kernel.org>
References: <20250528080924.2273858-19-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024737.406.7063848200836341008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f1c6b957f7f4091d822b93ca2833e83bf728e001
Gitweb:        https://git.kernel.org/tip/f1c6b957f7f4091d822b93ca2833e83bf728e001
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:18 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/topology.c

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
Link: https://lore.kernel.org/r/20250528080924.2273858-19-mingo@kernel.org
---
 kernel/sched/topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9026d32..2352caf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -315,7 +315,7 @@ static int __init sched_energy_aware_sysctl_init(void)
 }
 
 late_initcall(sched_energy_aware_sysctl_init);
-#endif
+#endif /* CONFIG_PROC_SYSCTL */
 
 static void free_pd(struct perf_domain *pd)
 {
@@ -451,9 +451,9 @@ free:
 
 	return false;
 }
-#else
+#else /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL): */
 static void free_pd(struct perf_domain *pd) { }
-#endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
+#endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
 static void free_rootdomain(struct rcu_head *rcu)
 {
@@ -1600,7 +1600,7 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
-#endif
+#endif /* CONFIG_NUMA */
 
 /*
  * SD_flags allowed in topology descriptions.
@@ -1716,7 +1716,7 @@ sd_init(struct sched_domain_topology_level *tl,
 				       SD_WAKE_AFFINE);
 		}
 
-#endif
+#endif /* CONFIG_NUMA */
 	} else {
 		sd->cache_nice_tries = 1;
 	}

