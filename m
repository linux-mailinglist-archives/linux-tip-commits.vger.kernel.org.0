Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3903E5A89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhHJM6a (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:58:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhHJM63 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:58:29 -0400
Date:   Tue, 10 Aug 2021 12:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IHdTih3UvPgqzcgKF8mDheJ/3CfnNs3H+PU8niFfV4=;
        b=dD11aroumibX8f+QMsutE4CkqD5YMHRvMxr3yGn0cAsF3kMliZB52eglDBu9a2jzjqs9eK
        OrBiEhXqc81I0xNLdFg5i6vNLQKdGhApFo87OfoGLgNrp587uN/am0yR1uxD3xNxCigMc0
        wwRyzG+5gVvmjObTjvSG3QAQKVX/XgG6gvF7AVNBAumPoa+gXBOnZl2XrJN6XxYwPTVU2/
        SZAMs7OlflEaRIcMAvWEOt62VVULs+zmMl/vW3jpwRPMEM8a3n01uEJcIMRqSDi8PicHDQ
        5ZuV//6AiUQglS+Hf5xYqSQK1aRga3rVjZAJ+99L2QDioDUdfCGjbMOVpECOLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600285;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IHdTih3UvPgqzcgKF8mDheJ/3CfnNs3H+PU8niFfV4=;
        b=sVsdZ3OHfurphrm2qlpTJyvA/GE6gQ72c/PC825qnUEOtWLTX2XezyVNgIYkXGTVSTa1IP
        HVGCGBzvKjdjgfAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210803141621.780504-26-bigeasy@linutronix.de>
References: <20210803141621.780504-26-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860028441.395.2862243717696898128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     428e211641ed808b55cdc7d880a0ee349eff354b
Gitweb:        https://git.kernel.org/tip/428e211641ed808b55cdc7d880a0ee349eff354b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:51:26 +02:00

genirq/affinity: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-26-bigeasy@linutronix.de

---
 kernel/irq/affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4..f7ff891 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -355,7 +355,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 		goto fail_npresmsk;
 
 	/* Stabilize the cpumasks */
-	get_online_cpus();
+	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
@@ -384,7 +384,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 		nr_others = ret;
 
  fail_build_affinity:
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
@@ -505,9 +505,9 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
 	} else {
-		get_online_cpus();
+		cpus_read_lock();
 		set_vecs = cpumask_weight(cpu_possible_mask);
-		put_online_cpus();
+		cpus_read_unlock();
 	}
 
 	return resv + min(set_vecs, maxvec - resv);
