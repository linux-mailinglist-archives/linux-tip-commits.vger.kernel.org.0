Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877C735B4DE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhDKNoT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rnEW3qkIRfR1hkL3qIvpTeqKa/DVZ5PC9FA32LkviuQ=;
        b=b+mpVDsynzQh/5h+38H71uylntJ42BNBxgnNeeTNt4iv1Wvw3mvI/6KFtDaYSR8YYKsxG8
        jYIvR+CdiSjjlawiJg/PvvBe+LF1l2xjqiNRanRRv5sEJBrpZ7tavZfqo5lWselzcowwqa
        j9fT59MsA+Vn6mrKJMsb5+GMKs42088rB0LkXitnf7jyP76Oq2fGdpJfeZ3QCGGCq2hx0v
        bgyCemw2xFnv9048HgtLVCxhNwPYKXjK1V1VEEp3B4BgEfy6oqoQgDHaxDb+1DfFPtJQXT
        ZaVcMTf/+OcDsJeT3ZoSwktD1DuJWJhBK8hKAFgpvSiuk6Q0cgYkzlI8dngafQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rnEW3qkIRfR1hkL3qIvpTeqKa/DVZ5PC9FA32LkviuQ=;
        b=jjvCZooTXwq9qe0ae26zogHmSG0DBB3mgvwRg8COtqdLtA4YGn75plTMNm9MmegWtCdx8m
        KLNwacl5vO/1mUDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Disable verbose torture-test output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861109.29796.8899087504876908130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0e7457b550233314394574c6bdc890de9131daf5
Gitweb:        https://git.kernel.org/tip/0e7457b550233314394574c6bdc890de9131daf5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 10:15:02 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

rcuscale: Disable verbose torture-test output

Given large numbers of threads, the quantity of torture-test output is
sufficient to sometimes result in RCU CPU stall warnings.  The probability
of these stall warnings was greatly reduced by batching the output,
but the warnings were not eliminated.  However, the actual test only
depends on console output that is printed even when rcuscale.verbose=0.
This commit therefore causes this test to run with rcuscale.verbose=0.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
index 0333e9b..ffbe151 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -12,5 +12,5 @@
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
 	echo $1 rcuscale.shutdown=1 \
-		rcuscale.verbose=1
+		rcuscale.verbose=0
 }
