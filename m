Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6442319E7E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhBLMhu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:37:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBLMhr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:47 -0500
Date:   Fri, 12 Feb 2021 12:37:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dUJvwdumNVZHK95MXFfgcP7q4xasT44BxPDFvU3NBMY=;
        b=cV54wL2Xdn934oFYsHyy4JK00CHOcKwcTdvVpG6sTejwgSVqU3MQcyPHZ3ZqYppEXC7wIK
        GlcfHdIup6hqhsHdBaPQwQdG9V5OobzOvbMez53//mYvIXJHZG8VGLQs3nhEF1VIiy0DUA
        6wKl60ubu6QJ8ZH1UcimEs0knO6e9Ll9enoWdWfVRAldFWxgcH7a2L+J20+OhjDfoJ03XK
        cuzxnmwiVIgi4nSDWeuJyBHZB5z81HRIpnhlW7ROEieQFXsfaXx+abZBslEnv20pY44sIO
        C0lUTTA+Q7HomXoPCTfcj/G9LzcDMXPKkur8kEm9iwSkwNMeDejM+xKkfbvDAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dUJvwdumNVZHK95MXFfgcP7q4xasT44BxPDFvU3NBMY=;
        b=hU5w9v9a+QeETkGVRkLZIVM8cGSXwS6G9nXTT2XuzUi6PbSY6iMnY+995UEPRkA1B5kdDl
        gR7qdV1qOC9TKiBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make call_rcu() print mem_dump_obj() info for
 double-freed callback
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Andrii Nakryiko <andrii@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342318.23325.5404547146366093321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b4b7914a6a73fc169fd1ce2fcd78a1d83d9528a9
Gitweb:        https://git.kernel.org/tip/b4b7914a6a73fc169fd1ce2fcd78a1d83d9528a9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 08 Dec 2020 13:45:49 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 22 Jan 2021 15:24:16 -08:00

rcu: Make call_rcu() print mem_dump_obj() info for double-freed callback

The debug-object double-free checks in __call_rcu() print out the
RCU callback function, which is usually sufficient to track down the
double free.  However, all uses of things like queue_rcu_work() will
have the same RCU callback function (rcu_work_rcufn() in this case),
so a diagnostic message for a double queue_rcu_work() needs more than
just the callback function.

This commit therefore calls mem_dump_obj() to dump out any additional
available information on the double-freed callback.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..84513c5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2941,6 +2941,7 @@ static void check_cb_ovld(struct rcu_data *rdp)
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
@@ -2954,8 +2955,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to __call_rcu().
 		 */
-		WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!!\n",
-			  head, head->func);
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
 	}
