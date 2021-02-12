Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D584319EEE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhBLMnh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBLMln (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:41:43 -0500
Date:   Fri, 12 Feb 2021 12:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8uywMPyriBqInRZWtFwz7QFlNva+k4SLODcZZc6VcWE=;
        b=2Yd6+42FphYUj1HNLluV3cu8K585KlL8if0YQeyxu/5ZG9qGEHBJs1OgRk1MO5F/dh8snK
        pC5mU/J1RnOJBt/avaV1e4GUJF9Z6kC9BFmuQJIri3c4quoDws0mWvwpUa+ZLgXASNkZj1
        xuibUiRnqIF5vj6lYEIC6Fu9uQcyccxAQ1LG5HWro0L47lxuuqIkyKRPnF/bkE8BvZjFNl
        CE474tKuiRU7w+IpPdqTa95YORXwvNwQPSlJz61k+yHlZnahPlqjsQaY4LEwebCu/CIwEg
        JUsNtVp/ioRsKr+Vl1CPdhn7OIz+ZxNbWjiFjN5aRUMT9WuNMcjOLItBIDGqZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8uywMPyriBqInRZWtFwz7QFlNva+k4SLODcZZc6VcWE=;
        b=IF2/OU6afIJERKlAek641Q+nXih9pdapt3NAuAJkxZq6EB1skHJ/lWBR9NUqf+e40UcM8F
        MxletGvewKdvI+AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow standalone kvm-recheck.sh run detect
 --trust-make
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344474.23325.7062719627645844778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b79b0b67791316e6ca0502bd0f2ecd7018d6d9e8
Gitweb:        https://git.kernel.org/tip/b79b0b67791316e6ca0502bd0f2ecd7018d6d9e8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 23 Dec 2020 16:00:27 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:25 -08:00

torture: Allow standalone kvm-recheck.sh run detect --trust-make

Normally, kvm-recheck.sh is run from kvm.sh, which provides the
TORTURE_TRUST_MAKE environment variable that, if a non-empty string,
indicates that the --trust-make command-line parameter has been passed
to kvm.sh.  If there was no --trust-make, kvm-recheck.sh insists
that the Make.out file contain at least one "CC" command.  Thus, when
kvm-recheck.sh is run standalone to evaluate a prior --trust-make run,
it will incorrectly insist that a proper kernel build did not happen.

This commit therefore causes kvm-recheck.sh to also search the "log"
file in the top-level results directory for the string "--trust-make".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-build.sh b/tools/testing/selftests/rcutorture/bin/parse-build.sh
index 09155c1..9313e50 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-build.sh
@@ -21,7 +21,7 @@ mkdir $T
 
 . functions.sh
 
-if grep -q CC < $F || test -n "$TORTURE_TRUST_MAKE"
+if grep -q CC < $F || test -n "$TORTURE_TRUST_MAKE" || grep -qe --trust-make < `dirname $F`/../log
 then
 	:
 else
