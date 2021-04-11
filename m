Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C0B35B4B7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhDKNoE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbhDKNn6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:58 -0400
Date:   Sun, 11 Apr 2021 13:43:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y0mcIusO5rGfnWVrQhmChE4BqzbMg++HvS1yMSlLdH8=;
        b=uicCiVAQKbtWs9QvgKy9zOA/miqOE3rCUZEsIopmmfbMnFhxDTOnRBrK7q8avIlddHqU8T
        MLqh0q8rQRgrvZR6w8UeQZMehT9oNT7BZv8ypZAfwN8hz9vdiGdwHMHRfbmMGJEM82B8ED
        XH1T6CXmDUMJ3KIH8pneUT+Fw5LA40nnX3QuPcwRUUGri+CW9sPiMkochPB4RZMggm19Wu
        JO5R7frC0wdd6FgUM76CQRUg2sPzFF0vriQk5CG8oiHhWEWzaBpt3waLGHGNnj3SCjkP+9
        ecZkDXdmpDVO1JJv292UDRR+IznECXhvW+y9sTvdgOP7BfX5RFc9Tw9mUWA/Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y0mcIusO5rGfnWVrQhmChE4BqzbMg++HvS1yMSlLdH8=;
        b=H3aSoLGL1Pv4pdi0xFnoVK1wtweKp6N+iOkiDBkpMrUW6GMKJrAnxFoJfi08u4RZnav5xJ
        ckJ/ViKhKdx5jlBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make TORTURE_TRUST_MAKE available in
 kvm-again.sh environment
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859999.29796.11346908512692916881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a5dbe2524f553a1283b3364ff91e96bfb618ceab
Gitweb:        https://git.kernel.org/tip/a5dbe2524f553a1283b3364ff91e96bfb618ceab
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 12:07:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:20 -07:00

torture: Make TORTURE_TRUST_MAKE available in kvm-again.sh environment

Because the TORTURE_TRUST_MAKE environment variable is not recorded,
kvm-again.sh runs can result in the parse-build.sh script emitting
false-positive "BUG: TREE03 no build" messages.  These messages are
intended to complain about any lack of compiler invocations when the
--trust-make flag is not given to kvm.sh.  However, when this flag is
given to kvm.sh (and thus when TORTURE_TRUST_MAKE=y), lack of compiler
invocations is expected behavior when rebuilding from identical source
code.

This commit therefore makes kvm-test-1-run.sh record the value of the
TORTURE_TRUST_MAKE environment variable as an additional comment in the
qemu-cmd file, and also makes kvm-again.sh reconstitute that variable
from that comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh      | 5 +++++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 3fb57ce..f1c80b0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -161,6 +161,11 @@ do
 	fi
 	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
 done
+
+# Extract settings from the last qemu-cmd file transformed above.
+grep '^#' $i | sed -e 's/^# //' > $T/qemu-cmd-settings
+. $T/qemu-cmd-settings
+
 grep -v '^#' $T/batches.oldrun | awk '
 BEGIN {
 	oldbatch = 1;
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index a386ca8..420ed5c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -204,6 +204,7 @@ echo "# seconds=$seconds" >> $resdir/qemu-cmd
 echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
 echo "# TORTURE_JITTER_START=\"$TORTURE_JITTER_START\"" >> $resdir/qemu-cmd
 echo "# TORTURE_JITTER_STOP=\"$TORTURE_JITTER_STOP\"" >> $resdir/qemu-cmd
+echo "# TORTURE_TRUST_MAKE=\"$TORTURE_TRUST_MAKE\"; export TORTURE_TRUST_MAKE" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
