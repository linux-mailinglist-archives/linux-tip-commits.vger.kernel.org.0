Return-Path: <linux-tip-commits+bounces-5729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A5ABFA9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A87D9E6653
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D7270ED8;
	Wed, 21 May 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8RSAMHR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CIy5LDdQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA262FCE;
	Wed, 21 May 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842586; cv=none; b=mOZWw8IEjyEcOG95h6JxNpXdI0+ZtBrxC1PSoMh2Wafb02OsFaEUjJGlReWhbRoZytY52G8YuUlNPCuQ3OVkybc1fOsSIr1HiD8N/9jEcykD5fTTRJz13Te/jzIhbe5UWlWav9+dSBXMRuPcZsbfGsD98qvtL+/xJK9DDHpWNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842586; c=relaxed/simple;
	bh=Lq0GpIiWnElGdv98PF+mwpA+8gEQD0zAKetf3u4/ziM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wn9SpuLjtL+bip7eIh6/9Rmpo3CW0x7IWcj9LR4VOZONDYV1Wr2f2aP4EN83Ob5y0fsRLr3uYaBxZfTviLkSREd6jFGCNSdFIPncMsUxi74MfEtXp7EnRLuklYjnEArzJFzic/o/rR/DTIy+eMTpIfnvQZHsNcqrNF36kAXm0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8RSAMHR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CIy5LDdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTnr4nSdPF2MnlxKTiIo5MXK/IX2z+jqtDtLAUgIEug=;
	b=j8RSAMHRFxHxzL1DTpKuKcY0EVUCD0rxut8WZ1pWn3+WEnLBNqKRLWgrpGGPBD8MmYmTPO
	cBtXxvOoDflgh5w4Uq+oHt45Yk+DEX55vYD/xKcrS8XKRY0VaVib6bCiASF+5/SPOiNBsZ
	4g6imWjkyRpDdeMtBm6yFgvto0WmjgbL108foi3dtqmb2LVf1kdyzl09LvsCeE1nAlhGc0
	FstjOv0ETNf/TSQAN5qJyrBv6ZrFPOw3BU24k4QAEi64vBDOHX/lxLqCt063zg+NsxWez3
	xRFvPkPAf70s3RP5XS+8VKgoowVZ7U0+LuVGNlJJKsfWjMV4W6oPCi5ZLDVeNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTnr4nSdPF2MnlxKTiIo5MXK/IX2z+jqtDtLAUgIEug=;
	b=CIy5LDdQ0vg8sVBEs9AeCuyiezOXrnLh/YPRu9ImuYvLroQm8hNiqL70mHuMxLQNQuugAV
	W104k9JI9KsLTmCw==
From: "tip-bot2 for Pohsun Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186: Add
 WDIOC_GETTIMELEFT support
Cc: Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507044311.3751033-2-robelin@nvidia.com>
References: <20250507044311.3751033-2-robelin@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258262.406.6289460058363239153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     28c842c8b0f5d1c2da823b11326e63cdfdbc3def
Gitweb:        https://git.kernel.org/tip/28c842c8b0f5d1c2da823b11326e63cdfdbc3def
Author:        Pohsun Su <pohsuns@nvidia.com>
AuthorDate:    Wed, 07 May 2025 12:43:09 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELEFT support

This change adds support for WDIOC_GETTIMELEFT so userspace
programs can get the number of seconds before system reset by
the watchdog timer via ioctl.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
Signed-off-by: Robert Lin <robelin@nvidia.com>
Link: https://lore.kernel.org/r/20250507044311.3751033-2-robelin@nvidia.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 64 ++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 5d4cf52..5eb6b7e 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ * Copyright (c) 2019-2025 NVIDIA Corporation. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -29,6 +30,7 @@
 
 #define TMRSR 0x004
 #define  TMRSR_INTR_CLR BIT(30)
+#define  TMRSR_PCV GENMASK(28, 0)
 
 #define TMRCSSR 0x008
 #define  TMRCSSR_SRC_USEC (0 << 0)
@@ -45,6 +47,9 @@
 #define  WDTCR_TIMER_SOURCE_MASK 0xf
 #define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
 
+#define WDTSR 0x004
+#define  WDTSR_CURRENT_EXPIRATION_COUNT GENMASK(14, 12)
+
 #define WDTCMDR 0x008
 #define  WDTCMDR_DISABLE_COUNTER BIT(1)
 #define  WDTCMDR_START_COUNTER BIT(0)
@@ -234,12 +239,69 @@ static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+	u32 expiration, val;
+	u64 timeleft;
+
+	if (!watchdog_active(&wdt->base)) {
+		/* return zero if the watchdog timer is not activated. */
+		return 0;
+	}
+
+	/*
+	 * Reset occurs on the fifth expiration of the
+	 * watchdog timer and so when the watchdog timer is configured,
+	 * the actual value programmed into the counter is 1/5 of the
+	 * timeout value. Once the counter reaches 0, expiration count
+	 * will be increased by 1 and the down counter restarts.
+	 * Hence to get the time left before system reset we must
+	 * combine 2 parts:
+	 * 1. value of the current down counter
+	 * 2. (number of counter expirations remaining) * (timeout/5)
+	 */
+
+	/* Get the current number of counter expirations. Should be a
+	 * value between 0 and 4
+	 */
+	val = readl_relaxed(wdt->regs + WDTSR);
+	expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, val);
+	if (WARN_ON_ONCE(expiration > 4))
+		return 0;
+
+	/* Get the current counter value in microsecond. */
+	val = readl_relaxed(wdt->tmr->regs + TMRSR);
+	timeleft = FIELD_GET(TMRSR_PCV, val);
+
+	/*
+	 * Calculate the time remaining by adding the time for the
+	 * counter value to the time of the counter expirations that
+	 * remain.
+	 */
+	timeleft += (((u64)wdt->base.timeout * USEC_PER_SEC) / 5) * (4 - expiration);
+
+	/*
+	 * Convert the current counter value to seconds,
+	 * rounding up to the nearest second. Cast u64 to
+	 * u32 under the assumption that no overflow happens
+	 * when coverting to seconds.
+	 */
+	timeleft = DIV_ROUND_CLOSEST_ULL(timeleft, USEC_PER_SEC);
+
+	if (WARN_ON_ONCE(timeleft > U32_MAX))
+		return U32_MAX;
+
+	return lower_32_bits(timeleft);
+}
+
 static const struct watchdog_ops tegra186_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = tegra186_wdt_start,
 	.stop = tegra186_wdt_stop,
 	.ping = tegra186_wdt_ping,
 	.set_timeout = tegra186_wdt_set_timeout,
+	.get_timeleft = tegra186_wdt_get_timeleft,
 };
 
 static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,

