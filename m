Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5502A1494D0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgAYKpi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:45:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgAYKnG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu7-0008Vo-DW; Sat, 25 Jan 2020 11:43:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F30181C1A75;
        Sat, 25 Jan 2020 11:42:48 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:48 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Fix typo "deference" to "dereference"
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896880.396.17967255195329015125.tip-bot2@tip-bot2>
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

Commit-ID:     6e6eca2ee79a23329093cdf8d1cc0bd86128981f
Gitweb:        https://git.kernel.org/tip/6e6eca2ee79a23329093cdf8d1cc0bd86128981f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 13 Nov 2019 09:12:59 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 10 Dec 2019 18:51:54 -08:00

doc: Fix typo "deference" to "dereference"

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep-splat.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
index 9c01597..b809631 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.txt
@@ -99,7 +99,7 @@ With this change, the rcu_dereference() is always within an RCU
 read-side critical section, which again would have suppressed the
 above lockdep-RCU splat.
 
-But in this particular case, we don't actually deference the pointer
+But in this particular case, we don't actually dereference the pointer
 returned from rcu_dereference().  Instead, that pointer is just compared
 to the cic pointer, which means that the rcu_dereference() can be replaced
 by rcu_access_pointer() as follows:
