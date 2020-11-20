Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC82BAA44
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgKTMeI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgKTMeH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57948C0613CF;
        Fri, 20 Nov 2020 04:34:07 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEQB2yYIetkNpJHx0zV5WYBK8QVLELfyCw0+yt/Rdzk=;
        b=qTPPYQW+mg4Z5Oqf6BlwluOP0aJy249XB0MUYGwe7C0UEgMuZ1t/HrkJ2yxXYFFDGxFK8Z
        uiWMLUjq/TdM6eBWx5Fi/FOmkF+TGJMn0yH+vyR51uW+zX/YwhJaxpbYK1U59AsslkGWut
        fTJZYLww4e02X1vYv73PUnZkGszjJUlIZ05HwUMxuuGosE/MYVm8t1GJrLaDYmlThloZyI
        PxYpdfO7k91+rQGtBOQRfoPVx245G6mBDR0+sBTpRDXntT/1h77flSu9kR1ENvl/dR8pHC
        0St3Q4ovVOSa0ITZ9EMdzKNlBhdHPlQJqcg5v3ZbhKDkM3UmgiYaNRuzpbCvfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEQB2yYIetkNpJHx0zV5WYBK8QVLELfyCw0+yt/Rdzk=;
        b=HpJQOf9XJ6wBNbHzGgD31qLAE8IL+EqOCAzkSo9Dfj2EJ6n7tTe6VcaRWpNluavUycjYWb
        EDqs/DuXxyam2YBg==
From:   "tip-bot2 for Ionela Voinescu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64: Rebuild sched domains on invariance status changes
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027180713.7642-3-ionela.voinescu@arm.com>
References: <20201027180713.7642-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Message-ID: <160587564498.11244.17662958657423680290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ecec9e86d1a366f97c827ab4a8134ec06ccf031a
Gitweb:        https://git.kernel.org/tip/ecec9e86d1a366f97c827ab4a8134ec06ccf031a
Author:        Ionela Voinescu <ionela.voinescu@arm.com>
AuthorDate:    Tue, 27 Oct 2020 18:07:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:47 +01:00

arm64: Rebuild sched domains on invariance status changes

Task scheduler behavior depends on frequency invariance (FI) support and
the resulting invariant load tracking signals. For example, in order to
make accurate predictions across CPUs for all performance states, Energy
Aware Scheduling (EAS) needs frequency-invariant load tracking signals
and therefore it has a direct dependency on FI. This dependency is known,
but EAS enablement is not yet conditioned on the presence of FI during
the built of the scheduling domain hierarchy.

Before this is done, the following must be considered: while
arch_scale_freq_invariant() will see changes in FI support and could
be used to condition the use of EAS, it could return different values
during system initialisation.

For arm64, such a scenario will happen for a system that does not support
cpufreq driven FI, but does support counter-driven FI. For such a system,
arch_scale_freq_invariant() will return false if called before counter
based FI initialisation, but change its status to true after it.
If EAS becomes explicitly dependent on FI this would affect the task
scheduler behavior which builds its scheduling domain hierarchy well
before the late counter-based FI init. During that process, EAS would be
disabled due to its dependency on FI.

Two points of future early calls to arch_scale_freq_invariant() which
would determine EAS enablement are:
 - (1) drivers/base/arch_topology.c:126 <<update_topology_flags_workfn>>
		rebuild_sched_domains();
       This will happen after CPU capacity initialisation.
 - (2) kernel/sched/cpufreq_schedutil.c:917 <<rebuild_sd_workfn>>
		rebuild_sched_domains_energy();
		-->rebuild_sched_domains();
       This will happen during sched_cpufreq_governor_change() for the
       schedutil cpufreq governor.

Therefore, before enforcing the presence of FI support for the use of EAS,
ensure the following: if there is a change in FI support status after
counter init, use the existing rebuild_sched_domains_energy() function to
trigger a rebuild of the scheduling and performance domains that in turn
will determine the enablement of EAS.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lkml.kernel.org/r/20201027180713.7642-3-ionela.voinescu@arm.com
---
 arch/arm64/kernel/topology.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 543c67c..2a9b69f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
+	bool invariance_status = topology_scale_freq_invariant();
 	cpumask_var_t valid_cpus;
 	bool have_policy = false;
 	int ret = 0;
@@ -255,6 +256,15 @@ static int __init init_amu_fie(void)
 	if (!topology_scale_freq_invariant())
 		static_branch_disable(&amu_fie_key);
 
+	/*
+	 * Task scheduler behavior depends on frequency invariance support,
+	 * either cpufreq or counter driven. If the support status changes as
+	 * a result of counter initialisation and use, retrigger the build of
+	 * scheduling domains to ensure the information is propagated properly.
+	 */
+	if (invariance_status != topology_scale_freq_invariant())
+		rebuild_sched_domains_energy();
+
 free_valid_mask:
 	free_cpumask_var(valid_cpus);
 
