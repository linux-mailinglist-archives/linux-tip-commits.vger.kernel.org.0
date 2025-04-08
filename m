Return-Path: <linux-tip-commits+bounces-4761-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B8A81571
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E05E18954B2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344C2417DE;
	Tue,  8 Apr 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qoTkxkf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5MmFExe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB98244195;
	Tue,  8 Apr 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139133; cv=none; b=erQf6SzJ3nJ/Z9WF9TftUy7kqtAxrkgv3sPkh35228P9spvgpm8gjXKgM7ToVqxbGN3xlEhnigiW0Pz9Qovfy6H39hJl+wvgrLk1HS44DT1aAhkoRKeWub1I1H9MzZBHsGofIWbC6QWo7mfrQTxQpgSxwjhK6F7vIh3/zIuO96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139133; c=relaxed/simple;
	bh=kWJyR/17OkFP3Gny6/lSexyTIjVMLYBZjd/1pSGSGEk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FAMGBEvG4vWa+6f6yIryrqpmX0G/gqw8JwDpjEPrSdJg+MhhGCtTIJ+MEvLHFItovIglsEoPvb2lCqvvLrXfZjgm8i7smyeyi0n4ggMcAguRYlI+N1/6iznG3QfuqhLM3HWDGcp+L+M5XOlAgfw/plbNt19zUxVsic7Hisykeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qoTkxkf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5MmFExe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfqSb4hRPM9Am6t3cmfjZ5zvQYJ5srYnkQnW+uwhy3g=;
	b=1qoTkxkfvZTR0HEccbD1JCQfUcvHKp7gUa6SEfUgfeJfjnnbx4P3uKltsjSZyNbGgLZ09J
	bqWvsNeQb0ZForWGR3Id4V4wtCg5Doy4IRLm1oKlRVre1gWkaNSUfc99Xk77Tuyf47UZGJ
	a+xliexjpUkP1xckfWVS++xq+0EQHbV3UCxfJ2XSBCYxqYI4LvizaWlYzWFQ6fWK9AKH0l
	ieVykYpKLQzS3feIr3WFNeVNhvx57ag4aDSK5zA92Z2M0umHEAFAUimp78YrjE043uXpT3
	5MMo0+ccV3bkzc/Tkz06jza60WqPqfQaxW9QNa0PaMAJ31WE7k59kM3//k1Pmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfqSb4hRPM9Am6t3cmfjZ5zvQYJ5srYnkQnW+uwhy3g=;
	b=q5MmFExehnujvcyjNrLlg9aqayaq0FRAo8/URqHeliT2Nyu80/0JcfyhRJYAVS8IDPc9oB
	SNHenZRtOmMOycBQ==
From: "tip-bot2 for Phil Auld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/isolation: Make use of more than one housekeeping cpu
Cc: Phil Auld <pauld@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, Vishal Chourasia <vishalc@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250218184618.1331715-1-pauld@redhat.com>
References: <20250218184618.1331715-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913011.31282.4940467706477731730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6432e163ba1b7d80b5876792ce53e511f041ab91
Gitweb:        https://git.kernel.org/tip/6432e163ba1b7d80b5876792ce53e511f041ab91
Author:        Phil Auld <pauld@redhat.com>
AuthorDate:    Tue, 18 Feb 2025 18:46:18 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:55 +02:00

sched/isolation: Make use of more than one housekeeping cpu

The exising code uses housekeeping_any_cpu() to select a cpu for
a given housekeeping task. However, this often ends up calling
cpumask_any_and() which is defined as cpumask_first_and() which has
the effect of alyways using the first cpu among those available.

The same applies when multiple NUMA nodes are involved. In that
case the first cpu in the local node is chosen which does provide
a bit of spreading but with multiple HK cpus per node the same
issues arise.

We have numerous cases where a single HK cpu just cannot keep up
and the remote_tick warning fires. It also can lead to the other
things (orchastration sw, HA keepalives etc) on the HK cpus getting
starved which leads to other issues.  In these cases we recommend
increasing the number of HK cpus.  But... that only helps the
userspace tasks somewhat. It does not help the actual housekeeping
part.

Spread the HK work out by having housekeeping_any_cpu() and
sched_numa_find_closest() use cpumask_any_and_distribute()
instead of cpumask_any_and().

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20250218184618.1331715-1-pauld@redhat.com
---
 kernel/sched/isolation.c | 2 +-
 kernel/sched/topology.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 81bc8b3..93b038d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
 			if (likely(cpu < nr_cpu_ids))
 				return cpu;
 			/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b334f25..bbc2fc2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2098,7 +2098,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 	for (i = 0; i < sched_domains_numa_levels; i++) {
 		if (!masks[i][j])
 			break;
-		cpu = cpumask_any_and(cpus, masks[i][j]);
+		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
 		if (cpu < nr_cpu_ids) {
 			found = cpu;
 			break;

