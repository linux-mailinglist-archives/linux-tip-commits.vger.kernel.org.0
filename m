Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF43E5AC0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhHJNLS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhHJNLR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 09:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A5C0613D3;
        Tue, 10 Aug 2021 06:10:55 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:10:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628601052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6wvZUl7vB3iLjAZJZDQnNL7kyE2nf2rkaAzA0zmbr8=;
        b=yyTBN0eeuixqPdVd8gV+cVdEWxokZ1p25VbNbpwiJMHiNozJKBlm4TuHwaSlHeyBQQSiMr
        Hru5fU2mEP7sExGdGuK2w/IohkadZdsvVo/wbprx94G1IQQQA0ycAt6DdmiThtXHdrQwtg
        S+a1BoQHJiKHg8X1FBPw46r6pKsUBgfQQ593uC/RjS+pik8xoa5j8xfuRHv0YWav5TmE8r
        DDz6bDijRXYK0+GScDpOcuId6usmnw4xGCMPKDVaNp0XUewhvyBVtDMYMh7UyQakSnknCN
        2kcbaqCPaS0dZuAScmuAs5EPrG96cWDBLnVForhGZsS65sDFXPrrJnbyp7CZPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628601052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6wvZUl7vB3iLjAZJZDQnNL7kyE2nf2rkaAzA0zmbr8=;
        b=JKln8XsE+6XnCl6UGdQ8NfYryzNBKQa2OEh67/w6IEFDeVYSoOLbdgZNl9kWRnNmYOm2rp
        RMrKTsv9EnF9kkDQ==
From:   "tip-bot2 for Joel Savitz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Clarify documentation for request_threaded_irq()
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210731050740.444454-1-jsavitz@redhat.com>
References: <20210731050740.444454-1-jsavitz@redhat.com>
MIME-Version: 1.0
Message-ID: <162860105130.395.18111061787171768078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     61377ec144574313ebfbf31685895a7b9b9b7a9a
Gitweb:        https://git.kernel.org/tip/61377ec144574313ebfbf31685895a7b9b9b7a9a
Author:        Joel Savitz <jsavitz@redhat.com>
AuthorDate:    Sat, 31 Jul 2021 01:07:40 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 15:06:04 +02:00

genirq: Clarify documentation for request_threaded_irq()

Clarify wording and document commonly used IRQF_ONESHOT flag.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210731050740.444454-1-jsavitz@redhat.com

---
 kernel/irq/manage.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef30b47..766468a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2072,9 +2072,9 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *	request_threaded_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
- *		  Primary handler for threaded interrupts
- *		  If NULL and thread_fn != NULL the default
- *		  primary handler is installed
+ *		  Primary handler for threaded interrupts.
+ *		  If handler is NULL and thread_fn != NULL
+ *		  the default primary handler is installed.
  *	@thread_fn: Function called from the irq handler thread
  *		    If NULL, no irq thread is created
  *	@irqflags: Interrupt type flags
@@ -2108,6 +2108,8 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
+ *	IRQF_ONESHOT		Do not unmask interrupt line until
+ *				thread_fn returns
  *
  */
 int request_threaded_irq(unsigned int irq, irq_handler_t handler,
