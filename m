Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278731BB95
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBOO5F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBOO47 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3422C061794;
        Mon, 15 Feb 2021 06:55:46 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OjVWjq6gXeDPHDXjgjInSRgDTDPKt0ZTThByaLI6PvE=;
        b=D6l3Hi2/4SNhMR1DByys3Y6ouhp96WxyfZwO1qpAR01QC3Piwfg8CokOUj3HPOO3g/4vQQ
        kPIsEu/bZNhGJD9CuwSGgTlD0h8tugiN86XOMtBVpNLQXCE4b3Bj6MYA6uuLZRmLoKSRxp
        Ue2PZLZ6wJgU/Iq0/8n+AfHO44ncMzBcm97iUqXDKzFV6bQr75v9rztvfZHVO9P2/68VGc
        nIYzV869tWGyobF132SqR4zUUuJXk29bAIUEpFYPxTm9+xOdu+yATDZWWsVLuBU4QQnOdH
        ICfBW2Zp1cm67N99fZO/SWousdbfsGTn6e52tjhrV5/WgNo8TsAaAHqcmK/hbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OjVWjq6gXeDPHDXjgjInSRgDTDPKt0ZTThByaLI6PvE=;
        b=5csS7f1TBQ860VtP508JOfZwd9iOu2jEwFTqPcDpukjmZEWUTtg+qAoNgaP+2JdylkucM2
        FqQhiGtU7MmTcTBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Prepare for ->start_gp_poll and ->poll_gp_state
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094370.20312.3003706215276999562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fd56f64b4e3b9c53fbb12ef74c6f1f5fde4cc1c8
Gitweb:        https://git.kernel.org/tip/fd56f64b4e3b9c53fbb12ef74c6f1f5fde4cc1c8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 20:14:27 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:39 -08:00

rcutorture: Prepare for ->start_gp_poll and ->poll_gp_state

The new get_state_synchronize_srcu(), start_poll_synchronize_srcu() and
poll_state_synchronize_srcu() functions need to be tested, and so this
commit prepares by renaming the rcu_torture_ops field ->get_state to
->get_gp_state in order to be consistent with the upcoming ->start_gp_poll
and ->poll_gp_state fields.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 528ed10..bcea23c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -311,7 +311,7 @@ struct rcu_torture_ops {
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
-	unsigned long (*get_state)(void);
+	unsigned long (*get_gp_state)(void);
 	void (*cond_sync)(unsigned long oldstate);
 	call_rcu_func_t call;
 	void (*cb_barrier)(void);
@@ -461,7 +461,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.deferred_free	= rcu_torture_deferred_free,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-	.get_state	= get_state_synchronize_rcu,
+	.get_gp_state	= get_state_synchronize_rcu,
 	.cond_sync	= cond_synchronize_rcu,
 	.call		= call_rcu,
 	.cb_barrier	= rcu_barrier,
@@ -1050,10 +1050,10 @@ rcu_torture_writer(void *arg)
 	/* Initialize synctype[] array.  If none set, take default. */
 	if (!gp_cond1 && !gp_exp1 && !gp_normal1 && !gp_sync1)
 		gp_cond1 = gp_exp1 = gp_normal1 = gp_sync1 = true;
-	if (gp_cond1 && cur_ops->get_state && cur_ops->cond_sync) {
+	if (gp_cond1 && cur_ops->get_gp_state && cur_ops->cond_sync) {
 		synctype[nsynctypes++] = RTWS_COND_GET;
 		pr_info("%s: Testing conditional GPs.\n", __func__);
-	} else if (gp_cond && (!cur_ops->get_state || !cur_ops->cond_sync)) {
+	} else if (gp_cond && (!cur_ops->get_gp_state || !cur_ops->cond_sync)) {
 		pr_alert("%s: gp_cond without primitives.\n", __func__);
 	}
 	if (gp_exp1 && cur_ops->exp_sync) {
@@ -1119,7 +1119,7 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_COND_GET:
 				rcu_torture_writer_state = RTWS_COND_GET;
-				gp_snap = cur_ops->get_state();
+				gp_snap = cur_ops->get_gp_state();
 				i = torture_random(&rand) % 16;
 				if (i != 0)
 					schedule_timeout_interruptible(i);
