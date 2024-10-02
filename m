Return-Path: <linux-tip-commits+bounces-2337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704198DFA2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027291F27783
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98B1D1F72;
	Wed,  2 Oct 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKKcCXHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4uTAO53"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923D1D175B;
	Wed,  2 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883899; cv=none; b=Nokvm73KUhNOKx3TcO8l/haAm0NY9NKLkxRFjemV8T4paVsV0Hm22FqiYx9YwqcKLUNaRLSKyDBUX8okFzGZiqvHV3AnhR5/tbGtNJQIaa/63MhQohSiHWqlBjKh4qjJfwHElaH3WuswFCqBU0Xcl++E6ViK2EC+ZkOXu1d4YQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883899; c=relaxed/simple;
	bh=RKWHwBDbRGfqKw5SGNEplvDAAe6oX7q52aU5bbC5HPg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mLEsqep7UTGucU6X15g2wAiJeAlEn+7qre2upzSepo3P9LDQWpB0SfCNVIvTs+QFK4R3UM20sp3MjETGHcfFjC4wK7rGinzgwsblA3ukrtTZhddFgm83TxhIOzwAQJMsdYBU+McxkVBjGS2PZoi8nPDP4wdg6QimNqpqj5x9QZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKKcCXHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4uTAO53; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRGmNLhZnL8EPj/eLlaIjryzSqcHXH9mG7QjJnX6DeA=;
	b=nKKcCXHumAq1RW5BYCIq2DN8p5MI11eZd5CCq49Kw879t+C6A45ISSwufg4dujC8S4cTni
	2a90wVdZJwwVIz++QpooneyQvDUZYLLxLrLAAxkJGEI2G3lvHSiK4PGmP4sf/7ApdfNxRu
	gDi3gvb5EH4anmjoIZ+K4Ing+4ChqxgWchME+XEEQb0u9YH/e+Ghuw0BB+w62S+cNVNkvQ
	rKmK6cCK43JifWsjQqmNTr3B5cdsDm+4gzhkRlnPuU/sDhMRuqhg+nvOZ4auRJFSPBzP8x
	+ABi0pT2eE69F7cnCgcp2DSZwdWloXSGgbaXsvWRtdpECR2YDB2gzlzCpstY0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRGmNLhZnL8EPj/eLlaIjryzSqcHXH9mG7QjJnX6DeA=;
	b=P4uTAO53Hlu4z9T1fAH7cfqDQM2f4aKpiby1WciUX0ubmirP/f0L4joyUguilBRxAQV1gw
	5kqEuunYMG/yXLBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] ntp: Convert functions with only two states to bool
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389516.1442.2315987124482723471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     48c3c65f64b01164f1704b40b38f60837d484f13
Gitweb:        https://git.kernel.org/tip/48c3c65f64b01164f1704b40b38f60837d484f13
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:39 +02:00

ntp: Convert functions with only two states to bool

is_error_status() and ntp_synced() return whether a state is set or
not. Both functions use unsigned int for it even if it would be a perfect
job for a bool.

Use bool instead of unsigned int. And while at it, move ntp_synced()
function to the place where it is used.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index bf2f6ee..905b021 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -171,7 +171,7 @@ static inline void pps_set_freq(s64 freq)
 	pps_freq = freq;
 }
 
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return (status & (STA_UNSYNC|STA_CLOCKERR))
 		/*
@@ -221,7 +221,7 @@ static inline void pps_clear(void) {}
 static inline void pps_dec_valid(void) {}
 static inline void pps_set_freq(s64 freq) {}
 
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
@@ -241,21 +241,6 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
 
 #endif /* CONFIG_NTP_PPS */
 
-
-/**
- * ntp_synced - Returns 1 if the NTP status is not UNSYNC
- *
- */
-static inline int ntp_synced(void)
-{
-	return !(time_status & STA_UNSYNC);
-}
-
-
-/*
- * NTP methods:
- */
-
 /*
  * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
  * time_freq:
@@ -609,6 +594,15 @@ static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_ns
 }
 #endif
 
+/**
+ * ntp_synced - Tells whether the NTP status is not UNSYNC
+ * Returns:	true if not UNSYNC, false otherwise
+ */
+static inline bool ntp_synced(void)
+{
+	return !(time_status & STA_UNSYNC);
+}
+
 /*
  * If we have an externally synchronized Linux clock, then update RTC clock
  * accordingly every ~11 minutes. Generally RTCs can only store second

