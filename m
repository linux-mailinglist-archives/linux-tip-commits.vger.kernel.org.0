Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF964319E9B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhBLMjB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhBLMhz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:55 -0500
Date:   Fri, 12 Feb 2021 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vHc15qm/jnmc8J/9G+/9IH3OtG4z//9J/qxoZX3zoZM=;
        b=g3h9ZL6G6tE0bEQVN5yjupYYud2rNgquzwuZVrMOzOPPEh2QToOyXC88vIBVlGv4ogs75H
        IE05MqGEEmNjhNEVAC3ZwVGt+6D5hjedaM/vd1xzOC+rY098CnGQk1NycPOiRmeIXBfI7G
        Kn8zxCo8DBRUGJsI1UCQX0p0H05y6dUcHTOeTBvpDWIxTvVmdoz9rAA5NdGyunNAplY068
        gZtJpM6RbiqoDI0dsmPCKf1c+hUZVQB31xFZzTEArmSMaGtzxxBFyCCkYjsE7Pfurisqhm
        DrYfdg25jFcC/jzXaECjypGRyJt/WPkL0lCLSnRnriIErk7KjulF0hwthezYJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133433;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vHc15qm/jnmc8J/9G+/9IH3OtG4z//9J/qxoZX3zoZM=;
        b=H868d+qLt1Vq/7ghs7iiGS4oCFj+x1/fLFhLTwPX9IWkt8mY+du1IBLZgWcpIxKo4+jJUY
        JnY7gX8UQrfBjLDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh throttle VERBOSE_TOROUT_*()
 for refscale
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343254.23325.637372469854143003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d97addc419e2b1cc1aba2ccc679373fbff7f2521
Gitweb:        https://git.kernel.org/tip/d97addc419e2b1cc1aba2ccc679373fbff7f2521
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 25 Nov 2020 20:49:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:44 -08:00

torture: Make torture.sh throttle VERBOSE_TOROUT_*() for refscale

This commit causes torture.sh to use the torture.verbose_sleep_frequency
kernel boot parameter to throttle verbose refscale output on large systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e2c97f9..f2f9140 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -282,7 +282,7 @@ fi
 for prim in $primlist
 do
 	torture_bootargs="refscale.scale_type="$prim" refscale.nreaders=$HALF_ALLOTED_CPUS refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot"
-	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS" --trust-make
+	torture_set "refscale-$prim" tools/testing/selftests/rcutorture/bin/kvm.sh --torture refscale --allcpus --duration 5 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --bootargs "verbose_batched=$VERBOSE_BATCH_CPUS torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=$VERBOSE_BATCH_CPUS" --trust-make
 done
 
 if test "$do_rcuscale" = yes
