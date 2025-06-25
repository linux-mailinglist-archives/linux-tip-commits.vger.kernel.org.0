Return-Path: <linux-tip-commits+bounces-5910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A8AE897F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB1C162143
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C82DAFA0;
	Wed, 25 Jun 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ty8yX6Ew";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CvdA8xEZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8072D663B;
	Wed, 25 Jun 2025 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868171; cv=none; b=r4uTfo4eDiXixijTavQAQHoLVG1fXBMqiZMshXoq5MZzV3Umj09+6c7k7VSsD0PC4QV4lLR0+XluMRS9iZrMQvz9x5Io0Xgl6AQeCneG7RGWGchQZXpxS76vmvAKIdNynOGKIbbqPmMWxAz/hHJXgyHR2O/uJ8a/EerNTEcJDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868171; c=relaxed/simple;
	bh=JAVCv/BXHu38CH/GqiL0SUR8uNWIs+NVTrAQyUqc774=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ni2PdbWhoaNR0jena3TGublMaK53y2KIEdfbiTFUqgUzk+q1nfak7HT5ZCqVWfmUoZhJzxdpp7lIVs28sKMLIHFC1TRpFfz26U1tsLkyuNfjB0/dlnC27lCoMT+XCd6TpmqMV3oL6uxLUbkj4/2AVI79PFqjy9SGE5lJhTDRBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ty8yX6Ew; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CvdA8xEZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbzKG2YPoEnJgl5IdklEBtxzMHO31uBE6KF+voKmL/M=;
	b=Ty8yX6Ew5AHGQOvRsE3tRBr/8LPmmUXXTxbvB/CIa03Jy+wnPy5Hn4qN3yHgyXuKHdN3Mg
	iy7RQInOWkWPj/vVepYhECzwNp8uFXbUEHN8xCezG1K+IRrjXX3i4eBvaAstO60wBP4gVU
	GA2u+3WCgzjfO73Sa/zQyBYDdRPYFed1e5BBnv1zXB/8YLAJ2C5wK4p6BJGukDuS/BrRCH
	ytszytZg7hBYzxUXFGLoYe79UuD8l+I+YSy0A9IBHi3Z+MFCDOvKuxnTN3HqBdUgAslQkG
	oH++51+wFo2UA6vqxTZgkcqFSXhqdqBx2d8r6pyUkOTfF61XU+/8wrHNWrUkOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbzKG2YPoEnJgl5IdklEBtxzMHO31uBE6KF+voKmL/M=;
	b=CvdA8xEZLZXG1wBpc1im4jgMrZZyHguJebJ6rWf6zxG62SIobCiTrptGs1n1CYaC7Xvb3y
	sbVJ9EeEhFh7iHAg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Introduce timekeeper ID
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.842476378@linutronix.de>
References: <20250519083025.842476378@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816671.406.11281411150262256179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     f12b45862c4dcb9c2937b83ed730e473b9a76cbf
Gitweb:        https://git.kernel.org/tip/f12b45862c4dcb9c2937b83ed730e473b9a76cbf
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

timekeeping: Introduce timekeeper ID

As long as there is only a single timekeeper, there is no need to clarify
which timekeeper is used. But with the upcoming reusage of the timekeeper
infrastructure for auxiliary clock timekeepers, an ID is required to
differentiate.

Introduce an enum for timekeeper IDs, introduce a field in struct tk_data
to store this timekeeper id and add also initialization. The id struct
field is added at the end of the second cachline, as there is a 4 byte hole
anyway.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083025.842476378@linutronix.de


---
 include/linux/timekeeper_internal.h | 14 +++++++++++++-
 kernel/time/timekeeping.c           |  5 +++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 785048a..bfcecad 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -12,6 +12,16 @@
 #include <linux/time.h>
 
 /**
+ * timekeeper_ids - IDs for various time keepers in the kernel
+ * @TIMEKEEPER_CORE:	The central core timekeeper managing system time
+ * @TIMEKEEPERS_MAX:	The maximum number of timekeepers managed
+ */
+enum timekeeper_ids {
+	TIMEKEEPER_CORE,
+	TIMEKEEPERS_MAX,
+};
+
+/**
  * struct tk_read_base - base structure for timekeeping readout
  * @clock:	Current clocksource used for timekeeping.
  * @mask:	Bitmask for two's complement subtraction of non 64bit clocks
@@ -52,6 +62,7 @@ struct tk_read_base {
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
  * @coarse_nsec:		The nanoseconds part for coarse time getters
+ * @id:				The timekeeper ID
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
@@ -101,7 +112,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... coarse_nsec
+ * 1:	xtime_sec ... id
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -123,6 +134,7 @@ struct timekeeper {
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
 	u32			coarse_nsec;
+	enum timekeeper_ids	id;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index fb1da87..f4692fc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1663,10 +1663,11 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
-static __init void tkd_basic_setup(struct tk_data *tkd)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+	tkd->timekeeper.id = tkd->shadow_timekeeper.id = tk_id;
 }
 
 /*
@@ -1696,7 +1697,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&

