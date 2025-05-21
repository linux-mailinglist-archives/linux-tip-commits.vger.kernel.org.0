Return-Path: <linux-tip-commits+bounces-5726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E327ABFA91
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF288C4082
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387A264A63;
	Wed, 21 May 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+BTW7hT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6mnmr6U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2222D7B7;
	Wed, 21 May 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842585; cv=none; b=D3tuVOriwYsuXYR2WNSb3e/ZjphhKQBwzGaSF5fLAY61a7VlSSfENT6rXUsGLw+I3dLxxQELrAPGWXC6FZHxd4W05aH0uSwdQr9kj+/90qnTTLE8SkIB2YnI1rpWmJ2jraG3p2TQgo3hq+kFl98QpxUk3hUol115G9iXJ/K2qZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842585; c=relaxed/simple;
	bh=6lfRm5uJsWtjg9wrUn7yd0o6zu7bMUupiiQKJ6fArNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d4guiA+ot4NgPR3DOwhUGlWJq/DH/kMUNBazmUOk2H6nJC27AHlYhS87CsNvWYlKZpRfJMyncbTL7GTENLbIUyTQ2ht26J/r8FggKE/jWjWZ90uVQeGpTOosBUiHRHzyBIIAwTXZd2AMG5QFmk0zbyw3KRm4deMUp4NXcbCMAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+BTW7hT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6mnmr6U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OlPTwB4OHfWl1yAAKyQx+j3W7tkeURG2F8enN92XiA=;
	b=O+BTW7hTgtgDv1g4qeDt5hxEkD4Tnbk9Or5D0rQ0qpFbB8l7wEVLJUUmkDmXOvQG+RIsXC
	aMv7toAFE+ZV1tF1U3V3vM3utfv6nJg8W3lg1OHP9l/ltExWOtI3+TCU72Efb8s8Q4lrGb
	DG4yfSvSXKOLrSY5y3RpYU364EMA3uXritvIveTL9vVEVFvY0aSJR/eyuPgGbloQ2WhSTh
	WtxS33DPzJOoe4+l5rAOHc7k4fqDGDDIyGFkR40wsKMzzOTNpBZkASR6LtvrHVR1AScUAL
	GUODsaprGI9OVz7oV+yhTv5Vf72NjlXYx/gyJFexrO+4x1j2JWTmICy53FpYLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OlPTwB4OHfWl1yAAKyQx+j3W7tkeURG2F8enN92XiA=;
	b=z6mnmr6Uq4rNGcXyv2ulC0iPld3whD7tUJe0/T6XMF/AuNsjpZX7ozmVo3BaIqKOBX5y0E
	GD4981fiLih+p9Cw==
From: "tip-bot2 for robelin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Remove
 unused bits
Cc: robelin <robelin@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507044311.3751033-4-robelin@nvidia.com>
References: <20250507044311.3751033-4-robelin@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258107.406.2455116961690341481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     39b27ddf4d680fc908b2fc788039406e2e1c4601
Gitweb:        https://git.kernel.org/tip/39b27ddf4d680fc908b2fc788039406e2e1c4601
Author:        robelin <robelin@nvidia.com>
AuthorDate:    Wed, 07 May 2025 12:43:11 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

clocksource/drivers/timer-tegra186: Remove unused bits

The intention to keep the unsed if(0) block is gone now. Remove
them for clean codes.

Signed-off-by: robelin <robelin@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20250507044311.3751033-4-robelin@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index fb8a51a..e5394f9 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -174,15 +174,6 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 		value &= ~WDTCR_PERIOD_MASK;
 		value |= WDTCR_PERIOD(1);
 
-		/* enable local FIQ and remote interrupt for debug dump */
-		if (0)
-			value |= WDTCR_REMOTE_INT_ENABLE |
-				 WDTCR_LOCAL_FIQ_ENABLE;
-
-		/* enable system debug reset (doesn't properly reboot) */
-		if (0)
-			value |= WDTCR_SYSTEM_DEBUG_RESET_ENABLE;
-
 		/* enable system POR reset */
 		value |= WDTCR_SYSTEM_POR_RESET_ENABLE;
 

