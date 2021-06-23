Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319943B232B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhFWWMb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhFWWLr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:47 -0400
Date:   Wed, 23 Jun 2021 22:09:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzZ1alLV/hHQ4wYMJS+DQsfhJMYYNd025WAB4mB/910=;
        b=u1/TwmSxlYL73HVyQcskQNRR7VjFaB0FK/rfZRBEQWjwXi9QU/m9ubdJuWeI360DhAuaUk
        jjy4SMxUSXQrrngWszZ0aB9HK48R9zTGIeblKbfpyC+TPLrS5/BRxEuDa0g42nuyH4hG5F
        4K4zIewU1bRLMjNFoS/UqO1tVrtmUsG0vlYauhMs7Lr/HPZ1McDXv7gXPIiVUBhD3rnIBX
        FT1EuuPyuqudMfEGEFPYUlol8cdl5RJqmHidqa79x372Txb9Z3B6+2sj8cv6cvc1F+ifgF
        sv5ZaDPM712rN6b/RvXKiiQUl3mQW+YJZVHun4dKFNlllYqqFrdcteDuGHDawQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzZ1alLV/hHQ4wYMJS+DQsfhJMYYNd025WAB4mB/910=;
        b=uU0o3OElMrf4Uo8bWVS6XKWlUur6iXsAHGopAyiNos55OFl9qquaaHcrRyXMOnpf75JuWG
        6k6t+NVb3Qa8MwDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Cleanup arch_set_user_pkey_access()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.635764326@linutronix.de>
References: <20210623121453.635764326@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616744.395.9591424790750099231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9fe8a6f5eed8fff6b2d7dbc99b911334e311732d
Gitweb:        https://git.kernel.org/tip/9fe8a6f5eed8fff6b2d7dbc99b911334e311732d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:50 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:52:41 +02:00

x86/fpu: Cleanup arch_set_user_pkey_access()

The function does a sanity check with a WARN_ON_ONCE() but happily proceeds
when the pkey argument is out of range.

Clean it up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.635764326@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 185cc5d..579e343 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -912,11 +912,10 @@ EXPORT_SYMBOL_GPL(get_xsave_addr);
  * rights for @pkey to @init_val.
  */
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val)
+			      unsigned long init_val)
 {
-	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
-	u32 new_pkru_bits = 0;
+	u32 old_pkru, new_pkru_bits = 0;
+	int pkey_shift;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -930,7 +929,8 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 * values originating from in-kernel users.  Complain
 	 * if a bad value is observed.
 	 */
-	WARN_ON_ONCE(pkey >= arch_max_pkey());
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
 
 	/* Set the bits we need in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
@@ -939,6 +939,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		new_pkru_bits |= PKRU_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
+	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */
