Return-Path: <linux-tip-commits+bounces-3255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D76A12B31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 19:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308BE1885E32
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C61D63C0;
	Wed, 15 Jan 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ST1SHREk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2O6pxK+U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60261D88AD;
	Wed, 15 Jan 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967266; cv=none; b=thWSERjwk0Ht3/owPd/p9D94yNgpy/VL5l6DV6JMsb59K38CDOJkQaEZk5gKP2/SU+Rlv0Mq+FRKoUAekwp7n//QIvNI0uAlJjpjHzuYJ3wTs0lzjuxT35XobXATGzruT4gzQju532AM4StbBAQLAgaMQ+hJRuaXi2cnEAeXqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967266; c=relaxed/simple;
	bh=1+xPG6pmcuU5mUp3t9kRj0Efkdmo4oY7M+n79+qAZGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aFq7sZi+I2SpRJMH3n99AEn31i2pftquDihMiau/wFY0xij1IYdAYgfXBMR0hEZ+Giw6xxImKTOKLIX+PGRErVBW7u0O53q3JQD6/0Ys92ipOFUmcSFhQvmCZ91Y48XzeYMmZDt2UwVGLDZHtkeK4lPK1VMyxoaR3gdNNSfpfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ST1SHREk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2O6pxK+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 18:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736967262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTXyWXZr96qpeq/kTIlIu9clYEXj9B08UOg47g/J6Zs=;
	b=ST1SHREkmMYJX4zvyvCjXbT4Gav/TF/ly5M1A74hci6zNNvVuvJcBQyZDqsGmXlW/igX+0
	1fK3p94bUwvyaL23DfuG1z1hIjl74oYUFqU6V4eCp1Wo1+g2HG1Dm9oySNYJGZaZFHBaZK
	czJBrpi88SpSTJpNxMgicBHamRE/HNrFPvckfFB7eCxvHXjD1wD/dPZ17i7/CQAy3jNAlx
	N5bjEJGnPzv/IalO/UhGwrS3b9C3aAme0XmnBi0vAJp/M7ODtT0xMLkqTKwesEKFaw+80z
	QQVuCA9WBEXr02419wl4BNJ/eXA8dGaBQPWOqfn+1XZXvNDIm9qmUgrVkG3iGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736967262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTXyWXZr96qpeq/kTIlIu9clYEXj9B08UOg47g/J6Zs=;
	b=2O6pxK+UQVdXKuXv/9ZVK6xPgkVFaYzAsw1Jl5nxdRTbRtT/fT4Q4ynNe5hNYH3iIjsyZx
	StUs6szNZchX56Bg==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Remove unused ktime_get_fast_timestamps()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250112160132.450209-1-linux@treblig.org>
References: <20250112160132.450209-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696726061.31546.10518774114228471040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2d2a46cf23788a19e5450c6f9c86ab17f596c708
Gitweb:        https://git.kernel.org/tip/2d2a46cf23788a19e5450c6f9c86ab17f596c708
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Sun, 12 Jan 2025 16:01:32 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 19:49:14 +01:00

timekeeping: Remove unused ktime_get_fast_timestamps()

ktime_get_fast_timestamps() was added in 2020 by commit e2d977c9f1ab
("timekeeping: Provide multi-timestamp accessor to NMI safe timekeeper")
but has remained unused.

Remove it.

[ tglx: Fold the inline as David suggested in the submission ]

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250112160132.450209-1-linux@treblig.org

---
 include/linux/timekeeping.h | 15 +-------
 kernel/time/timekeeping.c   | 77 +++---------------------------------
 2 files changed, 8 insertions(+), 84 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0e035f6..5427736 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -264,18 +264,6 @@ extern bool timekeeping_rtc_skipresume(void);
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
 /**
- * struct ktime_timestamps - Simultaneous mono/boot/real timestamps
- * @mono:	Monotonic timestamp
- * @boot:	Boottime timestamp
- * @real:	Realtime timestamp
- */
-struct ktime_timestamps {
-	u64		mono;
-	u64		boot;
-	u64		real;
-};
-
-/**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
@@ -345,9 +333,6 @@ extern int get_device_system_crosststamp(
  */
 extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 
-/* NMI safe mono/boot/realtime timestamps */
-extern void ktime_get_fast_timestamps(struct ktime_timestamps *snap);
-
 /*
  * Persistent clock related interfaces
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3d12882..1e67d07 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -485,91 +485,30 @@ u64 notrace ktime_get_tai_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);
 
-static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
+/**
+ * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
+ *
+ * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
+ */
+u64 ktime_get_real_fast_ns(void)
 {
+	struct tk_fast *tkf = &tk_fast_mono;
 	struct tk_read_base *tkr;
-	u64 basem, baser, delta;
+	u64 baser, delta;
 	unsigned int seq;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
 		delta = timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
-	if (mono)
-		*mono = basem + delta;
 	return baser + delta;
 }
-
-/**
- * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
- *
- * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
- */
-u64 ktime_get_real_fast_ns(void)
-{
-	return __ktime_get_real_fast(&tk_fast_mono, NULL);
-}
 EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
 
 /**
- * ktime_get_fast_timestamps: - NMI safe timestamps
- * @snapshot:	Pointer to timestamp storage
- *
- * Stores clock monotonic, boottime and realtime timestamps.
- *
- * Boot time is a racy access on 32bit systems if the sleep time injection
- * happens late during resume and not in timekeeping_resume(). That could
- * be avoided by expanding struct tk_read_base with boot offset for 32bit
- * and adding more overhead to the update. As this is a hard to observe
- * once per resume event which can be filtered with reasonable effort using
- * the accurate mono/real timestamps, it's probably not worth the trouble.
- *
- * Aside of that it might be possible on 32 and 64 bit to observe the
- * following when the sleep time injection happens late:
- *
- * CPU 0				CPU 1
- * timekeeping_resume()
- * ktime_get_fast_timestamps()
- *	mono, real = __ktime_get_real_fast()
- *					inject_sleep_time()
- *					   update boot offset
- *	boot = mono + bootoffset;
- *
- * That means that boot time already has the sleep time adjustment, but
- * real time does not. On the next readout both are in sync again.
- *
- * Preventing this for 64bit is not really feasible without destroying the
- * careful cache layout of the timekeeper because the sequence count and
- * struct tk_read_base would then need two cache lines instead of one.
- *
- * Access to the time keeper clock source is disabled across the innermost
- * steps of suspend/resume. The accessors still work, but the timestamps
- * are frozen until time keeping is resumed which happens very early.
- *
- * For regular suspend/resume there is no observable difference vs. sched
- * clock, but it might affect some of the nasty low level debug printks.
- *
- * OTOH, access to sched clock is not guaranteed across suspend/resume on
- * all systems either so it depends on the hardware in use.
- *
- * If that turns out to be a real problem then this could be mitigated by
- * using sched clock in a similar way as during early boot. But it's not as
- * trivial as on early boot because it needs some careful protection
- * against the clock monotonic timestamp jumping backwards on resume.
- */
-void ktime_get_fast_timestamps(struct ktime_timestamps *snapshot)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	snapshot->real = __ktime_get_real_fast(&tk_fast_mono, &snapshot->mono);
-	snapshot->boot = snapshot->mono + ktime_to_ns(data_race(tk->offs_boot));
-}
-
-/**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
  * @tk: Timekeeper to snapshot.
  *

