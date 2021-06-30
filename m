Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFE3B83DF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhF3NvB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhF3Nu2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FFBC061198;
        Wed, 30 Jun 2021 06:47:45 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X4NXepe+xoB7u+ztAWzimD79x+JiJ9EuzhOs6UrzoM4=;
        b=PF/q6mgjDRSKOhdLVY+aQjjRcDk5Gg8lKVBxSp/UOmOaFjFb2XMQ9rZ0aMfZean25k5B9H
        t1rctRV7eHds8QK4i2UzAplVum1tnCs/8AyKXTjQQGTviKoBQWJ8/lLPKzfi8Zo6liaYOB
        SLC0D+AgeFkM1kD1usvbMP7Ovn2i+GwRmS6/NfEN3XyBycLEAAYzQCdxFZEr1xj0jL89E9
        Dw9bY4w5fcchqAA0x7vYDHoWQ/LwVZ5uxqnuBIK5ASZTudPGOZ1UxYdjr6sWH9Uxpu+x65
        070ggb6Jq/3/fW4Eeb5svpNV9m2oPzi6jt9oN6Ze2EUKl9WjKPwh/Vyp/RhXMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X4NXepe+xoB7u+ztAWzimD79x+JiJ9EuzhOs6UrzoM4=;
        b=S2h0PL/mASS1xfkxHUF87IZAzIgFkFruxfPbfrUwhYBGcNdDse/kTcRO1BWCRduqxRCftI
        FAjOn7mLRdEUH5CQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Correctly fetch number of CPUs for
 non-English languages
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086356.395.13470413546177636597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f8c8484dbda78e09912a391a8c87414920bbdfee
Gitweb:        https://git.kernel.org/tip/f8c8484dbda78e09912a391a8c87414920bbdfee
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 01 Apr 2021 15:26:02 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture: Correctly fetch number of CPUs for non-English languages

Grepping for "CPU" on lscpu output isn't always successful, depending
on the local language setting.  As a result, the build can be aborted
early with:

	"make: the '-j' option requires a positive integer argument"

This commit therefore uses the human-language-independent approach
available via the getconf command, both in kvm-build.sh and in
kvm-remote.sh.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh  | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 55f4fc1..5ad973d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -42,7 +42,7 @@ then
 fi
 
 # Tell "make" to use double the number of real CPUs on the build system.
-ncpus="`lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
 if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index c4859fc..f08d415 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -136,7 +136,7 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ncpus="`ssh $i lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+	ncpus="`ssh $i getconf _NPROCESSORS_ONLN 2> /dev/null`"
 	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
 	ret=$?
 	if test "$ret" -ne 0
