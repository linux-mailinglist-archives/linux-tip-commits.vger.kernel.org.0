Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C214319ED3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhBLMmA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBLMkY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C5C061221;
        Fri, 12 Feb 2021 04:37:16 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=22np+uEnrDxiUatsKLakeOFbS8WNGM7mLW0ZmCJWf0U=;
        b=WmmGGUQj/D2ihKc6DE9MyM63um7qo/U/qhcpbOx+YJCRB/dpQ2yJxH+RQEQy0ZVRkksEkh
        SoKRNX1sXTFfnVdIIn4GCQj80zGYroRKDknofE6mnj5BMA4xrX2FojThJpehevQYJC74sE
        oGk+DFEefzkEUr4KiSS1VchWQeH3NmtVBivduRPT8TcBxwM4kBIlY6NRi+cQnZesbYhmh+
        vEw31GfI3uuEbf6F1aLuTdEh4BktZbn5MGlOTG0F59SVpW2c4DTodiRFJlilX6pVYuUE7Z
        4g8g05hToEeILsL3KxgyU0hMMGTh5jR0PXmAZqKNo+RiXuEHbQpuxuaMFe/p6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=22np+uEnrDxiUatsKLakeOFbS8WNGM7mLW0ZmCJWf0U=;
        b=OQM22y0+EZ5kcYf8p6+zTRa15N5GKl17dKS5owvhudkdHk7AK7/bWXZCD7IlsWihel/CMV
        Do9D2F0Lkre3D5CQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Create doyesno helper function for torture.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343299.23325.9795533429635723550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c9a9d8e8f2e6f34e70701a1d1580eef9c76265ef
Gitweb:        https://git.kernel.org/tip/c9a9d8e8f2e6f34e70701a1d1580eef9c76265ef
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 10:14:24 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:43 -08:00

torture: Create doyesno helper function for torture.sh

This commit saves a few lines of code by creating a doyesno helper bash
function for argument parsing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 78 +++-----------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a3c3c25..a01079e 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -47,6 +47,16 @@ do_kvfree=yes
 do_kasan=yes
 do_kcsan=no
 
+# doyesno - Helper function for yes/no arguments
+function doyesno () {
+	if test "$1" = "$2"
+	then
+		echo yes
+	else
+		echo no
+	fi
+}
+
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --doall"
@@ -79,44 +89,19 @@ do
 		do_kcsan=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig)
-		if test "$1" = --do-allmodconfig
-		then
-			do_allmodconfig=yes
-		else
-			do_allmodconfig=no
-		fi
+		do_allmodconfig=`doyesno "$1" --do-allmodconfig`
 		;;
 	--do-kasan|--do-no-kasan)
-		if test "$1" = --do-kasan
-		then
-			do_kasan=yes
-		else
-			do_kasan=no
-		fi
+		do_kasan=`doyesno "$1" --do-kasan`
 		;;
 	--do-kcsan|--do-no-kcsan)
-		if test "$1" = --do-kcsan
-		then
-			do_kcsan=yes
-		else
-			do_kcsan=no
-		fi
+		do_kcsan=`doyesno "$1" --do-kcsan`
 		;;
 	--do-kvfree|--do-no-kvfree)
-		if test "$1" = --do-kvfree
-		then
-			do_kvfree=yes
-		else
-			do_kvfree=no
-		fi
+		do_kvfree=`doyesno "$1" --do-kvfree`
 		;;
 	--do-locktorture|--do-no-locktorture)
-		if test "$1" = --do-locktorture
-		then
-			do_locktorture=yes
-		else
-			do_locktorture=no
-		fi
+		do_locktorture=`doyesno "$1" --do-locktorture`
 		;;
 	--do-none)
 		do_allmodconfig=no
@@ -130,36 +115,16 @@ do
 		do_kcsan=no
 		;;
 	--do-rcuscale|--do-no-rcuscale)
-		if test "$1" = --do-rcuscale
-		then
-			do_rcuscale=yes
-		else
-			do_rcuscale=no
-		fi
+		do_rcuscale=`doyesno "$1" --do-rcuscale`
 		;;
 	--do-rcutorture|--do-no-rcutorture)
-		if test "$1" = --do-rcutorture
-		then
-			do_rcutorture=yes
-		else
-			do_rcutorture=no
-		fi
+		do_rcutorture=`doyesno "$1" --do-rcutorture`
 		;;
 	--do-refscale|--do-no-refscale)
-		if test "$1" = --do-refscale
-		then
-			do_refscale=yes
-		else
-			do_refscale=no
-		fi
+		do_refscale=`doyesno "$1" --do-refscale`
 		;;
 	--do-scftorture|--do-no-scftorture)
-		if test "$1" = --do-scftorture
-		then
-			do_scftorture=yes
-		else
-			do_scftorture=no
-		fi
+		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
 	--duration)
 		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
@@ -363,11 +328,6 @@ fi
 exit $ret
 
 # @@@
-# RCU CPU stall warnings?
-# scftorture warnings?
 # Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
-# Work out --configs based on number of available CPUs?
-# Need to sense CPUs to size scftorture run.  Ditto rcuscale and refscale.
 # --kconfig as with --bootargs (Both have overrides.)
 # Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
-# Ensure that build failures count as failures
