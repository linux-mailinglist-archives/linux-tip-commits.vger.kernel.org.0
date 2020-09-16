Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABF26CB6B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIPRYm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgIPRYQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5A1C0A893D;
        Wed, 16 Sep 2020 06:11:22 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:11:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600261881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCZCdgfiySQMPQy2FuYEb++B+EE+LdtjaayAFptCdTo=;
        b=QpnDuXoABD8SIvVGptrfj1ERBfhkU7zSoSmn/T3t6FhnLw6262nCAmhNkjEeRMTgfd8ibi
        ebovb8z1/uqtllCcBQ+xzbSMnp1RtOOqE0jJIHIRaSebAp3d9poHhR6xOD8FUoE1tjjttd
        UFq1KdpvqE3BqsXCF6HLqy00YNGL6Bk1mLavOk/bZR/xKgnu/O5ZW0kRt7TaeNTx7AXzy+
        5QQ0nf1MhooJ78vP5tc/4csIwRy7/L7aPymX2aImOn1Cv2QdKwYR0pyypsvqrNlUSL13Nu
        jg3A7fgJtEkfELiNcA39BGmgfeGqCfyW/YPSZtT9ZA6uWe0b8tpumsQP8FfijA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600261881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCZCdgfiySQMPQy2FuYEb++B+EE+LdtjaayAFptCdTo=;
        b=hcJG5H8j+jFUZWpRlGYTSoTTrzEw4dyYVDuSIvQU90V6j1TEXVtnPzIbkpC4unPnnq6rWw
        BJ2I1pyt5RiorzDA==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/smp: Add a per-cpu view of SMT state
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729001103.6450-2-sblbir@amazon.com>
References: <20200729001103.6450-2-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <160026188050.15536.7745071933237655912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     0a260b1c5867863121b044afa8087d6b37e4fb7d
Gitweb:        https://git.kernel.org/tip/0a260b1c5867863121b044afa8087d6b37e4fb7d
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Wed, 29 Jul 2020 10:10:59 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:08:02 +02:00

x86/smp: Add a per-cpu view of SMT state

A new field smt_active in cpuinfo_x86 identifies if the current core/cpu
is in SMT mode or not. This can be very helpful if the system has some
of its cores with threads offlined and can be used for cases where
action is taken based on the state of SMT. The follow up patches use
this feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200729001103.6450-2-sblbir@amazon.com

---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/smpboot.c        | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d8..d9eb20f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -136,6 +136,8 @@ struct cpuinfo_x86 {
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
+	/*  Is SMT active on this core? */
+	bool			smt_active;
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f5ef689..5fc7e0e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -635,6 +635,9 @@ void set_cpu_sibling_map(int cpu)
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
 	if (threads > __max_smt_threads)
 		__max_smt_threads = threads;
+
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active = threads > 1;
 }
 
 /* maps the cpu to the sched domain representing multi-core */
@@ -1548,10 +1551,16 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_die_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
-	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
+			cpu_data(sibling).smt_active = false;
+	}
+
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
