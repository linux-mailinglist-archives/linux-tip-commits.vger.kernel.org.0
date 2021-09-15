Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5243F40C8D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhIOPvT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbhIOPvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B93C0613E7;
        Wed, 15 Sep 2021 08:49:33 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2725cPWU52BZCYrKGR2WQnBqzAz7Z7k6HJyniVmFzw=;
        b=jaEvDVsnIZ64jCasOJAbgVOivdu6RiFfHZCC530C/M845tf7z9hyZ77T2eHFRHzGmNKFnr
        PksxSwz/tDPH6P2k+DdqbLligljsLFJJRq6rFBRocgAIB9BPgZfkdkCGuRDkJqLqFuyilB
        eJvcm73Wk3ZNJXQnlWJfNjFG0F2vXTK2++3skgZOYrnR2z3kSx7wcqT/o1ZZwCkJj5D3NH
        nkqTFbXY/PKcff2jq95LjpLIWsxr9g6QnXQUcxmR+AimNBPdwDxJUrzABnG4zwyZzI1jCc
        HDvBC/WtDEjvdcHT6podlYXzHMDoh3+GWBTXLJSLfiR+AUE1bTCNCW/OGdnzyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720972;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2725cPWU52BZCYrKGR2WQnBqzAz7Z7k6HJyniVmFzw=;
        b=2WX/1YXSnzkQ3PspFCus63mrKblyK7LX0i3OR/Ha/qFMCdpGHLJgXcejy/xDEYRBTxctZP
        QnaUTnsSb3ezdeDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/kvm: Always inline vmload() / vmsave()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095147.942250748@infradead.org>
References: <20210624095147.942250748@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097170.25758.9223235079717389055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a168233a440d01d60ca65ea41e876661466f108b
Gitweb:        https://git.kernel.org/tip/a168233a440d01d60ca65ea41e876661466f108b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:45 +02:00

x86/kvm: Always inline vmload() / vmsave()

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0xea: call to vmload() leaves .noinstr.text section
vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x133: call to vmsave() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095147.942250748@infradead.org
---
 arch/x86/kvm/svm/svm_ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm_ops.h b/arch/x86/kvm/svm/svm_ops.h
index 22e2b01..9430d64 100644
--- a/arch/x86/kvm/svm/svm_ops.h
+++ b/arch/x86/kvm/svm/svm_ops.h
@@ -56,12 +56,12 @@ static inline void invlpga(unsigned long addr, u32 asid)
  * VMSAVE, VMLOAD, etc... is still controlled by the effective address size,
  * hence 'unsigned long' instead of 'hpa_t'.
  */
-static inline void vmsave(unsigned long pa)
+static __always_inline void vmsave(unsigned long pa)
 {
 	svm_asm1(vmsave, "a" (pa), "memory");
 }
 
-static inline void vmload(unsigned long pa)
+static __always_inline void vmload(unsigned long pa)
 {
 	svm_asm1(vmload, "a" (pa), "memory");
 }
