Return-Path: <linux-tip-commits+bounces-2326-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77D98DF8E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A2B1C24F7F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED441D12EC;
	Wed,  2 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OICInWvB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7bLJnuyG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC411D0940;
	Wed,  2 Oct 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883894; cv=none; b=YubMFgoo7179/MXJTGG1bn6y73Sgasulwy9hAukTY3FM8ctaEGdWA5b1TMvU3dnhKQiljnYvKpOUIpGIdvPmp+tyLSiVaPxtzZktstpFK1RlEs6pwHb6U3CXasPBl2unW1yJ7jRNZfReJbaqyBVRRr+kRn+t9xneTAUWaziMJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883894; c=relaxed/simple;
	bh=NO4GGi+/RL6UFNxfUhm7lGBkdpaR5+P1BgDU62PyMj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DwHTnTQU8+Lm1AWGRL2D333JksAgYPQUNC3nEIWPLZk2TFiZbfPdFjwYG/kdoRvl6GMVZc1ndWHmq74FW8PTzKwy3wrqm0CL7KlQXlVsmwPJuxMflBeEoXYimd82aNRWm9F4p9QlR313OhDbNNw9TGcBXL2a3IY9NEJQDWuBxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OICInWvB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7bLJnuyG; arc=none smtp.client-ip=193.142.43.55
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
	bh=TcWz9xtoBdhFbr0UAjdkbvX1OmLRxDTfFhcq35B3O6A=;
	b=OICInWvBweGpXEUZPfEX6bl0R4VWKJQ2MuJZbiJaOS9+d3pPGiL5WGG/NFmd01qgTvQx6r
	qtBV4O6pNQtwozf8B4uLSVE5ClKov0mrR3KHenQWt949iimS1ybxS3feJVkUGb3b9E2uLn
	1azRkIwTxCL9EMv01Jp0dReSdm2nyvCPnFd8hxQr19IRJ/EUzYvAorhkuPB3LUt1gFI6/M
	KM2Hf68R2yhghk4baSVGjHjhNeJZoL6y/8tcBznXn/uAw4vFvbb2CsEsgsirxIeJtJizq2
	5iBRqhTXIGI0IJa28CfvclXmbyfD4OwthSMLKZDOYjX0VYzkxjoUtoWXpz2Y+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883890;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcWz9xtoBdhFbr0UAjdkbvX1OmLRxDTfFhcq35B3O6A=;
	b=7bLJnuyGikGKrzexRAl8vfeEn8i7VEtfH/qT618yBCchktFMBTpdABpOpjbzfoyh/SpnxR
	/EUhBdB7GNLXpyDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Move pps_valid into ntp_data
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-15-?=
 =?utf-8?q?2d52f4e13476=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-15-2?=
 =?utf-8?q?d52f4e13476=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788388998.1442.4946221846956192299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     931a177f7027ad0066c071912873a7a24e63240d
Gitweb:        https://git.kernel.org/tip/931a177f7027ad0066c071912873a7a24e63240d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:40 +02:00

ntp: Move pps_valid into ntp_data

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-15-2d52f4e13476@linutronix.de

---
 kernel/time/ntp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index f156114..ad65ba2 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -40,6 +40,8 @@
  * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
  * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
+ * @pps_valid:		PPS signal watchdog counter
+ *
  * Protected by the timekeeping locks.
  */
 struct ntp_data {
@@ -57,6 +59,9 @@ struct ntp_data {
 	long			time_adjust;
 	s64			ntp_tick_adj;
 	time64_t		ntp_next_leap_sec;
+#ifdef CONFIG_NTP_PPS
+	int			pps_valid;
+#endif
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -91,7 +96,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static int pps_valid;		/* signal watchdog counter */
 static long pps_tf[3];		/* phase median filter */
 static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
@@ -147,9 +151,9 @@ static inline void pps_clear(void)
  */
 static inline void pps_dec_valid(struct ntp_data *ntpdata)
 {
-	if (pps_valid > 0)
-		pps_valid--;
-	else {
+	if (ntpdata->pps_valid > 0) {
+		ntpdata->pps_valid--;
+	} else {
 		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
 					  STA_PPSWANDER | STA_PPSERROR);
 		pps_clear();
@@ -1032,7 +1036,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	/* indicate signal presence */
 	ntpdata->time_status |= STA_PPSSIGNAL;
-	pps_valid = PPS_VALID;
+	ntpdata->pps_valid = PPS_VALID;
 
 	/*
 	 * When called for the first time, just start the frequency

