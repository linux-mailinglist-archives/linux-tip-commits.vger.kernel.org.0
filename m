Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498ED1CE62E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgEKVAC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732066AbgEKVAB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 17:00:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6403C061A0C;
        Mon, 11 May 2020 14:00:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWo-00060D-UV; Mon, 11 May 2020 22:59:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B7B31C074B;
        Mon, 11 May 2020 22:59:42 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:42 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Replace assigned pointer ret value by
 corresponding boolean value
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078227.390.16875132364939168186.tip-bot2@tip-bot2>
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

Commit-ID:     a66dbda7893f48b97d7406ae42fa29190aa672a0
Gitweb:        https://git.kernel.org/tip/a66dbda7893f48b97d7406ae42fa29190aa672a0
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Fri, 27 Mar 2020 21:23:53 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Replace assigned pointer ret value by corresponding boolean value

Coccinelle reports warnings at rcu_read_lock_held_common()

WARNING: Assignment of 0/1 to bool variable

To fix this,
the assigned  pointer ret values are replaced by corresponding boolean value.
Given that ret is a pointer of bool type

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 72461dd..17f2356 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -98,15 +98,15 @@ module_param(rcu_normal_after_boot, int, 0);
 static bool rcu_read_lock_held_common(bool *ret)
 {
 	if (!debug_lockdep_rcu_enabled()) {
-		*ret = 1;
+		*ret = true;
 		return true;
 	}
 	if (!rcu_is_watching()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	if (!rcu_lockdep_current_cpu_online()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	return false;
