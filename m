Return-Path: <linux-tip-commits+bounces-6529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BDB4AAB6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CAB1C60529
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B531A547;
	Tue,  9 Sep 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U69hj96h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXLLMfdJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D92D3EFD;
	Tue,  9 Sep 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413865; cv=none; b=ReHL32BfHgyXhE+6se+SicsikG1t6LbXzNAUwiU38+LPeFbm0BtXc5oR+1ktD3qwCzqUYqD8rdebgG5sJpKnngLgo1ZJII+LDKDL8R7PKJs1U9xvLFsOWd5RaNDcooCvAa+h3FlYgTELmvHEmwDlUC462njNjpdZ1wAoQzCFwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413865; c=relaxed/simple;
	bh=LM+W5XjrxuHg7iO6uC102wSCugVhOT4ab9XvU1vyCMk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Oao6LtAkzZn3y2AW/NucsUnFbzDAKB0p1IWlGOtn9pwUhS3kvQexchUPMahyu+5iviPpKySgE383a4D1wLvlbxTXF3JotMNI4EJhGDw1iLXlD0/fcakd69d7NPsGfkpuMYi+kbOxZ4RLMH/yIDtkXBAvzkPeriT9r6hR3BvGpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U69hj96h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXLLMfdJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpnS4bmL/H4AAuntqabe8Sp4zZW//0qF4uwLfzTZexs=;
	b=U69hj96hO77Y708MnJAfToRdQU49Yalm0+WEhh/hoRH0wq3LFh4eMos3gBAYYY76od0SQL
	Dpy6TgM+uZanjsZBO3v+BoiysdwNshSRxKxoGM3lAn2/w6BKYo8VYkn7preM7LHLNLcOCH
	DTGB8u0VTB3TJHveJgO4WKwZQlpWoIAIpMDkfheLBzd8YBT2fGjBTafjkbLcHPq8a7f0jf
	M7IkfhEWkSUXsYh52aH8dSX7qXU6xLUpTdfR7dE/in4S5A4il84MzU5Jo8/8drQjYE0IOD
	5D63KJNKUjaImRA892gpnqoFwrO0n01Q4s9BXF16XP4yTyHOtT3hPbI4FAnkNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpnS4bmL/H4AAuntqabe8Sp4zZW//0qF4uwLfzTZexs=;
	b=KXLLMfdJorcr6PssxC/LvRiPSevHyRxjgjuaGAPqXx+M6t3wsER5PaptjS6dEBbZ+fP7W0
	Hhc0elS0QGPUaRBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Remove hrtimer_clock_base:: Get_time
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250821-hrtimer-cleanup-get_time-v2-8-3ae822e5bfbd@linutronix.de>
References:
 <20250821-hrtimer-cleanup-get_time-v2-8-3ae822e5bfbd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741386009.1920.6115993605973864566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     009eb5da29a91016e3ebb988e6401e79411be7a1
Gitweb:        https://git.kernel.org/tip/009eb5da29a91016e3ebb988e6401e79411=
be7a1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 21 Aug 2025 15:28:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:27:18 +02:00

hrtimer: Remove hrtimer_clock_base:: Get_time

The get_time() callbacks always need to match the bases clockid.
Instead of maintaining that association twice in hrtimer_bases,
use a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250821-hrtimer-cleanup-get_time-v2-8-3ae8=
22e5bfbd@linutronix.de


---
 include/linux/hrtimer.h        |  5 +----
 include/linux/hrtimer_defs.h   |  2 +--
 kernel/time/hrtimer.c          | 34 ++++++++++++++++++++++++---------
 kernel/time/timer_list.c       |  2 +--
 scripts/gdb/linux/timerlist.py |  2 +--
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index e655502..2cf1bf6 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -154,10 +154,7 @@ static inline s64 hrtimer_get_expires_ns(const struct hr=
timer *timer)
 	return ktime_to_ns(timer->node.expires);
 }
=20
-static inline ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
-{
-	return timer->base->get_time();
-}
+ktime_t hrtimer_cb_get_time(const struct hrtimer *timer);
=20
 static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)
 {
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 84a5045..aa49ffa 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -41,7 +41,6 @@
  * @seq:		seqcount around __run_hrtimer
  * @running:		pointer to the currently running hrtimer
  * @active:		red black tree root node for the active timers
- * @get_time:		function to retrieve the current time of the clock
  * @offset:		offset of this clock to the monotonic base
  */
 struct hrtimer_clock_base {
@@ -51,7 +50,6 @@ struct hrtimer_clock_base {
 	seqcount_raw_spinlock_t	seq;
 	struct hrtimer		*running;
 	struct timerqueue_head	active;
-	ktime_t			(*get_time)(void);
 	ktime_t			offset;
 } __hrtimer_clock_base_align;
=20
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 30899a8..fedd1d7 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -59,6 +59,7 @@
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
=20
 static void retrigger_next_event(void *arg);
+static ktime_t __hrtimer_cb_get_time(clockid_t clock_id);
=20
 /*
  * The timer bases:
@@ -76,42 +77,34 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =3D
 		{
 			.index =3D HRTIMER_BASE_MONOTONIC,
 			.clockid =3D CLOCK_MONOTONIC,
-			.get_time =3D &ktime_get,
 		},
 		{
 			.index =3D HRTIMER_BASE_REALTIME,
 			.clockid =3D CLOCK_REALTIME,
-			.get_time =3D &ktime_get_real,
 		},
 		{
 			.index =3D HRTIMER_BASE_BOOTTIME,
 			.clockid =3D CLOCK_BOOTTIME,
-			.get_time =3D &ktime_get_boottime,
 		},
 		{
 			.index =3D HRTIMER_BASE_TAI,
 			.clockid =3D CLOCK_TAI,
-			.get_time =3D &ktime_get_clocktai,
 		},
 		{
 			.index =3D HRTIMER_BASE_MONOTONIC_SOFT,
 			.clockid =3D CLOCK_MONOTONIC,
-			.get_time =3D &ktime_get,
 		},
 		{
 			.index =3D HRTIMER_BASE_REALTIME_SOFT,
 			.clockid =3D CLOCK_REALTIME,
-			.get_time =3D &ktime_get_real,
 		},
 		{
 			.index =3D HRTIMER_BASE_BOOTTIME_SOFT,
 			.clockid =3D CLOCK_BOOTTIME,
-			.get_time =3D &ktime_get_boottime,
 		},
 		{
 			.index =3D HRTIMER_BASE_TAI_SOFT,
 			.clockid =3D CLOCK_TAI,
-			.get_time =3D &ktime_get_clocktai,
 		},
 	},
 	.csd =3D CSD_INIT(retrigger_next_event, NULL)
@@ -1253,7 +1246,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *tim=
er, ktime_t tim,
 	remove_hrtimer(timer, base, true, force_local);
=20
 	if (mode & HRTIMER_MODE_REL)
-		tim =3D ktime_add_safe(tim, base->get_time());
+		tim =3D ktime_add_safe(tim, __hrtimer_cb_get_time(base->clockid));
=20
 	tim =3D hrtimer_update_lowres(timer, tim, mode);
=20
@@ -1588,6 +1581,29 @@ static inline int hrtimer_clockid_to_base(clockid_t cl=
ock_id)
 	}
 }
=20
+static ktime_t __hrtimer_cb_get_time(clockid_t clock_id)
+{
+	switch (clock_id) {
+	case CLOCK_MONOTONIC:
+		return ktime_get();
+	case CLOCK_REALTIME:
+		return ktime_get_real();
+	case CLOCK_BOOTTIME:
+		return ktime_get_boottime();
+	case CLOCK_TAI:
+		return ktime_get_clocktai();
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return ktime_get();
+	}
+}
+
+ktime_t hrtimer_cb_get_time(const struct hrtimer *timer)
+{
+	return __hrtimer_cb_get_time(timer->base->clockid);
+}
+EXPORT_SYMBOL_GPL(hrtimer_cb_get_time);
+
 static void __hrtimer_setup(struct hrtimer *timer,
 			    enum hrtimer_restart (*function)(struct hrtimer *),
 			    clockid_t clock_id, enum hrtimer_mode mode)
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index b03d0ad..488e47e 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -102,8 +102,6 @@ print_base(struct seq_file *m, struct hrtimer_clock_base =
*base, u64 now)
 	SEQ_printf(m, "  .index:      %d\n", base->index);
=20
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
-
-	SEQ_printf(m,   "  .get_time:   %ps\n", base->get_time);
 #ifdef CONFIG_HIGH_RES_TIMERS
 	SEQ_printf(m, "  .offset:     %Lu nsecs\n",
 		   (unsigned long long) ktime_to_ns(base->offset));
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 9844567..ccc24d3 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -56,8 +56,6 @@ def print_base(base):
     text +=3D " .index:      {}\n".format(base['index'])
=20
     text +=3D " .resolution: {} nsecs\n".format(constants.LX_hrtimer_resolut=
ion)
-
-    text +=3D " .get_time:   {}\n".format(base['get_time'])
     if constants.LX_CONFIG_HIGH_RES_TIMERS:
         text +=3D "  .offset:     {} nsecs\n".format(base['offset'])
     text +=3D "active timers:\n"

