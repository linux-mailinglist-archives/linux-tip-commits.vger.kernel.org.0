Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432E32CD254
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgLCJPL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgLCJOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C8C061A4E;
        Thu,  3 Dec 2020 01:13:22 -0800 (PST)
Date:   Thu, 03 Dec 2020 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIkKosaBcX+Ew9O7TRSvoATVKwe3UK0Q+EST2eiBX3M=;
        b=InWutED0oVr6hdMklslXLHrI2lwXpvqJ2gcMSSP2a9T6IZyY+mNR7VFKOHaMwBePemEZCa
        RXVZxinOHJ+hkIVExp802jsUAkrci2z4ywpHsiIIxo+WavyBt/tLuPZaqwA5j86++wults
        zkcVaBqiG+R2yoDRzRaylHsnBX9aOK/8UChwDaTEWro5EdF46DW7PRHT6fB56VLnOWAym6
        hOjNuoBMuPpsrSJJVXbqIKBADrUVPpl2y4FU97WX7tj+US9QGbm0y+xgO2mQ1oHIBaSOr1
        34ZwvufJxTGpio54tPSvPA1kA+mswYjtRlFNOPGQfytlmDpBg5IT01eEGuv4QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIkKosaBcX+Ew9O7TRSvoATVKwe3UK0Q+EST2eiBX3M=;
        b=PdtnRIrCeNr0L7M1hh3TMvtcDC4xwJ5gwA/oZE+y+CRveABXMz7jhiiZy8bUqYdMDGBmJc
        pCqqaKqxbObSwuDQ==
From:   "tip-bot2 for Giovanni Gherdovich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Use midpoint of max_boost and max_P for
 frequency invariance on AMD EPYC
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112182614.10700-3-ggherdovich@suse.cz>
References: <20201112182614.10700-3-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <160698680062.3364.2318205075982527285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46609527577d1def0af29ca5b56cffeeea771ada
Gitweb:        https://git.kernel.org/tip/46609527577d1def0af29ca5b56cffeeea771ada
Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
AuthorDate:    Thu, 12 Nov 2020 19:26:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:35 +01:00

x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC

Frequency invariant accounting calculations need the ratio
freq_curr/freq_max, but freq_max is unknown as it depends on dynamic power
allocation between cores: AMD EPYC CPUs implement "Core Performance Boost".
Three candidates are considered to estimate this value:

- maximum non-boost frequency
- maximum boost frequency
- the mid point between the above two

Experimental data on an AMD EPYC Zen2 machine slightly favors the third
option, which is applied with this patch.

The analysis uses the ondemand cpufreq governor as baseline, and compares
it with schedutil in a number of configurations. Using the freq_max value
described above offers a moderate advantage in performance and efficiency:

sugov-max (freq_max=max_boost) performs the worst on tbench: less
throughput and reduced efficiency than the other invariant-schedutil
options (see "Data Overview" below). Consider that tbench is generally a
problematic case as no schedutil version currently is better than ondemand.

sugov-P0 (freq_max=max_P) is the worst on dbench, while the other sugov's
can surpass ondemand with less filesystem latency and slightly increased
efficiency.

1. DATA OVERVIEW
2. DETAILED PERFORMANCE TABLES
3. POWER CONSUMPTION TABLE

1. DATA OVERVIEW
================

sugov-noinv : non-invariant schedutil governor
sugov-max   : invariant schedutil, freq_max=max_boost
sugov-mid   : invariant schedutil, freq_max=midpoint
sugov-P0    : invariant schedutil, freq_max=max_P
perfgov     : performance governor

driver      : acpi_cpufreq
machine     : AMD EPYC 7742 (Zen2, aka "Rome"), dual socket,
              128 cores / 256 threads, SATA SSD storage, 250G of memory,
	      XFS filesystem

Benchmarks are described in the next section.
Tilde (~) means the value is the same as baseline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201112182614.10700-3-ggherdovich@suse.cz
---
 arch/x86/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a4ab5cf..c5dd5f6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2054,6 +2054,8 @@ static bool amd_set_max_freq_ratio(void)
 	}
 
 	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	/* midpoint between max_boost and max_P */
+	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
 	if (!perf_ratio) {
 		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
 		return false;
