Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED336234284
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgGaJXe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgGaJXe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:34 -0400
Date:   Fri, 31 Jul 2020 09:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mUksT33pqB+R7Vr7YerOjQVjEV190xZ07l5dim+3jYY=;
        b=ceBodAjb+KpfijO5dEDCouJ4nr9J/42GfTbykannJXEHG0ylZ46FutP+8qFQEF3DvudYCq
        nLC1KbIVoTdpjakkmZBx0h8dMs0CT18oPiPoXwFCd4zvgwoCZLkDpoB0rFxoBzxMRPydNH
        gwegcV1QlvaXnRuFqP6yioapNNpZz0nbK544JPHPm441eUUZH9oGdRf3/FNhTR0N5r3gru
        rJ0fD8A8WOy18yYRqnh6TsHSa2B9kZTeUJcUQfe9ES3a3yW8rggqKBuK1Z5mX8gaE9OUBE
        2GdjpME1j8yTxD3vA7MUzwGC8c7Palg9Cer/RQbO+g3HYTEX0yhJen2kniTqJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mUksT33pqB+R7Vr7YerOjQVjEV190xZ07l5dim+3jYY=;
        b=TX/yq26JwQfxVKXBOa4roTOygYT6fRTEZ8OvqLYs8SewqbriL4GBntTvL0P5ENc1jhWOou
        qKfLK32q7hKsjuBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark rcu_nmi_enter() call to
 rcu_cleanup_after_idle() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741127.4006.3810336460676158748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     04b25a495bd68c1dad07263fb91e8b5a31c00a9e
Gitweb:        https://git.kernel.org/tip/04b25a495bd68c1dad07263fb91e8b5a31c00a9e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 19 May 2020 17:00:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr

The objtool complains about the call to rcu_cleanup_after_idle() from
rcu_nmi_enter(), so this commit adds instrumentation_begin() before that
call and instrumentation_end() after it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index feb31c2..d17e5a0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -990,8 +990,11 @@ noinstr void rcu_nmi_enter(void)
 		rcu_dynticks_eqs_exit();
 		// ... but is watching here.
 
-		if (!in_nmi())
+		if (!in_nmi()) {
+			instrumentation_begin();
 			rcu_cleanup_after_idle();
+			instrumentation_end();
+		}
 
 		instrumentation_begin();
 		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
