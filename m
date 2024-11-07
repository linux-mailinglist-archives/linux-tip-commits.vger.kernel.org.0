Return-Path: <linux-tip-commits+bounces-2806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3F9BFC10
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910AF284110
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8F29D0C;
	Thu,  7 Nov 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6+3Bbv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AjdyUAXY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877914A8B;
	Thu,  7 Nov 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944780; cv=none; b=S+9bNyBY5V6uaSvmnjC+hqhwE4TT+eCDDsyF02P6aU7CsoxJcIBddwLXz4yfmEh1im6V5CkHPUCzUljeGfSpDcGllldNma5jFHIPdMpIGmErdmuKbLsSG/SoVrd3LrPCVM9mR+veELeyM/ehPt3wfOqqwY7z2w3ydehjry95RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944780; c=relaxed/simple;
	bh=WEKSH9gXLFkHfbJ7Abnmy4aVWjx1Fk1so95TBmdUFwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jy8xfqlAH2xko1BEz6eoshiuWOp2yg4w3Sz/Oh2ugIy4nbwocU6yk4RFHDwq3zQUF53w9CQaaD2yRjHTcCatveiL+O/A5DvutU+VGDL8UoV3lapLaM603+lIjUtl1ICoPnkAKp6bNZJy45+T4E2P8w5Om5J1xZHSDxpX39hTii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6+3Bbv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AjdyUAXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7POTU3oVOXCUmfm40J0IVZX+FNlQ466nz6UxjMEUPo=;
	b=D6+3Bbv5TjEF5cLW/wqsgWHbYq+r1tX9WC9WfwEm+RWqBolUWqsAyOUFjMkxkekxyzWnJc
	N0TmyA81XhiQt/zmftS0gd0xpzItirewkH6bjIAc8+n+1wmeWSo48jbYDuSIBitd6ZmNhs
	gTpJNviNsxp8SAseexxbXmRTfpZ5OO6feFPg/rpx0PS+PwwnSvO9G1RyQAfN+Gz0JQbLgE
	oy+qV1VdyibbYnFABT+jw0km2vm35HfrUJs5WJfrmRA4tCXa5kyqzOmbn2HKn/9Qd9LS9q
	/vdmImfLxtpQwNgTEr2jZOPGRm1ofzY2hZgO+2W/NywvzXArhVUyRrom+Ftpkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7POTU3oVOXCUmfm40J0IVZX+FNlQ466nz6UxjMEUPo=;
	b=AjdyUAXYDD++vlA9lMpDl4LkjnJ1DxBiCfmKwES9DqHcbcPM9WonOEsJ2c6xtQmeVbAN8p
	fMKOV4bVdIc9yYBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] sched/idle: Switch to use hrtimer_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C17f9421fed6061df4ad26a4cc91873d2c078cb0f=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C17f9421fed6061df4ad26a4cc91873d2c078cb0f=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477681.32228.9615470049280135388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     46d076af6d640774a7a8bd6ebf130c22913d3bdb
Gitweb:        https://git.kernel.org/tip/46d076af6d640774a7a8bd6ebf130c22913d3bdb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

sched/idle: Switch to use hrtimer_setup_on_stack()

hrtimer_setup_on_stack() takes the callback function pointer as argument
and initializes the timer completely.

Replace hrtimer_init_on_stack() and the open coded initialization of
hrtimer::function with the new setup mechanism.

The conversion was done with Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/17f9421fed6061df4ad26a4cc91873d2c078cb0f.1730386209.git.namcao@linutronix.de

---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d2f096b..631e428 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -399,8 +399,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function = idle_inject_timer_fn;
+	hrtimer_setup_on_stack(&it.timer, idle_inject_timer_fn, CLOCK_MONOTONIC,
+			       HRTIMER_MODE_REL_HARD);
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED_HARD);
 

