Return-Path: <linux-tip-commits+bounces-1929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AAB9461EA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B52A282956
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179413C914;
	Fri,  2 Aug 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYEenGyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="peSlUUIk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C6136326;
	Fri,  2 Aug 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616986; cv=none; b=gY5NCVL906yol1OcXYGxi8Imzw+ipOcZdHbE+lBuqPz6D4hP0iU1216o+j1lEAw5D96hXMEQtogRsmFEIA1EBXgpSgbv5MWrmrF4kGcc6Ms2YLCH64A/e3UMHiRzHKN8KIfTmYpalzMxv4ppMbA/oDFAr4fog6hOEMHgZAxUvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616986; c=relaxed/simple;
	bh=7jeXIKY0nOtHlLioHCdXCkad8/i51wj1+p9FTUPV6ng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fgrx/IVBo7I6/65CeWqj0pcUEvnt3+xoLvyAxcbkTmqXFivmMIU3xXJV8/ebP96clmYTYD9hLNU/dlcpGLG5Xj7VY946zyAKif21MuLR1f/s90B5ijlsRya1xyeyivxOHcIAQ9Lnz04uueEGy1lZyhOwLEKhp8CKOV6RNc+huwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYEenGyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=peSlUUIk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1reWfwjnP6fZeZEf27qyX2FkGKuWtYp9vovua3YRktM=;
	b=RYEenGyClaUNgZObxJvsSEGhACF/WlMYwRF4zd+revUc7bSwhNEqi5zeNNQzQj8Y+vNXzO
	RIv3B7orPnBJLt1fl1GbMnFVIHZB15ObvdsZ8rqs54D6zQhURfklp4rJqLX4e03DDjT798
	PtSTodNG7MxjPEzcCQuBnucC6oNEUN9f3G0Sx3amQKT6HY2hDboGj42wgPR1PhKhuOhd7h
	KKwH0cfFucjWy5T3OXF5Lj5cxSA/s3NvuuHn5Kjy8g9dzXDr5Dbm5pZg/Snprwrn2ANwuJ
	c4CBlYju228TR5tT51uNlAnR/7nI45HZ+VvntEusyEXg20l3NfYYvafQCCeogQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1reWfwjnP6fZeZEf27qyX2FkGKuWtYp9vovua3YRktM=;
	b=peSlUUIkfEE0+mc7NhH4vHcRSlDCuRTG6Cr9DdF9bOhcYUJvuZyCybnYg1isqnUaacjuRV
	4BLPrH0eyZerUACw==
From: "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource: Improve comments for watchdog
 skew bounds
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802154618.4149953-1-paulmck@kernel.org>
References: <20240802154618.4149953-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261698298.2215.15812740560627649840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     17915131ae4660658aa779f89e9f444319861561
Gitweb:        https://git.kernel.org/tip/17915131ae4660658aa779f89e9f444319861561
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Fri, 02 Aug 2024 08:46:14 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:37:13 +02:00

clocksource: Improve comments for watchdog skew bounds

Add more detail on the rationale for bounding the clocksource
->uncertainty_margin below at about 500ppm.

Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802154618.4149953-1-paulmck@kernel.org

---
 kernel/time/clocksource.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index d0538a7..581cdbb 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,6 +125,13 @@ static u64 suspend_start;
  *
  * The default of 500 parts per million is based on NTP's limits.
  * If a clocksource is good enough for NTP, it is good enough for us!
+ *
+ * In other words, by default, even if a clocksource is extremely
+ * precise (for example, with a sub-nanosecond period), the maximum
+ * permissible skew between the clocksource watchdog and the clocksource
+ * under test is not permitted to go below the 500ppm minimum defined
+ * by MAX_SKEW_USEC.  This 500ppm minimum may be overridden using the
+ * CLOCKSOURCE_WATCHDOG_MAX_SKEW_US Kconfig option.
  */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
 #define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
@@ -1146,14 +1153,19 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 	}
 
 	/*
-	 * If the uncertainty margin is not specified, calculate it.
-	 * If both scale and freq are non-zero, calculate the clock
-	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
-	 * if either of scale or freq is zero, be very conservative and
-	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
-	 * uncertainty margin.  Allow stupidly small uncertainty margins
-	 * to be specified by the caller for testing purposes, but warn
-	 * to discourage production use of this capability.
+	 * If the uncertainty margin is not specified, calculate it.  If
+	 * both scale and freq are non-zero, calculate the clock period, but
+	 * bound below at 2*WATCHDOG_MAX_SKEW, that is, 500ppm by default.
+	 * However, if either of scale or freq is zero, be very conservative
+	 * and take the tens-of-milliseconds WATCHDOG_THRESHOLD value
+	 * for the uncertainty margin.  Allow stupidly small uncertainty
+	 * margins to be specified by the caller for testing purposes,
+	 * but warn to discourage production use of this capability.
+	 *
+	 * Bottom line:  The sum of the uncertainty margins of the
+	 * watchdog clocksource and the clocksource under test will be at
+	 * least 500ppm by default.  For more information, please see the
+	 * comment preceding CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US above.
 	 */
 	if (scale && freq && !cs->uncertainty_margin) {
 		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);

