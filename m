Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE59229484
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jul 2020 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgGVJM0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgGVJM0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014FC0619DC;
        Wed, 22 Jul 2020 02:12:25 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o8NlohXYQnXlaNEm3IMvotU5bpXfIX7UZoQM981eLY=;
        b=4ArxLigxbHTAEG+HdI1TEyqs+I7uc2vHRdZhLyeoYqmEnK0SU2SoX+j+dSXd6W5uxq0Btf
        s970EXrCtTQxLlnsPUWD9cw6gu5Ien33qbyDAi6/PyilCHxaqBk4FOT1O3HoDZiRc6u8lp
        iJCLb0VVBCiH+RCQS7NC9kuQ2eFnAxh6ea6qlisLFa9zW44NJGvRxhEESFF+hiKrHQpGOR
        3Vy3fkOiWUQUJ8Y7YGd/Z3ZQHWxRpRwfYAEn7eGO0Xd4I7NKgCe1+lsWj5O794VRm3UicQ
        6zYWkaa8r16UVVaPY9F3Hapuz2sBDdV/24ZDKOYMg3Bi5YARyqt/MC5iioWKQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o8NlohXYQnXlaNEm3IMvotU5bpXfIX7UZoQM981eLY=;
        b=2MNG/sgAcVYBBGS/d1mLpn/J9/Z4JB+UszTVGhl4jbXZB24Ny04Q2TZ6dX0NRXT4rH8ZZP
        6SJyWleyO68NO2DQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200712165917.9168-4-valentin.schneider@arm.com>
References: <20200712165917.9168-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159540914347.4006.13840324425889090469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e17ae7fea8714caa743aa0d5e446a25a999ad726
Gitweb:        https://git.kernel.org/tip/e17ae7fea8714caa743aa0d5e446a25a999ad726
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Sun, 12 Jul 2020 17:59:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:06 +02:00

arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE

This option now correctly depends on CPU_FREQ_THERMAL, so select it on the
architectures that implement the required functions,
arch_set_thermal_pressure() and arch_get_thermal_pressure().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lkml.kernel.org/r/20200712165917.9168-4-valentin.schneider@arm.com
---
 arch/arm/Kconfig   | 1 +
 arch/arm64/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac7490..939c4d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,6 +46,7 @@ config ARM
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
+	select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41f..c403e6f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,7 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
+	select SCHED_THERMAL_PRESSURE
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
