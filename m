Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287E03E91E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 14:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhHKMtu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 08:49:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51458 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHKMtu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 08:49:50 -0400
Date:   Wed, 11 Aug 2021 12:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628686165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSrQi4eHTQBR778n48HJO33wnpYz7CxOJ1UTkNPhxgE=;
        b=A9ZjINUWiiqhBu++cSjiNsWMaOUMQH1lukTdAWMT9azrBl8ye1XHWct6Gn338PoKdYIP0O
        UJ5dSD4Np0z6jnrDICIBKbhYK/J0W+/sSZO27ebQczF12BRJIXC8XoNgNHurEMJjEBu6A+
        sLT5YdLMsQrNw6qIwoV8beZhZLK7+Tjd4kSr785UAzltPnKo8tPLyLs+TnwBILU+WAX8+G
        f+MytOND6QQXpKQB1hwPr6r8nPhlZwBmuURy5vIJCJ0+eq+bz3Y84Aco34B/2NeJ1sYGEk
        SAWo4FhZH+jKL6zFrQnb74duq/uKX0VyrpGjcKXJNNKWoXyLbDqUVk61xPL0AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628686165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSrQi4eHTQBR778n48HJO33wnpYz7CxOJ1UTkNPhxgE=;
        b=TMKPiBdX0fcWa1kemy8FouFEFjbrhkUr8ebGh620nH+kcq7Tq+F9/aC4G5s5XmHSHo7KE6
        s6EbEQuJkEFOVCDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Fix all kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210810225051.3938-1-rdunlap@infradead.org>
References: <20210810225051.3938-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162868616504.395.7373173792024751135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     49b3bd213a9f3d685784913c255c6a2cb3d1fcce
Gitweb:        https://git.kernel.org/tip/49b3bd213a9f3d685784913c255c6a2cb3d1fcce
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 10 Aug 2021 15:50:51 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Aug 2021 14:47:16 +02:00

smp: Fix all kernel-doc warnings

Fix the following warnings:

kernel/smp.c:1189: warning: cannot understand function prototype: 'struct smp_call_on_cpu_struct '
kernel/smp.c:788: warning: No description found for return value of 'smp_call_function_single_async'
kernel/smp.c:990: warning: Function parameter or member 'wait' not described in 'smp_call_function_many'
kernel/smp.c:990: warning: Excess function parameter 'flags' description in 'smp_call_function_many'
kernel/smp.c:1198: warning: Function parameter or member 'work' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'done' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'func' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'data' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'ret' not described in 'smp_call_on_cpu_struct'
kernel/smp.c:1198: warning: Function parameter or member 'cpu' not described in 'smp_call_on_cpu_struct'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210810225051.3938-1-rdunlap@infradead.org

---
 kernel/smp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 52bf159..f43ede0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -764,7 +764,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 EXPORT_SYMBOL(smp_call_function_single);
 
 /**
- * smp_call_function_single_async(): Run an asynchronous function on a
+ * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.
  * @cpu: The CPU to run on.
  * @csd: Pre-allocated and setup data structure
@@ -783,6 +783,8 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
+ *
+ * Return: %0 on success or negative errno value on error
  */
 int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
@@ -974,7 +976,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
  *        (atomically) until function has completed on other CPUs. If
  *        %SCF_RUN_LOCAL is set, the function will also be run locally
  *        if the local CPU is set in the @cpumask.
@@ -1180,7 +1182,13 @@ void wake_up_all_idle_cpus(void)
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
 /**
- * smp_call_on_cpu - Call a function on a specific cpu
+ * struct smp_call_on_cpu_struct - Call a function on a specific CPU
+ * @work: &work_struct
+ * @done: &completion to signal
+ * @func: function to call
+ * @data: function's data argument
+ * @ret: return value from @func
+ * @cpu: target CPU (%-1 for any CPU)
  *
  * Used to call a function on a specific cpu and wait for it to return.
  * Optionally make sure the call is done on a specified physical cpu via vcpu
