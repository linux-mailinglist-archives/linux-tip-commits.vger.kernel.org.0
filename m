Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B4A2D901A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394947AbgLMTZx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbgLMTCF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:05 -0500
Date:   Sun, 13 Dec 2020 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+oQOrJEYsdg1mESLBSgg1eK/Hq8ZzGFN/yuceEK9zLc=;
        b=00XSiuVY6A4W5uwaGKsG3b0Zoi8z7WQjaz6R3LtJPoUVY9zmMSW9NuoLnOTstHNuGAEwjf
        98yyYo5m4gGavnyY731xn85Ygnxs7DEBU+dDX6JtDl1Y59xgYXNfZzKGzI70Rcb4wHz9fK
        1kINWexUe5gcz8i0pNTT5OadHDMN4EJ8YEEewP6qAbKqeVvL4eBHvB0MS3qSHfE78cIK9I
        vQkAJFdQ7Il4JbL5BcXMSEXhR/qjmMtKlku5vvSOgfaGF4ldFYtehj79Xq5abaFGJLKN09
        9l7riU9RtvoyLSNKdi/5iKi6DtTB2Bs4sVN2dVImAyRUbrO0LodWjzYKF/0IKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+oQOrJEYsdg1mESLBSgg1eK/Hq8ZzGFN/yuceEK9zLc=;
        b=gC4qNX16xlo+2yeGRH/LG+Hf0Cy1gsGjDSggX+F4c/SmvUMwdy7WIXyr3+o2Hc3N2vMh7V
        f1r9eOH7XkbJq/Bg==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lockdep: Provide dummy forward declaration of
 *_is_held() helpers
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607366.3364.2310309535322165601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cd539cff9470fe1dacf0bf5ab3f54f37b854d6fc
Gitweb:        https://git.kernel.org/tip/cd539cff9470fe1dacf0bf5ab3f54f37b854d6fc
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:27 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:10:01 -08:00

lockdep: Provide dummy forward declaration of *_is_held() helpers

When CONFIG_LOCKDEP is not set, lock_is_held() and lockdep_is_held()
are not declared or defined.  This forces all callers to use #ifdefs
around these checks.

Recent RCU changes added a lot of lockdep_is_held() calls inside
rcu_dereference_protected().  This macro hides its argument on !LOCKDEP
builds, which can lead to false-positive unused-variable warnings.

This commit therefore provides forward declarations of lock_is_held()
and lockdep_is_held() but without defining them.  This way callers
(including those internal to RCU) can keep them visible to the compiler
on !LOCKDEP builds and instead depend on dead code elimination to remove
the references, which in turn prevents the linker from complaining about
the lack of the corresponding function definitions.

[ paulmck: Apply Peter Zijlstra feedback on "extern". ]
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: peterz@infradead.org
CC: mingo@redhat.com
CC: will@kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/lockdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f559487..ccc3ce6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -375,6 +375,12 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 
 #define lockdep_depth(tsk)	(0)
 
+/*
+ * Dummy forward declarations, allow users to write less ifdef-y code
+ * and depend on dead code elimination.
+ */
+extern int lock_is_held(const void *);
+extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
