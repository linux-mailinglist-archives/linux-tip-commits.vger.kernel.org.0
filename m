Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4690735B4C6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhDKNoI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B4C06138C;
        Sun, 11 Apr 2021 06:43:30 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BlXvuGjvsWK8tyS5iqTwBfo6iPC9IoU2GeyVZzWpvaY=;
        b=uE3N484O4fYzA8uyb8eeLy05auxDfAkAE/OxrPyuYvBQswiH7MxpllhlcZHdywiplKjR3q
        mpau4Amm7wIPMxCksc2luGGKUx1hid20nCUFCBQGyIFZaeLoRrVjwoPdGaAtnF6LRrxKB9
        zxPkVsFqG0bTl0u974evnYPijg65rJ5BMBd6BbvxvBmKISd/vtyHEWxIbd29HsTy2ObtHe
        vCeg1ng2fd1cbqyTtO98IyvQXrX0zfyGkVPfStp80qwk02O7a+Y/ntgoCTaVPSkB+qVkoG
        kAk5W+Sl2uTKxQq0sokGS2rdp7al8NTYocG32iURHILgSL078Y7Vcz9aqTlrWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BlXvuGjvsWK8tyS5iqTwBfo6iPC9IoU2GeyVZzWpvaY=;
        b=IlDtnJSPfrsi4gw742/uJqx+mVDOcizSIMdmPwPPwvFwcEgrRNMvZTPe32MMHeIJu747vW
        Ve9DsdweLovwISAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add --duration argument to kvm-again.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860071.29796.10799229563053742678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     00505165cf4484dffc488259d59689845ba77939
Gitweb:        https://git.kernel.org/tip/00505165cf4484dffc488259d59689845ba77939
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 22 Feb 2021 14:12:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:19 -07:00

torture: Add --duration argument to kvm-again.sh

This commit adds a --duration argument to kvm-again.sh to allow the user
to override the --duration specified for the original kvm.sh run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh     | 25 ++++++-
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh | 29 ++++++--
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 4137440..e7e5458 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -52,6 +52,7 @@ PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
 
 dryrun=
+dur=
 default_link="cp -R"
 rundir="`pwd`/tools/testing/selftests/rcutorture/res/`date +%Y.%m.%d-%H.%M.%S-again`"
 
@@ -61,6 +62,7 @@ starttime="`get_starttime`"
 usage () {
 	echo "Usage: $scriptname $oldrun [ arguments ]:"
 	echo "       --dryrun"
+	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --link hard|soft|copy"
 	echo "       --remote"
 	echo "       --rundir /new/res/path"
@@ -73,6 +75,23 @@ do
 	--dryrun)
 		dryrun=1
 		;;
+	--duration)
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		dur=$(($ts*mult))
+		shift
+		;;
 	--link)
 		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
 		case "$2" in
@@ -134,7 +153,11 @@ do
 	cp "$i" $T
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
-	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log < $T/qemu-cmd > $i
+	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log $dur < $T/qemu-cmd > $i
+	if test -n "$dur"
+	then
+		echo "# seconds=$dur" >> $i
+	fi
 	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
 done
 grep -v '^#' $T/batches.oldrun | awk '
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index c45a953..162dddb 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -3,7 +3,7 @@
 #
 # Transform a qemu-cmd file to allow reuse.
 #
-# Usage: kvm-transform.sh bzImage console.log < qemu-cmd-in > qemu-cmd-out
+# Usage: kvm-transform.sh bzImage console.log [ seconds ] < qemu-cmd-in > qemu-cmd-out
 #
 #	bzImage: Kernel and initrd from the same prior kvm.sh run.
 #	console.log: File into which to place console output.
@@ -29,20 +29,37 @@ then
 	echo "Need console log file name."
 	exit 1
 fi
+seconds=$3
+if test -n "$seconds" && echo $seconds | grep -q '[^0-9]'
+then
+	echo "Invalid duration, should be numeric in seconds: '$seconds'"
+	exit 1
+fi
+
+awk -v image="$image" -v consolelog="$consolelog" -v seconds="$seconds" '
+/^#/ {
+	print $0;
+	next;
+}
 
-awk -v image="$image" -v consolelog="$consolelog" '
 {
 	line = "";
 	for (i = 1; i <= NF; i++) {
-		if (line == "")
+		if ("" seconds != "" && $i ~ /\.shutdown_secs=[0-9]*$/) {
+			sub(/[0-9]*$/, seconds, $i);
+			if (line == "")
+				line = $i;
+			else
+				line = line " " $i;
+		} else if (line == "") {
 			line = $i;
-		else
+		} else {
 			line = line " " $i;
+		}
 		if ($i == "-serial") {
 			i++;
 			line = line " file:" consolelog;
-		}
-		if ($i == "-kernel") {
+		} else if ($i == "-kernel") {
 			i++;
 			line = line " " image;
 		}
