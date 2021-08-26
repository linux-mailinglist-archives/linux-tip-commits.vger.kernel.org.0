Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF93F8387
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhHZIKn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbhHZIKm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939A9C061757;
        Thu, 26 Aug 2021 01:09:54 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENUOH5Lqkr5/5/3huaRKNy0+GNqokCsj1dHZPZUdvOE=;
        b=tWoCVvBjUcwJwkGskZPicLfTYhSuIRQvh9JfgxnnCxxtgZpuUj8ZChiBF2zZ5TltZhck0Y
        KPxNFLBhFLh/ZrRnX9hd2713Xo0Lk5jxz4waYCcQ5ZL4ydIR2f05Zu5/WChVZ9AROjqKkr
        3WIhVtdv+hnvcBVc8N/c2WkJBdCUpJYlhPfszFRW9gRxQMEI/EgxPzcAcQE8wGNs0ScMXG
        L6JUFXc8wz8ZnE31XCW7KBvGIVZQE8jIvmMlGN0PMSUQOtDfqHE12B6YGrdF71exLtmKtI
        k79LudJnH4q0G2bZ19CsowmW2xhbP3Hv4xjBBfs5Iaja9qh7YNmjTv54jy6b+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENUOH5Lqkr5/5/3huaRKNy0+GNqokCsj1dHZPZUdvOE=;
        b=0gfq9HcMHS5N8uXIn2aIexoKR+Ad5duLG8IjRd2MK2dVRcAI47gu2gPbalCd2291dQIkS6
        2zytcTgALDdzR0DA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Simplify code, use free_percpu()'s
 built-in check for NULL
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-5-kim.phillips@amd.com>
References: <20210817221048.88063-5-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996539227.25758.7141307840286911102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6cf295b21608f9253037335f47cd0dfcce812d81
Gitweb:        https://git.kernel.org/tip/6cf295b21608f9253037335f47cd0dfcce812d81
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/amd/uncore: Simplify code, use free_percpu()'s built-in check for NULL

free_percpu() has its own check for NULL, no need to open-code it.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
