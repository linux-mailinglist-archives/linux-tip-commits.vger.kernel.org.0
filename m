Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B664190931
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCXJQ4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:16:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44010 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgCXJQz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg5-00087h-0U; Tue, 24 Mar 2020 10:16:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6246E1C04CC;
        Tue, 24 Mar 2020 10:16:44 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:44 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Allow CPU-hotplug to be disabled via --bootargs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140401.28353.10307591438676161836.tip-bot2@tip-bot2>
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

Commit-ID:     7aabb6f839622bc96a425d93f3f7373167be1e19
Gitweb:        https://git.kernel.org/tip/7aabb6f839622bc96a425d93f3f7373167be1e19
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 23 Jan 2020 12:32:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:59:59 -08:00

locktorture: Allow CPU-hotplug to be disabled via --bootargs

The bootparam_hotplug_cpu() bash function was checking for CPU-hotplug
kernel-boot parameters from --bootargs, but that check was specific to
rcutorture ("rcutorture\.onoff_").  This commit therefore makes this
check also work for locktorture ("torture\.onoff_").

Note that rcuperf does not do CPU-hotplug operations, so it is not
necessary to make a similar change for rcuperf.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index c3a49fb..1281022 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -12,7 +12,7 @@
 # Returns 1 if the specified boot-parameter string tells rcutorture to
 # test CPU-hotplug operations.
 bootparam_hotplug_cpu () {
-	echo "$1" | grep -q "rcutorture\.onoff_"
+	echo "$1" | grep -q "torture\.onoff_"
 }
 
 # checkarg --argname argtype $# arg mustmatch cannotmatch
