Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA935B4B4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhDKNoB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhDKNni (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:38 -0400
Date:   Sun, 11 Apr 2021 13:43:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JeIS0bq69F9WIM4iQdT8P4V33iVHWQCF3BkjEasZ6q4=;
        b=eR8xoLliH5uMJbuglCEvm72X9LTq23sf3BkprZMbcL3NDMGhe+aX14Q32wvtmagJIDRVjc
        6F8wUNXF7eZj8Cg5IZF3IUi7CVN4lCaQNtqWAlg38ZZ69jLaJVEs1986NB8vNfAiiu4e3D
        PQosH7XryfWokaHB2aa6V/4jylc5UH5lClKsnBCnC7wWhqEOvDdLMYIC6qPRtd6mYtKHLK
        3M1saipuwTpnhBv9eP+zxtdOVTe2XyAsU4yDji9YbctRJbphi5lAlkqNGmr7BXFf1j4FRt
        scvUCTdZZcPlu3WeYBvaZncL38KXnArCoyBo7nJLptJMq1yxlFoNNWT1+pLvrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JeIS0bq69F9WIM4iQdT8P4V33iVHWQCF3BkjEasZ6q4=;
        b=GvJnA4aydzFVe5HfZ5e9gmQSjbB3PiXB+hq6kIYX2WZUT2US8msTKzv1ADNCZ0D6TU9hUp
        Hxbrgeavb3HwsrBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Print proper vmlinux path for kvm-again.sh runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859963.29796.4790197968256320068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     03edf700db335b9375c18310d59d0a0ab6c850df
Gitweb:        https://git.kernel.org/tip/03edf700db335b9375c18310d59d0a0ab6c850df
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 13:12:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:20 -07:00

torture: Print proper vmlinux path for kvm-again.sh runs

The kvm-again.sh script does not copy over the vmlinux files due to
their large size.  This means that a gdb run must use the vmlinux file
from the original "res" directory.  This commit therefore finds that
directory and prints it out so that the user can copy and pasted the
gdb command just as for the initial run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh           | 5 ++++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index f1c80b0..668636e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -159,7 +159,10 @@ do
 	then
 		echo "# seconds=$dur" >> $i
 	fi
-	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+	if test -n "$arg_remote"
+	then
+		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+	fi
 done
 
 # Extract settings from the last qemu-cmd file transformed above.
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 576a9b7..5b1aa2a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -67,7 +67,11 @@ then
 	base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 	if ! test -f $base_resdir/vmlinux
 	then
-		base_resdir=/path/to
+		base_resdir="`cat re-run`/$resdir"
+		if ! test -f $base_resdir/vmlinux
+		then
+			base_resdir=/path/to
+		fi
 	fi
 	echo Waiting for you to attach a debug session, for example: > /dev/tty
 	echo "    gdb $base_resdir/vmlinux" > /dev/tty
