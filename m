Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6F31BB8D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBOO4n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhBOO4a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:30 -0500
Date:   Mon, 15 Feb 2021 14:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UaAPfSK2rL+Cg+mAZXiQwYXpjewfmbhsE03uaFWbZEQ=;
        b=YQtmhpjitkN3cnuDPB8YztgsD7VC9dafxOKhR7g0p9Fhnfwccv4becdbis+qOBP8P2uL77
        aNkC10GTphVb9ojY/U4/t3EQUuudydQg5K2KKaFUx/7s39IJsojwL498sZcrFnvnI2QMYd
        Mv16J0Atmp6s4uXXOzBClujg+bPHxG9vYcrmsjaBXSVCZXkTYWxK3oaDgCVUZPh5So9+sk
        GXyMzd7j6Uc+Qd6uZeUtv8AvTT/4uFxxOqriM9Jfk+V0yO1N5EQ8gwYlbEs4UAe4XJW0nC
        /Rd2yav6tekIgmY9060h6rVC9yKaveMyvjJnV5iZxMfQ7AR9GCaMQ8yvw3yIEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UaAPfSK2rL+Cg+mAZXiQwYXpjewfmbhsE03uaFWbZEQ=;
        b=151HM5plhNcvMy7wMAeinuRHOVr36wgtqLicbYeoLcUWwJCfYOu55aXL00NWPfV+T7uAvf
        d+o31ZwPS0G7mUDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Update RCU requirements RCU_INIT_POINTER() description
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094765.20312.11662112524491072594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d756c74e6f6e76e99f8bffcea57833816dd335b6
Gitweb:        https://git.kernel.org/tip/d756c74e6f6e76e99f8bffcea57833816dd335b6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 09 Dec 2020 16:54:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:35:15 -08:00

doc: Update RCU requirements RCU_INIT_POINTER() description

Back in the day, RCU_INIT_POINTER() was the only way to avoid
memory-barrier instructions while storing NULL to an RCU-protected
pointer.  Fortunately, in 2016, rcu_assign_pointer() started checking for
compile-time NULL pointers and omitting the memory-barrier instructions in
that case.  Unfortunately, RCU's Requirements.rst document was not updated
accordingly.  This commit therefore at long last carries out that update.

Fixes: 3a37f7275cda ("rcu: No ordering for rcu_assign_pointer() of NULL")
Link: https://lore.kernel.org/lkml/20201209230755.GV7338@casper.infradead.org/
Reported-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f32f8fa..65c7839 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1668,8 +1668,7 @@ against mishaps and misuse:
    this purpose.
 #. It is not necessary to use rcu_assign_pointer() when creating
    linked structures that are to be published via a single external
-   pointer. The RCU_INIT_POINTER() macro is provided for this task
-   and also for assigning ``NULL`` pointers at runtime.
+   pointer. The RCU_INIT_POINTER() macro is provided for this task.
 
 This not a hard-and-fast list: RCU's diagnostic capabilities will
 continue to be guided by the number and type of usage bugs found in
