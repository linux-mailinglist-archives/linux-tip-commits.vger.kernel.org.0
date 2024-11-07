Return-Path: <linux-tip-commits+bounces-2820-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817519BFC2D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EA42827D3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03750198E77;
	Thu,  7 Nov 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R46gcOBs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzUfhIhi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29919580F;
	Thu,  7 Nov 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944790; cv=none; b=Vqs1e4FD//iPoH64Om7jHpx/LEcPIwh25j0+S5fxfVGg9jE6JH+wGr2+yRk8fh+AKQAeJcF+xs7fAopiEuBvGFE7Zgk7FbaIACqE0CN3ZV/MIpDm/8Sac4h0d4VfnSli2YX3pDtSzCRqJ2bEfghOEgKBYXMFAzgxi3tWMBul5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944790; c=relaxed/simple;
	bh=w9gSU+/HrNSADsKZGWP80Hybk4NfjjEZ1GmYYpPeD8g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BcUaAzur/PrjpG0odR97RWNxs43sykuvNwO+O/2pFJSme/ooskwm8/qgc6IuhR+Jyc2fKY94HA5AeoO5knBwG1zeCjAxC+FJd8kytd12hRZB0DHomny3g/xnHGQobxdOfIz1pV1FlFU+y9zDOe9K3+n0LsVekVE7zy6qu/gW2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R46gcOBs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzUfhIhi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDswLsdhFohehK7Z3m+hb1OC+kk2/GFvcDHs+M69O90=;
	b=R46gcOBsDM/gtD1jothB/csN7yQkCNGzA2bIQQoeVoa//PQ8vWnfS9ai9qWL6RcuAzbLGi
	Mooew6Gy9cuZxv4ED5CqjEhRLyXfNfAT3vGZzlgyXwZ47bEbWECrVtr4yP0eXmbD1s9iNq
	t5YJHmo7rRhrgWj6/GrONeCwMH7MsktzVo55atR0JJilIL8VKGbMiFUMXj/BYFNxpjZJQm
	9tJaRYL5GzoT7+d9Oz5DNYeDndURQVC/8o0TW0HFpaqoU27B/PnzPBiJJ0TWbwaVPst4kd
	+kSxXjQySGqOucYL6Qvn7fr67WCbv7UiKOQAKaI3ZJjbF9s4m5p++osVnMnk0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDswLsdhFohehK7Z3m+hb1OC+kk2/GFvcDHs+M69O90=;
	b=yzUfhIhiBw3LLuVy70l3UU/p4RzzdAYSznLYa1TqNnws6sUe78P2oITo0IPbNrD/tVuky/
	fkBNSRxB3lqc1HAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] drm/i915/request: Remove unnecessary modification
 of hrtimer:: Function
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C50f865045aa672a9730343ad131543da332b1d8d=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C50f865045aa672a9730343ad131543da332b1d8d=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478690.32228.794880718976009614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     482a483cfe5bafeb5408532321cd607bae127a2b
Gitweb:        https://git.kernel.org/tip/482a483cfe5bafeb5408532321cd607bae127a2b
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:04 +01:00

drm/i915/request: Remove unnecessary modification of hrtimer:: Function

When a request is created, the hrtimer is not initialized and only its
'function' field is set to NULL. The hrtimer is only initialized when the
request is enqueued. The point of setting 'function' to NULL is that, it
can be used to check whether hrtimer_try_to_cancel() should be called while
retiring the request.

This "trick" is unnecessary, because hrtimer_try_to_cancel() already does
its own check whether the timer is armed. If the timer is not armed,
hrtimer_try_to_cancel() returns 0.

Fully initialize the timer when the request is created, which allows to
make the hrtimer::function field private once all users of hrtimer_init()
are converted to hrtimer_setup(), which requires a valid callback function
to be set.

Because hrtimer_try_to_cancel() returns 0 if the timer is not armed, the
logic to check whether to call i915_request_put() remains equivalent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/50f865045aa672a9730343ad131543da332b1d8d.1730386209.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/i915_request.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 519e096..8f62cfa 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -273,11 +273,6 @@ i915_request_active_engine(struct i915_request *rq,
 	return ret;
 }
 
-static void __rq_init_watchdog(struct i915_request *rq)
-{
-	rq->watchdog.timer.function = NULL;
-}
-
 static enum hrtimer_restart __rq_watchdog_expired(struct hrtimer *hrtimer)
 {
 	struct i915_request *rq =
@@ -294,6 +289,14 @@ static enum hrtimer_restart __rq_watchdog_expired(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static void __rq_init_watchdog(struct i915_request *rq)
+{
+	struct i915_request_watchdog *wdg = &rq->watchdog;
+
+	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	wdg->timer.function = __rq_watchdog_expired;
+}
+
 static void __rq_arm_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg = &rq->watchdog;
@@ -304,8 +307,6 @@ static void __rq_arm_watchdog(struct i915_request *rq)
 
 	i915_request_get(rq);
 
-	hrtimer_init(&wdg->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wdg->timer.function = __rq_watchdog_expired;
 	hrtimer_start_range_ns(&wdg->timer,
 			       ns_to_ktime(ce->watchdog.timeout_us *
 					   NSEC_PER_USEC),
@@ -317,7 +318,7 @@ static void __rq_cancel_watchdog(struct i915_request *rq)
 {
 	struct i915_request_watchdog *wdg = &rq->watchdog;
 
-	if (wdg->timer.function && hrtimer_try_to_cancel(&wdg->timer) > 0)
+	if (hrtimer_try_to_cancel(&wdg->timer) > 0)
 		i915_request_put(rq);
 }
 

