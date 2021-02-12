Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB0319EBE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhBLMkm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhBLMjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:09 -0500
Date:   Fri, 12 Feb 2021 12:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f758U79n0Y6REHNqugq/bCkC1DCQCkRrhCpnMEl9lII=;
        b=v3+hr/Mrnzvhx5CEzE5kLbw9KzYvBc1N79rSmLRaRUbLa+WA8oalVKJq5/q0Qvr3waocRW
        vHIGlbUrjuYQsap/drMTN2Uw4RCn0GCUZh2uOSR1NdTEOoykMd6Bht9V/ixczCLHL8CcfU
        m6TzLzxMaFSBvmc969xX8RVatgJ0S05QaN1lFY4eoZYGivF7oxmAyCzZoppy/nEQv9ru+p
        zPBDIbMKUWihl9BjtSdp44v2tDKhcFVDv4jk21vM1QpZ8na6xbZlK2m5ar+SiJWlzntKV3
        JmGDbSlGnoiEEcdLMUVMLUqBrI1Wk7Q51evhCBo+uhH/+rRQqLzwgCxgOYaLBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f758U79n0Y6REHNqugq/bCkC1DCQCkRrhCpnMEl9lII=;
        b=MeuvQO9QZj6mh0UPcqAgxCRVt63ugyQA5hrKeiDnw+aTMYw2J/kmp0I5+oR1hAwof6Jqdb
        P1lzeDtxknrBjpBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] cpu/hotplug: Add lockdep_is_cpus_held()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343738.23325.16454385458122834611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     43759fe5a137389e94ed6d4680c3c63c17273158
Gitweb:        https://git.kernel.org/tip/43759fe5a137389e94ed6d4680c3c63c17273158
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 11 Nov 2020 23:53:13 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

cpu/hotplug: Add lockdep_is_cpus_held()

This commit adds a lockdep_is_cpus_held() function to verify that the
proper locks are held and that various operations are running in the
correct context.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aa..3aaa068 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -111,6 +111,8 @@ static inline void cpu_maps_update_done(void)
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
+extern int lockdep_is_cpus_held(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpus_write_lock(void);
 extern void cpus_write_unlock(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91..1b6302e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,6 +330,13 @@ void lockdep_assert_cpus_held(void)
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_is_cpus_held(void)
+{
+	return percpu_rwsem_is_held(&cpu_hotplug_lock);
+}
+#endif
+
 static void lockdep_acquire_cpus_lock(void)
 {
 	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
