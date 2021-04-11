Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A45F35B4E4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhDKNoV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8A3C06138C;
        Sun, 11 Apr 2021 06:43:49 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Cd17CE88W3x96ArXq/f5ZpBkhF2Q8LDLzjP7rUGFOzw=;
        b=EmNEBeDQ0uCltHK1GPv87OV2ubglCV/coR73Vg+DQUIDM1NgzJYLTkbbKEs7krkVQ1DqUn
        hjs3pdk7EO+Kjxa5v4POZF81Z4RGBKBvBNky0W6DKZLkj8sqf2ssrK/AmmuGrh1oS5Cwyb
        yE7akJeyAW53lXm8ExAx0xEi1noii4ENNiag9pmhW5w3wFyBD8Ixwa0UiX9/4j7CU2F8uc
        kO/PyM/DkCTVxzfxzh9zyvqmNUaXmrfeiMsyJR2wleCMb8Ohs78kYfzo/niQLUmVP1WwVQ
        0KAMT5iErqJ6V7gJR7BdKbLyi7QMC99OcK+JG54ChHztE6NqcHgfQ8ouVRUfoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Cd17CE88W3x96ArXq/f5ZpBkhF2Q8LDLzjP7rUGFOzw=;
        b=cU1Frbtep3tM5lxRoFfF78Y9ksatNguYS8WF8QuyaysFl6L00kR2rKl5RjPPKCruWUbHR8
        tF0uQ+fYedDmS3Bw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Disable verbose torture-test output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861073.29796.17575196497558639163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     aebf8c7bf6d508dfb4255db8f7355ca819d9e6c9
Gitweb:        https://git.kernel.org/tip/aebf8c7bf6d508dfb4255db8f7355ca819d9e6c9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 10:17:26 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

refscale: Disable verbose torture-test output

Given large numbers of threads, the quantity of torture-test output is
sufficient to sometimes result in RCU CPU stall warnings.  The probability
of these stall warnings was greatly reduced by batching the output,
but the warnings were not eliminated.  However, the actual test only
depends on console output that is printed even when refscale.verbose=0.
This commit therefore causes this test to run with refscale.verbose=0.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
index 321e826..f81fa2c 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
@@ -12,5 +12,5 @@
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
 	echo $1 refscale.shutdown=1 \
-		refscale.verbose=1
+		refscale.verbose=0
 }
