Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E53B8413
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhF3NwN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhF3NvA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:51:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F5C061147;
        Wed, 30 Jun 2021 06:47:53 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KQToZBUINs+hQK7wzJieFS/Xbm2iS7spVCtHpQjE30k=;
        b=ytGojfUg0KPaoQIT7fAIzLsOEL+JwoyIHaHb7nGKhI1nXTHDv+Pb/ovdShQi4k9Zr/K77I
        OvR5OaM548+ctC9Vs9VMs2LxdZPK3N9L54BkaUBdX2tQN1hXjv1MN3c02fcJOy8Odt0uOw
        m3Qsuv35sIJnGZJ7OTsHPn6CLZ0FeC0snsw5vGpvZqySJPVcmyyAicNwGCwkwCSA556Pn5
        Itugx4i9+6ZXML+1g2Iokh7MsVNGER4YghOBHXn3xfkPIZPR2R8piub69sbTnOoaTOvISL
        PbXNNInyO65MCZSTXcav/lNbdhNG1aMoRM0ZMCD1YBa44kDfiCGfn7kxT7MHDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KQToZBUINs+hQK7wzJieFS/Xbm2iS7spVCtHpQjE30k=;
        b=B2Rhl2ymGDpvO+aIGHOUrDSUUfApi6B2FOJqz1doefwKvkcEMS0d6K4U5pMUjspGV4UVge
        iKX/BpnUAgwu81AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Fix remaining erroneous torture.sh instance of $*
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087072.395.10547039460603686341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     98da77199f0c629f0687b92824f1da2010f677e3
Gitweb:        https://git.kernel.org/tip/98da77199f0c629f0687b92824f1da2010f677e3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 14:15:00 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

torture: Fix remaining erroneous torture.sh instance of $*

Although "eval" was removed from torture.sh, that commit failed to
update the KCSAN instance of $* to "$@".  This results in failures when
(for example) --bootargs is given more than one argument.  This commit
therefore makes this change.

There is one remaining instance of $* in torture.sh, but this
is used only in the "echo" command, where quoting doesn't matter
so much.

Fixes: 197220d4a334 ("torture: Remove use of "eval" in torture.sh")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 56e2e1a..53ec7c0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -302,7 +302,7 @@ function torture_set {
 			kcsan_kmake_tag="--kmake-args"
 			cur_kcsan_kmake_args="$kcsan_kmake_args"
 		fi
-		torture_one $* --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
+		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
 	fi
 }
 
