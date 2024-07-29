Return-Path: <linux-tip-commits+bounces-1807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DE293F2E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A842B1F22AE0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAA146A98;
	Mon, 29 Jul 2024 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YoPfX0Yz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBXN1Sp3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB483146015;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249253; cv=none; b=NF9Gpne5YCDkYl0Oay6p2W/u7whhHiuDE5QZiHCykfgwmhA5nArWd3Spg1vo2OB8iUxK4VRMA59uFNS9+lNNn2JhtSS7vE7BWBNdVTFsLsfaaPAYOrmWVnA87sNGg+mxlIL9JEQsRqnK2iB9QAA/WHlVmmbyUqKy/EYnvQXf8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249253; c=relaxed/simple;
	bh=mmpifIAQXZXLpxk2YC/PMWMW24bUpa0mCN6dpceYu/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MHP0D6RMwZjdeR1SGpbJ62pjSqjDRukXOhdpNWe8lQcjhd8GSQf/7ByuiLTT0WNIewpYMG9CCyYGM5baU+6EtR7EuCajH2HcS4QPfvZN5qp5JQNh02+Z/3ZE1ARXG40ROnYRMY9Zn6Q0Fox7+wg0wuZ2lX4AA6IVcrTPgYxGw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YoPfX0Yz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBXN1Sp3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=By9nKlTD3RbDZ1R5LQ5j/4eiwzL9POa9HKWwqeHMZLM=;
	b=YoPfX0YzOZ1JxyNySjzt/gHHe+4vRC6K6ZJkmJGsqwWD+DFfG67ajW/YbDPcE7SbQfwu3i
	G86Sy4yMcET8JE4cAbGM4+8C+KL4r24HLK4+ZMGw7M0wOBLXDc2SoHbL3Dot93hKz9GPio
	BFX90QmAAXQOz+DR7734X7/8XpvOQOMbJOfX7yZByX/e4MYsIYrjwekh8gf4viQehSWxAu
	AX/CTjuQF4rlbv73M262Mi7RBfwPG5D/KVXYmoWYg0DKZPmpjY+9SMJizeVM5rOZP5tsMu
	kVP0ur3Hb6Eb7IpN9FC/X/LKlibfEFKQ7g7B3G44Ayyn85f+xpYFC7W0SmB/1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=By9nKlTD3RbDZ1R5LQ5j/4eiwzL9POa9HKWwqeHMZLM=;
	b=uBXN1Sp3ZcGh/5reHh/SullPEt7bYLz7Fp4Jm+AQza2OS9rYhpLVp59Tc9zmyhbjkMhZhl
	O1e1sQRAevVwPYAw==
From: "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smt: Introduce sched_smt_present_inc/dec() helper
Cc: stable@kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240703031610.587047-2-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-2-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924995.2215.9546634232496925582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     31b164e2e4af84d08d2498083676e7eeaa102493
Gitweb:        https://git.kernel.org/tip/31b164e2e4af84d08d2498083676e7eeaa102493
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 03 Jul 2024 11:16:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:32 +02:00

sched/smt: Introduce sched_smt_present_inc/dec() helper

Introduce sched_smt_present_inc/dec() helper, so it can be called
in normal or error path simply. No functional changed.

Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240703031610.587047-2-yangyingliang@huaweicloud.com
---
 kernel/sched/core.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f6550..acc04ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7895,6 +7895,22 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 	return 0;
 }
 
+static inline void sched_smt_present_inc(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
+#endif
+}
+
+static inline void sched_smt_present_dec(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+}
+
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7906,13 +7922,10 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, false);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
-#endif
+	sched_smt_present_inc(cpu);
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -7981,13 +7994,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_dec_cpuslocked(&sched_smt_present);
+	sched_smt_present_dec(cpu);
 
+#ifdef CONFIG_SCHED_SMT
 	sched_core_cpu_deactivate(cpu);
 #endif
 

