Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A552342E8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgGaJ0u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbgGaJXR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E39BC061575;
        Fri, 31 Jul 2020 02:23:17 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TPpFg/iDhPg4uvsjSgCF+AANoqDZU9Tn0k/qRmaErfk=;
        b=4yrEHeXwthooi3ZNFZa0X9m26FcCRfPWVoSOE9krQvZKPbfyzGq200WANz3EQf172YObLh
        PceD9AXIIvwSsBxg1m5s819gJ1ShG883kLdFX3DTOJ3mHRFMVIWSThG5V7tgtr0eG8WZGa
        t0euFncYSQiwaxaVIu3qVQuPLVXsV0YG1BkAfGs8C/X4iFcFD64Qyqjs6GD5BSA7yrSS+l
        LSHBY4RcclIF3Xq0iPeQfS3ubdPWaUFpRr6wGy7mEBkR40puDJZetQe/Llp1UukYVY1ske
        RdOoaEZHhBDE8yP01CdxO2R6t+ekhOM6dVDbVxcrEVigFuia9umnRqKfDu8c3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TPpFg/iDhPg4uvsjSgCF+AANoqDZU9Tn0k/qRmaErfk=;
        b=d85bgsAumYdBLTrynbdhZzXkMKUzrW+U5BeAZNzm1RA0vXSavnTzHuicwYkaDqxzxztg4p
        3iBV5Ph7kvXHS2Cw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Introduce single argument kvfree_rcu() interface
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739523.4006.6314340287723253932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1835f475e3518ade61e25a57572c78b953778656
Gitweb:        https://git.kernel.org/tip/1835f475e3518ade61e25a57572c78b953778656
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:59 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:26 -07:00

rcu: Introduce single argument kvfree_rcu() interface

Make kvfree_rcu() capable of freeing objects that will not
embed an rcu_head within it. This saves storage overhead in
such objects. Reclaiming headless objects this way requires
only a single argument (pointer to the object).

After this patch, there are two ways to use kvfree_rcu():

a) kvfree_rcu(ptr, rhf);
    struct X {
        struct rcu_head rhf;
        unsigned char data[100];
    };

    void *ptr = kvmalloc(sizeof(struct X), GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr, rhf);

b) kvfree_rcu(ptr);
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr);

Note that the headless usage (example b) can only be used in a code
that can sleep. This is enforced by the CONFIG_DEBUG_ATOMIC_SLEEP
option.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 51b26ab..d15d46d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -877,12 +877,42 @@ do {									\
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
- * @ptr:	pointer to kvfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
  *
- * Same as kfree_rcu(), just simple alias.
+ * This macro consists of one or two arguments and it is
+ * based on whether an object is head-less or not. If it
+ * has a head then a semantic stays the same as it used
+ * to be before:
+ *
+ *     kvfree_rcu(ptr, rhf);
+ *
+ * where @ptr is a pointer to kvfree(), @rhf is the name
+ * of the rcu_head structure within the type of @ptr.
+ *
+ * When it comes to head-less variant, only one argument
+ * is passed and that is just a pointer which has to be
+ * freed after a grace period. Therefore the semantic is
+ *
+ *     kvfree_rcu(ptr);
+ *
+ * where @ptr is a pointer to kvfree().
+ *
+ * Please note, head-less way of freeing is permitted to
+ * use from a context that has to follow might_sleep()
+ * annotation. Otherwise, please switch and embed the
+ * rcu_head structure within the type of @ptr.
  */
-#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
+	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
+
+#define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
+#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_1(ptr)					\
+do {								\
+	typeof(ptr) ___p = (ptr);				\
+								\
+	if (___p)						\
+		kvfree_call_rcu(NULL, (rcu_callback_t) (___p));	\
+} while (0)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
