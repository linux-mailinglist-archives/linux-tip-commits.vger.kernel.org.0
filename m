Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC54547F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhKQODp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhKQODD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:03:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04EC061570;
        Wed, 17 Nov 2021 06:00:04 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frxuyTMg+vCaQ3cywi+PNgr9/7OpA2DHIc4fXDJGQDo=;
        b=YuR+K9D/cgTmrbY/EN2gJST0kDcqwEPKOfcd9hh+LzjGai9vNil7ZEt8ABQazKrn0cV3H7
        EoFWckF6UMESXQljaFvTV4FfgCmgBSIIm624mglKAGnZQTv+OndTxP0mX5PbEWzCmvG7Xm
        O8FhcTMA6RoO/ZSB8cBT/UuwT444TMXWn5MPcd4UjpG4CzufHHs/64onkjFF/7jUnWbHtk
        2xhW2cvrTc34d5c0A5CzbfwjCIM5L2RdZzsinYZhIdOGXivZhgCeOh/IWcTozEArXRCOg3
        ZdfW0vaMmCNgA2m8aqnrQKDPrIuy9BljilogD2pihSD1c5yuZrnrmDfyGJst7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frxuyTMg+vCaQ3cywi+PNgr9/7OpA2DHIc4fXDJGQDo=;
        b=cagnvt1XxSpUkWGITyOPCRLlBYDDOnLMgQG8MB15PHB73T3yP7rBJbF8c1wSu1o2MWo705
        mYgYDs+L0SZUolCw==
From:   "tip-bot2 for Liu Xinpeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Remove repeated verbose comment
Cc:     Liu Xinpeng <liuxp11@chinatelecom.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
References: <1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Message-ID: <163715760175.11128.17366057120414556532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2d3791f116bb3d5b17571dadb8e085e12ae3a3cf
Gitweb:        https://git.kernel.org/tip/2d3791f116bb3d5b17571dadb8e085e12ae3a3cf
Author:        Liu Xinpeng <liuxp11@chinatelecom.cn>
AuthorDate:    Mon, 25 Oct 2021 11:46:25 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:59 +01:00

psi: Remove repeated verbose comment

Comment in function psi_task_switch,there are two same lines.
...
* runtime state, the cgroup that contains both tasks
* runtime state, the cgroup that contains both tasks
...

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/1635133586-84611-1-git-send-email-liuxp11@chinatelecom.cn
---
 kernel/sched/psi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..526af84 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -833,7 +833,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		/*
 		 * When switching between tasks that have an identical
 		 * runtime state, the cgroup that contains both tasks
-		 * runtime state, the cgroup that contains both tasks
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
