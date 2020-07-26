Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4D22DE0B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Jul 2020 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgGZKun (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Jul 2020 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZKul (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Jul 2020 06:50:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865CC0619D2;
        Sun, 26 Jul 2020 03:50:41 -0700 (PDT)
Date:   Sun, 26 Jul 2020 10:50:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595760637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7o0z+KHReNHyOszAW2M4Z2lGfMlRi1Kc1LJ6E0Cd0c=;
        b=2m2LF0wIzbLrtvReDJI+6xOFTmik0bOvSG+8gtpMkn4OoOHcDS5GBIS09GeMs02eACMGJ4
        fgotAymhqGSGa5BrFNKDG6J5nGJo5ks/yXlWsxXiwYY/6GqwUH1YKtlzvn2aaLsqkAgWMA
        6zDnQCWKpYAoEYln2o6dbCw7evjYpui4uwILzkiJ0D8qFmY77PttrMRDGjjvQFjb7sJUUA
        vQGtgdTEpFh12wmA1FL9qu+a/nTWPAgjpXMCbGCvf/2igpD4x8U01g5r7WPPlN15NZJEQ5
        qROZYtS3rRNlVp0PloOC+fllWupbC/88lWMT92DF75NuC//DFHZx69uBYG2hYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595760637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7o0z+KHReNHyOszAW2M4Z2lGfMlRi1Kc1LJ6E0Cd0c=;
        b=s8v+a5Y0kRuwgrCwvw6VagRc4ZAHxsjGJZlQBXX5IKZ3i9qtdGH0n9kAtGxIDXyZx5y6qe
        05FCVPVXZ64HlTDQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: uv: uv_hub.h: Delete duplicated word
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200726004124.20618-4-rdunlap@infradead.org>
References: <20200726004124.20618-4-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <159576063629.4006.9768537728578352299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     de0038bfaf53af0e8bc4961b7aacdcb79f43bf08
Gitweb:        https://git.kernel.org/tip/de0038bfaf53af0e8bc4961b7aacdcb79f43bf08
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 25 Jul 2020 17:41:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Jul 2020 12:47:22 +02:00

x86: uv: uv_hub.h: Delete duplicated word

Delete the repeated word "the".

[ mingo: While at it, also capitalize CPU properly. ]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200726004124.20618-4-rdunlap@infradead.org
---
 arch/x86/include/asm/uv/uv_hub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 60ca0af..5738c36 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -682,7 +682,7 @@ static inline int uv_node_to_blade_id(int nid)
 	return nid;
 }
 
-/* Convert a cpu number to the the UV blade number */
+/* Convert a CPU number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
 	return uv_node_to_blade_id(cpu_to_node(cpu));
