Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6E40C8CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhIOPvI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbhIOPu5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29444C0613E1;
        Wed, 15 Sep 2021 08:49:32 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fIUhIaAmxPpnXVIP6rcwLjBTHEXJCOopxAvr7P/x6o=;
        b=O/nkZJDG7Y5uJQ1UZaI8JjsOIC4RBQfmCwQUDzuZz/0l8Icrs6BCpMT3XIBHBLGO2j/Ifh
        yb4DSu8rgc+CBotXdRHBOo81+VC1CrFUARcSOdiB8MICUJLkRSEtRfp5rV8BbcCylgeWhu
        YyXt7W36bOW7GcyiXSjT727oE652eyFLDHUL62yN7tGXtTEevYkP20wtftg16PrNaZwClY
        3cC4SEuFH9TfFc8+RUhDbRjErR4QwQOPngUsRPwDRbBkQwKn4RZTVlhc2XjA6PdLStG4ni
        obJxbPDNOidAvcPJDncm8lm//487XETvpxjNBYwx/TuLecBiEkteR3jZTPYh1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fIUhIaAmxPpnXVIP6rcwLjBTHEXJCOopxAvr7P/x6o=;
        b=kbEMky+ArU2mYHamOayjYIyusFm7b7+cNDwo2MOqpIs6wjogwr60A2XAxGMmQy7/MrrApd
        LlGejx+0x6QEgLCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/kvm: Always inline to_svm()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.066347165@infradead.org>
References: <20210624095148.066347165@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097001.25758.10917935430866103147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     aee045ed0a6b22100f4d5945ee2deb75db6a0dd5
Gitweb:        https://git.kernel.org/tip/aee045ed0a6b22100f4d5945ee2deb75db6a0dd5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:46 +02:00

x86/kvm: Always inline to_svm()

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x13: call to to_svm() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.066347165@infradead.org
---
 arch/x86/kvm/svm/svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 408031a..38f12a6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -271,7 +271,7 @@ static inline bool vmcb_is_dirty(struct vmcb *vmcb, int bit)
         return !test_bit(bit, (unsigned long *)&vmcb->control.clean);
 }
 
-static inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
+static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
 }
