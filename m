Return-Path: <linux-tip-commits+bounces-5786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A70AD845A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F233A2FE4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003992E62A4;
	Fri, 13 Jun 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07EkbRQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bC8CnbAv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2452E2F1F;
	Fri, 13 Jun 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800234; cv=none; b=RlbUkeTHDcJv2lP6+O5Wnq4ZwrIW2SoSsTuepwjjmSUSDq8cFbDTmBykSlON6sj8jSuUeijNOMHm4yGqo7yeSvOxCGIMNF9o/QAKD+6HBFMrTn5aKqrgjQzQbL322TAQdU69/DocEQp/zXKgOS0xFTH8VdrXG+51QaxSu8h57uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800234; c=relaxed/simple;
	bh=DeFzKLp0RRss+6LiK7R1kh8o7qRT6nGEm2tnVGQXwl8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fH0pToF1NlwPLOb1vJXILyEyYN9plS56zk3Qutw7PrlYKJHMz1Ac1Fke7Sg8+GabmsuOesTvXSu8fxD9Xmd5aVCs/v46xshuhLm0dDFXVwe/V0sfqaT9P7pb+Mg1lzPvVrdEFkeAdYgoGOlrBOO6ARldZO/JS4mfo1kvNv5/jDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07EkbRQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bC8CnbAv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsQaRyS9PAM2JbusZC2EbUKNW0cw3KThaVumd+KbEkw=;
	b=07EkbRQ8lXctM6Mz2aK46TImX7DURDCQTSCLWFadJtoX5Sf/dyjct4eqa8csb1Ifag8zmu
	QfRwofAXcGwhP/+aJTO8lhRExBhBj6yBfKIH8hr7oOHkf7FQSmbP/YkpaiczpA5/BNSN3G
	QcASAjgbXhqfFN9d+8s+thch+iGMzqfnoL3+bWNPMZ1ZZ/jh+8zlY7vRHMZjvQj/w5DBWU
	IOgVAbXL0Y3ZM7mROJuIlfCOJiAYyYnCi/L/wn4sPFgTOamUltS76As1yOC6ibTGCUgYbM
	rA3kykHnSoLmth2u1dUxwYVrhDjR4x4SJWwhxdEBJHRi279/BnTBKbvaMezg+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsQaRyS9PAM2JbusZC2EbUKNW0cw3KThaVumd+KbEkw=;
	b=bC8CnbAvjY+sNiC64d1Tlhzw5EG70NZO9rR66bUwMBnT4zGJ6gCygEUWp4O+8aXwHmYvPr
	ZxFBaWk6VDOvBoBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of is_migration_disabled()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-38-mingo@kernel.org>
References: <20250528080924.2273858-38-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023057.406.4482693033699016443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9fd5da7989ba6175fe71439738ddcf4c030d3d51
Gitweb:        https://git.kernel.org/tip/9fd5da7989ba6175fe71439738ddcf4c030d3d51
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:22 +02:00

sched/smp: Use the SMP version of is_migration_disabled()

Simplify the scheduler by making the CONFIG_SMP-only code in
is_migration_disabled() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-38-mingo@kernel.org
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 234dd28..b184c3d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1301,11 +1301,7 @@ static inline int cpu_of(struct rq *rq)
 
 static inline bool is_migration_disabled(struct task_struct *p)
 {
-#ifdef CONFIG_SMP
 	return p->migration_disabled;
-#else
-	return false;
-#endif
 }
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);

