Return-Path: <linux-tip-commits+bounces-5783-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB6AD8458
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD30A189BB94
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C62E2EF3;
	Fri, 13 Jun 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpfazPH8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/U5me2h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF822D5404;
	Fri, 13 Jun 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800232; cv=none; b=ALqorIgVFR5AWygLRFBLbAAMIrmFvciu7+yWw8/v4KA/Ukowr51JSJfYSPFP8ApLKxLvjUvvOz/ZZjWX6npMUZ2oZN9NQctROlMAfiTl6XyN9j6mr/Drfml+Ph8zjI6XYnev/CmeuZONh00/afVI7fmBWpDUpGbQokNNYT7Fhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800232; c=relaxed/simple;
	bh=45sY0VYm7TqR8WZ3wDcQZrqcdacmeS1JR5Mc83oKz8o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BHTBU6lD3qXhHXgxPrwrfmZMCvaIz8b7QfmOtuSjAiz9mp/9vzO1T9El0ivYVDSUxU36AEFT5xEJZsJe0pyHjol8i8wsPnBzKTRmHhquvTRDJhrAIGcNTuDHeD2Xla/Wg6lmLlYNPclH3Eyq6dtC6EzWam3M81wSpYyRwwWEH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpfazPH8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/U5me2h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0Z7NB+XA+iG+GQJ9CVORe45IrTBYFQ2VpM8xNa4OI=;
	b=RpfazPH8qoqclyDaN8bCR0eHgk6eU7ria7Ljw6XsES+wVaWA+FH0fCFNstxv0rF7UCbFvQ
	92UZ2ECDLSVOLwngm40MK8QON0LV7Miau+k7bPba+UPkPWeBmb94bncE3rjCsgrL0z8T3/
	cnfrC3w473GJwRBgtrIhNgSjW+zz4xNHqS04SFsKN3mXK2DNA2o5LjlbXYoC++9Q9F9beO
	dyQpVra+s93BOGXKDUYIFzsw9bit4mdMada2aEv1FazbJtVA8LtCJsbTw9JG1kNklg0qzh
	wyFTPN3o3zNW9kRAj+kiZO4o71D29UJPMAc5ug4G+u80CkmPnxLXkwtTarAzYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ0Z7NB+XA+iG+GQJ9CVORe45IrTBYFQ2VpM8xNa4OI=;
	b=X/U5me2hXeEBNfeq9JNM5dGsa0OxU/00TjeqqLxTZY5Qrjax5OvDEBs8BPzHbI09VhgBgt
	+2RMUpASn42NlZBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of WF_ and SD_ flag
 sanity checks
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-41-mingo@kernel.org>
References: <20250528080924.2273858-41-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022743.406.5417633156555260582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0203244600b2f48c7074a9d439789d8d1152d3e1
Gitweb:        https://git.kernel.org/tip/0203244600b2f48c7074a9d439789d8d1152d3e1
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:23 +02:00

sched/smp: Use the SMP version of WF_ and SD_ flag sanity checks

Simplify the scheduler by making CONFIG_SMP=y asserts related
to WF_ and SD_ flags unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-41-mingo@kernel.org
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7490473..d8c78ee 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2261,11 +2261,9 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
 
-#ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
 static_assert(WF_FORK == SD_BALANCE_FORK);
 static_assert(WF_TTWU == SD_BALANCE_WAKE);
-#endif
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution

