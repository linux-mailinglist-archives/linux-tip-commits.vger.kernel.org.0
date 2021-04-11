Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C535B4E2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhDKNoU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E26C061574;
        Sun, 11 Apr 2021 06:43:49 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y90WIf+DmiYoKsWeFWxLVmvn0P8oZXOfY0bb5xNRawI=;
        b=1rU+D6Ci45eOv7B1OvpXVnoiYFH7PMSTlrgXPVnPPtQXq1X3H5ADjnHXn307TRf6I9cMmF
        SgoMoAt4DYrVmhzSiEib+oNvztsF4HdgkGdJS6WRUHs/3aEbnCp1uGZNZ+tEZ0PMtRJTNU
        WXW/SqP6gPnNr9Ir96GAKVBSZoX7X2IFjwGCVn9QjQAOpG96xSDQGfE6jALBlE8TWNYzj4
        BgrKGwhWIHU9+eK1qoj1GkkBNHGecJXB88sqSB+HqRHxvGllR21EEocglFMuiIn6T0ji0+
        dY/2DpSyC0fXu82QWr7TQ6pN6K5yrrjdPaPm/3WWwsQ8vXivuM+lDZScuFY0bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y90WIf+DmiYoKsWeFWxLVmvn0P8oZXOfY0bb5xNRawI=;
        b=UQGcVSol1eqkHgi66MTN93uL96l23rDnN9uGfTU3AAEGDoc7Kuwnd3SbNXqsQHUrmCOlJk
        Dr7UhLiVqXY9PgAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Reverse jittering and duration parameters
 for jitter.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860877.29796.13799291944612151694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4cd54518c3d8afadd11ebd6ad4f03b00859f5e85
Gitweb:        https://git.kernel.org/tip/4cd54518c3d8afadd11ebd6ad4f03b00859f5e85
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Feb 2021 11:54:43 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Reverse jittering and duration parameters for jitter.sh

Remote rcutorture testing requires that jitter.sh continue to be
invoked from the generated script for local runs, but that it instead
be invoked on the remote system for distributed runs.  This argues
for common jitterstart and jitterstop scripts.  But it would be good
for jitterstart and jitterstop to control the name and location of the
"jittering" file, while continuing to have the duration controlled by
the caller of these new scripts.

This commit therefore reverses the order of the jittering and duration
parameters for jitter.sh, so that the jittering parameter precedes the
duration parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 6 +++---
 tools/testing/selftests/rcutorture/bin/kvm.sh    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index ed0ea86..ff1d3e4 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -5,7 +5,7 @@
 # of this script is to inflict random OS jitter on a concurrently running
 # test.
 #
-# Usage: jitter.sh me duration jittering-path [ sleepmax [ spinmax ] ]
+# Usage: jitter.sh me jittering-path duration [ sleepmax [ spinmax ] ]
 #
 # me: Random-number-generator seed salt.
 # duration: Time to run in seconds.
@@ -18,8 +18,8 @@
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
 me=$(($1 * 1000))
-duration=$2
-jittering=$3
+jittering=$2
+duration=$3
 sleepmax=${4-1000000}
 spinmax=${5-1000}
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index de93802..a2ee3f2 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -504,7 +504,7 @@ function dump(first, pastlast, batchnum)
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
 	print "\ttouch " rd "jittering"
 	for (j = 0; j < njitter; j++)
-		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
+		print "\tjitter.sh " j " " rd "jittering " dur " " ja[2] " " ja[3] "&"
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
