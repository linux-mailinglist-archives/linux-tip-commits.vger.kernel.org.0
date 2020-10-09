Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6A3288231
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgJIGfc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgJIGf2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:28 -0400
Date:   Fri, 09 Oct 2020 06:35:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0yYR/tXx8TydltaH4eUjuZi+mbxB8BEGrB8+DULu158=;
        b=wjfTYItqTZKddxOmPt6RXEhvAz81EyXp1hywlnx7nn6zmD8BkbRQD/RHNM/FgQ6Gba/0Rx
        NZpHPv7k44g1kv/RkRCxD9kZjPiEKRgsI9a8HznkeXpRpxwz93QOJPOUNbtr98B8RtgH+M
        l+7ATZqCty2tQox9JYoTVNvyHMEqsCgekQmOfb65O4r2k57MBUbL7VK9yWa0L65GlVUsvK
        WVgFXYx+ZfQW+kG/iLyCyoIAmDT58Dm2sZWyGPz3gGhalpsgWtZBu0HufaLD3MSRknGzWy
        +ubsVBSeQPb8YGme6eEjVObCZeh/K4dogsTr6eIdcHX5yVkXkNS2LKUSjafNoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0yYR/tXx8TydltaH4eUjuZi+mbxB8BEGrB8+DULu158=;
        b=WTkvOS7bUC6caMww2YE8pMZIKZyvqoDRSkNT+/Ev+prqHHUEHXPmA2yXuIh2MSZfofoe7i
        MdTfp168yG6tgrBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Check unexpected "switch" statement value
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532654.7002.17243695895198826116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     de77d4da54d10df97d265e7e99112bfc2fef7d4a
Gitweb:        https://git.kernel.org/tip/de77d4da54d10df97d265e7e99112bfc2fef7d4a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 02 Jul 2020 12:15:37 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:37 -07:00

scftorture: Check unexpected "switch" statement value

This commit adds a "default" case to the switch statement in
scftorture_invoke_one() which contains a WARN_ON_ONCE() and an assignment
to ->scfc_out to suppress knock-on warnings.  These knock-on warnings
could otherwise cause the user to think that there was a memory-ordering
problem in smp_call_function() instead of a bug in scftorture.c itself.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 9180de7..d9c01c7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -357,6 +357,10 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
+	default:
+		WARN_ON_ONCE(1);
+		if (scfcp)
+			scfcp->scfc_out = true;
 	}
 	if (scfcp && scfsp->scfs_wait) {
 		if (WARN_ON_ONCE(!scfcp->scfc_out))
