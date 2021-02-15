Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8431BBAD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBOO6C (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhBOO5k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6ECC061225;
        Mon, 15 Feb 2021 06:55:56 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tvAYExzlABIjgfQ9s7hIesA0XOd0AZTF9UZx8yJJX20=;
        b=u94kZEcyrqwCZcPf9lJJmeaIeIaGz7chIEPssPKHESTAMJ1h3qKqUOsGMgT/BNkZfNKwXm
        CX2zWvahaSLUqwGEL0YHjDaVXu96CGTj57fyIEhY5Q1JmO7Tx23MXOtrFJlS/0lOR4ks4d
        LhFLT1yAIWJestYpr71qYmk2xzybY0hFY/joOAvgL02ev49HvcO9fGaM6nKrVV5HNbH0ly
        PYvSE34/j7BnpvTM5hPegiCNG3ykF/3zeuFuPELf79TkyFc3R1xHbwxXoK6WhVuMzf+DYx
        FW8ZP9K9+KZcindZeJnfA02DjnSt54J1jI9+0dJ7DsqPfhyTJVul9E/nC+z+sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400955;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tvAYExzlABIjgfQ9s7hIesA0XOd0AZTF9UZx8yJJX20=;
        b=Aat8oZ7/4Z66u5mdEBRFVcivO0h8CydFWM0n68q4KUjnCie+A8GNjY44XgYycD1b7stJJA
        iahFQg6mIHBtdFDg==
From:   "tip-bot2 for Akira Yokosawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Fix typo in klitmus7
 compatibility table
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340095483.20312.5950740507941559256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3d5c70329b910ab583673a33e3a615873c5d4115
Gitweb:        https://git.kernel.org/tip/3d5c70329b910ab583673a33e3a615873c5d4115
Author:        Akira Yokosawa <akiyks@gmail.com>
AuthorDate:    Sat, 28 Nov 2020 14:32:15 +09:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:40:50 -08:00

tools/memory-model: Fix typo in klitmus7 compatibility table

klitmus7 of herdtools7 7.48 or earlier depends on ACCESS_ONCE(),
which was removed in Linux v4.15.
Fix the obvious typo in the table.

Fixes: d075a78a5ab1 ("tools/memory-model/README: Expand dependency of klitmus7")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 39d08d1..9a84c45 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -51,7 +51,7 @@ klitmus7 Compatibility Table
 	============  ==========
 	target Linux  herdtools7
 	------------  ----------
-	     -- 4.18  7.48 --
+	     -- 4.14  7.48 --
 	4.15 -- 4.19  7.49 --
 	4.20 -- 5.5   7.54 --
 	5.6  --       7.56 --
