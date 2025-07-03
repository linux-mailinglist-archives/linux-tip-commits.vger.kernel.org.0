Return-Path: <linux-tip-commits+bounces-5984-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6CAF749C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA04189428D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B22E6D2A;
	Thu,  3 Jul 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7E3Dbg9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQciNWqF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305D2E54BF;
	Thu,  3 Jul 2025 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546985; cv=none; b=WalUAK9y76JEBJs0QFI9+7uBNpLGb9i0J4kc/7a8yDINvbFGWePhjzXVymLmlB21r0CagvpZ7DIuc5tkI2rn/gkPMlzCbeYdIiNwKzlkFekiItxG929hNLBO+Poh0vVXvFgB9HmpwrrFgsDtrnFVK7UICqn0k8T0qTtnshSjtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546985; c=relaxed/simple;
	bh=IdWOOvlRMfqTK0x5xPDEDQJQZYKBjvntK092U9eF7MM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RAkSG/hvQ4ETVTwrilmMHcMQrxeMQgJtUQlYv2Rh6p6QbRXSyrsZ2ZI2pJK5P/7kh0ZOiDiXcS7PfHWwMz96QfBZKtErDcttY/XBLFqrKHoIuRezJ9zjCzk7CAdpVQ6xsuHSMvMqqGlGHiwpMn1DfH70FEpB8f3V4q1wxbZ1Jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7E3Dbg9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQciNWqF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 12:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlcEuG15kT93IK5PKW81gN+wtC9gnI8l3WpgNIvutBo=;
	b=C7E3Dbg9jkSFe4CxRLgVSLpuTA5xFHT8F+GjnEP/yO6iM//M2Qlmfw6156Lz6tUGBWbzHV
	NTUspyPdkkCJykCxjxvHOE5XYg9i1Ei4TitJsqx03NcZze7LDzLNZhVh2FTjl4ZBly+Sc5
	1BkDZ2gmcfdUCzv9Fx5YEa0KN/1DKHDphbLyovTQE/OAMrzKIpFZ3PC34ytAaWLyHRlKZj
	yADhOGJHmtNJtMIwnE8IL1dZNEtnJJHnoNYmdcQC8UDPtbI+1Oe/PyqB/ovoCcK8pbei/j
	wAcsEUYd1PrgmA8Pz6JmLbKFHUmOkl6B3JGghPpa7vmV1e/G5UIPkn+mkABYzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlcEuG15kT93IK5PKW81gN+wtC9gnI8l3WpgNIvutBo=;
	b=DQciNWqFzIOR79aX6HzDTYxyJlFFZWha+YiCLd5+9vc947Niz9c9lqjwK1pmzzcO9BRDxl
	K9fS2p/jTXbc+xCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Provide ktime_get_clock_ts64()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701132628.357686408@linutronix.de>
References: <20250701132628.357686408@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175154698040.406.6091128422197349668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     5b605dbee07dda8fd538af1f07cbf1baf0a49cbc
Gitweb:        https://git.kernel.org/tip/5b605dbee07dda8fd538af1f07cbf1baf0a49cbc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 15:26:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 14:18:06 +02:00

timekeeping: Provide ktime_get_clock_ts64()

PTP implements an inline switch case for taking timestamps from various
POSIX clock IDs, which already consumes quite some text space. Expanding it
for auxiliary clocks really becomes too big for inlining.

Provide a out of line version. 

The function invalidates the timestamp in case the clock is invalid. The
invalidation allows to implement a validation check without the need to
propagate a return value through deep existing call chains.

Due to merge logistics this temporarily defines CLOCK_AUX[_LAST] if
undefined, so that the plain branch, which does not contain any of the core
timekeeper changes, can be pulled into the networking tree as prerequisite
for the PTP side changes. These temporary defines are removed after that
branch is merged into the tip::timers/ptp branch. That way the result in
-next or upstream in the next merge window has zero dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250701132628.357686408@linutronix.de

---
 include/linux/timekeeping.h | 10 ++++++++++
 kernel/time/timekeeping.c   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5427736..4a4c277 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
 
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
@@ -345,4 +346,13 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 extern int update_persistent_clock64(struct timespec64 now);
 #endif
 
+/* Temporary workaround to avoid merge dependencies and cross tree messes */
+#ifndef CLOCK_AUX
+#define CLOCK_AUX			MAX_CLOCKS
+#define MAX_AUX_CLOCKS			8
+#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
+
+static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+#endif
+
 #endif
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91..572e3bd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1573,6 +1573,39 @@ void ktime_get_raw_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
+/**
+ * ktime_get_clock_ts64 - Returns time of a clock in a timespec
+ * @id:		POSIX clock ID of the clock to read
+ * @ts:		Pointer to the timespec64 to be set
+ *
+ * The timestamp is invalidated (@ts->sec is set to -1) if the
+ * clock @id is not available.
+ */
+void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
+{
+	/* Invalidate time stamp */
+	ts->tv_sec = -1;
+	ts->tv_nsec = 0;
+
+	switch (id) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC_RAW:
+		ktime_get_raw_ts64(ts);
+		return;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			ktime_get_aux_ts64(id, ts);
+		return;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
 
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres

