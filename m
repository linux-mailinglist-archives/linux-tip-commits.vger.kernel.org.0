Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B53B8415
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhF3NwN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhF3NvB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:01 -0400
Date:   Wed, 30 Jun 2021 13:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a2T+qRdK0Xd4jdQuT/dPWYP9T+ayeG1xZI1aZxt/BbY=;
        b=e2x5ZIdlCNDiUxEv5dcyWkk65Rz4pZG9IEVaVWxbXLG34on6G27kvUR6D71HheX8e5qidQ
        ynVHt9ddoNJCTq+Oe/02JovZlE9ogFr+ZwsrISnoN3hd1wNU+mslNfvinKuCEX91sBoesg
        20T9jCUM+rfTeCb2XZF1LY+dhkiKlf3n/L4zvI+5r+xOaNs8ZHNSgJB3KCyg9w3UWk8wNj
        4bsfKl97lTri/nQa7Mc16n+JMHo/uLtN6lkKVcLVAXUqrUtjJcciOjRou9b+Zy6uB60dh9
        nflEnWM9MJ7U4dhsadz0IksSYu3mtOXcIrDbLf19v89JxyWs4BGG4g9zDLjw6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a2T+qRdK0Xd4jdQuT/dPWYP9T+ayeG1xZI1aZxt/BbY=;
        b=Ek6PrVeu/qxYVJf6qHjGrpz/bJ4UgNLs0kllbaUaaJ+U8gy1NCLtngwC9pVWhzn+OHtfx8
        oy67db3KfRxGqJDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Fix statement of RCU's memory-ordering requirements
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088217.395.3988897726479509107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     18389c4570211e10e94f4a2ce907d01397abc335
Gitweb:        https://git.kernel.org/tip/18389c4570211e10e94f4a2ce907d01397abc335
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 19 Mar 2021 16:30:15 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:39:19 -07:00

doc: Fix statement of RCU's memory-ordering requirements

The sentence defining the relationship of accesses before a grace
period to read-side accesses following that same grace period was
missing a small word: "not".  This commit therefore adds it.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index a648b42..3f6ce41 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -21,7 +21,7 @@ Any code that happens after the end of a given RCU grace period is guaranteed
 to see the effects of all accesses prior to the beginning of that grace
 period that are within RCU read-side critical sections.
 Similarly, any code that happens before the beginning of a given RCU grace
-period is guaranteed to see the effects of all accesses following the end
+period is guaranteed to not see the effects of all accesses following the end
 of that grace period that are within RCU read-side critical sections.
 
 Note well that RCU-sched read-side critical sections include any region
