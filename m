Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361103B838D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhF3NuC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhF3Nt5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD4C0617AE;
        Wed, 30 Jun 2021 06:47:28 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pO0YLTXfGsfM0ED5tZuhkFA2WCQnAV92WSxVjUGJpvw=;
        b=rVdZEH+KIwJxJxiM/rhJuSU01ZrVBUdVthgUZUDSuyGe6P1+rIQjx6CR4kriGJgbxXqrYR
        B5WkZk6oGIXcLzAyL3n7JmYUUd1lYbUY5rL3566wWbcpQvTLW8r54B8YbkLTEMbCTSKxrg
        B7akqjv9PCfXQK/+abXg+pXCCsVRTSiRj6/Dih1bTq6ci0ixsSJFuoe7rRY4CFG0DH5Vo5
        YYWJQ+k3X0fHODc7sz/XSVh869CDRxDog2CrCnNkYT1LxCJMqrb+QlO6O+8s/6ZlUDpd0F
        pDGa3xBWZ3ytY3VWhuLjVJyZWSc+OfEr+wMOT1pZIOJGdGRImdQGufLllZpN+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pO0YLTXfGsfM0ED5tZuhkFA2WCQnAV92WSxVjUGJpvw=;
        b=bskMm4j86RiNbKZ8g9AMDWBbt7w1Kx8Svk1qCZFjYJkUw72unkNcqLrT303JOLDH6ENCSZ
        NvrWzZbFr9G86WCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Create an unrcu_pointer() to remove __rcu from a pointer
Cc:     toke@redhat.com, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084584.395.3561271721346634504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     76c8eaafe4f061f3790112842a2fbb297e4bea88
Gitweb:        https://git.kernel.org/tip/76c8eaafe4f061f3790112842a2fbb297e4=
bea88
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 21 Apr 2021 14:30:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 13 May 2021 09:13:23 -07:00

rcu: Create an unrcu_pointer() to remove __rcu from a pointer

The xchg() and cmpxchg() functions are sometimes used to carry out RCU
updates.  Unfortunately, this can result in sparse warnings for both
the old-value and new-value arguments, as well as for the return value.
The arguments can be dealt with using RCU_INITIALIZER():

	old_p =3D xchg(&p, RCU_INITIALIZER(new_p));

But a sparse warning still remains due to assigning the __rcu pointer
returned from xchg to the (most likely) non-__rcu pointer old_p.

This commit therefore provides an unrcu_pointer() macro that strips
the __rcu.  This macro can be used as follows:

	old_p =3D unrcu_pointer(xchg(&p, RCU_INITIALIZER(new_p)));

Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1199ffd..b071d02 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -363,6 +363,20 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
=20
+/**
+ * unrcu_pointer - mark a pointer as not being RCU protected
+ * @p: pointer needing to lose its __rcu property
+ *
+ * Converts @p from an __rcu pointer to a __kernel pointer.
+ * This allows an __rcu pointer to be used with xchg() and friends.
+ */
+#define unrcu_pointer(p)						\
+({									\
+	typeof(*p) *_________p1 =3D (typeof(*p) *__force)(p);		\
+	rcu_check_sparse(p, __rcu);					\
+	((typeof(*p) __force __kernel *)(_________p1)); 		\
+})
+
 #define __rcu_access_pointer(p, space) \
 ({ \
 	typeof(*p) *_________p1 =3D (typeof(*p) *__force)READ_ONCE(p); \
