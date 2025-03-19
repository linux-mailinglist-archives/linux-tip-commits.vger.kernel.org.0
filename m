Return-Path: <linux-tip-commits+bounces-4353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABEA68AC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9671B8856D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68425A2BA;
	Wed, 19 Mar 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxYbrFn4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXwWwxiJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A54254B03;
	Wed, 19 Mar 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382228; cv=none; b=SkEhjIqGipVyZ5otbo56NSs1hT02ZcA7XvaYEEVGDKkHNj6vNZDjMSU6fsFMRk6d61CSAuyHyasw2jLDNVWz8E4Kg4QibW+xnIl8LJVvECwSvf7ZJU5WjIvFwgTfNGomaB4ur2OEZXJ+UWS2+Un6BsM3e7PosqKKITVoev7ILTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382228; c=relaxed/simple;
	bh=3JI9FQNJgA9Lf3sAFeVZKLeYWzWdBGQhaZbP5ieZDCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VvoRKFZsqX6doQhIEVvgB+Qbo9CjatNnzW63GxGRvdg6fOQrQGzjmcCNicQYMMxIJZFTK6fd7EG3JUrIvPK6JB+382ku/BNc/kT7ZpB72DI9AHnjV7JF4j9tjJDMSf8j3Y/nd5DFgVvL6YsQ8may+pvBAZeHdhVAFCidMa4qxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxYbrFn4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXwWwxiJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKDqtRefp6x4H0S88mxNf5mplgDKqh5R2V5mnVLsr+A=;
	b=GxYbrFn48Oau6YG9ikJ4nueDTEFpL/skky1lvPrivX/TnuA9E7P8fBOoU6yaWV6nqrfF/d
	DOCjlYkT0vbWk17kn4l2d0pyrtRNqvxv5n3GooE1prCOFhPnciCH87MRLis0gzIIjggnoK
	u18+2o9wjvovBNLbXuxQndSyP+XDFYXLLF08JtnYgx25OF/7DrPEEXy1fPRPwhRN8JNJgj
	kDkHvnkcBmqQeRrAeuEHPqAVdd2hyHXiumgAJDqXUeb3I1zQtRc9t1/hhUTc4/rd2zOaoU
	tw/WEBzdMmOP5N8hIOP4UciEQaV32uBF4ZVbGFfe7kKXo11SdzJuZ9Pu8yC5mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKDqtRefp6x4H0S88mxNf5mplgDKqh5R2V5mnVLsr+A=;
	b=pXwWwxiJYkt1rHtFHzOFMWjrbzWSO7Dx9RYnY56r4XoQ05xYgpFrmhrZ7+GBhXFs/fqtOh
	N+eYYMGVmfixNlDQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Fix 32-bit APIC initialization for extended
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
Message-ID: <174238222411.14745.11054334410746324314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     680d9b2a56681bc63eb7d2109700536d494b6c8c
Gitweb:        https://git.kernel.org/tip/680d9b2a56681bc63eb7d2109700536d494b6c8c
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:19 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:29 +01:00

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

