Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A31835B4C8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhDKNoH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zQiEukILIRX0n7awa3eSW33+Ea9YZtfDSaK1A2Yki10=;
        b=vM+CwYrq+TjKMrAHurYqBdJopCGqXk+pViEEyqZc2ysZcOcgSVenqk1IpC7Qs5WNIT/u9m
        5kWVHCo7hnya0o62gVVB/S882e98oGrlIxrQSIhePRbOeSq+eAv+x/qQy1drqe+x96dXwO
        xI7/8/njFkBcJgYnOWfyyzWjxR8NeiBsrxFhpxALiKB4FMIk1H/gGImPpfxVzwgT8wbQo1
        dusmtmyw6wEFVQXi4/SFnmWMwyKL6TnIO3rJ0YsUaNKI8CI7w63G3wZ+pdJvWdGLyCQup2
        oEwtNoS0I7L5oR/iIs6tgztzfo51gmfZOdWzGOfEEbtM7cq8/nDPTnNlcNrGpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zQiEukILIRX0n7awa3eSW33+Ea9YZtfDSaK1A2Yki10=;
        b=OxHUNQODYbRgDAcuh5aQ35V89a7H3QBMM5LIAszsNNyjZUHcWZtoKdm78RJhGtqyzNutmH
        2lLdmn/syl8uj9AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Rename SRCU-t and SRCU-u to avoid lowercase
 characters
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860261.29796.13967515283245160480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     00a447fabb5252d01035e78ae7f2943e5b4fff64
Gitweb:        https://git.kernel.org/tip/00a447fabb5252d01035e78ae7f2943e5b4fff64
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 20 Feb 2021 10:13:52 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:17 -07:00

torture: Rename SRCU-t and SRCU-u to avoid lowercase characters

The convention that scenario names are all uppercase has two exceptions,
SRCU-t and SRCU-u.  This commit therefore renames them to SRCU-T and
SRCU-U, respectively, to bring them in line with this convention.  This in
turn permits tighter argument checking in the torture-test scripting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST      |  4 +--
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T      | 11 +++++++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U      |  9 ++++++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot |  2 +-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t      | 11 +-------
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u      |  9 +------
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot |  2 +-
 9 files changed, 25 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index f2b20db..98b6175 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -7,8 +7,8 @@ TREE07
 TREE09
 SRCU-N
 SRCU-P
-SRCU-t
-SRCU-u
+SRCU-T
+SRCU-U
 TINY01
 TINY02
 TASKS01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
new file mode 100644
index 0000000..d6557c3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T
@@ -0,0 +1,11 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TINY_SRCU=y
+CONFIG_RCU_TRACE=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+#CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot
new file mode 100644
index 0000000..238bfe3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-T.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=srcu
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
new file mode 100644
index 0000000..6bc24e9
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U
@@ -0,0 +1,9 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TINY_SRCU=y
+CONFIG_RCU_TRACE=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot
new file mode 100644
index 0000000..ce48c7b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-U.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=srcud
+rcupdate.rcu_self_test=1
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
deleted file mode 100644
index d6557c3..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ /dev/null
@@ -1,11 +0,0 @@
-CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_TINY_SRCU=y
-CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-#CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot
deleted file mode 100644
index 238bfe3..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t.boot
+++ /dev/null
@@ -1 +0,0 @@
-rcutorture.torture_type=srcu
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
deleted file mode 100644
index 6bc24e9..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ /dev/null
@@ -1,9 +0,0 @@
-CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_TINY_SRCU=y
-CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot
deleted file mode 100644
index ce48c7b..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-rcutorture.torture_type=srcud
-rcupdate.rcu_self_test=1
