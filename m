Return-Path: <linux-tip-commits+bounces-2583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DC9B0C75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082BD1F24E35
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23A20EA4F;
	Fri, 25 Oct 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPKssegj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqAPOZkm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9620D4FC;
	Fri, 25 Oct 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879282; cv=none; b=Kwy3CsJSoBLAqocujSoUSRDu+4ThD/+tRZbRMk2Ce90i038c29WWIq4adYtZ+B1AGdHwB0VFvNHBi75KpUbNmJiM7HhLA/LP5iBljToO58v60HZPc6F2C3wRaNgO98OHESZqoNPBN1Tmm2NxFt9N/hmAPXsRRviYgXto6w5xOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879282; c=relaxed/simple;
	bh=sQV5smNZy31UoljrVBk2JGitPdlkSZOJsx4QOgJ1laI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KDAtiVqTBd5wbUHftOu9aBeFwueJh6Uo84gvjQ4bovXNh4/jvyWh6PQSdSB94zy/g22c/hsvBGQbLz5jx/4sTlQyxYS0fdAnvQWJiO6Yn4cxNfShTcp7zvXyMNX/pDAJy0EsMFZnwIAC1kKK6//zuaXq3Na6ZQHLX3iudex0Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vPKssegj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eqAPOZkm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOj+LLOKDS23ezwDAMOLLoqOf1iZRh7AYS9Ryy0hcTo=;
	b=vPKssegjGSHIjDoWndsiNNcxrcTRW9rUGsRcjJEzk3y7Ua5YvcAj0GyFURLGOkLhkntSpG
	JOtZ7Oa7stX/jTzswpaqD52fyIIpBYLzysi3pNzRJSWl+OqKsqWcEgElG//PuMDSZso7ND
	1WWHR5D37WVtrCxVxQuuEol8K0uVBvWb+BWlQ8TVsu4ytBf/XwioNuhE6vZCQZBVG3eQR1
	qFl/KnROCirwiHZFiAjmGZLHr58BecO9dxlDQio8iOCPgPzCRbHLZIQUpMK1WQYAkjmCGv
	5YYhyoSyB7+RJ428Ml8PAFtgEsvP6clgVHZME6+/H49fg8mqlu+5xXEtT495Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOj+LLOKDS23ezwDAMOLLoqOf1iZRh7AYS9Ryy0hcTo=;
	b=eqAPOZkmX0aqhEkGg0OZOodPdBh+zZQ2PGy+K1GmsukY+ATJF2hpFun+WhuvHfDo4kuFkP
	iXvZzjv+RosfJ2DQ==
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
Message-ID: <172987927755.1442.15113087899742880071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2cab490b41b28a4239baf810ca1bb1c9d6d017ca
Gitweb:        https://git.kernel.org/tip/2cab490b41b28a4239baf810ca1bb1c9d6d017ca
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:15 +02:00

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

