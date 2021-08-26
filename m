Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFEA3F833E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhHZHqO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 03:46:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58592 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZHqN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 03:46:13 -0400
Date:   Thu, 26 Aug 2021 07:45:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629963925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1vx38o6vdPoTRd16votnPrSIHf4V7EthSydmqEEnyw=;
        b=Ad0spxdTnZOwXy2wjsSIgvuXdMqW9v7Qp4atT4ooj2atZZpOfpyI43sJ0MeP3i3Ds1qeUr
        xWQ1WYUSAyKjmYRi6C/cqmoTiUfiKOQfT7wOmQXYwQgYtxuBYAJNWhBvtkM98W9MKvsuVI
        FGgs01zb/uuScCJx1DGFIGinWx8RtERwuG+YNOE8KEIaEdvF23gAMz0cXJOG4l9P+eR4xH
        7vkQZudY7waFKK1M0nJBpQjydBO3XY4i9HA0vikJ5RtX0F37NR83FVKavxSXUVgpM0vIsZ
        Xl2ytrY2YhZeq90OT9IAAYF0K3t6/ASB8mQso0NRDJTfhy/Q1kb7htSXwp08JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629963925;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1vx38o6vdPoTRd16votnPrSIHf4V7EthSydmqEEnyw=;
        b=pu/6GmN0nLMyV694JouzKy4W+CWLy34OG8MQw2H9jlXJ2oOpdzDRvr0CMYeQEA63Nc+9ob
        x9ITCGTAWC+DqaAA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/power: Assign pmu.module
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-4-kim.phillips@amd.com>
References: <20210817221048.88063-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996392470.25758.6765219503941032340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ccf26483416a339c114409f6e7cd02abdeaf8052
Gitweb:        https://git.kernel.org/tip/ccf26483416a339c114409f6e7cd02abdeaf8052
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:43 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:12:57 +02:00

perf/x86/amd/power: Assign pmu.module

Assign pmu.module so the driver can't be unloaded whilst in use.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-4-kim.phillips@amd.com
---
 arch/x86/events/amd/power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 16a2369..37d5b38 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -213,6 +213,7 @@ static struct pmu pmu_class = {
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.module		= THIS_MODULE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
