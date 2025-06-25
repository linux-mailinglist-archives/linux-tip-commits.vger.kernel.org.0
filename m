Return-Path: <linux-tip-commits+bounces-5908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB08AE897C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CB97B3335
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F82D9EDA;
	Wed, 25 Jun 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VH+QX5Wx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXTqMEHG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B32D8DA4;
	Wed, 25 Jun 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868168; cv=none; b=XIcE8x5zTdnSjGHdpbg2QWO/nMsb/3skVvzYU7kmuv1RhyiYTek4aBtY8LLX9QFnihEVnha0ecXra6f+UsyAa7stQtUkIMNzThacRWUz9dL/0EC9x9sJbYapZIsmaNAyiM9hdvLyaUJw5v+6djkPZL3Fl5MA37/vZFCeLiddHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868168; c=relaxed/simple;
	bh=tPY4VZ+EZCyoIuHT+3XwKCCC027q6fOT5uiIMZdTinM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1O/DEu5iSmnkHqKwMdshZAxrxAM56owwgw2acVYImIJSOzmQhSa40mEoWv82P6J5jbMY9wzGkTuH5MfL1KobZsjdVmn+LjbRZZqH+D/4xT9qTIntp88JEJz7S4IAIenq6IuZShE8TQ1YY4hv86Cl/yvFndnn/GMinwJRE+NSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VH+QX5Wx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXTqMEHG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A6wFOijRzW9dj8xXG1x9JRXlKO9nUz9p/u98VsfrAk=;
	b=VH+QX5WxFWsAsQgjRWSrnERKjoBH2jW6IybTDvKy2v7HUCjlDhCmqG1j1zHtkEz2Vs69eg
	wahKKor0rBZ6Rm4ketK3XCfAm8HCiAzpnBsEIlIuMygxr3i3PLuaKWnUiMxiB7ol0AUMpr
	wmzx1TUTie5J8CVLtyZNf6F4WOd4+uORqgbsvvcAkZJWn9z3OeXwo3d3GE+fldtNmFYx3a
	YhxPTiv4BnuSmgwZV8aXxVcWmh5gE/HgHhX0QHxFXDEcMBG9sSD+3dgkGiBl1M5eMm2psH
	s6CMszbNgTSQ7YOggdY0qqf2LMkfXEDipixQhZ7mNR4fcci0MaRY6KwfJUVEnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A6wFOijRzW9dj8xXG1x9JRXlKO9nUz9p/u98VsfrAk=;
	b=CXTqMEHGbe7pK7Y5eakqdkG4K/Wv4+y/WHXMCVwUznZj5G5knpOjjDZyE6ANEFm6uKww2J
	Dv3lhBLGiZi94QBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] ntp: Add support for auxiliary timekeepers
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.969000914@linutronix.de>
References: <20250519083025.969000914@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816451.406.15644609316106911557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     8515714b0f88a698a4c26f0f0ce7d43ad14dce16
Gitweb:        https://git.kernel.org/tip/8515714b0f88a698a4c26f0f0ce7d43ad14dce16
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

ntp: Add support for auxiliary timekeepers

If auxiliary clocks are enabled, provide an array of NTP data so that the
auxiliary timekeepers can be steered independently of the core timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083025.969000914@linutronix.de

---
 kernel/time/ntp.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b837d3d..5b5a0f7 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/audit.h>
+#include <linux/timekeeper_internal.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -86,14 +87,16 @@ struct ntp_data {
 #endif
 };
 
-static struct ntp_data tk_ntp_data = {
-	.tick_usec		= USER_TICK_USEC,
-	.time_state		= TIME_OK,
-	.time_status		= STA_UNSYNC,
-	.time_constant		= 2,
-	.time_maxerror		= NTP_PHASE_LIMIT,
-	.time_esterror		= NTP_PHASE_LIMIT,
-	.ntp_next_leap_sec	= TIME64_MAX,
+static struct ntp_data tk_ntp_data[TIMEKEEPERS_MAX] = {
+	[ 0 ... TIMEKEEPERS_MAX - 1 ] = {
+		.tick_usec		= USER_TICK_USEC,
+		.time_state		= TIME_OK,
+		.time_status		= STA_UNSYNC,
+		.time_constant		= 2,
+		.time_maxerror		= NTP_PHASE_LIMIT,
+		.time_esterror		= NTP_PHASE_LIMIT,
+		.ntp_next_leap_sec	= TIME64_MAX,
+	},
 };
 
 #define SECS_PER_DAY		86400
@@ -351,13 +354,13 @@ static void __ntp_clear(struct ntp_data *ntpdata)
  */
 void ntp_clear(void)
 {
-	__ntp_clear(&tk_ntp_data);
+	__ntp_clear(&tk_ntp_data[TIMEKEEPER_CORE]);
 }
 
 
 u64 ntp_tick_length(void)
 {
-	return tk_ntp_data.tick_length;
+	return tk_ntp_data[TIMEKEEPER_CORE].tick_length;
 }
 
 /**
@@ -368,7 +371,7 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	ktime_t ret;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
@@ -389,7 +392,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -605,7 +608,7 @@ static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_ns
  */
 static inline bool ntp_synced(void)
 {
-	return !(tk_ntp_data.time_status & STA_UNSYNC);
+	return !(tk_ntp_data[TIMEKEEPER_CORE].time_status & STA_UNSYNC);
 }
 
 /*
@@ -762,7 +765,7 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
@@ -1031,8 +1034,8 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
  */
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	struct pps_normtime pts_norm, freq_norm;
-	struct ntp_data *ntpdata = &tk_ntp_data;
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
@@ -1083,18 +1086,18 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
+	int rc = kstrtos64(str, 0, &tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj);
 	if (rc)
 		return rc;
 
-	tk_ntp_data.ntp_tick_adj <<= NTP_SCALE_SHIFT;
+	tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
-
 __setup("ntp_tick_adj=", ntp_tick_adj_setup);
 
 void __init ntp_init(void)
 {
-	ntp_clear();
+	for (int id = 0; id < TIMEKEEPERS_MAX; id++)
+		__ntp_clear(tk_ntp_data + id);
 	ntp_init_cmos_sync();
 }

