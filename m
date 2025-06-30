Return-Path: <linux-tip-commits+bounces-5954-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00004AEE1EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C5B16F36E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA5291C3E;
	Mon, 30 Jun 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="INN762Cb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTogzbwU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FB290D8B;
	Mon, 30 Jun 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295930; cv=none; b=lsr161HIEESK3I7IGfH4xcCv25Dor2yl118SUj9ttzHsHX7jLP/x/teYIbBWE9BDGbr2YANBfcZPghj3hKMCIzdK3FtzkA/xXsmFeyZQQP0jsDh3CTw1hDimY+LaSQDe2z+RGsO6KEtMt1I13AmfJn+qq3+0jeDsFSS0ZPZyIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295930; c=relaxed/simple;
	bh=o0fbrnq+x0rSjFruvIJCGcmqftzZtEoRovkZI4KXIss=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WrG/gdyFZzk5idZLm4ghAtABgEVFQSjjFJ1+QVttK7swN4RvqwaE99d6LiXTTKdAyZaZldDUSlTgGiTsOz2o6huKA8O5dlmyxFR+zzI204pBL2kv2LfyPbdHLm7zaF8BmY/8k2mgSqDFjmzzV5Qt5EZGIoKicmdRaQwIV+Ctrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=INN762Cb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTogzbwU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4exhz2+BEyxSqZW15KPl1xHE4c1JOI/KSE6ggD781Xo=;
	b=INN762Cbm8de2udZBD4L2vDXOw18Jwp4L7kO7+4l4N3jCsqtawm2kRj13lDWbS3EotXj9I
	nJvPxgtnSLKlzWZIp5P3cFgwHMKCAue89dgOLQJFrpdde7ah5VbIcm5s72BW/7N9OJljtr
	bUbdYcHNwK3y5NrIcAJKD9KSLJ3JzPB7IXOaGrRafO0EGuOSnWAUK2MXdMH3N5hZkh09PS
	lzPadmW8d8s/ITwQbzFjEzP9M2280GHXyLFmnC2VRlILI71suAn3GcCUKXB0VmUdzLL4UM
	hrYII3rHnBFAeiqMxPnFF8ahVW6m4HzEYvAmMV+FWzS/J5YByYA4FWk3ZeiibA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4exhz2+BEyxSqZW15KPl1xHE4c1JOI/KSE6ggD781Xo=;
	b=jTogzbwUU9ZYy+DKdiMaeO16x3O3E172Y3kwBOEy6cae2j3kVQePTlNIDiwVLES8Lujlh/
	iD1BR128TjIS8HBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Provide time getters for auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183757.868342628@linutronix.de>
References: <20250625183757.868342628@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592549.406.13607208895915587892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     05bc6e6290f91d2d40086ab4ef52da21c14ec4b6
Gitweb:        https://git.kernel.org/tip/05bc6e6290f91d2d40086ab4ef52da21c14ec4b6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:12 +02:00

timekeeping: Provide time getters for auxiliary clocks

Provide interfaces similar to the ktime_get*() family which provide access
to the auxiliary clocks.

These interfaces have a boolean return value, which indicates whether the
accessed clock is valid or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183757.868342628@linutronix.de

---
 include/linux/posix-timers.h |  5 +++-
 include/linux/timekeeping.h  | 11 ++++++-
 kernel/time/timekeeping.c    | 65 +++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index dd48c64..4d3dbce 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -37,6 +37,11 @@ static inline int clockid_to_fd(const clockid_t clk)
 	return ~(clk >> 3);
 }
 
+static inline bool clockid_aux_valid(clockid_t id)
+{
+	return IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) && id >= CLOCK_AUX && id <= CLOCK_AUX_LAST;
+}
+
 #ifdef CONFIG_POSIX_TIMERS
 
 #include <linux/signal_types.h>
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5427736..de9a3b7 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -263,6 +263,17 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * Auxiliary clock interfaces
+ */
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+extern bool ktime_get_aux(clockid_t id, ktime_t *kt);
+extern bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt);
+#else
+static inline bool ktime_get_aux(clockid_t id, ktime_t *kt) { return false; }
+static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+#endif
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ee97570..c7d2913 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2664,6 +2664,18 @@ EXPORT_SYMBOL(hardpps);
  */
 static unsigned long aux_timekeepers;
 
+static inline unsigned int clockid_to_tkid(unsigned int id)
+{
+	return TIMEKEEPER_AUX_FIRST + id - CLOCK_AUX;
+}
+
+static inline struct tk_data *aux_get_tk_data(clockid_t id)
+{
+	if (!clockid_aux_valid(id))
+		return NULL;
+	return &timekeeper_data[clockid_to_tkid(id)];
+}
+
 /* Invoked from timekeeping after a clocksource change */
 static void tk_aux_update_clocksource(void)
 {
@@ -2684,6 +2696,59 @@ static void tk_aux_update_clocksource(void)
 	}
 }
 
+/**
+ * ktime_get_aux - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @kt:	Pointer to ktime_t to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux(clockid_t id, ktime_t *kt)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct timekeeper *aux_tk;
+	unsigned int seq;
+	ktime_t base;
+	u64 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	if (!aux_tkd)
+		return false;
+
+	aux_tk = &aux_tkd->timekeeper;
+	do {
+		seq = read_seqcount_begin(&aux_tkd->seq);
+		if (!aux_tk->clock_valid)
+			return false;
+
+		base = ktime_add(aux_tk->tkr_mono.base, aux_tk->offs_aux);
+		nsecs = timekeeping_get_ns(&aux_tk->tkr_mono);
+	} while (read_seqcount_retry(&aux_tkd->seq, seq));
+
+	*kt = ktime_add_ns(base, nsecs);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux);
+
+/**
+ * ktime_get_aux_ts64 - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @ts:	Pointer to timespec64 to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *ts)
+{
+	ktime_t now;
+
+	if (!ktime_get_aux(id, &now))
+		return false;
+	*ts = ktime_to_timespec64(now);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux_ts64);
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)

