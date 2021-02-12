Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1121D319EE0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBLMnH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhBLMkl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:41 -0500
Date:   Fri, 12 Feb 2021 12:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WUUGu4HpNxOBPKBo8hwfl2u4ZXSpluCAwjgVFvIzejo=;
        b=aIaiP7/GBYOlp04yErm+w2tcekW6CkoR1+mnzSnS+H8nV6Or1HLlKZLmIG8mY7cXffCFbk
        rbEIaNJZnWysFLa9Goffi2Iv2Nqn0vlO2BjFMJXNBQ77FSj8HYa6uVpazvQLKkEHrMFqnH
        R+TRaLIDJ3nwCmq6Tp0xPsQbjuAtm/hEaeOIs2JXQ3xNWT5CmJvIt/BGwyh2amy+ptNq80
        SYDIhzOgZMv/nG2mysPept9HrYdmG6guo0nuRoQpw5XImdfpUEQ8ylQsM6d9ZY9/oUK9Qc
        sAnhqQFc5m+6cuaGwuxBe8efWzIsnmMU22IyP4v5S8R9xX5c2WXTOoADJWTlHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WUUGu4HpNxOBPKBo8hwfl2u4ZXSpluCAwjgVFvIzejo=;
        b=gAacbbfdD/ofQnJfx3vAoD5VBnQ4HwMTFu4mmuCYrjs2Gbrfcn+LAmAZkTxkE98xehF031
        0hTtohn/f3u4uTDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Do Kconfig analysis only once per scenario
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344298.23325.3154325699611875785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1120281713a5c8d9caffaa49db11fd0a25e34ef0
Gitweb:        https://git.kernel.org/tip/1120281713a5c8d9caffaa49db11fd0a25e34ef0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 24 Dec 2020 15:28:14 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 05 Jan 2021 11:33:20 -08:00

torture: Do Kconfig analysis only once per scenario

Currently, if a scenario is repeated as in "--configs '4*TREE01'",
the Kconfig analysis is performed for each occurrance (four times in
this example) and each analysis places the exact same data into the
exact same files.  This is not really an issue in this repetition-four
example, but it can needlessly consume tens of seconds of wallclock time
for something like "--config '128*TINY01'".

This commit therefore does Kconfig analysis only once per set of
repeats of a given scenario, courtesy of the "sort -u" command and an
automatically generated awk script.

While in the area, this commit also wordsmiths a comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 22 ++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6051868..8d3c99b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -286,7 +286,8 @@ then
 		exit 1
 	fi
 fi
-for CF1 in $configs_derep
+echo 'BEGIN {' > $T/cfgcpu.awk
+for CF1 in `echo $configs_derep | tr -s ' ' '\012' | sort -u`
 do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
@@ -299,12 +300,20 @@ do
 		fi
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
-		echo $CF1 $cpu_count >> $T/cfgcpu
+		echo 'scenariocpu["'"$CF1"'"] = '"$cpu_count"';' >> $T/cfgcpu.awk
 	else
 		echo "The --configs file $CF1 does not exist, terminating."
 		exit 1
 	fi
 done
+cat << '___EOF___' >> $T/cfgcpu.awk
+}
+{
+	for (i = 1; i <= NF; i++)
+		print $i, scenariocpu[$i];
+}
+___EOF___
+echo $configs_derep | awk -f $T/cfgcpu.awk > $T/cfgcpu
 sort -k2nr $T/cfgcpu -T="$T" > $T/cfgcpu.sort
 
 # Use a greedy bin-packing algorithm, sorting the list accordingly.
@@ -324,11 +333,10 @@ END {
 	batch = 0;
 	nc = -1;
 
-	# Each pass through the following loop creates on test batch
-	# that can be executed concurrently given ncpus.  Note that a
-	# given test that requires more than the available CPUs will run in
-	# their own batch.  Such tests just have to make do with what
-	# is available.
+	# Each pass through the following loop creates on test batch that
+	# can be executed concurrently given ncpus.  Note that a given test
+	# that requires more than the available CPUs will run in its own
+	# batch.  Such tests just have to make do with what is available.
 	while (nc != ncpus) {
 		batch++;
 		nc = ncpus;
