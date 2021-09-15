Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6328240C8D5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhIOPvU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbhIOPvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D7C0613E8;
        Wed, 15 Sep 2021 08:49:34 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C05AJoXuHhxCm0JieI42wcw5XBnMPGXP26yYpMBdljA=;
        b=Ci9NmYpSSU9yNnFIJOSfL6Gl3OmhFQAnT1E4C3EB53Ao/il956XC9+MGSy3XrHVEDDGhEM
        xkvmFj2TpCfWV/XV9LmNFLm0wCDijHhkn0Sdn+odK72oeBoztFwiOE5PVyhYhxCdTLbhuR
        Em7niWPExIGArP6hl7Ny61u2l/7LncErURI7cpL1mACwU54lIEIOCP6TOqcVyNzgLnPx0F
        wmn5lUMeZKVeixgQ3eAH2mTbdSo+pN6m1avZoTz79jSMxF9+Go1nWo23QGuUFobXQExYir
        qYTgHhHJatO7SMieuKujGYIAi9JCcYgeYzVN9CVjWeabohjdSGq1HKrbtWttxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C05AJoXuHhxCm0JieI42wcw5XBnMPGXP26yYpMBdljA=;
        b=X4Z83RUiXDveNmMIqgKraJWfA6OgdROprzPYdejnDwE/L0E3Tfn15Zznh7Acj13J/zkQag
        LBhMxdR8VoFqlpCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/kvm: Always inline sev_*guest()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095147.880513802@infradead.org>
References: <20210624095147.880513802@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097255.25758.16156175268854222340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2b2f72d4d81936bc08c18c426f40b7df70e2f8e7
Gitweb:        https://git.kernel.org/tip/2b2f72d4d81936bc08c18c426f40b7df70e2f8e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:45 +02:00

x86/kvm: Always inline sev_*guest()

vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x4d: call to sev_es_guest() leaves .noinstr.text section
vmlinux.o: warning: objtool: svm_vcpu_enter_exit()+0x50: call to sev_guest() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095147.880513802@infradead.org
---
 arch/x86/kvm/svm/svm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 524d943..408031a 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -218,12 +218,12 @@ DECLARE_PER_CPU(struct svm_cpu_data *, svm_data);
 
 void recalc_intercepts(struct vcpu_svm *svm);
 
-static inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
+static __always_inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_svm, kvm);
 }
 
-static inline bool sev_guest(struct kvm *kvm)
+static __always_inline bool sev_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
@@ -234,7 +234,7 @@ static inline bool sev_guest(struct kvm *kvm)
 #endif
 }
 
-static inline bool sev_es_guest(struct kvm *kvm)
+static __always_inline bool sev_es_guest(struct kvm *kvm)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
