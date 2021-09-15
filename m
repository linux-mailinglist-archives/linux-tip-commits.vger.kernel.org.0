Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC040C8C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbhIOPu7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhIOPut (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:49 -0400
Date:   Wed, 15 Sep 2021 15:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hhaj4YS7FOOJWK2q7i4um+bsMw8Ttun6vD3OEgam8/o=;
        b=GwiqpCRtQwh3grQPjTqR2es341rpZzne+Kr+Tum/Bir1dhJ0oPHeiep+EQVYVl7clwMQzA
        oZPiVIWhJhnVjUlhTjYFOV0459XOKnBAAc79L9+LSecO9/+fzVJfbp3Tb/MQajeftizqry
        QbP87H4ersyQNu3GrpQzezqJdhnxAY67U4xJxod/n8QgyUdT79sAYFbSXtp2Og/lzhVHTU
        SV4bNFvj8TlMqvBZPN2xbhjQGInp7ruiKqEf+v1cXe0B3XVHKx04WG+WFv2NaZf6tT1vwi
        hU+y5odI7T6CEHnZvFie8C2FUuHCpHItDNriBNOwyv1rP5NIEdQXG7UTb4A7Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hhaj4YS7FOOJWK2q7i4um+bsMw8Ttun6vD3OEgam8/o=;
        b=R3e84XLwT5rcDLi+xzmarkRMWJUqpDQO2GAed8x8LxBbsmfLS/1IECU5zmR35zA+cIlogY
        dTsmOrvnmGxoXbDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/kvm: Always inline evmcs_write64()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.126956644@infradead.org>
References: <20210624095148.126956644@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096916.25758.698934646939983104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     010050a86393703f43859a4704d2193be49126d6
Gitweb:        https://git.kernel.org/tip/010050a86393703f43859a4704d2193be49126d6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:46 +02:00

x86/kvm: Always inline evmcs_write64()

vmlinux.o: warning: objtool: vmx_update_host_rsp()+0x64: call to evmcs_write64() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.126956644@infradead.org
---
 arch/x86/kvm/vmx/evmcs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 152ab0a..16731d2 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -93,7 +93,7 @@ static __always_inline int get_evmcs_offset(unsigned long field,
 	return evmcs_field->offset;
 }
 
-static inline void evmcs_write64(unsigned long field, u64 value)
+static __always_inline void evmcs_write64(unsigned long field, u64 value)
 {
 	u16 clean_field;
 	int offset = get_evmcs_offset(field, &clean_field);
@@ -183,7 +183,7 @@ static inline void evmcs_load(u64 phys_addr)
 
 __init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
-static inline void evmcs_write64(unsigned long field, u64 value) {}
+static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
 static inline void evmcs_write16(unsigned long field, u16 value) {}
 static inline u64 evmcs_read64(unsigned long field) { return 0; }
