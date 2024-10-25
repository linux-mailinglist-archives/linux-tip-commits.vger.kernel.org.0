Return-Path: <linux-tip-commits+bounces-2554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316019B065B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554591C2222E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F3186612;
	Fri, 25 Oct 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yFPYOG8h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLnFQETW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67E16FF4E;
	Fri, 25 Oct 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868032; cv=none; b=eE9KeAYbenJbcE9XYzATqdIDSmNwAW0/tUUWxn3bGDY6VgTISGrQjuuco+7rE2pttOsIXg0VMK+fv0Cwjhmj6tmXCKp60ynyImoPi27d1SSbAZtiIBIMYnN1XfsY69kYEAUFde2IDrOqBRtnN/JP5To2S4CGlEdWOohoLmzM7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868032; c=relaxed/simple;
	bh=XqaMz2YfX/3P+V43JUCwLVCd5w4AtTjPi5tTLWB48bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ipurruspm0kIZkAUtp57F0MyHNtH/GVioKA8IsuXmsCJa+1rUIZl3qSyZ6HxkbaWNC2mB3JhCfsxO21Ib0wJ4oOazTvz7uJ8mc3QFYX0ECJVzpHZ+O8TLoByj4oTJMLuYvuIYX8v80+375rtGgImDQjVUieZVW9vBA5/QQ9CZm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yFPYOG8h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLnFQETW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 14:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729868029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV+HqhXLS8jbdPGBuTLgpBKDluId1N5xZ2rNGO+bgaw=;
	b=yFPYOG8hk9L6LHXomDkNmPlrtFmf0i98M8Qg4C9nsvL3tkQsHCTL0uDQhV72DzuoOEGscF
	AAYzGZ3CEmXx+oeLu0Xvc0xMuMmd4cowMOFoeFuJ5ga6sjbvif+ldqhYx6s273GzB9kknw
	aoalTwErKO5RetuK3iHCEvotgUW28p+18eKS2WESiQzWY6+R/G7hAOs2UMq5KlTmbTQhNV
	Hen5uPswbxu3Ihq37SZtMCcSokVpYDvrNEQjqXiqLBcKNKZqMMF5dgLbyRd5jAsl5yFjFK
	OiZK5UWv5HsBlWH6rad85VCJ3yGmuUIWBNqnYJB/XYOgM0ZBp1hdkkJXy+CU2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729868029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FV+HqhXLS8jbdPGBuTLgpBKDluId1N5xZ2rNGO+bgaw=;
	b=OLnFQETWxqFsH2M8pKdVPhjprkjSsvom70mh9/EnJoZBweAVyBDFvQPW7DMeZhCVPhpPbf
	7f92gXumR4X0L8Bg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Rework timekeeping_init() to use
 shadow_timekeeper
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-19-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-19-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172986802868.1442.2489428187408069194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     15234cc8e924ca3d23ef1b77410faaec274e90aa
Gitweb:        https://git.kernel.org/tip/15234cc8e924ca3d23ef1b77410faaec274e90aa
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 16:41:13 +02:00

timekeeping: Rework timekeeping_init() to use shadow_timekeeper

For timekeeping_init() the sequence count write held time is not relevant
and it could keep working on the real timekeeper, but there is no reason to
make it different from other timekeeper updates.

Convert it to operate on the shadow timekeeper.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f77782f..4e0037d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1809,7 +1809,7 @@ static bool persistent_clock_exists;
 void __init timekeeping_init(void)
 {
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tks = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core);
@@ -1833,22 +1833,20 @@ void __init timekeeping_init(void)
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	write_seqcount_begin(&tk_core.seq);
+
 	ntp_init();
 
 	clock = clocksource_default_clock();
 	if (clock->enable)
 		clock->enable(clock);
-	tk_setup_internals(tk, clock);
+	tk_setup_internals(tks, clock);
 
-	tk_set_xtime(tk, &wall_time);
-	tk->raw_sec = 0;
+	tk_set_xtime(tks, &wall_time);
+	tks->raw_sec = 0;
 
-	tk_set_wall_to_mono(tk, wall_to_mono);
+	tk_set_wall_to_mono(tks, wall_to_mono);
 
-	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
 }
 
 /* time in seconds when suspend began for persistent clock */

