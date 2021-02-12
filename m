Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66A319E9C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBLMjD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhBLMh5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:57 -0500
Date:   Fri, 12 Feb 2021 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4QzyzH+i7zE/+4wPDVeCfxHXTTVoBPn9oomOjvTeLMw=;
        b=bQvy3ECGLP8UIKJhVmbp0EMV0xIcPDYVxJ7G5eHR7ANSvQLFS1KOImqGVG1H+THQvp3qGB
        GnzTfoFbDP3tKjbc8QcwfSxC3akffKo/fKXHLN4w7DtROyeeysPzJGHj+JngilvVcPLxoP
        puKdK78gKPpC21m3Hp6SFayQ/ZncnKByaMpfZQQueQsq/tE/a7+A0P3ZVnsSpSiE60nlX4
        yHcJ46WmIVz9znBzyyzUcVoVQ4DsxkcqmZTdygJQ2+iVDHRaI/+ULsyM7s5W0w9/Sc4HpD
        CkWGS1FZsa7IHvECLKvbipIPhnLtVn6kcsUwxeWBlvUIY1v4hQ7fzeJfHZhmMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4QzyzH+i7zE/+4wPDVeCfxHXTTVoBPn9oomOjvTeLMw=;
        b=QKYc1aVSzVjQ3eRhuM52PnBZFy6CfMlT9NH0gX8vhTGX/lFvKOJ8bAp9Hct2+sr/Hwiumt
        +Yq32Lw4oe+8ULAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh allmodconfig retain and label output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343277.23325.10840428776952693857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1fe9cef42b6cf6491a2982f68fc495c92389ba7b
Gitweb:        https://git.kernel.org/tip/1fe9cef42b6cf6491a2982f68fc495c92389ba7b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 16:37:14 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:43 -08:00

torture: Make torture.sh allmodconfig retain and label output

This commit places "---" markers in the torture.sh script's allmodconfig
output, and uses "<<" to avoid overwriting earlier output from this
build test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a01079e..e2c97f9 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -238,9 +238,12 @@ then
 	echo " --- allmodconfig:" Start `date` | tee -a $T/log
 	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
 	mkdir -p "$amcdir"
-	make -j$MAKE_ALLOTED_CPUS clean > "$amcdir/Make.out" 2>&1
-	make -j$MAKE_ALLOTED_CPUS allmodconfig > "$amcdir/Make.out" 2>&1
-	make -j$MAKE_ALLOTED_CPUS > "$amcdir/Make.out" 2>&1
+	echo " --- make clean" > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
+	echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
+	echo " --- make " >> "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
 	retcode="$?"
 	echo $retcode > "$amcdir/Make.exitcode"
 	if test "$retcode" == 0
