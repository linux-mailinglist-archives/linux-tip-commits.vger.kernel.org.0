Return-Path: <linux-tip-commits+bounces-1330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCB88D7ECA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82FD1F283E6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8786AE5;
	Mon,  3 Jun 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3YyjBVf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/BmvQsV1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62286131;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407015; cv=none; b=jCe9cnKOIsAJYkIqM0FX4NZELLHMxn/FgUjaz8xZrlbNn7NvV/uV4oW3ofQf2v23R6LLekaRYWE5jG8NqpiM/97c9MtzrhJdqTkRG9s9HoYOr+GM6KsiW5bzHTac+3D11S25kssO/EQ84tc8AqSzR04OXNIletqXYBUz7nT4RcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407015; c=relaxed/simple;
	bh=sEATbtpkzBgIxUg6hJ9RpoZQVd2Jw9ZvM/T6vKh0OW4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ttygNQAJnDOS4igMDYCp8Rem/8990afNp9qthqu0xY3/yX9uxRH9AZv05lEFA4cu7QcE984xiio0B8VIrk+U+MlSBsihRA1ik/aKQ6/5JsI64QvH8cXkIjS6CVkAwCLM6uBUNgNBIGpLsmQ5TS/DztjJG+4GeQalhhgg9m4uQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3YyjBVf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/BmvQsV1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMSL6Hm2n1vn4qtn/uTuywZj2C5pq9snXf7ajBWy+fQ=;
	b=j3YyjBVfHRBz3E8o5MZEyWNA8DtaFCaPLL86ghRM8ChFpluF39sEhAW+PiepCp5eHbX0TB
	O3lk83XCuLkNnFcHdo0iw8XAbTzCHwrrlW668UigofRYwbnoN2EEV0T0shjytSQ8E47/rQ
	BOQAp1P0NYl0VcoYNAVy6OZp7C1H6tkt4cu1ok1yhMWDchRFm2b4PhjvP7p+QEq/7pAnxF
	mc2VSxwct/Ot7Owivhl/EptIbirVdNvss7BXSdxpgKTLZqEHttXfU2a6FQ/NRjFLXGpGGv
	sw5Xhlx9umOrP0yVRVCkSL02O72XSCoRr5Odd79YG2cShmNp9uFTVwsToKuzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMSL6Hm2n1vn4qtn/uTuywZj2C5pq9snXf7ajBWy+fQ=;
	b=/BmvQsV19dal53kq8VhTrOz3y4B+nQTUG9hO0clBh0Dl/Dev/AEOwTgNa5p7Nj9sQZyQo/
	NRTp9rqRyQUj/YDw==
From: "tip-bot2 for Lakshmi Sowjanya D" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Provide infrastructure for converting
 to/from a base clock
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-2-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-2-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700947.10875.17247952821923538605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6b2e29977518ec13ef3022f234ff8f3014c243da
Gitweb:        https://git.kernel.org/tip/6b2e29977518ec13ef3022f234ff8f3014c243da
Author:        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
AuthorDate:    Mon, 13 May 2024 16:08:02 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

timekeeping: Provide infrastructure for converting to/from a base clock

Hardware time stamps like provided by PTP clock implementations are based
on a clock which feeds both the PCIe device and the system clock. For
further processing the underlying hardwarre clock timestamp must be
converted to the system clock.

Right now this requires drivers to invoke an architecture specific
conversion function, e.g. to convert the ART (Always Running Timer)
timestamp to a TSC timestamp.

As the system clock is aware of the underlying base clock, this can be
moved to the core code by providing a base clock property for the system
clock which contains the conversion factors and assigning a clocksource ID
to the base clock.

Add the required data structures and the conversion infrastructure in the
core code to prepare for converting X86 and the related PTP drivers over.

[ tglx: Added a missing READ_ONCE(). Massaged change log ]

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-2-lakshmi.sowjanya.d@intel.com

---
 include/linux/clocksource.h | 27 +++++++++++++++++++++++-
 include/linux/timekeeping.h |  2 ++-
 kernel/time/timekeeping.c   | 42 +++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b55..d35b677 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+struct clocksource_base;
 struct clocksource;
 struct module;
 
@@ -50,6 +51,7 @@ struct module;
  *			multiplication
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
+ * @freq_khz:		Clocksource frequency in khz.
  * @rating:		Rating value for selection (higher is better)
  *			To avoid rating inflation the following
  *			list should give you a guide as to how
@@ -70,6 +72,8 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base:		Hardware abstraction for clock on which a clocksource
+ *			is based
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -107,10 +111,12 @@ struct clocksource {
 	u64			max_cycles;
 	const char		*name;
 	struct list_head	list;
+	u32			freq_khz;
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base *base;
 
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -306,4 +312,25 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
 
 void clocksource_verify_percpu(struct clocksource *cs);
 
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clocksource
+ *			is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID in certain snapshot
+ *			functions to allow callers to validate the clocksource from
+ *			which the snapshot was taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the clocksource
+ * @denominator:	Denominator of the clock ratio between base clock and the clocksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0ea7823..b2ee182 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -310,10 +310,12 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @use_nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			use_nsecs;
 };
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e18db1..3096e10 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1195,6 +1195,46 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 	return false;
 }
 
+static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	if (!numerator || !denominator)
+		return false;
+
+	res = div64_u64_rem(*val, denominator, &rem) * numerator;
+	*val = res + div_u64(rem * numerator, denominator);
+	return true;
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base;
+	u32 num, den;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id == scv->cs_id)
+		return true;
+
+	/*
+	 * Check whether cs_id matches the base clock. Prevent the compiler from
+	 * re-evaluating @base as the clocksource might change concurrently.
+	 */
+	base = READ_ONCE(cs->base);
+	if (!base || base->id != scv->cs_id)
+		return false;
+
+	num = scv->use_nsecs ? cs->freq_khz : base->numerator;
+	den = scv->use_nsecs ? USEC_PER_SEC : base->denominator;
+
+	if (!convert_clock(&scv->cycles, num, den))
+		return false;
+
+	scv->cycles += base->offset;
+	return true;
+}
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1241,7 +1281,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * installed timekeeper clocksource
 		 */
 		if (system_counterval.cs_id == CSID_GENERIC ||
-		    tk->tkr_mono.clock->id != system_counterval.cs_id)
+		    !convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 

