Return-Path: <linux-tip-commits+bounces-5950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B5AEE1E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA183BB586
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768128F524;
	Mon, 30 Jun 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="laVG9han";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TX5bg0ZE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FA28DF3A;
	Mon, 30 Jun 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295926; cv=none; b=qrnumn8iA8j7uM+xkntjD9uSDmo2AbQat9XT714tZjW/ZGOP1Gm//8xIHr+u/dbjRRy7jolHwj0qxtsuYAiBD2UE3lSZHHrGEwCskMy/0sRyd07PeM+L3XsnSEF1qHLHBYWbAU8jMjMN5iRnCyiTxGk+Pys4St9y40WAlJS+Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295926; c=relaxed/simple;
	bh=kogOZ3G1yO4gVOJHba29qY4nGRU20GIjXn27f4tu2NU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TeIK8ncisTEFkt77uNJjVBCi74vwjpY21IKFTs2YtaOo1QtPc3Oc9Dc/faG5Lab6T7WrmMJZsgM5gyFTCuZGleKVTfBeS/tvIAhQO1r2FiIPipiQrXdkzT9+XWovVcVTU1VRmsKLYWjyYBt9Uv/Hue7k0qQsOXo0FWtUNfYSYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=laVG9han; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TX5bg0ZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcsywtIJ2lw/xEgrmmgR6ID9ivEzSa2zouo9A963Gbc=;
	b=laVG9han99aqoFC3z3jz/2l3tq6ldxWipNYaRR5aBIXcMljEtGaNmH3dPEltazEUSKPWCi
	t46ZpqGk2S+z2K4jVOvHGVM5J9EeW2/yy+GG/cZPf03dqbrAi1KgwlQNPL7B30N78VgNnI
	BFjPUbtr8vRZKIIxb57UllkRmQI00pmu5YgZu0OYmOdFuy4DlbwXI+ikp4o+LIIsv1a1D6
	VgU/0HupByLG4QesvI7w4S1cGkb7aXOO2nSMQBgXwK9szjCaLEH1ORvUYhchfxOihcW1jz
	GRLwg1sK7hMzYrP5r376BQJ7pZwtO0Vk2ShghnBh6JjgZFeeAM9bJo+3tExrMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcsywtIJ2lw/xEgrmmgR6ID9ivEzSa2zouo9A963Gbc=;
	b=TX5bg0ZEOR5D22MavhkTUBAuAvQdTShZLu9jRMBS8zK5kjWeL1MZL/98toaFk30ZGv1ZEL
	J0L+t73Co4hNKbDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Add auxiliary clock support to
 __timekeeping_inject_offset()
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.124057787@linutronix.de>
References: <20250625183758.124057787@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129592169.406.306754534390862380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     2c8aea59c206b12b436373861590baeda728be12
Gitweb:        https://git.kernel.org/tip/2c8aea59c206b12b436373861590baeda728be12
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Add auxiliary clock support to __timekeeping_inject_offset()

Redirect the relative offset adjustment to the auxiliary clock offset
instead of modifying CLOCK_REALTIME, which has no meaning in context of
these clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.124057787@linutronix.de

---
 kernel/time/timekeeping.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2d294cf..e893557 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1431,6 +1431,11 @@ int do_settimeofday64(const struct timespec64 *ts)
 }
 EXPORT_SYMBOL(do_settimeofday64);
 
+static inline bool timekeeper_is_core_tk(struct timekeeper *tk)
+{
+	return !IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) || tk->id == TIMEKEEPER_CORE;
+}
+
 /**
  * __timekeeping_inject_offset - Adds or subtracts from the current time.
  * @tkd:	Pointer to the timekeeper to modify
@@ -1448,16 +1453,34 @@ static int __timekeeping_inject_offset(struct tk_data *tkd, const struct timespe
 
 	timekeeping_forward_now(tks);
 
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tks), *ts);
-	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		timekeeping_restore_shadow(tkd);
-		return -EINVAL;
+	if (timekeeper_is_core_tk(tks)) {
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tks), *ts);
+		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+
+		tk_xtime_add(tks, ts);
+		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+	} else {
+		struct tk_read_base *tkr_mono = &tks->tkr_mono;
+		ktime_t now, offs;
+
+		/* Get the current time */
+		now = ktime_add_ns(tkr_mono->base, timekeeping_get_ns(tkr_mono));
+		/* Add the relative offset change */
+		offs = ktime_add(tks->offs_aux, timespec64_to_ktime(*ts));
+
+		/* Prevent that the resulting time becomes negative */
+		if (ktime_add(now, offs) < 0) {
+			timekeeping_restore_shadow(tkd);
+			return -EINVAL;
+		}
+		tks->offs_aux = offs;
 	}
 
-	tk_xtime_add(tks, ts);
-	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }

