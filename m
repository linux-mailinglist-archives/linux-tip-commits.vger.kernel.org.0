Return-Path: <linux-tip-commits+bounces-2558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C49B0664
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553101F22573
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044C148FED;
	Fri, 25 Oct 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRg586dr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgHAZXa6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C23187321;
	Fri, 25 Oct 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868035; cv=none; b=bRW9ZS1KYx+CZ8U9QoKQOVscLkQw0uH3uYyvDJ/j2eM8QEpKD/N+1PvTKJ/se8tqfOODdZF0iljPjQ7X4RZMHXgwUHdd2h6uFhtSrKi4BNKF856VaMwDrwUSz4ZjqTaI+GMY92BoTb+mGz9MaPC2CLoI4XHLu1hyEge7qmm7jaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868035; c=relaxed/simple;
	bh=j8ZH+qCIIz4aFf8dcNZmhSVI7xnSdgqVg83zK8m3+fE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EYw6YoRgYRxuVumHVROgAFGCg6q85PIVKUChghzX29iCOHL9ndKDhGVqqkIY8ktMUICdpMtD1Own5DEiwLYL0Q5qcRcEh9ctA4mQglHw9l6CzmiMCh/uYOteOKw1PYgaxlLCYG16s+l3CoNC5kZMTR+NqLI5L5X6RH4PjKSSTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LRg586dr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgHAZXa6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0Kpv9qQsSUv6b3nDE5RzFxjybtR1n/UgGOYJvUtBjI=;
	b=LRg586drN4p1ouvjj3Jqlq7IsG3YOleiILzun9fvbUtkHVq4NexECOR3I3BcAZrl9X/MZx
	ULOs31kw0MJ0egfkTU2VjlIHzohK0VuD2cICh2lL/XdhZx43vVJYArhZ6M7fC1TXl+T1S6
	mb43Xfwpzl6vsAxqb854xRldDttFB+04ILhX2Ji6htCRXGUB/zEoYVPIWrbVWJmWHyDlRY
	RbKDkT16aqaFkZt5FF9iNymmMsDx+2agZEJCrcaE//4Wne4vna/I71aW71SJh3gDmvA286
	j2rUYc8t/m4uqNahPCNl2fQGTKgJirg02ZVZcMIs1oMnP04BSqemzXcs8/eN7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0Kpv9qQsSUv6b3nDE5RzFxjybtR1n/UgGOYJvUtBjI=;
	b=VgHAZXa6JN2zqsQHWc+tDUUKplbCK8UpRn6TSwQvbiU6LHjjlez5rjGoQrSsCGqAr73Cqy
	/e79zTDldX5FWFCA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework do_settimeofday64() to use
 shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-16-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-16-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986803068.1442.9198919712527825726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     773df86f5890844fd6feddec1ed3e9a0012acb09
Gitweb:        https://git.kernel.org/tip/773df86f5890844fd6feddec1ed3e9a0012acb09
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:12 +02:00

timekeeping: Rework do_settimeofday64() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert do_settimeofday64() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-16-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 42 ++++++++++++++------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ed0e328..1b8db11 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1510,45 +1510,35 @@ EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
  */
 int do_settimeofday64(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
 	struct timespec64 ts_delta, xt;
-	unsigned long flags;
-	int ret = 0;
 
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	xt = tk_xtime(tk);
-	ts_delta = timespec64_sub(*ts, xt);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
 
-	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
-		ret = -EINVAL;
-		goto out;
-	}
+		timekeeping_forward_now(tks);
 
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, ts_delta));
+		xt = tk_xtime(tks);
+		ts_delta = timespec64_sub(*ts, xt);
 
-	tk_set_xtime(tk, ts);
-out:
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		if (timespec64_compare(&tks->wall_to_monotonic, &ts_delta) > 0) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, ts_delta));
+		tk_set_xtime(tks, ts);
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
 
-	if (!ret) {
-		audit_tk_injoffset(ts_delta);
-		add_device_randomness(ts, sizeof(*ts));
-	}
-
-	return ret;
+	audit_tk_injoffset(ts_delta);
+	add_device_randomness(ts, sizeof(*ts));
+	return 0;
 }
 EXPORT_SYMBOL(do_settimeofday64);
 

