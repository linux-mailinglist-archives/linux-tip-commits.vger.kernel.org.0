Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37439234335
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgGaJ3B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:29:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbgGaJWo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:44 -0400
Date:   Fri, 31 Jul 2020 09:22:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zchGzFR6PDQO1B5dyrq+tXkAXHFNgYJCd29j4UHTOAQ=;
        b=RTjgaDIP5mGw9r+Gn4fEKzMBKFgTEAtcGmoNlxz3U8Ip4VQfZgz3GodExps73nHiAM9SU6
        r38Wa+MNZEjkkQFyFBnIp1E2BwphuKdSMJHtMtBsjhe8T8l7SRrTafl6jPwx6RfvHJ1EN4
        uu1w0uXv+RqvsuAEwruQT1dJUuBpQBuH9Zoxqe5I89z88u+tEsLjhHnFsvrYEvP1N69RN4
        TfEFK/WX2uiecGFioj7baEhz7fcyO7RPdW+8QmmfMY+O1Q+2ajkDRtKZPEojwoQKybLBvp
        rQ2YUnJnAwqSMMMR0RW6inv9DFHt2rMqsVAOWxq976fm8+BQVqtL8OyXOwrciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187363;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zchGzFR6PDQO1B5dyrq+tXkAXHFNgYJCd29j4UHTOAQ=;
        b=ElVASD+rFbtdCOLTyn/H3v8nEWXMrVMTHuJHtDGoje9WWUVtbfwwJVWLVP+SyFKWLkmK45
        iNF057MVg+k3tDAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Create qemu-cmd in --buildonly runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736276.4006.3997233712092722365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3e93a51f191aa710760591961240f8910d952b5b
Gitweb:        https://git.kernel.org/tip/3e93a51f191aa710760591961240f8910d952b5b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 05 Jun 2020 10:29:28 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Create qemu-cmd in --buildonly runs

One reason to do a --buildonly run is to use the build products elsewhere,
for example, to do the actual test on some other system.  Part of doing
the test is the actual qemu command, which is not currently produced
by --buildonly runs.  This commit therefore causes --buildonly runs to
create this file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1b9aebd..064dd73 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -153,6 +153,7 @@ qemu_append="`identify_qemu_append "$QEMU"`"
 boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
+echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -161,7 +162,6 @@ then
 	exit 0
 fi
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
 ( $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append "$qemu_append $boot_args" > $resdir/qemu-output 2>&1 & echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 sleep 10 # Give qemu's pid a chance to reach the file
