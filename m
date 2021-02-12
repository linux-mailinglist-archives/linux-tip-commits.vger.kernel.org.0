Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1205F319EFB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhBLMo5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:44:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBLMnC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:02 -0500
Date:   Fri, 12 Feb 2021 12:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pjkc5N2TceMumOy90JUs6wn+bWAUNWZWhbjYtWc6QbA=;
        b=M6ZdMHtGAdsNoE8NtgyjYFuauK5Pmzk47YzfKU38zCrtA9chKKwukNVO1zr4KmcrgojapR
        uP90GI+pL8eLIMUBFDDf8bBiL+PzSHGaDUGTST9+iAiibTRX86iWAI7ZW4vOesg6Dr4I65
        0c2R1IylwhHZ1FTki+YRtKdvQRz6lDee4OF5i5br5gvl4g9SVRrJEtWRMZmEutqqtom+wa
        XcBJ1It394yqYqms5PxLMDAeRAz2x8q2aKV5+S5VBkhZyv/jQbLnI9AS5towMV64k3Gydi
        wB06IWoxOdYXVEjhR12mwed35lM9jGV0kQsUtxyIpm/uCN3T7hCjMbqF3bY22g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pjkc5N2TceMumOy90JUs6wn+bWAUNWZWhbjYtWc6QbA=;
        b=bU6ePS4DWKPwNhJ39lV8m27QfMS5hfz3lyyU1tbPPc5W7YNy9j6kWZ3pabGVH4uZcTpZaF
        Jlh41dYAO7A2X3BQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh include --kconfig arguments in
 CPU calculation
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344644.23325.12313265510402198323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     22bf64cc94832a3b047a1412a4ad0f7d9bd6cd8b
Gitweb:        https://git.kernel.org/tip/22bf64cc94832a3b047a1412a4ad0f7d9bd6cd8b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 13:12:13 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:22 -08:00

torture: Make kvm.sh include --kconfig arguments in CPU calculation

Currently, passing something like "--kconfig CONFIG_NR_CPUS=2" to kvm.sh
has no effect on scenario scheduling.  For scenarios that do not specify
the number of CPUs, this can result in kvm.sh wastefully scheduling only
one scenario at a time even when the --kconfig argument would allow
a number to be run concurrently.  This commit therefore makes kvm.sh
consider the --kconfig arguments when scheduling scenarios across the
available CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6f21268..472929c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -290,7 +290,13 @@ for CF1 in $configs_derep
 do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
-		cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
+		if echo "$TORTURE_KCONFIG_ARG" | grep -q '\<CONFIG_NR_CPUS='
+		then
+			echo "$TORTURE_KCONFIG_ARG" | tr -s ' ' | tr ' ' '\012' > $T/KCONFIG_ARG
+			cpu_count=`configNR_CPUS.sh $T/KCONFIG_ARG`
+		else
+			cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
+		fi
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		echo $CF1 $cpu_count >> $T/cfgcpu
