Return-Path: <linux-tip-commits+bounces-1539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0FE916D03
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6C21C2266F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB716FF53;
	Tue, 25 Jun 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYs4qNOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOuFNAy4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6515F3E8;
	Tue, 25 Jun 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329230; cv=none; b=qhnlMKClrTVRhRv89xGkUzLbbcjth9wUZTRmvRDh8ISXfLW5WfL073/Sx3+mekJZ51VKipUnAjSlAEcvN9+O/M3MlFqlDBDHa1qm8OiJjiIOvc7wpdnNO5KlRuqgDpiuG4lyxzfB3ZXCSIG7yOawFv/wkOF9wSGIJO17n0RqsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329230; c=relaxed/simple;
	bh=8bisP0r3MDdbkFDFMndhD2ePnECreU6R2Dt0B4KH9L4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dn2FO4m1sCAxEKVuhyAJ9oiQtT7V5Xtmjv0raeY29Z36k1snrtBRNDAFymhbcT5z2bt8DysBWUPpMchUf0KjYJPunlhrUVCmIlft+N89yiPqnpJQbOSjyWfIAe7XLgMHhWpSe/exAbnE2etx+DAkH1etWYIe0Q+9FMdP3uMSBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYs4qNOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOuFNAy4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 15:27:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48KJWcopHhfzmZSKjpYdVo/SfdGFP94ggsHO/iG6SYw=;
	b=dYs4qNOrBeCdmF4Q0bhVVvDpHoGG8UF4x/geCkvkIeQclmuIrl1xKpvoppQ0hZ3fUtr6Wb
	oJEIvB+IwrDWHUnFlYB0qWXRIPNMxciWOTXC9GzvVeTFB5+wS94MdAdQmS57SZcIT7BENR
	3qczxzqTmklyqNkGPN2v6Qlcaejrxtmi88avd+vgwNuo7pJz2j6Gx4Q9GY8xvBWih+r0ZL
	8TPBQv7fUUZVRUeAXZIkHbS+v1iILnpVkcWi8OAZ2JsqCzMP+qDMwyb9XxE7pjAfOvfBhK
	cDK0NOyFd0f2KBhG5BwfDmiWNdS54MkmR8M0LL+SaOfAp8VKVejYP1A4DwLggQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719329227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48KJWcopHhfzmZSKjpYdVo/SfdGFP94ggsHO/iG6SYw=;
	b=pOuFNAy4tyeu8rIUjYMzugT0RICKg/QHaSmzx+Tk//pXEi+M3cdYGRc0b14lXunTUAFELR
	z/R0u69PpXman6AA==
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
Message-ID: <171932922715.2215.13368774215942312273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     86cb65448d07fe516e18d9512ae5786cd90db9bf
Gitweb:        https://git.kernel.org/tip/86cb65448d07fe516e18d9512ae5786cd90db9bf
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:48 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 25 Jun 2024 17:15:48 +02:00

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
index 24d6fd8..fc1b3f6 100644
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
@@ -485,8 +485,8 @@ static bool __init vmware_legacy_x2apic_available(void)
 	u32 eax;
 
 	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
-	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
-		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
+	return !(eax & GETVCPU_INFO_VCPU_RESERVED) &&
+		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT

