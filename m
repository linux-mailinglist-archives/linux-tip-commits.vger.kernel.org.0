Return-Path: <linux-tip-commits+bounces-6402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF1B3FCB0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851073BDFFA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563632F39C7;
	Tue,  2 Sep 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmJkkaED";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtKvGu5A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2302ECD1B;
	Tue,  2 Sep 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809398; cv=none; b=aD7vHM1qOq0pH+epBZUE4gOtjW16YF/toFeqwV8/IlLgUrrsOgPSdTbtQYMHaSZRV79MS47ugJKUBdXzJNKy7fyNezrLERmMcj5Akwe3DLChxmBVu95Z1M6LQxB4NTdcR38ig3cMIJg5nLTHuWFAkWqExfZ28WaeTXSPt8wIPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809398; c=relaxed/simple;
	bh=Y5Es3yQEYpzMbohgPLhaUOHnOZ6/aZFA+CCGYMGDswM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LzRJs7M7saJCkGG6fP4py8YrEMXigkd5sgRYKXRBBMpzMmbh0Fmn5z1DZJMeQ9gKxtEOim/gRwmQbyvxJz+oKzYnQ/o8LvVyt3zmk/bace3BCRYdOdtR4aoLJBkxJpO7Fr6ADCZbcs2lMjT7+30trdHoLPOV6Hw8ZdJnB5sPs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmJkkaED; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtKvGu5A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RZqPXDb3FKqU+Jbc9QFotzFDxglVqyBjD12qrEQnQA=;
	b=RmJkkaEDh0e2ZVJeGr6gZ3/K4be5+CHbT/oWIBTaBfbCs+RGp1HvrF2R0xgvFNouIa64mO
	62Bhi/l6bltuB1fHCSa+15ZwlPhfzqu8Bnqn6FzxzD1qL+HEYGJAug6Xi2wQVg+0vx80MR
	beh0zEW4wl45AeBE/KHam9P14b8mJLDN5Q0lEtMfP192rO3whkFCB05o3KRTd7IqKbdck8
	e1toKx2ZlqUiutBy9r0QqA0NfkUVayLns9G3t7xOQ8+WYWKmTH8UBV5ue/6SvukoFJ51TL
	E2c3lgqSWQzdNRz91rpzBdqafboswy3Lb1LkBT9bfmd2eyyZ8QhxcRTr4DePfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RZqPXDb3FKqU+Jbc9QFotzFDxglVqyBjD12qrEQnQA=;
	b=vtKvGu5ANmpARzf3mLsQZ03yS12pmNjUSPWvxMs8B3/jJyv8nBB6E54HNjhZNcASB71N9W
	amBD1ZAJyDp1thDw==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Enable Secure AVIC in the control MSR
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828112126.209028-1-Neeraj.Upadhyay@amd.com>
References: <20250828112126.209028-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939364.1920.16606028845427824675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c4074ab87f3483deb15f277f302f199cdb997738
Gitweb:        https://git.kernel.org/tip/c4074ab87f3483deb15f277f302f199cdb9=
97738
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:51:26 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:18:14 +02:00

x86/apic: Enable Secure AVIC in the control MSR

With all the pieces in place now, enable Secure AVIC in the Secure AVIC
Control MSR. Any access to x2APIC MSRs are emulated by the hypervisor
before Secure AVIC is enabled in the control MSR.  Post Secure AVIC
enablement, all x2APIC MSR accesses (whether accelerated by AVIC
hardware or trapped as a #VC exception) operate on the vCPU's APIC
backing page.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828112126.209028-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/include/asm/msr-index.h    | 2 ++
 arch/x86/kernel/apic/x2apic_savic.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 1291e05..5951344 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -704,6 +704,8 @@
 #define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
 #define MSR_AMD64_SAVIC_CONTROL		0xc0010138
+#define MSR_AMD64_SAVIC_EN_BIT		0
+#define MSR_AMD64_SAVIC_EN		BIT_ULL(MSR_AMD64_SAVIC_EN_BIT)
 #define MSR_AMD64_SAVIC_ALLOWEDNMI_BIT	1
 #define MSR_AMD64_SAVIC_ALLOWEDNMI	BIT_ULL(MSR_AMD64_SAVIC_ALLOWEDNMI_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 36e6d0d..b846de0 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -365,7 +365,8 @@ static void savic_setup(void)
 	if (res !=3D ES_OK)
 		snp_abort();
=20
-	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL, gpa | MSR_AMD64_SAVIC_ALLOWEDNMI);
+	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL,
+		      gpa | MSR_AMD64_SAVIC_EN | MSR_AMD64_SAVIC_ALLOWEDNMI);
 }
=20
 static int savic_probe(void)

