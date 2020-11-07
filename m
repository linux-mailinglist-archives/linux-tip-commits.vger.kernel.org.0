Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A12AA629
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgKGPOB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgKGPOB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:14:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15048C0613CF;
        Sat,  7 Nov 2020 07:14:01 -0800 (PST)
Date:   Sat, 07 Nov 2020 15:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2L1Ab5lfKvpXfP4ba2r896rfGE+wEzY7ZUOzSpCenXo=;
        b=gziXdjJWnrzpxCVQgJQBLirpzHvmdsSnfipfynK146uj7Xrn3b6XK6DXZfAHcRUWzxfIlG
        sVTP99HeSQKgYtWx/2x5t8A35oEVmec69zsoNYNBA3MZ1m3xBjuw//Te5fa4k35wNdwO6d
        QapALAF36EDdbg8LABL/wA3rKq+VjJ0S8CrmP2uSf538/k44laPpgD5yMPNIgxpGKx1TcN
        wekiZkKgJoMJRfUL7LWHHQXqWEY/tjSZjn+xqRU7BhDKld07pia1sufL/guZswmvzaMeRq
        KzuQOIinBkG4WsUYysHR+338DsNJp4aRbdJAd3tAK8JKhArGnrQubzMRuCuNoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2L1Ab5lfKvpXfP4ba2r896rfGE+wEzY7ZUOzSpCenXo=;
        b=vAavmJfvnSDMpTWQzQCImP8ZeR3UtdYSCBTgLU6fvxMXQ+eFMQSWVb8dmcBcZf9/w7Ytp5
        DiWpB573AKv0naCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/kprobes] locking/atomics: Regenerate the atomics-check SHA1's
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org
MIME-Version: 1.0
Message-ID: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/kprobes branch of tip:

Commit-ID:     a70a04b3844f59c29573a8581d5c263225060dd6
Gitweb:        https://git.kernel.org/tip/a70a04b3844f59c29573a8581d5c263225060dd6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 07 Nov 2020 12:54:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Nov 2020 13:20:41 +01:00

locking/atomics: Regenerate the atomics-check SHA1's

The include/asm-generic/atomic-instrumented.h checksum got out
of sync, so regenerate it. (No change to actual code.)

Also make scripts/atomic/gen-atomics.sh executable, to make
it easier to use.

The auto-generated atomic header signatures are now fine:

  thule:~/tip> scripts/atomic/check-atomics.sh
  thule:~/tip>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 2 +-
 scripts/atomic/gen-atomics.sh             | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 scripts/atomic/gen-atomics.sh

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 492cc95..888b6cf 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -1830,4 +1830,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 9d5e6a315fb1335d02f0ccd3655a91c3dafcc63e
+// 4bec382e44520f4d8267e42620054db26a659ea3
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
old mode 100644
new mode 100755
