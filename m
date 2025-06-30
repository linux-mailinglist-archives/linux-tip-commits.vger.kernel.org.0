Return-Path: <linux-tip-commits+bounces-5949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFCAEE1E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D72916BCE1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0828EA6F;
	Mon, 30 Jun 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cofGdp9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2EeFvZd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C728DEFF;
	Mon, 30 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295925; cv=none; b=NH8qlY7UM1gca2ei2HOx4btrZ+A1ED2JlzY79ftlriieRXQHbrLfyyY1FKP/nw4DygjwAO1VBb/UFj0Fpv3bXvIZlozK9JvP3AoWq/YWh1Zlw6gZPqZhzNZJE7O0lZ+LgTLTC/SeRsA1R62vdA1J4EHuDHj7nTMQFE7RN18HnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295925; c=relaxed/simple;
	bh=Hig8gY5a7pYZlYQ0lRwbDDSpM5MG57PDLXXf/mGO+3Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kICKTNNhbtsLKASV7l4ZocXW+6Vo7v2DFPLRHmFmeNRzNciOIpBKcp/CN9yjr9lyNDc6BdTNdpYMAez/UaDLExoS9rXiDtST7zhFQK2aeDHrMDRrzHpxUWTgP3T6HF9ggYOmGiYaDhKD57dPgGeWmFUse14miMzbWbm++Z8bgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cofGdp9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2EeFvZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3DqfwScTmTvLdmXl1/nvqzxgHQILPg2aZEgrqyg7M4=;
	b=2cofGdp9RatpokcuIxmoPGU6rMvO9au6FcmtUdx5X84XBrC9UMbC/pPdKF1E4ONTGktKnp
	dJ3zYLqzOoJtTEdagOKE7JCgoI18n5THspbrTJS1ydhsyBevKnLwc2aQ91sQItPIKGXNzo
	ZU87qNQqPSG1yoF84cTinP1dB+aGh2vjyJIECFXpQSvOQ0mtdiQBqvkBB8LvSzbIWnU7Du
	43+PnMO2ol2UumKikuKIPXIU8LCxOpQ2Xi83NqMMEaiHvlyEoTpvmm/tMG55riAk78ua05
	ZGynE6UDvJLPCEogH3S8bOb7FqwOIeKQDGDf2r4pTSkRiwLxymo9StVZfc8wpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3DqfwScTmTvLdmXl1/nvqzxgHQILPg2aZEgrqyg7M4=;
	b=+2EeFvZd/vTAZMmDwglj+4GUAC5bt+Gxv0u33JCGaVvsqMk5Mv1yJhL0IHlCYKXB7OUzJE
	YA/OI1nBLdxR0XCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Make do_adjtimex() reusable
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.187322876@linutronix.de>
References: <20250625183758.187322876@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592074.406.6151442701364229051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     775f71ebedd382da390dc16a4c28cffa5b937f79
Gitweb:        https://git.kernel.org/tip/775f71ebedd382da390dc16a4c28cffa5b937f79
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Make do_adjtimex() reusable

Split out the actual functionality of adjtimex() and make do_adjtimex() a
wrapper which feeds the core timekeeper into it and handles the result
including audit at the call site.

This allows to reuse the actual functionality for auxiliary clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.187322876@linutronix.de

---
 kernel/time/timekeeping.c | 102 ++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e893557..0de6131 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2585,17 +2585,18 @@ unsigned long random_get_entropy_fallback(void)
 }
 EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
-/**
- * do_adjtimex() - Accessor function to NTP __do_adjtimex function
- * @txc:	Pointer to kernel_timex structure containing NTP parameters
- */
-int do_adjtimex(struct __kernel_timex *txc)
+struct adjtimex_result {
+	struct audit_ntp_data	ad;
+	struct timespec64	delta;
+	bool			clock_set;
+};
+
+static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
+			 struct adjtimex_result *result)
 {
-	struct tk_data *tkd = &tk_core;
-	struct timespec64 delta, ts;
-	struct audit_ntp_data ad;
-	bool offset_set = false;
-	bool clock_set = false;
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
+	struct timespec64 ts;
+	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2604,56 +2605,65 @@ int do_adjtimex(struct __kernel_timex *txc)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	audit_ntp_init(&ad);
-
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	scoped_guard (raw_spinlock_irqsave, &tkd->lock) {
-		struct timekeeper *tks = &tkd->shadow_timekeeper;
-		s32 orig_tai, tai;
+	guard(raw_spinlock_irqsave)(&tkd->lock);
 
-		if (!tks->clock_valid)
-			return -ENODEV;
-
-		if (txc->modes & ADJ_SETOFFSET) {
-			delta.tv_sec  = txc->time.tv_sec;
-			delta.tv_nsec = txc->time.tv_usec;
-			if (!(txc->modes & ADJ_NANO))
-				delta.tv_nsec *= 1000;
-			ret = __timekeeping_inject_offset(tkd, &delta);
-			if (ret)
-				return ret;
-
-			offset_set = delta.tv_sec != 0;
-			clock_set = true;
-		}
+	if (!tks->clock_valid)
+		return -ENODEV;
 
-		orig_tai = tai = tks->tai_offset;
-		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
+	if (txc->modes & ADJ_SETOFFSET) {
+		result->delta.tv_sec  = txc->time.tv_sec;
+		result->delta.tv_nsec = txc->time.tv_usec;
+		if (!(txc->modes & ADJ_NANO))
+			result->delta.tv_nsec *= 1000;
+		ret = __timekeeping_inject_offset(tkd, &result->delta);
+		if (ret)
+			return ret;
+		result->clock_set = true;
+	}
 
-		if (tai != orig_tai) {
-			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
-			clock_set = true;
-		} else {
-			tk_update_leap_state_all(&tk_core);
-		}
+	orig_tai = tai = tks->tai_offset;
+	ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &result->ad);
 
-		/* Update the multiplier immediately if frequency was set directly */
-		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+	if (tai != orig_tai) {
+		__timekeeping_set_tai_offset(tks, tai);
+		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
+		result->clock_set = true;
+	} else {
+		tk_update_leap_state_all(&tk_core);
 	}
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		result->clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+
+	return ret;
+}
+
+/**
+ * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
+ */
+int do_adjtimex(struct __kernel_timex *txc)
+{
+	struct adjtimex_result result = { };
+	int ret;
+
+	ret = __do_adjtimex(&tk_core, txc, &result);
+	if (ret < 0)
+		return ret;
+
 	if (txc->modes & ADJ_SETOFFSET)
-		audit_tk_injoffset(delta);
+		audit_tk_injoffset(result.delta);
 
-	audit_ntp_log(&ad);
+	audit_ntp_log(&result.ad);
 
-	if (clock_set)
+	if (result.clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer(offset_set);
+	ntp_notify_cmos_timer(result.delta.tv_sec != 0);
 
 	return ret;
 }

