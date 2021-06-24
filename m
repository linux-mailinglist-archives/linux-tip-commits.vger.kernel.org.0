Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D913B2981
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhFXHlw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFXHlr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92DCC061756;
        Thu, 24 Jun 2021 00:39:27 -0700 (PDT)
Date:   Thu, 24 Jun 2021 07:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624520366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m30QSrtNMGte4nFWNlbbRldPqx11fw4jKJA4iK8fg8o=;
        b=v9rNEsLK/a81p0izzfBMo6s5YFgORnqN8m0jWOSUgwbNHCHwFKSGWnFvf4w+aMOpnzfJwI
        KdkX4k0pXj0C16u3oUJRzwOvOa8ZkUJZxtVhi3oUIRYDYN1yqlCE/cvw/NuDWk7CqZdWWD
        sJppoSpa5UuxA/nhFYXqzUAkF8csF5QbUVyH/vDrDhuolcR1SCfODb5Jg88ANVH5Yuo3Xb
        D/7VduQeOmvZN9dkPgv3ZjZNSUkBygnRqcKM7U30hbZyqyKoPbvv4v3npRa+RyIBYiDWFm
        fzhSofXOD8CkcurJZtN+6cCSXAa8ofKw2MQdqd7EFMT5DLuCyPxSJY72O5E82w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624520366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m30QSrtNMGte4nFWNlbbRldPqx11fw4jKJA4iK8fg8o=;
        b=OIzs44DTgWSSgJeF9nkYI0f7Q2+mIXaYV+uKnc0tiigjWDo/QBUb3nO1Xfin2tbWYcWSU3
        MBwkSdBMygQWk+DA==
From:   "tip-bot2 for Beata Michalska" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL
 sched_domain flag
Cc:     Beata Michalska <beata.michalska@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603140627.8409-2-beata.michalska@arm.com>
References: <20210603140627.8409-2-beata.michalska@arm.com>
MIME-Version: 1.0
Message-ID: <162452036571.395.11311163633927225157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2309a05d2abe713f7debc951640b010370c8befb
Gitweb:        https://git.kernel.org/tip/2309a05d2abe713f7debc951640b010370c8befb
Author:        Beata Michalska <beata.michalska@arm.com>
AuthorDate:    Thu, 03 Jun 2021 15:06:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Jun 2021 09:07:50 +02:00

sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag

Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
topology flag, to distinguish between shed_domains where any CPU
capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
a full set of CPU capacities is visible to all domain members
(SD_ASYM_CPUCAPACITY_FULL).

With the distinction between full and partial CPU capacity asymmetry,
brought in by the newly introduced flag, the scope of the original
SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
behaviour when one is detected on a given sched domain, allowing
misfit migrations within sched domains that do not observe full range
of CPU capacities but still do have members with different capacity
values. It loses though it's meaning when it comes to the lowest CPU
asymmetry sched_domain level per-cpu pointer, which is to be now
denoted by SD_ASYM_CPUCAPACITY_FULL flag.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20210603140627.8409-2-beata.michalska@arm.com
---
 include/linux/sched/sd_flags.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 34b21e9..57bde66 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
+ * Domain members have different CPU capacities spanning all unique CPU
+ * capacity values.
+ *
+ * SHARED_PARENT: Set from the topmost domain down to the first domain where
+ *		  all available CPU capacities are visible
+ * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
+ */
+SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
+
+/*
  * Domain members share CPU capacity (i.e. SMT)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
