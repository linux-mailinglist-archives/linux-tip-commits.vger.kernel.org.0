Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFF2D8FDB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgLMTPc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392540AbgLMTDK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95ABC0619D9;
        Sun, 13 Dec 2020 11:01:11 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CXEJ3UCKMWUK6DyOdxLR80cNXuH5ztk+q7Xk2Ru9cKQ=;
        b=AEhRnXgrStGlGzi74izyUwuEe5P7s1XxC9mogpcXct7+my9xy5TBxaspXjE/PyqWBDicxL
        pVKSnt7InUyOC1J4ASN7IEXbJ2MV16ToOTVTQkonbmDD2Vjh2bqyM31DpgJosGM5WhOrhg
        VIz7sov8Axi7K/YG+DSKUVtOGfSanoaXBhPDP4puzt8saLccOlQnmbxNp/8wuF6PTch0ck
        0J6rmIn0GIKobVH0fKm1Uq3zCe+gypP2HQwSM39h2VIKyP1rW8dnLw1rG+UlKb27OdbfNT
        d6fjvzQ1sa+xDstVEFfgemTfH+Ee7SULGCE5EN7I7i8eZmcQjUkx3GSOjClcBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CXEJ3UCKMWUK6DyOdxLR80cNXuH5ztk+q7Xk2Ru9cKQ=;
        b=1lKDv8Y8qGY8ANlKy3+ngU3DF7LooQwkvSBAu1fg+1qXJd8ttnqZ4UdeEwhodovBwCO0nY
        OG7OWt2lfPsPRUCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Exclude "NOHZ tick-stop error" from fatal errors
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607005.3364.12398742029299837707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8d68e68a781db80606c8e8f3e4383be6974878fd
Gitweb:        https://git.kernel.org/tip/8d68e68a781db80606c8e8f3e4383be6974878fd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 10:10:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:50 -08:00

torture: Exclude "NOHZ tick-stop error" from fatal errors

The "NOHZ tick-stop error: Non-RCU local softirq work is pending"
warning happens frequently and appears to be irrelevant to the various
torture tests.  This commit therefore filters it out.

If there proves to be a need to pay attention to it a later commit will
add an "advice" category to allow the user to immediately see that
although something happened, it was not an indictment of the system
being tortured.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 0e4c0b2..80ae7f0 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -13,4 +13,5 @@
 egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console'
+grep -v 'Warning: unable to open an initial console' |
+grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
