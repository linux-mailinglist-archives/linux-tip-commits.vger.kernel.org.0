Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763153B2316
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFWWMJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFWWLa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:30 -0400
Date:   Wed, 23 Jun 2021 22:09:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uto/JDGl9udf0RyWxFUuZmsyjzWQYkcmBxkpWDebkUg=;
        b=WmZHpkp2VuxV1CZ2EgNenknHwzacJzkSdwsYIStWXGuaPRrIK0MZ6g75KqcinuDFNaDrqd
        2/k26yWygzcatowG0Wdi8vAjiu+osBoxKQ3xnLZMduPQyurOpIE47YMMXht/nIecdFPXsE
        HztM98g4pujoxjHyikZSwlRXZC/TTrN3IXMrRqYsf1e5d1DOSETmb9dOBN4/dhHukZU5aK
        J81grtUu9akMNTf4ai3qVj/RMwQUfRlTu1hw+p0GTUlAY8W2897OWFL5V0HTKALd15bG/t
        0Fehze1oGB3R8fQM8Y8hMAXZSegjToQGB4z19EjcUg9ZAcECTvCGWL9cP3FVKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uto/JDGl9udf0RyWxFUuZmsyjzWQYkcmBxkpWDebkUg=;
        b=m7oTlytpLpWGU/P0mimSKCa2tZ8vgfPyC9h5W1/IQbmJCJl65xoNZqB/hLbEzZXBnUuHdB
        go0F3hw9OJ2S8cDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkru: Provide pkru_get_init_value()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.404880646@linutronix.de>
References: <20210623121455.404880646@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615063.395.10363501284970136257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     739e2eec0f4849eb411567407d61491f923db405
Gitweb:        https://git.kernel.org/tip/739e2eec0f4849eb411567407d61491f923db405
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:02:49 +02:00

x86/pkru: Provide pkru_get_init_value()

When CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is disabled then the following
code fails to compile:

     if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
     	u32 pkru = READ_ONCE(init_pkru_value);
	..
     }

because init_pkru_value is defined as '0' which makes READ_ONCE() upset.

Provide an accessor macro to avoid #ifdeffery all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.404880646@linutronix.de
---
 arch/x86/include/asm/pkru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index ec8dd28..19d3d7b 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -10,8 +10,10 @@
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
+#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
 #else
 #define init_pkru_value	0
+#define pkru_get_init_value()	0
 #endif
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
