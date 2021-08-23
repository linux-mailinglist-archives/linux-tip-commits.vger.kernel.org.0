Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD63F479B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbhHWJdc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbhHWJda (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7842C061575;
        Mon, 23 Aug 2021 02:32:48 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N78n5UL3QOqJfLiifQMaVPPAdxGGOO9LjsZ1CqpXDbQ=;
        b=JPi40sOiMv/W3YKkvz4A+4rNbxCsFLKSXSAUkdeD24tzHoegUDn2Fpy2kPKZ+FdOaRCKh6
        hki3SSKHAa+wLSq1qzFV4gg0FFF2IQa5Q66HifDaT16uZGRo6KqarqE9QUDUcR1snH68c6
        M6KkMxQMvesiEFv5bcBouAlVvlDRWurt3k1t3A0ikvWwiJgJbPe/xVTPJbpn5X7k9xAKjw
        A2jL67y3UPfm5VFUmbLLLX7qxI2EMZlfunddttjNKDMrqO9QUpd0kPc1COh1wOWTLK97yR
        XH1rQ0CHE15toyWozpeIX5U0U80uHs2kmM3+D4Vr+jwkud9YVLk+A6Fm3/ep0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N78n5UL3QOqJfLiifQMaVPPAdxGGOO9LjsZ1CqpXDbQ=;
        b=ojZl1ARFM4gGWgqyla1XM7MPvMZ+a3tWB4KC1xPALS1PC31lAWTqPSvqI1gqUxMGKiv1uY
        +LI3V6BDK/DoSaCA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Use free_percpu's built-in check for null
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-5-kim.phillips@amd.com>
References: <20210817221048.88063-5-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116653.25758.6586153876849600277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7987baceb9fe700a35b86e4a2f55b2d2d524d687
Gitweb:        https://git.kernel.org/tip/7987baceb9fe700a35b86e4a2f55b2d2d524d687
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:44 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:13 +02:00

perf/amd/uncore: Use free_percpu's built-in check for null

free_percpu() has its own check for null.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210817221048.88063-5-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 582c0ff..05bdb4c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -659,11 +659,9 @@ fail_prep:
 fail_llc:
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB))
 		perf_pmu_unregister(&amd_nb_pmu);
-	if (amd_uncore_llc)
-		free_percpu(amd_uncore_llc);
+	free_percpu(amd_uncore_llc);
 fail_nb:
-	if (amd_uncore_nb)
-		free_percpu(amd_uncore_nb);
+	free_percpu(amd_uncore_nb);
 
 	return ret;
 }
