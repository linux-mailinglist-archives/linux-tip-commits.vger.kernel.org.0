Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF0264EE1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIJT2K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 15:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgIJPsR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C3C06134F;
        Thu, 10 Sep 2020 08:08:29 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIqSlBM5m5tgXp5bs0+fPyqW4eg6ui/UC5UO14epl3s=;
        b=nbDL8HtnCHJ9RwqMV1du7VKQKsuDeWwJf4Y2OR3XGJdSBZ8vaBP/4BxBPSw9XnFV0LI4F7
        LDyfG6aCjJEVYqVR180R/p9oCiaNvXegZepP8DyUZyBcmfmaI08NCCw9sAh4j8PnL9STIu
        AKWt80DqM8wy4yxVIx9XFiWEriVbaQO78akWYjeOvQ8Sn1w5KQKaqm40UhZ5RQUqY/cGvZ
        DcT6l0cu+fkvHzz8F6pxBspCQDVK74RbnEHiu9YlajDgh+ZIsvA87NC8tx9eeEAVx5oFV2
        WNm7kU01+5mowueM9stobrEHwb6ETyLiWQsFE3/Fkg1TzO1oZ76bx3B5cWGfAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIqSlBM5m5tgXp5bs0+fPyqW4eg6ui/UC5UO14epl3s=;
        b=THZq6iK77vEbIteolIsWT3+Q2L/dBN8GPR7HaRLnI2Qgf+HSTgDqWWXDTfl60GdLypDAI9
        ZxfBcmPqhTFEa5DA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rbtree_latch: Use seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-8-a.darwish@linutronix.de>
References: <20200827114044.11173-8-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050648.20229.11045619138069270549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     24bf401cebfd630cc9e2c3746e43945e836626f9
Gitweb:        https://git.kernel.org/tip/24bf401cebfd630cc9e2c3746e43945e836626f9
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:29 +02:00

rbtree_latch: Use seqcount_latch_t

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures that only latching-safe seqcount APIs
are to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-8-a.darwish@linutronix.de
---
 include/linux/rbtree_latch.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 7d012fa..3d1a9e7 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -42,8 +42,8 @@ struct latch_tree_node {
 };
 
 struct latch_tree_root {
-	seqcount_t	seq;
-	struct rb_root	tree[2];
+	seqcount_latch_t	seq;
+	struct rb_root		tree[2];
 };
 
 /**
@@ -206,7 +206,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	do {
 		seq = raw_read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (read_seqcount_retry(&root->seq, seq));
+	} while (read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
