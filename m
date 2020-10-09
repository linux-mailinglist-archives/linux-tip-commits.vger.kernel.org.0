Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17862882C2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgJIGjl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbgJIGfQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E3C0613D2;
        Thu,  8 Oct 2020 23:35:16 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YnwkJdBoLLT4OWV0dYyYZQ1jJAhnJHYTWLjAhHwZgvE=;
        b=NaKyYFyjUjbl5x9h6FaFBmwadz/0cnO+VXjHe4YfOAyruLghBYf92LrlAA/KKloLLuGQDd
        Rso4twM5IZLQzcedauGZ24n0zmRNschJrE01N4++ty+wvZG1WTL6+EoklAMW32I7kbP0pu
        mVuN41/RdjGMF2am7MxiXocVlobvuiY+RG13iGdvXmfpbaBIYpsB/RZcRa9zke8sfLDO2n
        ZMVl3QOB6/6TzSFupKRQTjiISjP49HtoqEOrrbWBiJkl+P+FwedwAs5oh3IRlOiqi7SfFe
        rZQ/Y/Vk85aJR0v5MWMpevymdlqb77eUcPWOB29iHmfmfvXB3MZ6nQZgY6OUuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YnwkJdBoLLT4OWV0dYyYZQ1jJAhnJHYTWLjAhHwZgvE=;
        b=qfhISFINYa0cRdiVt/Ryk+QEDNFTYyhU63/d2WldlaSHOS23whOZ0JKos1GgteP7CrYAwv
        dp3KITj2nOfig3Dg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531390.7002.3682274709500222618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fc848cf4face352dce663c1fcc73717fba2d4557
Gitweb:        https://git.kernel.org/tip/fc848cf4face352dce663c1fcc73717fba2d4557
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 14 Jul 2020 11:02:15 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:33 -07:00

rcutorture: Add CONFIG_PROVE_RCU_LIST to TREE05

Currently, the CONFIG_PROVE_RCU_LIST=y case is untested.  This commit
therefore adds CONFIG_PROVE_RCU_LIST=y to rcutorture's TREE05 scenario.

Cc: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05 b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
index 2dde0d9..4f95f85 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05
@@ -16,5 +16,6 @@ CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_PROVE_RCU_LIST=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
