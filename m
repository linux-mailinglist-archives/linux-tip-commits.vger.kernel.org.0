Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4D1494A8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAYKnD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:43:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44231 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbgAYKnD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItz-0008Uk-O2; Sat, 25 Jan 2020 11:42:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1A6281C1A81;
        Sat, 25 Jan 2020 11:42:48 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:47 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove rcu_swap_protected()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896782.396.10070315148965985301.tip-bot2@tip-bot2>
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

Commit-ID:     4414abf89158d734a83c99f6504f648417bd9550
Gitweb:        https://git.kernel.org/tip/4414abf89158d734a83c99f6504f648417bd9550
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 23 Sep 2019 16:31:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 12 Dec 2019 10:24:52 -08:00

rcu: Remove rcu_swap_protected()

Now that the calls to rcu_swap_protected() have been replaced by
rcu_replace_pointer(), this commit removes rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Shane M Seymour <shane.seymour@hpe.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/rcupdate.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0b75063..fe47024 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -401,22 +401,6 @@ do {									      \
 })
 
 /**
- * rcu_swap_protected() - swap an RCU and a regular pointer
- * @rcu_ptr: RCU pointer
- * @ptr: regular pointer
- * @c: the conditions under which the dereference will take place
- *
- * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
- * @c is the argument that is passed to the rcu_dereference_protected() call
- * used to read that pointer.
- */
-#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
-	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
-	rcu_assign_pointer((rcu_ptr), (ptr));				\
-	(ptr) = __tmp;							\
-} while (0)
-
-/**
  * rcu_access_pointer() - fetch RCU pointer with no dereferencing
  * @p: The pointer to read
  *
