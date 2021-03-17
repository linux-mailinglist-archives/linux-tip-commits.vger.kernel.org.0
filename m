Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAF33FA1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhCQUsE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 16:48:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhCQUrt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 16:47:49 -0400
Date:   Wed, 17 Mar 2021 20:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616014068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8hauYpn2234y1mIxB8mcikZjFSfCw1wMaazafTU1LU=;
        b=2n+Xyt4E7nEKwTxglzUt4nnf/c71qwnNxxL+IyVriNtQJMPIXyVUEmmOyYfXPFXO/7QsSq
        3UAk5ALFOw4XE+kS2P0B70LsiwCxJAG8G0Uf/IvDYtIfpBqLY+GcFIMYnfFlIL8J5comxV
        DMUV+V3+8cPCNa9J76M+GP0Zm1khDwDHFy6Mu4W7tASpYICLPHuN+FPZOWCzQBtwqPC9Am
        DwJuQ0hZtLnqR3W1/fb09u4LK+C9Tbcu5iedhxIXKAxF0/Z9J8ROGgX6oE9FSPQhoGqnuK
        VX8LTYo9nsYTjlHXlOGy6EJxsdB5AGuonkt0xa6ZyEyvrmVcPJoKmaXl3a09Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616014068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8hauYpn2234y1mIxB8mcikZjFSfCw1wMaazafTU1LU=;
        b=r2Zos3qTQhdcgsZV+SIjnbINKt+8XwiI0GzR9V3cIEk2GNMjrjmG/5wOZaQczAuvD3neGl
        aLuwH+8SyhdHPbDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq: Simplify condition in irq_matrix_reserve()
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210211070953.5914-1-jgross@suse.com>
References: <20210211070953.5914-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161601406708.398.17055440090597099983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2c6b02185cc608c19a22691fadc6ca2cd114c286
Gitweb:        https://git.kernel.org/tip/2c6b02185cc608c19a22691fadc6ca2cd114c286
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Feb 2021 08:09:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 21:44:01 +01:00

irq: Simplify condition in irq_matrix_reserve()

The if condition in irq_matrix_reserve() can be much simpler.

While at it fix a typo in the comment.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210211070953.5914-1-jgross@suse.com

---
 kernel/irq/matrix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 7a9465f..6f8b1d1 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -337,15 +337,14 @@ void irq_matrix_assign(struct irq_matrix *m, unsigned int bit)
  * irq_matrix_reserve - Reserve interrupts
  * @m:		Matrix pointer
  *
- * This is merily a book keeping call. It increments the number of globally
+ * This is merely a book keeping call. It increments the number of globally
  * reserved interrupt bits w/o actually allocating them. This allows to
  * setup interrupt descriptors w/o assigning low level resources to it.
  * The actual allocation happens when the interrupt gets activated.
  */
 void irq_matrix_reserve(struct irq_matrix *m)
 {
-	if (m->global_reserved <= m->global_available &&
-	    m->global_reserved + 1 > m->global_available)
+	if (m->global_reserved == m->global_available)
 		pr_warn("Interrupt reservation exceeds available resources\n");
 
 	m->global_reserved++;
