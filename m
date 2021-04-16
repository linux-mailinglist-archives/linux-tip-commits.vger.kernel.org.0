Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F7362494
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhDPPyT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhDPPyK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:10 -0400
Date:   Fri, 16 Apr 2021 15:53:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qE2yJxzonP8C3SKSYcvuIhy8zvJ6gGv7M6CIrXOX8M=;
        b=Q75a8yZl/VC20snywhYzn914oswykE18phOuGiAn0/HyMovtSG24Darmf9rEBBds4XuEs8
        01395IK1TMqq4qtcsZ0CbPkVO/ZZpsad+QOjFg0SBw0RZ0Tc9zNyryZ6o5Kt47bSbRBBqM
        IKoM3rvy7YMBzGOXmtG+n0XG5k+lz83mQ5noiJEl0cC2keeDYQuxR7vXug4nOCbsYw6hYP
        231pG5PrlF8d9c09PGcM3MhMMuiQBliiSrbVUX/0OzjdYUNw6yWAVCboTyidYExiO85t3H
        Q+A4UPhdt2tw9doFruvalBR0JK0P3BBbeAJru5XD8joJRLSCW3KIc4Tq6lPTXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qE2yJxzonP8C3SKSYcvuIhy8zvJ6gGv7M6CIrXOX8M=;
        b=GujCNFZu47yyAfLi0n0B7crlSlgxGQMrb3lyJeN3waCs7K7BUpoP9UGXco1DANn9XfMk+L
        oOEuY8s27kVoQoCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpumask: Introduce DYING mask
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210310150109.151441252@infradead.org>
References: <20210310150109.151441252@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842478.29796.12244189943849858201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e40f74c535b8a0ecf3ef0388b51a34cdadb34fb5
Gitweb:        https://git.kernel.org/tip/e40f74c535b8a0ecf3ef0388b51a34cdadb34fb5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 19 Jan 2021 18:43:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:32 +02:00

cpumask: Introduce DYING mask

Introduce a cpumask that indicates (for each CPU) what direction the
CPU hotplug is currently going. Notably, it tracks rollbacks. Eg. when
an up fails and we do a roll-back down, it will accurately reflect the
direction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210310150109.151441252@infradead.org
---
 include/linux/cpumask.h | 20 ++++++++++++++++++++
 kernel/cpu.c            |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index a584336..e6b948a 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -91,10 +91,12 @@ extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
+extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
+#define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -826,6 +828,14 @@ set_cpu_active(unsigned int cpu, bool active)
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
+static inline void
+set_cpu_dying(unsigned int cpu, bool dying)
+{
+	if (dying)
+		cpumask_set_cpu(cpu, &__cpu_dying_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
+}
 
 /**
  * to_cpumask - convert an NR_CPUS bitmap to a struct cpumask *
@@ -900,6 +910,11 @@ static inline bool cpu_active(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
+static inline bool cpu_dying(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_dying_mask);
+}
+
 #else
 
 #define num_online_cpus()	1U
@@ -927,6 +942,11 @@ static inline bool cpu_active(unsigned int cpu)
 	return cpu == 0;
 }
 
+static inline bool cpu_dying(unsigned int cpu)
+{
+	return false;
+}
+
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 23505d6..838dcf2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	int (*cb)(unsigned int cpu);
 	int ret, cnt;
 
+	if (cpu_dying(cpu) != !bringup)
+		set_cpu_dying(cpu, !bringup);
+
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
 		return -EAGAIN;
@@ -2512,6 +2515,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
 
+struct cpumask __cpu_dying_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_dying_mask);
+
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
