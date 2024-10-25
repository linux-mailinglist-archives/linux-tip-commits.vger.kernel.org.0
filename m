Return-Path: <linux-tip-commits+bounces-2557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254A9B0661
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65A4283C4F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663B1EF92E;
	Fri, 25 Oct 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGNWnYGB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5PjbMdSt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CD1422D4;
	Fri, 25 Oct 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868034; cv=none; b=d7uZlssCZ+2y4G8poP2d7GyOEIrPD8KbPPgLsVEb0XquaIX3KsEmYIKiIgwmYOUmmZILbhq3pjY7V8IKyL0Mr9AhGmotw4ohAfqGzhq5aDwWjqFv+6xwAHX9L3wu9jUX3eod4atQekM3wbGSSqZlt225fxcNRO5DFaVWtRgIJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868034; c=relaxed/simple;
	bh=gsX4LnQXQ8g5NmueEAQSi7AHtJKEsuQU/2y4CClwWsw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Myy/Gp+D82FSPzQB6VUYTgWaFE5DmVWfvLeilmswmCZIPJNq2wRSgfKsbpKecDcUgskoTmgieTFCZtdWUmxsPiafi1HesLQn26PUi00Vc4Ga9/cQxTeA8zZumO6t0M9KnjEr7CFS+oUl9zu4Ojsnu4QTjCmIDLVOgMN15tS8fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGNWnYGB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5PjbMdSt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WGFZe9BXCbUxr6uwJyRNThZtm4IpCetOtzxkm7sKbI=;
	b=fGNWnYGBXjKgGr+vCFJ34IN6KaNughqCplmImZ9Kw9Hte9KEgkWl16Vz6MdoSIDl2gwfyq
	F8m/LMOnR/nsV9he/xTbAhqRe7cKDe3QJfBGL9WLPNxGFk+jl7aO3rzZnCxc/gKLl1JaaY
	ixLfAsevmlDnbErKHvjhbvSKZR8231DaM9nVTX/lvUxzmqmY4Ie4IF7ngihgK1IIy5MHF7
	Gs4nh5x7rglJZv25CW6lX9CEca2rtrAbXEonqn6HvgT/Yd2V83elO8NNelqy7ZlFONgfDK
	2EpblGPgdfbYTSjfLn/GxErmVSeni2a8vZnHGuGPiW1b0DuLzYCcs9+CrpWOmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WGFZe9BXCbUxr6uwJyRNThZtm4IpCetOtzxkm7sKbI=;
	b=5PjbMdStVEir79QNE2OKX3ORDva8yMR0ce5kbvGkFFa/xB783Lq8C3k3f9gKu9ifnlK8zj
	Tk+sFlHnexGNaGCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework timekeeping_inject_offset() to
 use shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-17-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-17-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802999.1442.1533196109140039609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1460ef54d0b1859a89db2d54c391b4a4abb26fea
Gitweb:        https://git.kernel.org/tip/1460ef54d0b1859a89db2d54c391b4a4abb26fea
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert timekeeping_inject_offset() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-17-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 41 ++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1b8db11..7e865f0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1550,40 +1550,31 @@ EXPORT_SYMBOL(do_settimeofday64);
  */
 static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64 tmp;
-	int ret = 0;
-
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tk), *ts);
-	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		ret = -EINVAL;
-		goto error;
-	}
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tks = &tk_core.shadow_timekeeper;
+		struct timespec64 tmp;
 
-	tk_xtime_add(tk, ts);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_forward_now(tks);
 
-error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
-
-	return ret;
+	return 0;
 }
 
 /*

