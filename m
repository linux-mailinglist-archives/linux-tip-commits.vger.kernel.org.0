Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2F313D48
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 19:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhBHSWW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 13:22:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38300 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhBHSV0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 13:21:26 -0500
Date:   Mon, 08 Feb 2021 18:20:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612808444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE0FKRQGePEyRQMV2K5lLY6GFa0S0xi++VAfzftjR9k=;
        b=EbfZ+6hmBCmOIoNbHWATbH8GfNxwGKTVKMIPdKRa/91QDDz7yPGijVJGEW6QghiL9qyMEP
        wFqc8Nnvamuzo9Lkbd1T7kgUbNAQh4PNtnQUrnnZn1CLxuLKa7+Rzqog1t/ecExqm0RZu/
        A/X2088gt3GxQIZkBtZ8UZhrzGRIWLlUFCMV1OhPdbOsiv6ZYBPDgI3GY+DYMeIqw2Wv+k
        9HzhB4yCVgyz/Zpm+SqATiIa0WeB2MQM2tPF+BJgOXVOcnNGI9T+MnkjesjZZGq8ICBt8m
        iyHBqGdWetBejIH4TH4+s5J2eJulgawGXg6gsSqXpINytF9CRsgUGwk48ELlLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612808444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eE0FKRQGePEyRQMV2K5lLY6GFa0S0xi++VAfzftjR9k=;
        b=eW6v6LBxjf2PYVpm83vl/G1tCm3H3+M75mYd2Gxiz9cdfbxLYvUGTcVp9oLCvYSeUOjFvz
        lXb7kl7xsm7lvPAg==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Maintain encl->refcount for each
 encl->mm_list entry
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210207221401.29933-1-jarkko@kernel.org>
References: <20210207221401.29933-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <161280844318.23325.9475103452435627384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2ade0d60939bcd54197c133b03b460fe62a4ec47
Gitweb:        https://git.kernel.org/tip/2ade0d60939bcd54197c133b03b460fe62a4ec47
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 08 Feb 2021 00:14:01 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Feb 2021 19:11:30 +01:00

x86/sgx: Maintain encl->refcount for each encl->mm_list entry

This has been shown in tests:

[  +0.000008] WARNING: CPU: 3 PID: 7620 at kernel/rcu/srcutree.c:374 cleanup_srcu_struct+0xed/0x100

This is essentially a use-after free, although SRCU notices it as
an SRCU cleanup in an invalid context.

== Background ==

SGX has a data structure (struct sgx_encl_mm) which keeps per-mm SGX
metadata.  This is separate from struct sgx_encl because, in theory,
an enclave can be mapped from more than one mm.  sgx_encl_mm includes
a pointer back to the sgx_encl.

This means that sgx_encl must have a longer lifetime than all of the
sgx_encl_mm's that point to it.  That's usually the case: sgx_encl_mm
is freed only after the mmu_notifier is unregistered in sgx_release().

However, there's a race.  If the process is exiting,
sgx_mmu_notifier_release() can be called in parallel with sgx_release()
instead of being called *by* it.  The mmu_notifier path keeps encl_mm
alive past when sgx_encl can be freed.  This inverts the lifetime rules
and means that sgx_mmu_notifier_release() can access a freed sgx_encl.

== Fix ==

Increase encl->refcount when encl_mm->encl is established. Release
this reference when encl_mm is freed. This ensures that encl outlives
encl_mm.

 [ bp: Massage commit message. ]

Fixes: 1728ab54b4be ("x86/sgx: Add a page reclaimer")
Reported-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20210207221401.29933-1-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/driver.c | 3 +++
 arch/x86/kernel/cpu/sgx/encl.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index f2eac41..8ce6d83 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -72,6 +72,9 @@ static int sgx_release(struct inode *inode, struct file *file)
 		synchronize_srcu(&encl->srcu);
 		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
 		kfree(encl_mm);
+
+		/* 'encl_mm' is gone, put encl_mm->encl reference: */
+		kref_put(&encl->refcount, sgx_encl_release);
 	}
 
 	kref_put(&encl->refcount, sgx_encl_release);
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a50..f65564a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -481,6 +481,9 @@ static void sgx_mmu_notifier_free(struct mmu_notifier *mn)
 {
 	struct sgx_encl_mm *encl_mm = container_of(mn, struct sgx_encl_mm, mmu_notifier);
 
+	/* 'encl_mm' is going away, put encl_mm->encl reference: */
+	kref_put(&encl_mm->encl->refcount, sgx_encl_release);
+
 	kfree(encl_mm);
 }
 
@@ -534,6 +537,8 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	if (!encl_mm)
 		return -ENOMEM;
 
+	/* Grab a refcount for the encl_mm->encl reference: */
+	kref_get(&encl->refcount);
 	encl_mm->encl = encl;
 	encl_mm->mm = mm;
 	encl_mm->mmu_notifier.ops = &sgx_mmu_notifier_ops;
