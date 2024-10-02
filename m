Return-Path: <linux-tip-commits+bounces-2339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6617C98DFA8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E881F27BB3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D4C1D26E8;
	Wed,  2 Oct 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9jRIKPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MS2KmFFL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C821D1E9C;
	Wed,  2 Oct 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883901; cv=none; b=M91nRYLwo78n021BHp+7CrCmnX2jlR5GJO32LrDbsn6mC4QLZsHw7XQ7S/D0SDFOsRKvJJuskCxd8q1tVzfJ8Xk/pvVQG2eOA0yfI/KS1/4meO/rqbhi7qMfWiC5bEKBgCovBxYQ8eLli5TjQ24Hb4GC3D3EedH1i49z4EaT+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883901; c=relaxed/simple;
	bh=KAK+31xl2R3RI//yj9iq2OGZLou0HQXcFHuFHCE+zlM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KuXP+2wHsvXwi6taFb6R0dFnMJd8/D++8kbgvF0ClJRXDkl5SPZ00n+wUzM3YngJjkvXCR2M7kOzAKUSgSw1rvOip6PuRXZDRRk1Hp6YmedqPgPQEAigTw4XK89thk8yyf1yljorGfaSi5otMRVs7YdGuUUknReHWMXuYv07OsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9jRIKPb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MS2KmFFL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrckyO9F0B5kpS+FEJ81hi45VwD00rMgDr9u6SGu1BI=;
	b=F9jRIKPb7yV+nDEYy4hMrkPNtNEXKccFYw4ZNfxTKTcGx+VhvniqzPP9/Ve+KzmB7lQQwt
	OnaTN8gvJJtZe2+fRlhVSMvd2yX8/BWJrlJpZ1L8PP+3eOovpRCKcBON1ZVl5E8KDXPazw
	gDhzs17MeTgLeYgn6+4mqxb253a7l1S3X7DX9X0uLHTcROhFmSDe2Ab+TQmY81+Vnzw1/j
	PQsaDdwDNLeXm03tQZx9WepIcCX6DhL9+DGTj47sS3KhWmi9yabe2YAZgvEJd+/mZcNQq6
	I6XX1JZUxH7frEx+zYr8bcjafpo+Q3g3m+VOobAS4jC7gMYofkR/L1sXiSBiFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrckyO9F0B5kpS+FEJ81hi45VwD00rMgDr9u6SGu1BI=;
	b=MS2KmFFLFjXAHdr18G8ortu0T81bwpDX7s75si2RlvNCWnK9G6TECfR8F5G5q9UcPXbW4y
	vblSLB1L/0ua9gAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Make tick_usec static
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
References:
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788389666.1442.12751641136969381369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     66606a93849bfe3cbe9f0b801b40f60b87c54e11
Gitweb:        https://git.kernel.org/tip/66606a93849bfe3cbe9f0b801b40f60b87c54e11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 11 Sep 2024 15:17:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 16:53:38 +02:00

ntp: Make tick_usec static

There are no users of tick_usec outside of the NTP core code. Therefore
make tick_usec static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de

---
 include/linux/timex.h | 7 -------
 kernel/time/ntp.c     | 5 ++++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 7f7a12f..4ee32ef 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -139,13 +139,6 @@ unsigned long random_get_entropy_fallback(void);
 #define MAXSEC 2048		/* max interval between updates (s) */
 #define NTP_PHASE_LIMIT ((MAXPHASE / NSEC_PER_USEC) << 5) /* beyond max. dispersion */
 
-/*
- * kernel variables
- * Note: maximum error = NTP sync distance = dispersion + delay / 2;
- * estimated error = NTP dispersion.
- */
-extern unsigned long tick_usec;		/* USER_HZ period (usec) */
-
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
 	__typeof__(x) __x = (x);	\
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index c17cc9d..ed15ec9 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -31,7 +31,7 @@
 
 
 /* USER_HZ period (usecs): */
-unsigned long			tick_usec = USER_TICK_USEC;
+static unsigned long		tick_usec = USER_TICK_USEC;
 
 static u64			tick_length;
 static u64			tick_length_base;
@@ -44,6 +44,9 @@ static u64			tick_length_base;
 
 /*
  * phase-lock loop variables
+ *
+ * Note: maximum error = NTP sync distance = dispersion + delay / 2;
+ * estimated error = NTP dispersion.
  */
 
 /*

