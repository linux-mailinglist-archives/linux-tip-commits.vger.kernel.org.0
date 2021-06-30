Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDD3B83C6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhF3Nut (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhF3NuT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:19 -0400
Date:   Wed, 30 Jun 2021 13:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1lw0oqyaTvt8g/76+r3QGB6eDMrmobBB1vkKyBb2FM8=;
        b=1V6A8ONKfz00zc4+NcGPaOEVQV8qPSeBXUfQqYEOFW+I4N5mdCInhhoZ4cx8UXc10k18EW
        FxD6vduLq6xttSJ6Zr9xApZDn0ZPdftXrFGwRxcblVT8zApxLIFqvZxBptS81BpB+mX8i2
        Gh9n+hN9lJtEWm+4yeMkl1M6dk+gv4vwFgr3eVGt9p3l3mSiw7DZQlw2j225+OCb6OVFlt
        2PIULkwolgUIA1j39tpSyOVKuMwVPgaqdfwwInMHLa79kYHn8D6iGzfXzrHqmhefO7R1mP
        UGM2gHypCxRwGZ8lYLIh4UHTDBSkA2nbhRkAxkC/Z2EV+O2tzezeJkVMREcA9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1lw0oqyaTvt8g/76+r3QGB6eDMrmobBB1vkKyBb2FM8=;
        b=aEA4asHfVYGHM/1MmT6F9mIVSAkSkbdsaTVo81tQxdUuxad5YJ5bbjtL+zxxo/2t6TeA5n
        HJOTOSMkRv4CxVDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Allow CPU hotplug to be enabled
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086920.395.7460514447042510441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     68d415f91ff2284828211e937f12a3f6d9a18cb9
Gitweb:        https://git.kernel.org/tip/68d415f91ff2284828211e937f12a3f6d9a18cb9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 05 Mar 2021 13:12:36 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

refscale: Allow CPU hotplug to be enabled

It is no longer possible to disable CPU hotplug in many configurations,
which means that the CONFIG_HOTPLUG_CPU=n lines in refscale's Kconfig
options are just a source of useless diagnostics.  In addition, refscale
doesn't do CPU-hotplug operations in any case.  This commit therefore
changes these lines to read CONFIG_HOTPLUG_CPU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 2 +-
 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 1cd25b7..ad505a8 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
index d10bc69..4f08e64 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
