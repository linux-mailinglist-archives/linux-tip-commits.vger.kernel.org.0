Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994AE2D9019
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394926AbgLMTZs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbgLMTCF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:05 -0500
Date:   Sun, 13 Dec 2020 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zsZQmKoRwiFGLrDgfcbXahzWSoQdPTB1tJBT3cOj6zY=;
        b=Nyu/1pk/1889cPYIBd+xZVqAwpbBX2DOGQNzfH5SWG2RN6Srq+OjgKrLcy612U/MfNE/vb
        OIS5uo10i16bc5gXyH+Hk9zwRClYTfoJF7eVrFNYe1s1GbOe1ZkkBAJQdDQSfCO5NZrqm7
        AxUWNBZq+nWfYLlWVlEXwveaZF01yg3zhyJCYUkSoPSgeqaLtPfW1pXlb7R+i2m7hkKb5i
        qV01bNYeySoS94xkeA5u3OvVQVzjzTchEUmFM0ry0w4rQk6rAYbrLmY7V59FEx+NROH86Q
        tnsU3s4i2w30ZTd6NMwB0r6NIkGBV8N3p2Xp3W+N8ybHgvTnTvbf3fEeMrjaZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zsZQmKoRwiFGLrDgfcbXahzWSoQdPTB1tJBT3cOj6zY=;
        b=6R01Ia27jpJfRWoQ/LyQttTO9kmYo/A2LPSENNpExz3fAVRwzy1ksTlB5DdmAld+C8S+tm
        aMdjxhn40QX8YFCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make preemptible TRACE02 enable lockdep
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607324.3364.8021140551789128343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e1eb075ccf3766860b7aa3f104ca29dcb8a46ed0
Gitweb:        https://git.kernel.org/tip/e1eb075ccf3766860b7aa3f104ca29dcb8a46ed0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 15 Sep 2020 14:33:38 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:12:42 -08:00

rcutorture: Make preemptible TRACE02 enable lockdep

Currently, the CONFIG_PREEMPT_NONE=y rcutorture TRACE01 rcutorture
scenario enables lockdep.  This limits its ability to find bugs due to
non-preemptible sections of code being RCU readers, and pretty much all
code thus appearing to lockdep to be an RCU reader.  This commit therefore
moves lockdep testing to the CONFIG_PREEMPT=y rcutorture TRACE02 scenario.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01 | 6 +++---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02 | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 12e7661..34c8ff5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
 CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index b69ed66..77541ee 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
