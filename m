Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC76D35B4BB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbhDKNoF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhDKNn6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:58 -0400
Date:   Sun, 11 Apr 2021 13:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tQ8stdrtKMfOJ/asJL5FYmglz5gb9af7WUly4zcGvD4=;
        b=HN/xJ/++c6n2AiZPFVd+iD7HdmGHa2KeinrJVg4LlQtEm9YGUoO01WPhbWx4Q1COLldIUg
        pk/JnNmlNO2c4dVBF9xE5SCxzPbwOGqylrEoUM9g3V0sBXadltHtwe8Sop93ijm2i8udpU
        5AbtploHXAXam1aVXxPer84x1R2GUtz0zZlh54bJbiTPWkAkYBSlesJygL4Hcn3pAMxqcg
        q2YSF4yyWwuC1I2KZ0jI6XkCBHp/UOY5+IwRQR0XrjivqFM08KSxN5N1hoKToWhx5FRe8D
        riGD3FoWxy0K3R9q6xZSrRbxaVs2rOP+Oy6VOAZNvt1Uolbh8+dIbia5n6bTPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tQ8stdrtKMfOJ/asJL5FYmglz5gb9af7WUly4zcGvD4=;
        b=ceNF6WgiJnO+UKOanpe1rGfAD6HjnAIUBIT7gQWZDVWmDgmHOocp0zFo3mwzcBc1haZUAU
        BImI1lzwGXsu1sDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: De-capitalize TORTURE_SUITE
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860185.29796.3251426663515542155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7ef0d5a33c81cfb1993f2947c361784b1b02adc8
Gitweb:        https://git.kernel.org/tip/7ef0d5a33c81cfb1993f2947c361784b1b02adc8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Feb 2021 14:04:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:18 -07:00

torture: De-capitalize TORTURE_SUITE

Although it might be unlikely that someone would name a scenario
"TORTURE_SUITE", they are within their rights to do so.  This script
therefore renames the "TORTURE_SUITE" file in the top-level date-stamped
directory within "res" to "torture_suite" to avoid this name collision.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 47cf4db..e01b31b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -30,7 +30,7 @@ do
 			resdir=`echo $i | sed -e 's,/$,,' -e 's,/[^/]*$,,'`
 			head -1 $resdir/log
 		fi
-		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		TORTURE_SUITE="`cat $i/../torture_suite`"
 		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 03364f4..a1cd05c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -405,7 +405,7 @@ echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
 echo $scriptname $args >> $resdir/$ds/log
-echo ${TORTURE_SUITE} > $resdir/$ds/TORTURE_SUITE
+echo ${TORTURE_SUITE} > $resdir/$ds/torture_suite
 echo Build directory: `pwd` > $resdir/$ds/testid.txt
 if test -d .git
 then
