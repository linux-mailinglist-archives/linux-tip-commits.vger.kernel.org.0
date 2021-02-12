Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A27319EF7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhBLMov (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBLMm5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:42:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8713C061786;
        Fri, 12 Feb 2021 04:42:17 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C9xDQIgjQ5JN2iIspUQ935/1yS3nKggu43hLGEzOuhc=;
        b=fz+2Xzjmih9FBcJzM6jRR2ZLNzUuriQD7ydM4QorxQm/sjpbGP+vyPpjOpcmQUnhS3izsy
        +wMrTxPohukOrpADx99+EFZadpMfQ44zdZ0mWu78+E4WXEiaD5jBVrO7AbDtY3USZg0Fyb
        8/U7iBytDB/9ZAOniTukSWAOZnfqy6xey7hcju0yVtx3tYhRKfgBObvknZUAOYAOoJYWih
        3+2k3k/oL+zuqRiEodkEQQ6YuMkG1cj0YIR/gI7HLI6s9vxjzHH7AHhVNq7UXLDW87lNYF
        HijD4ZLNK9y8C382yi3KWqpxflfZ3LMmvBDvQ3IDgsH/io/na+WEnOv2IGyTIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C9xDQIgjQ5JN2iIspUQ935/1yS3nKggu43hLGEzOuhc=;
        b=Iroc6YAb+5R9AxxA9Ha5febp/zTtMP+ogcfoMLe00P0GyrV24HAhvTtpmN2BMyH2YB4vfW
        Tt9ITCG1tL1MXqBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add --dryrun batches to help schedule a
 distributed run
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344566.23325.11355285696655003139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     755cf0afc16477bf55c837a35bf3b15461850194
Gitweb:        https://git.kernel.org/tip/755cf0afc16477bf55c837a35bf3b15461850194
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 11 Dec 2020 16:26:50 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:23 -08:00

torture: Add --dryrun batches to help schedule a distributed run

When all of the remote systems have the same number of CPUs, one
approach is to use one "--buildonly" run and one "--dryrun sched" run,
and then distributing the batches out one per remote system.  However,
the output of "--dryrun sched" is not made for parsing, so this commit
adds a "--dryrun batches" that provides the same information in easily
parsed form.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 22 +++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 667896f..6b90036 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -60,7 +60,7 @@ usage () {
 	echo "       --cpus N"
 	echo "       --datestamp string"
 	echo "       --defconfig string"
-	echo "       --dryrun sched|script"
+	echo "       --dryrun batches|sched|script"
 	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
@@ -126,7 +126,7 @@ do
 		shift
 		;;
 	--dryrun)
-		checkarg --dryrun "sched|script" $# "$2" 'sched\|script' '^--'
+		checkarg --dryrun "batches|sched|script" $# "$2" 'batches\|sched\|script' '^--'
 		dryrun=$2
 		shift
 		;;
@@ -235,7 +235,7 @@ do
 	shift
 done
 
-if test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 then
 	:
 else
@@ -547,8 +547,7 @@ then
 elif test "$dryrun" = sched
 then
 	# Extract the test run schedule from the script.
-	egrep 'Start batch|Starting build\.' $T/script |
-		grep -v ">>" |
+	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
 	nbuilds="`grep 'Starting build\.' $T/script |
 		  grep -v ">>" | sed -e 's/:.*$//' -e 's/^echo //' |
@@ -557,6 +556,19 @@ then
 	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
 	echo Total number of batches: $nbatches
 	exit 0
+elif test "$dryrun" = batches
+then
+	# Extract the tests and their batches from the script.
+	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+		sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
+		awk '
+		/^----Start/ {
+			batchno = $3;
+			next;
+		}
+		{
+			print batchno, $1, $2
+		}'
 else
 	# Not a dryrun, so run the script.
 	bash $T/script
