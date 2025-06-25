Return-Path: <linux-tip-commits+bounces-5899-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E1AE8972
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CB018808EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216C2BF01D;
	Wed, 25 Jun 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCivYQv7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ArnlDkv5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA331B042E;
	Wed, 25 Jun 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868159; cv=none; b=O8bBoKrDbALt9iDM1qFlB3PhcWAf1uF295lbpfyqQyTt5wLD8COomTIUQsUKIhGBVBzlU7Q1ON0Bah4TBtjeX4XKdga0Z8tTxHjLlL4LvQmiOpBEmlNhlOfrCNU/qmwq0+FhnmZ3jEYWcW5mAF5ixumoEMO0DulrDpTpvtgaA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868159; c=relaxed/simple;
	bh=S9G4uE4WzaqwY1rpSP3VMiH37x9vdt9iuBEGxkYSpVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bq88uA9g6eoJzdECEqVMgebt1ZacvlKWdfb38F00dkqj0OCMkBdxH3bcjOY5roVsx5a8Cx9RXpA5wW8NB6WZooXsA0k7O2cpSMT3SFdt0i/Lt5/wtF3FRdZQ54D0yjuwLtDb0ZAX9plXx/sc4z3xvfunT3KR541LNMbpTuPuosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCivYQv7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ArnlDkv5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87tC2vKSttM87WL045LNXUb5mncoJsQXGoxqcGhk7rg=;
	b=BCivYQv78w3PANLkNe4WeaCGM7h81s9A/3qItO8CeAxNXZ1Cvw0bnahG7ypOaSKf7bJ5dY
	KWn+/hlo4Z85Hn/S7ZpZbt/b/hLGXUKyx5YVbomkq/Dpht4fuegLqgyHvj92S9sVci5l9k
	iBV5K55IPUuQIVBGcwVvwLX/wIMjZYgY5fWVpJiuGik2ezkS+GJAJzQD70Di4yLIqXe3rY
	Ieth6afZGWsFIKmNGUu9Aaw7QshxQPNSNiqqBMU1dnzvk1LyNWghnAKY6MJEeRq5NiqXTZ
	nsSGJO4yqcLOHaW7pjba2SWi+OE267I6cCbat6Cp1sdWNlpgCGbkIKVzVJkJyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87tC2vKSttM87WL045LNXUb5mncoJsQXGoxqcGhk7rg=;
	b=ArnlDkv5uMxFc38IIOR4m5ARVghyf+T1iBn3T/K1pAMfVMJQtvHiKiVtLcGB+12QlVPU6C
	pbU8n/NY70w4PnDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Add AUX offset to struct timekeeper
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.533486349@linutronix.de>
References: <20250519083026.533486349@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086815506.406.14977690170514086926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     180d8b4ce91fe0cf7a9cb236bb01f14587ba4bf0
Gitweb:        https://git.kernel.org/tip/180d8b4ce91fe0cf7a9cb236bb01f14587ba4bf0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:24 +02:00

timekeeping: Add AUX offset to struct timekeeper

This offset will be used in the time getters of auxiliary clocks. It is
added to the "monotonic" clock readout.

As auxiliary clocks do not utilize the offset fields of the core time
keeper, this is just an alias for offs_tai, so that the cache line layout
stays the same.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083026.533486349@linutronix.de

---
 include/linux/timekeeper_internal.h |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 1690eda..ca79938 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -67,6 +67,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
+ * @offs_aux:			Offset clock monotonic -> clock AUX
  * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
@@ -113,6 +114,9 @@ struct tk_read_base {
  * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
  * accelerate the VDSO update for CLOCK_BOOTTIME.
  *
+ * @offs_aux is used by the auxiliary timekeepers which do not utilize any
+ * of the regular timekeeper offset fields.
+ *
  * The cacheline ordering of the structure is optimized for in kernel usage of
  * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
  * timekeeper is prepended in the core timekeeping code with a sequence count,
@@ -139,7 +143,10 @@ struct timekeeper {
 	struct timespec64	wall_to_monotonic;
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
-	ktime_t			offs_tai;
+	union {
+		ktime_t		offs_tai;
+		ktime_t		offs_aux;
+	};
 	u32			coarse_nsec;
 	enum timekeeper_ids	id;
 

