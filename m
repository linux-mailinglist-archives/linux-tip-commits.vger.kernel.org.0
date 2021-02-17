Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFB31DA36
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhBQNTt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhBQNTC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:19:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE1C0617AA;
        Wed, 17 Feb 2021 05:17:39 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rd/W1CRGnSD8mehvLbKv8P+T2jwQCIZywXxgXcMfz94=;
        b=zacELPSktbD/FbyWvAYuCo18wjymiIOh8rHpraTHxtbvbhle9seIqwAd11iiBU21rYmMOI
        58bB6+AgZv9KJiNY47ELu2OIZzruO2VKBtQrLTWCB6PLODki86IAlmgJtZ1R+8eqXbsFOo
        NtQk51gKyCmkGKyoo++YpK0+IfGTD0iEPMucLi0HpxRcnSwR4DMtT5UvIkDNL77bSk3gRm
        bDft2nNNUOhdOCq9atKEyvOt7rX2L0w5SrqGg94G8BWwg8uF5g52c+Vkhf7t0f9oNxYSmQ
        6lK++gPMhN2Qs9r7S9R3IgrRoJ7B2jhCN6LXjJlY+xA13M5/fNGdGR7aZypCQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rd/W1CRGnSD8mehvLbKv8P+T2jwQCIZywXxgXcMfz94=;
        b=bk8+V0X/BwicpI5hFztndOOEFrM9kBSUme4gUHbaiHHsRIKr4F4BfPvZ1rMvLTJbT7CBiO
        v4Euc2QEz9jQQaBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rbtree, timerqueue: Use rb_add_cached()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785704.20312.639489769023750532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     798172b1374e28ecf687d6662fc5fdaec5c65385
Gitweb:        https://git.kernel.org/tip/798172b1374e28ecf687d6662fc5fdaec5c65385
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Apr 2020 17:07:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:01 +01:00

rbtree, timerqueue: Use rb_add_cached()

Reduce rbtree boiler plate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/timerqueue.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index c527109..cdb9c76 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -14,6 +14,14 @@
 #include <linux/rbtree.h>
 #include <linux/export.h>
 
+#define __node_2_tq(_n) \
+	rb_entry((_n), struct timerqueue_node, node)
+
+static inline bool __timerqueue_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __node_2_tq(a)->expires < __node_2_tq(b)->expires;
+}
+
 /**
  * timerqueue_add - Adds timer to timerqueue.
  *
@@ -26,28 +34,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->rb_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct timerqueue_node *ptr;
-	bool leftmost = true;
-
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
 
-	while (*p) {
-		parent = *p;
-		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires < ptr->expires) {
-			p = &(*p)->rb_left;
-		} else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	rb_link_node(&node->node, parent, p);
-	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
-
-	return leftmost;
+	return rb_add_cached(&node->node, &head->rb_root, __timerqueue_less);
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 
