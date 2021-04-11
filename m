Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B641135B4EA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhDKNoY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XGTWbtN3y9Vhbxa80n3BbRh15BLjO/bCVJQitlS9RzI=;
        b=XYYWmy+B3Y8bH3wEJdekq9Y/R1bVriUaIKpS0Uepup0WLXD2cEmPUfft7VyV4z8EIVLz5P
        LlItA/YEUg9vl7j2Ot2jin3zrE8+mxa93hLIGvMqTG+k/qSvL1e0oIBHuAxD8CsdYCwYCs
        jj3QI0AvlOEp4y5E3aNiOaK9VD5maeRagcyuEViF7docfXF3m/i9t0ZYlZD6fTRbDmS3I7
        13L4HhWNdobMfnysYlKttgw5wcg5p92awWsLI3s1Mi/cP0j75K2Kuq5rCgwY9WADTZnrAA
        s2ko+1AKL8F8VFOpDeRVxuebdrZXDQEqSyIpBaWKoCufB28US+wwlcJvD88u5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XGTWbtN3y9Vhbxa80n3BbRh15BLjO/bCVJQitlS9RzI=;
        b=5LgB0M0rhitvmaiTyLE22364t2fGXzkq684zhHFS59AKnXdRaYfc1v+FmFIq95XbyAUrrU
        zgfp0CZRp60/fnAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torturescript: Don't rerun failed rcutorture builds
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861255.29796.17254589208037090229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a519d21480d330918bd522499a323432c31b6ec2
Gitweb:        https://git.kernel.org/tip/a519d21480d330918bd522499a323432c31b6ec2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 05 Jan 2021 10:50:32 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torturescript: Don't rerun failed rcutorture builds

If the build fails when running multiple instances of a given rcutorture
scenario, for example, using the kvm.sh --configs "8*RUDE01" argument,
the build will be rerun an additional seven times.  This is in some sense
correct, but it can waste significant time.  This commit therefore checks
for a prior failed build and simply copies over that build's output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 13 ++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 536d103..9d8a82c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
@@ -83,6 +83,17 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
+elif test "$base_resdir" != "$resdir"
+then
+	# Rerunning previous test for which build failed
+	ln -s $base_resdir/Make*.out $resdir  # for kvm-recheck.sh
+	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
+	echo Initial build failed, not running KVM, see $resdir.
+	if test -f $builddir.wait
+	then
+		mv $builddir.wait $builddir.ready
+	fi
+	exit 1
 elif kvm-build.sh $T/KcList $resdir
 then
 	# Had to build a kernel for this test.
