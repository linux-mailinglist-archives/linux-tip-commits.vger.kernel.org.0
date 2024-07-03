Return-Path: <linux-tip-commits+bounces-1589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29792690A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D405B22631
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083719005B;
	Wed,  3 Jul 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e8emhiFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBB7D3tj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359A1849D2;
	Wed,  3 Jul 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035382; cv=none; b=BcxTg/7oJaX6DSsoW0XFP/BZH6/FCidzELu47+zr8LNmV8QS4y6dAX1DylMF0c9eqkASfTjThsLRVd6l2C88UxUrp7hSFFmOuTa6EIjsciMZtveW7wVldiUiaw1EWWM+lIJVj73vq8oP9NHTnqpu4/zHt359hSNOcVi4LgDTTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035382; c=relaxed/simple;
	bh=cyov/uXH6nAW3JfR+A9pDGautkIvBvuRb6Vha5Kmiug=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SJoX/XD/8xKcE26kMM7+ZA2Nyrh2p1dC8jWf/IT7QXe8xefSLpDInziNIAi677WtW6n8MWQAA6dHNiKZC178rxHPqKEBrSPOFo1d67yO4IDeqP0GcYROrUMgsplEQsxw5O2Ed2TTFPXH90MuYMxZG/kBPswzgLHYVuuCXXDNEoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e8emhiFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBB7D3tj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IXwKPSYDMuupaRkOYPcllYwSbvPtAPr2jwAVJ5t4RQ=;
	b=e8emhiFGuUm9EH2ykSQ4uqlO38H+hcqEexeq8DHfmAtfXN/zPqICk9xnFenzVO4QhZ+w8z
	/2aVCKflYbAb2j7jN6xTWET/rRAF9CGTpHxgf0vKy/7iDzU0kGPwQkMZCrbfD0TkidToun
	Pmw/XuQZtEofpMIulzPrqlF3kU7NWtxRDkuz2ew1xtmDFnyRoGnd4GsRweJXxx/k2E6WOH
	y252mb97MNDDHtBVJ84jqWV2Pt8b7xW0fhirpxm7QOvoTsidguYEhBIDUrhTslH+uOcFG3
	G7xGVQPTIqDNaiLYUHhIGT2s9t2OPNRHg+Brdo5L1Ugu0sZIvbTzeXGCjBTkSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IXwKPSYDMuupaRkOYPcllYwSbvPtAPr2jwAVJ5t4RQ=;
	b=wBB7D3tjDywehvJrDgM4sfSJXeKI3N0BvLWS1Vs3WxrZKHkcjHnxfBJc7f7Tu+38NWTmuW
	lxbUx60ocutMZ1BA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Combine WARN_ON_ONCE and print_once
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610103552.25252-1-anna-maria@linutronix.de>
References: <20240610103552.25252-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003537827.2215.3767578007917654423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     59dbee7d4d59425658b1d86238732c575216b718
Gitweb:        https://git.kernel.org/tip/59dbee7d4d59425658b1d86238732c575216b718
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 12:35:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:32:55 +02:00

tick/sched: Combine WARN_ON_ONCE and print_once

When the WARN_ON_ONCE() triggers, the printk() of the additional
information related to the warning will not happen in print level
"warn". When reading dmesg with a restriction to level "warn", the
information published by the printk_once() will not show up there.

Transform WARN_ON_ONCE() and printk_once() into a WARN_ONCE().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240610103552.25252-1-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 43a6370..753a184 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1026,10 +1026,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
 
-		WARN_ON_ONCE(1);
-		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
-			    basemono, ts->next_tick, dev->next_event,
-			    hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
+		WARN_ONCE(1, "basemono: %llu ts->next_tick: %llu dev->next_event: %llu "
+			  "timer->active: %d timer->expires: %llu\n", basemono, ts->next_tick,
+			  dev->next_event, hrtimer_active(&ts->sched_timer),
+			  hrtimer_get_expires(&ts->sched_timer));
 	}
 
 	/*

