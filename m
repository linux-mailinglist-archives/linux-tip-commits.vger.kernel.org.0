Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01407234347
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgGaJ31 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgGaJWk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F49C061575;
        Fri, 31 Jul 2020 02:22:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W2R/2nhQqlKxPQ/KugUhAAIpxwe8SZycjkXsRmoBVuQ=;
        b=MWTbwHEtD6hszFiICcoiN+L2CG+cMCoWusr4C63Pvh3uSLz0tqq3coEKMfHZ9o55Q/WU/I
        PZjpYFuBtZ4HdOE8D0Hajclljqv2Ifllm43jKEVpPYLOVNSlNg96YnDUwNo1hx0zSyyuLh
        TrC2vtE2CKt7tei1zA/pAZy0vv6bVWg7AqzoGuMU2gnkTJcAa688ga2Kdipqn1H8Hl4+41
        yOrRbpWmRitKlOIhjSX5pTxdXtkaibFbH5zCBYKiPHzL7QTIbBVRPRFC66rhPgKtEIp98e
        Tr7K8wrmhkRF9l1gCMmXyL/HIQ6Gnh12Ir/i/OUMTzJIKvtm+0X78b3cy2Li/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W2R/2nhQqlKxPQ/KugUhAAIpxwe8SZycjkXsRmoBVuQ=;
        b=8Ofqga1XwA428riEGom4lnD9TDIdbSdZK/xY3eGzfaWLnd59PJJC2lkgpjWQOPFAT8XxqA
        IDHJ/qRg5J3MeNBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Avoid duplicate specification of qemu command
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735622.4006.16663033341164320411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     316db5897ee5d7408f2adea4d5992ed380316928
Gitweb:        https://git.kernel.org/tip/316db5897ee5d7408f2adea4d5992ed380316928
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 16:34:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Avoid duplicate specification of qemu command

Currently, the qemu command is constructed twice, once to dump it
to the qemu-cmd file and again to execute it.  This is of course an
accident waiting to happen, but is done to ensure that the remainder
of the script has an accurate idea of the running qemu command's PID.
This commit therefore places both the qemu command and the PID capture
into a new temporary file and sources that temporary file.  Thus the
single construction of the qemu command into the qemu-cmd file suffices
for both purposes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 10 ++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 5ec095d..484445b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -161,8 +161,16 @@ then
 	touch $resdir/buildonly
 	exit 0
 fi
+
+# Decorate qemu-cmd with redirection, backgrounding, and PID capture
+sed -e 's/$/ 2>\&1 \&/' < $resdir/qemu-cmd > $T/qemu-cmd
+echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
+
+# In case qemu refuses to run...
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-( $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append "$qemu_append $boot_args" > $resdir/qemu-output 2>&1 & echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
+
+# Attempt to run qemu
+( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 sleep 10 # Give qemu's pid a chance to reach the file
 if test -s "$resdir/qemu_pid"
