Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7246E3888E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbhESIEN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:04:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbhESIEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:04:12 -0400
Date:   Wed, 19 May 2021 08:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrBKEcQb2rwqfg9yK1W+KxlHz6+lnpZ+OHOEme6w4wk=;
        b=q1lKjv3+l1KPV8tLU9L8Th1tvcXjYG4uECoTfvvpcRAOuog/gujwu1Swv32mR7MR8IfHo5
        6Gje/NtWuryCtSOhPCEL5aMUxqj/wHrFFGwCMQ9LG8ItwUf+p5SJBj5pwy6woPNi5jGliK
        xFL7REVp9ClwWl8lXfllchRggUG6GOtNdC423r6KcIGdkInyatZPXMebkybZHmyvEbEgg8
        9J1ns2ZjaVuzez/dkUczcFSRjGOkS0HVZCPvkQAvnKdwuswK9TiTCrfLicpSef3F9cSLFH
        6KTbCH5InhOF7TidVoceN/QIeza1B1Z28Rb4e5BAnO0Nz0lZI+sStFhoO1qZEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrBKEcQb2rwqfg9yK1W+KxlHz6+lnpZ+OHOEme6w4wk=;
        b=oSUNXPUMDqiLYyb7M/U2zKHuxDHdZq7J6XVUTHifVVbmqiVFV8rhNsyfHrGJNT30KZCmqi
        JWQMjxTiXsFXRKBw==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Avoid touching LBR_TOS MSR for Arch LBR
Cc:     Like Xu <like.xu@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210430052247.3079672-1-like.xu@linux.intel.com>
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162141137216.29796.11868187906649777826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3317c26a4b413b41364f2c4b83c778c6aba1576d
Gitweb:        https://git.kernel.org/tip/3317c26a4b413b41364f2c4b83c778c6aba1576d
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Fri, 30 Apr 2021 13:22:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:47 +02:00

perf/x86: Avoid touching LBR_TOS MSR for Arch LBR

The Architecture LBR does not have MSR_LBR_TOS (0x000001c9).
In a guest that should support Architecture LBR, check_msr()
will be a non-related check for the architecture MSR 0x0
(IA32_P5_MC_ADDR) that is also not supported by KVM.

The failure will cause x86_pmu.lbr_nr = 0, thereby preventing
the initialization of the guest Arch LBR. Fix it by avoiding
this extraneous check in intel_pmu_init() for Arch LBR.

Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
[peterz: simpler still]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210430052247.3079672-1-like.xu@linux.intel.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2521d03..e288922 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6253,7 +6253,7 @@ __init int intel_pmu_init(void)
 	 * Check all LBT MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
+	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
 		x86_pmu.lbr_nr = 0;
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
