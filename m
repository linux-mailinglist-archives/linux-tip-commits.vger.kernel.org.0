Return-Path: <linux-tip-commits+bounces-5101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9DA9817B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Apr 2025 09:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D23E3ABE3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Apr 2025 07:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78024467C;
	Wed, 23 Apr 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXaK4xK+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEd2fGcR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6C20E70B;
	Wed, 23 Apr 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394424; cv=none; b=s/IUaYQtovtuUVcot/FvxISsrfxfIEXi4TslCK/YxJQbKipJ3H0wSKl+hKRW0dNztH9lQbupD8ShQL61DcT1LtRbi3CuqJtujiOdqnIcaJwOZibAyJ9KmaS/zND4o5EeA71+Mm6z5+LyYmQ/Wv9M6iP4zBnGDLsg0M6z0tqYd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394424; c=relaxed/simple;
	bh=ZZLcZ/gK84AuMRGVAcTNROrmA2S/Lkekv5uKPhJHzvA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hGN3I4srQjRgX7DTspUw6bASRQxqMXyZOqKTXj6Sc2Y1CNW5pMu850mR58k8AQdxgdCXM1ijjLXV3V6/dqPrHTe5txv0Z0T103vrYDHWnyz4meTS9MB1a9dLEAa8F0VbYhsKJpqUmmasBXDxSnLlr5UP+upSlWFajkBHpHs5n8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXaK4xK+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEd2fGcR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Apr 2025 07:46:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745394420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZOordCAjLPJq3gqoTnFGYn04Zi3ZKgMnFY3eSXDI04=;
	b=VXaK4xK+ox44KA17Co0cxIcG7SbMVlkpdfkCX3I7nvkjxEPpFOdAGjm7NMIrSK1zFLd2eI
	vJhu+o/JTOfW/bcrU62haqI+kOatQ2RX7Lw0YTFqK1IqULHKPvM7JvwX+WLPIaoRQNbbzy
	bHRzkNqnatU2F3Wku7iN0fTiiFBEBXSKT8O4EwpxnQBlCh0YviTxljrJlz3pel5eR0WRLS
	wbsuF8NmlGNKzTVA5osAKge9HN23NgDtRdRg2qymvfVnfvzo2BOk4xnyXzMgTcDIgOW+rp
	dbzsW5meOl8EV9JgopjJ2yzv1rdwZdxXhZcWdVQiMH/qnhmVxoyrjBaM6u9p9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745394420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZOordCAjLPJq3gqoTnFGYn04Zi3ZKgMnFY3eSXDI04=;
	b=JEd2fGcR1Wi34ML2Wqde/c5/WjL58jMiBTNOys+USLQuRqXS36rOb1+teXdy0GhoIp4p+e
	iVDrDDjZU5pbYJBg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Change to POLLERR for pinned events with error
Cc: Gabriel Marin <gmx@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250422223318.180343-1-namhyung@kernel.org>
References: <20250422223318.180343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174539441547.31282.3071132411377381637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0db61388b389f43c1ba2f1cee3613feb4fd12150
Gitweb:        https://git.kernel.org/tip/0db61388b389f43c1ba2f1cee3613feb4fd12150
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 22 Apr 2025 15:33:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Apr 2025 09:39:06 +02:00

perf/core: Change to POLLERR for pinned events with error

Commit:

  f4b07fd62d4d11d5 ("perf/core: Use POLLHUP for pinned events in error")

started to emit POLLHUP for pinned events in an error state.

But the POLLHUP is also used to signal events that the attached task is
terminated.  To distinguish pinned per-task events in the error state
it would need to check if the task is live.

Change it to POLLERR to make it clear.

Suggested-by: Gabriel Marin <gmx@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250422223318.180343-1-namhyung@kernel.org
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e93c195..95e7038 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3943,7 +3943,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 
 			if (*perf_event_fasync(event))
-				event->pending_kill = POLL_HUP;
+				event->pending_kill = POLL_ERR;
 
 			perf_event_wakeup(event);
 		} else {
@@ -6075,7 +6075,7 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 
 	if (unlikely(READ_ONCE(event->state) == PERF_EVENT_STATE_ERROR &&
 		     event->attr.pinned))
-		return events;
+		return EPOLLERR;
 
 	/*
 	 * Pin the event->rb by taking event->mmap_mutex; otherwise

