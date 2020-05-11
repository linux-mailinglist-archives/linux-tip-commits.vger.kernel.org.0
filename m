Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1C1CE708
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 May 2020 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgEKVFs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 May 2020 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729501AbgEKU7R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 May 2020 16:59:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572BC061A0C;
        Mon, 11 May 2020 13:59:17 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW7-0005et-IF; Mon, 11 May 2020 22:59:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 39F691C0494;
        Mon, 11 May 2020 22:59:15 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:15 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow scenario-specific Kconfig options to
 override CFcommon
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075516.390.16456820083714310693.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5b6b4b69ad6494733dafa090c09dd80eda741d1f
Gitweb:        https://git.kernel.org/tip/5b6b4b69ad6494733dafa090c09dd80eda741d1f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 16:38:20 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

torture: Allow scenario-specific Kconfig options to override CFcommon

This commit applies config_override_param() to allow scenario-specific
Kconfig options to override those in CFcommon.  This in turn will allow
additional Kconfig options to be placed in CFcommon, for example, an
option common to all but a few scenario can be placed in CFcommon and
then overridden in those few scenarios.  Plus this change saves one
whole line of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b7296f1..c7534fd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -67,12 +67,11 @@ if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
 	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
-	config_override.sh $config_dir/CFcommon $config_template > $T/Kc1
+	cp $config_dir/CFcommon $T/Kc0
 else
-	cp $config_template $T/Kc1
+	echo > $T/Kc0
 fi
-echo " --- $config_template" >> $resdir/ConfigFragment.input
-cat $config_template >> $resdir/ConfigFragment.input
+config_override_param "$config_template" Kc0 Kc1 "`cat $config_template 2> /dev/null`"
 config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
 cp $T/Kc3 $resdir/ConfigFragment
