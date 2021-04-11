Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C535B4FF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhDKNoh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhDKNoL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:11 -0400
Date:   Sun, 11 Apr 2021 13:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dGWWAORguxa4h5lXqal4e2aa8jLebL0KJIB54jJaRF8=;
        b=fxuCfdSc8tq6EDKDzsesmAYrB/QmEtDoa5GmZUGU7tknpGI2PK3FvG6htADdL5bvR/mW9w
        rIKLBZy1KCZyQZJ6ZWQwima6HDjcf2+E1N+Eu5Hn2QXmkOinbsEtKspGwGztKYHGjOwYFd
        glIKZiWGg2tV636zB5Ay4N2DwPqCzFkDwwcRk49EtiWi7mKYQYmZ+meRI/N1/b2+KzbnbL
        iojhDh30wF1/m9EZIclhBsEinKZbl5nhSMM56VRiGq5SydN3rJ4K53aZzMJtPZLWKZuiFr
        wbw/klwlvk8aFSj5U2zuUKynChm9c+vW+xiSCx3pfwMBU0mSQ0+K2s4EjIZpxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dGWWAORguxa4h5lXqal4e2aa8jLebL0KJIB54jJaRF8=;
        b=wrSXn8TrfQK4TYxh7ybMslfKL5TsG3Tcu7iQw3zUI5YCdkZ0RZ62DiYIwlrjRwsbD1tdS2
        ImdIA83HbTrdhQBQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Comment the reason behind BH disablement on
 batch processing
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861776.29796.17700596811464501186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5de2e5bb80aeef82f75fff76120874cdc86f935d
Gitweb:        https://git.kernel.org/tip/5de2e5bb80aeef82f75fff76120874cdc86f935d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 18:12:08 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:20:20 -08:00

rcu/nocb: Comment the reason behind BH disablement on batch processing

This commit explains why softirqs need to be disabled while invoking
callbacks, even when callback processing has been offloaded.  After
all, invoking callbacks concurrently is one thing, but concurrently
invoking the same callback is quite another.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index cd513ea..013142d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2235,6 +2235,12 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
 	local_irq_restore(flags);
+	/*
+	 * Disable BH to provide the expected environment.  Also, when
+	 * transitioning to/from NOCB mode, a self-requeuing callback might
+	 * be invoked from softirq.  A short grace period could cause both
+	 * instances of this callback would execute concurrently.
+	 */
 	local_bh_disable();
 	rcu_do_batch(rdp);
 	local_bh_enable();
