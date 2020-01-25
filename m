Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE71494A9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgAYKnD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:43:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44215 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgAYKnB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu2-0008Sq-Ez; Sat, 25 Jan 2020 11:42:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A2A251C1A76;
        Sat, 25 Jan 2020 11:42:46 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:46 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist_nulls: Add docbook comments
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896647.396.11467334487017924378.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7f5d51e26a471f771b8dae1b9ef417f5fd5e9c85
Gitweb:        https://git.kernel.org/tip/7f5d51e26a471f771b8dae1b9ef417f5fd5e9c85
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Thu, 05 Dec 2019 11:46:49 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 10 Jan 2020 14:00:57 -08:00

rculist_nulls: Add docbook comments

This patch adds docbook comment headers for hlist_nulls_first_rcu()
and hlist_nulls_next_rcu() in rculist_nulls.h.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 517a06f..25952c4 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 	}
 }
 
+/**
+ * hlist_nulls_first_rcu - returns the first element of the hash list.
+ * @head: the head of the list.
+ */
 #define hlist_nulls_first_rcu(head) \
 	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
 
+/**
+ * hlist_nulls_next_rcu - returns the element of the list after @node.
+ * @node: element of the list.
+ */
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
