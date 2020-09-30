Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE51327F227
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgI3S7T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgI3S66 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5136C061755;
        Wed, 30 Sep 2020 11:58:57 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:58:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pb3V8MgO3/1t7uj3O29ZUItcV5OvsStfzJsKCdWzK3Y=;
        b=p9BLsQIydwu+C4EpQ4VqXdED+9QXkzvG6NGZ8yYKvxkLbgO7QJk0mv/IqzCrlbxwsqIEHz
        WbLoHbjI5A9nPTjfoWiM4sfbO/KxdeecvbXTiwP2qs5auY7jME8iXgOAWSIFUtbO50hgY9
        4uhyJF9dO7/0UqAqruYnD0aP5ntUMkFR2sZM82I7IeKQ6TTk2pnXoBkGyBDbv+Vx9lRLkP
        2QfhtOGKxizg7wB8PSAmXTI2EqPMCvW/Hswoj5s2O1CNqrsDuCKF0IjJT9Ncviz3vq0zWr
        XpfnSd1K3s5IN2p4WURBACAbI6gRdUi9vfLeQQ8o9STIfZswwYdi6Cxtz2ORrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pb3V8MgO3/1t7uj3O29ZUItcV5OvsStfzJsKCdWzK3Y=;
        b=PUqjBLv2u1Odqo5grCsr2ENxEvCCMq9/T760O2ABjv94g9QPS0nqzEtECYmGVdZCJFa+KZ
        LfZRWuh8vDJP6MBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Split the Ice Lake and Tiger
 Lake MSR uncore support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200925134905.8839-1-kan.liang@linux.intel.com>
References: <20200925134905.8839-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233571.7002.14146314086926850990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8abbcfefb5f7afabab4578bedd7cd400800cb039
Gitweb:        https://git.kernel.org/tip/8abbcfefb5f7afabab4578bedd7cd400800cb039
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 25 Sep 2020 06:49:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:00 +02:00

perf/x86/intel/uncore: Split the Ice Lake and Tiger Lake MSR uncore support

Previously, the MSR uncore for the Ice Lake and Tiger Lake are
identical. The code path is shared. However, with recent update, the
global MSR_UNC_PERF_GLOBAL_CTRL register and ARB uncore unit are changed
for the Ice Lake. Split the Ice Lake and Tiger Lake MSR uncore support.

The changes only impact the MSR ops() and the ARB uncore unit. Other
codes can still be shared between the Ice Lake and the Tiger Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200925134905.8839-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     |  4 ++--
 arch/x86/events/intel/uncore.h     |  1 +
 arch/x86/events/intel/uncore_snb.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index ce0a5ba..86d012b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1627,12 +1627,12 @@ static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
 };
 
 static const struct intel_uncore_init_fun tgl_uncore_init __initconst = {
-	.cpu_init = icl_uncore_cpu_init,
+	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_uncore_mmio_init,
 };
 
 static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
-	.cpu_init = icl_uncore_cpu_init,
+	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index df544bc..83d2a7d 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -568,6 +568,7 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
+void tgl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index cb94ba8..d2d43b6 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -377,6 +377,22 @@ void icl_uncore_cpu_init(void)
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
+static struct intel_uncore_type *tgl_msr_uncores[] = {
+	&icl_uncore_cbox,
+	&snb_uncore_arb,
+	&icl_uncore_clockbox,
+	NULL,
+};
+
+void tgl_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = tgl_msr_uncores;
+	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
+	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
+	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
