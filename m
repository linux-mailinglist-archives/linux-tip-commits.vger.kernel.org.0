Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3823F82CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 08:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbhHZG5c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 02:57:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHZG5b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 02:57:31 -0400
Date:   Thu, 26 Aug 2021 06:56:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629961003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRSW2Vj6MvzqJKgLS4oQwPlRFaZHddykfKT/ZAyygC8=;
        b=kwkKh9PMsiE6j2LWNiL0iQ3CdtqcHkqjBSx9R7wDRFltXqEJI/8Ad+1gDqhKM/nNEmsdI3
        yS2vD0O/Krbs5MRFQlD+yErzar9z8kcalS0m3rqHO91HOtUWbW20opnqu+eF8IUtD2luXv
        TDd50UYOV/iCPs9m1qekf52gRc5r02gAKw0KWxlrw6XHaHYBwdmdklIde/vY6LeA+J6yep
        arYLmnFKW0M6+rkXRpKvuIw/Whzw7NnFpFV02cqR0nBaydubr1VPD2CJItbf6ZchgAgL2l
        N8lHC1J5rgEcRtVdIGsDRGYDNJDsQYEm+kjQdiMoi5IwJsBD8pbkEVVqLuJaPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629961003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRSW2Vj6MvzqJKgLS4oQwPlRFaZHddykfKT/ZAyygC8=;
        b=0z5tFpADQY8XNievygW5UL0qUG6rbYSRM/YJtwnYNEBLtQ5zr2BMsZyrzmewZQko7u4J7w
        38zzvFDEf4qF1lDA==
From:   "tip-bot2 for Xiaoyao Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/pt: Fix mask of num_address_ranges
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210824040622.4081502-1-xiaoyao.li@intel.com>
References: <20210824040622.4081502-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Message-ID: <162996100295.25758.16268174110649682469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c53c6b7409f4cd9e542991b53d597fbe2751d7db
Gitweb:        https://git.kernel.org/tip/c53c6b7409f4cd9e542991b53d597fbe2751d7db
Author:        Xiaoyao Li <xiaoyao.li@intel.com>
AuthorDate:    Tue, 24 Aug 2021 12:06:22 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Aug 2021 15:42:31 +02:00

perf/x86/intel/pt: Fix mask of num_address_ranges

Per SDM, bit 2:0 of CPUID(0x14,1).EAX[2:0] reports the number of
configurable address ranges for filtering, not bit 1:0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20210824040622.4081502-1-xiaoyao.li@intel.com
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9158476..b044577 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -62,7 +62,7 @@ static struct pt_cap_desc {
 	PT_CAP(single_range_output,	0, CPUID_ECX, BIT(2)),
 	PT_CAP(output_subsys,		0, CPUID_ECX, BIT(3)),
 	PT_CAP(payloads_lip,		0, CPUID_ECX, BIT(31)),
-	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x3),
+	PT_CAP(num_address_ranges,	1, CPUID_EAX, 0x7),
 	PT_CAP(mtc_periods,		1, CPUID_EAX, 0xffff0000),
 	PT_CAP(cycle_thresholds,	1, CPUID_EBX, 0xffff),
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
