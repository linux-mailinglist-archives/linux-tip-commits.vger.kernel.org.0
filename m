Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B583B83ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhF3NvW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhF3Nud (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:33 -0400
Date:   Wed, 30 Jun 2021 13:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JGegXUPtGa1Jh8UBfprANxcZAQlbR/N5lpNifDBISzc=;
        b=rcyVwcSEFhYt0T6zuOp0ZKgKfUQF7SHk5ar0DTfpU/MnRtd/ITcBmGDm4ZvchtIkwIoDDZ
        CAoaaaqOPHWTexAqdd9B2LBJE3r3hJSKoRR1ibUqetrYj6DmKho/lHZq2EMIW18fnft3V8
        EaHVuES0Uz2wMrhGKyQE1EXh742muo5GtRJtT9AFTPBqJVWkqlusZUXoDtWZ2S2uI65znb
        wGA+nW6lU3md8u9khlHxzIiFzG7w5x1DfIej3BjBRTZbWBWa56s+dGrgzAgOzTOhpaheb7
        qegKPch68GjiXRCXIpO0epNzt38pxOMPPbD43869848Bvt1zxAbE2SREPR2iGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JGegXUPtGa1Jh8UBfprANxcZAQlbR/N5lpNifDBISzc=;
        b=atCMj7kjHa5+UPyiSaL1cmmMULqY4Mqynxni32VPb2tCjPPBR2Hs2emJGcVPN1IyYdfH7u
        eXsFOfei02wgz4Bw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Unconditionally embed struct lockdep_map
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087330.395.6265963103755920622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7bf0a6141ab9c1d113bd85d6d13d43903a4278ba
Gitweb:        https://git.kernel.org/tip/7bf0a6141ab9c1d113bd85d6d13d43903a4278ba
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 09 Apr 2021 00:38:58 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:03:35 -07:00

srcu: Unconditionally embed struct lockdep_map

Since struct lockdep_map has zero size when CONFIG_DEBUG_LOCK_ALLOC=n,
this commit removes the #ifdef from the srcu_struct structure's ->dep_map.
This change will simplify further manipulations of this field.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a..cb1f435 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -82,9 +82,7 @@ struct srcu_struct {
 						/*  callback for the barrier */
 						/*  operation. */
 	struct delayed_work work;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
