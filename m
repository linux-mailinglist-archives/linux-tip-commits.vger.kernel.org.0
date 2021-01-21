Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C62FF7B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbhAUWHb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 17:07:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUWHa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 17:07:30 -0500
Date:   Thu, 21 Jan 2021 22:06:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611266805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAqNmS9C2PfBLAnZ7EYj5MUeLg1by+I0hZpIR7HVej0=;
        b=LseDNlA7JtJy9ttK5nyu/Q7byKaep7m66A0Zld2qOKgEbdA+J38VS4ttUHsUcSQX/EUCMt
        rrP78wGaTmPZ2pUZniMSMf7Q17Vb42LB0eE7xyJp0PQnrHhvWxMyYxiUtFDMi4eOvtTxEE
        95Ghr7tMPUFmPjwD/QQ4v45cHWXhz5nVF7Me8um/1amHn/F4GpvsJWCkllzPs4Ze2+PjoV
        rqjjlKJoj3aaxOUFMIjT//ElVsxvjcPhb31wLPGtRPEWz9FxpiNkt2iOoK601LEXMNVmlx
        1rGox9RO8vlWtJJa1+N381COzYCpRmoMKifFTexYNCHsWLQ4coCyzsWqhYStfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611266805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tAqNmS9C2PfBLAnZ7EYj5MUeLg1by+I0hZpIR7HVej0=;
        b=56OS7QqFttHoH6XGu69b/q0pSyLKiPL7l7D8H8kUXzLed+CTpUwIEuYiA3Rf1QPDK0ItiX
        lvghwKzO83IwiEDg==
From:   "tip-bot2 for Gayatri Kammela" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add another Alder Lake CPU to the Intel family
Cc:     Gayatri Kammela <gayatri.kammela@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121215004.11618-1-tony.luck@intel.com>
References: <20210121215004.11618-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <161126680417.414.11680360777018059432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6e1239c13953f3c2a76e70031f74ddca9ae57cd3
Gitweb:        https://git.kernel.org/tip/6e1239c13953f3c2a76e70031f74ddca9ae57cd3
Author:        Gayatri Kammela <gayatri.kammela@intel.com>
AuthorDate:    Thu, 21 Jan 2021 13:50:04 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Jan 2021 23:01:51 +01:00

x86/cpu: Add another Alder Lake CPU to the Intel family

Add Alder Lake mobile CPU model number to Intel family.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210121215004.11618-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5e658ba..9abe842 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -97,6 +97,7 @@
 
 #define	INTEL_FAM6_LAKEFIELD		0x8A
 #define INTEL_FAM6_ALDERLAKE		0x97
+#define INTEL_FAM6_ALDERLAKE_L		0x9A
 
 /* "Small Core" Processors (Atom) */
 
