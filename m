Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC2455E17
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhKROho (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhKROhl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E7C061574;
        Thu, 18 Nov 2021 06:34:41 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e2CHsiNW2gjAi0KCiY9Y60aoaonyMeunWGCYqn3esg=;
        b=nrep6g9QiFvLKda7IMkhg7ic6ZHccJkGuADIuV6lqVQemGn2s0UIKlaSyEI778rctWRLu/
        paR6ZdX0OAcB46I8NFrDe/F+4Xv0AJTUvJzOeZF6BB3iheR8UlHi/67MDWtDvo4VlfhnlH
        Ba6w5S/9R/Pbps6v+c3ZfGNsggcExDU5PUcjkN7c5EMkwN5A8NXyBuM/Y9eizfeg+Tmw2N
        QmakCKxzQAvetfRCyI0gAjfHU60Gkmxm5u0ORhCAtC59Rmi5S8JnvGj3TQ337SbwRbmtf9
        pgd+HXhSU86kxI776a/4xO8XdeSxzNB9kvMvU63Uv72DdeuQEBBAVoHMiz+OAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/e2CHsiNW2gjAi0KCiY9Y60aoaonyMeunWGCYqn3esg=;
        b=qmJydfi7OAht/Lv9WbmWbSDA9nJxit5dRggu/Hg1XmKxpSEgP4637k0781MwrMfBeRdOwC
        X/bx7CL9iI5sOjDw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: arm64: Hide kvm_arm_pmu_available behind
 CONFIG_HW_PERF_EVENTS=y
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-16-seanjc@google.com>
References: <20211111020738.2512932-16-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724607789.11128.6052744162598816978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     be399d824b432a85f8df86b566d2e5994fdf58b0
Gitweb:        https://git.kernel.org/tip/be399d824b432a85f8df86b566d2e5994fdf58b0
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:36 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:11 +01:00

KVM: arm64: Hide kvm_arm_pmu_available behind CONFIG_HW_PERF_EVENTS=y

Move the definition of kvm_arm_pmu_available to pmu-emul.c and, out of
"necessity", hide it behind CONFIG_HW_PERF_EVENTS.  Provide a stub for
the key's wrapper, kvm_arm_support_pmu_v3().  Moving the key's definition
out of perf.c will allow a future commit to delete perf.c entirely.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211111020738.2512932-16-seanjc@google.com
---
 arch/arm64/kernel/image-vars.h |  2 ++
 arch/arm64/kvm/perf.c          |  2 --
 arch/arm64/kvm/pmu-emul.c      |  2 ++
 include/kvm/arm_pmu.h          | 19 ++++++++++++-------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index c96a9a0..7eaf1f7 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -102,7 +102,9 @@ KVM_NVHE_ALIAS(__stop___kvm_ex_table);
 KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
 
 /* PMU available static key */
+#ifdef CONFIG_HW_PERF_EVENTS
 KVM_NVHE_ALIAS(kvm_arm_pmu_available);
+#endif
 
 /* Position-independent library routines */
 KVM_NVHE_ALIAS_HYP(clear_page, __pi_clear_page);
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 374c496..52cfab2 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -11,8 +11,6 @@
 
 #include <asm/kvm_emulate.h>
 
-DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
-
 void kvm_perf_init(void)
 {
 	kvm_register_perf_callbacks(NULL);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a5e4bbf..3308cee 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -14,6 +14,8 @@
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
 
+DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
 static void kvm_pmu_create_perf_event(struct kvm_vcpu *vcpu, u64 select_idx);
 static void kvm_pmu_update_pmc_chained(struct kvm_vcpu *vcpu, u64 select_idx);
 static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc);
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 90f2189..f9ed4c1 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -13,13 +13,6 @@
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
 
-DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
-
-static __always_inline bool kvm_arm_support_pmu_v3(void)
-{
-	return static_branch_likely(&kvm_arm_pmu_available);
-}
-
 #ifdef CONFIG_HW_PERF_EVENTS
 
 struct kvm_pmc {
@@ -36,6 +29,13 @@ struct kvm_pmu {
 	struct irq_work overflow_work;
 };
 
+DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
+static __always_inline bool kvm_arm_support_pmu_v3(void)
+{
+	return static_branch_likely(&kvm_arm_pmu_available);
+}
+
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
@@ -65,6 +65,11 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
 struct kvm_pmu {
 };
 
+static inline bool kvm_arm_support_pmu_v3(void)
+{
+	return false;
+}
+
 #define kvm_arm_pmu_irq_initialized(v)	(false)
 static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					    u64 select_idx)
