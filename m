Return-Path: <linux-tip-commits+bounces-2325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3698DF8D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED43E1F239A5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38961D0F6B;
	Wed,  2 Oct 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvg7QtKz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XlOMOIhL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4C1D0E07;
	Wed,  2 Oct 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883893; cv=none; b=EZ4e2Z+jz0/wF8ks0YyX83hsi6e9Hu0XRC3n2et08/41QxdxFcuaSfaPH7n5wJWYeqj/2fT3rpIsiOBYJu+BmjLHGvo2inBJ+vmsNqtvQyUmWPp5LuGpwNfxp3lFF0jweHuLA+4iL5DgBZv5kewZzDBdjG3HGFvr/fMLYYynBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883893; c=relaxed/simple;
	bh=U+HMqai0Z5xhVOiyFLmewhfSDainK5iOwlmX6zWmTMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N4ZER63sNi4gsrDqzoZsUGpl5OcabaFzi3PD2PeXVwjcfi+pmmUljVbDOegXY76ZPS/LmR2EsSZUZVbiSlaeqI3QZr8QJMNB8vCMP15CuQIyf8sa9PkPGi/CRNkVY3XekbNniLg7x40GbXoC0S9bUaT1TJ8eDj4HigJfvRduemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvg7QtKz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XlOMOIhL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95qSEPp0tQFhVpJLSZ2yaN4uDkPZfbcSC0rZ51KN2a0=;
	b=jvg7QtKzW2evLyDb4ubRCsjV6LBadZA+PFmweupBbc8k0XbtU7iexk9bna6iM91UQwIzil
	LgvTVbo3RPdjAdGkTMp6viGJXOiHjxdU/jihrocgili+NjzWmGGoaWcpZHJolQ28UVm0Xe
	GT+P1ED7azDicsp1X8UIoCiwCcYo6LhTSls6ooR+nO6iUuav0RzAjcOiO9M48bAEpL9hQ+
	OgFapmSgp3zrZOu/gL0RjK/OW7NS765gPqYWy19bi6ydUtvDISPE11PwHBKwtLWE8gYO4h
	1Zm1ryAzgxw/cn3Mu61m9YLqmaUVLyeH+N2c+GyO9SVQl7QAhny1AKJ5GVMRCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95qSEPp0tQFhVpJLSZ2yaN4uDkPZfbcSC0rZ51KN2a0=;
	b=XlOMOIhLY+kNtgUQo3XIZihxO5Sv0ozKUyebeyZE0NEmbtpjBVfE6GiN0L9zXt2O7acDbO
	vHP/0wAnzeePenCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_ft into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-16-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-16-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388951.1442.6595267161194107906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5cc953b8ae0b2b7d0ebc7c3c0105e73ffaa03085
Gitweb:        https://git.kernel.org/tip/5cc953b8ae0b2b7d0ebc7c3c0105e73ffaa03085
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move pps_ft into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-16-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index ad65ba2..6a1ba27 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -41,6 +41,7 @@
  * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
  * @pps_valid:		PPS signal watchdog counter
+ * @pps_tf:		PPS phase median filter
  *
  * Protected by the timekeeping locks.
  */
@@ -61,6 +62,7 @@ struct ntp_data {
 	time64_t		ntp_next_leap_sec;
 #ifdef CONFIG_NTP_PPS
 	int			pps_valid;
+	long			pps_tf[3];
 #endif
 };
 
@@ -96,7 +98,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static long pps_tf[3];		/* phase median filter */
 static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
@@ -134,13 +135,14 @@ static inline void pps_reset_freq_interval(void)
 
 /**
  * pps_clear - Clears the PPS state variables
+ * @ntpdata:	Pointer to ntp data
  */
-static inline void pps_clear(void)
+static inline void pps_clear(struct ntp_data *ntpdata)
 {
 	pps_reset_freq_interval();
-	pps_tf[0] = 0;
-	pps_tf[1] = 0;
-	pps_tf[2] = 0;
+	ntpdata->pps_tf[0] = 0;
+	ntpdata->pps_tf[1] = 0;
+	ntpdata->pps_tf[2] = 0;
 	pps_fbase.tv_sec = pps_fbase.tv_nsec = 0;
 	pps_freq = 0;
 }
@@ -156,7 +158,7 @@ static inline void pps_dec_valid(struct ntp_data *ntpdata)
 	} else {
 		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
 					  STA_PPSWANDER | STA_PPSERROR);
-		pps_clear();
+		pps_clear(ntpdata);
 	}
 }
 
@@ -211,7 +213,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 }
 
 static inline void pps_reset_freq_interval(void) {}
-static inline void pps_clear(void) {}
+static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
 
@@ -337,7 +339,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 
 	ntpdata->ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
-	pps_clear();
+	pps_clear(ntpdata);
 }
 
 /**
@@ -870,22 +872,22 @@ static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 }
 
 /* Get current phase correction and jitter */
-static inline long pps_phase_filter_get(long *jitter)
+static inline long pps_phase_filter_get(struct ntp_data *ntpdata, long *jitter)
 {
-	*jitter = pps_tf[0] - pps_tf[1];
+	*jitter = ntpdata->pps_tf[0] - ntpdata->pps_tf[1];
 	if (*jitter < 0)
 		*jitter = -*jitter;
 
 	/* TODO: test various filters */
-	return pps_tf[0];
+	return ntpdata->pps_tf[0];
 }
 
 /* Add the sample to the phase filter */
-static inline void pps_phase_filter_add(long err)
+static inline void pps_phase_filter_add(struct ntp_data *ntpdata, long err)
 {
-	pps_tf[2] = pps_tf[1];
-	pps_tf[1] = pps_tf[0];
-	pps_tf[0] = err;
+	ntpdata->pps_tf[2] = ntpdata->pps_tf[1];
+	ntpdata->pps_tf[1] = ntpdata->pps_tf[0];
+	ntpdata->pps_tf[0] = err;
 }
 
 /*
@@ -988,8 +990,8 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 	long jitter;
 
 	/* Add the sample to the median filter */
-	pps_phase_filter_add(correction);
-	correction = pps_phase_filter_get(&jitter);
+	pps_phase_filter_add(ntpdata, correction);
+	correction = pps_phase_filter_get(ntpdata, &jitter);
 
 	/*
 	 * Nominal jitter is due to PPS signal noise. If it exceeds the

