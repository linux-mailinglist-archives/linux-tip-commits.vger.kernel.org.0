Return-Path: <linux-tip-commits+bounces-2340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098E98DFB3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0FB25C6D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C87E1D2702;
	Wed,  2 Oct 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M/8PZgaN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyIWYzkb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B51D1F50;
	Wed,  2 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883901; cv=none; b=fRE/otkCoNpRkJeJLyWiZeioKj9Qwl2idK1Xmau2EmcYZhb/Aa4nKMGCg25cnOJp4367dxEtcRxupl/GtBMJ9kGcqBt0wFUpTCeqpfZiZNfrrNH5UtIef8CAf7BQbBaKgdiNBgZ3orB7aKYrNSaZu/Bg1j/dgRYAdui4gqwU/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883901; c=relaxed/simple;
	bh=VeFnEyMAsGJjnCrpzUMcrHihjoaUMicQFkDsxfondSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qMaez+0/Y9kPr9NqlpAgMG1zr1LRgkuEqEgspUu7uLWuaoxHTVKeoV0BzGj9zhlfi1Qmg/sZBSTystWMn/ufdPvQWVsrDbBKVIn4LhTsuwfiYhfj3WM0pFkQ3cBUl4xMNdSSQOiUeTFEUELlnR1s3SXccEBQizwQoMOhQaUzcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M/8PZgaN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IyIWYzkb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OImAcSAFHMQdwCaykTtyq0xD0JUrEbc0cHBbUE55fY=;
	b=M/8PZgaNxdP/we5VwD/6nmZu9x1JcpsBJeR/3Oh486fR+1qWjgWarLc8E/RsBm7OkMKoUs
	NfqTPa03eoA9euGJPa5RuB914gQEyGnQVu9XfDHubO69/j93TS0LOehz8tc4eV7H/6Hv8g
	EAwp1A5D8byijBnt+VA6HawQAQv164GuB0GFNTygcyA+hdcti4SYzJ8xcRmxyGs+Lumg3k
	Lmw7lcqN6Jp2/MoJVaUU+2gAGrkM/gVtZnkrMLK2uONX6l7/wP+SjDOtm4BIMyCVINmQSI
	mI1gjk3YVR4pP24F7aAvgxqnlN9GlJf3jFn3CiThyrk5Js4TP0m2Q7itErjbxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OImAcSAFHMQdwCaykTtyq0xD0JUrEbc0cHBbUE55fY=;
	b=IyIWYzkblKP5YNME1erzZGLF6JIavrVmCZaPqBmSxKPNB1Jjy50z+QNng5UPQ1IRmLSE/Q
	8l+ne2NSwrlyPIBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Remove unused tick_nsec
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389716.1442.15522999436684899527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a849a0273d0f73a252d14d31c5003a8059ea51fc
Gitweb:        https://git.kernel.org/tip/a849a0273d0f73a252d14d31c5003a8059ea51fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:38 +02:00

ntp: Remove unused tick_nsec

tick_nsec is only updated in the NTP core, but there are no users.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-1-2d52f4e13476@linutronix.de

---
 arch/x86/include/asm/timer.h | 2 --
 include/linux/timex.h        | 1 -
 kernel/time/ntp.c            | 8 ++------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 7365dd4..23baf8c 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -6,8 +6,6 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 
-#define TICK_SIZE (tick_nsec / 1000)
-
 unsigned long long native_sched_clock(void);
 extern void recalibrate_cpu_khz(void);
 
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 3871b06..7f7a12f 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -145,7 +145,6 @@ unsigned long random_get_entropy_fallback(void);
  * estimated error = NTP dispersion.
  */
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
-extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
 
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 802b336..c17cc9d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -33,9 +33,6 @@
 /* USER_HZ period (usecs): */
 unsigned long			tick_usec = USER_TICK_USEC;
 
-/* SHIFTED_HZ period (nsecs): */
-unsigned long			tick_nsec;
-
 static u64			tick_length;
 static u64			tick_length_base;
 
@@ -253,8 +250,8 @@ static inline int ntp_synced(void)
  */
 
 /*
- * Update (tick_length, tick_length_base, tick_nsec), based
- * on (tick_usec, ntp_tick_adj, time_freq):
+ * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
+ * time_freq:
  */
 static void ntp_update_frequency(void)
 {
@@ -267,7 +264,6 @@ static void ntp_update_frequency(void)
 	second_length		+= ntp_tick_adj;
 	second_length		+= time_freq;
 
-	tick_nsec		 = div_u64(second_length, HZ) >> NTP_SCALE_SHIFT;
 	new_base		 = div_u64(second_length, NTP_INTERVAL_FREQ);
 
 	/*

