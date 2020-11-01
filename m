Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7727D2A1FBA
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKARAQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKARAQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:16 -0500
Date:   Sun, 01 Nov 2020 17:00:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E0KMFy2POH7IwevZm/k5fQuBmRAqfG1PPDoWaGbOE8=;
        b=OtX1JDPgwrBz+izuA/uiVKrDbgnZfcdwnEYYmYeRaNE4x9wiXHR1WXKu61Dtbvc6ImTRB4
        IjFeiCwEq6nnRLnypbQEccfizo9Js8SJaZ4gug2yqIM5IBBXguT304fKetRmPsZi9NRJZj
        7T5A1I5OJbsNFkxOrNONeNBbQ78b1UVNM6t00XJESSTGgyZMgPSUdWKwLiV8EAaPYK6yT2
        JTrRJuuNhKxwIXOpn+COeRzEFR/TUlyj3iwftRteGHOyRKbLGZW9+fU05g/DV4rBfZy6Z6
        PGxXTA+zCS53zzgA7y43w1uijtUHnzipd/rPKDYAS1dixag4++vKFJkenkc1OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250014;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E0KMFy2POH7IwevZm/k5fQuBmRAqfG1PPDoWaGbOE8=;
        b=uJs6OjwJ2Icb+HnxN6v45bSRybbso4Vf9Eo5sBpKleNrTR8GtW087JNz58EMcUrI1yYhXQ
        alJLf2cDLYxIonAw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
Cc:     Pavel Machek <pavel@ucw.cz>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201015101222.GA32747@amd>
References: <20201015101222.GA32747@amd>
MIME-Version: 1.0
Message-ID: <160425001324.397.16087694985398433477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     151a535171be6ff824a0a3875553ea38570f4c05
Gitweb:        https://git.kernel.org/tip/151a535171be6ff824a0a3875553ea38570f4c05
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 15 Oct 2020 21:41:44 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 15 Oct 2020 21:41:44 +01:00

genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY

kernel/irq/ipi.c otherwise fails to compile if nothing else
selects it.

Fixes: 379b656446a3 ("genirq: Add GENERIC_IRQ_IPI Kconfig symbol")
Reported-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201015101222.GA32747@amd
---
 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10a5aff..164a031 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -82,6 +82,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	select IRQ_DOMAIN_HIERARCHY
 
 # Generic MSI interrupt support
 config GENERIC_MSI_IRQ
