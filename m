Return-Path: <linux-tip-commits+bounces-5909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6DAE8984
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041CE1C234D0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C82D660F;
	Wed, 25 Jun 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/Plz52z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xy3GKZPc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891F2C325B;
	Wed, 25 Jun 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868170; cv=none; b=gFXIKo2FfFVOduYpQTfm8I/BuUVPnt+3xEwSsrF8Vkc0Ybp6bcxjGMs32Qwo0j8vCh0SBC5whgouS4LAMQkkOoxW3wQ2wrHZz2SF7XstEucFuSYDVCD/1+oTjNdfYjcyxpfSjjJL56S5pS/DALoYIGnp+a85JEJIezWGL69rYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868170; c=relaxed/simple;
	bh=J+UOStcuZXniH6hr70Hckbwd5jNeAYRbXzs2bB/npjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iaq7CM1C0xqaIn/JL61ZXx/UnsBJpi7KTHKrl4feThrcTGbAKnlyLJbZTlh37y4908ZHqJqRWHq0SZKVFcqWQOUt7imV8C3BSyDgUvu97nHluDrETlnfvGLnRDOSI2ebYIugsz+VCiUHskNulytOiPIhripSMMdnT5yREAwivdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/Plz52z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xy3GKZPc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08MeqIU3o63vlnI1Ba2ZD7RMoxv2Z0UrjkjfVQgDyX4=;
	b=n/Plz52zTcRhESLXde9BviNTggzzgFJU6p0ApyHH0H4ksBivQhZakI7NvH7OD53HNQGEe1
	L2zR2IppGTD89jcJW/oJY8PWgLDYX5Q2/Wtik1I9T9ILm8+j0/aJSDkY5s6a+rl2U1s8gx
	g/hB44WV0DMBUlHNaV0nyKgkw5BaXlrUFYLAvDjnMxIoXXvxAk2GDpgUx85v4T404bIgpA
	sztDolFgUiAipXz8rFuu9yIH0fYhKHLcPKKSWhMzOQAybjzh7qSbSuZRMglQc+z9pWnnDP
	7bll1FqYjI7V/W+q5AjTcKdTKgpep3jU20VZsG/ExJg2cnVxLCWdwLelkpvwvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868166;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08MeqIU3o63vlnI1Ba2ZD7RMoxv2Z0UrjkjfVQgDyX4=;
	b=xy3GKZPcvyng+wLYqYcj0gUwFXrvivpjnsUwmyKZchgtBTf/V20+jiv2/UosGoxIHrV9Hl
	LQ/bHOxw7QELpnDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] time: Introduce auxiliary POSIX clocks
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.905800695@linutronix.de>
References: <20250519083025.905800695@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816568.406.6821399496495131726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     9094c72c3d81bf2416b7c79d12c8494ab8fbac20
Gitweb:        https://git.kernel.org/tip/9094c72c3d81bf2416b7c79d12c8494ab8fbac20
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

time: Introduce auxiliary POSIX clocks

To support auxiliary timekeeping and the related user space interfaces,
it's required to define a clock ID range for them.

Reserve 8 auxiliary clock IDs after the regular timekeeping clock ID space.

This is the maximum number of auxiliary clocks the kernel can support. The actual
number of supported clocks depends obviously on the presence of related devices
and might be constraint by the available VDSO space.

Add the corresponding timekeeper IDs as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083025.905800695@linutronix.de


---
 include/linux/timekeeper_internal.h | 10 ++++++++--
 include/uapi/linux/time.h           | 11 +++++++++++
 kernel/time/Kconfig                 | 15 +++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index bfcecad..4201ae8 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -13,11 +13,17 @@
 
 /**
  * timekeeper_ids - IDs for various time keepers in the kernel
- * @TIMEKEEPER_CORE:	The central core timekeeper managing system time
- * @TIMEKEEPERS_MAX:	The maximum number of timekeepers managed
+ * @TIMEKEEPER_CORE:		The central core timekeeper managing system time
+ * @TIMEKEEPER_AUX_FIRST:	The first AUX timekeeper
+ * @TIMEKEEPER_AUX_LAST:	The last AUX timekeeper
+ * @TIMEKEEPERS_MAX:		The maximum number of timekeepers managed
  */
 enum timekeeper_ids {
 	TIMEKEEPER_CORE,
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	TIMEKEEPER_AUX_FIRST,
+	TIMEKEEPER_AUX_LAST = TIMEKEEPER_AUX_FIRST + MAX_AUX_CLOCKS - 1,
+#endif
 	TIMEKEEPERS_MAX,
 };
 
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 4f4b6e4..16ca1ac 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -64,6 +64,17 @@ struct timezone {
 #define CLOCK_TAI			11
 
 #define MAX_CLOCKS			16
+
+/*
+ * AUX clock support. AUXiliary clocks are dynamically configured by
+ * enabling a clock ID. These clock can be steered independently of the
+ * core timekeeper. The kernel can support up to 8 auxiliary clocks, but
+ * the actual limit depends on eventual architecture constraints vs. VDSO.
+ */
+#define CLOCK_AUX			MAX_CLOCKS
+#define MAX_AUX_CLOCKS			8
+#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
+
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
 #define CLOCKS_MONO			CLOCK_MONOTONIC
 
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b0b97a6..7c6a52f 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -82,9 +82,9 @@ config CONTEXT_TRACKING_IDLE
 	help
 	  Tracks idle state on behalf of RCU.
 
-if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
+if GENERIC_CLOCKEVENTS
 # Core internal switch. Selected by NO_HZ_COMMON / HIGH_RES_TIMERS. This is
 # only related to the tick functionality. Oneshot clockevent devices
 # are supported independent of this.
@@ -208,6 +208,17 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 	  interval and NTP's maximum frequency drift of 500 parts
 	  per million.	If the clocksource is good enough for NTP,
 	  it is good enough for the clocksource watchdog!
+endif
+
+config POSIX_AUX_CLOCKS
+	bool "Enable auxiliary POSIX clocks"
+	depends on POSIX_TIMERS
+	help
+	  Auxiliary POSIX clocks are clocks which can be steered
+	  independently of the core timekeeper, which controls the
+	  MONOTONIC, REALTIME, BOOTTIME and TAI clocks.  They are useful to
+	  provide e.g. lockless time accessors to independent PTP clocks
+	  and other clock domains, which are not correlated to the TAI/NTP
+	  notion of time.
 
 endmenu
-endif

