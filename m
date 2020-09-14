Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868982692DC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINRRn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 13:17:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgINRQn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 13:16:43 -0400
Date:   Mon, 14 Sep 2020 17:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600103793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qki7fGr/aT2GdSaXkAblGGGKMUy1Sd86S29p7DMYng=;
        b=HK7AAVYNCCFpLsRNQ97aGf5DXBe/1mepIglw/CEfjf9MJggthWldt/D8Bn+BJWTgyMlN+C
        MYdk1CwQMajmDnIz2YuTniBksNpQzVbozb8wP4UFRnHCSFrZT2VWIgLloiUgJ9DMwK+jI9
        Bixi6Qh577x8RjPx8giwAnQlb3J0cnglsz52oOeswSvfwv+8PNMXkWqEfZBfG0dSz2NBBL
        lvOUgsZy4c0uiHcfbL4ncOjXjopX50ouV3IqVwsaOcWHaGW/15oO+wmdNqiC+zkIa/1j6M
        RPgTvIYQ0QrzoZWQQPWKE/Eo07dyAf3SNoW1EANDrQG0zXQ/AvaixglQbvV+qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600103793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qki7fGr/aT2GdSaXkAblGGGKMUy1Sd86S29p7DMYng=;
        b=tgpL4HFvHtid3d90qZNaPgNk5hWhaxO4unEK3BjKkyqTta9+T3pp3CMhFCsqtol/rw+4DU
        vPuuq3O8cHh8nnCg==
From:   "tip-bot2 for Vitaly Kuznetsov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] KVM: nSVM: Avoid freeing uninitialized pointers in
 svm_set_nested_state()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Colin King <colin.king@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200914133725.650221-1-vkuznets@redhat.com>
References: <20200914133725.650221-1-vkuznets@redhat.com>
MIME-Version: 1.0
Message-ID: <160010379231.15536.17765949656127348235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     e6eb15c9ba3165698488ae5c34920eea20eaa38e
Gitweb:        https://git.kernel.org/tip/e6eb15c9ba3165698488ae5c34920eea20eaa38e
Author:        Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate:    Mon, 14 Sep 2020 15:37:25 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 14 Sep 2020 18:08:54 +02:00

KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()

The save and ctl pointers are passed uninitialized to kfree() when
svm_set_nested_state() follows the 'goto out_set_gif' path. While the
issue could've been fixed by initializing these on-stack varialbles to
NULL, it seems preferable to eliminate 'out_set_gif' label completely as
it is not actually a failure path and duplicating a single svm_set_gif()
call doesn't look too bad.

 [ bp: Drop obscure Addresses-Coverity: tag. ]

Fixes: 6ccbd29ade0d ("KVM: SVM: nested: Don't allocate VMCB structures on stack")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Joerg Roedel <jroedel@suse.de>
Reported-by: Colin King <colin.king@canonical.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20200914133725.650221-1-vkuznets@redhat.com
---
 arch/x86/kvm/svm/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2803662..d1ae94f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1092,7 +1092,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE)) {
 		svm_leave_nested(svm);
-		goto out_set_gif;
+		svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
+		return 0;
 	}
 
 	if (!page_address_valid(vcpu, kvm_state->hdr.svm.vmcb_pa))
@@ -1145,7 +1146,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	load_nested_vmcb_control(svm, ctl);
 	nested_prepare_vmcb_control(svm);
 
-out_set_gif:
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
 	ret = 0;
