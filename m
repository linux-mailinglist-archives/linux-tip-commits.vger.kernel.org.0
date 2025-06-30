Return-Path: <linux-tip-commits+bounces-5953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B108AEE1EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAEE16D79B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834B290DB2;
	Mon, 30 Jun 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zl2KckBO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoAu+pIR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961C28FAB5;
	Mon, 30 Jun 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295928; cv=none; b=EkofyPZrXKvo63fH4LqUMEDEi8oNLzwAYHOgpMIBQ4kL12lSi2RUdBCoWOm6cCYb2ok9FfqFcrQ1jlqa1xKf7eLfjh/z0rJE23hQB12aoKhnt/liMxHuF63jB+XJIoeK2josi8WCAWY5oP9ATEsz2BfFD0+l7wBXvE2qx/ny1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295928; c=relaxed/simple;
	bh=VmwRtV4EDyoOJYMR9KncFFZ3QRzcR7AFXzCkOpnGsuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EOVC7g7BZ+rIEzyDNaS1zuuM9jEZF43Ujrjvi03c5MylVUc1CQECEA1vZcyRhyPIkTEQFp+F8LtwWgOy+rbRC/3TizWUpGtl0Nu/q1rS036OMuBERuf29jISZzcuPPmAHJmykiSfcqnPbEHMINoIRfN9Ylo5KnRE95pNnfwupmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zl2KckBO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoAu+pIR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsQWHYvdlvP7PY0Rcpt+MHy7s5iAeznkfeJ3TxbK5oI=;
	b=Zl2KckBOu1oM5jx54Zdj0Y+LwUnO1eZa2xK8YF8lDZVtdmiMg3fNn4GJOwQyhHulZHcQKO
	1ogHpJZoYdtTgiaKwie61/o646RdzGOEqR28SjD18F9kmHxto5h+wt12hTPf/XPGppkNrL
	KI1u4vSIhK8LI638Eegtmx6kiIvvEGsE5w9SeZeGFQLc0jnM9TWJW0MJNdPIx1dLAjlere
	mztCMi+zEuS+dlbUEVOywFOjOyOEQA1lx+dxPzxb03DS3juOo2RmHn34jSOgIPlrcRQiul
	sYBfMzxmqYkpmgzLGjBlBI1tlzB9P8KHgd97bviFvl0ei3QaM8Fx5HbN9lBPvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295924;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsQWHYvdlvP7PY0Rcpt+MHy7s5iAeznkfeJ3TxbK5oI=;
	b=uoAu+pIRWwrC6WWRDlKcR+ROcL7+XtgNr9pXtWSg2J925Tj3R2uB1LpV1kE6F2ERvleP+Y
	v7RWxZDyLAhBQaCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Provide time setter for auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183757.995688714@linutronix.de>
References: <20250625183757.995688714@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592353.406.12059259254019900229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     60ecc26ec5af567a55f362ad92c0cac8b894541c
Gitweb:        https://git.kernel.org/tip/60ecc26ec5af567a55f362ad92c0cac8b894541c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:12 +02:00

timekeeping: Provide time setter for auxiliary clocks

Add clock_settime(2) support for auxiliary clocks. The function affects the
AUX offset which is added to the "monotonic" clock readout of these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183757.995688714@linutronix.de

---
 kernel/time/timekeeping.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 10c6e37..b6ac784 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2765,9 +2765,53 @@ static int aux_get_timespec(clockid_t id, struct timespec64 *tp)
 	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
 }
 
+static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct timekeeper *aux_tks;
+	ktime_t tnow, nsecs;
+
+	if (!timespec64_valid_settod(tnew))
+		return -EINVAL;
+	if (!aux_tkd)
+		return -ENODEV;
+
+	aux_tks = &aux_tkd->shadow_timekeeper;
+
+	guard(raw_spinlock_irq)(&aux_tkd->lock);
+	if (!aux_tks->clock_valid)
+		return -ENODEV;
+
+	/* Forward the timekeeper base time */
+	timekeeping_forward_now(aux_tks);
+	/*
+	 * Get the updated base time. tkr_mono.base has not been
+	 * updated yet, so do that first. That makes the update
+	 * in timekeeping_update_from_shadow() redundant, but
+	 * that's harmless. After that @tnow can be calculated
+	 * by using tkr_mono::cycle_last, which has been set
+	 * by timekeeping_forward_now().
+	 */
+	tk_update_ktime_data(aux_tks);
+	nsecs = timekeeping_cycles_to_ns(&aux_tks->tkr_mono, aux_tks->tkr_mono.cycle_last);
+	tnow = ktime_add(aux_tks->tkr_mono.base, nsecs);
+
+	/*
+	 * Calculate the new AUX offset as delta to @tnow ("monotonic").
+	 * That avoids all the tk::xtime back and forth conversions as
+	 * xtime ("realtime") is not applicable for auxiliary clocks and
+	 * kept in sync with "monotonic".
+	 */
+	aux_tks->offs_aux = ktime_sub(timespec64_to_ktime(*tnew), tnow);
+
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+	return 0;
+}
+
 const struct k_clock clock_aux = {
 	.clock_getres		= aux_get_res,
 	.clock_get_timespec	= aux_get_timespec,
+	.clock_set		= aux_clock_set,
 };
 
 static __init void tk_aux_setup(void)

