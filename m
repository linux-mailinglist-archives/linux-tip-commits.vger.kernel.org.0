Return-Path: <linux-tip-commits+bounces-4677-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DDDA7C27F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42AD7A94AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32F21D5AF;
	Fri,  4 Apr 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozkysSj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWMuAXbT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88D21D3D9;
	Fri,  4 Apr 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788053; cv=none; b=N7tnYVBrxW5TigbqPz/z48iV+d5Oy5aJSI0vRawptR+nla4jWwXqB3hc528aro4rjFHayPdulKNGHWp2w1xn00HLIt7XjOEysVqikUIACUH88edINt9j1kl9kaZHWBMf6nO+KpUU9yfb2Q3yH4SERcsEqWvgxBNxpsIpaliA8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788053; c=relaxed/simple;
	bh=vSQesiJqx0eXkXtckPcI6s5OfcfCNmnZVhIfXS/Svf8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wmm+fdriEsu4OdnSrY6XJDGy8gCdmPb0f6EoaSgwMdF/7V7d+YCEkmbk81k4PSzutsO8mp97P2JmTuYvqcIjWvHgPMkl4hTtGbdZ4idpSuZuZDFouXLhcZwY6leWSqjw3L8m77/2BxFtEGeWwQotu3qoHEmAcWrYvSg5IZjMv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozkysSj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWMuAXbT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWEYRjQ6uVWFOpqJWTPHwdD8/BpW3z0YcfY8lOraaC0=;
	b=ozkysSj/4MJjIk28Qb9QsZZvG8jwv5vFML1xrdjgne6dsYZ1uXDmr+TG2pWR87wGnuoQnx
	nQWER1AWw4tGAv+A7ZlrkCLWbOv1UUx6IYyX6MOAKS/zF1Pd4idIk+yAa8vc3Iu9RRtI5I
	52AMlqu2TQCulExEUd4RozXMFe5zdWpeDgdThia1mpeN5Qh2+tQyvBSwbiLqCRNka65QlZ
	KgX+L1KiZegg6+cfnfCCgdLj/YX/Hzuntm/zv+sN/IJQLfpYkXui89avMsSvOPX26GMoKl
	nRQMdqJwpD/HXM/bbKqqHd4J2rtyYjCKZyRwajWrGhSGKEpP5nIkXE4ZTm38EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWEYRjQ6uVWFOpqJWTPHwdD8/BpW3z0YcfY8lOraaC0=;
	b=DWMuAXbTZNf5pbWZVnT1ULy+7zlr89Vvldb83tCULnaHglAxFBWFIzXam/1aG0usmH+BI8
	ooc0zoA9YQif7kBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Remove unnecessary NULL check in
 hrtimer_start_range_ns()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4661c571ee87980c340ccc318fc1a473c0c8f6bc=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378805005.31282.3416072238396590953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     e767a548b68989ed3f4e4904ef50847f8b5ccd7c
Gitweb:        https://git.kernel.org/tip/e767a548b68989ed3f4e4904ef50847f8b5ccd7c
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

hrtimers: Remove unnecessary NULL check in hrtimer_start_range_ns()

The 'function' field of struct hrtimer can only be changed using
hrtimer_setup*() or hrtimer_update_function(), and both already null-check
'function'. Therefore, null-checking 'function' in hrtimer_start_range_ns()
is not necessary.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/4661c571ee87980c340ccc318fc1a473c0c8f6bc.1738746927.git.namcao@linutronix.de

---
 kernel/time/hrtimer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 88ea4bb..e883f65 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1316,8 +1316,6 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
-		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
 	 * match on CONFIG_PREEMPT_RT = n. With PREEMPT_RT check the hard

