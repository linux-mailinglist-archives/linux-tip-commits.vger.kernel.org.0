Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECAC2BAA45
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKTMeH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgKTMeH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8CC0613CF;
        Fri, 20 Nov 2020 04:34:06 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLNnhkKXkvgRELlemvB4Ol2twAR0wsZFEmevItNTlns=;
        b=lX9OTaN66GScwuI2xLacQFv965Wdtfh4NFeFpu95n3T51fwtXpoG6rTvERGsT6lSluO8sw
        R9i91nLmQD4VbdfUfHutKO7zVyzLAcO3Urwv4pz2uL3cmCH7/bSOF5w76afnYD7JJ1k6Ib
        2MvLnh8c3RX+ORR/8UdshU+iEeH4E+U6364Qq1iZS4llieL9ibOAW6s2xbR/29UFBw4M/K
        6TH2AhfuRQ2TeBA1pJpDQpLZmhtNY2QAYUmHqPrqSJsXnLGXjf2E4xAWEAth7eAbtzD3qP
        Dyvqkjvv4sJqcQmaiiCgGL1EeE8LOtg7eJaxs61HGENaVAFjf/nQWfvxjTbUdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLNnhkKXkvgRELlemvB4Ol2twAR0wsZFEmevItNTlns=;
        b=TcAg6hy6PIsrIBFZ4bthx3RNT4u4HESultd1AYJnr4asCXV9Mv4gaG2jTcbEasKX5McZIW
        /JKGtzFWFz9qm9Cg==
From:   "tip-bot2 for Ionela Voinescu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Condition EAS enablement on FIE support
Cc:     Quentin Perret <qperret@google.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201027180713.7642-4-ionela.voinescu@arm.com>
References: <20201027180713.7642-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Message-ID: <160587564437.11244.7301839109814236795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fa50e2b452c60cff9f4000de5b372a61d6695c26
Gitweb:        https://git.kernel.org/tip/fa50e2b452c60cff9f4000de5b372a61d6695c26
Author:        Ionela Voinescu <ionela.voinescu@arm.com>
AuthorDate:    Tue, 27 Oct 2020 18:07:13 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:47 +01:00

sched/topology: Condition EAS enablement on FIE support

In order to make accurate predictions across CPUs and for all performance
states, Energy Aware Scheduling (EAS) needs frequency-invariant load
tracking signals.

EAS task placement aims to minimize energy consumption, and does so in
part by limiting the search space to only CPUs with the highest spare
capacity (CPU capacity - CPU utilization) in their performance domain.
Those candidates are the placement choices that will keep frequency at
its lowest possible and therefore save the most energy.

But without frequency invariance, a CPU's utilization is relative to the
CPU's current performance level, and not relative to its maximum
performance level, which determines its capacity. As a result, it will
fail to correctly indicate any potential spare capacity obtained by an
increase in a CPU's performance level. Therefore, a non-invariant
utilization signal would render the EAS task placement logic invalid.

Now that we properly report support for the Frequency Invariance Engine
(FIE) through arch_scale_freq_invariant() for arm and arm64 systems,
while also ensuring a re-evaluation of the EAS use conditions for
possible invariance status change, we can assert this is the case when
initializing EAS. Warn and bail out otherwise.

Suggested-by: Quentin Perret <qperret@google.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201027180713.7642-4-ionela.voinescu@arm.com
---
 kernel/sched/topology.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 04d9ebf..5d3675c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -328,6 +328,7 @@ static void sched_energy_set(bool has_eas)
  *    3. no SMT is detected.
  *    4. the EM complexity is low enough to keep scheduling overheads low;
  *    5. schedutil is driving the frequency of all CPUs of the rd;
+ *    6. frequency invariance support is present;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -376,6 +377,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		goto free;
 	}
 
+	if (!arch_scale_freq_invariant()) {
+		if (sched_debug()) {
+			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
+				cpumask_pr_args(cpu_map));
+		}
+		goto free;
+	}
+
 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
