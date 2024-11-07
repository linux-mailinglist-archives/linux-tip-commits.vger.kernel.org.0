Return-Path: <linux-tip-commits+bounces-2809-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BDB9BFC17
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A35B1F21A1B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28117E473;
	Thu,  7 Nov 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vb/2aVHA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bA41bc6j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E57E105;
	Thu,  7 Nov 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944783; cv=none; b=il3hA2gmbvwEtQPkYUknqW5oqS+FwPLyctSCpm4YBsJQnok6XhBHepwRON1NQK3B0Zn7MBgG6C17YDRtLGcImueuc3Mi2w0XQb3ufCItzRTyuTy8Pi6U5+LEnxzbSlqQ1YTZ09Wr45TjP9Y1OeS5PaCeP4/prOZYnMxBHnpDMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944783; c=relaxed/simple;
	bh=pHV8hEZg70yRvDUWsTxhmLbwz2IE+5o3zZNDrA1fe+Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D5HYotfs9cqppDgQYQNDRCz2m9/OcmrRKbTF8tzB4h+/dJcd1AZWsjD+5M6KFH0wcWA6qLCxPIDGLHY6+lk0IZsfFCdnAiAsH/cwwyHbbUHXsH3Bi0buolLcU9OJbDro2gRQYP01VO/7/6s7ZMVoEWePlBOfKSRzAG+WiuTtCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vb/2aVHA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bA41bc6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1T4GqAIdibo5ZxHX7nIGC53iIkGCexyS766AecxGSE=;
	b=Vb/2aVHATfCZLeDuT2XhhNO+Pykqa9N2BxTi64EduaD1q7kuYqQNCZE2WOrPjc/byPkK+8
	GTpy/4TCJKeJwWFZPzKLgdjTtO1XvH1HV40NbUI5GlQDcP+SXcqH2833F2BqyG8ie1scGk
	fJVtir6ODMb5Lo2H2Rvgk71LLVGGSlHNxRWr5TdGkjNkcxHYPgPBwU1VL4lYG1ZUtNHItL
	hCnUKSuuFhB9z1Tvk6Oxod8bmQPdDNLtYQ59CNO6EebJKIW+1nVXr77fPrbcHnkGZG3vex
	W9q1oDaUA+92EE8TgUjZXzxwl8GjODt2KAfZHTUeB+dhor3xoV41cBmDpC49Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944780;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1T4GqAIdibo5ZxHX7nIGC53iIkGCexyS766AecxGSE=;
	b=bA41bc6jwgfJ8j5AziczkPQ6TJ0EnM4V6IW+N2twbqqP9nEgYKBb0Ptr5JUmLifheRM/pQ
	ZE+cf50y0AeWEGAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Switch to use hrtimer_setup_sleeper_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C299c07f0f96af8ab3a7631b47b6ca22b06b20577=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C299c07f0f96af8ab3a7631b47b6ca22b06b20577=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477878.32228.11522617993591199118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8fae141107d4540a153efa0e2751a6fc12a13679
Gitweb:        https://git.kernel.org/tip/8fae141107d4540a153efa0e2751a6fc12a13679
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

timers: Switch to use hrtimer_setup_sleeper_on_stack()

hrtimer_setup_sleeper_on_stack() replaces hrtimer_init_sleeper_on_stack()
to keep the naming convention consistent.

Convert the usage sites over to it. The conversion was done with
Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/299c07f0f96af8ab3a7631b47b6ca22b06b20577.1730386209.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c       | 5 ++---
 kernel/time/sleep_timeout.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 1d1f5c0..6943046 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2138,8 +2138,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	struct hrtimer_sleeper t;
 	int ret;
 
-	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
-				      HRTIMER_MODE_ABS);
+	hrtimer_setup_sleeper_on_stack(&t, restart->nanosleep.clockid, HRTIMER_MODE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
 	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
 	destroy_hrtimer_on_stack(&t.timer);
@@ -2153,7 +2152,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	struct hrtimer_sleeper t;
 	int ret = 0;
 
-	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 3054e52..dfe939f 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -208,7 +208,7 @@ int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
+	hrtimer_setup_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
 

