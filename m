Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5D319EF9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhBLMow (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhBLMm7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:42:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D17C061788;
        Fri, 12 Feb 2021 04:42:19 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TZTvB/OJAjpH/22fpi7NcRUqa3yqWhljRdHhYrUWG5w=;
        b=BKlbGpwbNHDI0wEW/FM4g6xrfgf/ebeSRIm4kMd8bQSSB7l4w6ReYAQkneirCZpYy8fUaa
        jWCMuVv0dB+GRNtj/kTE0xESCpuhwhc2c6n7iTljw2DSry++LrL5VrKVp4a46FoOw+JS2I
        Y/j+oXwf3UiRYP7hz9IPf2zzLmMJrCJOdKdXVtskBR6atkiJBVr2daXWg1zuGEmdCgOmok
        82bQOx2kSXXFzgtQJvkykpW66bKP8Yb5GYZCyIAhukGf+2Z7uNC+e/mRsSa/xVjvSby01X
        9pAiAAO7nN0IpWLPSIAB2yqEaOK0RfG0x2zYEKgr4nKCSaXY5UBa/d2RvmqNPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133446;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TZTvB/OJAjpH/22fpi7NcRUqa3yqWhljRdHhYrUWG5w=;
        b=qgqhplqajcMN8B1sTGvWo6lXPsJQvtqFfEwSe6pallRrTSv5pm1WoGcEtC4V4I9WE+xBcS
        gf/6I5dSzY+4LLBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Stop hanging on panic
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344587.23325.14886256316738427651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f716348f29d30e8ef3a1ceed3fea19490aba4fe4
Gitweb:        https://git.kernel.org/tip/f716348f29d30e8ef3a1ceed3fea19490aba4fe4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 03 Dec 2020 13:27:42 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:23 -08:00

torture: Stop hanging on panic

By default, the "panic" kernel parameter is zero, which causes the kernel
to loop indefinitely after a panic().  The rcutorture scripting will
eventually kill the corresponding qemu process, but only after waiting
for the full run duration plus a few minutes.  This works, but delays
notifying the developer of the failure.

This commit therefore causes the rcutorture scripting to pass the
"panic=-1" kernel parameter, which caused the kernel to instead
unceremoniously shut down immediately.  This in turn causes qemu to
terminate, so that if all of the runs in a given batch panic(), the
rcutorture scripting can immediately proceed to the next batch.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 97c3a17..c35ba24 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -203,6 +203,7 @@ identify_qemu () {
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
 	echo debug_boot_weak_hash
+	echo panic=-1
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
