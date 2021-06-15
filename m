Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDD3A8743
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhFORQo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFORQn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 13:16:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449DC06175F;
        Tue, 15 Jun 2021 10:14:39 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:14:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623777277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SafpwjhBp7YaFsWBnaN9wDAKx7ugIqiUCTrxkxn6ZjE=;
        b=NXV3XFGnf/HGSM12rH+h0NmZg7KMr/EeNfO/oxUib79ecPfSQRxUWugK0UqlNYi3XJgA2G
        Yw8gQkkYpVEOdApteUiiBZsWlN8IdziENHzM6g5Ljn78aWBWSRz8I9LmBRqRdVsAFPYWBI
        FwiNQ7IDYTTEtPTsGTApxjHnMgLfDHE0SN5mr3uytRs/TtWV7q2FGLKmoUMo46yCBfdlvk
        /lZDayDViNKpqvzmkPbvD2WMK60KpbkP2bQdQeX2/JwStw5rxq0xq/9BGt0BcJl1brPo2b
        9hhvjur4Rcb/YOqHYWTu5cs71QwMiBIK0Sy9iBz8mnirYS1Pk8AfeWPmHlv/zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623777277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SafpwjhBp7YaFsWBnaN9wDAKx7ugIqiUCTrxkxn6ZjE=;
        b=n2r0mpT2Spx8jR4CAwmQNtk4Bxhka79zrShvuT/KpzFzxBQ0LhFZ3yoJXYoWDDlnFMwDfc
        lF31AaA6ZZDVlfBg==
From:   "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/events/intel: Do not deploy TSX force abort
 workaround when TSX is deprecated
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Neelima Krishnan <neelima.krishnan@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce4d410f786946280ced02dd07c74e0a74f1d10cb=2E16237?=
 =?utf-8?q?04845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Eco?=
 =?utf-8?q?m=3E?=
References: =?utf-8?q?=3Ce4d410f786946280ced02dd07c74e0a74f1d10cb=2E162370?=
 =?utf-8?q?4845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom?=
 =?utf-8?q?=3E?=
MIME-Version: 1.0
Message-ID: <162377727686.19906.13579403063424613180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ad3c2e174938d72fded674acead42e2464a3b460
Gitweb:        https://git.kernel.org/tip/ad3c2e174938d72fded674acead42e2464a3b460
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Mon, 14 Jun 2021 14:13:23 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 17:36:03 +02:00

x86/events/intel: Do not deploy TSX force abort workaround when TSX is deprecated

Earlier workaround added by

  400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")

for perf counter interactions [1] are not required on some client
systems which received a microcode update that deprecates TSX.

Bypass the perf workaround when such microcode is enumerated.

[1] [ bp: Look for document ID 604224, "Performance Monitoring Impact
      of Intel Transactional Synchronization Extension Memory". Since
      there's no way for us to have stable links to documents... ]

 [ bp: Massage comment. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Link: https://lkml.kernel.org/r/e4d410f786946280ced02dd07c74e0a74f1d10cb.1623704845.git-series.pawan.kumar.gupta@linux.intel.com
---
 arch/x86/events/intel/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2521d03..062bf89 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6015,7 +6015,13 @@ __init int intel_pmu_init(void)
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(pmem);
 
-		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		/*
+		 * Processors with CPUID.RTM_ALWAYS_ABORT have TSX deprecated by default.
+		 * TSX force abort hooks are not required on these systems. Only deploy
+		 * workaround when microcode has not enabled X86_FEATURE_RTM_ALWAYS_ABORT.
+		 */
+		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT) &&
+		   !boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT)) {
 			x86_pmu.flags |= PMU_FL_TFA;
 			x86_pmu.get_event_constraints = tfa_get_event_constraints;
 			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
