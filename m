Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737372D9028
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgLMT3L (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:29:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgLMTBw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:52 -0500
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wyuz1qwcKzz7OfIHnWtF6Jszr8USP3Xd1BnEymf+35g=;
        b=SrvKQkI4WvyMA/bWLdFGSXYur2jXQXDZ/g8KLUTp/Evs34kp37eRjtg65gcTn2fpNztlCh
        3kYNCwtLr4hdrLsKH73Z7TTE8NpxFJLvi/7LZC+drg6Uitrn7rvKlD1HJFxKAcKRNRS10/
        NkquQ7maOAjFu3rglo0vsSO4pv+Wp+KDspycY2tn8u9Gt4NIJZyNH9Ci0TmRjpl9Llhhx1
        81Q1tvq9QURp7fBmOIJpUfT/5TT5IV3w+Qn485wEV++xxB3l9q9aHpeEybR+PC9D/OSyQR
        ZrgW4UCE4vYJjlwq2aBzzTVMBXnHFfFVcCecY/Y4Js2MV/f+bSFHr6zSSZv9Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Wyuz1qwcKzz7OfIHnWtF6Jszr8USP3Xd1BnEymf+35g=;
        b=yr4hIsFzPQtfGN2AgD8wbjPrYu3c2eDFDb3f1jNbZNf/kgrW+y2lcQGZAyivXAllN9FNRV
        W4sx6atyYgtk4GAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Avoid divide by zero
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607020.3364.5324008911727833048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     45c7b962014da36c2ac1aee6e5014b644ba37a84
Gitweb:        https://git.kernel.org/tip/45c7b962014da36c2ac1aee6e5014b644ba37a84
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 09 Sep 2020 22:24:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:50 -08:00

rcuscale: Avoid divide by zero

The rcuscale test module does not use batches, so there is only
ever one batch.  This commit therefore informs the kvm-recheck-rcuscale.sh
script of this fact of life.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
index aa74515..b582113 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -32,7 +32,7 @@ sed -e 's/^\[[^]]*]//' < $i/console.log |
 awk '
 /-scale: .* gps: .* batches:/ {
 	ngps = $9;
-	nbatches = $11;
+	nbatches = 1;
 }
 
 /-scale: .*writer-duration/ {
