Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2235B4CE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhDKNoM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbhDKNoD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:03 -0400
Date:   Sun, 11 Apr 2021 13:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mry+5OR+hQ3Uho6nAOKbGWyCxZmjx5j4mjMGsKs1yxk=;
        b=K+VJyjoj4fsu6uUL9wRPASB/za7mE9Xds2D2fRjFIym8Jq41ZKTICkrgc0yDggPsOCJ2ag
        tZMcfzAwLygNLJ8vMV8Rz/s1RYBUmagNRNcHLY2ER6AxDVVbay2OPBMSHt2CR4ZqxAtVYx
        RPTgLfpPzuEDJgQ27GwB4LTGDscST7RKnveftYvvZ5upWgWYFO0W62z5uy8Co+AiQF3Ivh
        s4TIaJCKMkscDzJsoLkBpyik+3KV+WsXlwpxcR2KIizs6su9YhPyVwqveDN/cJAoGb9FQq
        JzCeP17pwsC5/0AoYjKng8ew/V8fWEnXIvf5yiSKNz+TKCKOn8LFuJNCXHlMsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Mry+5OR+hQ3Uho6nAOKbGWyCxZmjx5j4mjMGsKs1yxk=;
        b=2Bz/1Sw9kWJog59oel6KL5Mnv/KYOIp6wFkO4oJ0jk54La7UEFMSllRDOb2EUCjoYYfFpY
        uNM0U2cFYaZGA2Dg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Abstract jitter.sh start/stop into scripts
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860478.29796.2152584259595748003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     040accb3cd4ac4a8d151413f569b7ba6d918a19c
Gitweb:        https://git.kernel.org/tip/040accb3cd4ac4a8d151413f569b7ba6d918a19c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Feb 2021 12:37:46 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:28:34 -07:00

torture: Abstract jitter.sh start/stop into scripts

This commit creates jitterstart.sh and jitterstop.sh scripts that handle
the starting and stopping of the jitter.sh scripts.  These must be sourced
using the bash "." command to allow the generated script to wait on the
backgrounded jitter.sh scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitterstart.sh | 37 ++++++++++-
 tools/testing/selftests/rcutorture/bin/jitterstop.sh  | 23 ++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh         |  7 +--
 3 files changed, 62 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstart.sh
 create mode 100644 tools/testing/selftests/rcutorture/bin/jitterstop.sh

diff --git a/tools/testing/selftests/rcutorture/bin/jitterstart.sh b/tools/testing/selftests/rcutorture/bin/jitterstart.sh
new file mode 100644
index 0000000..3d710ad
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/jitterstart.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Start up the specified number of jitter.sh scripts in the background.
+#
+# Usage: . jitterstart.sh n jittering-dir duration [ sleepmax [ spinmax ] ]
+#
+# n: Number of jitter.sh scripts to start up.
+# jittering-dir: Directory in which to put "jittering" file.
+# duration: Time to run in seconds.
+# sleepmax: Maximum microseconds to sleep, defaults to one second.
+# spinmax: Maximum microseconds to spin, defaults to one millisecond.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+jitter_n=$1
+if test -z "$jitter_n"
+then
+	echo jitterstart.sh: Missing count of jitter.sh scripts to start.
+	exit 33
+fi
+jittering_dir=$2
+if test -z "$jittering_dir"
+then
+	echo jitterstart.sh: Missing directory in which to place jittering file.
+	exit 34
+fi
+shift
+shift
+
+touch ${jittering_dir}/jittering
+for ((jitter_i = 1; jitter_i <= $jitter_n; jitter_i++))
+do
+	jitter.sh $jitter_i "${jittering_dir}/jittering" "$@" &
+done
diff --git a/tools/testing/selftests/rcutorture/bin/jitterstop.sh b/tools/testing/selftests/rcutorture/bin/jitterstop.sh
new file mode 100644
index 0000000..576a4cf
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/jitterstop.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Remove the "jittering" file, signaling the jitter.sh scripts to stop,
+# then wait for them to terminate.
+#
+# Usage: . jitterstop.sh jittering-dir
+#
+# jittering-dir: Directory containing "jittering" file.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+jittering_dir=$1
+if test -z "$jittering_dir"
+then
+	echo jitterstop.sh: Missing directory in which to place jittering file.
+	exit 34
+fi
+
+rm -f ${jittering_dir}/jittering
+wait
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index a2ee3f2..d6973e4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -502,15 +502,12 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\ttouch " rd "jittering"
-	for (j = 0; j < njitter; j++)
-		print "\tjitter.sh " j " " rd "jittering " dur " " ja[2] " " ja[3] "&"
+	print "\t. jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3]
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
-	print "\trm -f " rd "jittering"
-	print "\twait"
+	print "\t. jitterstop.sh " rd
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
