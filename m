Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9816232B085
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhCCDi7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:38:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577823AbhCBJza (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:55:30 -0500
Date:   Tue, 02 Mar 2021 09:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qD2KF3Gh/cz5SrnuvhtFW1snlvgKZwmJh0dXtKiHyMQ=;
        b=Cw+T4buaMBfXv0iQ1YlzG9Z9SnskHBWQACY4qGeajFlMWexyLaPmlMU5lRx7gidmLpyytS
        7HJ16+mdHLtMjU+fgOsGOh/fsa0IM0BhK6T+hm+ZpnI9FErZAJ+2FgX8z16ssLLdHGIwTW
        F6uJP2K9uk4tD39qL2z4ilPDGxYlZmkSThu0YJLXgmhvbFQFJnp4UJQYMHJM5PEGn98Ikv
        Gd1BBkqvykUFGtmoUB+OMn9ezqrI//X4zlQucnuV3HIBl+DObxKyd9l85asDFGaOxvJVvZ
        GfQJ4BHToYm2wp1//SlGoCA7X7R7MgVVu7jNJ0i4W1nscXu/28ldoCVdmdZpEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qD2KF3Gh/cz5SrnuvhtFW1snlvgKZwmJh0dXtKiHyMQ=;
        b=XLw81wPNwzL25STg8D8CoVNSsrJXRYqPnL8FrIR+svK/32qgqweMVlFTqAws5dua6ECwpo
        t8GS7yGSPD0WMiAw==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Do not make is_lazy dirty for no reason
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-7-namit@vmware.com>
References: <20210220231712.2475218-7-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161467888727.20312.2951422825515894606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     db73f8099a502be8ed46f6332c91754c74ac76c2
Gitweb:        https://git.kernel.org/tip/db73f8099a502be8ed46f6332c91754c74ac76c2
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:09 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 08:01:38 +01:00

x86/mm/tlb: Do not make is_lazy dirty for no reason

Blindly writing to is_lazy for no reason, when the written value is
identical to the old value, makes the cacheline dirty for no reason.
Avoid making such writes to prevent cache coherency traffic for no
reason.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-7-namit@vmware.com
---
 arch/x86/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 345a0af..17ec4bf 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -469,7 +469,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
+	if (was_lazy)
+		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
