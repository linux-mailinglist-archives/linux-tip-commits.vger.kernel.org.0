Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EFF319EF1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBLMnm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBLMl5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:41:57 -0500
Date:   Fri, 12 Feb 2021 12:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R7h6vP5N2IOFiISZG39cft1s81uUcxhFdJyHZSukIWA=;
        b=1s06tOIiJs1vmjjaC3FmeiKVuH+WdX1oNghGzf2Nl5EhRrb89DmDOfxAViPkITlK2otjIw
        zg5Kqv5HVXe2BOMhu6jtv0Wd/V4ZKNxo4CnQeuyxgttfbv8wplHXBkG/B1p7vNjRsqCOp2
        x5MnPyiKfwexBbCu9vNHpZNQ3XgT44c9xTsfYqrKdm/jp4gPdJnbKQjdN6DDGtzcfPzOVU
        MDiEiSyUkmiD4xb2bv7BfM8vKZr+cwk32RvuZGER3J2bErT52OrCzEKKt4FDhTVmxEDmAP
        CiPgDIDFOEcLwHikPUvsYPDqOEQvutExobqOcQcQ7Uqt47GGrlaUzbArIIsn7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=R7h6vP5N2IOFiISZG39cft1s81uUcxhFdJyHZSukIWA=;
        b=azqeDiq5VQvYu+k+HoQYvwdfhcgaAVuNKd26kZDwTFsOPp8Hf9iDx5LXP9HyBsQwqaS1eK
        srzUsGasIFSZmNCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove "Failed to add ttynull console" false
 positive
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344496.23325.8051214632082403476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     546eee2d931b3d76357a9c813778203001375fe1
Gitweb:        https://git.kernel.org/tip/546eee2d931b3d76357a9c813778203001375fe1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 23 Dec 2020 10:35:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:25 -08:00

torture: Remove "Failed to add ttynull console" false positive

Commit 757055ae8ded ("init/console: Use ttynull as a fallback when
there is no console") results in the string "Warning: Failed to add
ttynull console. No stdin, stdout, and stderr for the init process!"
appearing on the console, which the rcutorture scripting interprets as
a warning, which causes every rcutorture run to be flagged.  However,
the rcutorture init process never attempts to do any I/O, and thus does
not care that it has no stdin, stdout, or stderr.

This commit therefore causes the rcutorture scripting to ignore this
message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 1 +
 tools/testing/selftests/rcutorture/bin/parse-console.sh   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 80ae7f0..e6a132d 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -14,4 +14,5 @@ egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls o
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
+grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr.*the init process!' |
 grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 263b1be..9f624bd 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -128,7 +128,7 @@ then
 	then
 		summary="$summary  Badness: $n_badness"
 	fi
-	n_warn=`grep -v 'Warning: unable to open an initial console' $file | egrep -c 'WARNING:|Warn'`
+	n_warn=`grep -v 'Warning: unable to open an initial console' $file | grep -v 'Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process' | egrep -c 'WARNING:|Warn'`
 	if test "$n_warn" -ne 0
 	then
 		summary="$summary  Warnings: $n_warn"
