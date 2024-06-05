Return-Path: <linux-tip-commits+bounces-1341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F48FCA09
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721E71F21A2E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F631922FA;
	Wed,  5 Jun 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNZFXUKg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rz3cGb4Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336A149C77;
	Wed,  5 Jun 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586196; cv=none; b=SDFUMgOE5ItkFNaa87Tj8NlsEyzIWP1cY59eKsWPmTNSYWmHjYVRjwn2Hy0OlHM+UksdRySkQY+jgzaEQ8Hp9IT+ksCteAHYtD2qkLtZwwiixebclVDWxMsZbMP8+rNyrKu0rmsNMHskZHhGrA8ZbIcZo4RIxqtpAlfGsilWJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586196; c=relaxed/simple;
	bh=i5qDHUlWKpQ7V2KQc/nRIfd7ci0vEVnDOh7Bt8/XeBo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Gbb9FA/+/E4x4oFLJZSCLvoECcjrrYYooUNw4/x52IJMdVSUESmOSbeWak81fwia6DjZKzavK4YeR/AcBrx2txgoA9wCUJzycNlWQuGhTazQHgAzhZa+Ehe2grWxo9y+P+flw0qSJL/wusG3JIYti3S0u0Sg9duMzqTqrpmbJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNZFXUKg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rz3cGb4Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 11:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717586193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XWQTvEYhGK0QV04a9jOnt8+f38VQ0r81EfON1LHHCPo=;
	b=KNZFXUKgAfLC6go0IbsRUUFSaKCpRcTShPH59LI/sncWD3SPjfWIj7jd8La01dOB2UdQ18
	TxJcMlI73g4lXdJbVXpLtO2DQ1+Kvv05Aq7TjsV5DP1Bnof5VIDCW3PWJTK/klrr9CtX9+
	QqVu/C6BNy80BZfrjKp3DXpKcWyQzGo1dNlGHSs7pnZsnhdtfHeo6ks7a6GMxEBLGw5QM7
	otPhWnl6m/STkh+SstrsI6GUSY9dpb/fyj822TzGOdQGaar/ZqFpVDmuGWjFRFjt45+L29
	An6+AZi/+B7IcYRZMvzFTh8wIAVsGr/RxGmkCURKLoW5QE9G97T+MQfMfwgZnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717586193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XWQTvEYhGK0QV04a9jOnt8+f38VQ0r81EfON1LHHCPo=;
	b=rz3cGb4ZE4tuXJS+sXWCzrfEZpmHE86mr0G/92SWIyw+oRmQsFb3bHN2cDjpivwOs446cy
	DrZ93h2RhTwCEBDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Simplify prefetch_curr_exec_start()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171758619265.10875.8871135454479339495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     85c9a8f4531c6c0862ecda50cac662b0b78d1974
Gitweb:        https://git.kernel.org/tip/85c9a8f4531c6c0862ecda50cac662b0b78d1974
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 05 Jun 2024 13:01:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Jun 2024 13:03:20 +02:00

sched/core: Simplify prefetch_curr_exec_start()

Remove unnecessary use of the address operator.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5d861b5..0935f9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5340,9 +5340,9 @@ EXPORT_PER_CPU_SYMBOL(kernel_cpustat);
 static inline void prefetch_curr_exec_start(struct task_struct *p)
 {
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	struct sched_entity *curr = (&p->se)->cfs_rq->curr;
+	struct sched_entity *curr = p->se.cfs_rq->curr;
 #else
-	struct sched_entity *curr = (&task_rq(p)->cfs)->curr;
+	struct sched_entity *curr = task_rq(p)->cfs.curr;
 #endif
 	prefetch(curr);
 	prefetch(&curr->exec_start);

