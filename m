Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143403F8383
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhHZIKk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbhHZIKj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072CFC061757;
        Thu, 26 Aug 2021 01:09:53 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:09:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUXg5UkkZspbOhje4VCcKlGvmvV0YctfMqoTXW4PbbI=;
        b=Z6ZZ+xuYksRHNzBxg59szMITk8DTEXAdx2ANZ2Gwp1hCSgOgq6HGUVjjVdQ/SzX5guC7ST
        QE99LVxL9KWep40zeeESfKCTWuNzUpHZkH5lfZlr7qAMSM7SbiPbZznO6PfRdhEJODJsIX
        Rpnk8s9i7y3GUiCBXM81RYxQQf2KRarJepg6egPBz30Kg9lmLh81T9TSUL4o1K4tPCcXK6
        XtxG7+JLmuhFWWtcNdxHfL3lbe67NI4ZfuxIIZ7FmIz5TcDI8opyWV1AvjH85iwhDGnzAW
        emyEY7JPILN4xFOIGonmOP7iS3uzYVmP0u8VcjtSTHSd2GIIY6ESg4YxIMjXKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUXg5UkkZspbOhje4VCcKlGvmvV0YctfMqoTXW4PbbI=;
        b=Z+xZpkXiTGk+6t9JmlnkRioyPVsG3rVrHOdPifIleot3jt+So2Bl8TZdw94XOaLCdVrN1d
        VB79B4Napu9JABCg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Add get_llc_id() helper function
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-7-kim.phillips@amd.com>
References: <20210817221048.88063-7-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996539079.25758.3108707295523610204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9164d9493a792682143af12b182be12d7c32b195
Gitweb:        https://git.kernel.org/tip/9164d9493a792682143af12b182be12d7c32b195
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

x86/cpu: Add get_llc_id() helper function

Factor out a helper function rather than export cpu_llc_id, which is
needed in order to be able to build the AMD uncore driver as a module.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-7-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c     | 2 +-
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/kernel/cpu/amd.c        | 2 +-
 arch/x86/kernel/cpu/common.c     | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7fb50ad..a01f9f1 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -452,7 +452,7 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 
 	if (amd_uncore_llc) {
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id = per_cpu(cpu_llc_id, cpu);
+		uncore->id = get_llc_id(cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f3020c5..33dd157 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -795,6 +795,8 @@ extern int set_tsc_mode(unsigned int val);
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
+extern u16 get_llc_id(unsigned int cpu);
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b7c0030..2131af9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -438,7 +438,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
-		node = per_cpu(cpu_llc_id, cpu);
+		node = get_llc_id(cpu);
 
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 64b805b..0f88859 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -79,6 +79,12 @@ EXPORT_SYMBOL(smp_num_siblings);
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+u16 get_llc_id(unsigned int cpu)
+{
+	return per_cpu(cpu_llc_id, cpu);
+}
+EXPORT_SYMBOL_GPL(get_llc_id);
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
