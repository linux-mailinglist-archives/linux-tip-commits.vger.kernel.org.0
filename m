Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C53D8B3F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbhG1J6O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhG1J6N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A4C061764;
        Wed, 28 Jul 2021 02:58:12 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRT/lQKu2JlkJqOgynCQAChHgIv41T2kO+6q9tvSNCw=;
        b=sgagafx0MiJ5Qb9QYJZlAEycuPP7f1ORJoTkuDtF7qdwHV80k/ZXyn+vZS15CfKN2+gylg
        dKtLjBqpEYiqY0W5rcgnOYJFPDz2v5G4/5g7YEHQW6vYGwl3UgTHPQ3+gayBfT9HrfEtDd
        KTqsd2NkXR4/9igQh2ePeXcdfImAD9pnDJuRcvJbcqr1qLPdsHpVWUKn2PL4GY1uzp4RUd
        aMaJbmiS2GjDvSV08nbaypPfew7RHjkLw7r3Y4otiwQIGmLZZAqURmZMzCrEQ2fb1WBFHT
        eN6h0Zpc6GXjv4sJuTorTeNnvPsxBnxDRmj3Bn8SObbvWbFfXT3qAlJvSreoqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRT/lQKu2JlkJqOgynCQAChHgIv41T2kO+6q9tvSNCw=;
        b=JI1f0HwsXLxrKpv8ggUSgRsQpBoiv+vjGDg8N0hE1KLr4DwASlwDdowZrfxAOxyUXBBWOr
        E/Bn2NDDNhV3meAQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/smp: Add a per-cpu view of SMT state
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-2-sblbir@amazon.com>
References: <20210108121056.21940-2-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746629028.395.4183635884229640325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c52787b590634646d4da3d8f23c4532ba050d40d
Gitweb:        https://git.kernel.org/tip/c52787b590634646d4da3d8f23c4532ba050d40d
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Fri, 08 Jan 2021 23:10:52 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:23 +02:00

x86/smp: Add a per-cpu view of SMT state

A new field smt_active in cpuinfo_x86 identifies if the current core/cpu
is in SMT mode or not.

This is helpful when the system has some of its cores with threads offlined
and can be used for cases where action is taken based on the state of SMT.

The upcoming support for paranoid L1D flush will make use of this information.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-2-sblbir@amazon.com
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/smpboot.c        | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f3020c5..1e0d13c 100644
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
index 9320285..85f6e24 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -610,6 +610,9 @@ void set_cpu_sibling_map(int cpu)
 	if (threads > __max_smt_threads)
 		__max_smt_threads = threads;
 
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active = threads > 1;
+
 	/*
 	 * This needs a separate iteration over the cpus because we rely on all
 	 * topology_sibling_cpumask links to be set-up.
@@ -1552,8 +1555,13 @@ static void remove_siblinginfo(int cpu)
 
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
 	cpumask_clear(cpu_llc_shared_mask(cpu));
