Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C825827100A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Sep 2020 20:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgISS5k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 19 Sep 2020 14:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISS5j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 19 Sep 2020 14:57:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E7C0613CE;
        Sat, 19 Sep 2020 11:57:39 -0700 (PDT)
Date:   Sat, 19 Sep 2020 18:57:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600541853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrhy/4PNeswPO7VxIUEcBRAZ4qKr20VRiqemKU3AXIA=;
        b=wiMmCwv7F4m8GYSaeLAa0GGg7oMIET7ccseP1HwjRIpBri2ELROccJ/4pfRK/Z9uyHZZpa
        sK0BmajyykD7wCGXKWQg8CFmzkXp9e/kih9Gvz7RR6Ybuq3VVxvixRSQJhRfIGuS9wAQzS
        w+vy/sIS5tCeim6GZ1R28VytEH7ABUEkMIriHcw0Eh0Upzn7kUS1JKKi3BLZEEmUxGsBCR
        OiBoGAbWpq+9sTyiN8IsCUtHKpn+FX83FlLIMoKqtnlsBPabTeMpNjST/RW/aO9gvrC0dV
        CoBrnT+aVtoGc/i49qxoIc3sDNk9YD2IDL+K7OjIvZGVzEzFrBp87KSMUZUZRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600541853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrhy/4PNeswPO7VxIUEcBRAZ4qKr20VRiqemKU3AXIA=;
        b=GNzgJyc0QNk2MoPwNeRcV2T1HQXG6NTBBiaXzE5N+hkNfJC4CdwClCuujdVnQKve6WKq88
        a+CyggX4x90qGfCA==
From:   "tip-bot2 for Krish Sadhukhan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: SVM: Don't flush cache if hardware enforces cache
 coherency across encryption domains
Cc:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917212038.5090-4-krish.sadhukhan@oracle.com>
References: <20200917212038.5090-4-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Message-ID: <160054184758.15536.15665221112789518623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e1ebb2b49048c4767cfa0d8466f9c701e549fa5e
Gitweb:        https://git.kernel.org/tip/e1ebb2b49048c4767cfa0d8466f9c701e549fa5e
Author:        Krish Sadhukhan <krish.sadhukhan@oracle.com>
AuthorDate:    Thu, 17 Sep 2020 21:20:38 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Sep 2020 20:46:59 +02:00

KVM: SVM: Don't flush cache if hardware enforces cache coherency across encryption domains

In some hardware implementations, coherency between the encrypted and
unencrypted mappings of the same physical page in a VM is enforced. In
such a system, it is not required for software to flush the VM's page
from all CPU caches in the system prior to changing the value of the
C-bit for the page.

So check that bit before flushing the cache.

Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/20200917212038.5090-4-krish.sadhukhan@oracle.com
---
 arch/x86/kvm/svm/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 402dc42..567792f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -384,7 +384,8 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
 	uint8_t *page_virtual;
 	unsigned long i;
 
-	if (npages == 0 || pages == NULL)
+	if (this_cpu_has(X86_FEATURE_SME_COHERENT) || npages == 0 ||
+	    pages == NULL)
 		return;
 
 	for (i = 0; i < npages; i++) {
