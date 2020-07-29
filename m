Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E249223207C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgG2Odu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgG2Ods (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0FC061794;
        Wed, 29 Jul 2020 07:33:48 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033226;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sF3y32fO59mgE9yZ4XLGwaIGcOuJpfXCy6t2yt3pwGo=;
        b=EOGN3WdTOnOXvk1ERtt5RVSb1IJxDImBlgbtXkEMEaiok5ySca5G9/Dw9czRIYGikvyUPb
        LqX4w5sxQ7Zm9lvV9IdofYBMAhWUhp1Whn4Ni5J8VzLY8CdUjioUpsrdf0WnE7GLqDjRap
        gSUOxcHod7ijZQlXG6UGDW6onush/yOvG4qqHitb9L8gGfyIuOTEmJvT2HvQCz9kBrASwt
        lrOwoLQY8LwY+h+m07MtNnOBolq2Yql2nWn8p+GdQItSyFKaiay8khUo55D0MrZZYG1LTV
        AhoDR0AK1NZaR3FTQGlUM9IzDVecci/kjcoy2QPtWZ25+RkbyKoWESxQ1TMfjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033226;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sF3y32fO59mgE9yZ4XLGwaIGcOuJpfXCy6t2yt3pwGo=;
        b=ddfbKBhSsLwt+0DBbwLHgXy3tYG7/KCMezCGUKEGwQKXNthqaGpm3r6mPa3tO/pyTHwVPO
        Z81ArTxA4bSvAoAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm, arm64: Fix selection of CONFIG_SCHED_THERMAL_PRESSURE
Cc:     Qian Cai <cai@lca.pw>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729135718.1871-1-valentin.schneider@arm.com>
References: <20200729135718.1871-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159603322570.4006.15235615372892935766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fcd7c9c3c35aed58aba2eea6d375f0e5b03bd6d6
Gitweb:        https://git.kernel.org/tip/fcd7c9c3c35aed58aba2eea6d375f0e5b03bd6d6
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 29 Jul 2020 14:57:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:16 +02:00

arm, arm64: Fix selection of CONFIG_SCHED_THERMAL_PRESSURE

Qian reported that the current setup forgoes the Kconfig dependencies and
results in warnings such as:

  WARNING: unmet direct dependencies detected for SCHED_THERMAL_PRESSURE
    Depends on [n]: SMP [=y] && CPU_FREQ_THERMAL [=n]
    Selected by [y]:
    - ARM64 [=y]

Revert commit

  e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")

and re-implement it by making the option default to 'y' for arm64 and arm,
which respects Kconfig dependencies (i.e. will remain 'n' if
CPU_FREQ_THERMAL=n).

Fixes: e17ae7fea871 ("arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200729135718.1871-1-valentin.schneider@arm.com
---
 arch/arm/Kconfig   | 1 -
 arch/arm64/Kconfig | 1 -
 init/Kconfig       | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 939c4d6..2ac7490 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,7 +46,6 @@ config ARM
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
-	select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c403e6f..66dc41f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,7 +192,6 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
-	select SCHED_THERMAL_PRESSURE
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/init/Kconfig b/init/Kconfig
index 0a97d85..9f7f249 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -493,6 +493,8 @@ config HAVE_SCHED_AVG_IRQ
 
 config SCHED_THERMAL_PRESSURE
 	bool
+	default y if ARM && ARM_CPU_TOPOLOGY
+	default y if ARM64
 	depends on SMP
 	depends on CPU_FREQ_THERMAL
 	help
