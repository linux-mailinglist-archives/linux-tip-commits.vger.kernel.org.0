Return-Path: <linux-tip-commits+bounces-5780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99EAD8453
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743863A2E3D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3852D1F7B;
	Fri, 13 Jun 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5W+Gf1x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yAFDsV+y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEC2D1905;
	Fri, 13 Jun 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800229; cv=none; b=kVVKcfqFU4JUAVcGumkVK4RRrdTZSLhcscb4xAE0/3EmyCzmlcsxt72ORwk9NfGPCyoepW61o2zJ8z6ghrln9ba1q3rToaj+VHz+kk/hJ0w8dEmYjiyQjiDl0aI1ECTOQ9m2bfUltLA+Ot95JHbDmP+wzyggYB4uJOrSlC6TmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800229; c=relaxed/simple;
	bh=NLkkR8ijEyXqyItP3m76zDh3RiZvv4Biqr3HgKC4awE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jWi3f4q64BC0uJuuoyAWuoisriVS+h26GKVoMTl6sO9mF06fM4b/2gEOlEb7RbUhhGJs6BAOp6epgZiFBSbdWB6grZketSNGbIBOa80J+Jj6JKFUtQJ2BX7I3cvkgmMw3jKr6JqK1hqZ9zucPan/fibkM2d3NSmJvMpMyE92aJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5W+Gf1x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yAFDsV+y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2zuEZyWB8g32MCIGGprz+nmScd2qc9BxZ7lEYBxJ6Q=;
	b=I5W+Gf1xXn3Q1Y/Hn80idPESt9WTZ/TMqut5lpu71uAB20jfaNqYP473WYq/t8JIDo4oXi
	c5B3IF6HMZFzvViHTcAan68CWh9sE/kyYZAjeslCn+ZLSF9OU9lG2wmGljL6Nq6O5rd9TG
	fWPssUEvckJupSjo2/34/vV0kb5/9weyWjvDRSOEnOlyIKqoDtTQxkxvDsCge/zSLtxN/G
	RIU7UOrQ3ro5LtCluNPfxHTx7wSvTlZFdy8XT1HMv1QMNNXfqw96aDEZuikcO+qA+jIKwZ
	3tfgvOyJkmLtWiNTNlDbIIdcrPr0xnBaQQZsn8dPxsAUzIBlEcBmYR68ucltsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2zuEZyWB8g32MCIGGprz+nmScd2qc9BxZ7lEYBxJ6Q=;
	b=yAFDsV+yh1lE9rBxOsQaMNzyh3G38vTrNrUw32+Rx6mYd0sNyTcWdY/EgPReX3+myrQC//
	dIdgX4PaAHribfAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of
 double_rq_clock_clear_update()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-44-mingo@kernel.org>
References: <20250528080924.2273858-44-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022442.406.1107705034782372550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dabe1be4e84c05db9341eb8c6c410e18a5ffeaa5
Gitweb:        https://git.kernel.org/tip/dabe1be4e84c05db9341eb8c6c410e18a5ffeaa5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:23 +02:00

sched/smp: Use the SMP version of double_rq_clock_clear_update()

Simplify the scheduler by making CONFIG_SMP=y code in
double_rq_clock_clear_update() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-44-mingo@kernel.org
---
 kernel/sched/sched.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aa08103..c323d01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2840,10 +2840,7 @@ unsigned long arch_scale_freq_capacity(int cpu)
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 {
 	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
-	/* rq1 == rq2 for !CONFIG_SMP, so just clear RQCF_UPDATED once. */
-#ifdef CONFIG_SMP
 	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
-#endif
 }
 
 #define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)				\

