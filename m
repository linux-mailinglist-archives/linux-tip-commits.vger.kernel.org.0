Return-Path: <linux-tip-commits+bounces-4350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F9A68AB9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8820C88671B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06254259C8F;
	Wed, 19 Mar 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbKrg61o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4/PubovZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA12561AD;
	Wed, 19 Mar 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382226; cv=none; b=h5lJFgKV8lxlHNKE4nC5qZ0Z6eq5sTddW9sBw3wgg/pJRS9MTalfKxmrrh2tlJWkHQXHguPIJ+j1OkBicIFlJSPvVEEOtHt+G9D5Jjrn3+uUUj+Rmzfw73r941+SHDa5y46hxFKCsfHt5Drt6vIGAF7LxYQg2/Poi7MQy+vo2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382226; c=relaxed/simple;
	bh=qOeBGqjaWvQ74jL8v6OpXMIGaiC5QHn/WXYx6pTtP5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GYN4SlPeBeVWq58SjrPiGLiglZ2B3mKXEHMbs1yJF2434lF2skzbFABFePCGfqA6gleaudepwcKICl9WwZ3TJwJmcr8Tobn7+qx7G5iSU6HcjJT9SGFoLXQwhAm/hprfChNEEwc+PWYuyY8AfsUthePjfY0N75+6O04LNw/4Fwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbKrg61o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4/PubovZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GddCiOsBlv5g2yhGIiTmTPRU+nPG4R5wpd1mZeZKQnU=;
	b=vbKrg61oiAHFVR/Eq5p7fvHwxje17ChaxS1jyJXpbY6m/5SebUo0XkpXfdWs+8CDFfNjGD
	hXuAxVvzT3kp87jPMbWtwhk5+O9EwggLZmIFPNa2Y0OfIUZD4jtXKGYnymYndMq228AcjL
	DUZGavVnXfw3+vTothdfBrlZLTyYVaf806qQc1bsHTfiqvxJLmKlMetTpa7RHzR75NYejT
	vvYhV6421u9DsUmGpbCYiVqyNn1TxYl49o/ozP3kEG/kvWIMpvckSDIf4a+ldUleQO+hCG
	WdvpkSr5EbrONqe/VQ22xSxn8Qi2uocJCvV4V7vWMsId/LyeNoic+mQTWpSAQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GddCiOsBlv5g2yhGIiTmTPRU+nPG4R5wpd1mZeZKQnU=;
	b=4/PubovZWpc03yt/cxK/33K9EoTxiMf3TqbxFbcshvIGWfo5eCCgKKg31BuRUxxVr0wF+7
	1oD/TZgL2cwxZBBw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/mtrr: Modify a x86_model check to an Intel VFM check
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-5-sohil.mehta@intel.com>
References: <20250219184133.816753-5-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222248.14745.8978424761344413502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a8cb451458057295fa251152a0297ece5519850f
Gitweb:        https://git.kernel.org/tip/a8cb451458057295fa251152a0297ece5519850f
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:22 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:40 +01:00

x86/mtrr: Modify a x86_model check to an Intel VFM check

Simplify one of the last few Intel x86_model checks in arch/x86 by
substituting it with a VFM one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-5-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 6be3cad..e2c6b47 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -13,6 +13,7 @@
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
@@ -1026,8 +1027,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
 			pr_warn("mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);

