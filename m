Return-Path: <linux-tip-commits+bounces-2551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616149B0656
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B2EB26E83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E87170A37;
	Fri, 25 Oct 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOlHt/tC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNlWSbuW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5515A858;
	Fri, 25 Oct 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868030; cv=none; b=s7+m28TZqVMTG17LXQqLaq5GZIZf1tK6JBno9Fp2wuaqxBcgPM0FwE1IeSvLzRquP3+uP0+PSvGqQh7L+QdjyTTC+WPyfc4Z0F9dR4US5NvuSJ6/rCOkk2QXnOiVoDX3ld4Hk+sYukq9tAlIJdTwS1G6cF/3pMZ3qymDGPI4kGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868030; c=relaxed/simple;
	bh=zQamBrsBFnJwYa722gV48fN5wPH2n4GKdisc9mth6IQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qh4cf4LTPAMDSMi6mCMb0/jzubCBYPc9G3GshdVy1wMcENKFmri2tGmtrVxesrw4hijq2oQcsRVHcOps7ft5iKRjb2xSWlv0l3BevZyQurNKJ3KLlJRtHE2i09zM48vdBPahNmo1s4qx2dfbtE6ChpnpS2qwPMjwy19+yeHlzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOlHt/tC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNlWSbuW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j34A0UTVMLI13okJ0nwyBBpvJaOSk36nr8VcavX2eFY=;
	b=pOlHt/tC9zHmzYOE61B/4yN488nrRTi02jcyfnK/DWJrWVKZNRM7slIOmFDbJscpuObXUE
	YOrAb5ZtH/TKx94S9kpMQkwkces21RMn4v1i8QmnuEuJI5bQsyhtSiQENRlqow3Xx6iGfC
	pIeehngwrmGY5R4/Sm2G9FAGBMwwMNApD2Xz9T8v0+UkHTDlvh4RcORSw1bRXXE4jevkFl
	HSd+15D1klZCn4yyX7iQdwqbg/Vp/Lx5FqWoXGBPb7LDNUdgeO0L5ZHutTeuVwwgJ7U845
	njHcQ7g7vmfxU79DFi8ExFhBAvka23/aIiLqYrTLcL52X8/c8pZfbqfPsUlLpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868026;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j34A0UTVMLI13okJ0nwyBBpvJaOSk36nr8VcavX2eFY=;
	b=PNlWSbuW9FHVhzxcsub2FKOOJzxhVk9euP+eKfSQCSnyQJTci7tAPQG8bpRiR3kR8eTJfL
	vhwqTx93v8vOj4Ag==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Rework do_adjtimex() to use shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-23-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-23-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802597.1442.1000620555176157192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f310960e85f1332ec21b26e10bd1287610a28c11
Gitweb:        https://git.kernel.org/tip/f310960e85f1332ec21b26e10bd1287610a28c11
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

timekeeping: Rework do_adjtimex() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert do_adjtimex() to use this scheme and take the opportunity to use a
scoped_guard() for locking.

That requires to have a separate function for updating the leap state so
that the update is protected by the sequence count. This also brings the
timekeeper and the shadow timekeeper in sync for this state, which was not
the case so far. That's not a correctness problem as the state is only used
at the read sides which use the real timekeeper, but it's inconsistent
nevertheless.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-23-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 41 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 231eaa4..f117982 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -742,6 +742,18 @@ static inline void tk_update_leap_state(struct timekeeper *tk)
 }
 
 /*
+ * Leap state update for both shadow and the real timekeeper
+ * Separate to spare a full memcpy() of the timekeeper.
+ */
+static void tk_update_leap_state_all(struct tk_data *tkd)
+{
+	write_seqcount_begin(&tkd->seq);
+	tk_update_leap_state(&tkd->shadow_timekeeper);
+	tkd->timekeeper.next_leap_ktime = tkd->shadow_timekeeper.next_leap_ktime;
+	write_seqcount_end(&tkd->seq);
+}
+
+/*
  * Update the ktime_t based scalar nsec members of the timekeeper
  */
 static inline void tk_update_ktime_data(struct timekeeper *tk)
@@ -2656,13 +2668,10 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
-	unsigned long flags;
-	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2673,6 +2682,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 	if (txc->modes & ADJ_SETOFFSET) {
 		struct timespec64 delta;
+
 		delta.tv_sec  = txc->time.tv_sec;
 		delta.tv_nsec = txc->time.tv_usec;
 		if (!(txc->modes & ADJ_NANO))
@@ -2690,23 +2700,22 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
+		s32 orig_tai, tai;
 
-	orig_tai = tai = tk->tai_offset;
-	ret = __do_adjtimex(txc, &ts, &tai, &ad);
+		orig_tai = tai = tks->tai_offset;
+		ret = __do_adjtimex(txc, &ts, &tai, &ad);
 
-	if (tai != orig_tai) {
-		__timekeeping_set_tai_offset(tk, tai);
-		timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-		clock_set = true;
-	} else {
-		tk_update_leap_state(tk);
+		if (tai != orig_tai) {
+			__timekeeping_set_tai_offset(tks, tai);
+			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+			clock_set = true;
+		} else {
+			tk_update_leap_state_all(&tk_core);
+		}
 	}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
-
 	audit_ntp_log(&ad);
 
 	/* Update the multiplier immediately if frequency was set directly */

