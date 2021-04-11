Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB8435B4B3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhDKNn6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:43:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhDKNni (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:38 -0400
Date:   Sun, 11 Apr 2021 13:43:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=imdo6wh8/NXej78Z1P/nN7LEpV765239g6A77+XXxg4=;
        b=vgV9AMTEbbOetc6lo6NYfvWihhuV7Jq9V0zMsXjxUVb81K/SbnD/eJXKI2MyNSjVULIQHg
        Y3UYyNyJP3ZNxPSBJf6KZypowlN4w1Da7neWqCzfXs1kqhJRwtNvE3Dt3zxXoccVsXNSYY
        RrHJvYAFO7WXYsWj22Q7W73ymy1R7knL+yCrvGgLGB+8sDwmU5KmUQhSRLnTD3Y9lXoDOi
        wdkKlJSee7AdCo9xDhwY9v2k4/5tV+LNKJUKCWrSosUrWuhT2PBk3jsaIoiTMAL9WsL70o
        W/F4tlwtdO2K1GComePsQKiLokLK1z++0ryMsF1HmyRPlOP6tocSPreILd5Ekw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=imdo6wh8/NXej78Z1P/nN7LEpV765239g6A77+XXxg4=;
        b=G6ltBghN/6JwVmFfk8TDvRl/s/KYqb23G6EwkKpt1Lndg++Ur+4CyAQZSIw2oy+Z9qcWFE
        2vuW8vR6fM/8LuCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Consolidate qemu-cmd duration editing into
 kvm-transform.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859922.29796.5037229931739988350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a1ab2e89f36d678512a50cbebf6afc4201f41a31
Gitweb:        https://git.kernel.org/tip/a1ab2e89f36d678512a50cbebf6afc4201f41a31
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 14:33:03 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:21 -07:00

torture: Consolidate qemu-cmd duration editing into kvm-transform.sh

Currently, kvm-again.sh updates the duration in the "seconds=" comment
in the qemu-cmd file, but kvm-transform.sh updates the duration in the
actual qemu command arguments.  This is an accident waiting to happen.

This commit therefore consolidates these updates into kvm-transform.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh     | 4 ----
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 668636e..46e47a0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -155,10 +155,6 @@ do
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
 	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur < $T/qemu-cmd > $i
-	if test -n "$dur"
-	then
-		echo "# seconds=$dur" >> $i
-	fi
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index e9dcbce..d40b4e6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -44,6 +44,14 @@ fi
 
 awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
     -v seconds="$seconds" '
+/^# seconds=/ {
+	if (seconds == "")
+		print $0;
+	else
+		print "# seconds=" seconds;
+	next;
+}
+
 /^# TORTURE_JITTER_START=/ {
 	print "# TORTURE_JITTER_START=\". jitterstart.sh " $4 " " jitter_dir " " $6 " " $7;
 	next;
