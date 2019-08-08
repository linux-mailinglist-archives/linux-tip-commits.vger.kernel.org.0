Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8786084
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfHHLAd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 07:00:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHLAd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 07:00:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78B0FOa3128321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 04:00:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78B0FOa3128321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565262016;
        bh=T+PEPqCjbiKUY0I0c8YBNkeV+FlD66sZGnf9J3SBYfo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mSR/pXrcIvc2yu2wnRXvj1QWnVfHdX9iKgp7PvF8eqAWNethcdgCARp2P8Y9nWtYR
         pxDw/GnYLyKNp50DFiwGAhXOnFBUeA2jLMybhWhPUJGtSoEdvN2exlSy+OwqtxP85J
         bYuxQg5CzRjmxkl2Tx2fMjEyJspQMAdkn+VjpA5hvaxSOrTwEVUIwsvOv+wF6MsbY5
         wRZC1/ZhAlugP50XcTnW9bI9fu/t6hvUEc9MdU1mnygDsppCF9TEx75DCAUWyAiozm
         VsbYOiPC47dVaqoR1MMo5JpOtzGyRipYsVxWpBp+3bAp+xcUM33icleJqiZpJiUShX
         FRoJxhQbqj8uw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78B0FCr3128317;
        Thu, 8 Aug 2019 04:00:15 -0700
Date:   Thu, 8 Aug 2019 04:00:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-5c3ceef9ad7b340b0acee6c26d0c9e6429decb2c@git.kernel.org>
Cc:     qais.yousef@arm.com, peterz@infradead.org, mingo@redhat.com,
        hpa@zytor.com, viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
          vincent.guittot@linaro.org, qais.yousef@arm.com,
          peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
          viresh.kumar@linaro.org
In-Reply-To: <20190802104628.8410-1-qais.yousef@arm.com>
References: <20190802104628.8410-1-qais.yousef@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpufreq: schedutil: fix equation in comment
Git-Commit-ID: 5c3ceef9ad7b340b0acee6c26d0c9e6429decb2c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  5c3ceef9ad7b340b0acee6c26d0c9e6429decb2c
Gitweb:     https://git.kernel.org/tip/5c3ceef9ad7b340b0acee6c26d0c9e6429decb2c
Author:     Qais Yousef <qais.yousef@arm.com>
AuthorDate: Fri, 2 Aug 2019 11:46:28 +0100
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

cpufreq: schedutil: fix equation in comment

scale_irq_capacity() call in schedutil_cpu_util() does

	util *= (max - irq)
	util /= max

But the comment says

	util *= (1 - irq)
	util /= max

Fix the comment to match what the scaling function does.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Link: https://lkml.kernel.org/r/20190802104628.8410-1-qais.yousef@arm.com
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 636ca6f88c8e..e127d89d5974 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -259,9 +259,9 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	 * irq metric. Because IRQ/steal time is hidden from the task clock we
 	 * need to scale the task numbers:
 	 *
-	 *              1 - irq
-	 *   U' = irq + ------- * U
-	 *                max
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
 	 */
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
