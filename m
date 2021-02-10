Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8731688D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBJOA0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBJOAO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:14 -0500
Date:   Wed, 10 Feb 2021 13:59:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJf00JHMOyx0/Hm8CnOXTdUi4uJZ9Yvb5fPWbtSJSAw=;
        b=bISiaCidScin1qMZNp5sMDkiZLKA7qyp3XZOKnpO44pEMpz9cgdE7UnQj2pjwag4N+FkD8
        //qjV7cwxKT4FQc4xKM8ty9+rfITcSIfjKDssP4jlIyrI1SHeOSLAZu/39O2DII36HiM5J
        M2iV8FDH0C1gM7nJDsBL3Jpjik1cfoxPJSQSQtY5qQUpxopVHqoboKPbc91WanUh1pMKEZ
        ugTYhOpk2FR2/B2wKbu8LGrhj3tnPIsOXneTl9P3ZYk46p+ovPU6WThqqLMc41EZLOQ4Oe
        +IrQzsyT1VILAH41pfxFfCx2Z9N5ywydqG9D/LZkOrz8vAng7I/7YnVy2kNqsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJf00JHMOyx0/Hm8CnOXTdUi4uJZ9Yvb5fPWbtSJSAw=;
        b=y1YD95Zp2rN4GHkSWxCZj9+P3215SE721TwZIKg1UhHoePstvWcsFqMNUFUr5vRnddJbkD
        NmTD23dGWNeoeTDQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Fix psys-energy event on Intel SPR platform
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210204161816.12649-3-rui.zhang@intel.com>
References: <20210204161816.12649-3-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <161296556988.23325.3666894255401748695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     838342a6d6b7ecc475dc052d4a405c4ffb3ad1b5
Gitweb:        https://git.kernel.org/tip/838342a6d6b7ecc475dc052d4a405c4ffb3ad1b5
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 05 Feb 2021 00:18:16 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:55 +01:00

perf/x86/rapl: Fix psys-energy event on Intel SPR platform

There are several things special for the RAPL Psys energy counter, on
Intel Sapphire Rapids platform.
1. it contains one Psys master package, and only CPUs on the master
   package can read valid value of the Psys energy counter, reading the
   MSR on CPUs in the slave package returns 0.
2. The master package does not have to be Physical package 0. And when
   all the CPUs on the Psys master package are offlined, we lose the Psys
   energy counter, at runtime.
3. The Psys energy counter can be disabled by BIOS, while all the other
   energy counters are not affected.

It is not easy to handle all of these in the current RAPL PMU design
because
a) perf_msr_probe() validates the MSR on some random CPU, which may either
   be in the Psys master package or in the Psys slave package.
b) all the RAPL events share the same PMU, and there is not API to remove
   the psys-energy event cleanly, without affecting the other events in
   the same PMU.

This patch addresses the problems in a simple way.

First,  by setting .no_check bit for RAPL Psys MSR, the psys-energy event
is always added, so we don't have to check the Psys ENERGY_STATUS MSR on
master package.

Then, by removing rapl_not_visible(), the psys-energy event is always
available in sysfs. This does not affect the previous code because, for
the RAPL MSRs with .no_check cleared, the .is_visible() callback is always
overriden in the perf_msr_probe() function.

Note, although RAPL PMU is die-based, and the Psys energy counter MSR on
Intel SPR is package scope, this is not a problem because there is only
one die in each package on SPR.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20210204161816.12649-3-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7ed25b2..f42a704 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -454,16 +454,9 @@ static struct attribute *rapl_events_cores[] = {
 	NULL,
 };
 
-static umode_t
-rapl_not_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	return 0;
-}
-
 static struct attribute_group rapl_events_cores_group = {
 	.name  = "events",
 	.attrs = rapl_events_cores,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_pkg[] = {
@@ -476,7 +469,6 @@ static struct attribute *rapl_events_pkg[] = {
 static struct attribute_group rapl_events_pkg_group = {
 	.name  = "events",
 	.attrs = rapl_events_pkg,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_ram[] = {
@@ -489,7 +481,6 @@ static struct attribute *rapl_events_ram[] = {
 static struct attribute_group rapl_events_ram_group = {
 	.name  = "events",
 	.attrs = rapl_events_ram,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_gpu[] = {
@@ -502,7 +493,6 @@ static struct attribute *rapl_events_gpu[] = {
 static struct attribute_group rapl_events_gpu_group = {
 	.name  = "events",
 	.attrs = rapl_events_gpu,
-	.is_visible = rapl_not_visible,
 };
 
 static struct attribute *rapl_events_psys[] = {
@@ -515,7 +505,6 @@ static struct attribute *rapl_events_psys[] = {
 static struct attribute_group rapl_events_psys_group = {
 	.name  = "events",
 	.attrs = rapl_events_psys,
-	.is_visible = rapl_not_visible,
 };
 
 static bool test_msr(int idx, void *data)
@@ -534,6 +523,14 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
 };
 
+static struct perf_msr intel_rapl_spr_msrs[] = {
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, true, RAPL_MSR_MASK },
+};
+
 /*
  * Force to PERF_RAPL_MAX size due to:
  * - perf_msr_probe(PERF_RAPL_MAX)
@@ -764,7 +761,7 @@ static struct rapl_model model_spr = {
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_msrs      = intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
