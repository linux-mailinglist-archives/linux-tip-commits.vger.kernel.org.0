Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A718D3B83B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhF3Nug (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhF3NuJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506DC0617AF;
        Wed, 30 Jun 2021 06:47:38 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PhuD9PW3TG3wttnIyWeZQBpN27aUuVYqZRK9qnXCQlg=;
        b=TKnOklshc5pmwEZHMGMQ+L1RM2s5OqedD4w+uSAIzJtpSq+zl0gIJU8lDmtqo2RefdydHR
        rOEvazlk7yCbYzFEtEuH58sHZQyW1BWFBXGc5JAjVjHsOcSJd4dTfGlUqpAwbNt0ibla5m
        yL7wqVIXt7bjywP3L96+rXFKNoj2g7uQQjG1xAtFpqeEunADQDd2jSHXr3uGmQOcszQnZ4
        0BKXCGzRO29GemvFdgDCgOK7hEpdP5jQj0/YfEocxd0FhnJ5qugCNILhhCBd3C+MJTf3LQ
        NARmL6YsnioAOvaK0Z0e6QolKjoG2MTWA6ZOEjQU+4pvkJNDRAOAyfJRt6HGkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PhuD9PW3TG3wttnIyWeZQBpN27aUuVYqZRK9qnXCQlg=;
        b=sT1l+XE6/aOLHoii5BMQpx2fzGFhEZ+VwwMfjU26zBBLEqraL++jTp/bgsheUVWAc9JYr0
        jJZcULDIkLX32SBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add ->gp_max to show_rcu_gp_kthreads() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085592.395.3712727270659045004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     27ba76e164fc83ffe6ceeb0415c427ad1191af6c
Gitweb:        https://git.kernel.org/tip/27ba76e164fc83ffe6ceeb0415c427ad1191af6c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 04 Apr 2021 17:23:36 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Add ->gp_max to show_rcu_gp_kthreads() output

This commit adds ->gp_max to show_rcu_gp_kthreads() output in order to
better diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index fb47025..a4e2bb3 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -737,12 +737,13 @@ void show_rcu_gp_kthreads(void)
 	jr = j - data_race(rcu_state.gp_req_activity);
 	js = j - data_race(rcu_state.gp_start);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#lx ->rt_priority %u delta ->gp_start %lu ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_max %lu ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
 		rcu_state.gp_state, t ? t->state : 0x1ffffL, t ? t->rt_priority : 0xffU,
 		js, ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
+		data_race(rcu_state.gp_max),
 		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
