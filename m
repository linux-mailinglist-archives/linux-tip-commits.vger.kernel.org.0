Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C129F1CE64C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgEKVBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732001AbgEKVAH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 17:00:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400CC061A0C;
        Mon, 11 May 2020 14:00:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWv-000613-7h; Mon, 11 May 2020 23:00:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 842841C086D;
        Mon, 11 May 2020 22:59:43 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:43 -0000
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Revert "rculist: Describe variadic macro argument in
 a Sphinx-compatible way"
Cc:     j.neuschaefer@gmx.net, "Paul E. McKenney" <paulmck@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078346.390.5687192511992244193.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ddc465936643108d5ba61f88594a2868d6a156ab
Gitweb:        https://git.kernel.org/tip/ddc465936643108d5ba61f88594a2868d6a156ab
Author:        Jonathan Neuschäfer <j.neuschaefer@gmx.net>
AuthorDate:    Thu, 05 Mar 2020 23:22:55 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

Revert "rculist: Describe variadic macro argument in a Sphinx-compatible way"

This reverts commit f452ee096d95482892b101bde4fd037fa025d3cc.

The workaround became unnecessary with commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 8214cdc..7375bb3 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -371,7 +371,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the list_head within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protection.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as list_add_rcu()
@@ -646,7 +646,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
- * @cond...:	optional lockdep expression if called from non-RCU protection.
+ * @cond:	optional lockdep expression if called from non-RCU protection.
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
