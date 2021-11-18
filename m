Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056DD455E14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhKROhm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhKROhk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:40 -0500
Date:   Thu, 18 Nov 2021 14:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obazFwK0qJ3Ft+YyQO+zEna79biSq5r4rUoMEDx5S9Q=;
        b=T7b6QWvoGu73IJ7soktiMb572rFoLJrEZunjI+JCJC+7218rDUYQ1e713JlP5+Rolg7SnH
        +LfrXsR0i/ZZskfPwGxAPVdhDEtRaYle2nddo9YbhvjGJLSXvIkDrwuiioWzVuFBywJJCs
        UgveZ8m9VH66JELkQTiLjVGEKQ9nB/0ONPjTTPFoUtV53gRLmF7TInzoa8D900oMV/NeCD
        FcQjeZmHJ/+/8VnNtOPIIXie2pct/6n+ot6uwBpmsO8A7hT8jpJMZG1pJuKrHHWPHHde3T
        4VluFcsBmgg97iHa3DOGtUkGfiCOVef5XPgBEaJ4eqymF0Wpun0jvGNvBHXu9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obazFwK0qJ3Ft+YyQO+zEna79biSq5r4rUoMEDx5S9Q=;
        b=1sAF5LTLhm/0quJzhedmn7/0WJSirh/20MgA3LVedYryZMuwnw6MAay5P43cOaQ/Pnyg5N
        iD08nKZaMVyOwJDQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] KVM: arm64: Convert to the generic perf callbacks
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-15-seanjc@google.com>
References: <20211111020738.2512932-15-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724607868.11128.9418762241597798046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7b517831a1c6aceb0821860edb9c7bc7d4f803a2
Gitweb:        https://git.kernel.org/tip/7b517831a1c6aceb0821860edb9c7bc7d4f803a2
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:35 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:11 +01:00

KVM: arm64: Convert to the generic perf callbacks

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211111020738.2512932-15-seanjc@google.com
---
 arch/arm64/kvm/perf.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index dfa9bce..374c496 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,42 +13,12 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!vcpu)
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (!vcpu_mode_priv(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state		= kvm_guest_state,
-	.get_ip		= kvm_get_guest_ip,
-};
-
 void kvm_perf_init(void)
 {
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_register_perf_callbacks(NULL);
 }
 
 void kvm_perf_teardown(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_unregister_perf_callbacks();
 }
