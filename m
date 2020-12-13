Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E342D9018
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgLMTZt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46470 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbgLMTCF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:05 -0500
Date:   Sun, 13 Dec 2020 19:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPf5KwXc/5P8oi/xxkaojDpY+Rsvpji2qUPyDWGV384=;
        b=RZdZTaqgPOu0pXlw5DC05KYD+PGiK9rhz/7VBDe2GdeSLopIauVZHYTgTMzTe36n7j9Wbg
        h9IDa5NfqupARW0i5Uaq+5KSQYRc+bXkYL8LXnF5GCzQvMi7qcgwyid7hPGQgf1elMLhrw
        wxVB2ZRUV/jofgfb7PDFQEDly68bRReOJvFp4ws0M8fjFbf5l8jWonQ90eQEDxVGSIacko
        SPm8NRWraOq403IfeewwC9WjXRroL5fiN7gC7rgGvvPUr+NDU0PKyhL9kLwZjPj16QCKyH
        DGAblZ+SRHdkYGnNvsD0Xtk/2U34IXhqhYVIvDZsiam5J0hTnwQliskWPRFNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPf5KwXc/5P8oi/xxkaojDpY+Rsvpji2qUPyDWGV384=;
        b=NYgNgP7tW2N7RH7gPwUJ0KFnOlhMXgVN9Wc5BbJddeMeqVfknt8uTDEPS6cMjkaikPm8JP
        o676XRz0vdle6GCQ==
From:   "tip-bot2 for Jakub Kicinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Use a more appropriate lockdep helper
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607388.3364.5591152415390075235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f505d4346f6129d4708338491cf23ca9cf1d8f2a
Gitweb:        https://git.kernel.org/tip/f505d4346f6129d4708338491cf23ca9cf1d8f2a
Author:        Jakub Kicinski <kuba@kernel.org>
AuthorDate:    Wed, 16 Sep 2020 11:45:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:10:00 -08:00

srcu: Use a more appropriate lockdep helper

The lockdep_is_held() macro is defined as:

 #define lockdep_is_held(lock)		lock_is_held(&(lock)->dep_map)

This hides away the dereference, so that builds with !LOCKDEP don't break.
This works in current kernels because the RCU_LOCKDEP_WARN() eliminates
its condition at preprocessor time in !LOCKDEP kernels.  However, later
patches in this series will cause the compiler to see this condition even
in !LOCKDEP kernels.  This commit prepares for this upcoming change by
switching from lock_is_held() to lockdep_is_held().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: jiangshanlai@gmail.com
CC: paulmck@kernel.org
CC: josh@joshtriplett.org
CC: rostedt@goodmis.org
CC: mathieu.desnoyers@efficios.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c13348e..6cd6fa2 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -906,7 +906,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
-	RCU_LOCKDEP_WARN(lock_is_held(&ssp->dep_map) ||
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			 lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
