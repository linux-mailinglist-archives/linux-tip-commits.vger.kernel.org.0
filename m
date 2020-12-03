Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B642CE2FA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbgLCXsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgLCXsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C4C061A4F;
        Thu,  3 Dec 2020 15:47:51 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EPRDDhEAUDIbDPvHukng9dIeI/+BRwMr7h6eSH66Y8=;
        b=WWLSo6h+lBf5d7onjIcJCb31JSa8q8l5zuYQIcOk04fbfUY1N4k5du0SfaqIvB5VslKpd6
        DFmC37FtJWnPgrOaphi54e6/wXeObW/Wvv9tzePKfzPl+zVOZLlGIRkqFact9zL5Bs42GZ
        5Fruam0F4DoazdE1GZ5H0hY2VVrSmD9Z0qXM/LL0DrOWBx4fziA2YU3VKVDFAK8JC+GNT1
        YNJFlfjDVNUWJT2FOxe+hVlvkPw7E1ivCzHNGOA+AnZYLYdfZkYXd5w4AlA6oII3/PysrR
        3stgR7SffeMwgxOoKHIM1TTRFmag3QwmTcRHz3S9yM6N5jYuG27fr7Lzhrp4lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3EPRDDhEAUDIbDPvHukng9dIeI/+BRwMr7h6eSH66Y8=;
        b=ZZ2dVEMtUTwE6if7JT0CmA2SR6IGyraatwEYgeqytI4YEDo6uJo2qw4CahBT1Ys9osgoq1
        y5kHv98PkSIXR1CA==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/riscv: Make RISCV_TIMER
 depends on RISCV_SBI
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201028131230.72907-1-wangkefeng.wang@huawei.com>
References: <20201028131230.72907-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703926836.3364.14013734584487863383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ab3105446f1ec4e98fadfc998ee24feec271c16c
Gitweb:        https://git.kernel.org/tip/ab3105446f1ec4e98fadfc998ee24feec271c16c
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Wed, 28 Oct 2020 21:12:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

clocksource/drivers/riscv: Make RISCV_TIMER depends on RISCV_SBI

The riscv timer is set via SBI timer call, let's make RISCV_TIMER
depends on RISCV_SBI, and it also fixes some build issue.

Fixes: d5be89a8d118 ("RISC-V: Resurrect the MMIO timer implementation for M-mode systems")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201028131230.72907-1-wangkefeng.wang@huawei.com
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 390c27c..9f00b83 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -644,7 +644,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform" if COMPILE_TEST
-	depends on GENERIC_SCHED_CLOCK && RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV && RISCV_SBI
 	select TIMER_PROBE
 	select TIMER_OF
 	help
