Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6131BB84
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBOO4c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBOO4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972DC061786;
        Mon, 15 Feb 2021 06:55:44 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IV57XUPMn5cZuH2sSysfEKGHAfTdnmnXn1C0D+ktRi8=;
        b=L1tXQGXhHXbxt8+Xin1VwIt4xlv/k8KYHkR1SOysA+dWQvmx6JOoBwPEIXxaxQVQfj09Ha
        ebnBkd4diH8dawCrMC2VPxmnfAUP3E2QaEqbYfKvdXJgiQW+FOh3Uvf33rduwM7vfEWPdx
        Sfq9OlcYd9JlJ9hy8XFOxbqXU4LEAhy4n3k+aZhR+FAaNf9Tn0GzXinJPMcDgm2CU+WNNL
        4ctFSBpyQs0vjZmT42o9/jMCa/6OuDnUTKpXacdwdbqvQPSrhXfPa7dIm8rmbp9YJqDCLN
        3xXoSHvDPBePsqShEhuTyR+fPnOVeaFqCO78fN93uI+t1kThWAnx6hYRSJGKfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IV57XUPMn5cZuH2sSysfEKGHAfTdnmnXn1C0D+ktRi8=;
        b=8MozNt46yap/08F1mXS6xdoH0087lOsruqlxIXK18gutEOmVp73+v1CdirBGQxqqazP2iM
        HnlUqA/LyXpK8ACg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark obtuse portion of stall warning as internal debug
Cc:     Jonathan Lemon <bsd@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094231.20312.16236811170512592253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b08ea1de6a8f8929c7dafd6f708799365fa90c11
Gitweb:        https://git.kernel.org/tip/b08ea1de6a8f8929c7dafd6f708799365fa90c11
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 06 Nov 2020 13:52:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:54:40 -08:00

rcu: Mark obtuse portion of stall warning as internal debug

There is a rather obtuse string that can be printed as part of an
expedited RCU CPU stall-warning message that starts with "blocking
rcu_node structures".  Under normal conditions, most of this message
is just repeating the list of CPUs blocking the current expedited grace
period, but in a manner that is rather difficult to read.  This commit
therefore marks this message as "(internal RCU debug)" in an effort to
give people the option of avoiding wasting time attempting to extract
nonexistent additional meaning from this portion of the message.

Reported-by: Jonathan Lemon <bsd@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8760b6e..6c6ff06 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -545,7 +545,7 @@ static void synchronize_rcu_expedited_wait(void)
 			data_race(rnp_root->expmask),
 			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
-			pr_err("blocking rcu_node structures:");
+			pr_err("blocking rcu_node structures (internal RCU debug):");
 			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
