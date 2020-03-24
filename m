Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE319096D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCXJUc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:20:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgCXJQd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffh-0007vo-Pl; Tue, 24 Mar 2020 10:16:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C8831C0470;
        Tue, 24 Mar 2020 10:16:29 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:29 -0000
From:   "tip-bot2 for SeongJae Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc/RCU/listRCU: Fix typos in a example code snippets
Cc:     SeongJae Park <sjpark@amazon.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138911.28353.7021878257400945600.tip-bot2@tip-bot2>
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

Commit-ID:     c50a871409dc664f2f89d11926d9a6b8ab7f5b07
Gitweb:        https://git.kernel.org/tip/c50a871409dc664f2f89d11926d9a6b8ab7f5b07
Author:        SeongJae Park <sjpark@amazon.de>
AuthorDate:    Mon, 06 Jan 2020 21:07:57 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:03:13 -08:00

doc/RCU/listRCU: Fix typos in a example code snippets

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/listRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 55d2b30..e768f56 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -226,7 +226,7 @@ need to be filled in)::
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
-				e->rule.file_count = newfield_count;
+				e->rule.field_count = newfield_count;
 				write_unlock(&auditsc_lock);
 				return 0;
 			}
@@ -255,7 +255,7 @@ RCU (*read-copy update*) its name.  The RCU code is as follows::
 					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
-				ne->rule.file_count = newfield_count;
+				ne->rule.field_count = newfield_count;
 				list_replace_rcu(&e->list, &ne->list);
 				call_rcu(&e->rcu, audit_free_rule);
 				return 0;
