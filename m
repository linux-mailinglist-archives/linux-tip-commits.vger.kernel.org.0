Return-Path: <linux-tip-commits+bounces-1323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2B8D7EBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2AB22D57
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0485947;
	Mon,  3 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c41ndSlt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11JNGyiK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435185928;
	Mon,  3 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407012; cv=none; b=fEbLqe3dtbtRrHzXj7VT/bopaIz8nqdCyFczmVIsxV7DVUJSfdDEu5mtGzfRp8rV9SaEAYp37jxOp55gBGREcD2S3SoD19dzFW68e4Ynd+TvCvWN7T4EYQKpY8llRshMR0SecrFUW24CSbzR1GUJWz8wRnRRoMWCE6Sh5oCvl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407012; c=relaxed/simple;
	bh=9MTQrwzkD9pYsjn+hfo3EjM7hxX+lCcbpkbaAzoiwFA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nNyj29u5REvxb3MXA4SBlYUmgn4a7V4sdP4qo0RgGggSFh3b/m29/CkttICJOklPhRmVTANMy+vRQsXZq2ANospAC5R7knB9w1ylRv6zFsV48FhUKTh7riWACSyU9wz6RGEi1hhHQjVXK7ZVhRssUfOCbRjiAeh8gnEJcPPJQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c41ndSlt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11JNGyiK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWzFvI1IdX1Ff6cp99AHs3tSAAGsWrvDrbhgbqDKY5Q=;
	b=c41ndSltGkml1JlQobzjXdm/wDsaTq7/ylxYUcfMZhvatYLSFYnmpl569TotqCcrSGxEpm
	U9pz7XOdXIOpOIu8/W/wmXUNS98xUBQi9BZWgRD5akrFuYd6smSqSeWAgbafTFLCbeVpqN
	fSFCMJduONFjfF2Tfvfmf80M3iudi81F0V3DqA2jW6XwYk0UWOtW6HAHftsX6zgXQtzX6I
	/xgH/hyAU0s0hRkOy2qEnHYs7nApF6xajsph3hdV56qeeAScV8PdA1Z3PBkpUb/gMhTDAK
	Qs+69VZSbTJaBPJrX2/5L2CmlDyn8GkJJ3+3YpbAvlt3Wf9OgiTMo3/fCE6jhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWzFvI1IdX1Ff6cp99AHs3tSAAGsWrvDrbhgbqDKY5Q=;
	b=11JNGyiKrH955nQUFGAgscSpHi+KreC3S16bS2ocGeKoqIp+HuvfdYrbcyNfoQhVJVg/cK
	bQsgOJESfNdpiIBQ==
From: "tip-bot2 for Lakshmi Sowjanya D" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add function to convert realtime to
 base clock
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-10-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-10-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700790.10875.12830194730255026022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     02ecee07ca30f76f2a0f1381661a688b8e501ab0
Gitweb:        https://git.kernel.org/tip/02ecee07ca30f76f2a0f1381661a688b8e501ab0
Author:        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
AuthorDate:    Mon, 13 May 2024 16:08:10 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:51 +02:00

timekeeping: Add function to convert realtime to base clock

PPS (Pulse Per Second) generates a hardware pulse every second based on
CLOCK_REALTIME. This works fine when the pulse is generated in software
from a hrtimer callback function.

For hardware which generates the pulse by programming a timer it is
required to convert CLOCK_REALTIME to the underlying hardware clock.

The X86 Timed IO device is based on the Always Running Timer (ART), which
is the base clock of the TSC, which is usually the system clocksource on
X86.

The core code already has functionality to convert base clock timestamps to
system clocksource timestamps, but there is no support for converting the
other way around.

Provide the required functionality to support such devices in a generic
way to avoid code duplication in drivers:

  1) ktime_real_to_base_clock() to convert a CLOCK_REALTIME timestamp to a
     base clock timestamp

  2) timekeeping_clocksource_has_base() to allow drivers to validate that
     the system clocksource is based on a particular clocksource ID.

[ tglx: Simplify timekeeping_clocksource_has_base() and add missing READ_ONCE() ]

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-10-lakshmi.sowjanya.d@intel.com

---
 include/linux/timekeeping.h |  4 ++-
 kernel/time/timekeeping.c   | 86 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b2ee182..fc12a9b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -318,6 +318,10 @@ struct system_counterval_t {
 	bool			use_nsecs;
 };
 
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3096e10..da984a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1235,6 +1235,68 @@ static bool convert_base_to_cs(struct system_counterval_t *scv)
 	return true;
 }
 
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base;
+
+	/*
+	 * Check whether base_id matches the base clock. Prevent the compiler from
+	 * re-evaluating @base as the clocksource might change concurrently.
+	 */
+	base = READ_ONCE(cs->base);
+	if (!base || base->id != base_id)
+		return false;
+
+	*cycles -= base->offset;
+	if (!convert_clock(cycles, base->denominator, base->numerator))
+		return false;
+	return true;
+}
+
+static bool convert_ns_to_cs(u64 *delta)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+
+	if (BITS_TO_BYTES(fls64(*delta) + tkr->shift) >= sizeof(*delta))
+		return false;
+
+	*delta = div_u64((*delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+	return true;
+}
+
+/**
+ * ktime_real_to_base_clock() - Convert CLOCK_REALTIME timestamp to a base clock timestamp
+ * @treal:	CLOCK_REALTIME timestamp to convert
+ * @base_id:	base clocksource id
+ * @cycles:	pointer to store the converted base clock timestamp
+ *
+ * Converts a supplied, future realtime clock value to the corresponding base clock value.
+ *
+ * Return:  true if the conversion is successful, false otherwise.
+ */
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		if ((u64)treal < tk->tkr_mono.base_real)
+			return false;
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (!convert_ns_to_cs(&delta))
+			return false;
+		*cycles = tk->tkr_mono.cycle_last + delta;
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1347,6 +1409,30 @@ int get_device_system_crosststamp(int (*get_time_fn)
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
 /**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *				      is based on given a base clock
+ * @id:		base clocksource ID
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *		after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *		false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	/*
+	 * This is a snapshot, so no point in using the sequence
+	 * count. Just prevent the compiler from re-evaluating @base as the
+	 * clocksource might change concurrently.
+	 */
+	struct clocksource_base *base = READ_ONCE(tk_core.timekeeper.tkr_mono.clock->base);
+
+	return base ? base->id == id : false;
+}
+EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
+
+/**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
  *

