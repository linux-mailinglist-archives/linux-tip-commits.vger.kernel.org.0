Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299613B83E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhF3NvM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhF3Nua (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F21FC0611BE;
        Wed, 30 Jun 2021 06:47:47 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6/XilzV6p0gMEJFeETRf5T2QNaNzjUe1w9yXU6zvEZM=;
        b=ape68gY5EYiOgw4LhfxSjnFOSwjSGLSqHqrWqCQw8PkG3r7N6MZe51IA4ZTCpz3a5xkWcD
        7hN1Djt7iDXrnFD+mAe1+2h+ucjN9f7S0HdSxZvbNRAk8kD56heJtwTHOYrX8hvMz+19N4
        v+M0kD6e1pjZ+MdqP/vkc8XyP5s/SUZe0+CCPn2DK57nNoyTlwgZBq4Uq05pwurkZVkPIa
        bUztGf//znA7jHorcS+6TlAnIBTqDXULVcUuKm/w8qDXG78AIYnSOD5KgmG47S9c9Qfxvi
        GUndghWkZDSvVp3QpYNDJnBR1DcX7JUxIgC8FZ/0jCfY2eSAq2eW9/TtXGhZiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6/XilzV6p0gMEJFeETRf5T2QNaNzjUe1w9yXU6zvEZM=;
        b=ekZ0LoPXXHR1DddkjjByzjJpvN6oGsJ5s1nSyv7fFbC3LspZLY5VxBG2R0q+M451twzurU
        W4LeClW8m5iOEJBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make the build machine control N in "make -jN"
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086510.395.126275583220026646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b09751d752fb0e8dce4062254da9f813dcb00de5
Gitweb:        https://git.kernel.org/tip/b09751d752fb0e8dce4062254da9f813dcb00de5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 18 Mar 2021 14:00:59 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture:  Make the build machine control N in "make -jN"

Given remote rcutorture runs, it is quite possible that the build system
will have fewer CPUs than the system(s) running the actual test scenarios.
In such cases, using the number of CPUs on the test systems can overload
the build system, slowing down the build or, worse, OOMing the build
system.  This commit therefore uses the build system's CPU count to set
N in "make -jN", and by tradition sets "N" to double the CPU count.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 115e182..55f4fc1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -40,8 +40,10 @@ if test $retval -gt 1
 then
 	exit 2
 fi
-ncpus=`cpus2use.sh`
-make -j$ncpus $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
+
+# Tell "make" to use double the number of real CPUs on the build system.
+ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
 then
