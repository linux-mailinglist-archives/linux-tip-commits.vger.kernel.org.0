Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F032FA8A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCFMNV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:13:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCFMM4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:12:56 -0500
Date:   Sat, 06 Mar 2021 12:12:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps4YWvo86Y6Y5ihohpGCqYDGRO4PKRStjqbWo7HBq8g=;
        b=Ads8BDue2jNDzC229TjrzeXmtmhd9okkWECzQTWXzTcnO+Vm1u6Qf5PvbWoQPn4a6c4B6H
        ZG6kDFcdwLR7VtlaDeJqpbUHRwt1pVNCHPpAIpTHnl0Bs1IcG7zXyxy4Geg8uMSHxGgYFm
        CHBDLuRN8+aDBtwXuCPOD62GP5kt38q5HBypNUDySWQo9bV54LrW+J6o7sFifi8kpyGTUq
        GMXXdMRHv1An60OlDZvBEnSt5MAd77olsydP5g20NzyxKCSrN8rc1b48SIr0XuDEiSf823
        6uYdgs5MNN+ZZFV2j2I/JazKwjluE3XzEx47Ms315CFUXjGX0B8V9OSooDFFZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps4YWvo86Y6Y5ihohpGCqYDGRO4PKRStjqbWo7HBq8g=;
        b=Jj4q+DgrWnFXxOH9MXzVtjDdgQhgsRxOu2M+fgHgSFtmmXwEtdGmx6wsKrrexC8ddmIPiN
        048ZBqzlg+PJraDQ==
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
Message-ID: <161503277478.398.10679282978114075916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     09c5272e48614a30598e759c3c7bed126d22037d
Gitweb:        https://git.kernel.org/tip/09c5272e48614a30598e759c3c7bed126d22037d
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:09 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:59:10 +01:00

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
