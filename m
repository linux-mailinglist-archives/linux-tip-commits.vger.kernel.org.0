Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB9319ED0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBLMlq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhBLMkT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:19 -0500
Date:   Fri, 12 Feb 2021 12:37:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B5y943xhxcIaOykd/IRQqACSQ8gR/z72yRvv2TcpBK8=;
        b=EwFUvG0vSYP3jGVTeDS4G5AlC6EX5lWhAbL+c1NC7XfBYZEtYbivX6tcqVTh9T1XdMVKMs
        92mvyyE9aVc9HclqT0Iptx6CX8C6w8w7875MxU5wfN3KP+xp/BD3NSH5kyDiQsVfMQHhjB
        gyioNfNonDJCPKpZcU+61oqyX7fW9cj6uHcnKYVrRV3zxqwf4JHOHqE+0VCq4wh4LI0svT
        Tf6vaV1lCVQX+ihhmQzzMMVaOzNqX7uFixqBSpME2VpRC8hkDTQcD/8sX0V1IIIA7y8kp+
        F2IC8x1oF8+W3bOBGtiYaOjEWgniY6eQ7x8VB59TTYeVCJ3AmTLjxjZA4AAtvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B5y943xhxcIaOykd/IRQqACSQ8gR/z72yRvv2TcpBK8=;
        b=CIk4onb5m0bzd4/ZeScJdQ1dUVXm2Xt3P/cyDmRX7HO0QQjp9/0v9dFySF0ql0w0mOtbL3
        IXFb7p9mfgcjphAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Don't deoffload an offline CPU with pending work
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343978.23325.4195127008923855203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ef005345e6e49859e225f549c88c985e79477bb9
Gitweb:        https://git.kernel.org/tip/ef005345e6e49859e225f549c88c985e79477bb9
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:20 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/nocb: Don't deoffload an offline CPU with pending work

Offloaded CPUs do not migrate their callbacks, instead relying on
their rcuo kthread to invoke them.  But if the CPU is offline, it
will be running neither its RCU_SOFTIRQ handler nor its rcuc kthread.
This means that de-offloading an offline CPU that still has pending
callbacks will strand those callbacks.  This commit therefore refuses
to toggle offline CPUs having pending callbacks.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1b870d0..b70cc91 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2227,6 +2227,15 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	printk("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * If there are still pending work offloaded, the offline
+	 * CPU won't help much handling them.
+	 */
+	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return -EBUSY;
+	}
+
 	rcu_segcblist_offload(cblist, false);
 
 	if (rdp->nocb_cb_sleep) {
