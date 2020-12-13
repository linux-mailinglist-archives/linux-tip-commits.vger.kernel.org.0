Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912A82D8FDA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgLMTPV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392633AbgLMTDL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40FC0619DC;
        Sun, 13 Dec 2020 11:01:13 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9KmIG01WK2x+giseGK1prrPDVZzP4U/krLu+tFmYKWc=;
        b=TwDiVQ+Au0aulbQxNyk6NAXzIKYfvKXEsGoxMAzTWvWbh5LcSuSjYW8ef4MAa43+drBLcj
        qWc0ci3XplxFT4ifD9bo/WmTkGbJLAnU9IaciJ3uqBjumApMNhGJbiv8L5yyvQQ89IIl2/
        YY37XtF+3USETxXpkqZf56AxMLEDdq6BYfFapQ3N2gRLS81jDUm7hnHHTPbMAGR7IVxQQC
        312e6Iy0ZgNCKeixrTwgzhRAzvdN9CDAZoTQVc5dZpInLk5CfdtGEvo/YW4ZHrMDsg6LFP
        C17XG4HpvmNAFRyD8LMNoY1DfV9r3gsBd6Nr6C0RiHWbB951PL1DLFE/C+eygg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9KmIG01WK2x+giseGK1prrPDVZzP4U/krLu+tFmYKWc=;
        b=8pqAiuO1nE5CsEPw6HwnUGExGRlb3zvidtfwNNnMVQdSEdflknnWISe8w/EpapJudKvY0Y
        hGwb0nepJPtS0WBQ==
From:   "tip-bot2 for Hui Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs/rcu: Update the call_rcu() API
Cc:     Hui Su <sh_def@163.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607120.3364.15958072665237755984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c386e29d43728778ddd642fa73cc582bee684171
Gitweb:        https://git.kernel.org/tip/c386e29d43728778ddd642fa73cc582bee684171
Author:        Hui Su <sh_def@163.com>
AuthorDate:    Thu, 15 Oct 2020 22:13:34 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:02:43 -08:00

docs/rcu: Update the call_rcu() API

This commit updates the documented API of call_rcu() to use the
rcu_callback_t typedef instead of the open-coded function definition.

Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index fb3ff76..1a4723f 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
 In such cases, one uses call_rcu() rather than synchronize_rcu().
 The call_rcu() API is as follows::
 
-	void call_rcu(struct rcu_head * head,
-		      void (*func)(struct rcu_head *head));
+	void call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 This function invokes func(head) after a grace period has elapsed.
 This invocation might happen from either softirq or process context,
