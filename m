Return-Path: <linux-tip-commits+bounces-4755-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1AA81563
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE4B3B6188
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE332528F0;
	Tue,  8 Apr 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtfXY2tY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KT4ZTH7V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C024886B;
	Tue,  8 Apr 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139107; cv=none; b=AXJnliifvHAILTRTXNyiv1fKE71xmHiU8ySIWbnyp3kfwtCutDTUwyhY4Vdri5V5sQy0wtDErlJ2WyXicQ8oTdIpLRWia/TyQivcTTW4D40rbq3kEaf0rZIqn9A5Yk2jif3K7Capf3GxrvLBt4iSpNlRoqTrY7GZ/DaT7UA3TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139107; c=relaxed/simple;
	bh=OwHffWNXMjNE8Q92IWOo1aAQ6lSfMPCxYzJZMAOoQx0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p939fT4530dhmG8mtmtI+S/gP8iS8mwk5a3JrC/mmdfttGq9HUS3d+0EypRo3rih6h2uZNec58ohgAp96kl3AxuitHrbPIoBcwXfHfmoN7vWs07xJUuLer6oIMvCZf0ke2uaKKufCE8LWFZgQWtv+vr1kzYu4q9rwZmijYZDVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtfXY2tY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KT4ZTH7V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPIW5Nc8GbEvgmg68fmBJkt8GRoUbiDH2U8xXJgdOSg=;
	b=CtfXY2tYGuTyg1Ik9MUKoGwuP/w+nTLiR8bhO2WKczfu79EeoA27LGHuomos32YVq82yAX
	nGg1zWUR7D51WSaMZHACl2Msk9gBcx1bHrjxysfS8QNX5VdGRsuUWY+N82rCGNhZBjyPKS
	HDx1RgdzzHoT6NUl/KDw2TICIDxr9vdrefMYom36LQztI0QRf6ASutCDaUK7/49wiqYail
	GHXKuioX4E/b/oqZATPC5ny+eDL3d/eNw5JjQmgYnpCmKhPEOsIbTZYwjYrJK0AG93WJ8y
	zfjtr6/PEj0C5FBduRTnbPtZkLawpN97wyOCPLeIkCqyuRWCVfp6E+zd/WEIog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPIW5Nc8GbEvgmg68fmBJkt8GRoUbiDH2U8xXJgdOSg=;
	b=KT4ZTH7ViInS5x+W7XMLtADztCYdd7ZOH9JlLVn5MioZidEzHbHjQjQLPQsjOLm+j1dFrg
	r/egzfojjaUpjLCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Simplify perf_event_release_kernel()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193723.151721102@infradead.org>
References: <20250307193723.151721102@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910331.31282.6556072278526735885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e8671e00e57b3d006ed8ae5ef055807506e44b2
Gitweb:        https://git.kernel.org/tip/3e8671e00e57b3d006ed8ae5ef055807506e44b2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jan 2025 15:31:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:47 +02:00

perf: Simplify perf_event_release_kernel()

There is no good reason to have the free list anymore. It is possible
to call free_event() after the locks have been dropped in the main
loop.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193723.151721102@infradead.org
---
 kernel/events/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fa6dab0..f75b0d3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5696,7 +5696,6 @@ int perf_event_release_kernel(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_event *child, *tmp;
-	LIST_HEAD(free_list);
 
 	/*
 	 * If we got here through err_alloc: free_event(event); we will not
@@ -5765,23 +5764,23 @@ again:
 					       struct perf_event, child_list);
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
-			list_add(&child->child_list, &free_list);
+		} else {
+			child = NULL;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
+
+		if (child) {
+			/* Last reference unless ->pending_task work is pending */
+			put_event(child);
+		}
 		put_ctx(ctx);
 
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
 
-	list_for_each_entry_safe(child, tmp, &free_list, child_list) {
-		list_del(&child->child_list);
-		/* Last reference unless ->pending_task work is pending */
-		put_event(child);
-	}
-
 no_ctx:
 	/*
 	 * Last reference unless ->pending_task work is pending on this event

