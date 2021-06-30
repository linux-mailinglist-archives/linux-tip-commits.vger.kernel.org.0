Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E03B8416
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhF3NwP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhF3Nuz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:55 -0400
Date:   Wed, 30 Jun 2021 13:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PId7N3c6aVci1DOiP7PJLof6lmB5DqlaK03nPI4wWlA=;
        b=Z+rpuoh8YTD9rz1TAAUx/9bWa0MAMueZsIEC+yt4OWIa1jh+yNT8SqOQO/7b/M5yTffENR
        FUUo3IPynvmAT74+bPWV/WeoiwLZkv2fsUBkxcTatkzSpz5xBKFrQRSfbJwY2tzNej8OLu
        du3pjR3xpMC7/FJMjnVpU+6yxe4l6EsiMDvIJvtqobeRK10wP60R53Fwl3iFDYf72skqfl
        ldRtp8LbtgB1wkio6/k2NTM4Bvs/2qsXL2BnIz21KmAPBggZpXwonfZzmuSHz2lz7RL5em
        5tNkQCcw0J82JjrrwGkdDgNENawg5A3QfhfUK421g/vZQwa08hLIp32GJSRq3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PId7N3c6aVci1DOiP7PJLof6lmB5DqlaK03nPI4wWlA=;
        b=wTImqG84b/gl+VyploMqZqs51s40pdYy4+me2h2/rj6XHzLYYcyp+GNo4RrWNDXmxgRHlO
        uGlyw0HowlzHhUDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Fix diagram references in memory-ordering document
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088167.395.18116715355997551648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     58d0db869d7ab8ca97b521f167022caa2c42cbe7
Gitweb:        https://git.kernel.org/tip/58d0db869d7ab8ca97b521f167022caa2c42cbe7
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 04 Apr 2021 23:58:43 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 15:39:19 -07:00

doc: Fix diagram references in memory-ordering document

The three diagrams describing rcu_gp_init() all spuriously refer to
the same figure, probably due to a copy/paste issue.  This commit fixes
these references.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 3f6ce41..11cdab0 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -339,14 +339,14 @@ The diagram below shows the path of ordering if the leftmost
 leftmost ``rcu_node`` structure offlines its last CPU and if the next
 ``rcu_node`` structure has no online CPUs).
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-2.svg
 
 The final ``rcu_gp_init()`` pass through the ``rcu_node`` tree traverses
 breadth-first, setting each ``rcu_node`` structure's ``->gp_seq`` field
 to the newly advanced value from the ``rcu_state`` structure, as shown
 in the following diagram.
 
-.. kernel-figure:: TreeRCU-gp-init-1.svg
+.. kernel-figure:: TreeRCU-gp-init-3.svg
 
 This change will also cause each CPU's next call to
 ``__note_gp_changes()`` to notice that a new grace period has started,
