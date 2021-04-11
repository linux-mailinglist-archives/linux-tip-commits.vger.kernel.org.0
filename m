Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA235B4D5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhDKNoO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbhDKNoD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:03 -0400
Date:   Sun, 11 Apr 2021 13:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jmAEvPFyqqGggxMpVNexwZI9hu6XYu26LoQIgrOQLmI=;
        b=iPtaTRQFQLdH0c/VFz67fbo/jkjwJhrkeYBJNLaUK0htKLWZHtp+NkUzN1fKza3aFmpRDC
        Hk7JSrd47idsZsSPntUxllNdKrLY7cKTVv7CVlLgkRRygLZ+o1gn/TC7Dw0eUzvSRkdNeu
        RiAGasffpMAdaUhLD6J6H1sEWiYCH7j3biPsB4HVCp4jq/sDOFiu0q2ecWE+zuN+sqkkF/
        Ou29gYbLpyqXO1bV2YyHATxxZMvmBi7VwF5vIokcc8gBpW/EPNUQ5JZ5TXto9NGU84q+R5
        6g0CzP6dBIeVMPumLENQS66Scz8ag7FkuQSs20Fe1pFveo5Na2753Usy5TV4FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jmAEvPFyqqGggxMpVNexwZI9hu6XYu26LoQIgrOQLmI=;
        b=b9Y2jvgdlhxRg7IEqsKho1lHfaZ8TP1liH+7Zl30Cx9K4DqxMAk+f/sxom3GZE8dx/w7K0
        7Kf5wIV6KjQludDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Record TORTURE_KCONFIG_GDB_ARG in qemu-cmd
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860446.29796.2193811030979572881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cc45716e07a41233b7c0b2183b0a3e60b85192e0
Gitweb:        https://git.kernel.org/tip/cc45716e07a41233b7c0b2183b0a3e60b85192e0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Feb 2021 16:19:29 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:15 -07:00

torture: Record TORTURE_KCONFIG_GDB_ARG in qemu-cmd

When re-running old rcutorture builds, if the original run involved
gdb, the re-run also needs to do so.  This commit therefore records the
TORTURE_KCONFIG_GDB_ARG environment variable into the qemu-cmd file so
that the re-run can access it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index eb5346b..5d9ac90 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -201,6 +201,7 @@ echo kernel here: `head -n 1 $testid_txt | sed -e 's/^Build directory: //'`  >> 
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
+echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
