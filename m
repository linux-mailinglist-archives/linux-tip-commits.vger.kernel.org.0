Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CF35B506
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhDKNou (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DgISDbyozpVfVVVqaknfqQ1EiVOVf5Th5FeX4zTgq6Q=;
        b=i8YxOLJHhTXR7r876+K0mkYShrcA4e5AbKAtgo9MDcW8djNOfb4p1GgeIVsz9aQCisNL7s
        mB8QE2FbwgNH6ETLLFrXqL5lTtwSSerJd9YmiObu2ksPZ8Yk/VzWp1t4hV/7gr9qwWoGCd
        dD8eODRL0HSA2TZOmcKY1O9lnLU+/EIKnEZgnvS84BUiBPc4LeJCsDbmam2/yTKfZeuuyN
        H8YgKiXD9wUhbfZ5++4xaT9KZXQ//2SNoqgFe+zNTKEnSj4ek9Cq03vafRqBOdQ0OWIAVp
        aioL7fUY5ln9z+Fa7n9KLXbm9lkdP0x4JUU6RYGF8JqBu1G2z9bQCGR86hQYZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DgISDbyozpVfVVVqaknfqQ1EiVOVf5Th5FeX4zTgq6Q=;
        b=b4JS9FKZVXKWahIRY4lBte0HpkzSBfDg5bQLK8I7aKHmJTSGEfATkTWm7R8oeL7vj2lYoF
        /F4laxrbHnXQQSAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: Correctly spell Stephen Hemminger's name
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860804.29796.8948891830574155504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e589c7c72315f7e52ebb5cffc19615dc18d0cc50
Gitweb:        https://git.kernel.org/tip/e589c7c72315f7e52ebb5cffc19615dc18d0cc50
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 10:07:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:53:24 -07:00

docs: Correctly spell Stephen Hemminger's name

This commit replaces "Steve" with the his real name, which is "Stephen".

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/RTFP.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 3b0876c..588d973 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -847,7 +847,7 @@ Symposium on Distributed Computing}
 	'It's entirely possible that the current user could be replaced
 	by RCU and/or seqlocks, and we could get rid of brlocks entirely.'
 	.
-	Steve Hemminger responds by replacing them with RCU.
+	Stephen Hemminger responds by replacing them with RCU.
 }
 }
 
