Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710E83B8402
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhF3NwA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhF3Nup (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4710C061766;
        Wed, 30 Jun 2021 06:47:48 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2krgRd219YXiOUwGsaBvc91IkP9DZ5wTkoQq62fZq8Q=;
        b=B8h53BJ3LAlsNXT4npX9akwbatUFndVVhaCR5FzZLxjqc6nc2pppeyjTj7qcjG8rK1m2df
        5t5aOynwdQnWid8gWgrR52+tsP9LDAZh4rGQMX93c3akpRftHxeT1YDDYOIcoRY0q/R0W6
        sYDylNs3g6LeCiUgyZJvPWf1DtMUjVyivChYr+WJgZcPom6hiup9SGR2RfLbZJ7MrqWteA
        QWM7HgvVKaI8jxRdIIzzc7rmx86cW08/Rae6cub9WrlzOS0b2s5pSQM2uHPP3MVi6RmORw
        sylDkIF0uN8R4Gk08X2Giks+fXxSvK+JP6+i1UMnUhdcPp1GnGv8fCAn74YNJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060867;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2krgRd219YXiOUwGsaBvc91IkP9DZ5wTkoQq62fZq8Q=;
        b=vPXb98tGBTWyOFVLejgHFx9Xf4OKSa+gZVPSrNPWEAjS88suyhj3PaOA7I6a8nMI84fkdh
        6OEwIioc9436mzDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Fix grace-period rate output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086667.395.17394502646952476174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     32dbdaf71ab9b606d0649616039c897df2b03e47
Gitweb:        https://git.kernel.org/tip/32dbdaf71ab9b606d0649616039c897df2b03e47
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 14 Mar 2021 15:19:59 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture: Fix grace-period rate output

The kvm-again.sh script relies on shell comments added to the qemu-cmd
file, but this means that code extracting values from the QEMU command in
this file must grep out those commment.  Which kvm-recheck-rcu.sh failed
to do, which destroyed its grace-period-per-second calculation.  This
commit therefore adds the needed "grep -v '^#'" to kvm-recheck-rcu.sh.

Fixes: 315957cad445 ("torture: Prepare for splitting qemu execution from kvm-test-1-run.sh")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 1706cd4..fbdf162 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -31,7 +31,7 @@ then
 	echo "$configfile ------- " $stopstate
 else
 	title="$configfile ------- $ngps GPs"
-	dur=`sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`
+	dur=`grep -v '^#' $i/qemu-cmd | sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//'`
 	if test -z "$dur"
 	then
 		:
