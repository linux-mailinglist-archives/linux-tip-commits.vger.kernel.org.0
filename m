Return-Path: <linux-tip-commits+bounces-5906-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB4AE898A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59703B2084
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB12D8787;
	Wed, 25 Jun 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AExgIuJn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TiIfNELA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32792D660F;
	Wed, 25 Jun 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868166; cv=none; b=tVQDriGg/5PG5x4pFmjnUK1h61H1VU6dZgnijCwXxoCXtPFatdVw86k/exGkR0EvYIr8T/f+qfmBiGYL0K7LzDEFkwUhr3bh1xr0XbEoRkNwxagHo+EwOCYEh83BiR3Ijz+nGUrJPioJVgoWzzNQvpFEshmrmEl8OmKxi1auf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868166; c=relaxed/simple;
	bh=lq3MKVaq7Nf4DcUagIzIkTTo9o5nueVe/+5hksdLERw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d9hGtuQn0nAzPiHES/9m7bu/jCbBw30jh3UwjgNYkXIWCGS2DvOOG+8Iuov2YtL/li9N/rt59VZ23SUlpxBDZDfncwDEvFcQIQkPJWRqUp0jtDwMGJkJ/5D79dPBWFIPJASmcp1gJl0PKOpsZuBq/uUNbL5EFOsSz1s40tHKFK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AExgIuJn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TiIfNELA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCp+17hARnc58LkCsC045sCC2pRx43l7QTKsgpT6krQ=;
	b=AExgIuJneMqzBglfQwG/bkmiuezHx8rk5u+JfuYQfkhQMoOMA6FK/vGH6Je9AdkZdwTt94
	pcJ5pilG8nik6LWKQMjHekHChOYkzfT6rdEeCzTDTuDbOgAqHIXanxGbNAyHDhVoRC9bPu
	ZWmFiTMRitTjroK5BgAeZsHhSNE+F1/SlkKlpL0Z1u2VXS4R6fA0mS3aWVEEtp4E9DhIhO
	bm67HPLpe8wRzVpCqoiug+V+pwqO46kaicouhb3TDzlkYWDp4XwgFDAXQKXwaXB1Fr5gfN
	uxOBbl7t+1yzMxLQlpv+evJ/H+3Xr4xkjwou6ngcgL+U+nOtBjU7x8NVtBj2vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCp+17hARnc58LkCsC045sCC2pRx43l7QTKsgpT6krQ=;
	b=TiIfNELArMRI3dp2TePP/wbB7wP7COXlDzaZD9D275svwlfCaiZ7GkdEwDPFAoDkdcZxqQ
	2Px5g/hbsMeHhQAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] ntp: Rename __do_adjtimex() to ntp_adjtimex()
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083026.095637820@linutronix.de>
References: <20250519083026.095637820@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816244.406.11733267958732136286.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     c7ebfbc440151ae4a66a03b0f879cbece45174c8
Gitweb:        https://git.kernel.org/tip/c7ebfbc440151ae4a66a03b0f879cbece45174c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:23 +02:00

ntp: Rename __do_adjtimex() to ntp_adjtimex()

Clean up the name space. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083026.095637820@linutronix.de


---
 kernel/time/ntp.c          | 4 ++--
 kernel/time/ntp_internal.h | 4 ++--
 kernel/time/timekeeping.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index e28dc53..9aba1bc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -767,8 +767,8 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-		  s32 *time_tai, struct audit_ntp_data *ad)
+int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+		 s32 *time_tai, struct audit_ntp_data *ad)
 {
 	struct ntp_data *ntpdata = &tk_ntp_data[tkid];
 	int result;
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 2d3e966..7084d83 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,8 +8,8 @@ extern void ntp_clear(unsigned int tkid);
 extern u64 ntp_tick_length(unsigned int tkid);
 extern ktime_t ntp_get_next_leap(unsigned int tkid);
 extern int second_overflow(unsigned int tkid, time64_t secs);
-extern int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
-			 s32 *time_tai, struct audit_ntp_data *ad);
+extern int ntp_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
+			s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e1b8e26..99b4749 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2586,7 +2586,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		}
 
 		orig_tai = tai = tks->tai_offset;
-		ret = __do_adjtimex(tks->id, txc, &ts, &tai, &ad);
+		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);

