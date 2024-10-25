Return-Path: <linux-tip-commits+bounces-2596-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D79B0C8F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BD028290B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3C21746D;
	Fri, 25 Oct 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyvX5HXJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DC373Hhm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5712216E0E;
	Fri, 25 Oct 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879292; cv=none; b=ESLtEvcquCujSR5U1wo+eexnRVIjhwPs3EQz01xYZD6650VISKaEfj8XOEfIPiBJufil/+2HoNPL/VZ5UQlCEExP6SUIT4YEyZct+f1n/R1WHP4+kDNHRrHEzDdMjzi7Hynu3dY7tAnKdvjkGE5d+za8JiTsdjDF6S+y0rE6cTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879292; c=relaxed/simple;
	bh=veNHhUTG4PiQlPKTalkJchDyC+PnxrzyD3P2TjUPZxA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hO2dh5w7ZunmbbVwdW2EEY29k07F9HSjk05Wui4EkL1XTrDUNMoY98YGAE9+j72ZmUgWkobuz6UMabTv5gNEq9BDCLyNrdvO/WrUL1V6Li7i82CcagHYdtpt5fQDJWMj0Jyd/tuSKf+ifXcPHGSaF6rgHHslDdpHZ/xk9ZIDI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RyvX5HXJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DC373Hhm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1h98WtqdlCkh/01IH0DWIMuY8y/QlYtmQkRzwzb6h8=;
	b=RyvX5HXJhI2HM5fPdXUWrxfuOhTp9dtMzX4h0xRH1rNb7VX9yeXGdMNZV/HDrwKr98KDBP
	66fwffZQCVDRg4aoNwE/JxgWAjTyF7iFJgD1YEGpLS599hts5skDADXxOGDXze81qIF0s7
	Xe6pxDGOn0jGfzT1DiCZtG3FTqao47DlC40tlnJZVNXWDPMjnZ320C8XOsqGBEKtFOYs9D
	9Bt0HCgfjRz/sVpGEVMsxHq2G3Se0L9KCo+AvX7Tk/E5mvA3s7BnpAhzHxfqPhAg/+GPej
	ZORkZ5wiRZebrhSB/etDPwvoPq9Ox4GfY+TLHrURDkuHGi8nrhbz1Ml3cPZFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1h98WtqdlCkh/01IH0DWIMuY8y/QlYtmQkRzwzb6h8=;
	b=DC373HhmUbvZ9cD029E+fBQmOBU+qrI31brZDUvbZ0BqRUZ58izb5J/yX8Ri/YbEafTPRp
	J3BdwFHTlTDRXBDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Simplify code in timekeeping_advance()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-5-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-5-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928774.1442.15542081714807205566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c2a329566a3d5a638061733f232c40379235931d
Gitweb:        https://git.kernel.org/tip/c2a329566a3d5a638061733f232c40379235931d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:13 +02:00

timekeeping: Simplify code in timekeeping_advance()

timekeeping_advance() takes the timekeeper_lock and releases it before
returning. When an early return is required, goto statements are used to
make sure the lock is realeased properly. When the code was written the
locking guard() was not yet available.

Use the guard() to simplify the code and while at it cleanup ordering of
function variables. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-5-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a9550f6..cfb718d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2307,23 +2307,22 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
-	u64 offset;
-	int shift = 0, maxshift;
 	unsigned int clock_set = 0;
-	unsigned long flags;
+	int shift = 0, maxshift;
+	u64 offset;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&timekeeper_lock);
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
-		goto out;
+		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
-		goto out;
+		return false;
 
 	/* Do some additional sanity checking */
 	timekeeping_check_update(tk, offset);
@@ -2342,8 +2341,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
 	shift = min(shift, maxshift);
 	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift,
-							&clock_set);
+		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
 		if (offset < tk->cycle_interval<<shift)
 			shift--;
 	}
@@ -2372,8 +2370,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	memcpy(real_tk, tk, sizeof(*tk));
 	/* The memcpy must come last. Do not put anything here! */
 	write_seqcount_end(&tk_core.seq);
-out:
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	return !!clock_set;
 }

