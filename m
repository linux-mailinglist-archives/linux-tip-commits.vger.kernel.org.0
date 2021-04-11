Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F203235B4B6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhDKNoD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhDKNn6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:58 -0400
Date:   Sun, 11 Apr 2021 13:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uc7ZuyrKl8SnVlPKPpPf/hgCS1vyvv0bSUw0UKdvshM=;
        b=W6dIJKyck+BVEoUoN/c6ZTTfv3qox7YWUY7MzZbIC+QMBQG5fPebeVSIzxwqbAIAbEEhq8
        NtPtud7uBRTWgGePAQXjj+8hp2BpIRU61vYq0iini/GzK4ASV+bAnB/K5yP0Qmm+QjHZSl
        +pJ0qo7lRSupQ1/wO26IDgh7koxbb3+BO7M8JU0V6tr8xb2Le+CyNlbnu6lbLI3sX1Z/qo
        9MiWGL8Rgk5ljyMR9x7G9pbD8x7OtiNfrIS5+c+i5sL+awFneWlT6pT6TgMMZJ4xx3SftD
        +XKdcQh6zT1qIbwW8exz8cXZbsyfUnbQMcROynxhlYunuq9Wk9gurrMfEgq5RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uc7ZuyrKl8SnVlPKPpPf/hgCS1vyvv0bSUw0UKdvshM=;
        b=svKLbuwzjRl1bzQNDeljv734VKLsUkECuhohzYNuO9XhSz+TUFzNLY6rFbU/Co4/b1FORa
        mVS7zGaYHqZ9X9Aw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Create a "batches" file for build reuse
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860147.29796.11337673354834222930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d6100d764cc47100ecabdc704bde5ad0448c87cd
Gitweb:        https://git.kernel.org/tip/d6100d764cc47100ecabdc704bde5ad0448c87cd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Feb 2021 14:40:03 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:18 -07:00

torture: Create a "batches" file for build reuse

This commit creates a "batches" file in the res/$ds directory, where $ds
is the datestamp.  This file contains the batches and the number of CPUs,
for example:

1 TREE03 16
1 SRCU-P 8
2 TREE07 16
2 TREE01 8
3 TREE02 8
3 TREE04 8
3 TREE05 8
4 SRCU-N 4
4 TRACE01 4
4 TRACE02 4
4 RUDE01 2
4 RUDE01.2 2
4 TASKS01 2
4 TASKS03 2
4 SRCU-t 1
4 SRCU-u 1
4 TASKS02 1
4 TINY01 1
5 TINY02 1
5 TREE09 1

The first column is the batch number, the second the scenario number
(possibly suffixed by a repetition number, as in "RUDE01.2"), and the
third is the number of CPUs required by that scenario.  The last line
shows the number of CPUs expected by this batch file, which allows
the run to be re-batched if a different number of CPUs is available.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 29 ++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index a1cd05c..0add163 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -565,6 +565,18 @@ echo 'ret=$?' >> $T/script
 echo "cat $T/kvm-recheck.sh.out | tee -a $resdir/$ds/log" >> $T/script
 echo 'exit $ret' >> $T/script
 
+# Extract the tests and their batches from the script.
+egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
+	sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
+	awk '
+	/^----Start/ {
+		batchno = $3;
+		next;
+	}
+	{
+		print batchno, $1, $2
+	}' > $T/batches
+
 if test "$dryrun" = script
 then
 	cat $T/script
@@ -583,21 +595,14 @@ then
 	exit 0
 elif test "$dryrun" = batches
 then
-	# Extract the tests and their batches from the script.
-	egrep 'Start batch|Starting build\.' $T/script | grep -v ">>" |
-		sed -e 's/:.*$//' -e 's/^echo //' -e 's/-ovf//' |
-		awk '
-		/^----Start/ {
-			batchno = $3;
-			next;
-		}
-		{
-			print batchno, $1, $2
-		}'
+	cat $T/batches
+	exit 0
 else
-	# Not a dryrun, so run the script.
+	# Not a dryrun.  Record the batches and the number of CPUs, then run the script.
 	bash $T/script
 	ret=$?
+	cp $T/batches $resdir/$ds/batches
+	echo '#' cpus=$cpus >> $resdir/$ds/batches
 	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a $resdir/$ds/log
 	exit $ret
 fi
