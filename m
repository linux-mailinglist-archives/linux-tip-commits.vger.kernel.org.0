Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7F4389F6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJXPmV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJXPmU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:20 -0400
Date:   Sun, 24 Oct 2021 15:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635089998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PHCa7Ue+Y1cFGyZFeG5JFAiT39ub1Qqe9HEj8dRcjU=;
        b=KbzQgFnnKcMI4yda3Dh6SbgyTsyC2v/qlQhQfkfjv/EG4PsZCBeJDsNljvH5N/zjy90Q9H
        zBiYiTWcQmC8DBevS3RJwjua8NpB08CrgdWcDg92hzT60Q/MNTDxXw5xrUBMedxPttg5aK
        GCIX3S0zNCUur6Pbngbez6HZbq5dOMEqz41Z9lULapvckecvF5Av/44z7d6cY4YPCpPBoa
        tFpKov3QLyWJnXzjfb9eYHWLBRb3Cu01koIe+ZCZa+5b394Pj0OurfoE5dKGTIZZkDYEHD
        TGz9RFdQP5/f90U12ArpyeoAkuDYbtDoutuRIFth12BJWX62FEIMqoT7p3soLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635089998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PHCa7Ue+Y1cFGyZFeG5JFAiT39ub1Qqe9HEj8dRcjU=;
        b=Wve/+Q//rfXo936tiNMn27uemt0fxDWbTIeHoS1NcaDRC+hxUmdvC6K0fd23Y3tWauiCU6
        Q95OxS49oGdW3ADg==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynosy: Depend on
 sub-architecture for Exynos MCT and Samsung PWM
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021063500.39314-1-krzysztof.kozlowski@canonical.com>
References: <20211021063500.39314-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <163508999769.626.1747216680300353727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8602a80bb85e3840a7bbafca069e25735ba237b3
Gitweb:        https://git.kernel.org/tip/8602a80bb85e3840a7bbafca069e25735ba237b3
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Thu, 21 Oct 2021 08:35:00 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 21 Oct 2021 12:54:28 +02:00

clocksource/drivers/exynosy: Depend on sub-architecture for Exynos MCT and Samsung PWM

The Exynos MCT and Samsung PWM Timer clocksource drivers are not usable
on anything else than Samsung Exynos, S3C or S5P SoC platforms.  These
are integral parts of a SoC.  Even though the drivers are not user
selectable, still document the hardware architecture explicitly with
depends on ARCH_EXYNOS and others.  This also serves a purpose of
documenting use-case, if someone ever wonders whether to select the
driver for his platform.  No functional change, because drivers are
already selected by the platform described in depends. We follow similar
approach also for other SoC-specific drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20211021063500.39314-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index eb661b5..ac56b56 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -417,12 +417,14 @@ config ATMEL_TCB_CLKSRC
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
 config CLKSRC_SAMSUNG_PWM
 	bool "PWM timer driver for Samsung S3C, S5P" if COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || COMPILE_TEST
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
