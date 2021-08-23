Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5CA3F4796
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhHWJda (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhHWJd3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF6C061575;
        Mon, 23 Aug 2021 02:32:47 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:32:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xor3nwFC7JZ19QSYiQ/QaQuEJn/fC8QEj+V6rTuzq6c=;
        b=WK+NYWX5P4wmn5/LYlRfr4lU41laWm06UmuKboCsfAyonS3d7LJWlRJeSB2qslD03zcJoK
        JXkIuNJxDOYyr0k9UMaRy+JYPdIkZi7ApRvWMTZ55CejoUi8ILRCSvpXOF+CFBIZep2RXu
        VwyLuoSlo8UcXneKattXSMlKN+batxNYycafYL7A6JtkiCFQrk9LzmmhsHgePcEbE3M244
        p1f0t7S/jMnRg2jc0W/5lYj4wcBuG0HUbQTl+uWd23c6c3akJ/Isb6fVXcRx1NrnxzZ545
        RziqYE0j4oNH8D+Xe6APNAXkpQmde/eZNs6bWsPUUxZv6HTiQDVQl+HmlEjsSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xor3nwFC7JZ19QSYiQ/QaQuEJn/fC8QEj+V6rTuzq6c=;
        b=Y6Aflzf5Ns1eo7LKzanKneij8J5IVIJBo0y7RcokXQkgukXu6NBtVe/3U1li4iryS3dnSF
        a1rlVIK4AYx8AnCg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Add helper function get_llc_id
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-7-kim.phillips@amd.com>
References: <20210817221048.88063-7-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116488.25758.15038893049947052336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f644500512b6b3838091ddc2cfe61a4110e7778e
Gitweb:        https://git.kernel.org/tip/f644500512b6b3838091ddc2cfe61a4110e7778e
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:46 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:13 +02:00

x86/cpu: Add helper function get_llc_id

Factor out a helper function rather than export cpu_llc_id, which is
needed in order to be able to build the AMD uncore driver as a module.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 154321d..fa2f7ee 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -785,6 +785,8 @@ extern int set_tsc_mode(unsigned int val);
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
+extern u16 get_llc_id(unsigned int cpu);
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 #else
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2d11384..1d83024 100644
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
index a1b756c..684d4e1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -78,6 +78,12 @@ EXPORT_SYMBOL(smp_num_siblings);
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
