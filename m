Return-Path: <linux-tip-commits+bounces-1631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FB92A55C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 17:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F9D283C81
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF912142915;
	Mon,  8 Jul 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XEod1348";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqiv8aaJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFD13212E;
	Mon,  8 Jul 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451238; cv=none; b=Ywen1fQxcpWtfUH/UevPUqHM4dZ6cXQr3Af0U3sq8t/KI4C0z4lIpQjom09t2WrIqAFjfHrBHAlaQxcy5dgLHDPy1dXVuoCMOT7fkC30WjVhxzJIAOrI+DoqLyM0CV0C70/dCb8TkPHSe/JvpDkRMYALCqbpeo6YdaAaPdcf/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451238; c=relaxed/simple;
	bh=WXcV6yjlDvL5JaZKSvLgjy8kE3dOhfaSpaMq0UkeVi8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GTAxrqvef+DLoafYYEYtSQH6DjEHNFlN7D0o/AKH8ACJ0p93OrqhhUaLpK5I0jNfkADFlm+7FC8a+2ICl/QLC33b0eZ39SOTzcABdVCErhu3NFXKF1Ujk5eZBrdf0Z7Wye5ye5Zwldl29VWPo6AqumX5BJWWR0L4BjTDcCBiLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XEod1348; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zqiv8aaJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 15:07:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720451229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRY91ZHAJoiKtGMcLVxXN9TcUBfluF4Q6pR/aMDRb7Q=;
	b=XEod1348sgHTwLs8ADAgwjQRLhFIri23Iftcf3eil/K3z+hpsdcap7zb/bAAXMj7YLCkVz
	1BzOzwpcnNcQ6R6BuKWF+YkUeerD6BhsNyM9YdXQZ9wsZIrl/0cAaSgdQiRpFrwK3Zwb0B
	nb5GjU24eoLhTDKGput/Uyj245imGT4nPAHDRanUv8dvHZOuad0ANau+aotOUjworZ+YXX
	Rqy9u8NlDNou7rk8DcmkDeh/0mE0y5SBD//v5Wxy/4KMkn/UwB4VdfO4ZGOTHwfTZCsDj0
	kjHZeltqbFiGAMXmYtdkEFFcBtJkZusRbo+QjbtdfJPw9ODGi38ocGXPCQL86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720451229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRY91ZHAJoiKtGMcLVxXN9TcUBfluF4Q6pR/aMDRb7Q=;
	b=zqiv8aaJc9Ie74wBrbdbxp4B/aqixaivPmt2iTRsdAtsg6aXjwyiyoC5bDr0dvEZx0Ro5x
	qCfaInb1M2x650Bg==
From: "tip-bot2 for Tvrtko Ursulin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/psi: Optimise psi_group_change a bit
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240625135000.38652-1-tursulin@igalia.com>
References: <20240625135000.38652-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172045122897.2215.4147151982373421168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ec208ce9834929769ace0e2a506106192d08069
Gitweb:        https://git.kernel.org/tip/0ec208ce9834929769ace0e2a506106192d08069
Author:        Tvrtko Ursulin <tursulin@ursulin.net>
AuthorDate:    Tue, 25 Jun 2024 14:50:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 15:59:52 +02:00

sched/psi: Optimise psi_group_change a bit

The current code loops over the psi_states only to call a helper which
then resolves back to the action needed for each state using a switch
statement. That is effectively creating a double indirection of a kind
which, given how all the states need to be explicitly listed and handled
anyway, we can simply remove. Both the for loop and the switch statement
that is.

The benefit is both in the code size and CPU time spent in this function.
YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
0x2c1.

Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20240625135000.38652-1-tursulin@igalia.com
---
 kernel/sched/psi.c | 54 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 146baa9..368139c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -218,28 +218,32 @@ void __init psi_init(void)
 	group_init(&psi_system);
 }
 
-static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
+static u32 test_states(unsigned int *tasks, u32 state_mask)
 {
-	switch (state) {
-	case PSI_IO_SOME:
-		return unlikely(tasks[NR_IOWAIT]);
-	case PSI_IO_FULL:
-		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
-	case PSI_MEM_SOME:
-		return unlikely(tasks[NR_MEMSTALL]);
-	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] &&
-			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
-	case PSI_CPU_SOME:
-		return unlikely(tasks[NR_RUNNING] > oncpu);
-	case PSI_CPU_FULL:
-		return unlikely(tasks[NR_RUNNING] && !oncpu);
-	case PSI_NONIDLE:
-		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
-			tasks[NR_RUNNING];
-	default:
-		return false;
+	const bool oncpu = state_mask & PSI_ONCPU;
+
+	if (tasks[NR_IOWAIT]) {
+		state_mask |= BIT(PSI_IO_SOME);
+		if (!tasks[NR_RUNNING])
+			state_mask |= BIT(PSI_IO_FULL);
+	}
+
+	if (tasks[NR_MEMSTALL]) {
+		state_mask |= BIT(PSI_MEM_SOME);
+		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
+			state_mask |= BIT(PSI_MEM_FULL);
 	}
+
+	if (tasks[NR_RUNNING] > oncpu)
+		state_mask |= BIT(PSI_CPU_SOME);
+
+	if (tasks[NR_RUNNING] && !oncpu)
+		state_mask |= BIT(PSI_CPU_FULL);
+
+	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
+		state_mask |= BIT(PSI_NONIDLE);
+
+	return state_mask;
 }
 
 static void get_recent_times(struct psi_group *group, int cpu,
@@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
-	enum psi_states s;
 	u32 state_mask;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		return;
 	}
 
-	for (s = 0; s < NR_PSI_STATES; s++) {
-		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
-			state_mask |= (1 << s);
-	}
+	state_mask = test_states(groupc->tasks, state_mask);
 
 	/*
 	 * Since we care about lost potential, a memstall is FULL
@@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	/*
 	 * After we disable psi_group->enabled, we don't actually
 	 * stop percpu tasks accounting in each psi_group_cpu,
-	 * instead only stop test_state() loop, record_times()
+	 * instead only stop test_states() loop, record_times()
 	 * and averaging worker, see psi_group_change() for details.
 	 *
 	 * When disable cgroup PSI, this function has nothing to sync
@@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	 * would see !psi_group->enabled and only do task accounting.
 	 *
 	 * When re-enable cgroup PSI, this function use psi_group_change()
-	 * to get correct state mask from test_state() loop on tasks[],
+	 * to get correct state mask from test_states() loop on tasks[],
 	 * and restart groupc->state_start from now, use .clear = .set = 0
 	 * here since no task status really changed.
 	 */

