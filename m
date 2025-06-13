Return-Path: <linux-tip-commits+bounces-5799-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB6AD8486
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA184189DBF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B92EA466;
	Fri, 13 Jun 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckoieB5O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mnhky4Vp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808392E92AD;
	Fri, 13 Jun 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800246; cv=none; b=FdwOnkITXahwcqfRkuFphqbqcfSCbf3yVjgGHmIIIC/7F/T/dUmVaBWlImGwJeYS9+h80hAn0B24HWsVoK5CrtSNdIqMjycZNwS7mXG6rq6trdoOKpoNE0tBwxY2gH+KFnsg0j8nHg/GxPh2wmZ3wOX2TQ+TgqZ6OZOnK2gniKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800246; c=relaxed/simple;
	bh=S+Aug7GrdjGf/YJy4tDxI1oSCT423CBjdY7gJBityHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eB6IWI8cnU5cHfXLfH7KZeT78WhaO0RXOmuZwh3nLO/W1hE+7D1P86yFEv0liNWQ53eb5D1/W/X9xFe8MNnlSQjr3d2aipW+61yU7g001D+fm9nhTUOgBPft8XBRQ1IL4LMheKXshYE99hNIgUamHEpfU6AzzDQMhm80rShBst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ckoieB5O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mnhky4Vp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu4uyUjplrv2bKyv5x7u4e5f5lrPusc+404KmvbqUwc=;
	b=ckoieB5O9U9LzDELC/2lYfc0lwgaYhT0V5Fc3Xiuq1KApur+rcuEVPQHgGCZRSVhBgOjgz
	o+r5kBJi8fzbqTRzOJ0z7JY7D/mHX4boN+zAQ4+flVyfmi4FZYkFibfOZjYbit+24AYKCX
	n8zQ1vDQOl/B8kmlBJH1F5cs3oMYZK38rGGXtrqASku1S3OFh4e8R0woIdAs1ogATa/1Hr
	R8RSh/LXU2+4Vv/Xrl+WqKGF6569rHXy8XwujiZ94086843cmPUSrxa4/uXQKLEC0RujFj
	7QLLlgEZZPUJx/YzN92vVm9XjBrAMbuv7ioWnTIuPb0WJBgeiT7rMTgaUsdwog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu4uyUjplrv2bKyv5x7u4e5f5lrPusc+404KmvbqUwc=;
	b=mnhky4Vphle6yi8NBX+GLmG6tqTWlamWobyYuPV7p/SKIUkwuliWDaZtoyBZQxwyXU1ePI
	OUTritXuDOXkFoCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of __task_needs_rq_lock()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-25-mingo@kernel.org>
References: <20250528080924.2273858-25-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024218.406.12439897938176648745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8039addbe5a56e4108b1bea57aa5b3f70750fed9
Gitweb:        https://git.kernel.org/tip/8039addbe5a56e4108b1bea57aa5b3f70750fed9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:19 +02:00

sched/smp: Use the SMP version of __task_needs_rq_lock()

Simplify the scheduler by making CONFIG_SMP=y code in
__task_needs_rq_lock() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-25-mingo@kernel.org
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d20fea6..82b7cdb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4312,14 +4312,12 @@ static bool __task_needs_rq_lock(struct task_struct *p)
 	if (p->on_rq)
 		return true;
 
-#ifdef CONFIG_SMP
 	/*
 	 * Ensure the task has finished __schedule() and will not be referenced
 	 * anymore. Again, see try_to_wake_up() for a longer comment.
 	 */
 	smp_rmb();
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
-#endif
 
 	return false;
 }

