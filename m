Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466963FD5BC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Sep 2021 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhIAIiX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Sep 2021 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbhIAIiW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Sep 2021 04:38:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF6C061575;
        Wed,  1 Sep 2021 01:37:25 -0700 (PDT)
Date:   Wed, 01 Sep 2021 08:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630485444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZDxDK9nRAs2KhLIgG+POPxwfXHm7rkShl/vFNhjo/4=;
        b=y1/WvtAgIK+jq0Qqa6DoPkJC5bix/ei8Qgil4jd+T7DWdu9DMqkKhKntKU8sJp/tPeb2J3
        vXXXtT9wbixR3fYQX3enwuaU3ZzGRwUW3bhtBEDq8a1t5nbfOeP3MJjVQCH6Lu6JSb7ba7
        fIugeImIlfl23bY7LqUEkw1ppRXrhWmaYSsyJThCYV8IWvXXHg5nmARKKRg1UWqY3+EZCe
        CO+opLgIyPknNiKIZoidhobDYMjswrzDozUGk2TpyTfez4SvkWaEOGKGHyvULqoU4Y6GBH
        b/7niXuCagOik6UlotXuogLxSrQj0kUkLzfLKHLtumu0LnFGbp1r2eTKNTG2uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630485444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZDxDK9nRAs2KhLIgG+POPxwfXHm7rkShl/vFNhjo/4=;
        b=lR9eCb1SHDwmLZ0dmoxl9uqDzReiqTW4+AHDmau6SIVTplIexhgxZIiAI5kTfiMSspD7HM
        Mx0xSqDAh5JnRFAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] drivers: base: cacheinfo: Get rid of
 DEFINE_SMP_CALL_CACHE_FUNCTION()
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <871r69ersb.ffs@tglx>
References: <871r69ersb.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163048544295.25758.14907139415224306667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     4b92d4add5f6dcf21275185c997d6ecb800054cd
Gitweb:        https://git.kernel.org/tip/4b92d4add5f6dcf21275185c997d6ecb800054cd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 31 Aug 2021 13:48:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Sep 2021 10:29:10 +02:00

drivers: base: cacheinfo: Get rid of DEFINE_SMP_CALL_CACHE_FUNCTION()

DEFINE_SMP_CALL_CACHE_FUNCTION() was usefel before the CPU hotplug rework
to ensure that the cache related functions are called on the upcoming CPU
because the notifier itself could run on any online CPU.

The hotplug state machine guarantees that the callbacks are invoked on the
upcoming CPU. So there is no need to have this SMP function call
obfuscation. That indirection was missed when the hotplug notifiers were
converted.

This also solves the problem of ARM64 init_cache_level() invoking ACPI
functions which take a semaphore in that context. That's invalid as SMP
function calls run with interrupts disabled. Running it just from the
callback in context of the CPU hotplug thread solves this.

Fixes: 8571890e1513 ("arm64: Add support for ACPI based firmware tables")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/871r69ersb.ffs@tglx
---
 arch/arm64/kernel/cacheinfo.c   |  7 ++-----
 arch/mips/kernel/cacheinfo.c    |  7 ++-----
 arch/riscv/kernel/cacheinfo.c   |  7 ++-----
 arch/x86/kernel/cpu/cacheinfo.c |  7 ++-----
 include/linux/cacheinfo.h       | 18 ------------------
 5 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 7fa6828..587543c 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,7 +43,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -78,7 +78,7 @@ static int __init_cache_level(unsigned int cpu)
 	return 0;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int level, idx;
 	enum cache_type type;
@@ -97,6 +97,3 @@ static int __populate_cache_leaves(unsigned int cpu)
 	}
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index 53d8ea7..495dd05 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -17,7 +17,7 @@ do {								\
 	leaf++;							\
 } while (0)
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -74,7 +74,7 @@ static void fill_cpumask_cluster(int cpu, cpumask_t *cpu_map)
 			cpumask_set_cpu(cpu1, cpu_map);
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -114,6 +114,3 @@ static int __populate_cache_leaves(unsigned int cpu)
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index d867813..90deabf 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -113,7 +113,7 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
 	}
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct device_node *np = of_cpu_device_node_get(cpu);
@@ -155,7 +155,7 @@ static int __init_cache_level(unsigned int cpu)
 	return 0;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
@@ -187,6 +187,3 @@ static int __populate_cache_leaves(unsigned int cpu)
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d66af29..b5e36bd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -985,7 +985,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->priv = base->nb;
 }
 
-static int __init_cache_level(unsigned int cpu)
+int init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
@@ -1014,7 +1014,7 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4_regs)
 	id4_regs->id = c->apicid >> index_msb;
 }
 
-static int __populate_cache_leaves(unsigned int cpu)
+int populate_cache_leaves(unsigned int cpu)
 {
 	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -1033,6 +1033,3 @@ static int __populate_cache_leaves(unsigned int cpu)
 
 	return 0;
 }
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 4f72b47..2f909ed 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -79,24 +79,6 @@ struct cpu_cacheinfo {
 	bool cpu_map_populated;
 };
 
-/*
- * Helpers to make sure "func" is executed on the cpu whose cache
- * attributes are being detected
- */
-#define DEFINE_SMP_CALL_CACHE_FUNCTION(func)			\
-static inline void _##func(void *ret)				\
-{								\
-	int cpu = smp_processor_id();				\
-	*(int *)ret = __##func(cpu);				\
-}								\
-								\
-int func(unsigned int cpu)					\
-{								\
-	int ret;						\
-	smp_call_function_single(cpu, _##func, &ret, true);	\
-	return ret;						\
-}
-
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
