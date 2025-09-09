Return-Path: <linux-tip-commits+bounces-6504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F499B4A624
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51277B8C15
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E91AA1D2;
	Tue,  9 Sep 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZfrfxNb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WMq/y6jl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBB274B59;
	Tue,  9 Sep 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408204; cv=none; b=ummbIUY03XK9q5dqxvYnfLFSVW9DIjfOopJbaYvNxVPsHMK1Ub9wsdQXdZhgLpV85AKppE8fJb6oFs0soeW4YDFAgOgIMbHBEo0phG1I4fgkuIcqcF0mEx95Ftu6ihhmg6RpiesMGaz1BMe6qgiIrGkZhclMSEQVywgOIsk640w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408204; c=relaxed/simple;
	bh=bSiy09kl9vyBr+AH5RmpBVSDADwDgC+UflcI34VjgSg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gpef1+EblezuKUB8vRbMbGzAfDSzac8RbSJACUc6FRYk2UX4ugH89npP9k5AlQovPvy84iBgCtZ8M7vGSZ3fuJXnb9zgKlF8iBjbTK0FhfySaAojk+ApSz/5Jk2pafdR/cW17zc6Q6UZatZFlYZtMQMXAkdt57h+0n3DJ6mVG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZfrfxNb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WMq/y6jl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 08:56:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFgQaAUTRKuWJ6/OEEh5Vi2Nhkq6AMZy+lG9lZxuLbw=;
	b=MZfrfxNbH58B4rKx5rPlaf/4XFXmbOSKg1NLdsV1eBrrsaPURAmW1qvZguWEbsrmYR4WGb
	qCQxhkI+oCNo2fALVRp6Qonfk1/ckY8ZVIzYAZ6Fjkb5JTJaGQPmRfxYN/tN/nfe0BfbsQ
	+wQeuf5yhca2KlwvDyI5k7e6mNNzjP8DbGApcpMkiXvToRg06VsVyoaJX3DHFN4CyYUk2u
	nCRa1K3rsVGQeCu0snMcsM6GigByRN6Cc8u6YYrFmSC7R/LAQKaY2TiKAPGyUn3RY3EJ9J
	+Do0cc/Sz0ip5Ggfh+MR6oeQZ8TsnOAm4IgcMqHTsYqmdHj5s6C+WK0n77k9pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFgQaAUTRKuWJ6/OEEh5Vi2Nhkq6AMZy+lG9lZxuLbw=;
	b=WMq/y6jlBv3btEtEKp6eSVsBDjNLmjp4YIBTcbNz+5BUbB4V4hb2nW9Mu66kWYKtvIk2K5
	qZpiX7cj8CoI6jCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Remove hrtimer_clock_base::get_time
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250812-hrtimer-cleanup-get_time-v1-8-b962cd9d9385@linutronix.de>
References:
 <20250812-hrtimer-cleanup-get_time-v1-8-b962cd9d9385@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740819618.1920.2252980357348613724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c37fc72e2662a01662cc9f7bbcbb91fd387f4b4b
Gitweb:        https://git.kernel.org/tip/c37fc72e2662a01662cc9f7bbcbb91fd387=
f4b4b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 08:08:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:53:30 +02:00

hrtimer: Remove hrtimer_clock_base::get_time

The get_time() callbacks always need to match the bases clockid.
Instead of maintaining that association twice in hrtimer_bases,
use a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-hrtimer-cleanup-get_time-v1-8-b962=
cd9d9385@linutronix.de
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
index 30899a8..4ce754a 100644
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
+	case CLOCK_REALTIME:
+		return ktime_get_real();
+	case CLOCK_MONOTONIC:
+		return ktime_get();
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

