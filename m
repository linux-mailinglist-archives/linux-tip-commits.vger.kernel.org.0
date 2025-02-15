Return-Path: <linux-tip-commits+bounces-3363-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8457A36D64
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A883B0EA4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940D1A304A;
	Sat, 15 Feb 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8RDobiv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJ2+OJ2W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028011A23BD;
	Sat, 15 Feb 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616960; cv=none; b=uojAjsNalNDdztyIvFH9rZ9g84XzaClOWz644q8pI6twfqR8naN2iMM6SB6moSucbQH98xN1pZqO+ojwS5shsUoT7oEEICkQUofP9kijrPq09SSLE2BqUpcyihQfy4M+lToPTCQoLcn8EIU8+i5ozuospDgBsOEM8+t1+j2fpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616960; c=relaxed/simple;
	bh=cwV4GJPv6+vLMjPLxK9h8mxo2J0X8KdiqHOSZqOFJPw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U2TyqB8hx9o07t0eFJAh5n29bUR4nwOviY/q5xdfe6moaYXziWRigzgkQPAxRNFlp3qUwUP1Xru8aqgjlx4aKsz+PAdygjV8NrvaT1YiDSDixPy6a9QwuuZSAK1V38Fj9eXBFgTTrR1j61EotCJFa/z6y6hVKLGp7w0JY6O4REg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8RDobiv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJ2+OJ2W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PquJFUk3IH3jUTv2TezDyvZQbb5kNJjtTC87VPrr598=;
	b=n8RDobiv6EffZL/yC2WaXSzsQpimYm34T7TJDQHsrvDA7Nx8MHKvG63/E4nzVP3P67Lg06
	sLgJUVG4NyQ6m60zT6O1pZPFfenhDuyhmMGcLG57vxwxlCT/TeOoZ0oK/tB1O/RMzSvwur
	NKT1N24bpGMGDlbpG8nJS5V4JBV7/47Su6WshgmglWSC87Ng1hINyXGZTJJNBHip50oorc
	TkubL+7x/uEs4hSlnZqTtTtWL4FwflYfsQ73wRAJhr+IfVthrzHJpETNx7xeAU3t0zZNE8
	CmBpdzAK4DMxwA9QvxigaTAfO4gZ0ryKnZ19qJra8x0PtXbB+6NXXuxuASnklA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PquJFUk3IH3jUTv2TezDyvZQbb5kNJjtTC87VPrr598=;
	b=yJ2+OJ2WRy7pmTfMfmcvJkulIvipnqkE6LR2T2w7740o1M++wKYg5camz0qsq7GRE1/iaF
	VqjZyqQ1TFAEA0Cg==
From: "tip-bot2 for I Hsin Cheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Refactor can_migrate_task() to elimate looping
Cc: I Hsin Cheng <richard120310@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210103019.283824-1-richard120310@gmail.com>
References: <20250210103019.283824-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961695638.10177.15446908649592495018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d34e798094ca7be935b629a42f8b237d4d5b7f1d
Gitweb:        https://git.kernel.org/tip/d34e798094ca7be935b629a42f8b237d4d5b7f1d
Author:        I Hsin Cheng <richard120310@gmail.com>
AuthorDate:    Mon, 10 Feb 2025 18:30:18 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:01 +01:00

sched/fair: Refactor can_migrate_task() to elimate looping

The function "can_migrate_task()" utilize "for_each_cpu_and" with a
"if" statement inside to find the destination cpu. It's the same logic
to find the first set bit of the result of the bitwise-AND of
"env->dst_grpmask", "env->cpus" and "p->cpus_ptr".

Refactor it by using "cpumask_first_and_and()" to perform bitwise-AND
for "env->dst_grpmask", "env->cpus" and "p->cpus_ptr" and pick the
first cpu within the intersection as the destination cpu, so we can
elimate the need of looping and multiple times of branch.

After the refactoring this part of the code can speed up from ~115ns
to ~54ns, according to the test below.

Ran the test for 5 times and the result is showned in the following
table, and the test script is paste in next section.

  -------------------------------------------------------
  |Old method|  130|  118|  115|  109|  106|  avg ~115ns|
  -------------------------------------------------------
  |New method|   58|   55|   54|   48|   55|  avg  ~54ns|
  -------------------------------------------------------

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250210103019.283824-1-richard120310@gmail.com
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9279bfb..857808d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9439,12 +9439,11 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 			return 0;
 
 		/* Prevent to re-select dst_cpu via env's CPUs: */
-		for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
-				env->flags |= LBF_DST_PINNED;
-				env->new_dst_cpu = cpu;
-				break;
-			}
+		cpu = cpumask_first_and_and(env->dst_grpmask, env->cpus, p->cpus_ptr);
+
+		if (cpu < nr_cpu_ids) {
+			env->flags |= LBF_DST_PINNED;
+			env->new_dst_cpu = cpu;
 		}
 
 		return 0;

