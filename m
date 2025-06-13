Return-Path: <linux-tip-commits+bounces-5804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C78AD847F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552FF7A4C93
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7862EBDC1;
	Fri, 13 Jun 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+iBV5GR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xi6yA28L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA32EB5AD;
	Fri, 13 Jun 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800251; cv=none; b=AyiETuUtuovDSY6oe7ke3HGwUJ3KAhewy4UIWloIM88UP1GBWuWS0RAnd60z83f0N7EnPeI1/e5vma4tOE5cXxoeCmbSfi+Lnnt0wNyFxjOVR6zBNt0RisnaYU8vsZviXpk5wuKRdealweH9at4VxbAJX0KpIJSFQAdHZCiUXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800251; c=relaxed/simple;
	bh=ASDhmL+2gpTv9DC1QKCvvwmNKIxHiaZYxA3fUlf/XxU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nqD5hkrNNDm07VtDlua1+ijGs/enFeOUSECCzY7SklLvFP/iX3cQeXf0UeESo334Ic1x4awHN1uO2Jt6BuNWW4wy9TfGSDTThZuU2pDiCUZqMxvMn8f6gmCdhxsgnSpq33xn8XmCXJc94gzK33ROLQYKwBQlKu9IzAZKAUb8NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+iBV5GR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xi6yA28L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioLiiK2rZ2UOEu6djBL2d3YM++31ZOhub6bJKMpv7YM=;
	b=k+iBV5GR9IzniVM0/RB2sbEW3LxWwYHVJPKJ00ZEZaKxHhs0qc/aCj9Eg59I88fAWgRFDd
	owjHgl9xyAitHd1VT5vdyg1OUhddqYGMo0gfuth8auvFPFM5awdjzjpjL1SF2x+NwVxYwK
	AJEzArYP4qE+UDN2ExMp6o0kFjf7aQqnVW0BN8OaCiVaydvKVYjDxtwMCsJokpoxwSKUcJ
	fI8TnizSJqHWGrEFD4bqCMSwwNaJquKamj6odhmPKBN51TEfA5ClSt4QQ8/2KcwCYw1Raj
	Dzv5IwIhktBdnhfRAmOkPn+OrltCMB5ZNhswfSFrEE8s9ytiyLXS4AeVY+Q7dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioLiiK2rZ2UOEu6djBL2d3YM++31ZOhub6bJKMpv7YM=;
	b=Xi6yA28LDxDM/oz60aYwRb3bBMbhIxzElqWem2Vi//tCrXvW7kh/0yQGY4wd5Obd2SnJ8y
	kxv4Q/RbxGMIlUDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Always define
 sched_domains_mutex_lock()/unlock(), def_root_domain and sched_domains_mutex
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-20-mingo@kernel.org>
References: <20250528080924.2273858-20-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024651.406.6982259401672691141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5202c25dd17c54cd4c21f266d9a51b644d7cd682
Gitweb:        https://git.kernel.org/tip/5202c25dd17c54cd4c21f266d9a51b644d7cd682
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:18 +02:00

sched/smp: Always define sched_domains_mutex_lock()/unlock(), def_root_domain and sched_domains_mutex

Simplify the scheduler by making CONFIG_SMP=y primitives and data
structures unconditional.

Unconditionally build kernel/sched/topology.c and the main sched-domains
locking primitives.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-20-mingo@kernel.org
---
 include/linux/sched.h        | 5 -----
 kernel/sched/build_utility.c | 3 ++-
 kernel/sched/topology.c      | 4 ++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64..aa54d75 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -395,15 +395,10 @@ enum uclamp_id {
 	UCLAMP_CNT
 };
 
-#ifdef CONFIG_SMP
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
 extern void sched_domains_mutex_lock(void);
 extern void sched_domains_mutex_unlock(void);
-#else
-static inline void sched_domains_mutex_lock(void) { }
-static inline void sched_domains_mutex_unlock(void) { }
-#endif
 
 struct sched_param {
 	int sched_priority;
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index bf9d8db..5c485b2 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -83,9 +83,10 @@
 #ifdef CONFIG_SMP
 # include "cpupri.c"
 # include "stop_task.c"
-# include "topology.c"
 #endif
 
+#include "topology.c"
+
 #ifdef CONFIG_SCHED_CORE
 # include "core_sched.c"
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 2352caf..ee347d9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -17,6 +17,8 @@ void sched_domains_mutex_unlock(void)
 	mutex_unlock(&sched_domains_mutex);
 }
 
+#ifdef CONFIG_SMP
+
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
 static cpumask_var_t sched_domains_tmpmask2;
@@ -2842,3 +2844,5 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	sched_domains_mutex_unlock();
 }
+
+#endif /* CONFIG_SMP */

