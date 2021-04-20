Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA4365685
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhDTKrP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhDTKrO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:14 -0400
Date:   Tue, 20 Apr 2021 10:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkrD1L5nueXeJZrckvtVOjYvPICdIW/we7aLIC4kJF4=;
        b=X2gwRjaJG2zWmk5v62dvfpKVP7jNmOKWSh5GHm5g3Xp+fEPWRVp9QBM1LDO8+XRPAf3zQw
        sqnIXsMBz96CexJz+PPnviPeJQOq8RpyvMAtV0TD/dsUKDAyRLZIEtl/H8kKSSLGcwyWNn
        76AVykmEqk+XW6zkMtUs2+Cdq/486wINa6BXam5oCATViVRuA9o4B7LLQVUCelWxXnX/M1
        AbFmwKq7a1x2u9qrVMvcs2K4wHgVfXoMmuVHHgqKGJEtLlU96JE0i1eiExhiy2e8TZp/M2
        z3KZRC8obxieDWDkAR/FEWYK7B5mE/eIlhE9RfHWFZLkDaIyPcaGF7IOepOZ8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkrD1L5nueXeJZrckvtVOjYvPICdIW/we7aLIC4kJF4=;
        b=vjDQVuurIO4CpWwD/SjteRxLCI269evbvc6DgUy1mdBw6cmFFoKITQQR+QhzhoEM9HITZA
        PBtJsSzbNKwzSRCA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Alder Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-24-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-24-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560119.29796.11364634587535953691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     19d3a81fd92dc9b73950564955164ecfd0dfbea1
Gitweb:        https://git.kernel.org/tip/19d3a81fd92dc9b73950564955164ecfd0dfbea1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:31:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:29 +02:00

perf/x86/msr: Add Alder Lake CPU support

PPERF and SMI_COUNT MSRs are also supported on Alder Lake.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-24-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 680404c..c853b28 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -100,6 +100,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
 	case INTEL_FAM6_ROCKETLAKE:
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
