Return-Path: <linux-tip-commits+bounces-2588-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47919B0C7E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBC28203B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFD215C42;
	Fri, 25 Oct 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4dPCPv3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AC85kFuX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB720F3EA;
	Fri, 25 Oct 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879285; cv=none; b=TLrCC2SM/F1Sr+9SOPSKvN0Q8Bs1nLQkOGGOq1zgCYt1HOkvJzo/RRCcm7AtgNDIKqsZy0UjuzWScf2oUbmRt4tmW6/CVIc6ottz2QR+OCA8I06+ICLSWfJhojCDElGuqVNrsadVBK+azOVaconZEdks21ge3od9oWg3krOjxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879285; c=relaxed/simple;
	bh=B/8JkOzRdSFthO+GwIrJ2S8b85vLicRNDGH9fT8Nus0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MYoA68yZBflubgsrJ3tCph0gFzCvFpL5Cu/DIiHwXYebeZq0rFBzjTpCkpHedMUdb48vTwKuKTfGI9lVYYa8xDgeQW9tBWlDhkX6Zp1NCYeM+pk1uVCqmr/mF3NbA0ttPB7rRNnLjxeaCyGs83K9kjA/oBJxihOr582At3zjFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u4dPCPv3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AC85kFuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L882R1TGbroN6L1ROUmIazO8BxiAcQMStwTF3b/pVd4=;
	b=u4dPCPv3gpmYnd2CDyfVcXw1+pIpibCkPHNrATpJ/zz9XbrPtSYgAOCuwGO3fL4vYcJF31
	M8chTflcdEZodLIacDmxb2mx1BHSJfG1ncrgBEvYyINmTKd9YiuW2OiIy3TgHVpLA4SOM6
	ordS8rRHhPwO5PfCwaY0bljirOI/DvFlFSzH8my4tG3SGjTMLerYoIIHVO0E0JJx+g9Ww5
	15GxQgYmNea/iTkqZLFgKqt8BPhtGXdFbrKyN4qpoA+O09Qc1M63igBG3Vtis6ZT7pBbd2
	mXprUvPM114fKQ1kVIx5nUX+luo6DjCUdzrxevnwKBLlY8S1o1oqSP8XdLNuqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L882R1TGbroN6L1ROUmIazO8BxiAcQMStwTF3b/pVd4=;
	b=AC85kFuXffpb3JGhQkVSnklcYVTNreMCuynt3pH9wV72u+1ny63j0KfTaUsgcDZ+Sg4bFw
	DIk2rm5sCvhFByCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Introduce combined timekeeping action flag
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-14-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-14-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928119.1442.1257273252944279442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6b1ef640f4c48663777972ab0953a3eb6355ef85
Gitweb:        https://git.kernel.org/tip/6b1ef640f4c48663777972ab0953a3eb6355ef85
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Introduce combined timekeeping action flag

Instead of explicitly listing all the separate timekeeping actions flags,
introduce a new one which covers all actions except TK_MIRROR action.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-14-554456a44a15@linutronix.de
---
 kernel/time/timekeeping.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b3f4989..c30b187 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -33,6 +33,8 @@
 #define TK_MIRROR		(1 << 1)
 #define TK_CLOCK_WAS_SET	(1 << 2)
 
+#define TK_UPDATE_ALL		(TK_CLEAR_NTP | TK_CLOCK_WAS_SET)
+
 enum timekeeping_adv_mode {
 	/* Update timekeeper when a tick has passed */
 	TK_ADV_TICK,
@@ -1524,7 +1526,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 
 	tk_set_xtime(tk, ts);
 out:
-	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1574,7 +1576,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
 
 error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1659,7 +1661,7 @@ static int change_clocksource(void *data)
 	timekeeping_forward_now(tk);
 	old = tk->tkr_mono.clock;
 	tk_setup_internals(tk, new);
-	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1950,7 +1952,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 
 	__timekeeping_inject_sleeptime(tk, delta);
 
-	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);

