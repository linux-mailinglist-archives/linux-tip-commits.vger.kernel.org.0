Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE13568C3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbhDGKES (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350514AbhDGKDm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:42 -0400
Date:   Wed, 07 Apr 2021 10:03:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvPex6z3wgxYXIiiRD83DhHV7vLEXGd1sWTD5quMXws=;
        b=LGzUU09EP/cJkHtMdBX2wl6NKmjruBlzFGhlh3Udm6PpUtFwabBE2mlw4LKqYatPv4Weck
        LAkk3cqB137W4iFWZ4/3nQY39H3ehOt29njCDg+7ktgFrvXBBLhZNPrn6KXYC3S9WQS7VY
        3EWKzrWu0ybKSCntXeOfHrbHZf+o+YfWkrjuwTvdYTZmbHf1jizr/24mESA8k8I721dDhi
        zwtvMO2sFoXhhHYXppt/GoY3shmQNASQ7Dz6x38R+90pIU/FlWoiIjC+7540eD7iul4SPI
        /SFxx+4AlymOT3pb6xd+Wi+QOg5ERgsYmpAL28kf7AzX3BuKYzpc0anBszl9EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789812;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvPex6z3wgxYXIiiRD83DhHV7vLEXGd1sWTD5quMXws=;
        b=Ejhi9O5UjoX10aqj1VJkE+fUxF798yzCuXkivwJj6zOjguTjIRB+SdiCmCYMuhWMFeVcrL
        Kwv4kByBDaolqCAA==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Move ENCLS leaf definitions to sgx.h
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2e6cd7c5c1ced620cfcd292c3c6c382827fde6b2.1616136308.git.kai.huang@intel.com>
References: <2e6cd7c5c1ced620cfcd292c3c6c382827fde6b2.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981177.29796.3134584985123205107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     9c55c78a73ce6e62a1d46ba6e4f242c23c29b812
Gitweb:        https://git.kernel.org/tip/9c55c78a73ce6e62a1d46ba6e4f242c23c29b812
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:23:04 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 06 Apr 2021 09:43:41 +02:00

x86/sgx: Move ENCLS leaf definitions to sgx.h

Move the ENCLS leaf definitions to sgx.h so that they can be used by
KVM.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/2e6cd7c5c1ced620cfcd292c3c6c382827fde6b2.1616136308.git.kai.huang@intel.com
---
 arch/x86/include/asm/sgx.h      | 15 +++++++++++++++
 arch/x86/kernel/cpu/sgx/encls.h | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 14bb5f7..34f4423 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -27,6 +27,21 @@
 /* The bitmask for the EPC section type. */
 #define SGX_CPUID_EPC_MASK	GENMASK(3, 0)
 
+enum sgx_encls_function {
+	ECREATE	= 0x00,
+	EADD	= 0x01,
+	EINIT	= 0x02,
+	EREMOVE	= 0x03,
+	EDGBRD	= 0x04,
+	EDGBWR	= 0x05,
+	EEXTEND	= 0x06,
+	ELDU	= 0x08,
+	EBLOCK	= 0x09,
+	EPA	= 0x0A,
+	EWB	= 0x0B,
+	ETRACK	= 0x0C,
+};
+
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 443188f..be5c496 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -11,21 +11,6 @@
 #include <asm/traps.h>
 #include "sgx.h"
 
-enum sgx_encls_function {
-	ECREATE	= 0x00,
-	EADD	= 0x01,
-	EINIT	= 0x02,
-	EREMOVE	= 0x03,
-	EDGBRD	= 0x04,
-	EDGBWR	= 0x05,
-	EEXTEND	= 0x06,
-	ELDU	= 0x08,
-	EBLOCK	= 0x09,
-	EPA	= 0x0A,
-	EWB	= 0x0B,
-	ETRACK	= 0x0C,
-};
-
 /**
  * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
  *
