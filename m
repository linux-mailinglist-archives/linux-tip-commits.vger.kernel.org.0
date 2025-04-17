Return-Path: <linux-tip-commits+bounces-5038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8DA91D2C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0873A8154
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E97178395;
	Thu, 17 Apr 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TsIIVCCr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dWTNyHBM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A88248875;
	Thu, 17 Apr 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894896; cv=none; b=feMLHaCDxsJt4R7Hsfna0te/vLJSdhdULfUErBp79l1mZZtteCOwe0pgy/mOP+I6x/Vpf5yhly5W3s0FcwDnWKZq85hlltTtFmQ3MPnUcJtKCMaz6W3MBb8ICSayZ2IhfaSN6jqxZr9qw7jiYUQmfBDfQ2npSbjShQR2D6qaU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894896; c=relaxed/simple;
	bh=tafaz74ehmp1/FoXgCRfcPNHoJbD6rhSVj7NjYXXlLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QNp8wsDdRxzH2JBO6o02wEjonu5jQg74bPSn1bCB10YC5YnySjnkIbLCBt9o3UGeLTwSh8EtibaVj0iNitkoGxajM4RQaC0CncMT9btOWkaWKOHFJzTuVT0eS+FKsBTtcjz+LGcLQL/HQcq5piScqaz/u6yiSrvYb4wN7qb86NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TsIIVCCr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dWTNyHBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSX3Hg6GLRH8S5QQhlbq6hwUoe7wc3SuRIDP7P1LH4w=;
	b=TsIIVCCrVphnyzAhiQ07Eoco85Dit/Hu6KvE9EiL2jQ12y4qah2v90BmBvue5NkXGe4pZu
	u91qZzdtY3fAazRyB9+FQuN0rNlOd1sNyeF3D1QQJAJhtbJK5dcjLVXZTOaIlf19DIvQbT
	yMhvZQ/5OaeH24K6sOc4H08jvxblFanVV+sJExhnrvKdz4qrDvjNeCs+UvUg5b17FewN2f
	pHu3XwlXvsx/GsymrJDwXzGkDc5B9ePlbkD0kpLSklXFCW/VDP8uBoBlCIVyOVRCfHFuv6
	dqWsndOdIiINOCCbshwXD4qldOcPH+kgAdjvWEGRzZNQDSQuyXZNkztgf9F5Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894893;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSX3Hg6GLRH8S5QQhlbq6hwUoe7wc3SuRIDP7P1LH4w=;
	b=dWTNyHBM5h+xewHkiRAUwH4KEM5n8/zUTpwY1EUvNTXt/I4xGHg8bJb8dV6BVcdAi4Zy9J
	cWwPndriMu2Z2tBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix event->parent life-time issue
Cc: kernel test robot <oliver.sang@intel.com>,
 James Clark <james.clark@linaro.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415131446.GN5600@noisy.programming.kicks-ass.net>
References: <20250415131446.GN5600@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489287.31282.14109913010573391981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     162c9e3faf58eef653c74d0c774e6583d9225467
Gitweb:        https://git.kernel.org/tip/162c9e3faf58eef653c74d0c774e6583d9225467
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Apr 2025 12:12:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:15 +02:00

perf/core: Fix event->parent life-time issue

Due to an oversight in merging:

  da916e96e2de ("perf: Make perf_pmu_unregister() useable")

on top of:

  56799bc03565 ("perf: Fix hang while freeing sigtrap event")

.. it is now possible to hit put_event(EVENT_TOMBSTONE), which makes
the computer sad.

This also means that for the event->parent == EVENT_TOMBSTONE, the
put_event() matching inherit_event() has gone missing.

Previously this was done in perf_event_release_kernel() after calling
perf_remove_from_context(), but with it delegated to put_event(), this
case is now entirely missed, leading to leaks.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/oe-lkp/202504131701.941039cd-lkp@intel.com
Link: https://lkml.kernel.org/r/20250415131446.GN5600@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1a19df9..43d87de 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2343,6 +2343,7 @@ static void perf_child_detach(struct perf_event *event)
 	 * not being a child event. See for example unaccount_event().
 	 */
 	event->parent = EVENT_TOMBSTONE;
+	put_event(parent_event);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -5688,7 +5689,7 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent)
+	if (parent && parent != EVENT_TOMBSTONE)
 		put_event(parent);
 }
 

