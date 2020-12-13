Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC42D8FA1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391124AbgLMTC6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390877AbgLMTCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5AC0619D6;
        Sun, 13 Dec 2020 11:01:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=v7boa4XFumMgzokPCNQKqV7k1GOmq808fsDhcysmp7E=;
        b=MYs2lEVfbi4XgBg0S1cY70LDPQxtTMv7Uq02OxR/xidzfSsoNjFjwVuePJibz0VJipnqsJ
        JTKV/hiqZ97DlCMD7bP5xHZV8qU/k9LvmPlIFGoVKN3egKBIKmvv7/YC++JPAovvsaTsTA
        21b0EJMg5ciJ12uJu0eIJ5zN/mL+SOIp5k7Otb+JglpOtmnYS4weeii3cIYgkzKurtd8pd
        R5gG8K5CiDNdrqwvxedjpns2F1rTFRoaig7rekYUBzn6K+dfnUn+inZ1Up1qoqOfQM4NTA
        xziKT0OeIm/BaxoEaknvSRudXqmDolZ+OjLNZybabsffmlLsqrv19KcogcARcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=v7boa4XFumMgzokPCNQKqV7k1GOmq808fsDhcysmp7E=;
        b=V8LR2CnVIyaHmnwUNj/AMedGymZYEPeDjyfRQIbchuX3/0kve8NrezlixBYedAmklCa9eU
        4UT6EZVpdCeGj6CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Adjust scenarios SRCU-t and SRCU-u to
 make kconfig happy
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606952.3364.10147963807679209999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6f26d010e678249367cc00b5a827c3731c8138f3
Gitweb:        https://git.kernel.org/tip/6f26d010e678249367cc00b5a827c3731c8138f3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 17 Sep 2020 12:34:01 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:52 -08:00

rcutorture: Adjust scenarios SRCU-t and SRCU-u to make kconfig happy

The SRCU-u scenario expects to enable lockdep but to also disable the
CONFIG_PREEMPT_COUNT kconfig option.  This no longer works.  This commit
therefore instead enables lockdep in SRCU-t, which then allows SRCU-u
to disable CONFIG_PREEMPT_COUNT.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-t | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-u | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
index 6c78022..d6557c3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -4,7 +4,8 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 #CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
index c15ada8..6bc24e9 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -4,7 +4,6 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_PREEMPT_COUNT=n
