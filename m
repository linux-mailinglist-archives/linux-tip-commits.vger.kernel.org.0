Return-Path: <linux-tip-commits+bounces-5781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D5AD8454
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57A63B4A2E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E22D29AE;
	Fri, 13 Jun 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+PPTjRQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOus5mY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234662D1925;
	Fri, 13 Jun 2025 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800229; cv=none; b=A9moBjdGeulrP3QIA88ScMjdVmT3Dz8zqrZEYDuEIRgDWiw99LUiDJnUqhV8AcQD2ytKAfcVtdWcfGQ2Sk5UiFSwmK7tkvkd/SQgjQ95OFxotV4LBNWyeaAhIXD7X/neyJYeBuA0YohDQy9E+MUd1LycrmaYVk4DefZ1BPhu0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800229; c=relaxed/simple;
	bh=eKHDxCGKB22JUn8UNy/Sz4gVpfyDQv63ufaCSOOJpBU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zym4GHEhPzaDOydA0PIxk3hhsBtzw2YbhbvYKQ7e8rxThGxMPIy/zFPqamkQst0w62VqoZg6gDk5oTwZTnMG2+Jiabd69x/YHQgigqd1nUiUOSbUqiWd21On4QJJuHypPIWYkoQzYWy4SuJbaQ9eObmGs5gWWCUABtlp94+0aUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+PPTjRQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOus5mY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpwjr4He6l2OUAOaNxnfwQLxYlrYUHvbKkzuYmGXz+s=;
	b=O+PPTjRQnmmv+lu9dcbsxbzjbFgCQTBKSTwM1E6diCDNxe2iRoBGHBXlFZ9yzpvnWgYdG7
	IUMO+uf7+lwChXggZFBWjg+6UbEMvOfP3N2Zbm1xO86CTa+jJR/ZIVsQfyrsMQKUozluIt
	IZhSbJe5OVZwup3sJHai7WtKzM6iy0KCzqzRa1+dn8HcPKTs/3uzlOFb01nDYO/ZjMfGnd
	0ia74SU1j3HrItUsJLelXyqTNSWuBuW5Fi6//frGE7cJHxNW6spNMAQlFy8VqCa/N06nkg
	LNntbcT/SHW3L9y6ho8GvxkwJ3STUG6nJ6jI1ayCIaiErBZz1c84FnixTcm4JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpwjr4He6l2OUAOaNxnfwQLxYlrYUHvbKkzuYmGXz+s=;
	b=wOus5mY5YCr9TRndd1sAGKI99thwlxfU1Qhm6CVqRTNk3ccjpqtvwL7a2hV83tzhdjdRtE
	McSPCS+/QH4q+YBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of add_nr_running()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-43-mingo@kernel.org>
References: <20250528080924.2273858-43-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022539.406.10215245782977967932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc75ac3c918d512952f7c132ef635cedfc4900a6
Gitweb:        https://git.kernel.org/tip/fc75ac3c918d512952f7c132ef635cedfc4900a6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:23 +02:00

sched/smp: Use the SMP version of add_nr_running()

Simplify the scheduler by making CONFIG_SMP=y code in
add_nr_running() unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-43-mingo@kernel.org
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 45245f4..aa08103 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2673,10 +2673,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 		call_trace_sched_update_nr_running(rq, count);
 	}
 
-#ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2)
 		set_rd_overloaded(rq->rd, 1);
-#endif
 
 	sched_update_tick_dependency(rq);
 }

