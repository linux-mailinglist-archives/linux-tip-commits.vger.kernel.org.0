Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53E2779CF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Sep 2020 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIXT6I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Sep 2020 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIXT6I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Sep 2020 15:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB35C0613CE;
        Thu, 24 Sep 2020 12:58:07 -0700 (PDT)
Date:   Thu, 24 Sep 2020 19:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600977485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jyi2TET1KUaHPx4heTAbnal+/8yvv2uU5a9TrwOkP+g=;
        b=VgHMU3Jme6LUOyteWH1H9Dpuf60NbH5cHEKxg6yBCP0WDKktydU++ZgdkZdijGeUnCt4S5
        WdQSZwWYAxoFaRbWIzs9lJR/jnnM8j+3ZW2iw3quYDUbMnj3WYEnEyAfFtF6Pd9G0CEAow
        lpUInm5QKgrkm/kDc+QtpmGBXhTM8V/Y/BvuQ2V++WwvRz0V/01oWEFheoD66dKZx9g+/y
        wTwnXYi9oj4iB1TMb5HNygq0nORhgpyWquoi7etyUOsxNaD2tcD5e1U2xcbiHU76r6ta46
        wRaxZbZrksPfoMpLjhEDuprN05YuvcLzkIC2ZWNzDfLSRlGuGbOraoeF64LMlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600977485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jyi2TET1KUaHPx4heTAbnal+/8yvv2uU5a9TrwOkP+g=;
        b=EjnqHmw0i3TsXiqM/Do204nDEgYCZPAZEFWeHgiX2yLfFrnFJQG8ysmLEeGVOzsMoa01To
        TCXff/ftwxxoY0Aw==
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Allow debug_obj_descr to be const
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815004027.2046113-2-swboyd@chromium.org>
References: <20200815004027.2046113-2-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <160097748498.7002.9732116646308360622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     aedcade6f4fa9a1e65f327fc42de3fb47660646c
Gitweb:        https://git.kernel.org/tip/aedcade6f4fa9a1e65f327fc42de3fb47660646c
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Fri, 14 Aug 2020 17:40:26 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Sep 2020 21:56:24 +02:00

debugobjects: Allow debug_obj_descr to be const

The debugobject core could be slightly harder to corrupt if the
debug_obj_descr would be a pointer to const memory.

Depending on the architecture, const data structures are placed into
read-only memory and thus are harder to corrupt or hijack.

This descriptor is used to fix up stuff like timers and workqueues when
core kernel data structures are busted, so moving the descriptors to
read-only memory will make debugobjects more resilient to something going
wrong and then corrupting the function pointers inside struct
debug_obj_descr.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200815004027.2046113-2-swboyd@chromium.org

---
 include/linux/debugobjects.h | 32 ++++++++++++++++----------------
 lib/debugobjects.c           | 30 +++++++++++++++---------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index afc416e..8d2dde2 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -30,7 +30,7 @@ struct debug_obj {
 	enum debug_obj_state	state;
 	unsigned int		astate;
 	void			*object;
-	struct debug_obj_descr	*descr;
+	const struct debug_obj_descr *descr;
 };
 
 /**
@@ -64,14 +64,14 @@ struct debug_obj_descr {
 };
 
 #ifdef CONFIG_DEBUG_OBJECTS
-extern void debug_object_init      (void *addr, struct debug_obj_descr *descr);
+extern void debug_object_init      (void *addr, const struct debug_obj_descr *descr);
 extern void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr);
-extern int debug_object_activate  (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_deactivate(void *addr, struct debug_obj_descr *descr);
-extern void debug_object_destroy   (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_free      (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr);
+extern int debug_object_activate  (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_destroy   (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_free      (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr);
 
 /*
  * Active state:
@@ -79,26 +79,26 @@ extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
  * - Must return to 0 before deactivation.
  */
 extern void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next);
 
 extern void debug_objects_early_init(void);
 extern void debug_objects_mem_init(void);
 #else
 static inline void
-debug_object_init      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_init      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr) { }
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr) { }
 static inline int
-debug_object_activate  (void *addr, struct debug_obj_descr *descr) { return 0; }
+debug_object_activate  (void *addr, const struct debug_obj_descr *descr) { return 0; }
 static inline void
-debug_object_deactivate(void *addr, struct debug_obj_descr *descr) { }
+debug_object_deactivate(void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_destroy   (void *addr, struct debug_obj_descr *descr) { }
+debug_object_destroy   (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_free      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_assert_init(void *addr, struct debug_obj_descr *descr) { }
+debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
 
 static inline void debug_objects_early_init(void) { }
 static inline void debug_objects_mem_init(void) { }
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fe45579..e2a3171 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -90,7 +90,7 @@ static int			debug_objects_pool_size __read_mostly
 				= ODEBUG_POOL_SIZE;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
-static struct debug_obj_descr	*descr_test  __read_mostly;
+static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
@@ -223,7 +223,7 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
  * Must be called with interrupts disabled.
  */
 static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
+alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
 	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
@@ -475,7 +475,7 @@ static struct debug_bucket *get_bucket(unsigned long addr)
 
 static void debug_print_object(struct debug_obj *obj, char *msg)
 {
-	struct debug_obj_descr *descr = obj->descr;
+	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
 	if (limit < 5 && descr != descr_test) {
@@ -529,7 +529,7 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 }
 
 static void
-__debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
+__debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
 	bool check_stack = false;
@@ -587,7 +587,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_init(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -602,7 +602,7 @@ EXPORT_SYMBOL_GPL(debug_object_init);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr)
+void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  * @descr:	pointer to an object specific debug description structure
  * Returns 0 for success, -EINVAL for check failed.
  */
-int debug_object_activate(void *addr, struct debug_obj_descr *descr)
+int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -695,7 +695,7 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
+void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -747,7 +747,7 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
+void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -797,7 +797,7 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_free(void *addr, struct debug_obj_descr *descr)
+void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -838,7 +838,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -886,7 +886,7 @@ EXPORT_SYMBOL_GPL(debug_object_assert_init);
  * @next:	state to move to if expected state is found
  */
 void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
 	struct debug_bucket *db;
@@ -934,7 +934,7 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	struct debug_obj_descr *descr;
+	const struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
@@ -1052,7 +1052,7 @@ struct self_test {
 	unsigned long	dummy2[3];
 };
 
-static __initdata struct debug_obj_descr descr_type_test;
+static __initconst const struct debug_obj_descr descr_type_test;
 
 static bool __init is_static_object(void *addr)
 {
@@ -1177,7 +1177,7 @@ out:
 	return res;
 }
 
-static __initdata struct debug_obj_descr descr_type_test = {
+static __initconst const struct debug_obj_descr descr_type_test = {
 	.name			= "selftest",
 	.is_static_object	= is_static_object,
 	.fixup_init		= fixup_init,
