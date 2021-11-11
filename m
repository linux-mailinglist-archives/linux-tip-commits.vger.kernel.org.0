Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415844D691
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhKKMZU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbhKKMZU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:20 -0500
Date:   Thu, 11 Nov 2021 12:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsZI6trMhFGTz4ljsk0ULCNPbtxt95TknQmxiPdqXTA=;
        b=FYUILA0OV2EBulHACH+cjfqxOQ3A1E5Lw8DIAausiP3UEmDCahzL6wpdNvBEbpEf6SI4GT
        iavWNHeL4B4ZkwdFb5I8SaY4FOgcnlLWa/7gaBGXZcCGWfRk7PuOakci+gmt5Y/k99fKn/
        381QqfdAYfpQYiRKnXnJeI9QcRidKJxOycUAPIs9QIJZAHnBAHYO2gThrg8RtzJRPl+VEk
        thfGtWKeK45N8RvrtiWUzKjhX4K2HD73I4T8GCiVmXYnNlzNwPLBmXCEyazpq5/pJlvZru
        khSVu2Yy/Alws0BmNf6NI9+Vliq2KSS9lb7s0eFxWsA7i+4c70AZQtKLLMntRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsZI6trMhFGTz4ljsk0ULCNPbtxt95TknQmxiPdqXTA=;
        b=hIjM7NyOGxHSLvAorQbu7Z0KWJjnqmYQWPw4T/8EdjBxEe0ilgsTTKKV4uQxQeeyG4UWxb
        o0HKTVLiiQjiIoDQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Cc:     "Jing-Ting Wu" <jing-ting.wu@mediatek.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211104175120.857087-1-vincent.donnefort@arm.com>
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <163663334891.414.10793572232732655162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     42dc938a590c96eeb429e1830123fef2366d9c80
Gitweb:        https://git.kernel.org/tip/42dc938a590c96eeb429e1830123fef2366d9c80
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Thu, 04 Nov 2021 17:51:20 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:32 +01:00

sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()

Nothing protects the access to the per_cpu variable sd_llc_id. When testing
the same CPU (i.e. this_cpu == that_cpu), a race condition exists with
update_top_cache_domain(). One scenario being:

              CPU1                            CPU2
  ==================================================================

  per_cpu(sd_llc_id, CPUX) => 0
                                    partition_sched_domains_locked()
      				      detach_destroy_domains()
  cpus_share_cache(CPUX, CPUX)          update_top_cache_domain(CPUX)
    per_cpu(sd_llc_id, CPUX) => 0
                                          per_cpu(sd_llc_id, CPUX) = CPUX
    per_cpu(sd_llc_id, CPUX) => CPUX
    return false

ttwu_queue_cond() wouldn't catch smp_processor_id() == cpu and the result
is a warning triggered from ttwu_queue_wakelist().

Avoid a such race in cpus_share_cache() by always returning true when
this_cpu == that_cpu.

Fixes: 518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")
Reported-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20211104175120.857087-1-vincent.donnefort@arm.com
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 523fd60..cec173a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3726,6 +3726,9 @@ out:
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
+	if (this_cpu == that_cpu)
+		return true;
+
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
