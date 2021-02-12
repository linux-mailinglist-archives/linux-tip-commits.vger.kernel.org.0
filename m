Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80734319EC8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBLMlF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhBLMj7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C2C06121F;
        Fri, 12 Feb 2021 04:37:15 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UDUalJTt/jqtg6oJH+CEsGTRZwi+5wXZHODP0bXZbig=;
        b=4V9BclZF5XPINaSM+Ofd6Vsc9J+K7xSYJ6L0MTVd3eO8u5JQgZilD3EUL26Hz7aSy/rtsU
        H0/VtksAeLkf9PNe6Nv+QUTI3xkIKcffyhCfBbXHFvfVCWxrUl5zN034R3CwtLAbix2ZaP
        h9wY9pBOlGdmdnTALF8usmNMnWzJhWfc0ChC5jU5gP2cNVmHeDSNrnY2MVuTVH5hjFfyV/
        cFoR6fiCiedC0Zw5PoP0D4SBxqTW8xNX8h+S27JVOwTJzw26gqCczdvDesGjr0OqHkIO+C
        UB1PpLeaLo9mNTyREJ+8X0xLhK9XqyOJ4vg+gbnJNkLZtoZ2b66thGaoQ0BJgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UDUalJTt/jqtg6oJH+CEsGTRZwi+5wXZHODP0bXZbig=;
        b=JVbJnN8TTjosRmxqBuogvmuza/gBob/V31s9/ITNia8wCw9wMVGKc12EiPkI/Y4vuyulzN
        FSE7YoxvFKRwstAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Drop log.long generation from torture.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343208.23325.4368599282680839646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5ae5f7453f93b21e06296e78e8481ba8baaaa55e
Gitweb:        https://git.kernel.org/tip/5ae5f7453f93b21e06296e78e8481ba8baaaa55e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 26 Nov 2020 21:27:27 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:45 -08:00

torture: Drop log.long generation from torture.sh

Now that kvm.sh puts all the relevant details in the "log" file,
there is no need for torture.sh to generate a separate "log.long"
file.  This commit therefore drops this from torture.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 43ef2c0..cf74123 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -203,11 +203,8 @@ function torture_one {
 	"$@" $boottag "$cur_bootargs" --datestamp "$ds/results-$curflavor" > $T/$curflavor.out 2>&1
 	retcode=$?
 	resdir="`grep '^Results directory: ' $T/$curflavor.out | tail -1 | sed -e 's/^Results directory: //'`"
-	if test -n "$resdir"
+	if test -z "$resdir"
 	then
-		cp $T/$curflavor.out $resdir/log.long
-		echo retcode=$retcode >> $resdir/log.long
-	else
 		cat $T/$curflavor.out | tee -a $T/log
 		echo retcode=$retcode | tee -a $T/log
 	fi
