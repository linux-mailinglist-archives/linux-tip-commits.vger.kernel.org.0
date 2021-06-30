Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159083B8409
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhF3NwJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbhF3Nus (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:48 -0400
Date:   Wed, 30 Jun 2021 13:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3TyJhKGVbshaeHj8GfpVroYsga7++KW9VNCyUJ+s85o=;
        b=g+1S2xOfEoW6CGPgB1NFBjEalh53H5FTn136SPd2MZGbtLGgNpaX85rXxm+hIKYLNpWeFR
        W6EmwgYlbTpBkU9ecxMOJEC7sdq0GqH/VJdbNZqdajP9UoK5qyScTWsJLD+wzjHigrpSpF
        PC77meWbuyAxWa5VhwkZ+b70Lg3OqpkjbrP1I6XFmTjHNihsrFnMjzWO3G5/bCMGoQL/ve
        b8bHiCWxvUr7CUeEB+dzIU/pDBUpP5GUkygMryi1NQIvTQf2gYusIIoLbxa8rl3dfa+ffz
        WtIVmRNhDcdzF3WLGJiVvShLgOzizXN1jNX65bHHWRBpspw972+2RbYiG99w6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3TyJhKGVbshaeHj8GfpVroYsga7++KW9VNCyUJ+s85o=;
        b=SfC2EqjakbDZWEmfU9U1spkeJy33RyMSRrlP/nD6wWx6kgHp13rDS+teTg+e7rcKDSPcvQ
        /n+KHLFEK5Qr87Dg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access
 to nr_bkv_objs
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087956.395.5513533942041405498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ac7625ebd5f7bad93f821b7397fe50635f58aa4b
Gitweb:        https://git.kernel.org/tip/ac7625ebd5f7bad93f821b7397fe50635f58aa4b
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Thu, 15 Apr 2021 19:19:57 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs

nr_bkv_objs is a count of the objects in the kvfree_rcu page cache.
Accessing it requires holding the ->lock.  Switch to READ_ONCE() and
WRITE_ONCE() macros to provide lockless access to this counter.
This lockless access is used for the shrinker.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74d840a..676a49a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3250,7 +3250,7 @@ get_cached_bnode(struct kfree_rcu_cpu *krcp)
 	if (!krcp->nr_bkv_objs)
 		return NULL;
 
-	krcp->nr_bkv_objs--;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
 	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
@@ -3264,9 +3264,8 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 		return false;
 
 	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	krcp->nr_bkv_objs++;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
 	return true;
-
 }
 
 static int
@@ -3278,7 +3277,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
-	krcp->nr_bkv_objs = 0;
+	WRITE_ONCE(krcp->nr_bkv_objs, 0);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	llist_for_each_safe(pos, n, page_list) {
@@ -3682,18 +3681,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
-	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->nr_bkv_objs;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
+		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
