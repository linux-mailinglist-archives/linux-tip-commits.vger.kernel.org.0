Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D228825B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbgJIGgc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbgJIGfo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:44 -0400
Date:   Fri, 09 Oct 2020 06:35:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ONbO1lgMYtS7IaXC70WkOV/UqFQRp72omcXS19SjjxM=;
        b=hKf2cJNh07DuoWy7AEaP1tpV49faCfReLGZ01q+oVPuN+QAcvvZvnFaxFThp+F9xZnARQF
        NgtWD26kN2sVWNKGk0Jh/oEFbU8rvJ8Ba6B41ajzFLUPKGh/NkHOUqC9UcCADG+LvIoNBB
        On1PyY7LlLx+F66l3Bl1+h3CvMbVzF69Sj3XQ2sVEEdbuQhRgG0JVPUUY8IYZaC5peZgYK
        z48zJGsz7yfPY3c3vF4twTl0cB2AlapDE+Gm1OzrdeZ7L6oj11EMTkxSMSTriHEMC8w2Ot
        EUPAcq4epy0OKl7lnTg2f4XrAqN2OUfifb4j2IBeEzSCo+HVVeQYIXcchqXvPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ONbO1lgMYtS7IaXC70WkOV/UqFQRp72omcXS19SjjxM=;
        b=A0iC+3kHLlJOp34723g69UG2K0kGY7eUmWg7NPWC2IbTkmsPdD1yNnhtgx+FOswv+qjPoQ
        LlGo60V6+zWHAhCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] nocb: Clarify RCU nocb CPU error message
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534184.7002.17898670386211902428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e082c7b38185af0f59e55efff840939c35391f85
Gitweb:        https://git.kernel.org/tip/e082c7b38185af0f59e55efff840939c35391f85
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 22 Jun 2020 09:25:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:05 -07:00

nocb: Clarify RCU nocb CPU error message

A message of the form "rcu:    !!! lDTs ." can be tracked down, but
doing so is not trivial.  This commit therefore eases this process by
adding text so that this error message now reads as follows:
"rcu:    nocb GP activity on CB-only CPU!!! lDTs ."

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 982fc5b..bbc0c07 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2417,7 +2417,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	    !waslocked && !wastimer && !wassleep)
 		return;  /* Nothing untowards. */
 
-	pr_info("   !!! %c%c%c%c %c\n",
+	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
 		"lL"[waslocked],
 		"dD"[!!rdp->nocb_defer_wakeup],
 		"tT"[wastimer],
