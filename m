Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A480E35B4B5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhDKNoC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhDKNn5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E9C061574;
        Sun, 11 Apr 2021 06:43:26 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1QUHtVmlFXjOkxj1y63PXJ4LjTRWS7UDXTsiJVceZD4=;
        b=ObZY4e2SFRm3Vm+t9DXd7kUTTUNP/qfCdcaajKyNnVrHFEPHLL3cU0U49a6ICsVnmqn5Bs
        dq80y9fKslFbh/VXB8Kh8IBvcBz1XU0GweePajPpTDgqn6vuVDU7atRu3PEOydx2hIKogM
        PPt7EjpwOor0unqKYBtrd2PV8mMNIEphuWRo+PmMz3vgIkdr2wd9z1bTcgzQxKEzLZGbxf
        Y+t7Y8S70QUbFk0AHbYutSLfZLxRwdPlq4+wrMLnUiTHkPGJPhl6aTWb/klPzqMvKXmb+9
        eBikvaB2JEkgTlyYy+cYw+oTb4FSGYTN229uhOgaZAnWYODlRJII0olNlJiPIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1QUHtVmlFXjOkxj1y63PXJ4LjTRWS7UDXTsiJVceZD4=;
        b=XPMoAQSXPm5qUd32wmbm0wD7SIbB5b5WmCXQB4eBwia7RliD86jKHjI9VC1EI7fMPEZiPZ
        LdggpzIIAFdTYqDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Test start_poll_synchronize_rcu() and
 poll_state_synchronize_rcu()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859796.29796.9127729573091517038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7ac3fdf099bf784794eb944e0ba5bb69867ca06d
Gitweb:        https://git.kernel.org/tip/7ac3fdf099bf784794eb944e0ba5bb69867ca06d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 25 Feb 2021 20:56:10 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 24 Mar 2021 17:17:38 -07:00

rcutorture: Test start_poll_synchronize_rcu() and poll_state_synchronize_rcu()

This commit causes rcutorture to test the new start_poll_synchronize_rcu()
and poll_state_synchronize_rcu() functions.  Because of the difficulty of
determining the nature of a synchronous RCU grace (expedited or not),
the test that insisted that poll_state_synchronize_rcu() detect an
intervening synchronize_rcu() had to be dropped.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 99657ff..956e6bf 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -494,6 +494,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
 	.get_gp_state	= get_state_synchronize_rcu,
+	.start_gp_poll	= start_poll_synchronize_rcu,
+	.poll_gp_state	= poll_state_synchronize_rcu,
 	.cond_sync	= cond_synchronize_rcu,
 	.call		= call_rcu,
 	.cb_barrier	= rcu_barrier,
@@ -1223,14 +1225,6 @@ rcu_torture_writer(void *arg)
 				WARN_ON_ONCE(1);
 				break;
 			}
-			if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
-				WARN_ONCE(rcu_torture_writer_state != RTWS_DEF_FREE &&
-					  !cur_ops->poll_gp_state(cookie),
-					  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
-					  __func__,
-					  rcu_torture_writer_state_getname(),
-					  rcu_torture_writer_state,
-					  cookie, cur_ops->get_gp_state());
 		}
 		WRITE_ONCE(rcu_torture_current_version,
 			   rcu_torture_current_version + 1);
@@ -1589,7 +1583,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_enable();
 	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
 		WARN_ONCE(cur_ops->poll_gp_state(cookie),
-			  "%s: Cookie check 3 failed %s(%d) %lu->%lu\n",
+			  "%s: Cookie check 2 failed %s(%d) %lu->%lu\n",
 			  __func__,
 			  rcu_torture_writer_state_getname(),
 			  rcu_torture_writer_state,
