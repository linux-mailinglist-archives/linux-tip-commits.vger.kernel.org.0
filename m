Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF753568C5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhDGKEU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350494AbhDGKDn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74345C061765;
        Wed,  7 Apr 2021 03:03:33 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIHJ+siW+aqTpevFtkqB+bSjz/bp55L6t4itcX64O0g=;
        b=Kk1q9XZhRi1g4AEqAFnFMHS0BoAUt3Kuiagq5DSQeeZhg58gMY7EMmYz2HtVfUKQYhDGoY
        qWhnh0b5smkKjJceFdpVGRz2FOMCmLTPfqDR6doNs+HamGvi23996gqSSMYAW3voLdIkmp
        59WgfrUViEogRPT/mPLMfZz7tu5Z0fl6Nl5F/nxKjzBKPNbLobARg6eaikYh9vI2gCuyST
        ePnPiryGQnwGZx57isTmPPjxhCQja4qAyTigmG30wjpKnNfkdu0Erp5qqdggcKCG9+5FBz
        fAPVP021GZekiz88m/1wuulk1FZUeaTGEciB5/PnhCuMJa1dZBbyOLYsEUijPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIHJ+siW+aqTpevFtkqB+bSjz/bp55L6t4itcX64O0g=;
        b=/kVI7Lhct8c29luivjmVcr0QLFoH3Edu4ap9JTDoOdlVI6dk9X7lkXHITHrJ9o8ZYNf6Eb
        7EkpIuASUaW7KlDQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add SGX2 ENCLS leaf definitions (EAUG, EMODPR
 and EMODT)
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5f0970c251ebcc6d5add132f0d750cc753b7060f.1616136308.git.kai.huang@intel.com>
References: <5f0970c251ebcc6d5add132f0d750cc753b7060f.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981135.29796.2908264440005666587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     32ddda8e445df3de477db14d386fb3518042224a
Gitweb:        https://git.kernel.org/tip/32ddda8e445df3de477db14d386fb3518042224a
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:05 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:42 +02:00

x86/sgx: Add SGX2 ENCLS leaf definitions (EAUG, EMODPR and EMODT)

Define the ENCLS leafs that are available with SGX2, also referred to as
Enclave Dynamic Memory Management (EDMM).  The leafs will be used by KVM
to conditionally expose SGX2 capabilities to guests.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/5f0970c251ebcc6d5add132f0d750cc753b7060f.1616136308.git.kai.huang@intel.com
---
 arch/x86/include/asm/sgx.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 34f4423..3b025af 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -40,6 +40,9 @@ enum sgx_encls_function {
 	EPA	= 0x0A,
 	EWB	= 0x0B,
 	ETRACK	= 0x0C,
+	EAUG	= 0x0D,
+	EMODPR	= 0x0E,
+	EMODT	= 0x0F,
 };
 
 /**
