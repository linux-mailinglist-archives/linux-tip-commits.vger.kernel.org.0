Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C4319EF4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhBLMoF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:44:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhBLMmN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:42:13 -0500
Date:   Fri, 12 Feb 2021 12:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XHG6v7aBs4Pa87lIcpjBmvjRw1xV9jYJdWaOTFO0r8g=;
        b=jK1iDm7WWKmK/zdbmfOtH+8wsm7jQmTfDthAjiqLe2ix9rteOvkcfLptgn2unim+Y1EtU/
        uHqDRXXOF0ByjSvoNMCkH1uzpsXKOKZA50uagyG1wrd5JQPw1sXtVBQzAQIZZbzLJsNxJQ
        76ylkweWz7VzqagLpi/+PX3MHZeECYfZ1wsuVK5ItbQkeMQ6dfxJxenERAXmu5UkP+mpHF
        7IyNT3QOig2Y2HeQiGe1jbFhBJG9GVzfEddmKnvdz2tz13gwYVpOEkaWszU1hCvZs9oLSf
        2bsWMyCLJfSF5HDjXUmKnnzR6f9k5vCT208Mpuw/cTw7HsYdJwEnEhRWs/nWeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XHG6v7aBs4Pa87lIcpjBmvjRw1xV9jYJdWaOTFO0r8g=;
        b=rQjTMzzCo4kPbuS4USGu2Pa98kbgT6VYPLxJe4+Ua+GkVOBZ6is/WOG9bAvq4YoZJwMTU2
        8xb/IaU4gIDJSKAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: s/STOP/STOP.1/ to avoid scenario collision
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344544.23325.1495138230344887475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c821f855f625f763a87c49f413aa4f60974b5071
Gitweb:        https://git.kernel.org/tip/c821f855f625f763a87c49f413aa4f60974b5071
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 11 Dec 2020 16:59:40 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:24 -08:00

torture: s/STOP/STOP.1/ to avoid scenario collision

This commit changes the "STOP" file that is used to cleanly halt a running
rcutorture run to "STOP.1" because no scenario directory will ever end
with ".1".  If there really was a scenario named "STOP", its directories
would instead be named "STOP", "STOP.2", "STOP.3", and so on.  While in
the area, the commit also changes the kernel-run-time checks for this
file to look directly in the directory above $resdir, thus avoiding the
need to pass the TORTURE_STOPFILE environment variable to remote systems.

While in the area, move the STOP.1 file to the top-level directory
covering all of the scenarios.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 8 ++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 4bc0e62..536d103 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -211,7 +211,7 @@ do
 		if test -n "$TORTURE_KCONFIG_GDB_ARG"
 		then
 			:
-		elif test $kruntime -ge $seconds || test -f "$TORTURE_STOPFILE"
+		elif test $kruntime -ge $seconds || test -f "$resdir/../STOP.1"
 		then
 			break;
 		fi
@@ -254,16 +254,16 @@ then
 fi
 if test $commandcompleted -eq 0 -a -n "$qemu_pid"
 then
-	if ! test -f "$TORTURE_STOPFILE"
+	if ! test -f "$resdir/../STOP.1"
 	then
 		echo Grace period for qemu job at pid $qemu_pid
 	fi
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
-		if test -f "$TORTURE_STOPFILE"
+		if test -f "$resdir/../STOP.1"
 		then
-			echo "PID $qemu_pid killed due to run STOP request" >> $resdir/Warnings 2>&1
+			echo "PID $qemu_pid killed due to run STOP.1 request" >> $resdir/Warnings 2>&1
 			kill -KILL $qemu_pid
 			break
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6b90036..6051868 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -386,7 +386,7 @@ then
 fi
 mkdir -p $resdir/$ds
 TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
-TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
+TORTURE_STOPFILE="$resdir/$ds/STOP.1"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
