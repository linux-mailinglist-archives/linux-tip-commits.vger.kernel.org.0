Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE82D9022
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393094AbgLMTZs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgLMTCF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:05 -0500
Date:   Sun, 13 Dec 2020 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2hPH1Lh4Df8l5q+rkZuukpbeYLsArMu0UKcspFyIXYA=;
        b=lnHK2qat/jYqB0AQko0lVYrfrwDFFPrP+aLZU4llgjGLw96TFCVg7Yspy7LQorPo52tZlp
        t+CTbYhiCbt1Htu/RhTYRUEzdgSQxzC/Q3db5BDYn/QjZppxd46Z+JYZvPdPvoJg9kMRKZ
        JTAAzQjqT0lv9U2u2BevJj8j0c4jdSw75k2V5n9eNjsFMhIyQYmBtKh1pipYwjNhl1WJiF
        ELpvQVsLu+sGj1z5S4HaM5GcwiiflSUtd/K65wDQtSnjZmhcgE0wvTItg2achYlru74zh8
        G4LwSMiwvVbxnrp9LdD2dflBt5C2Fe5mX9nnA7Z7u/+/xePCRKwRkMBQNcOYFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2hPH1Lh4Df8l5q+rkZuukpbeYLsArMu0UKcspFyIXYA=;
        b=j1pBK0Bak7NVt45bV209kB461LTos85/4bhIgwLWWTNhKLeExdd7/FY/2v2LZ0+s3nEm4j
        Aesc4YkSFEvTomBg==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607346.3364.10168001356842712455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     65e9eb1ccfe56b41a0d8bfec651ea014968413cb
Gitweb:        https://git.kernel.org/tip/65e9eb1ccfe56b41a0d8bfec651ea014968413cb
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:28 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:10:01 -08:00

rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition

We run into a unused variable warning in bridge code when variable is
only used inside the condition of rcu_dereference_protected().

 #define mlock_dereference(X, br) \
	rcu_dereference_protected(X, lockdep_is_held(&br->multicast_lock))

Since on builds with CONFIG_PROVE_RCU=n rcu_dereference_protected()
compiles to nothing the compiler doesn't see the variable use.

This commit therefore prevents this warning by adding the condition as
dead code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: paulmck@kernel.org
CC: josh@joshtriplett.org
CC: rostedt@goodmis.org
CC: mathieu.desnoyers@efficios.com
CC: joel@joelfernandes.org
CC: jiangshanlai@gmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f9533bb..de08264 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -328,7 +328,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #else /* #ifdef CONFIG_PROVE_RCU */
 
-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
+#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
 #define rcu_sleep_check() do { } while (0)
 
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
