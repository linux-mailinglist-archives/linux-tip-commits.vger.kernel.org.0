Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13A288421
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbgJIH66 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732455AbgJIH6q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E1FC0613D4;
        Fri,  9 Oct 2020 00:58:45 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D8mpGziUtvPniz5+mxx8U2SgFxJbrivX25Qpk7Nhv+Y=;
        b=N104HgFMvHnQSCWuP0O6wi+foSO+UTDahMHa2ADYkhoegkvlvK67thUNEeUG2MrdomTOTF
        BWRKSD+nwpUbNL/aMIt0sStwIEDjQqR6Ac/uw5XgX1fHtfBrhKvw3+gE03G07+t478BCSQ
        o9hdw1zYkclf5Xa7L3hN1Vi1jOFHmkl23qwSsi6265ZXBHzSVPxG4qViGs8lrh6JUqMdN5
        3Hn/TkA4Xwxew2saXWQOSTD325J2LzS5l3icR7EYVnc7SzxC68fR/VbhCOlBgn0Nl42Ltw
        bqxWIrFNJBHcPFTNar0rWsglJOHcfyUV/M9CJMOBMHfY1VKBxfV2tV1WZWU/Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D8mpGziUtvPniz5+mxx8U2SgFxJbrivX25Qpk7Nhv+Y=;
        b=Hx4+fujPtOMWPoTz3CvtcCfg8djtYSs7JreikNMLIl+EY8NEfETTPXo+5yG4RvS4dmalCA
        LjnR8iWCpOk03IBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Update recipes.txt
 prime_numbers.c path
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032377.7002.9971884274009905206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cc9628b45c9fa9b165a50dbb262928bc529bf35d
Gitweb:        https://git.kernel.org/tip/cc9628b45c9fa9b165a50dbb262928bc529bf35d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 22 Jul 2020 16:08:23 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 03 Sep 2020 09:51:00 -07:00

tools/memory-model: Update recipes.txt prime_numbers.c path

The expand_to_next_prime() and next_prime_number() functions have moved
from lib/prime_numbers.c to lib/math/prime_numbers.c, so this commit
updates recipes.txt to reflect this change.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/recipes.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index 63c4adf..03f58b1 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -1,7 +1,7 @@
 This document provides "recipes", that is, litmus tests for commonly
 occurring situations, as well as a few that illustrate subtly broken but
 attractive nuisances.  Many of these recipes include example code from
-v4.13 of the Linux kernel.
+v5.7 of the Linux kernel.
 
 The first section covers simple special cases, the second section
 takes off the training wheels to cover more involved examples,
@@ -278,7 +278,7 @@ is present if the value loaded determines the address of a later access
 first place (control dependency).  Note that the term "data dependency"
 is sometimes casually used to cover both address and data dependencies.
 
-In lib/prime_numbers.c, the expand_to_next_prime() function invokes
+In lib/math/prime_numbers.c, the expand_to_next_prime() function invokes
 rcu_assign_pointer(), and the next_prime_number() function invokes
 rcu_dereference().  This combination mediates access to a bit vector
 that is expanded as additional primes are needed.
