Return-Path: <linux-tip-commits+bounces-2601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208899B0C99
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EDD1F23B99
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D2D218946;
	Fri, 25 Oct 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vwRywgr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIyWrO+M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8A217645;
	Fri, 25 Oct 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879294; cv=none; b=NfvGiL2QoW5NUBuWWtlph8PwpwWEHQwIsM2mqPD1z7qnuIZP+mi8u67NB84uEOs1YhTjNsZD1f06xmfFBfS/VNitVJf1rwRX7Y9UD8uGOsFrssfhFZ5MGq9jAJ/KMSgEhMNja2riWcnCSbI/AKAsTT9GCS68eXo+ZwPkkbHsniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879294; c=relaxed/simple;
	bh=09rtN23f/2fqGEVqw5BDo6aBndOaeqSyLy6vxabVDRo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lzQ02pCS/XXHDThgnYuQQvrELgDi57hyEP5Am9xHs6Yk9cJFN8d9U9d9PH3WKQQc+fDvEj23VktfXiO+YhnR5DZMleRSX7p6ZFL1N+XqOaxUOna0c4gT4NTuEN0lJkrQLhsQRY2O0Ny8/xeuhkKF+VHWoNrmrgNXKJ+AG4L7RtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vwRywgr0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIyWrO+M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sygGQNoZWnNpdRcx9DihtuqwyWyLHZkIhdV98RSYqeg=;
	b=vwRywgr0e75SpidkRKyiXwk7sZo8YFfdNUjfRpT7AlaIe+BS45Ail57I9xtysEK0tH/Jty
	mZ113eRsAnors3AI5yzDJ9tfco785M0patcFEEb1N1/FwiEiL4d2Bacmkz8TO9h1N0+km/
	xCg3fPCYOQv44dLULDetalAk6a9b64UA+gSXxHXwF6lQpM5xawp2IlNqI4hBTAr12loZqI
	KmnSEbmOXGTHbhkIQxXk+fCmMw4/5/2kwXCh+uCjK8D6w4Hb4hjvf3N9MexjbuWmtERq8u
	abSXfQqHapZj5IpP/LpNj1ENcLHr7mTkvW0Vi9ss6ykVH/yKKK77ncjV4TSZpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879291;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sygGQNoZWnNpdRcx9DihtuqwyWyLHZkIhdV98RSYqeg=;
	b=fIyWrO+MyLf8MtmA/qlYpRNbPMJvIHVqPYgS6tG4CE52biayb1Rcm+3AMgmH+WhEOWf0cd
	N9GGr0zYdcTZnJCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Read NTP tick length only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-1-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-1-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987929055.1442.14883159884487157363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     14f1e3b3dfc7fc8b61fcb79f956f05625af6f049
Gitweb:        https://git.kernel.org/tip/14f1e3b3dfc7fc8b61fcb79f956f05625af6f049
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:28:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:12 +02:00

timekeeping: Read NTP tick length only once

No point in reading it a second time when the comparison fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-1-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1427c58..2bc3542 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2161,16 +2161,17 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
+	u64 ntp_tl = ntp_tick_length();
 	u32 mult;
 
 	/*
 	 * Determine the multiplier from the current NTP tick length.
 	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	if (likely(tk->ntp_tick == ntp_tick_length())) {
+	if (likely(tk->ntp_tick == ntp_tl)) {
 		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
 	} else {
-		tk->ntp_tick = ntp_tick_length();
+		tk->ntp_tick = ntp_tl;
 		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
 				 tk->xtime_remainder, tk->cycle_interval);
 	}

