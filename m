Return-Path: <linux-tip-commits+bounces-6203-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF3DB11C72
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5838584EAB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E12E8DEB;
	Fri, 25 Jul 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RayQM4sk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhsos3kd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEF2E62C2;
	Fri, 25 Jul 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439509; cv=none; b=QlD8iolBexLrgRJCJn83kw+q5CeszlFNeY4345ogMp004CM+Pizy9IUHsUGsMehDVdF7tLDFYTSRPw4EaqhvPcW2Wfz7sQp5DbZNnFyvIcKkyd4Fe1BSJfJyzTXtuENnqsA41Hxgrce87kdUaBFvmgFrgIQOpJNZ/HnpdvmG+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439509; c=relaxed/simple;
	bh=c9UyqWvyKDoQ0rCbbtEDgcM1g9LYFUhFAbmGqjDMdAY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=frGdzTdftxHeyAzsGuPyoycAg5DkHzJtz2yHBTABwhjJ2VZsy++H/esfgnB9f3HwV4qXhLQt8lQi0r84oKtI+ylWqhZ1oqOx5M8kj7pVV2tge7aZrMgPz0XDeS0IBNq9QyXsh9DwUqRYKETv4UlfwnO+yoOtRosExxMDI7kgQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RayQM4sk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhsos3kd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg4OtJSK2BT6ETCzq4xCke17Js7PSihDgWoBu01m5Jg=;
	b=RayQM4skZhKKuLEY2B1lGf6PZdeJlyr4aTlqyZ3tURN+7CDINYb6IQDr3TY7zCbU3/l0NV
	yul4+HKSMwuF84LCinQq4QgEVXaAzJz8ooJ2C2FMAxARwu4mkNAbw2NZHIX1gbeYfZCL5D
	NPA02e3swX0DOZ/ZMgcaFuHFSnCXGWAgFhbcf74V/n8/8qEOr43REPCxaxXGfnc1s2a/DY
	TSMqo5Qf6PXV1/deZ3A9n6sLC/LJbJNoQacv7EAMs9Z3OurlZGbucqSUcCJINpnRGxV6Bc
	ya7PwOyOE2f/eTdEYCVeku4+qPRZT6ZcF0l/8Jlw9hU678B+oQ5DZ6KsnBbTvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg4OtJSK2BT6ETCzq4xCke17Js7PSihDgWoBu01m5Jg=;
	b=lhsos3kdBQflqsNX6bNsdFJmXk83IbtuRDvcePO21omwvq3wwZmvuvpDnNaL5ybWkB7SaC
	H5X+yPOb4H5scrAQ==
From: "tip-bot2 for Donghoon Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
Cc: Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 John Stultz <jstultz@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-3-willmcvicker@google.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950363.1420.13008443070923899875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     57eac487dfd1d4342812a78138559f9f1d1d5c08
Gitweb:        https://git.kernel.org/tip/57eac487dfd1d4342812a78138559f9f1d1=
d5c08
Author:        Donghoon Yu <hoony.yu@samsung.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:05:32 +02:00

clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64

The MCT register is unfortunately very slow to access, but importantly
does not halt in the c2 idle state. So for ARM64, we can improve
performance by not registering the MCT for sched_clock, allowing the
system to use the faster ARM architected timer for sched_clock instead.

The MCT is still registered as a clocksource, and a clockevent in order
to be a wakeup source for the arch_timer to exit the "c2" idle state.

Since ARM32 SoCs don't have an architected timer, the MCT must continue
to be used for sched_clock. Detailed discussion on this topic can be
found at:

  https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email=
-chirantan@chromium.org/

Original commit from:

  https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6=
eb8dd00727

Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.=
com
---
 drivers/clocksource/exynos_mct.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index da09f46..96361d5 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -219,12 +219,18 @@ static struct clocksource mct_frc =3D {
 	.resume		=3D exynos4_frc_resume,
 };
=20
+/*
+ * Since ARM devices do not have an architected timer, they need to continue
+ * using the MCT as the main clocksource for timekeeping, sched_clock, and t=
he
+ * delay timer. For AARCH64 SoCs, the architected timer is the preferred
+ * clocksource due to it's superior performance.
+ */
+#if defined(CONFIG_ARM)
 static u64 notrace exynos4_read_sched_clock(void)
 {
 	return exynos4_read_count_32();
 }
=20
-#if defined(CONFIG_ARM)
 static struct delay_timer exynos4_delay_timer;
=20
 static cycles_t exynos4_read_current_timer(void)
@@ -250,12 +256,13 @@ static int __init exynos4_clocksource_init(bool frc_sha=
red)
 	exynos4_delay_timer.read_current_timer =3D &exynos4_read_current_timer;
 	exynos4_delay_timer.freq =3D clk_rate;
 	register_current_timer_delay(&exynos4_delay_timer);
+
+	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
 #endif
=20
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
=20
-	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
=20
 	return 0;
 }

