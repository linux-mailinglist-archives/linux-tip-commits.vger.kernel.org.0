Return-Path: <linux-tip-commits+bounces-4315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8EA67C5E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60C7423E3D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D32144C2;
	Tue, 18 Mar 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iF3ym/J0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMHBY3/V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A0213E83;
	Tue, 18 Mar 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324080; cv=none; b=iWQPF8tGPTsKz68zKGyZJTlaILdQ5J0zz7X9GKWnSnVesFqSCRxUBo+CeKLLeCw+y6/d7PQNULxz2aToUYuAuWslzNHCFIDDoN/7rqOp2DcDQ4xj7IN3vHiato+nrRIW/ws+84vpS3HwEd34HLBk6hnJuSC/C1IUx0yuAl6mRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324080; c=relaxed/simple;
	bh=RKfpRifPgZaVq7lU1uFVi5IVcVVtuoyAGQj7hLQIUIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YRQSL3Pet471yAzSpkf4aXYGiKNuXZ8F4A0kJr9oGOIjMMEw2cFBDCj3CfMQ7/ICvxXH+01Vtm/Obp1XSmv5ZtrSRIdzuXRY+Gsdj+W+Loub0OZClNbxOxdfZxuTXFAHQaI+kjhZam9QHpcA+XyMj66o6b7mHGWTeDfFo3V0KBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iF3ym/J0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMHBY3/V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydlw+V5tJ/DFT28B3UEoeiIuPT3DG7hIWV6mRfeV8T8=;
	b=iF3ym/J0yhf1TsORWXnIT+ufwIml872QVM1wp3M1pt9w/K0KfzxjuYz4T8u1zbkUnh2ZE5
	MjRohJ1phzU3JcxhuWGjbM6N3k/YNlyfTyaPNMduNiPZf6H5RzgKhpDHz3njc5RrGSSZKa
	M5rto9acEu0WDGS5P1jeXOvrXSDXDCcH1Zxyqk+vjhYPm8FyZqyjMiYp1hO1f1eKPdWM7N
	wBgW09bBEQxwWosjiV9uNFEhzCVMVynC7WRu9RlKx5vNkgVuPiykvjBHdD5Qk2L59slt+s
	+BbZwzcSzGj5ihmvh+2p4fHYD+EFLX0F04tiZlc7fMrYNjEaT+lMkkLZxhPAgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydlw+V5tJ/DFT28B3UEoeiIuPT3DG7hIWV6mRfeV8T8=;
	b=kMHBY3/VFSpVKzmCBb0B+HKeCKgySOP/KvsEITR7jumANo67t1m25s5CrxUw0QPx6CLx1Y
	iYmdUB97B1iwLpCw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/apic: Fix 32-bit APIC initialization for extended
 Intel Families
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-2-sohil.mehta@intel.com>
References: <20250219184133.816753-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407614.14745.9291363878961520475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3447a2e710494fea44ba76a949b3d3afe17a7a23
Gitweb:        https://git.kernel.org/tip/3447a2e710494fea44ba76a949b3d3afe17a7a23
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:19 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:44 +01:00

x86/apic: Fix 32-bit APIC initialization for extended Intel Families

APIC detection is currently limited to a few specific Families and will
not match the upcoming Families >=18.

Extend the check to include all Families 6 or greater. Also convert it
to a VFM check to make it simpler.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-2-sohil.mehta@intel.com
---
 arch/x86/kernel/apic/apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ddca8da..62584a3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2011,8 +2011,8 @@ static bool __init detect_init_APIC(void)
 	case X86_VENDOR_HYGON:
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
-		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
+		if ((boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)) ||
+		    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 			break;
 		goto no_apic;
 	default:

