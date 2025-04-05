Return-Path: <linux-tip-commits+bounces-4698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF7DA7C851
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A188E3B790E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Apr 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118011DED5D;
	Sat,  5 Apr 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+VRMKUb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+66eP3aY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682F1DC197;
	Sat,  5 Apr 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743842806; cv=none; b=ZPauynBcvMAiiDei3Xk+9G8nUGrPrkv1UPgu+nNE2VDvYAc1AYe/RVzH7JEmq+UbC0dcdseH2nrfb/ZC9tdsdZP5hBYxUzEiGO4fWmmYfJESwzPU+b7NMjaRGCTkpVwTuVV6A/eRC/TSYnEL0aKqgGvrVo9egLepg8V2Nu9jOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743842806; c=relaxed/simple;
	bh=O+qUmyPYPQY1Ndmj/iNjpk9W/JRQam/u3hNE1HDz1OE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RjTzHDcWrpV7Q3mLv+2K9DvoBywZppCAjfDGQtHBUydXw6dcPgRYY+57FlYnGB8KsbX8eXsBgCgSBn+Lk1j6f/4Bwr5Oqv6sK5oSz88IFpD/LIFLeAmp/p5e2SkzSMsPm77385UD0mSVnp8LUBc45ssUy0+Pt2L3Fo7OyOiEqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+VRMKUb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+66eP3aY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 05 Apr 2025 08:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743842799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuVFzXZY8Z/mrg9Rz+nKwmkrRTDFQIGivW+x75zszRQ=;
	b=q+VRMKUbf/LFW6CaGD+Op37JEShPdrwK9XFdtZZcfPLLkRR3cp99+Ku4/Ql6DioYEzTqGy
	2pFVWqQUrXg14j6KOV69mrDGqTT52O3n6zC8cSMSCmLZGyU2A2pjaAWKiHL1/Y5LgOKGSc
	UK4y/a3cZ3xJbloA/A3yfMA+7j5scCCNUyRRvXr6evZXZiYBiCENEtJcdfdLel3GYNlRrn
	5WIgc92zbw9GiDkci4d3jgwPsYZROFIFWcXmRywFtyWxMzOsIWVeWr+s5XzCycWgCJHsLr
	gAB9yFLTeYXvyvRx6oPN7YV0XxG4eBREgVPn3Ml8lOYSsNrPKLsYYoTm53RMnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743842799;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuVFzXZY8Z/mrg9Rz+nKwmkrRTDFQIGivW+x75zszRQ=;
	b=+66eP3aYvhiolZOsBMexmH9AOhWOT0Ajgk/E7DMRDToq1FgWlHT70d902lmdmVF1pQJ/Sj
	AhxG0OAjyLrsWaBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] hrtimers: Merge __hrtimer_init() into
 __hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C8a0a847a35f711f66b2d05b57255aa44e7e61279=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174384279827.31282.4938905262868922075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     87d82cff3829733fa6838492a9215303ad98a61c
Gitweb:        https://git.kernel.org/tip/87d82cff3829733fa6838492a9215303ad98a61c
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 05 Apr 2025 10:30:17 +02:00

hrtimers: Merge __hrtimer_init() into __hrtimer_setup()

__hrtimer_init() is only called by __hrtimer_setup(). Simplify by merging
__hrtimer_init() into __hrtimer_setup().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/8a0a847a35f711f66b2d05b57255aa44e7e61279.1738746927.git.namcao@linutronix.de
---
 kernel/time/hrtimer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2d2835c..163cde3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1592,8 +1592,9 @@ static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 	}
 }
 
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
+static void __hrtimer_setup(struct hrtimer *timer,
+			    enum hrtimer_restart (*function)(struct hrtimer *),
+			    clockid_t clock_id, enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
 	struct hrtimer_cpu_base *cpu_base;
@@ -1626,13 +1627,6 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
-}
-
-static void __hrtimer_setup(struct hrtimer *timer,
-			    enum hrtimer_restart (*function)(struct hrtimer *),
-			    clockid_t clock_id, enum hrtimer_mode mode)
-{
-	__hrtimer_init(timer, clock_id, mode);
 
 	if (WARN_ON_ONCE(!function))
 		timer->function = hrtimer_dummy_timeout;

