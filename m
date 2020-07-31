Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCF2342C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgGaJXa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgGaJX2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:28 -0400
Date:   Fri, 31 Jul 2020 09:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wh07SNZK+hnbCLhWZHGo/6vgz0mLEcluCAUAusAzyFo=;
        b=p6RlI+cKSamvCEvLUPvAHBIavSDT0HDEGUAaVibwBgq6Dv7BsMovTgjw0aylLj0lSGIBd0
        7yrp+cdsUnaVu1gEMaJsSfo2G+2RUfVlxiUkUKB3X9xCvd6sM/eu1u7Wh6g6qq7pLuwTvZ
        vDGVnPaBAAHK4cAkMtMc3v8KSaGZHUXyWvHmepyeXg4f85VMt9AtqYbE3TovR7/UJr6IpB
        nETKu7w8phiIF4YFHTmvw4sYvAoSTHjZMJ7HwDPqzAVypKOWKODLD4aTSFc9N2DOmPQuYC
        UjdBOUk8qddiNyptlgHFtc89SO0ix5/QBTvfFEf504MgJzPdVMskX3tTYJR2Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wh07SNZK+hnbCLhWZHGo/6vgz0mLEcluCAUAusAzyFo=;
        b=VW5OfBVFKUsF42MKvOz9IezMBIB4fRm+oZU6FIOErtcYvXBypGStC2IyPJcLlFEx4KhiGx
        MeMNHsuNuUhAH3CQ==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix some kernel-doc warnings
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740589.4006.12331724973116805599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     24692fa22c30cb8fcfcabdc07a3c82964475b639
Gitweb:        https://git.kernel.org/tip/24692fa22c30cb8fcfcabdc07a3c82964475b639
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 15 Jun 2020 08:46:49 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: Fix some kernel-doc warnings

The current code provokes some kernel-doc warnings:

	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
	./include/linux/rculist.h:2: WARNING: Unexpected indentation.

This commit therefore moves the comment for "count" to the kernel-doc
markup and adds a missing "*" on one kernel-doc continuation line.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d1..7eed65b 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
