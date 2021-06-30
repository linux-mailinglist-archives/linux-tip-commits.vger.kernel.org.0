Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E73B83E5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbhF3NvL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhF3Nua (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CDC0611BD;
        Wed, 30 Jun 2021 06:47:46 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cAp779Qi+dousZC1T2SIbDm34k+8aAzWeU/Hxxx5KAE=;
        b=lkC7Uhi7BM2nC+jP4lC7M/nOED2tOKiUjZWac0IkpIyDW82LXtU39MgdczXXxmYXkrNnfz
        ttP+m59RTilzgBKwJSyPSoW8oNAov+qdB9zNbr45Ovy5cMgcyr0OQIjyVEzTrxYlimVl0j
        DsjooC2LTvF3hnFB705cieKDY6MKwcWpeoC9Oq3YiU45hfYG88/T5iy0dePOBnPFjIX41d
        +cFX8K8mSiiNASWcSsBZiC4uylYts31fz2DQPdK1y0gmYsQ0dRE42Ose10hdor9ZO8wh4Z
        T9Ewt5j9gzfW/+KKV2HNUlm8ACZ5ukzWVVXZAIGOSAccMSZB9OrhDifsruajsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cAp779Qi+dousZC1T2SIbDm34k+8aAzWeU/Hxxx5KAE=;
        b=+Piu6ggAsRaODdSyCxjNQNClAs7ZQ43TJNDXympcl6v3KfVHFG7msgXe6g0FT4nIA2E+p9
        swG3ddwDszS3BFAw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm-find-errors.sh account for kvm-remote.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086459.395.10105526779071065098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     226dd39d23487c01ab5cc1d68eba142a4dc76a08
Gitweb:        https://git.kernel.org/tip/226dd39d23487c01ab5cc1d68eba142a4dc76a08
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 25 Mar 2021 19:39:14 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture: Make kvm-find-errors.sh account for kvm-remote.sh

Currently, kvm-find-errors.sh assumes that if "--buildonly" appears in
the log file, then the run did builds but ran no kernels.  This breaks
with kvm-remote.sh, which uses kvm.sh to do a build, then kvm-again.sh
to run the kernels built on remote systems.  This commit therefore adds
a check for a kvm-remote.sh run.

While in the area, this commit checks for "--build-only" as well as
"--build-only".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 0670841..daf64b5 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -43,7 +43,7 @@ then
 else
 	echo No build errors.
 fi
-if grep -q -e "--buildonly" < ${rundir}/log
+if grep -q -e "--build-\?only" < ${rundir}/log && ! test -f "${rundir}/remote-log"
 then
 	echo Build-only run, no console logs to check.
 	exit $editorret
