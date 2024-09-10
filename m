Return-Path: <linux-tip-commits+bounces-2293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D09736A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFDA1F26859
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27D18FDB1;
	Tue, 10 Sep 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkRrQ7pt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kASNtcE7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB81885BD;
	Tue, 10 Sep 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969552; cv=none; b=VzgBPIrZXdYW8tqCYkIPy5j/UH7fRMS3CcQVuth6fNlSFdKLcc1t2QVhBgVxcubMjJGM/SaTx08YCuI9XyCGtvMiibJQFSw6INSV0G+e80x6Sewe51calSM3ky4ZzFcRppPLkGzYu7l7qlKHXy0/3yUMlMekwFf0L5BaB4W5oxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969552; c=relaxed/simple;
	bh=rWo0XGDoMhkkcWWkit+Tg0Rln0w1WZIlTMmDs4yEV2w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OGpap/ivMigIqcUQLgwQDkVYslc43UYlhlXNEW93Ixj5Ai3yFWvax+ZYGI+bXmKRS+BayTnO8KL+zs3oIhXHNZjDOqGRMkcxA7n0I6u5Vk4bKp+gBT6EWYdhJffPw8gfRdCtd02CIHB7De0cHv8L0d0vZ2Xy83rztymFjZQT1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkRrQ7pt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kASNtcE7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 11:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725969548;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QfhozGlni9DREoqdZY6Z0ybsDx8Ur3D6GH/AoU7E/w=;
	b=wkRrQ7ptuVOcF8ZuB1v+MyAmAriqtvVxHsJonu1650fWdaT4nqIBJRBWesLFv9FOwEsQBI
	EsJK+q4Ls7aDh5L88Y8FXoyW1EngwgqGorYi0RDbYzDxf/EtN47aset7R13WZl82JjdnpD
	H2+TWMCQO1uhY/I9kJfc4BOQ9rXBF5vaJCT6SvPP0FeqMWA1Sl1uDdfCADBuV6wljkg0H7
	C4SZ/4DhoTFqDgmt5ptU9HJlaau8D4vgZSMi6dRvf50BINVWNILDcnkHNwyvLYjxWaXYXv
	z6+1gehLrAJi0nRXLWlNoy3rmAILTaCJ/DY4RgsiaESDxoDV+9zTXu8pZJJAqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725969548;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QfhozGlni9DREoqdZY6Z0ybsDx8Ur3D6GH/AoU7E/w=;
	b=kASNtcE7YOF1zzKXdS+rGWdNUDVVJQA+DPGcc91RYkbIPC1E3u2RKwLbs3gmktO7fiO+QU
	Jo2NHRGxtu+6KfDQ==
From: "tip-bot2 for Benjamin ROBIN" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Make sure RTC is synchronized when time goes
 backwards
Cc: Benjamin ROBIN <dev@benjarobin.fr>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240908140836.203911-1-dev@benjarobin.fr>
References: <20240908140836.203911-1-dev@benjarobin.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596954822.2215.3385652199225021326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     35b603f8a78b0bd51566db277c4f7b56b3ff6bac
Gitweb:        https://git.kernel.org/tip/35b603f8a78b0bd51566db277c4f7b56b3ff6bac
Author:        Benjamin ROBIN <dev@benjarobin.fr>
AuthorDate:    Sun, 08 Sep 2024 16:08:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Sep 2024 13:50:40 +02:00

ntp: Make sure RTC is synchronized when time goes backwards

sync_hw_clock() is normally called every 11 minutes when time is
synchronized. This issue is that this periodic timer uses the REALTIME
clock, so when time moves backwards (the NTP server jumps into the past),
the timer expires late.

If the timer expires late, which can be days later, the RTC will no longer
be updated, which is an issue if the device is abruptly powered OFF during
this period. When the device will restart (when powered ON), it will have
the date prior to the ADJ_SETOFFSET call.

A normal NTP server should not jump in the past like that, but it is
possible... Another way of reproducing this issue is to use phc2sys to
synchronize the REALTIME clock with, for example, an IRIG timecode with
the source always starting at the same date (not synchronized).

Also, if the time jump in the future by less than 11 minutes, the RTC may
not be updated immediately (minor issue). Consider the following scenario:
 - Time is synchronized, and sync_hw_clock() was just called (the timer
   expires in 11 minutes).
 - A time jump is realized in the future by a couple of minutes.
 - The time is synchronized again.
 - Users may expect that RTC to be updated as soon as possible, and not
   after 11 minutes (for the same reason, if a power loss occurs in this
   period).

Cancel periodic timer on any time jump (ADJ_SETOFFSET) greater than or
equal to 1s. The timer will be relaunched at the end of do_adjtimex() if
NTP is still considered synced. Otherwise the timer will be relaunched
later when NTP is synced. This way, when the time is synchronized again,
the RTC is updated after less than 2 seconds.

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240908140836.203911-1-dev@benjarobin.fr

---
 kernel/time/ntp.c          | 10 +++++++++-
 kernel/time/ntp_internal.h |  4 ++--
 kernel/time/timekeeping.c  |  4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8d2dd21..802b336 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -660,9 +660,17 @@ rearm:
 	sched_sync_hw_clock(offset_nsec, res != 0);
 }
 
-void ntp_notify_cmos_timer(void)
+void ntp_notify_cmos_timer(bool offset_set)
 {
 	/*
+	 * If the time jumped (using ADJ_SETOFFSET) cancels sync timer,
+	 * which may have been running if the time was synchronized
+	 * prior to the ADJ_SETOFFSET call.
+	 */
+	if (offset_set)
+		hrtimer_cancel(&sync_hrtimer);
+
+	/*
 	 * When the work is currently executed but has not yet the timer
 	 * rearmed this queues the work immediately again. No big issue,
 	 * just a pointless work scheduled.
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 23d1b74..5a633dc 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -14,9 +14,9 @@ extern int __do_adjtimex(struct __kernel_timex *txc,
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
-extern void ntp_notify_cmos_timer(void);
+extern void ntp_notify_cmos_timer(bool offset_set);
 #else
-static inline void ntp_notify_cmos_timer(void) { }
+static inline void ntp_notify_cmos_timer(bool offset_set) { }
 #endif
 
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e41..7e6f409 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2553,6 +2553,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
+	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
 	unsigned long flags;
@@ -2575,6 +2576,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		if (ret)
 			return ret;
 
+		offset_set = delta.tv_sec != 0;
 		audit_tk_injoffset(delta);
 	}
 
@@ -2608,7 +2610,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer();
+	ntp_notify_cmos_timer(offset_set);
 
 	return ret;
 }

