Return-Path: <linux-tip-commits+bounces-2579-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A99B0C6D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF89B280F82
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28E20D4EB;
	Fri, 25 Oct 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGPqvgU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zw/RQekK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D35206505;
	Fri, 25 Oct 2024 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879279; cv=none; b=WP8r4/MglbD6oXETWT4uZia6g63re5gmW1lJEX9XETVX/o5q4kL6VchBRHPcEPSjGtBpEXgOfg1QVxNa76Jg0Yp1TnDup3uPFITDg6mt0BDhSA2d5dhEwihRKm6TdUmrySH+swx7r1FawJ6M9aC9pIwNPaGmkEbO4YtFhhisorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879279; c=relaxed/simple;
	bh=Ctxfm/R1vlLe/z/loP7hmDFcnDy6IeDhsJrQMZpgkiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qdXX8vHIRQS0vS8+xwOlfuUzWT2zWsAPkMpk7vJEWqdor0uwEBXIa0tjmjh4/r9v2KTT1pKl6HOY72i98HV4OFMJb4LfsSSYHJx2ETBopoS4idVRXs+5y+GYINCnWCS1vttGmdkEQxwU30e3zWaphYRxfpsJYANAPor6NJj0DsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGPqvgU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zw/RQekK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqeqMLdcLCCq5KiFpFX0UVebZIyjl9q9W71IKs8OMG8=;
	b=bGPqvgU/F6qt21ph7354aLkhH/qCQcvRc4b1vWXrzO51HMgpebZnzqmsxnE7AV4sa4BsG/
	mzETMm0KhG8ZvaqkWsolYrqIjpkJs1bKPz4gKA2lfYGeg/NCrRcWWs7/fpP3l4RuAmOJkN
	BMBIak3jjLDzv8hGqvq/wGw39HN/GVBtPAy0n30N8R8DnSxbrU3BBr7iPGxux5WDUEer82
	Y6fRY6dDsIpo5iImBZNcsc/Fyjq3dQlj2t3GJEPVVCc5ZQAWWqvDCS1OGbrsONG3YRK6i5
	DgXcJd2eR7Mb5v2BCQyY9VtarIoY2BLnixk9g33W6dqX7h8WcGhu5yQExQeNig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879276;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqeqMLdcLCCq5KiFpFX0UVebZIyjl9q9W71IKs8OMG8=;
	b=Zw/RQekKbu0TRkBbWQvwvWwbpaRgx6GSG/+PXB6hziLsT/zPv86Ap2N78xVaROpW31PGKa
	w9uUYSYJaFLaYWBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework timekeeping_suspend() to use
 shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-22-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-22-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987927504.1442.4378424350848954054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d05eae87764ed28a3caf08220d0e2f72dbc0f596
Gitweb:        https://git.kernel.org/tip/d05eae87764ed28a3caf08220d0e2f72dbc0f596
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

timekeeping: Rework timekeeping_suspend() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

While the sequence count held time is not relevant for the resume path as
there is no concurrency, there is no reason to have this function
different than all the other update sites.

Convert timekeeping_inject_offset() to use this scheme and cleanup the
variable declarations while at it.

As halt_fast_timekeeper() does not need protection sequence counter, it is
no problem to move it with this change outside of the sequence counter
protected area. But it still needs to be executed while holding the lock.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-22-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 94f68e7..231eaa4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2003,11 +2003,11 @@ void timekeeping_resume(void)
 
 int timekeeping_suspend(void)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64		delta, delta_delta;
-	static struct timespec64	old_delta;
+	struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	struct timespec64 delta, delta_delta;
+	static struct timespec64 old_delta;
 	struct clocksource *curr_clock;
+	unsigned long flags;
 	u64 cycle_now;
 
 	read_persistent_clock64(&timekeeping_suspend_time);
@@ -2023,8 +2023,7 @@ int timekeeping_suspend(void)
 	suspend_timing_needed = true;
 
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-	timekeeping_forward_now(tk);
+	timekeeping_forward_now(tks);
 	timekeeping_suspended = 1;
 
 	/*
@@ -2032,8 +2031,8 @@ int timekeeping_suspend(void)
 	 * just read from the current clocksource. Save this to potentially
 	 * use in suspend timing.
 	 */
-	curr_clock = tk->tkr_mono.clock;
-	cycle_now = tk->tkr_mono.cycle_last;
+	curr_clock = tks->tkr_mono.clock;
+	cycle_now = tks->tkr_mono.cycle_last;
 	clocksource_start_suspend_timing(curr_clock, cycle_now);
 
 	if (persistent_clock_exists) {
@@ -2043,7 +2042,7 @@ int timekeeping_suspend(void)
 		 * try to compensate so the difference in system time
 		 * and persistent_clock time stays close to constant.
 		 */
-		delta = timespec64_sub(tk_xtime(tk), timekeeping_suspend_time);
+		delta = timespec64_sub(tk_xtime(tks), timekeeping_suspend_time);
 		delta_delta = timespec64_sub(delta, old_delta);
 		if (abs(delta_delta.tv_sec) >= 2) {
 			/*
@@ -2058,9 +2057,8 @@ int timekeeping_suspend(void)
 		}
 	}
 
-	timekeeping_update(&tk_core, tk, TK_MIRROR);
-	halt_fast_timekeeper(tk);
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_from_shadow(&tk_core, 0);
+	halt_fast_timekeeper(tks);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	tick_suspend();

