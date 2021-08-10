Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6833E5AA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhHJNFB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 09:05:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbhHJNFA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 09:05:00 -0400
Date:   Tue, 10 Aug 2021 13:04:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAk8JT1Dj/n5R2+LJOi0BRioV6mLfadsh4iGwOjM0gw=;
        b=PY79sx5J8knSVE8kD2mcNX2BFdnClrcFz/bJ6NsJ7tP0QChN8iX/nG8zFtDyudOxXhapME
        ZqcfJhHA91VeLR9liuDB0TAnFM728ybyKQiDzEZIfsObRqtkA5e/MK2TsyABKUfh9Ywvx5
        7PVfzuxg2XExOeuenbtyAETsmPx17HAgYIaqlO2K3F3uFWyaEUhXcpxoAU5n1NNbYZUFGM
        a/1M0ESL96kEz9mLpuWDHXtayMrTglmqcs9LcB3uLjUpp++ZeDcRpm/IIzxnRBcQRyrXSd
        IwcLbH24COoivNkcZiBKSMkf5b2JIWs9pQc3uC7MTOA0a3OgvJ6hvwSu392BpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAk8JT1Dj/n5R2+LJOi0BRioV6mLfadsh4iGwOjM0gw=;
        b=2DfmcmuJnvWe4xUpTL3uuegUT4Rf6hZRvCyWBRff0HoOYhG+CTPi8byTGGDC4bpC4J+Svv
        lZHcKdSd7aO35LAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-11-bigeasy@linutronix.de>
References: <20210803141621.780504-11-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860067530.395.3453742829000031569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4db0d3d3eeb8e15fce529480e4e99a3776f69604
Gitweb:        https://git.kernel.org/tip/4db0d3d3eeb8e15fce529480e4e99a3776f69604
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 15:00:26 +02:00

perf/x86/intel: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-11-bigeasy@linutronix.de

---
 arch/x86/events/intel/core.c | 8 ++++----
 arch/x86/events/intel/pt.c   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e355db5..aa15145 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5026,9 +5026,9 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
 
 	x86_pmu.attr_freeze_on_smi = val;
 
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(flip_smm_bit, &val, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 done:
 	mutex_unlock(&freeze_on_smi_mutex);
 
@@ -5071,9 +5071,9 @@ static ssize_t set_sysctl_tfa(struct device *cdev,
 
 	allow_tsx_force_abort = val;
 
-	get_online_cpus();
+	cpus_read_lock();
 	on_each_cpu(update_tfa_sched, NULL, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return count;
 }
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9158476..0369a23 100644
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
