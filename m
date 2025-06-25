Return-Path: <linux-tip-commits+bounces-5903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4833AE8970
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1991617B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DE2D5C82;
	Wed, 25 Jun 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kzCbncoc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3rNpWLu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71D2D29A5;
	Wed, 25 Jun 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868164; cv=none; b=NS5740zZaxZjxo8h0J/lWtbur2edZVLgiWoQ0QoTlWlmkm2GOJS9VLkvCkxXvtdGpcVwto4h9wOEwLtlrREzVZMobncPjMvQV7P5O1R222sIS8ugZ5T2T/jCmXXaDZ4V0ynqsHyJ/lk6/BkKWf7Lbo6F3x8OSXNSli+p7LC8i/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868164; c=relaxed/simple;
	bh=PLlTXNTUhFhOtA0lblJuCtV0irlygLqB8ngy2uc1tAE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ybj5GZAd3eYxuDicy7FiK7cEkdkLYOpDfzCI5KOrxhfRJurxNbMtPTQyskfAKtgLZi1QdqHc8SWo3mrNxJ05j7yrg/cL7M148w6vx3jMCe3cW5ZCrNFXgdXw/UgAlAJ02qm5H3zrSSE58cU9DYQRflloRltEu1VlQfhxHUpZRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kzCbncoc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3rNpWLu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mwcSJpR+SyRjabYeTcdi3PCgDByHPX2UjJ1OCOjKgQ=;
	b=kzCbncocAcohcvybfcNONirHBQ4sgHQpDC1l1vwxQ9Fj2AgCgpwvZVR4WoejVy41fHqBhj
	DmA/rw5C+i1hZpUOX9HiLl5AHcALGafcyjTU/5yr2b/uBlf+GZ+H0NNvtF0rvH2xIdutE7
	baKD79GO8Y1C1f+TnKxQ8PrfNPC9+n9sXVW5t6GGzIPutkYOKnbr2HEYxVHwDCKVJ50OjD
	LTnPYo6Ll6ARkejf6maYrqrfopvf87ABAuMsB7QH2ZSlfu5/mJgL+af+XYZsI87ca37oED
	7dwoUrDLNAd4HxDuJ4scqOK8yUkuhLc2wH+hUR8c76IrzAsvAonq6IL+nozWxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mwcSJpR+SyRjabYeTcdi3PCgDByHPX2UjJ1OCOjKgQ=;
	b=w3rNpWLuGNGbjrPrFjTXMi2AQ5zhw4kopxNz9uBSfHsGxcWGz2ONQouRFXYtsPED6S7goJ
	cYszV00/Uk30rDBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Add clock_valid flag to timekeeper
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.287145536@linutronix.de>
References: <20250519083026.287145536@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086815928.406.5307674642753629647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     6168024604236cb2bb1004ea8459c8ece2c4ef5f
Gitweb:        https://git.kernel.org/tip/6168024604236cb2bb1004ea8459c8ece2c4ef5f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

timekeeping: Add clock_valid flag to timekeeper

In preparation for supporting independent auxiliary timekeepers, add a
clock valid field and set it to true for the system timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083026.287145536@linutronix.de


---
 include/linux/timekeeper_internal.h | 2 ++
 kernel/time/timekeeping.c           | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 4201ae8..1690eda 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -73,6 +73,7 @@ struct tk_read_base {
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
  * @cs_was_changed_seq:		The sequence number of clocksource change events
+ * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
@@ -149,6 +150,7 @@ struct timekeeper {
 	/* Cachline 3 and 4 (timekeeping internal variables): */
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
+	u8			clock_valid;
 
 	struct timespec64	monotonic_to_boot;
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e3c1a1c..bf59bac 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1665,11 +1665,12 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
-static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id)
+static __init void tkd_basic_setup(struct tk_data *tkd, enum timekeeper_ids tk_id, bool valid)
 {
 	raw_spin_lock_init(&tkd->lock);
 	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
 	tkd->timekeeper.id = tkd->shadow_timekeeper.id = tk_id;
+	tkd->timekeeper.clock_valid = tkd->shadow_timekeeper.clock_valid = valid;
 }
 
 /*
@@ -1699,7 +1700,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
-	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE);
+	tkd_basic_setup(&tk_core, TIMEKEEPER_CORE, true);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&

