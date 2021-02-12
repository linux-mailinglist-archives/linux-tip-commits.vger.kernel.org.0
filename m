Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE2319E9F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBLMjF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhBLMh6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:58 -0500
Date:   Fri, 12 Feb 2021 12:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yNI5lslDd/w4n00Ms5X3bViBk0bE1SCKgyFXGOizWPg=;
        b=FGqqbQbbKkxPn0dMM2pbF/LdBy6ieiRSm1vaSHuE7t6fOxx5AmEsBKxR9HhJIVcgUyxg5d
        9OxBQ71Fu9TXAc4caoYyvkybHWX3tJcCq5KxpDuD+iNmW8PHjGgzlUz8NvzsGYRKL7gGmj
        GHzXd8QhXN4mbz7kuZEE7Jxg9Erp4BKCEYJut8p16bJFfJyIReZufoD4bYrTrH9YTgc+q2
        SucAT/ntvUxnZBZB/6d0kxJP61MUz4plQKLswcnpSfAevsgfx6AvDrP54BDq8guiMJExX4
        zbJ9GiV5FA+Sti8ZpZI1DRRF3H4gckCUCYHGgWx05AYTqBDlLjcNR13HMgA0LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yNI5lslDd/w4n00Ms5X3bViBk0bE1SCKgyFXGOizWPg=;
        b=Fd3RwdMlGthqd6I9qiL5L+FxekJX4yMGJ8XXCjeTCQRaAMyAFf3U/Yb6XzYyppEnDFfQd8
        O5BgDqdCkUZ8KdCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh refscale runs use
 verbose_batched module parameter
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343324.23325.7019393927048876555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     264da4832b3af4a1a4cc83df1c5fe2d43429faa6
Gitweb:        https://git.kernel.org/tip/264da4832b3af4a1a4cc83df1c5fe2d43429faa6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 19:13:52 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:42 -08:00

torture: Make torture.sh refscale runs use verbose_batched module parameter

On large systems, the refscale printk() rate can overrun the file system's
ability to accept console log messages.  This commit therefore uses the
new verbose_batched module parameter to rate-limit some of the higher-rate
printk() calls.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a89b521..a3c3c25 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -24,6 +24,11 @@ if test "$HALF_ALLOTED_CPUS" -lt 1
 then
 	HALF_ALLOTED_CPUS=1
 fi
+VERBOSE_BATCH_CPUS=$((TORTURE_ALLOTED_CPUS/16))
+if test "$VERBOSE_BATCH_CPUS" -lt 2
+then
+	VERBOSE_BATCH_CPUS=0
+fi
 
 # Default duration and apportionment.
 duration_base=10
@@ -309,7 +314,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
