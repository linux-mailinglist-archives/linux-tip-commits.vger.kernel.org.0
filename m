Return-Path: <linux-tip-commits+bounces-2320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C498D98DF82
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5732830C5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D81D0BB0;
	Wed,  2 Oct 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exCZvaAk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydiDO/BW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C621D0DC4;
	Wed,  2 Oct 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883890; cv=none; b=suPMmN9nCLSNQEVKwPrLZ8sisDu9WWAhUZfJyPNtr2Vf954yqp9Zgxbo/25jjnazqENqlpSewpuSbYdS2zwfy51rHVmvODJXzT8SoKOSN34Ufm1aSCBSLureKwNLLbqkJ6GpGJrP0tSkDoQsmNT6fAabQGI/PIVmL6TTGcfLd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883890; c=relaxed/simple;
	bh=V6LofR9kXsBJkX3idJADcv+GOs9ghFMH902pfdjQmBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X1S0ZFktFmYt2kqrThf4vJMmkjbpOekamawSRgbJkiKTTiOD4qzG4CGhxvDbAnB2gS/9iqNbalNlJa6SjLBr52il3yHrvIK4402h228qRyIuOfKbCS3rsj5p13B3eBY7P8T7/MAAF2rpEF9bKeTpS8+6q+I/B3hkRwFoliUlzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exCZvaAk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydiDO/BW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhzVZAewrjK3h2WsbK1+oCn/Z2OfTGE/Z61AkcQ8sRo=;
	b=exCZvaAkXxjNXDmaZ/kJaCd8SCsYHYCeC0HGjsmRFrcvpOvEVplRvHbu1VySL2OKfd79Px
	m0P+VM7SSEW2PnJZgbDrpTJnMDKJ4+je7Y4AYiOTcdt58CiEp/LzL8GgwVSX+vQm9auKY2
	Dl8Ks26JUoAgNp57qL8roNJleXfcxXVjuzHYkEg+oo3bfvN0iyUwCAyHV+LT8l1u+XMGkk
	HfSzzNGlM3NGlpyIwfX6waXBrc5KLxxxfja/R0f0rkJdYJ9Lsq8LoMB7fSHyIUFO8i07WR
	i3NJS3nkjmKDHBHDPK5pgLhGndSnkgn2OpGwyBW/QqQ/XGegRcbTwUfvW9Mi5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhzVZAewrjK3h2WsbK1+oCn/Z2OfTGE/Z61AkcQ8sRo=;
	b=ydiDO/BWmmb6bmGXAHkfXz0VZkae/1rMXzEpDJfqti8NniNbIZw8XQsXy6/369sMdkqsZ0
	Nf130Q/RRXb8LsBw==
From: "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timekeeping: Add the boot clock to system time snapshot
Cc: Vincent Donnefort <vdonnefort@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240911093029.3279154-5-vdonnefort@google.com>
References: <20240911093029.3279154-5-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388645.1442.11881131090630410048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8102c4daf44ab86c2d2226a8136bec905d6e2bd1
Gitweb:        https://git.kernel.org/tip/8102c4daf44ab86c2d2226a8136bec905d6e2bd1
Author:        Vincent Donnefort <vdonnefort@google.com>
AuthorDate:    Wed, 11 Sep 2024 10:30:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 17:10:41 +02:00

timekeeping: Add the boot clock to system time snapshot

For tracing purpose, the boot clock is interesting as it doesn't stop on
suspend. Export it as part of the time snapshot. This will later allow
the hypervisor to add boot clock timestamps to its events.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911093029.3279154-5-vdonnefort@google.com


---
 include/linux/timekeeping.h | 2 ++
 kernel/time/timekeeping.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9b..e85c273 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -275,6 +275,7 @@ struct ktime_timestamps {
  *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
+ * @boot:	Boot time
  * @raw:	Monotonic raw system time
  * @cs_id:	Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
@@ -283,6 +284,7 @@ struct ktime_timestamps {
 struct system_time_snapshot {
 	u64			cycles;
 	ktime_t			real;
+	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409..47e44b9 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1060,6 +1060,7 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 	unsigned int seq;
 	ktime_t base_raw;
 	ktime_t base_real;
+	ktime_t base_boot;
 	u64 nsec_raw;
 	u64 nsec_real;
 	u64 now;
@@ -1074,6 +1075,8 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
 		base_real = ktime_add(tk->tkr_mono.base,
 				      tk_core.timekeeper.offs_real);
+		base_boot = ktime_add(tk->tkr_mono.base,
+				      tk_core.timekeeper.offs_boot);
 		base_raw = tk->tkr_raw.base;
 		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw  = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
@@ -1081,6 +1084,7 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 
 	systime_snapshot->cycles = now;
 	systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
+	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
 	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
 }
 EXPORT_SYMBOL_GPL(ktime_get_snapshot);

