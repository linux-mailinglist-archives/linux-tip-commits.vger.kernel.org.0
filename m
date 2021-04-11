Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF235B4D8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhDKNoP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PIcaIMAP7HmhDDiLUsP3s3K/Wc7S7x7g9RaVL1M1kIo=;
        b=itzB8bgQ0BunB/W1As8mc1N09uzUIHwtRlFFLEJ/fI5A5g96amxw6lMIvYOAdWVSSW8nyA
        5yRPufp3/pg7wGy30gmloPXKe1yZ018/EO9MxSc1/+Fws+UlJJiTs6RW74ijrb/cpRQeNs
        3tz4Ga8kz8FoGanh2K4LVYf24H3VOqGDzamsV3CN9kQta8bq6cjjfubHGod2ByeXtPYMO7
        SEPCOk0yHZsuoBA06zahhP6HLJGsZbvZYXKLcPWjHfB3PGj6tNTpS+hZJo2nCS6cnlo1DK
        uG2Q9ulDn8GMp3u3vICZvWndVDbcOURpFuVtguYBmk0vXQNk7yGkC/AJeTpDJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PIcaIMAP7HmhDDiLUsP3s3K/Wc7S7x7g9RaVL1M1kIo=;
        b=5qbhV1wabF2aNH0zGcrIp51Uxua+hlwUgoYIG6shEzaFLoQi5b8lEuicSLIqiQE5W2rLYr
        PvQLWL0Obgbp3ZCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Record kvm-test-1-run.sh and
 kvm-test-1-run-qemu.sh PIDs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860348.29796.5830933033582844806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cb1fa863a00ba0e8faf69d2ebb960b75129bccd6
Gitweb:        https://git.kernel.org/tip/cb1fa863a00ba0e8faf69d2ebb960b75129bccd6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Feb 2021 16:55:04 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:17 -07:00

torture: Record kvm-test-1-run.sh and kvm-test-1-run-qemu.sh PIDs

This commit records the process IDs of the kvm-test-1-run.sh and
kvm-test-1-run-qemu.sh scripts to ease monitoring of remotely running
instances of these scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 2 ++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 6b0d71b..576a9b7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -33,6 +33,8 @@ then
 	exit 1
 fi
 
+echo ' ---' `date`: Starting kernel, PID $$
+
 # Obtain settings from the qemu-cmd file.
 grep '^#' $resdir/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
 . $T/qemu-cmd-settings
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index a69f8ae..a386ca8 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -41,7 +41,7 @@ then
 	echo "kvm-test-1-run.sh :$resdir: Not a writable directory, cannot store results into it"
 	exit 1
 fi
-echo ' ---' `date`: Starting build
+echo ' ---' `date`: Starting build, PID $$
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
 
