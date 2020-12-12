Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA182D8697
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407385AbgLLNDq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438961AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53520C0611CE;
        Sat, 12 Dec 2020 04:58:52 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEOJdrYVbzVycYA21QkrmlZ6K0PQvNLxYTfenwRVnmk=;
        b=yfMewR8FSnIJBRs+KJnaQJw/lNLqtkdMpkTZYJh7QzBrfc/Li/Wg3t6za+wU4/7q2p+p1K
        5eV7eJWxWVzUOurOwA3BeWh/gDjspscl7l/pxo4tM9L9B8Qgk5Kr/ERjRIMyKZQW0aQON7
        dDf/KeIvWe50j6mPfG/nxrwI7c4sw4Ky6qXcbNY8R3FUYYXJqWuGdMf2oxpEk4bqhUR9ST
        VzPN9aOeUpD4P4mgb7UpX78cuaeYtSZY3oXBI9UYDCANJknjIHvgNbGqOAl2S2Y7ggr94D
        CojxLB0m9p14Bw9Ww4mHOxzSejssfnuVhZTNlMWBuxlTIcz7mI80bS1gNvpAHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEOJdrYVbzVycYA21QkrmlZ6K0PQvNLxYTfenwRVnmk=;
        b=+reaGRqrzgy4lE8mFNFJmkmN8vXmDzD4AUYeT8ztqTWKuFAw02epGTEl+dI7j05gcpsClT
        5ZAlET8vFgHXYgCA==
From:   "tip-bot2 for Keqian Zhu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Use stable
 count reader in erratum sne
Cc:     Marc Zyngier <maz@kernel.org>, Keqian Zhu <zhukeqian1@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201204073126.6920-2-zhukeqian1@huawei.com>
References: <20201204073126.6920-2-zhukeqian1@huawei.com>
MIME-Version: 1.0
Message-ID: <160777793055.3364.11955080846892702144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d8cc3905b8073c7cfbff94af889fa8dc71f21dd5
Gitweb:        https://git.kernel.org/tip/d8cc3905b8073c7cfbff94af889fa8dc71f21dd5
Author:        Keqian Zhu <zhukeqian1@huawei.com>
AuthorDate:    Fri, 04 Dec 2020 15:31:25 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 05 Dec 2020 19:33:55 +01:00

clocksource/drivers/arm_arch_timer: Use stable count reader in erratum sne

In commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter
to access stable counters"), we separate stable and normal count reader to omit
unnecessary overhead on systems that have no timer erratum.

However, in erratum_set_next_event_tval_generic(), count reader becomes normal
reader. This converts it to stable reader.

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201204073126.6920-2-zhukeqian1@huawei.com
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 6c3e841..777d38c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -396,10 +396,10 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long 
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
 	if (access == ARCH_TIMER_PHYS_ACCESS) {
-		cval = evt + arch_counter_get_cntpct();
+		cval = evt + arch_counter_get_cntpct_stable();
 		write_sysreg(cval, cntp_cval_el0);
 	} else {
-		cval = evt + arch_counter_get_cntvct();
+		cval = evt + arch_counter_get_cntvct_stable();
 		write_sysreg(cval, cntv_cval_el0);
 	}
 
