Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A3388A19
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbhESJEq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 05:04:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbhESJDy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 05:03:54 -0400
Date:   Wed, 19 May 2021 09:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621414954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yb8ZYW1po+hNHnzM2OhChBEB04WKGy1knQGPHvMmjvM=;
        b=xtATJ259YV3bqw1zc0J4ilF4e0oVpOogT2QXedfXzKU/tVqVoFGD2DS1jBGh5+G/nbM/Ie
        DuugFimpJm0IrKZ3HbaIRAz8PIbR4B5Sw8J+4gGd6Wdk4v4oc+lMHBgdv4Wlbqf0Y6OR7E
        iN0plXxXx636HgMqxnyKhxw2MwYrjjZ+CRA4Cf9QejGS2n88iSANNtOxkzG055/6/IksqJ
        Wqg8jHuLhr9DdCZsVijzFevivA/yjUYlePMn14UoeMQ5KmSazRznzM47EOP3fYDntIY4wo
        iVydtxt7ArtOgNIcHdXPVwvOkKcvN2ibssWPUr7P7ntncU1BTtN9nPeHZkU/+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621414954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yb8ZYW1po+hNHnzM2OhChBEB04WKGy1knQGPHvMmjvM=;
        b=CPcbpkl7+uKVuvcpgGrA8VRF7JNZarLa7g7/lepbEU6obT+iWGtkyEKQ+XafibiUYSAOQx
        gaJQyPv2rHXgxxBQ==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix locking around cpu_util_update_eff()
Cc:     Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510145032.1934078-3-qais.yousef@arm.com>
References: <20210510145032.1934078-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <162141495356.29796.14241444686990774584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     93b73858701fd01de26a4a874eb95f9b7156fd4b
Gitweb:        https://git.kernel.org/tip/93b73858701fd01de26a4a874eb95f9b7156fd4b
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 10 May 2021 15:50:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 19 May 2021 10:53:02 +02:00

sched/uclamp: Fix locking around cpu_util_update_eff()

cpu_cgroup_css_online() calls cpu_util_update_eff() without holding the
uclamp_mutex or rcu_read_lock() like other call sites, which is
a mistake.

The uclamp_mutex is required to protect against concurrent reads and
writes that could update the cgroup hierarchy.

The rcu_read_lock() is required to traverse the cgroup data structures
in cpu_util_update_eff().

Surround the caller with the required locks and add some asserts to
better document the dependency in cpu_util_update_eff().

Fixes: 7226017ad37a ("sched/uclamp: Fix a bug in propagating uclamp value in new cgroups")
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210510145032.1934078-3-qais.yousef@arm.com
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f97eb73..3ec420c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9507,7 +9507,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
 	cpu_util_update_eff(css);
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 #endif
 
 	return 0;
@@ -9597,6 +9601,9 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	enum uclamp_id clamp_id;
 	unsigned int clamps;
 
+	lockdep_assert_held(&uclamp_mutex);
+	SCHED_WARN_ON(!rcu_read_lock_held());
+
 	css_for_each_descendant_pre(css, top_css) {
 		uc_parent = css_tg(css)->parent
 			? css_tg(css)->parent->uclamp : NULL;
