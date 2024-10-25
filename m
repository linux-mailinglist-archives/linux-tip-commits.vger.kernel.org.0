Return-Path: <linux-tip-commits+bounces-2591-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B57A89B0C84
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1064D28307F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1922161FD;
	Fri, 25 Oct 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RzdRByXo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeUjAIrS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B26215C40;
	Fri, 25 Oct 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879287; cv=none; b=B2WQ0D9bhAV66aVDpt5N2EH6CQ6A4eTbxIh7JHnJDX8+2dfPwAtKwseSJ/k3Li361ohVWSvZ9VgPsf4/SkNA46AhQmb7QC0pfQ4boR/ImfjxAXs+Etvc948B/Mu219rr1AEpLaWuPmYJrSWFoeYEmlmtXT8II06SpLDYNLqecMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879287; c=relaxed/simple;
	bh=7dZ9GMoLnfV5aC4F7OHAgXsaB0ym3uQWk3MpD9opYto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RnQxqCOALUcY2zf8t7gWAQR2ANjCbh2yrEuzEhjO8HwPfIuBkfOusiUVCeuhhdmrNAdrVKR2S/vFcydsOaKqieeDtAOS8EXjfvVzAOze70kWC0wm0mHQ3n7r/HQEVYRIuXQfswPtSnjI3zbXnq52mekAzrKrP3pPwKj5guXkSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RzdRByXo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeUjAIrS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXYmczrXFt9cCexQsaOpZUENRkkFRxlxjlyndzVA058=;
	b=RzdRByXo4bHAMNAh7Zrk9jl3nE0XRo5Z159RWYybv1iOCsqdCvsaG8QPsm431e6ZHA8iVm
	/rHug5b9T6e7QYyzFRBmIpncD/xhUf+taoM5rfYHqIHxfErWLu7OYuPKCZqyBcKBfYeozN
	jYvc7QXbIUSzHI93LhWQYxeWgIrknMfPKW8jsy2taFmcRbDaSD7ri813o2HHJtGimnD22/
	y8NeL5h0v5AzI1EEMrOgSRJu5+PcQXjttqMyeQ+AucYwA4LpknZCfad+pthcRZo08zZhFy
	u7AgGLFPTuHZ+h5dSvjmKnQEdJ3KBNYFZsta4NtqICsBRrEHoZb+X555CXmDyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXYmczrXFt9cCexQsaOpZUENRkkFRxlxjlyndzVA058=;
	b=yeUjAIrS1jougaCGDouA8mnZB+x78lRk5od7r7eNC5PqYGNb6VMUMbsbhg2azfMc5jA5jp
	5WKNm8EKvfbUJ6Dw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Introduce tkd_basic_setup() to make
 lock and seqcount init reusable
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeepin?=
 =?utf-8?q?g-v2-11-554456a44a15=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C20241009-devel-anna-maria-b4-timers-ptp-timekeeping?=
 =?utf-8?q?-v2-11-554456a44a15=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987928324.1442.11305646882144543702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a5f9e4e4ef941048d1ff78cbb1ef95b20ed83802
Gitweb:        https://git.kernel.org/tip/a5f9e4e4ef941048d1ff78cbb1ef95b20ed83802
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 09 Oct 2024 10:29:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:14 +02:00

timekeeping: Introduce tkd_basic_setup() to make lock and seqcount init reusable

Initialization of lock and seqcount needs to be done for every instance of
timekeeper struct. To be able to easily reuse it, create a separate
function for it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-11-554456a44a15@linutronix.de

---
 kernel/time/timekeeping.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d520c11..cd83dea 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1765,6 +1765,12 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
+static __init void tkd_basic_setup(struct tk_data *tkd)
+{
+	raw_spin_lock_init(&tkd->lock);
+	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+}
+
 /*
  * Flag reflecting whether timekeeping_resume() has injected sleeptime.
  *
@@ -1792,8 +1798,7 @@ void __init timekeeping_init(void)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
 
-	raw_spin_lock_init(&tk_core.lock);
-	seqcount_raw_spinlock_init(&tk_core.seq, &tkd->lock);
+	tkd_basic_setup(&tk_core);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&

