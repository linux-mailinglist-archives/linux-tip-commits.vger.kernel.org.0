Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554BE2B3A6B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgKOWvV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgKOWvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60971C0613CF;
        Sun, 15 Nov 2020 14:51:07 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XG8lgep86k2y56aS5VtVJadB8ki5ptTEPhMyTxR9rsA=;
        b=oJjl88wFsZpOD4u0HepLHgElUG0oX4dk0RoGgY1QzLCogeF9SBfP2ZNU3r50cnpuL27wxP
        X6H+pWT00uOe1h03OvU8RZsEPlQb+/7d96twYYGLW+tjhf+f4XhGZ+/QHDsd659e7+oaRS
        LiNhpAUcWIpql6MqRB7kRHiRdLOz34Dxso8agGeodJ73svfzpI49ISi17xPCcRQJk5VY0Z
        GNIdFZyQ9IWa5gnqquY0FL4Ds0bZhAvfCC5usJ8ylIBmmsMApyRhz7uC5rdZNjDIbiNnHZ
        T2UnBufXtmdsH24j0uFm+GySICAI9tcCvLEYhtQrCSlyn7GjR4Ktt1HkFn6M1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480665;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XG8lgep86k2y56aS5VtVJadB8ki5ptTEPhMyTxR9rsA=;
        b=EoYLdtsvNDIj+pBsJQVj+3V42Z+5Hh4diaM6zdaScCr8adeUaZ+78lPSceEDTmt6B2+GjJ
        k+rYsmUnzeXWz1DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix up function documentation for the
 NMI safe accessors
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160548066511.11244.3059760643732979841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c1ce406e80fb15fa52b2b48dfd48fad6f3d2a32f
Gitweb:        https://git.kernel.org/tip/c1ce406e80fb15fa52b2b48dfd48fad6f3d2a32f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Nov 2020 21:09:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:24 +01:00

timekeeping: Fix up function documentation for the NMI safe accessors

Alex reported the following warning:

 kernel/time/timekeeping.c:464: warning: Function parameter or member
 'tkf' not described in '__ktime_get_fast_ns'

which is not entirely correct because the documented function is
ktime_get_mono_fast_ns() which does not have a parameter, but the
kernel-doc parser looks at the function declaration which follows the
comment and complains about the missing parameter documentation.

Aside of that the documentation for the rest of the NMI safe accessors is
either incomplete or missing.

  - Move the function documentation to the right place
  - Fixup the references and inconsistencies
  - Add the missing documentation for ktime_get_raw_fast_ns()

Reported-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c | 58 +++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a823703..ab4b831 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -437,6 +437,27 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
 
+static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
+{
+	struct tk_read_base *tkr;
+	unsigned int seq;
+	u64 now;
+
+	do {
+		seq = raw_read_seqcount_latch(&tkf->seq);
+		tkr = tkf->base + (seq & 0x01);
+		now = ktime_to_ns(tkr->base);
+
+		now += timekeeping_delta_to_ns(tkr,
+				clocksource_delta(
+					tk_clock_read(tkr),
+					tkr->cycle_last,
+					tkr->mask));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
+
+	return now;
+}
+
 /**
  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
  *
@@ -463,39 +484,24 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
  *
  * So reader 6 will observe time going backwards versus reader 5.
  *
- * While other CPUs are likely to be able observe that, the only way
+ * While other CPUs are likely to be able to observe that, the only way
  * for a CPU local observation is when an NMI hits in the middle of
  * the update. Timestamps taken from that NMI context might be ahead
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
-static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
-{
-	struct tk_read_base *tkr;
-	unsigned int seq;
-	u64 now;
-
-	do {
-		seq = raw_read_seqcount_latch(&tkf->seq);
-		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base);
-
-		now += timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
-	} while (read_seqcount_latch_retry(&tkf->seq, seq));
-
-	return now;
-}
-
 u64 ktime_get_mono_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_mono);
 }
 EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
 
+/**
+ * ktime_get_raw_fast_ns - Fast NMI safe access to clock monotonic raw
+ *
+ * Contrary to ktime_get_mono_fast_ns() this is always correct because the
+ * conversion factor is not affected by NTP/PTP correction.
+ */
 u64 ktime_get_raw_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_raw);
@@ -522,6 +528,9 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
+ *
+ * The caveats vs. timestamp ordering as documented for ktime_get_fast_ns()
+ * apply as well.
  */
 u64 notrace ktime_get_boot_fast_ns(void)
 {
@@ -531,9 +540,6 @@ u64 notrace ktime_get_boot_fast_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
 
-/*
- * See comment for __ktime_get_fast_ns() vs. timestamp ordering
- */
 static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 {
 	struct tk_read_base *tkr;
@@ -558,6 +564,8 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 
 /**
  * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
+ *
+ * See ktime_get_fast_ns() for documentation of the time stamp ordering.
  */
 u64 ktime_get_real_fast_ns(void)
 {
