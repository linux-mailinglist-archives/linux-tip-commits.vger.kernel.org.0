Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8494614946F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgAYKnC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:43:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgAYKnB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu2-0008Vr-VO; Sat, 25 Jan 2020 11:42:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E5861C0105;
        Sat, 25 Jan 2020 11:42:49 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:49 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Updated full list of RCU API in whatisRCU.rst
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        Phong Tran <tranmanphong@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896906.396.7111674737424958367.tip-bot2@tip-bot2>
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

Commit-ID:     17f0da13873ba393a72f14d41ffc8ff388e38723
Gitweb:        https://git.kernel.org/tip/17f0da13873ba393a72f14d41ffc8ff388e38723
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Mon, 11 Nov 2019 23:41:22 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 10 Dec 2019 18:51:54 -08:00

doc: Updated full list of RCU API in whatisRCU.rst

This patch updates the list of RCU API in whatisRCU.rst.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Tested-by: Amol Grover <frextrite@gmail.com>
Tested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 2f6f6eb..c7f147b 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
 RCU list traversal::
 
 	list_entry_rcu
+	list_entry_lockless
 	list_first_entry_rcu
 	list_next_rcu
 	list_for_each_entry_rcu
 	list_for_each_entry_continue_rcu
 	list_for_each_entry_from_rcu
+	list_first_or_null_rcu
+	list_next_or_null_rcu
 	hlist_first_rcu
 	hlist_next_rcu
 	hlist_pprev_rcu
@@ -902,7 +905,7 @@ RCU list traversal::
 	hlist_bl_first_rcu
 	hlist_bl_for_each_entry_rcu
 
-RCU pointer/list udate::
+RCU pointer/list update::
 
 	rcu_assign_pointer
 	list_add_rcu
@@ -912,10 +915,12 @@ RCU pointer/list udate::
 	hlist_add_behind_rcu
 	hlist_add_before_rcu
 	hlist_add_head_rcu
+	hlist_add_tail_rcu
 	hlist_del_rcu
 	hlist_del_init_rcu
 	hlist_replace_rcu
-	list_splice_init_rcu()
+	list_splice_init_rcu
+	list_splice_tail_init_rcu
 	hlist_nulls_del_init_rcu
 	hlist_nulls_del_rcu
 	hlist_nulls_add_head_rcu
