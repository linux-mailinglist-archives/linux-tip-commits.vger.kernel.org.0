Return-Path: <linux-tip-commits+bounces-5789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D9AD846D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887B7189BA37
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BB2E763E;
	Fri, 13 Jun 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="giBakqLL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="APVoq9S8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8A2E6D1F;
	Fri, 13 Jun 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800238; cv=none; b=MDnKHIZjqBVWjTvIndwvGxaMHz2LGOycBaBZohFsMgK1H9wP7Zm91UmWAZjpeoMUja7TZqfb/Zwj9M9pqG83FIYporwxS1GJ6fL7jjeGhXfR3NFqhDeCpiX3TKeEZF0sWO21jNr1nNOVM4G7MYIiP6Yongofe6/PLcwfH+G38tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800238; c=relaxed/simple;
	bh=n8RGjjnkkuldS8rW6nK+AuyZymoYFUJUJ+HcJ4J807w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aL7dAGR1SOUyVlLf5UEWzkjy4zZR8sNbc3qhfk/R7RSU/NSpHSX/yJuGwKQCzW8BRfTIGEzy/ZqR6hTQZz5sSVfBrczNVSwEtsCvRWTi/+es4u+YBz9hdKr2MTio6tAqdWrIJg0Q8bP8PQuX/z26UHKB5HPlvzYXCDW0hRFRFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=giBakqLL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=APVoq9S8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtXzndXqQJoWN9/9oNVG8rhnzsGOsU7qA7JbvD0N67M=;
	b=giBakqLLsadUNmcJVPOmgpphdBPFichkTDjQ7Y4EDeQ4hSztxQjrTLFVjVITe2RwxDbh7t
	UCJdhP6xjvUkTO8tZWRLH4EhtgUVz7kWSq3tjmOCg6iqCsCPcWgLo7XRI1tvru38JU+BWy
	CNQZOypLmhd+7pjEYeM0calQsemq5FSzwZusEgPGCX2fmby1aSHvgQ4lJhkqgV9QFm4qc3
	Yd6O5fCn58rpxcYL/2W0T2RnPeA2mIc0b5p8W4wR3k1r2Fl1EvRi91ps4bKP9uREuDHjYI
	hNemKTzdMxKS0OqKgIYQA76UQ4Yg8LcefDwKoSWeNN00k6TUmf2V8Gjvx4zgAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtXzndXqQJoWN9/9oNVG8rhnzsGOsU7qA7JbvD0N67M=;
	b=APVoq9S8ULL0oUNlo08lBLXkevsKCOcvRfyPAMjeQ3dkTgobzsPkc5M1mw8OuHW6u/dke4
	DlpMhlIiNz5dM8DQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of
 sched_update_asym_prefer_cpu()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-34-mingo@kernel.org>
References: <20250528080924.2273858-34-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023420.406.3320852878387182188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6c8d251621c131274fa05b46fc138f296b00f6e4
Gitweb:        https://git.kernel.org/tip/6c8d251621c131274fa05b46fc138f296b00f6e4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:21 +02:00

sched/smp: Use the SMP version of sched_update_asym_prefer_cpu()

Simplify the scheduler by making CONFIG_SMP=y code in
sched_update_asym_prefer_cpu() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-34-mingo@kernel.org
---
 kernel/sched/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f2c1016..8e06b1d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1323,7 +1323,6 @@ next:
 /* Update the "asym_prefer_cpu" when arch_asym_cpu_priority() changes. */
 void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
 {
-#ifdef CONFIG_SMP
 	int asym_prefer_cpu = cpu;
 	struct sched_domain *sd;
 
@@ -1373,7 +1372,6 @@ void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
 
 		WRITE_ONCE(sg->asym_prefer_cpu, asym_prefer_cpu);
 	}
-#endif /* CONFIG_SMP */
 }
 
 /*

