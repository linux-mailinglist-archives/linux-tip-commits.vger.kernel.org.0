Return-Path: <linux-tip-commits+bounces-6210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43115B11C80
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06345164578
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6D2EBDED;
	Fri, 25 Jul 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HfxY8MDM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgQ02h6V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD102EB5D3;
	Fri, 25 Jul 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439516; cv=none; b=ok6mBR5ERnIK/jvBGmmSJ2c7+XYXCrjedsLTC+UazHxt1nmB6kXy9FnLJtkeYnU7plaoXzY/OGkYc/yafJxDeEYED/ApgbCz3tK7FsGdULdVQceHyfsaQfqLsbyeU5JCoDRioF5PnZqHxHHjVpMZnq9BRuPB5S/WubBPlSYIuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439516; c=relaxed/simple;
	bh=k3jhhaSjGIF9EW7gFpdHvXKrDS9zW1MXDMhOg5F9YHk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G+WctWsJbGPK9SI6YUios4XE3wGLSJD2lxwepgEcJU+KnK5MlFXgh7cGAj5GGjbp4rR6evBrBBrPps6Uy71SHwMaFgNuOWaexI5hKdVSvPfa3Yd3zFYsyKmtZ23Nr+cSTGr8LaJnrZ2AHfsQBjdY2a/OeQHqVSsU44t+kHE4Nxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HfxY8MDM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgQ02h6V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLjylgzYkBRzPQwa+Qnv3d4Qdx2JNhDqmPhEmidJv7s=;
	b=HfxY8MDMiu5DsV1wc/wHJ3uFc3SY6kfpsSG1zZBs/jC/HTgTJCTDkGnDJjDs6cuadPJ/VP
	o6oTzsMbL9p7zAEYG+kQp9yBNmljbmD6aaucZDJJvjwf40ekHwPDZDrFJAEeXdckOGo66Y
	NDFufMZkqe1E80PbEIsoQC8cpLehk5n50iecdYNQ7/C/An5op4GLuyPT0DVWVAJoOsMCZi
	SbuSI44t5nmq+804X5mvoCOGy59P8aWHt1LeQskvp1lyxYds4iHEOjHorDdZ6uejwVzYIq
	XKI5GDmr5wIOM2TEe1ZfU+M60vzrCvohxMQvABdFjXNcjXSngr7JuGrtBViHnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439511;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLjylgzYkBRzPQwa+Qnv3d4Qdx2JNhDqmPhEmidJv7s=;
	b=TgQ02h6VCt+K6T/j5Q6ATKZZff4I5qx5gVMBO0yvhNFzKZJRBCK0cwTnZxXkj5C1ncdF+R
	vMhQm0zXqxz3qICQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] time/sched_clock: Export symbol for
 sched_clock_register() function
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Carlos Llamas <cmllamas@google.com>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-8-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-8-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951054.1420.9514413458124872985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     84deaa77d5dbecdca1f6a12107080a2a2870dd52
Gitweb:        https://git.kernel.org/tip/84deaa77d5dbecdca1f6a12107080a2a287=
0dd52
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:43 +02:00

time/sched_clock: Export symbol for sched_clock_register() function

Timer drivers could be converted into modules. The different
functions to register the clocksource or the clockevent are already
exporting their symbols for modules, but the sched_clock_register()
function is missing.

Export the symbol so the drivers using this function can be converted
into modules.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-8-daniel.lezcano@linar=
o.org
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

