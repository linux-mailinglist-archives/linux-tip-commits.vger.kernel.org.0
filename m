Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625C43B83BC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhF3Nut (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhF3NuS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:18 -0400
Date:   Wed, 30 Jun 2021 13:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hD/4oxxvPhDctkD4DzmvLnGtd2i3PSIcob7Z+0RYyO4=;
        b=Sf1zv4TH7/wduJxobRz576MI8hPcgzzQdTaLLdOCt0na1XDCd2DY4uD3t8mAoovFxSX0MQ
        LEfcsOVVRGDQasXKLg1E+DuSdpMoE3gtJrpEqf9TRiC7kGvthVbRhk1weBtsZ+0NxywQpW
        8PVnWuUrxTcSsqWd+JNiNQSuOupFazK2KnGEd+5vYbcXA8pYVvDYUDKxVmu8IpK74AcBZC
        zBG+b+CaAdurwP9qc1aFpA75mrQJzBtLrJV6JXyF85ln8tBXypdVG72WkKSQ4NYWoABq0W
        koZfQ7BWK6SA2wclx26Nkn38dHN2gEU10mZ5JVQxZDitju31zx2JJml+Swm6uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hD/4oxxvPhDctkD4DzmvLnGtd2i3PSIcob7Z+0RYyO4=;
        b=OqAMDkGRjk1eznCXUXtllZo8HbRy5fkuVj1EbPiRS65nkMQLKpsksFII/FaLrF/FLY6hJ4
        qT4KBsyGBNB61/Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Allow CPU hotplug to be enabled
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086867.395.16400503188388361512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     179141865d08d9b9ebdbef8775b2450dc6f98a14
Gitweb:        https://git.kernel.org/tip/179141865d08d9b9ebdbef8775b2450dc6f98a14
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 05 Mar 2021 13:15:31 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

rcuscale: Allow CPU hotplug to be enabled

It is no longer possible to disable CPU hotplug in many configurations,
which means that the CONFIG_HOTPLUG_CPU=n lines in rcuscale's Kconfig
options are just a source of useless diagnostics.  In addition, rcuscale
doesn't do CPU-hotplug operations in any case.  This commit therefore
changes these lines to read CONFIG_HOTPLUG_CPU=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE   | 2 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
index 721cfda..4cc1cc5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -7,7 +7,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_NOCB_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
index 7629f5d..f595206 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
@@ -8,7 +8,7 @@ CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
+CONFIG_HOTPLUG_CPU=y
 CONFIG_SUSPEND=n
 CONFIG_HIBERNATION=n
 CONFIG_RCU_FANOUT=3
