Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACE027F220
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgI3S66 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgI3S65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A99C061755;
        Wed, 30 Sep 2020 11:58:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:58:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqoIUfRqnAtYwMWDy33IcrRlJ7/WRrZ7HU+UhbXz4ss=;
        b=r0Szl/DU7zv9d8NJCcoePWHxUHgBIKYRsWgPVzXX4V8rJeDF8pncSZyPAoDlLJQYbbRu+7
        0qgDdf4lnwtZ4jnuPAKNCCnK9KnC1vK2N//t7fUkJxGrpnFW3gWIW0sLY2zzNji2Qy0G0o
        zhkmH+l0YrRsfWuZkiVUYDyBboDvuS4Fg1S6WK4nlTSY7Xw4mn2GwTFwLryJZy2pDuJcax
        /pmeUmNVbKzvXi0WNrUmUx8zGymjakIBT1rUTQcY4UkYSvJNMWmmeFroee4Kp5O/X6U2bz
        3J722iz9v9plDuJZq3Ak5hIDD/iIjmO23kzvXEZvyEfkrWazzZBFjp4gzObgDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqoIUfRqnAtYwMWDy33IcrRlJ7/WRrZ7HU+UhbXz4ss=;
        b=zTBI378OtFwD101x+HiTOb2VuuWJHJsBtQ2gG894WpMWRrvuv+oAb2dhv78K/YtLV1ZYi9
        lQOihyR44TnltwAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Reduce the number of CBOX counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200925134905.8839-3-kan.liang@linux.intel.com>
References: <20200925134905.8839-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233474.7002.7983108265083974331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ee139385432e919f4d1f59b80edbc073cdae1391
Gitweb:        https://git.kernel.org/tip/ee139385432e919f4d1f59b80edbc073cdae1391
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 25 Sep 2020 06:49:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:01 +02:00

perf/x86/intel/uncore: Reduce the number of CBOX counters

An oops is triggered by the fuzzy test.

[  327.853081] unchecked MSR access error: RDMSR from 0x70c at rIP:
0xffffffffc082c820 (uncore_msr_read_counter+0x10/0x50 [intel_uncore])
[  327.853083] Call Trace:
[  327.853085]  <IRQ>
[  327.853089]  uncore_pmu_event_start+0x85/0x170 [intel_uncore]
[  327.853093]  uncore_pmu_event_add+0x1a4/0x410 [intel_uncore]
[  327.853097]  ? event_sched_in.isra.118+0xca/0x240

There are 2 GP counters for each CBOX, but the current code claims 4
counters. Accessing the invalid registers triggers the oops.

Fixes: 6e394376ee89 ("perf/x86/intel/uncore: Add Intel Icelake uncore support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200925134905.8839-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2bdfcf8..de3d962 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -325,7 +325,7 @@ static struct intel_uncore_ops icl_uncore_msr_ops = {
 
 static struct intel_uncore_type icl_uncore_cbox = {
 	.name		= "cbox",
-	.num_counters   = 4,
+	.num_counters   = 2,
 	.perf_ctr_bits	= 44,
 	.perf_ctr	= ICL_UNC_CBO_0_PER_CTR0,
 	.event_ctl	= SNB_UNC_CBO_0_PERFEVTSEL0,
