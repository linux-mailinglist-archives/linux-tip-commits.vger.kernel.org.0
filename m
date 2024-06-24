Return-Path: <linux-tip-commits+bounces-1519-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF983915520
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E291C21FB4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953B519EEC2;
	Mon, 24 Jun 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFjNp+I1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W2s06mn7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54D19EEB7;
	Mon, 24 Jun 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249276; cv=none; b=nuOyocEd0tceLGUSfIrxAK3fSa6wnFRRMeqCsJO71pdGDoOuF9bAl99R6ckhd9MthLOWIHibz+aZt1b5099cUSyuuue9iFgf0f6mLFmvt/8k0Re5Q4HdP/cQ+IN4lfsfVYw0JfmIDpFoerUcphtDmG9XDtHzocbbUDZzdMApINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249276; c=relaxed/simple;
	bh=qwSoDmn5RY19N/Pa1/2LaA1bq80ulxOB6TyMqeCmABI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cO707j83yWsCEckduIwNCgAnn1i89UCoDa7oPHnFHNGqlt6QTXV3ZRTrGqILHOVYaAVvQPJmHkg9iO/iS7WchgclW8E2Y88sCpzySVEFBbPzPK0RLvk4vA8wXOS5FrH7bbHDAz+c+Ps5iJGqwGlwmTNawgBiiT1O+wLCzy4p3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFjNp+I1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W2s06mn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:14:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719249273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxVdJ2Z7cJaHQIcabjS5WT27Ue8MPgKhlJBrjov7XPY=;
	b=ZFjNp+I12VVlCUI6J84fqCmKKn/kjsxhk652SFNaq3UUaGzm55HLhbYu3GnCwbaxUgkkkB
	QWY0LjQLmmlYXwZboOWi/39nMahl+hydMatnAz2V1JBgjCdzCdoWkHIeR3M12JaTXhEJPe
	9k8Jt9AuZeI+8ArpttQMR7j23zmE4s0B14nd/li/stowdeyS1h4pVV7GZSwKHGNUkIr9Lg
	fngFSV1rkdPu/UJo+gDO10zez6mAcNxDQlmRyjLy0Py5F8AnkYQvrh2cvof+3ACfOUKV8S
	RNMqGsRXWi4RTy0sabuVppdaSxsh+VMMnmXmVpQodiXrL2eBRAleKgTQY9qGlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719249273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxVdJ2Z7cJaHQIcabjS5WT27Ue8MPgKhlJBrjov7XPY=;
	b=W2s06mn78JjPVi6n6tZiVA0P/uLrVMaw397PWX9Wyi2zkTaYEl2gt53ELtR00CMXPWE+f9
	HZCvCJ8kQyqTbKBA==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Correct macro names
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-7-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924927307.10875.10049376685938566850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     381a0d8979568dceaf4a1ecad9eb229f79702989
Gitweb:        https://git.kernel.org/tip/381a0d8979568dceaf4a1ecad9eb229f79702989
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:48 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 07:10:38 +02:00

x86/vmware: Correct macro names

VCPU_RESERVED and LEGACY_X2APIC are not VMware hypercall commands.  These are
bits in the return value of the VMWARE_CMD_GETVCPU_INFO command.  Change
VMWARE_CMD_ prefix to GETVCPU_INFO_ one. And move the bit-shift
operation into the macro body.

Fixes: 4cca6ea04d31c ("x86/apic: Allow x2apic without IR on VMware platform")
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-7-alexey.makhalov@broadcom.com
---
 arch/x86/kernel/cpu/vmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c0a3ffa..d24ba03 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -42,8 +42,8 @@
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
 
-#define VMWARE_CMD_LEGACY_X2APIC  3
-#define VMWARE_CMD_VCPU_RESERVED 31
+#define GETVCPU_INFO_LEGACY_X2APIC           BIT(3)
+#define GETVCPU_INFO_VCPU_RESERVED           BIT(31)
 
 #define STEALCLOCK_NOT_AVAILABLE (-1)
 #define STEALCLOCK_DISABLED        0
@@ -473,8 +473,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT

