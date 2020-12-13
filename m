Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA772D9021
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393783AbgLMTZs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgLMTCF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:05 -0500
Date:   Sun, 13 Dec 2020 19:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JeNkgsYEhftUdAX9uT1J1SU9sUKdCmOQd6rCCYakP5Q=;
        b=Aw/M5oHNrqIeyS7xeEKtWZUq6eIVzCe6I8Koye5NCMI3X8UFiv7QJ4viRy832G2ISjnVJz
        ZlZxGhAQrhqa0j5bd93E7zg6feEoIfbGlrq21vsJIygCqv9KJQnocfDX0pMC1ekXsgbVMB
        3P70ZmlT2LSvaJqnAFTG1Rfye5rmpMh7cwr9USSPw9HIDrBygcMhf+XEiSEgU/m6CtMiz3
        nBHPumJGS5/B8MsJjSiO7Y/807DV95xfFXsSdwCyPBCUFS1X6SPd6plo9HqOtBnVtK6eX1
        z3kx8FRTzRA2hWczAYIMmeShdodvh3FXH8VNef8PDNkRtIbeN9y5LfhGIm70bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JeNkgsYEhftUdAX9uT1J1SU9sUKdCmOQd6rCCYakP5Q=;
        b=IGavX5EsILK9mtPkYXnvAJS1kVFWHsFWUIu3A8LmTcrF5UoNnbbJ3wULWZt9dflaKEswru
        9B3qmUvlsl8/ySBQ==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] net: sched: Remove broken definitions and un-hide for
 !LOCKDEP
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607409.3364.12443709944329000810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a72e9d5472055ca53faed106dc9a11c6b656e66d
Gitweb:        https://git.kernel.org/tip/a72e9d5472055ca53faed106dc9a11c6b656e66d
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:25 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:10:00 -08:00

net: sched: Remove broken definitions and un-hide for !LOCKDEP

Currently, variables used only within lockdep expressions are flagged as
unused, requiring that these variables' declarations be decorated with
either #ifdef or __maybe_unused.  This results in ugly code.  This commit
therefore causes the full definitions of the lockdep_tcf_chain_is_locked()
and lockdep_tcf_proto_is_locked() functions to be visible even when
lockdep is not enabled, thus removing the need for the previous empty
functions that were provided in non-lockdep kernels.  This approach
further relies on dead-code elimination to remove any references to
functions or variables that are not available in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/net/sch_generic.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d8fd867..749db62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -435,7 +435,6 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
-#ifdef CONFIG_PROVE_LOCKING
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
@@ -445,17 +444,6 @@ static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
 {
 	return lockdep_is_held(&tp->lock);
 }
-#else
-static inline bool lockdep_tcf_chain_is_locked(struct tcf_block *chain)
-{
-	return true;
-}
-
-static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
-{
-	return true;
-}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
 
 #define tcf_chain_dereference(p, chain)					\
 	rcu_dereference_protected(p, lockdep_tcf_chain_is_locked(chain))
