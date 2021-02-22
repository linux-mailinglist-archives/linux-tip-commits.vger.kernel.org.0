Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF563213C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 11:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBVKIZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 05:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBVKGE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 05:06:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79178C0617A7;
        Mon, 22 Feb 2021 02:05:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:04:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988299;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ictB9UNTbPTnZh2bU4966VWv2MsoBeK6KLw5hUUhRX4=;
        b=42mJezkE+n1ONbHAfYI4+nlYqSXtZUVGcXBxyDhCk53EIH/0W8FuWBNgYJZv4bmIPIQlt/
        c24WpuGS/OW6STRev6kpBan++9JekL1kNbqV4IEecyjIzN8wSEv5lI7vOCnYqInQYN6mYD
        B9T0At4Q/pqYRtQSazFv3Jz+hodHyvPQf4Gx7/OTO958uLpGEyMNILVAKZ8A7JpzQdHodb
        gfA0MTZdNyDrcJ+zV6pRM/CI1P1ddvkOK1bEhiasvCpPa6So3N/JQLJetXUaz11Gi9fwGc
        nf9TY54Ky4n9GAMsX20dyGz6K+namKvm0toIxvRalnccPah/OAMz2DHmV3zjtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988299;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ictB9UNTbPTnZh2bU4966VWv2MsoBeK6KLw5hUUhRX4=;
        b=v9ZeKewva8pIX1mOWXWAs/drASFcQHZ/xGzeWjnJhZgAxU9ih7gtVBW91+EBUHadmHTx7/
        sqUnJlepv+OA4KAw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/ixp4xx: Select TIMER_OF when needed
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210103135955.3808976-1-arnd@kernel.org>
References: <20210103135955.3808976-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <161398829842.20312.8658555102212708773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7a3b8758bd6e45f7b671723b5c9fa2b69d0787ae
Gitweb:        https://git.kernel.org/tip/7a3b8758bd6e45f7b671723b5c9fa2b69d0787ae
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Sun, 03 Jan 2021 14:59:24 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jan 2021 16:20:15 +01:00

clocksource/drivers/ixp4xx: Select TIMER_OF when needed

Compile-testing the ixp4xx timer with CONFIG_OF enabled but
CONFIG_TIMER_OF disabled leads to a harmless warning:

arm-linux-gnueabi-ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-ixp4xx.o' being placed in section `__timer_of_table'

Move the select statement from the platform code into the driver
so it always gets enabled in configurations that rely on it.

Fixes: 40df14cc5cc0 ("clocksource/drivers/ixp4xx: Add OF initialization support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210103135955.3808976-1-arnd@kernel.org
---
 arch/arm/mach-ixp4xx/Kconfig | 1 -
 drivers/clocksource/Kconfig  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f7211b5..165c184 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -13,7 +13,6 @@ config MACH_IXP4XX_OF
 	select I2C
 	select I2C_IOP3XX
 	select PCI
-	select TIMER_OF
 	select USE_OF
 	help
 	  Say 'Y' here to support Device Tree-based IXP4xx platforms.
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 14c7c47..66be9ea 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -79,6 +79,7 @@ config IXP4XX_TIMER
 	bool "Intel XScale IXP4xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
+	select TIMER_OF if OF
 	help
 	  Enables support for the Intel XScale IXP4xx SoC timer.
 
