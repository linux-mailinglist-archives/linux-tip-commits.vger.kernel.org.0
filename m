Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4E79CE7F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Sep 2023 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjILKhe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Sep 2023 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjILKhK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Sep 2023 06:37:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FD26A9;
        Tue, 12 Sep 2023 03:36:34 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:36:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=am+Un2OqmW2Loepn8y4t8ZkGjNdfoKTvcEiRMqelg0M=;
        b=fhTkufp6UE56eD+60KBBsTVgb9JUQNGf+SJe0nsedTCsm38j5UX2b4wc6AV3bLv51eyD7x
        118fyEm3wAkR6pE9p9gIPpiC6xHvRNaQDwYP2LrKGfKUB1iR8RpbJGA8JM4PdGmdiMtNev
        4SpwwsesGrLetor2GTvYYRPf1Uuk+PvKczoqRth/PrUKYzyZf002yiKh+RB8AewTM1cVj9
        uNlhnulLE3j163cl2VwD8yfCx4+4r/JfNHw5DT0bEAe5NIqAwMIiYUhtUmXZJHwoaAzyLn
        0CLDvXK1GGwfDxQhJysE/evaBGJ72G04IJ9Ghi23wNl6geVzyUU5NEUxXo6Ong==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=am+Un2OqmW2Loepn8y4t8ZkGjNdfoKTvcEiRMqelg0M=;
        b=j4gQluExe9atJWySglxGy9jOpSOZD0VHYZgc3rWi8ImNgRu6MZTE0ZjPrDhnGJKO4sf7vc
        9zmKe8XilTn1XICg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] cleanup: Make no_free_ptr() __must_check
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816103102.GF980931@hirez.programming.kicks-ass.net>
References: <20230816103102.GF980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169451499208.27769.5856056754166699857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     68373ebb9d61985e05574313a356f751ef9911ab
Gitweb:        https://git.kernel.org/tip/68373ebb9d61985e05574313a356f751ef9911ab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Aug 2023 12:52:04 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:27 +02:00

cleanup: Make no_free_ptr() __must_check

recent discussion brought about the realization that it makes sense for
no_free_ptr() to have __must_check semantics in order to avoid leaking
the resource.

Additionally, add a few comments to clarify why/how things work.

All credit to Linus on how to combine __must_check and the
stmt-expression.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230816103102.GF980931@hirez.programming.kicks-ass.net
---
 include/linux/cleanup.h | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 53f1a7a..9f1a9c4 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -7,8 +7,9 @@
 /*
  * DEFINE_FREE(name, type, free):
  *	simple helper macro that defines the required wrapper for a __free()
- *	based cleanup function. @free is an expression using '_T' to access
- *	the variable.
+ *	based cleanup function. @free is an expression using '_T' to access the
+ *	variable. @free should typically include a NULL test before calling a
+ *	function, see the example below.
  *
  * __free(name):
  *	variable attribute to add a scoped based cleanup to the variable.
@@ -17,6 +18,9 @@
  *	like a non-atomic xchg(var, NULL), such that the cleanup function will
  *	be inhibited -- provided it sanely deals with a NULL value.
  *
+ *	NOTE: this has __must_check semantics so that it is harder to accidentally
+ *	leak the resource.
+ *
  * return_ptr(p):
  *	returns p while inhibiting the __free().
  *
@@ -24,6 +28,8 @@
  *
  * DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
  *
+ * void *alloc_obj(...)
+ * {
  *	struct obj *p __free(kfree) = kmalloc(...);
  *	if (!p)
  *		return NULL;
@@ -32,6 +38,24 @@
  *		return NULL;
  *
  *	return_ptr(p);
+ * }
+ *
+ * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
+ * kfree() is fine to be called with a NULL value. This is on purpose. This way
+ * the compiler sees the end of our alloc_obj() function as:
+ *
+ *	tmp = p;
+ *	p = NULL;
+ *	if (p)
+ *		kfree(p);
+ *	return tmp;
+ *
+ * And through the magic of value-propagation and dead-code-elimination, it
+ * eliminates the actual cleanup call and compiles into:
+ *
+ *	return p;
+ *
+ * Without the NULL test it turns into a mess and the compiler can't help us.
  */
 
 #define DEFINE_FREE(_name, _type, _free) \
@@ -39,8 +63,17 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
+#define __get_and_null_ptr(p) \
+	({ __auto_type __ptr = &(p); \
+	   __auto_type __val = *__ptr; \
+	   *__ptr = NULL;  __val; })
+
+static inline __must_check
+const volatile void * __must_check_fn(const volatile void *val)
+{ return val; }
+
 #define no_free_ptr(p) \
-	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+	((typeof(p)) __must_check_fn(__get_and_null_ptr(p)))
 
 #define return_ptr(p)	return no_free_ptr(p)
 
