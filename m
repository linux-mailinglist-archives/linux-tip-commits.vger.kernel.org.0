Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED62342CA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgGaJX3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbgGaJX1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:27 -0400
Date:   Fri, 31 Jul 2020 09:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZG5b5Bc522c+MoOW4BJXPvTS+0ThLYJ9U9DTEsrVPHE=;
        b=nkz3FgaldZdrS2A1dtj8nrd5HF1JF9z7o5uA7zmYz/i0nwi5ly3Sn5fbQNzZklnsemDBly
        UxZPmgu70jzSMGKiu9ELflQxeLrjk42Ks2lnnxfSlog3qxsfRnH9CyXG1xgHIsdgYl1L0d
        kPhKU5kAI2WqmFabg4wzwLGV3A5WgplucK3+YouGWrvgAiZez1t6OD5OZ3U/X0tOr7fV5g
        MVdnohK5+GtDyIb0iJkTN/RP9NTatBgI3OeWqcsCDnHixDwsqgoXVZqnn5J6UW3Qkyxwc9
        LiDAxMUiQgeDeoluc/fWseVKYOUAjIAvdAGGDEAnBXlQ7XiT9YCVTy1jfk9iPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZG5b5Bc522c+MoOW4BJXPvTS+0ThLYJ9U9DTEsrVPHE=;
        b=7xf1e6NulzK0nfBy4dr6YXmhlMm0MVhdXC/dif4cervJhZHAOn5Oirz7A90FCy8M0xuf+q
        afxrNYENd6i7zWCQ==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix a kernel-doc warnings for "count"
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740523.4006.12597891813891208346.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e11690d2f5a9823d66f68918c3986b4e9e160ab
Gitweb:        https://git.kernel.org/tip/8e11690d2f5a9823d66f68918c3986b4e9e160ab
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 04 May 2020 14:35:00 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:24 -07:00

rcu: Fix a kernel-doc warnings for "count"

There are some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'

This commit therefore moves the comment for "count" to the kernel-doc
markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c6569e..ba4c477 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3004,6 +3004,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3019,7 +3020,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 
