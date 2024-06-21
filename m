Return-Path: <linux-tip-commits+bounces-1481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9332912B35
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F7828678D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFD15FA8E;
	Fri, 21 Jun 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lx/w5SXO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/d99FCPl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066F10A39;
	Fri, 21 Jun 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986840; cv=none; b=Mtp0l5MLMXN4C1M6ANK60ME1kdBzV3b1hq+hsqMo14WdfuLvcLlPBEsjt74vinaWfndQOVqSF3kNhOjRqs7kIqDR4RaBKE8HbTr2A5LR9PTVs5Vvpgvfkr+TQ7VoYtTxtif1LFxkIRLysOM1dK1BFDc4rbD3O5+eRFidKuZtRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986840; c=relaxed/simple;
	bh=HnlV+cCTqaM4UP3kbIjZTe7DLXPO/focsR5atAj+r/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FxnOoJpHxJxBWZXK6ZMJbh27REku4pjn4vgvFZCgCcP9sQDfrhUCVd8PNxmYL5bBfeGg75/9kGepbcJp7gKpLgiqrCt/kWORbrHOM/sSD1evUXzy3ftHwcOlmk1nu4leXdxxUe65Rv1P64nqE53s/stgVuSdarvSqXejGU/ohnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lx/w5SXO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/d99FCPl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 16:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718986836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUM9AB2A6NZHBScDO+eWQXzQBNFBuUmgXo6HlCZ81pw=;
	b=lx/w5SXOUTtFGJxxXIesU8uZWQkDj0Ew196zucK/BXq8VrJrjlL5mfuIkKE4kWEUlL6hqu
	yD0XZR2SI29dgel8imxfp/6tBdGENx0rI+YYpNGG4Zc2A4UFdp7ehbcgpNw/LQ/TPgugVR
	0NvENYthJBtKODrTqzR46r9evLtCp8uYb7u8aU+jBbnhZA168ILf9ijAE4TgQBzk0bzdCz
	d4iAqMYBDQ90CMwXyaTjGcSm1T59UpjSc8tMNNxjJaK/TmA/grKsjqNNUKhwRGDxOtwm0Z
	wGRLjnAwhXrmpYnrjuw+oR3ly2YlMKjdFrvEy+TXmyhlNq6XCumw94CHUPAXIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718986836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUM9AB2A6NZHBScDO+eWQXzQBNFBuUmgXo6HlCZ81pw=;
	b=/d99FCPlUA38y63pY2o9fPfGC2M3Z2E8855sCjqFCUugfWxX0H6OclXJNhD/WVlPcgvbX4
	eSb/v9l+WFgJg3Ag==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Remove unnused tick_nohz_get_idle_calls()
Cc: Christian Loehle <christian.loehle@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240617161615.49309-1-christian.loehle@arm.com>
References: <20240617161615.49309-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171898683609.10875.9584736500010182191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9403408e122628a6dc7154a95716f00dae3747c7
Gitweb:        https://git.kernel.org/tip/9403408e122628a6dc7154a95716f00dae3747c7
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Mon, 17 Jun 2024 17:16:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Jun 2024 18:10:15 +02:00

tick: Remove unnused tick_nohz_get_idle_calls()

The function returns the idle calls counter for the current cpu and
therefore usually isn't what the caller wants. It is unnused since
commit 466a2b42d676 ("cpufreq: schedutil: Use idle_calls counter of the
remote CPU")

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240617161615.49309-1-christian.loehle@arm.com

---
 include/linux/tick.h     |  1 -
 kernel/time/tick-sched.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 4924a33..7274463 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,7 +139,6 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
-extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792c..43a6370 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1385,20 +1385,6 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 	return ts->idle_calls;
 }
 
-/**
- * tick_nohz_get_idle_calls - return the current idle calls counter value
- *
- * Called from the schedutil frequency scaling governor in scheduler context.
- *
- * Return: the current idle calls counter value for the current CPU
- */
-unsigned long tick_nohz_get_idle_calls(void)
-{
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-
-	return ts->idle_calls;
-}
-
 static void tick_nohz_account_idle_time(struct tick_sched *ts,
 					ktime_t now)
 {

