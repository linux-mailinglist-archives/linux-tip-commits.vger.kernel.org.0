Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E067288269
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgJIGg5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbgJIGfk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:40 -0400
Date:   Fri, 09 Oct 2020 06:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ao+0r4b2jrr1V7iI8+Y3s9H4twbjWQdGlNOwMuabJy4=;
        b=ULMLF0Ik5FHZQCzPDTLD3y69guEgKf/XAYVBSnUWArdU9RQ4Cmv5VZJyZ4J9S50jtzOyrY
        iOJ5ViW8NIX540KyLvxrqqJHLNP7lrM0tPQU+i4by9yRQU5tcC37LdTCA2LwOZB05Xam7C
        10WyHgodTqPU236/56yi2AC+qlg9wLvOHlWOGgnKoUsbame7sQh7De993mboAi5y58KGPY
        IxjMz3wdwMDdLfcO9mMuSUIkI3Z6/ezOCVF1LT4QFYbbwC82wvUmEK/oEEZyHrBl1kfdvc
        WODTGtbBbsY07oxO1fd4hmzQX1prOPqqmpi9+xV1tKykyAM6MiQktORYl8pf5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ao+0r4b2jrr1V7iI8+Y3s9H4twbjWQdGlNOwMuabJy4=;
        b=JA2JP0ZJntvU1ozqMyFiI5GjbEAOLf/3QUy/EaESuxhcI3xcjlKtEnF//A4LhJ1k2ZnW/J
        pLFij1qMRCI0LCBg==
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist: Introduce list/hlist_for_each_entry_srcu() macros
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Suraj Upadhyay <usuraj35@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533720.7002.1441565405440890375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ae2212a7216b674633bdc3bd2e24947a0665efb8
Gitweb:        https://git.kernel.org/tip/ae2212a7216b674633bdc3bd2e24947a0665efb8
Author:        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
AuthorDate:    Sun, 12 Jul 2020 18:40:02 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:09 -07:00

rculist: Introduce list/hlist_for_each_entry_srcu() macros

list/hlist_for_each_entry_rcu() provides an optional cond argument
to specify the lock held in the updater side.
However for SRCU read side, not providing the cond argument results
into false positive as whether srcu_read_lock is held or not is not
checked implicitly. Therefore, on read side the lockdep expression
srcu_read_lock_held(srcu struct) can solve this issue.

However, the function still fails to check the cases where srcu
protected list is traversed with rcu_read_lock() instead of
srcu_read_lock(). Therefore, to remove the false negative,
this patch introduces two new list traversal primitives :
list_for_each_entry_srcu() and hlist_for_each_entry_srcu().

Both of the functions have non-optional cond argument
as it is required for both read and update side, and simply checks
if the cond is true. For regular read side the lockdep expression
srcu_read_lock_head() can be passed as the cond argument to
list/hlist_for_each_entry_srcu().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Suraj Upadhyay <usuraj35@gmail.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
[ paulmck: Add "true" per kbuild test robot feedback. ]
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 48 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 7a6fc99..f8633d3 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -63,9 +63,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
 	})
+
+#define __list_check_srcu(cond)					 \
+	({								 \
+	RCU_LOCKDEP_WARN(!(cond),					 \
+		"RCU-list traversed without holding the required lock!");\
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
+
+#define __list_check_srcu(cond) ({ })
 #endif
 
 /*
@@ -386,6 +394,25 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_srcu	-	iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ * The lockdep expression srcu_read_lock_held() can be passed as the
+ * cond argument from read side.
+ */
+#define list_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
+		&pos->member != (head);					\
+		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+
+/**
  * list_entry_lockless - get the struct for this entry
  * @ptr:        the &struct list_head pointer.
  * @type:       the type of the struct this is embedded in.
@@ -684,6 +711,27 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 			&(pos)->member)), typeof(*(pos)), member))
 
 /**
+ * hlist_for_each_entry_srcu - iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ * The lockdep expression srcu_read_lock_held() can be passed as the
+ * cond argument from read side.
+ */
+#define hlist_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);			\
+		pos;							\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
+			&(pos)->member)), typeof(*(pos)), member))
+
+/**
  * hlist_for_each_entry_rcu_notrace - iterate over rcu list of given type (for tracing)
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
