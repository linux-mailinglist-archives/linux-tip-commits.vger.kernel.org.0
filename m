Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663223ACFAC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhFRQFv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhFRQFu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B1C061574;
        Fri, 18 Jun 2021 09:03:40 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADz+raE3UC3dmf6KgIT/Yuyg5O5AJCFh7zi6fdNcdH8=;
        b=olgar+yJ5iIIDxcWga1dowN6bGdsiWYCHaHncd+yDJzuprWCdiYT+gtx6XtXbw1czMQRly
        IwY56pkeEtVCXPJBg7ZkD5OSeB0JPCLHpz35XRjlID3+90o0A6275iyyClgX1ltKWkrQI7
        yNeH6A//4kwGZ68/G/D5F3DXnBzPajM6zdCtxqBOiDTUF39cq8Xds/FjTfpWcTfJIl/B/3
        C8d7pBREuTJ24org5LvWHstL+8x7Y71MKrpF0rjOM/OewSArRmJ2xOa7jI1G708QLyJQ5c
        3QfgXNwnEgzCtgWFC4z9bUsvqn5qQLlff6Kxgf7kR2UyFSnH1/OkDm4XFgQCPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ADz+raE3UC3dmf6KgIT/Yuyg5O5AJCFh7zi6fdNcdH8=;
        b=QpZb+cBEiR0Q1xfrKysy3c4IyZG0gEsBvKwNyFll4xJ1RpBhp5gceb5hX15crPwF9GJekv
        mQ5yVX83uBcBPCBg==
From:   "tip-bot2 for Andrea Merello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER
 due to CONFIG_CPU_FREQ anymore
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        soren.brinkmann@xilinx.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org
In-Reply-To: <20210406130045.15491-3-andrea.merello@gmail.com>
References: <20210406130045.15491-3-andrea.merello@gmail.com>
MIME-Version: 1.0
Message-ID: <162403221865.19906.17203231411813786854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     68e2215e9d5f5ec8e5ba0158683742932519cad9
Gitweb:        https://git.kernel.org/tip/68e2215e9d5f5ec8e5ba015868374293251=
9cad9
Author:        Andrea Merello <andrea.merello@gmail.com>
AuthorDate:    Tue, 06 Apr 2021 15:00:45 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 16 Jun 2021 17:33:04 +02:00

arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to CONFIG_CPU_FREQ anymo=
re

Now ARM global timer driver could work even if it's source clock rate
changes, so we don't need to disable that driver when cpu frequency scaling
is in use.

This cause Zynq arch to get support for timer delay and get_cycles().

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210406130045.15491-3-andrea.merello@gmail.c=
om
---
 arch/arm/mach-zynq/Kconfig  | 2 +-
 drivers/clocksource/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 43fb941..a56748d 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -6,7 +6,7 @@ config ARCH_ZYNQ
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER if !CPU_FREQ
+	select ARM_GLOBAL_TIMER
 	select CADENCE_TTC_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 19fc5f8..9fa2823 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -360,6 +360,7 @@ config ARM_GLOBAL_TIMER
=20
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
+	default 2 if ARCH_ZYNQ
 	default 1
 	depends on ARM_GLOBAL_TIMER
 	help
