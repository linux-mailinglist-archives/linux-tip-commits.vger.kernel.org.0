Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B33B83B7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhF3Nuo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhF3NuL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:11 -0400
Date:   Wed, 30 Jun 2021 13:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0F09f8zVy8mFr8xczPxcd5oHQp8ME7L5DOD4l4g60B8=;
        b=J9PkjXKMhfuvho5QPcTButuBuSNkepBQ3exszkFAgUXHfpvdwH7cWHqmsCWAMLmATOmP6m
        s52nZvaVgnU1AFtGAuMiu1S5+7T72rh0Kz1ffZdwZrrvLqDEvY8BT2U7/PDeZmYor1Yvl0
        ZY3bO1LXiAxhojOURpk9HftI7gcJX8E0TPtPN3W46VwIZLHLSBRvM8GUjSNbrL10Yce3n0
        tyai+D3qzNtypHj7w0Znc3IpzXSlnasmbOhHolF/MmAT3LZqH9VbJvFM8uAluhJhkgLv8f
        BX7yGyuw4Zq1WhIvLMJYfbQY6Dox1XJwFcbiq6p942eTvYaHTu7tBIM8mIiymg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0F09f8zVy8mFr8xczPxcd5oHQp8ME7L5DOD4l4g60B8=;
        b=fybSfkS25v8dfvj/1Nu4oZCISc8qpPTQoClo+oBp/WcEIAJhLjpSxgc4kiUjm1HdNf369P
        FS72+7OllrEoHuCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add BUSTED-BOOST to test RCU priority
 boosting tests
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086097.395.4670869275615598883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d4240d628f989efe32b3ad10a78d6921f8e28bd6
Gitweb:        https://git.kernel.org/tip/d4240d628f989efe32b3ad10a78d6921f8e28bd6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 11 Apr 2021 10:44:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

rcutorture: Add BUSTED-BOOST to test RCU priority boosting tests

This commit adds the BUSTED-BOOST rcutorture scenario, which can be
used to test rcutorture's ability to test RCU priority boosting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST      | 17 +++++++++++++++++
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |  8 ++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
new file mode 100644
index 0000000..22d598f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST
@@ -0,0 +1,17 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=y
+CONFIG_NO_HZ_IDLE=n
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_TRACE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_RCU_FANOUT=2
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
new file mode 100644
index 0000000..f57720c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -0,0 +1,8 @@
+rcutorture.test_boost=2
+rcutorture.stutter=0
+rcutree.gp_preinit_delay=12
+rcutree.gp_init_delay=3
+rcutree.gp_cleanup_delay=3
+rcutree.kthread_prio=2
+threadirqs
+tree.use_softirq=0
