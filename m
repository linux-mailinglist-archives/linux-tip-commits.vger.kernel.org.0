Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359443958E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhEaKW6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaKW6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:22:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80193C061574;
        Mon, 31 May 2021 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B0MUtlUcmiTPTXwp18zRtpJbNe6aC+d1mnXiYiZ9kFM=; b=D5sNFoHf97YL1Cb9gJK6EQrgmS
        uZ+ZQLMphVDgpqQMxKm0DwaR/FKmQ/HPCWksQg+KTA6u4sffd5YqAicM/pM3v+RxGdIgbeQ3yJ3xQ
        mZpOMaCDtWJpRmlrGrk6r7ohd3ZaKCSnjg2zBsSLhMYoNy/MqsY8Gpxq1ImB+Twr939+DogePp3RN
        NLoRCjaa2/tamQa4Fd6Hj2dCP6e/jagiFvCaxaAgHQhiQUNfvgqoFQHnDUPiPgIgjZBIfU08kr4GO
        AmpopqcivhtFv7fSm5PKcVMnLETy6nlBFGqw8U4W3+eJ9FJ0FvewmB3lXXpcW3/sQ9ozHCzf6qKjW
        4GCzvejA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnf2h-002Flq-MY; Mon, 31 May 2021 10:21:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C4CA30019C;
        Mon, 31 May 2021 12:21:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 114D32029A1A5; Mon, 31 May 2021 12:21:13 +0200 (CEST)
Date:   Mon, 31 May 2021 12:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Yejune Deng <yejune.deng@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>, x86@kernel.org
Subject: [PATCH] sched,init: Fix DEBUG_PREEMPT vs early boot
Message-ID: <YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net>
References: <20210510151024.2448573-3-valentin.schneider@arm.com>
 <162141495460.29796.4438792168641232595.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162141495460.29796.4438792168641232595.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, May 19, 2021 at 09:02:34AM -0000, tip-bot2 for Yejune Deng wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     570a752b7a9bd03b50ad6420cd7f10092cc11bd3
> Gitweb:        https://git.kernel.org/tip/570a752b7a9bd03b50ad6420cd7f10092cc11bd3
> Author:        Yejune Deng <yejune.deng@gmail.com>
> AuthorDate:    Mon, 10 May 2021 16:10:24 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 19 May 2021 10:51:40 +02:00
> 
> lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed
> 
> is_percpu_thread() more elegantly handles SMP vs UP, and further checks the
> presence of PF_NO_SETAFFINITY. This lets us catch cases where
> check_preemption_disabled() can race with a concurrent sched_setaffinity().
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> [Amended changelog]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210510151024.2448573-3-valentin.schneider@arm.com
> ---
>  lib/smp_processor_id.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> index 1c1dbd3..046ac62 100644
> --- a/lib/smp_processor_id.c
> +++ b/lib/smp_processor_id.c
> @@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>  	if (irqs_disabled())
>  		goto out;
>  
> -	/*
> -	 * Kernel threads bound to a single CPU can safely use
> -	 * smp_processor_id():
> -	 */
> -	if (current->nr_cpus_allowed == 1)
> +	if (is_percpu_thread())
>  		goto out;

So my test box was unhappy with all this and started spewing lots of
DEBUG_PREEMPT warns on boot.

This extends 8fb12156b8db6 to cover the new requirement.

---
Subject: sched,init: Fix DEBUG_PREEMPT vs early boot

Extend 8fb12156b8db ("init: Pin init task to the boot CPU, initially")
to cover the new PF_NO_SETAFFINITY requirement.

While there, move wait_for_completion(&kthreadd_done) into kernel_init()
to make it absolutely clear it is the very first thing done by the init
thread.

Fixes: 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 init/main.c         | 11 ++++++-----
 kernel/sched/core.c |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index 7b027d9c5c89..e945ec82b8a5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -692,6 +692,7 @@ noinline void __ref rest_init(void)
 	 */
 	rcu_read_lock();
 	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
+	tsk->flags |= PF_NO_SETAFFINITY;
 	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
 	rcu_read_unlock();
 
@@ -1440,6 +1441,11 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	/*
+	 * Wait until kthreadd is all set-up.
+	 */
+	wait_for_completion(&kthreadd_done);
+
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
@@ -1520,11 +1526,6 @@ void __init console_on_rootfs(void)
 
 static noinline void __init kernel_init_freeable(void)
 {
-	/*
-	 * Wait until kthreadd is all set-up.
-	 */
-	wait_for_completion(&kthreadd_done);
-
 	/* Now the scheduler is fully set up and can do blocking allocations */
 	gfp_allowed_mask = __GFP_BITS_MASK;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index adea0b1e8036..ae7737e6c2b2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8867,6 +8867,7 @@ void __init sched_init_smp(void)
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
 		BUG();
+	current->flags &= ~PF_NO_SETAFFINITY;
 	sched_init_granularity();
 
 	init_sched_rt_class();
