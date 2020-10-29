Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB81629E9B3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgJ2KxC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgJ2Kvm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1EDC0613CF;
        Thu, 29 Oct 2020 03:51:42 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jjBfSwRCKSqipevsqRSJ3zMMIHmAMi7xTsQmzLzroY=;
        b=C2lNnu2W9B5TNEgeC5af7ekhn04y2pqYdErEUNAXCZ8LWqCgFJQm92u06NvU0a0dOEyBWf
        q/SwhmPBXy6QNRzGmnidnhaIPQKA07QHgJU7P23mudYBNIp3keYquFGKa7W0ofTHRm7LNO
        nJLFqm/3M7MKLhat3MTPaPClghxziChHUgylK3jj1HFhHiBLEIFoUDWzIknzyEnTcUJzST
        ylJzsGaoNKN3+B2WSAArn0FYpWjwWr1dr1wJZRAQ4RT4SMGLtFOhyiRvAd6+9FoHT8BVC9
        UDL8z0WfrVBgPV6nk2ugsDSwuxAHeW7j2UqbR9j/+gDIxXmRTYSmEFWj7pjGTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jjBfSwRCKSqipevsqRSJ3zMMIHmAMi7xTsQmzLzroY=;
        b=GFZLsCFxKWSWOUbfH2oXj2g2rObCi1stEJksf+XGjpqVuys2ayXQ5gHT35QDOGGZ0r/VfV
        v4RK5JL+zufQzXAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Rocket Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019153528.13850-1-kan.liang@linux.intel.com>
References: <20201019153528.13850-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396870016.397.9899994397896474469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b14d0db5b8c86507c9810c1c8162c7d4a3c656bd
Gitweb:        https://git.kernel.org/tip/b14d0db5b8c86507c9810c1c8162c7d4a3c656bd
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 19 Oct 2020 08:35:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:39 +01:00

perf/x86/intel: Add Rocket Lake CPU support

>From the perspective of Intel PMU, Rocket Lake is the same as Ice Lake
and Tiger Lake. Share the perf code with them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201019153528.13850-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7186098..4d70c7d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5436,6 +5436,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
