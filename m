Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0577E2D8FDF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLMTQJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392457AbgLMTDK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412FC0619D8;
        Sun, 13 Dec 2020 11:01:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/O5STtLbx51+JYrmDZWaTrM9A5smaxG+GPTfVI6OQV0=;
        b=YVYsNytgu+zZqWGfzcE6AWnJyNrc4F8Pi9IpesgTS8dunTew0wwuOn/EDMxgY587xv1eGP
        BeknYYFCvJxTbEKevAEDiBx9bUbAEkscm+tSKF9WPF9eKeUeQh67JaxttnTQlnRGyrgUtK
        staHWLe6kjEQ82MRQDWFB9hFhsI45i9L70eYBT873c69QGevho3zJWLrzdbOhGjJLwN/L/
        ec70nN/s15EI3P2Ye7jNwFQoY/UkQMXggi3nDm92gMKKvOonQ1nfHmWxbDeTbHAl/4LRcI
        Zs1QYmg5ekT0fiL2ImslL8RSIcbmA9TXTYQLV0/im9pBAXbqmkP5Sp8zquERgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/O5STtLbx51+JYrmDZWaTrM9A5smaxG+GPTfVI6OQV0=;
        b=+f6ptejEV05oou8Eppl0ekvVyjjppz0MUutKShidSMVNWbw05VBZuORiGfrXhQMVbDjlnu
        iK34+gROv2/VG9Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Prevent hangs for invalid arguments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606989.3364.4487124508260996108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2f2214d43ccd27ac6d124287107c136a0f7c6053
Gitweb:        https://git.kernel.org/tip/2f2214d43ccd27ac6d124287107c136a0f7c6053
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 17 Sep 2020 10:30:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:51 -08:00

rcuscale: Prevent hangs for invalid arguments

If an rcuscale torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a rcu_scale_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index c42f240..06491d5 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -802,7 +802,6 @@ rcu_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -876,6 +875,10 @@ rcu_scale_init(void)
 unwind:
 	torture_init_end();
 	rcu_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
