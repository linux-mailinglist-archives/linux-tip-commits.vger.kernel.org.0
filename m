Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D73B83B4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhF3Nuh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbhF3NuJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:09 -0400
Date:   Wed, 30 Jun 2021 13:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kL6CVJ+s2DZDmxVIA4tmPAxbLtBvMygPURAXX4ePioQ=;
        b=CurLAFm2TjdsHvQ1mRJSlK3WQ4zJg5ME+iUa1/6lwMKzSThsA7YLQNUQoN3oG77TzBWWrm
        kSURm3YW5bpt2Zl3PvXYKw9pTBCoo3qV8V+8DHSASqNZHP35bwU4jddwPbjaRJzl5tRXRc
        kvIFnNPc7Vv7N3/SzXzF1VDcM41CBdoZhETLGLJeZqrSrRkjNrDr/ROWUKviz4yvaFMa/a
        svLwjMQNZ4pD1J8LBOj2Xlmh5ebW5fANucLoF9Zy6mvI7JTblihEw1UMonbXHk1F69iLpi
        PlGvonahf6HS1nmgJgT4pmWQLe4WxaucBf1AjMifrH+ec2jFU9TvJaP/gGuEXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kL6CVJ+s2DZDmxVIA4tmPAxbLtBvMygPURAXX4ePioQ=;
        b=Z19lvsLCUbNdd06uetwybguqEi64H15ewzsEiVEPJyyPG9lJ4pccYCxESQps8uXI3T5go2
        pMp4thnQE6qZUcAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Don't cap remote runs by build-system number of CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085903.395.9968620011066631581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d78668e5b50f1a28fdfd4293fc61b90eb10ba75
Gitweb:        https://git.kernel.org/tip/3d78668e5b50f1a28fdfd4293fc61b90eb10ba75
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 27 Apr 2021 13:51:35 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

torture: Don't cap remote runs by build-system number of CPUs

Currently, if a torture scenario requires more CPUs than are present
on the build system, kvm.sh and friends limit the CPUs available to
that scenario.  This makes total sense when the build system and the
system running the scenarios are one and the same, but not so much when
remote systems might well have more CPUs.

This commit therefore introduces a --remote flag to kvm.sh that suppresses
this CPU-limiting behavior, and causes kvm-remote.sh to use this flag.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh        | 14 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 20e848d..79e680e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -66,7 +66,7 @@ then
 		if (ds != "")
 			print "--datestamp " ds;
 	}'`"
-	kvm.sh "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
+	kvm.sh --remote "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
 	ret=$?
 	if test "$ret" -ne 0
 	then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 390bb97..b4ac4ee 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -44,6 +44,7 @@ TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
+TORTURE_REMOTE=
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
 TORTURE_MOD=rcutorture
@@ -80,6 +81,7 @@ usage () {
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
+	echo "       --remote"
 	echo "       --results absolute-pathname"
 	echo "       --torture lock|rcu|rcuscale|refscale|scf"
 	echo "       --trust-make"
@@ -115,10 +117,13 @@ do
 		checkarg --cpus "(number)" "$#" "$2" '^[0-9]*$' '^--'
 		cpus=$2
 		TORTURE_ALLOTED_CPUS="$2"
-		max_cpus="`identify_qemu_vcpus`"
-		if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+		if test -z "$TORTURE_REMOTE"
 		then
-			TORTURE_ALLOTED_CPUS=$max_cpus
+			max_cpus="`identify_qemu_vcpus`"
+			if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+			then
+				TORTURE_ALLOTED_CPUS=$max_cpus
+			fi
 		fi
 		shift
 		;;
@@ -209,6 +214,9 @@ do
 		TORTURE_QEMU_CMD="$2"
 		shift
 		;;
+	--remote)
+		TORTURE_REMOTE=1
+		;;
 	--results)
 		checkarg --results "(absolute pathname)" "$#" "$2" '^/' '^error'
 		resdir=$2
