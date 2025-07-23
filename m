Return-Path: <linux-tip-commits+bounces-6174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC75B0EBB0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15F4563F9E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573E2750E9;
	Wed, 23 Jul 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhzLb2ut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weDPthOl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005F274FCE;
	Wed, 23 Jul 2025 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255054; cv=none; b=mipdTsqdC4lhclbRJkzcl0VaagR1MK7h7CkHvRpIqpRRemf+K4nWNyxdH+ZBIeCmXy71WbYsBEQZQkIahzaMZeqZOifFY7zg+ReSM5g9JtTcMNmkGUZkcv5wcrnnM6buYH6v1J9WgR9tfNKhJTibObVc53B2J9uSEWJr6nnwvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255054; c=relaxed/simple;
	bh=TGTw/CafbCf3/QK4Lgq36U7XUUGAKIqKdl09hO1xvxw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k2GIpbzFXRSk2q0ELFgAIGStgFmPZLT6d5+WvbmVibliT2+wh0haqoT+Ua6s+EPVnwKGg7r1IpguwlbSPGsfsgT9A67b++tSI2KB1Rg7eN0r+GmtX7InnunmQpVGTSSoKxvdp2b3mS0bQB4NpNNDXrYiTQPT8LdOSJUVkrxJpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhzLb2ut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weDPthOl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFGH56q0M9UTz3eHkrulP/mPodoEWwwnjEaKtSJ+1Q=;
	b=dhzLb2utO9gtXcJhy9tdYZ7atDl0Spg8zk+2G5Y2h2j57blD2ddNlnxCfpeYrsBBI2AEUm
	C+ndh4eU59tuZ2tMz1BW/O9KoxSZnSA04j06fwfplRwK8SF40g1xQc9o/itRFuQyylsjAq
	E4BN+ZXhaImvUNSsgUtcylcv2ufFbwZ7DaizIKuxQwuykbNn53A97xDlk77l0xGvivjUAD
	Ufo29p4G1O//P/UiMinKEYxyCtEAmHBYG+NJtIikiCZnBoD93a2jT4oLEchqb0sDn1AIGB
	rswEgxXdTtjPbvOW1RjJumFPVL/Zbw9zh6BkAHe0TnqJgyJ1SvTOjhTBelP6Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDFGH56q0M9UTz3eHkrulP/mPodoEWwwnjEaKtSJ+1Q=;
	b=weDPthOllWgEMuodM9BZaRdIgbdoruaIt3aLKTbDTqLw+iUOEpLwiJjDxuXlm6Dj/o9dRa
	GYFeXk7Zf610zOAQ==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
Cc: Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-3-willmcvicker@google.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     394b981382e6198363cf513f6eb6be4c55b22e44
Gitweb:        https://git.kernel.org/tip/394b981382e6198363cf513f6eb6be4c55b=
22e44
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:05 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00

clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64

The MCT register is unfortunately very slow to access, but importantly
does not halt in the c2 idle state. So for ARM64, we can improve
performance by not registering the MCT for sched_clock, allowing the
system to use the faster ARM architected timer for sched_clock instead.

The MCT is still registered as a clocksource, and a clockevent in order
to be a wakeup source for the arch_timer to exit the "c2" idle state.

Since ARM32 SoCs don't have an architected timer, the MCT must continue
to be used for sched_clock. Detailed discussion on this topic can be
found at [1].

[1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-ema=
il-chirantan@chromium.org/

[Original commit from https://android.googlesource.com/kernel/gs/+/630817f708=
0e92c5e0216095ff52f6eb8dd00727

Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Acked-by: John Stultz <jstultz@google.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

