Return-Path: <linux-tip-commits+bounces-4237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C4A64433
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ABC3ACC44
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F95219317;
	Mon, 17 Mar 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vd/mvsfm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7AspckAM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A38F5C;
	Mon, 17 Mar 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197653; cv=none; b=J+ksRZnEokx9wCFmX4mpqgMPCZThhKaVEJtFf4JhnGcCX+w1QLU7RgPL1QbbiLAZl9fvSd16Vyf6oJPhS5sE0wtMlKRmVLDpHCkGOieg/5AROXH7RROwtevHWP8f80HVblpJCQYJRZWPE74ywsttTQQZe6JL2o+2CsYWnGjrBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197653; c=relaxed/simple;
	bh=J3XKG9BbwjucKQjJf1aLxigaBlT/GGjPaSyGokWnxBg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l6S6T/NhqSrIHZTk/j6ohw5JBMeAzzR/v7EvqgIUSAEKkuf4QbL56IxEB9yfOPaFgV/sXiNnCjY/eYeOiuUo9UOzlQV2H0Lz0NeJSymqJ02ltitGsKJ+qR5Ushn3JmoYzl3WL4+YDqe2WgkX6HEy2LK9loO5mFiiBltu+CmIbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vd/mvsfm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7AspckAM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 07:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742197649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MJhWwnCe+FHABOWvaTeRXQ8YwjLyhH4AXVvGTGzKZ4=;
	b=vd/mvsfmrgEQdCIjj/7i1RywYkmbddCBqAimzJ3MU+ndgO3D2p13VyNiIlNz3SCjU8qwjl
	z9/6bOhZ6Jk0wBBQ0v6/EA3k9RhKCD3PYk7gh7vdJ4Nipo2k88QCR6q4MG+xjd9FcBjAKR
	xEUXNyWGgmL+O0h6j8+dmTYRJzeurXKCltHbQpqT5ZAFwPtVnu+13VJ/HV6OeH6R6B8xZ9
	PD9+lW3DOM8S3BDT5Iq4/4l5fC1LQN3iX1knHEO0v3h44ZyrGr2/cqUHA/qP+A3BZVjc25
	jr0iC8nmJY3E34qaDWW8NrZ4n6MLNchsNPs6J5p1S/zEZV0QMksu4q9aHfd4nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742197649;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MJhWwnCe+FHABOWvaTeRXQ8YwjLyhH4AXVvGTGzKZ4=;
	b=7AspckAMG8+C9K9X4PEmPa2ihEPQZmMPa78hvaEOaNYsH+SbsQgO1pvEg7S6Tisdl8GjJY
	+j7Znugnp/XWDlDA==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Use POLLHUP for pinned events in error
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317061745.1777584-1-namhyung@kernel.org>
References: <20250317061745.1777584-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174219764913.14745.17811346871050746363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f4b07fd62d4d11d57a15cb4ae01b3833282eb8f6
Gitweb:        https://git.kernel.org/tip/f4b07fd62d4d11d57a15cb4ae01b3833282eb8f6
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Sun, 16 Mar 2025 23:17:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 08:31:03 +01:00

perf/core: Use POLLHUP for pinned events in error

Pinned performance events can enter an error state when they fail to be
scheduled in the context due to a failed constraint or some other conflict
or condition.

In error state these events won't generate any samples anymore and are
silently ignored until they are recovered by PERF_EVENT_IOC_ENABLE,
or the condition can also change so that they can be scheduled in.

Tooling should be allowed to know about the state change, but
currently there's no mechanism to notify tooling when events enter
an error state.

One way to do this is to issue a POLLHUP event to poll(2) to handle this.
Reading events in an error state would return 0 (EOF) and it matches to
the behavior of POLLHUP according to the man page.

Tooling should remove the fd of the event from pollfd after getting
POLLHUP, otherwise it'll be returned repeatedly.

[ mingo: Clarified the changelog ]

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250317061745.1777584-1-namhyung@kernel.org
---
 kernel/events/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2533fc3..ace1bcc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3984,6 +3984,11 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+
+			if (*perf_event_fasync(event))
+				event->pending_kill = POLL_HUP;
+
+			perf_event_wakeup(event);
 		} else {
 			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
 
@@ -5925,6 +5930,10 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 	if (is_event_hup(event))
 		return events;
 
+	if (unlikely(READ_ONCE(event->state) == PERF_EVENT_STATE_ERROR &&
+		     event->attr.pinned))
+		return events;
+
 	/*
 	 * Pin the event->rb by taking event->mmap_mutex; otherwise
 	 * perf_event_set_output() can swizzle our rb and make us miss wakeups.

