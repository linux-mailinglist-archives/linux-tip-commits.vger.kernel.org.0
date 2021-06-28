Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C93B5F77
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhF1OAc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhF1OAc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 10:00:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76CC061574;
        Mon, 28 Jun 2021 06:58:06 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624888683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyZ+Vinq0Y+cqJkD6Gxupj7bGITGax9nPqCUz96nryE=;
        b=ovjvx0c2QydRLY17LyXkiztHLQxUxeYoqH94BSngXyVjsDE3K5XaODNnDvH6D2TWAbh6Z4
        NDTJ5t+uKupXCazNBXpkAkliHPMfopbpgR5vuFivfQd5jB8pAvuGOVo6PskvEh0zV/JQ84
        ix6UpA5vhFgIgl1UCZsr5QdgL3LMxBWxbWUDRih8xbYnsV/HHdusPUYYblwe3bzMGvFviM
        mGeJ9HRn/KeE6tkXlHp5KVk1yXxG5iFH4nfQQZyUaW3tlRlQVFlB0eASpKGtJ8QX4b1pcG
        w0I2kmYOjN235TFIn4ZUGJAfrnLJ3p9AaGnuiSKo/zjnOXI3mLB58Bo2W0Jchw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624888683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyZ+Vinq0Y+cqJkD6Gxupj7bGITGax9nPqCUz96nryE=;
        b=Z5a100+0oGiuH8A8bI6ewKuXik0Yey+O7em4H3RIX1cmisf5Fx1UeXjdJiuFUpHIz0gPjH
        0r7RYmcFhQUjGNDg==
From:   "tip-bot2 for Yuan ZhaoXiong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Optimize housekeeping_cpumask() in
 for_each_cpu_and()
Cc:     Li RongQing <lirongqing@baidu.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1622985115-51007-1-git-send-email-yuanzhaoxiong@baidu.com>
References: <1622985115-51007-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Message-ID: <162488868286.395.10942600934422360377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     031e3bd8986fffe31e1ddbf5264cccfe30c9abd7
Gitweb:        https://git.kernel.org/tip/031e3bd8986fffe31e1ddbf5264cccfe30c9abd7
Author:        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
AuthorDate:    Sun, 06 Jun 2021 21:11:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 28 Jun 2021 15:42:26 +02:00

sched: Optimize housekeeping_cpumask() in for_each_cpu_and()

On a 128 cores AMD machine, there are 8 cores in nohz_full mode, and
the others are used for housekeeping. When many housekeeping cpus are
in idle state, we can observe huge time burn in the loop for searching
nearest busy housekeeper cpu by ftrace.

   9)               |              get_nohz_timer_target() {
   9)               |                housekeeping_test_cpu() {
   9)   0.390 us    |                  housekeeping_get_mask.part.1();
   9)   0.561 us    |                }
   9)   0.090 us    |                __rcu_read_lock();
   9)   0.090 us    |                housekeeping_cpumask();
   9)   0.521 us    |                housekeeping_cpumask();
   9)   0.140 us    |                housekeeping_cpumask();

   ...

   9)   0.500 us    |                housekeeping_cpumask();
   9)               |                housekeeping_any_cpu() {
   9)   0.090 us    |                  housekeeping_get_mask.part.1();
   9)   0.100 us    |                  sched_numa_find_closest();
   9)   0.491 us    |                }
   9)   0.100 us    |                __rcu_read_unlock();
   9) + 76.163 us   |              }

for_each_cpu_and() is a micro function, so in get_nohz_timer_target()
function the
        for_each_cpu_and(i, sched_domain_span(sd),
                housekeeping_cpumask(HK_FLAG_TIMER))
equals to below:
        for (i = -1; i = cpumask_next_and(i, sched_domain_span(sd),
                housekeeping_cpumask(HK_FLAG_TIMER)), i < nr_cpu_ids;)
That will cause that housekeeping_cpumask() will be invoked many times.
The housekeeping_cpumask() function returns a const value, so it is
unnecessary to invoke it every time. This patch can minimize the worst
searching time from ~76us to ~16us in my testing.

Similarly, the find_new_ilb() function has the same problem.

Co-developed-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1622985115-51007-1-git-send-email-yuanzhaoxiong@baidu.com
---
 kernel/sched/core.c | 6 ++++--
 kernel/sched/fair.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2883c22..0c22cd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -993,6 +993,7 @@ int get_nohz_timer_target(void)
 {
 	int i, cpu = smp_processor_id(), default_cpu = -1;
 	struct sched_domain *sd;
+	const struct cpumask *hk_mask;
 
 	if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
 		if (!idle_cpu(cpu))
@@ -1000,10 +1001,11 @@ int get_nohz_timer_target(void)
 		default_cpu = cpu;
 	}
 
+	hk_mask = housekeeping_cpumask(HK_FLAG_TIMER);
+
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		for_each_cpu_and(i, sched_domain_span(sd),
-			housekeeping_cpumask(HK_FLAG_TIMER)) {
+		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
 			if (cpu == i)
 				continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45edf61..11d2294 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10188,9 +10188,11 @@ static inline int on_null_domain(struct rq *rq)
 static inline int find_new_ilb(void)
 {
 	int ilb;
+	const struct cpumask *hk_mask;
 
-	for_each_cpu_and(ilb, nohz.idle_cpus_mask,
-			      housekeeping_cpumask(HK_FLAG_MISC)) {
+	hk_mask = housekeeping_cpumask(HK_FLAG_MISC);
+
+	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
 
 		if (ilb == smp_processor_id())
 			continue;
