Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30E137F87C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhEMNSg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhEMNSb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1CC06174A;
        Thu, 13 May 2021 06:17:21 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTpbuzG+rPAw07ucY7V0DQfdDXZgFVUUGIHIN/4Kito=;
        b=JjlH7tJRnhb3WvMoTygypqHnT1UszgCOtGLliKI7dKD3kTu5QEHvYQiT5nD36V4M9gU9p8
        Xe6fgd339eF5ICT76PxcXLAnmyR5LYba7ZQzrkZtxAt5lYE6A904eeQfGdBSlb0nKi8oIp
        pNahS6n8y1gXZdWW9jXce59EGG1JcS8oFv7hpasqBh8TzqKoqi/FezOXbjMx8sxUlto63u
        VVThz0N2092+B0yOBxPMH9ezB3Bh/IsJn5l6yH2gScWwWkjeLXMyhX2bzxU5Pj35iTOFiM
        6tjeFvkoPqux/de0daBw7aQerqV1w/WpUatfmzRlwuAH4q1hilwepYs9qnqzTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTpbuzG+rPAw07ucY7V0DQfdDXZgFVUUGIHIN/4Kito=;
        b=5/TUpg37G1Gu1dP3PCF+G0TO/XREcbZ0oC6ibU5A+xjQPFuxRDukMaJzNuBmGNyd47XQan
        YEZ8/uJTH5+75zDQ==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/isolation: Reconcile rcu_nocbs= and nohz_full=
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
References: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <162091183827.29796.11397808016289850547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     915a2bc3c6b71e9802b89c5c981b2d5367e1ae3f
Gitweb:        https://git.kernel.org/tip/915a2bc3c6b71e9802b89c5c981b2d5367e1ae3f
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Mon, 19 Apr 2021 00:26:59 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:12:47 +02:00

sched/isolation: Reconcile rcu_nocbs= and nohz_full=

We have a mismatch between RCU and isolation -- in relation to what is
considered the maximum valid CPU number.

This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
fact the former will enforce the latter.  So we don't want a CPU mask to
be valid for one and denied for the other.

The difference 1st appeared as of v4.15; further details are below.

As it is confusing to anyone who isn't looking at the code regularly, a
reminder is in order; three values exist here:

  CONFIG_NR_CPUS  - compiled in maximum cap on number of CPUs supported.
  nr_cpu_ids      - possible # of CPUs (typically reflects what ACPI says)
  cpus_present    - actual number of present/detected/installed CPUs.

For this example, I'll refer to NR_CPUS=64 from "make defconfig" and
nr_cpu_ids=6 for ACPI reporting on a board that could run a six core,
and present=4 for a quad that is physically in the socket.  From dmesg:

 smpboot: Allowing 6 CPUs, 2 hotplug CPUs
 setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:6 nr_node_ids:1
 rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
 smp: Brought up 1 node, 4 CPUs

And from userspace, see:

   paul@trash:/sys/devices/system/cpu$ cat present
   0-3
   paul@trash:/sys/devices/system/cpu$ cat possible
   0-5
   paul@trash:/sys/devices/system/cpu$ cat kernel_max
   63

Everything is fine if we boot 5x5 for rcu/nohz:

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-5 rcu_nocbs=2-5 root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

..even though there is no CPU 4 or 5.  Both RCU and nohz_full are OK.
Now we push that > 6 but less than NR_CPU and with 15x15 we get:

  Command line: BOOT_IMAGE=/boot/bzImage rcu_nocbs=2-15 nohz_full=2-15 root=/dev/sda1 ro
  rcu: 	Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

These are both functionally equivalent, as we are only changing flags on
phantom CPUs that don't exist, but note the kernel interpretation changes.
And worse, it only changes for one of the two - which is the problem.

RCU doesn't care if you want to restrict the flags on phantom CPUs but
clearly nohz_full does after this change from v4.15.

 edb9382175c3: ("sched/isolation: Move isolcpus= handling to the housekeeping code")

 -       if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 -               pr_warn("Housekeeping: Incorrect nohz_full cpumask\n");
 +       err = cpulist_parse(str, non_housekeeping_mask);
 +       if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
 +               pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");

To be clear, the sanity check on "possible" (nr_cpu_ids) is new here.

The goal was reasonable ; not wanting housekeeping to land on a
not-possible CPU, but note two things:

  1) this is an exclusion list, not an inclusion list; we are tracking
     non_housekeeping CPUs; not ones who are explicitly assigned housekeeping

  2) we went one further in 9219565aa890 ("sched/isolation: Require a present CPU in housekeeping mask")
     - ensuring that housekeeping was sanity checking against present and not just possible CPUs.

To be clear, this means the check added in v4.15 is doubly redundant.
And more importantly, overly strict/restrictive.

We care now, because the bitmap boot arg parsing now knows that a value
of "N" is NR_CPUS; the size of the bitmap, but the bitmap code doesn't
know anything about the subtleties of our max/possible/present CPU
specifics as outlined above.

So drop the check added in v4.15 (edb9382175c3) and make RCU and
nohz_full both in alignment again on NR_CPUS so "N" works for both,
and then they can fall back to nr_cpu_ids internally just as before.

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-N rcu_nocbs=2-N root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

As shown above, with this change, RCU and nohz_full are in sync, even
with the use of the "N" placeholder.  Same result is achieved with "15".

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20210419042659.1134916-1-paul.gortmaker@windriver.com
---
 kernel/sched/isolation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5a6ea03..7f06eaf 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -81,11 +81,9 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
 	cpumask_var_t tmp;
-	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
-	err = cpulist_parse(str, non_housekeeping_mask);
-	if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
+	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		free_bootmem_cpumask_var(non_housekeeping_mask);
 		return 0;
