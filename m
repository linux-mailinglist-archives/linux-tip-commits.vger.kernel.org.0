Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5F28BEBB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Oct 2020 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404066AbgJLRId (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Oct 2020 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403845AbgJLRI3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Oct 2020 13:08:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997CC0613D0;
        Mon, 12 Oct 2020 10:08:29 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602522507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kD4AE9Xjhy1xBbpVilqLgTZel6YalRUgINSHXo6BGKk=;
        b=28bcxx51ftZbCchvyRprFM2u8Ij41aWJ1fC28W2ROT3ZV8giFDXjg+Jpmj6miwtDDq6xuy
        UbZDdXv9a3Q5IebGzHfPv9eHUvohU473+8CKzgMaZBDEPWxglhVtcnaSgddutPZiWOkSFo
        Y3c5MjvXD/HWk/jQezsrGBYr2Gb9pB6mvUuQ8At8DtgyZxV6/fHVjqYPexsyWHpy0ybPia
        ubVx4sDt9ZG2h6aPzUmkwn5OC4mDe4fiJqUOQrLcwH92W1LDu3mOUTwbHUo+fGqLVul89S
        /IQPSXUG3qkCRPWlhNYPaV+uGC3v7v0FeBb7yMRdRGFks9oXEOZL02ZgS9VrwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602522507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kD4AE9Xjhy1xBbpVilqLgTZel6YalRUgINSHXo6BGKk=;
        b=PZaApUfb0QgzMnyDPTlugskiKtbiB7ywc7OOujyQ4XgIo+keahmSYeon+COwzdXKAVPx7c
        KnZx0viGIrYDipBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] llist: Add nonatomic __llist_add() and __llist_dell_all()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <159870619318.1229682.13027387548510028721.stgit@devnote2>
References: <159870619318.1229682.13027387548510028721.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160252250706.7002.737254513470475787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     476c5818c37a7828d558f34ae01f0c32f8bfadde
Gitweb:        https://git.kernel.org/tip/476c5818c37a7828d558f34ae01f0c32f8bfadde
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 29 Aug 2020 22:03:13 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 12 Oct 2020 18:27:27 +02:00

llist: Add nonatomic __llist_add() and __llist_dell_all()

We'll use these in the new, lockless kretprobes code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/159870619318.1229682.13027387548510028721.stgit@devnote2
---
 drivers/gpu/drm/i915/i915_request.c |  6 ------
 include/linux/llist.h               | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0b2fe55..0e851b9 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -357,12 +357,6 @@ void i915_request_retire_upto(struct i915_request *rq)
 	} while (i915_request_retire(tmp) && tmp != rq);
 }
 
-static void __llist_add(struct llist_node *node, struct llist_head *head)
-{
-	node->next = head->first;
-	head->first = node;
-}
-
 static struct i915_request * const *
 __engine_active(struct intel_engine_cs *engine)
 {
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2e9c721..24f207b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -197,6 +197,16 @@ static inline struct llist_node *llist_next(struct llist_node *node)
 extern bool llist_add_batch(struct llist_node *new_first,
 			    struct llist_node *new_last,
 			    struct llist_head *head);
+
+static inline bool __llist_add_batch(struct llist_node *new_first,
+				     struct llist_node *new_last,
+				     struct llist_head *head)
+{
+	new_last->next = head->first;
+	head->first = new_first;
+	return new_last->next == NULL;
+}
+
 /**
  * llist_add - add a new entry
  * @new:	new entry to be added
@@ -209,6 +219,11 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
 	return llist_add_batch(new, new, head);
 }
 
+static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
+{
+	return __llist_add_batch(new, new, head);
+}
+
 /**
  * llist_del_all - delete all entries from lock-less list
  * @head:	the head of lock-less list to delete all entries
@@ -222,6 +237,14 @@ static inline struct llist_node *llist_del_all(struct llist_head *head)
 	return xchg(&head->first, NULL);
 }
 
+static inline struct llist_node *__llist_del_all(struct llist_head *head)
+{
+	struct llist_node *first = head->first;
+
+	head->first = NULL;
+	return first;
+}
+
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
 struct llist_node *llist_reverse_order(struct llist_node *head);
