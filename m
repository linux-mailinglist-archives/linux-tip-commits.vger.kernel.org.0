Return-Path: <linux-tip-commits+bounces-4131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B40A5D9FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E813B2B2A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEB723F398;
	Wed, 12 Mar 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpg0CrKX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TS+Y5Qr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EF23F377;
	Wed, 12 Mar 2025 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773289; cv=none; b=fFaE0BfNbiHjiFaXHHmCZg8FI8ec3ByD74JjoIkAXiGLV4o/d+jKH3m1E2ix4mCYmU3Ua1uMQs1ZcISF4SRs6hpTwilmygoeinZ867mr5ws5T5/AEdJMerJhxDl3T/xWGIeQhDiN5KlLFf+dGfTtTXcDnZKUfLtWdkYW3CiXT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773289; c=relaxed/simple;
	bh=uzXD8X1GbzGlrb0xCGzBsoDL56yXbEP0MZCttV8i1Ok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DjITXtxNJ6DQ+byhwFTTbxtJaFJYfEymsWhGP4pXceyDUcF5q4hDlTADp+JXUsr/qpSTfiW7OJNOOhaWZaLN++Awdl5l+EiE160cCjEEbxzm4HJEAKUWuKHpIv6LPTJfTWPF1by0EGTSxaXCxbQX3oFpexSg88hM8+o1Pr6mq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpg0CrKX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TS+Y5Qr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 09:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741773286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j9ZZQxMTfPJYMUVua93KqXy2Qxalv/pKd/JtQCFurY=;
	b=kpg0CrKXMVDSmbJTdlXx6VWHT38yKD2cWFw58/8hpZcb+xB6P+vSxqBV+TrSEEv1lO4ual
	arvVdqCZrr4SsHo+1o3UDBxhjxm6qcdCdjrRmw/ij3Z1m2vKYByqYOQCXK4f6itbf09C1m
	yLFWl5c8hJFEPSVHbvl6WUWAsHjZeu4DAhWnaKyMOK1F2gMisb8xU5TLSiPMtFeM+gATCR
	u5Z2SBOStTr5pMUDK8ZFNZ46xErX99p6Flgy6wnd9WuRLdVLsyvIhmAYxQfa/bbj37mCiz
	5J31H+KGtMpop3JUljgQkfVnfek7ygbuJMyfR/bVBZZTlVHLCoc/M7Y2bSnw1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741773286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j9ZZQxMTfPJYMUVua93KqXy2Qxalv/pKd/JtQCFurY=;
	b=3TS+Y5Qr7FqVI+f0UoOUorcxNY/XNng8hEpOYsjTO3dvexMHBByqE6rllF5ZEVyz95Ly83
	fO3Kg9YFTFrs5JBw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174177328557.14745.10103638051920921786.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0a4e4ed87f42e250e4dc126dab38365e0ff1f2fb
Gitweb:        https://git.kernel.org/tip/0a4e4ed87f42e250e4dc126dab38365e0ff1f2fb
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:02:05 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Mar 2025 20:53:29 +01:00

x86/cpu: Fix the description of X86_MATCH_VFM_STEPS()

The comments needs to reflect an implementation change.

No functional change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-1-e8514dcaaff2@linux.intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index ba32e0f..9ebc263 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -209,9 +209,11 @@
 
 #define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
- * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * X86_MATCH_VFM_STEPS - Match encoded vendor/family/model and steppings
+ *			 range.
  * @vfm:	Encoded 8-bits each for vendor, family, model
- * @steppings:	Bitmask of steppings to match
+ * @min_step:	Lowest stepping number to match
+ * @max_step:	Highest stepping number to match
  * @data:	Driver specific data or NULL. The internal storage
  *		format is unsigned long. The supplied value, pointer
  *		etc. is cast to unsigned long internally.

