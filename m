Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9849A319ECF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhBLMln (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhBLMkL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3EC06121E;
        Fri, 12 Feb 2021 04:37:15 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ynK+bHKs88dnle2spYJIUrPju4aT5nG7k6UFgF55hJ8=;
        b=vuxx3uUzWBAJOKJJr2nQqUOoKxn2VeGEfXwUCxsOdcI9hTgsB8eLOci/qs5XRB+Gknp8AQ
        VCU+DfJAQzOUsbjwQvfwRTdbncXF3hWZWUYA3rhXWbKi9UuJYbsSHXBlVlym9xGaIT4tAM
        WJBjbdvhw+/anT3HWVrxgig8oJpUKUDwUvMfdS/Rty9aPHdv5N9v6Am6r4BNyLqGamZDRt
        K3gUnF/5e5OYI6LQO4705qI9+nww2akv6/pmjoO1fVQjW/TYLVxMqGl1+XT6758RfECkwB
        azJbMp834/7W11wn7PKELGU6q1LggBuVHXj2VD49kTkTbc+hJalGgufUVbjfBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ynK+bHKs88dnle2spYJIUrPju4aT5nG7k6UFgF55hJ8=;
        b=Tmi8mcFN3YpbQtVfTBYoI5iMltpuEj8lZjYCVseFo3nOaVJa4FWGBghTkLaCnGvpj+SHrg
        KAqgzOvjxmABaBAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add --kcsan-kmake-arg to torture.sh for KCSAN
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343136.23325.5039120435350311417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c54e413822701a18e7cf6bada2028ea9a9ecdaf9
Gitweb:        https://git.kernel.org/tip/c54e413822701a18e7cf6bada2028ea9a9ecdaf9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 27 Nov 2020 18:06:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:46 -08:00

torture: Add --kcsan-kmake-arg to torture.sh for KCSAN

In 2020, running KCSAN often requires careful choice of compiler.
This commit therefore adds a --kcsan-kmake-arg parameter to torture.sh
to allow specifying (for example) "CC=clang" to the kernel build process
to correctly build a KCSAN-enabled kernel.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 21 ++++++++++----
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 90ca736..0867f30 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -34,6 +34,7 @@ fi
 configs_rcutorture=
 configs_locktorture=
 configs_scftorture=
+kcsan_kmake_args=
 
 # Default duration and apportionment.
 duration_base=10
@@ -79,6 +80,7 @@ usage () {
 	echo "       --do-refscale / --do-no-refscale"
 	echo "       --do-scftorture / --do-no-scftorture"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
+	echo "       --kcsan-kmake-arg kernel-make-arguments"
 	exit 1
 }
 
@@ -166,6 +168,11 @@ do
 		duration_base=$(($ts*mult))
 		shift
 		;;
+	--kcsan-kmake-arg|--kcsan-kmake-args)
+		checkarg --kcsan-kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
+		kcsan_kmake_args="`echo "$kcsan_kmake_args $2" | sed -e 's/^ *//' -e 's/ *$//'`"
+		shift
+		;;
 	*)
 		echo Unknown argument $1
 		usage
@@ -269,6 +276,8 @@ function torture_one {
 # Note that quoting is problematic.  So on the command line, pass multiple
 # values with multiple kvm.sh argument instances.
 function torture_set {
+	local cur_kcsan_kmake_args=
+	local kcsan_kmake_tag=
 	local flavor=$1
 	shift
 	curflavor=$flavor
@@ -281,7 +290,12 @@ function torture_set {
 	if test "$do_kcsan" = "yes"
 	then
 		curflavor=${flavor}-kcsan
-		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --kmake-arg "CC=clang" --kcsan
+		if test -n "$kcsan_kmake_args"
+		then
+			kcsan_kmake_tag="--kmake-args"
+			cur_kcsan_kmake_args="$kcsan_kmake_args"
+		fi
+		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 	fi
 }
 
@@ -382,8 +396,3 @@ then
 	cp $T/log $tdir
 fi
 exit $ret
-
-# @@@
-# Need a way for the invoker to specify clang.  Maybe --kcsan-kmake or some such.
-# --kconfig as with --bootargs (Both have overrides.)
-# Command line parameters for --bootargs, --config, --kconfig, --kmake-arg, and --qemu-arg
