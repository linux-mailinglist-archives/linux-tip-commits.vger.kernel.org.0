Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48182D8FFA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgLMTUY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390621AbgLMTCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7EDC0611CC;
        Sun, 13 Dec 2020 11:01:08 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AfIp9zdPPjG7b/XlRprPnAo3XsKymjjD+tq3ysqdbt8=;
        b=GKjDga0mU4faB358jQS6pA0HjtCF4/Pml9th/w2n4WDWVsA+5NuCSUwqi4Jpb/QBuZpXBr
        HmN7LxD8i3SEgWbiK9RuIyGs50hyn0U5BIXTlNuyPBDPATAflodGoI5rBm+K971VxH9m9K
        zBD7j+nBeS0Z9md9fu27Zp3jj82D/FaYb2YzMTN5JnXcpy/qzzYd3yp+xjdpdB97L9D/3/
        TzVtz16um5/JEDmGcrfL7L/B6LlZWG3vgvJLi4CvmB2EjpyxyyyAWSVdfBB2bL52BINsBn
        /MyxvrLRC9NSsOy7c7PmRQh/o6znH92TXA4/9DWDZnmLpj7z2anXBJ2W1QSwIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AfIp9zdPPjG7b/XlRprPnAo3XsKymjjD+tq3ysqdbt8=;
        b=viuwjLpvtp2JEGJrl0HTCbZ15qyuRdtKJIB8t9kpLbSVLL80xWbZlK7kgDlJcxggfuP+pj
        r5peXAeRvR+EBlBw==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/rcutorture: Fix BUG parsing of console.log
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606660.3364.3387967143308615584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     01f9e708d9eae6335ae9ff25ab09893c20727a55
Gitweb:        https://git.kernel.org/tip/01f9e708d9eae6335ae9ff25ab09893c20727a55
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 02 Nov 2020 18:12:20 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:58 -08:00

tools/rcutorture: Fix BUG parsing of console.log

For the rcutorture test summary log file console.log of virtual machines is
parsed. When a console.log contains "DEBUG", BUG counter is incremented
because regular expression does not handle to ignore DEBUG.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index e033380..263b1be 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -133,7 +133,7 @@ then
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c 'BUG|Oops:' $file`
+	n_bugs=`egrep -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
