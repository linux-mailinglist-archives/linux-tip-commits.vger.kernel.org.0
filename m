Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D51C31BB81
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBOO41 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBOO4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:24 -0500
Date:   Mon, 15 Feb 2021 14:55:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G8mmpCwhb8xuFQevmP3g7RpCIoGXzq7kM7jh8PBOP+I=;
        b=0ALAjU8S58hTMpumI0gfWeGr6FoOrgIjfjA/3jOg2Glp/ZZTZpnZkBWK/mGv06dmuuZkVw
        dy2gSeGdGWi2T7xhNh77aWZCSN518LAQzlO6TRxhJkbDqzXP3jXS5FTW6XRLN3K0J2T1U2
        Foac3X90AbttQKenaZkK1Ex41rx7zPIGtgF7ZR7L1F8RD3BRcLb+ek1K949KBN0kBDxY/V
        a3VdS1c2DAod2GCE43HExtE210eNc5vF6SyrrNHw9uyJfkYcTp2nD2SNhcxf8z8LRc00jZ
        L9UDmtof+ENxV+GlMWnxM9E09O3inzqo5xN4AUGYp3SDsZdhsf8y+/mIL+ut8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G8mmpCwhb8xuFQevmP3g7RpCIoGXzq7kM7jh8PBOP+I=;
        b=LC811va6SIGLlMiKY/E5zf1NI0rn9ywm4cm2d1kd48UOsDuSyp5aVA0sq7MP2+3Ik9alw5
        8+ZkCqAA2A3Rg7AA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make --kcsan specify lockdep
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094157.20312.15581602818894425793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0682aa7acd5d2688a8b781d91938e21ae4717c52
Gitweb:        https://git.kernel.org/tip/0682aa7acd5d2688a8b781d91938e21ae4717c52
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 05 Nov 2020 20:01:46 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:17 -08:00

torture: Make --kcsan specify lockdep

The --kcsan argument to kvm.sh adds CONFIG_KCSAN_VERBOSE=y in order to
get more detail from the KCSAN reports.  However, this Kconfig option
requires lockdep to be enabled.  This commit therefore causes --kcsan
to also enable lockdep.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 45d07b7..bd07df7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -169,7 +169,7 @@ do
 		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_INTERRUPT_WATCHER=y CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
