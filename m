Return-Path: <linux-tip-commits+bounces-5802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F030EAD8485
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E983A69B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6652EAD03;
	Fri, 13 Jun 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZGiJ6rR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jrm8Ai9L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B72EA482;
	Fri, 13 Jun 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800249; cv=none; b=BV27d2aZAxBfM157bIANj60dxK5LbDFZryPdd6srUc0qovIn8iLFdeqWy+6uzJTrmLIz3YZhP8jVnt107nSHhOST5+frNsj05SksauBAeceI2dHCsfNyOFenHt58xOqq9RAYjhB+siy7d7ZW+Se6xrLhdFEd4WaC4S9wlrbkdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800249; c=relaxed/simple;
	bh=c3eLj73r6isJ6Qg5nF1MV2b00OxH6rz7Ez7dudV9lYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SMOzaIDyxgtFOGceWf6dBU6KxM3TGSpPohIa+0HfhAN0Z2Pn3qHXt69Q8t6x0i3mwS9LB3ocQ4h447jwzKE6LHVOxpq/dJOtlmDtWbrCyYAQcl+Wttl94H/msX7H6/s8cRer6TnPiKltrzpuL4OStliu5mTd8B3dVICN54O0SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZGiJ6rR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jrm8Ai9L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgm/Jy+NkXbIz4HYYlVR7R4wXdNXGkpmH0U4NBggTfk=;
	b=NZGiJ6rRa7zJCfapvpSky92gi950wiGO76VZpfbzOCns67ENrxA7vEo3FJUoph5gXST/Yz
	WsqjB3qdoJd3b/6scyTeJkB4RtOXZrC6HbfSJ58Ewp7EDUEyTgakr1iDUvuoJ7K2Z/hpBS
	oqQ1ZOc3FVdbYWxBebcaj/XZJQve8LcACeM1cMAcSonxxXRlLR86v+aRBKi5AXApSMQ8ud
	501ZHPh1exgDrNEf0yV7AUhH2i2+UByNl9fSRWNEikGwTape/anZrveJDmuYSiWzTJ5mbt
	/A0L58eDq9aJ+hbMBymgfwT4hEqn3PpByN/YMCttpdi/LzKrkyf5Kztkrt3kBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgm/Jy+NkXbIz4HYYlVR7R4wXdNXGkpmH0U4NBggTfk=;
	b=jrm8Ai9LsHpjWiSFv+48/L+6192pJQvVE5Re2g051Ek86jSobwLmLRVZVOOYy/AsgmbVW1
	w0EwR3i2DKZHZIDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Always define is_percpu_thread() and
 scheduler_ipi()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-22-mingo@kernel.org>
References: <20250528080924.2273858-22-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024478.406.12282096237020663354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06ddd17521bf11a3e7f59dafdf5c148f29467d2c
Gitweb:        https://git.kernel.org/tip/06ddd17521bf11a3e7f59dafdf5c148f29467d2c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:18 +02:00

sched/smp: Always define is_percpu_thread() and scheduler_ipi()

Simplify the scheduler by making the CONFIG_SMP=y primitives
of is_percpu_thread() and scheduler_ipi() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-22-mingo@kernel.org
---
 include/linux/sched.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 376befd..eec6b22 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1765,12 +1765,8 @@ extern struct pid *cad_pid;
 
 static __always_inline bool is_percpu_thread(void)
 {
-#ifdef CONFIG_SMP
 	return (current->flags & PF_NO_SETAFFINITY) &&
 		(current->nr_cpus_allowed  == 1);
-#else
-	return true;
-#endif
 }
 
 /* Per-process atomic flags. */
@@ -1967,7 +1963,6 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
 	buf;						\
 })
 
-#ifdef CONFIG_SMP
 static __always_inline void scheduler_ipi(void)
 {
 	/*
@@ -1977,9 +1972,6 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-#else
-static inline void scheduler_ipi(void) { }
-#endif
 
 extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
 

