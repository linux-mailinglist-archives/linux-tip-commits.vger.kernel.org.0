Return-Path: <linux-tip-commits+bounces-5759-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3012AD4FBE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF290175BF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258562609EE;
	Wed, 11 Jun 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jidW1O9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNm0x3U0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CE25F961;
	Wed, 11 Jun 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634177; cv=none; b=FMiZyza3lRV0HnuK0UBUOnx1iR7Fz7hxmBAS3ZY23QTPlzILZ8Us3IBMkwAz5BTc0WIuoE8D6d1DN/DlC2kkDD34csywuFVn57SgwEej4SlEjIiGSWv8ZGCy9/spyKUV7nzzxulWDfU6nYN4+VJ/9Hhe1mMH3/wvWZF7b3J3kjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634177; c=relaxed/simple;
	bh=5dwCQjNjMH42aS4jIHosjBujMf4n3go+V5xUVlRCoDg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Z3tevCpqYeE+4bQrLFLzmDALcF5JaRTmVHQki+qcR9Qk7jPjPZtekboZmCjXw2hht1u1+7X+30aa+DMDTPmkFa0TbOgFJu8KXSdwjJ98FrykPCXS5IS2o3vUcf33cKM7SkdwG+PNyd1mL5uK5B8RWKjpG1fjkb5L3p2qQtpfvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jidW1O9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNm0x3U0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Q8v3ysy2MYIH9NfrH+JmEPIDbQpb54oQ4uGytFSVgrg=;
	b=3jidW1O9i4KuR6IXYQ0Y6/pHVR6EyFkcveYiwZBabS0704yM6dSgKCBxMm1824IRg7mFNV
	rDYSJ+uYF74XT0Gg+NmVQTjQ4flSIIcXW9sDYx1W9iiYgmmd2PKizqLsjd9sfJLJxQY7wj
	6UvB8Eaq+1/mDXe8TImQn3yRnwWrxFjPpI2ZUBLoXrx1rx5UERAlPUmrQsUIubt+u1CFJB
	0YabJAOMRC80Pn9pnHmpkqzeGRoDY407+e2Tewq1Fu5Xm5sacrFcrY0JOS5OYLwWsbkZoZ
	GUpbkVLfBSuI1gwLK4mJ1B8gnWCKkr8TjUCk6imE9HCDEyKdZIZcaHs4SpGV8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Q8v3ysy2MYIH9NfrH+JmEPIDbQpb54oQ4uGytFSVgrg=;
	b=uNm0x3U01mdp32T3nr/xiDBwG9Dk8iiQ2DAzLXZMQW5AzGATbJ0OiWFuv9dzcdEsYmLwvB
	4uEhcwOlKH//STBA==
From: "tip-bot2 for Yeoreum Yun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix dangling cgroup pointer in cpuctx
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 David Wang <00107082@163.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963417288.406.5121901251939787406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3b7a34aebbdf2a4b7295205bf0c654294283ec82
Gitweb:        https://git.kernel.org/tip/3b7a34aebbdf2a4b7295205bf0c654294283ec82
Author:        Yeoreum Yun <yeoreum.yun@arm.com>
AuthorDate:    Mon, 02 Jun 2025 19:40:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:52 +02:00

perf: Fix dangling cgroup pointer in cpuctx

Commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting
bug at task exit") moves the event->state update to before
list_del_event(). This makes the event->state test in list_del_event()
always false; never calling perf_cgroup_event_disable().

As a result, cpuctx->cgrp won't be cleared properly; causing havoc.

Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/
---
 kernel/events/core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cc98b9..d786083 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2120,18 +2120,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
 }
@@ -2488,11 +2476,14 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_EXIT;
 	if (flags & DETACH_REVOKE)
 		state = PERF_EVENT_STATE_REVOKED;
-	if (flags & DETACH_DEAD) {
-		event->pending_disable = 1;
+	if (flags & DETACH_DEAD)
 		state = PERF_EVENT_STATE_DEAD;
-	}
+
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 
 	if (flags & DETACH_GROUP)

