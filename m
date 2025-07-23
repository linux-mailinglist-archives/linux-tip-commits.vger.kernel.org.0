Return-Path: <linux-tip-commits+bounces-6180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914FDB0EBB4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5261C848CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FE2777E1;
	Wed, 23 Jul 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WKOXFp2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/PgiAYvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DE27701C;
	Wed, 23 Jul 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255061; cv=none; b=hsZHQexy8kgwKYiREF0JN48KGvbvggyHE47BKyNAMdBlX/7nm7iOkoP/EpXh2ZLMWecvmVIALe2Ud5XYhuk+mkqAuoj8EHPl1R5LIHnO/HCHFIL+dBbDVaHTJHjRuGKgw+uDaJGkBHFV4jJQIgQZoc38dGByzyZgwA+nnb9bi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255061; c=relaxed/simple;
	bh=ABZKhJPGP9ljExqQ8ct6J3ef59lwhSwFLObXZWEib8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jyHF0qRsbl9QGiV+IfstqoKa7wBgYvWXjo4s1fLNYrPPoWdLqoV+jkHhCI8xv77h3/Kk8yn0RG78gMQETG6WYGJ5VYb3FbCxOtm/6ZY1SI4EC+5unsSrKhtFJf1i54HVbcnl8vnSoHN13RY3u4vs1UXjDkOS7sxgWt7aTIFfzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WKOXFp2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/PgiAYvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxKbX664JGl7tf9IoCXD05+eiTwbaBU4+lSvqdDurAY=;
	b=3WKOXFp2ut8xQ+XnW99JpaHNqvcDNaDjxIo7zpv/zy+TFht7SkKug1vdqFdUWeBL3fBUM3
	bTFYg8oG9ht37nq+1DZ5YCedUMDQam4W7gYW2F9+M/CYexdBRaF2OroCqXTEqMWnYgb72y
	0mTtq0M2veRF3+FYIwyqk5ZcouLRZkgDu1CgJXXY2vHqLCf51KEBF4VhXu3q1J4LHdAbbD
	Fj3kOS4UaLJcVCLAb8CBXRNFILNtao/TkEXlsok3lEPeG3Y3DQFF3Uq4h8jZebMHUolULD
	XSb1eSEFNMkwW250049P5smSk9rLOyBls3IFd4+3La+9Fljkbc8k593dRUthTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxKbX664JGl7tf9IoCXD05+eiTwbaBU4+lSvqdDurAY=;
	b=/PgiAYvgifjHovVdyrMngFNFDats6rN6SFsfG40R9V6iSromRT0ixt9knfn/JpIPTGgMUV
	QVm9ah1VRLeuqYCQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] time/sched_clock: Export symbol for
 sched_clock register function
Cc: Will McVicker <willmcvicker@google.com>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Carlos Llamas <cmllamas@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-8-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-8-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505624.1420.2572890421381994075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     1bc6a9b86eaa9d9da346ce4c137952c1782ac94d
Gitweb:        https://git.kernel.org/tip/1bc6a9b86eaa9d9da346ce4c137952c1782=
ac94d
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

time/sched_clock: Export symbol for sched_clock register function

The timer drivers could be converted into modules. The different
functions to register the clocksource or the clockevent are already
exporting their symbols for modules but the sched_clock_register()
function is missing.

Export the symbols so the drivers using this function can be converted
into modules.

Reviewed-by: Will McVicker <willmcvicker@google.com>
Acked-by: John Stultz <jstultz@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-8-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cc15fe2..cc1afec 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -174,8 +174,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtim=
er *hrt)
 	return HRTIMER_RESTART;
 }
=20
-void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -247,6 +246,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigne=
d long rate)
=20
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
+EXPORT_SYMBOL_GPL(sched_clock_register);
=20
 void __init generic_sched_clock_init(void)
 {

