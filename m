Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358635B512
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhDKNpH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhDKNoY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:24 -0400
Date:   Sun, 11 Apr 2021 13:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WTgSFNQefqcb61hl48UGhbOlRf6u40fyx7eKv92cHzs=;
        b=CIOD10dd+sYdM8PkqWtcQc+pbuag27j9AyYZfUfNHRVW9wVIeI6z/gm+X7rt6L/ljiyVD6
        Atemy+atOwh4wE3mC9sWt1iLElNfD9fggJQnvVuSInWmY1KqiJUG1xEPU6Aa4UAECgJIav
        3/Ic1fy8S7cRDPVEVqvk7oSzPrDwYJnrGV+HOoaDhjsNZr0pbjYcickbrUqfitHnOngiH4
        AK1wAPQ2vRn5H2vIxW7N2WNzIgkJPgmHJcDN2IPdiB0jfNrG3P4btK8PsaaAYPV2uCYT4y
        X/MhI4WxM5ZzHBwiMyGp3fRTVvx7iEDN8JwVWKvBud6I/lDS23yMdqwTzqaHAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WTgSFNQefqcb61hl48UGhbOlRf6u40fyx7eKv92cHzs=;
        b=LzQwOfIAv4QhE9JCHnmu1e0EiEK8ZERsEvbSfdPBKd671Kch+amdzhZ5FcV0konALeEd62
        GtopLls4OoB5VrCQ==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862005.29796.16755031446905945595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3e7ce7a187fc6aaa9fda1310a2b8da8770342ff7
Gitweb:        https://git.kernel.org/tip/3e7ce7a187fc6aaa9fda1310a2b8da8770342ff7
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Fri, 29 Jan 2021 17:16:03 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

kvfree_rcu: Replace __GFP_RETRY_MAYFAIL by __GFP_NORETRY

__GFP_RETRY_MAYFAIL can spend quite a bit of time reclaiming, and this
can be wasted effort given that there is a fallback code path in case
memory allocation fails.

__GFP_NORETRY does perform some light-weight reclaim, but it will fail
under OOM conditions, allowing the fallback to be taken as an alternative
to hard-OOMing the system.

There is a four-way tradeoff that must be balanced:
    1) Minimize use of the fallback path;
    2) Avoid full-up OOM;
    3) Do a light-wait allocation request;
    4) Avoid dipping into the emergency reserves.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7ee83f3..0ecc1fb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3517,8 +3517,20 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
+
+			// __GFP_NORETRY - allows a light-weight direct reclaim
+			// what is OK from minimizing of fallback hitting point of
+			// view. Apart of that it forbids any OOM invoking what is
+			// also beneficial since we are about to release memory soon.
+			//
+			// __GFP_NOMEMALLOC - prevents from consuming of all the
+			// memory reserves. Please note we have a fallback path.
+			//
+			// __GFP_NOWARN - it is supposed that an allocation can
+			// be failed under low memory or high memory pressure
+			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC | __GFP_NOWARN);
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			*krcp = krc_this_cpu_lock(flags);
 		}
 
