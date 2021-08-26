Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64B23F8388
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhHZIKo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhHZIKm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:42 -0400
Date:   Thu, 26 Aug 2021 08:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xW22BvzKXSIcTkkwxxIqSs/O1b+k3n3aAajqyRG6qQ=;
        b=KyTZhNugltlpqzA/dJQFifrSAwkfC17Wzvh/gDbFEpT9lfr7NWkm8oTbiRv/sPWdQ1yR/9
        kqptpfj7dExtiBLQto0MPipW9O1EBTEaRw2DbaBeETdC/o+SlcmcYUKcRHyVuIN0VQ0ftR
        sj4TF1aZkcQQiNT5e7xnWBK8R2yww+0tnfg7+2UUy6pWwgFlM7kRVwoA6Jz2XCVvJOgrPY
        Zzu7W77ZXyI+6QvuPyV41gD1GjxpeI2on66Q1WlUrlvoYmh6gptRglrnmOH0KPbzq2Pgwt
        SFI1OvWD/ZBamdk1e6V2IU+dX2jPxkeFsVPOj7bHn2DfrESk8aqUk1S1cRvEeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xW22BvzKXSIcTkkwxxIqSs/O1b+k3n3aAajqyRG6qQ=;
        b=6d2f70QXcYp3j+8ER7fgQZlx9gLGNTlrtQfEZKBt0KMV/RSxdxdcDQvHpCi8FDRMcKUCK5
        Cxn1yi6FkWz1IUDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Replace deprecated CPU-hotplug functions
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-11-bigeasy@linutronix.de>
References: <20210803141621.780504-11-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162996539374.25758.14860453072920511618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eda8a2c599d1ff874a63de7684b430740e747dea
Gitweb:        https://git.kernel.org/tip/eda8a2c599d1ff874a63de7684b430740e747dea
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/x86/intel: Replace deprecated CPU-hotplug functions

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210803141621.780504-11-bigeasy@linutronix.de
---
 arch/x86/events/intel/core.c | 8 ++++----
 arch/x86/events/intel/pt.c   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac6fd2d..7011e87 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5032,9 +5032,9 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
 
 	x86_pmu.attr_freeze_on_smi = val;
 
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(flip_smm_bit, &val, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 done:
 	mutex_unlock(&freeze_on_smi_mutex);
 
@@ -5077,9 +5077,9 @@ static ssize_t set_sysctl_tfa(struct device *cdev,
 
 	allow_tsx_force_abort = val;
 
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(update_tfa_sched, NULL, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return count;
 }
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b044577..7f406c1 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1708,7 +1708,7 @@ static __init int pt_init(void)
 	if (!boot_cpu_has(X86_FEATURE_INTEL_PT))
 		return -ENODEV;
 
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		u64 ctl;
 
@@ -1716,7 +1716,7 @@ static __init int pt_init(void)
 		if (!ret && (ctl & RTIT_CTL_TRACEEN))
 			prior_warn++;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (prior_warn) {
 		x86_add_exclusive(x86_lbr_exclusive_pt);
