Return-Path: <linux-tip-commits+bounces-6252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC67B27E08
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 12:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A5189AE49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20292FCC1F;
	Fri, 15 Aug 2025 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaIoCn3R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+14F+ukF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADB2FCBE6;
	Fri, 15 Aug 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252689; cv=none; b=OBZdPV/1ouh5qteCvIjwAICaG3NVemcWjRjRXAZ4Zv/GPpF4NG5DVlp1ziO+30a/bA8+desieZKiHfiKS65NA5mnt0wTuXVX0ZrWKSYjtpuZSCGv5VBBiuooYtpvAVEMKrHB+2xif6mPbVWKcMFo8WD+0UKcF2+vl312e4a4bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252689; c=relaxed/simple;
	bh=PBoXPGnAOWb+fVOrpPhlTiRaZSoZ2vCeniL2WaMcJtA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j3iEbD7eCLant/azoR6CYkn/bkPxYlUU0ls6bcVleanKvKlXZPt1L0Nk2zVvJRMi4HRYvKMvmlGjo+Zfoph89q6WYzAI+N6w5Z7s4RT1hGH95AZ52FiSwOip8kK4LYFlQXGBCY3DSL9nz7DqZnKHiaRMO5EiGaj0Ggo6Cd2MfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaIoCn3R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+14F+ukF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 10:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755252686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4z+FAvE9V+jZF6k+PmGBnuf6ZsMfp0E49fCaBJdqvk=;
	b=XaIoCn3RDiqdz+yK20K3ExdlswzBitkgr/ESp8tNB/rE5NK7XcOcdNASgAIfZU0wTJiMB6
	HTPoeKylaewiO4pfWZVTUpKkPXcKQALz5OpXqGQQTj0q4b1aNiXW8IxzBXQVqbTCRf2+Jv
	vBQUx3jiQPCBlFvI3CVETvrQpOsn9BBI2HBzvxRWuiemtXQyTF6PR2sW6ssCEinyCIjBEm
	Sh8L2m/VOfXRW+Gllpgv9JymNuBwRkfP0UPCNTE7dAAi39gf5QYlBcou7dFH2v7YlDl8k6
	UECSXnA5WgY1TOGd5QvOUewhoVH2/G9Ye5g6uQHFN5inydhKSIlwxofBE7c4uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755252686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4z+FAvE9V+jZF6k+PmGBnuf6ZsMfp0E49fCaBJdqvk=;
	b=+14F+ukFTNaChJpadn2z/svs9gPmqGLIERhJ2r1LvL6OxxFcp7S9iQgB42veWR89jquq/r
	AuaCqtZpOZ9KYyBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpuid: Remove transitional <asm/cpuid.h> header
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250815070227.19981-2-darwi@linutronix.de>
References: <20250815070227.19981-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175525268515.1420.17935032400077427387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f6d34f02ebf8eb27f209efb821df998333a29339
Gitweb:        https://git.kernel.org/tip/f6d34f02ebf8eb27f209efb821df998333a=
29339
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 15 Aug 2025 09:01:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 11:46:47 +02:00

x86/cpuid: Remove transitional <asm/cpuid.h> header

All CPUID call sites were updated at commit:

    968e30006807 ("x86/cpuid: Set <asm/cpuid/api.h> as the main CPUID header")

to include <asm/cpuid/api.h> instead of <asm/cpuid.h>.

The <asm/cpuid.h> header was still retained as a wrapper, just in case
some new code in -next started using it.  Now that everything is merged
to Linus' tree, remove the header.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250815070227.19981-2-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid.h | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/x86/include/asm/cpuid.h

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
deleted file mode 100644
index d5749b2..0000000
--- a/arch/x86/include/asm/cpuid.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_X86_CPUID_H
-#define _ASM_X86_CPUID_H
-
-#include <asm/cpuid/api.h>
-
-#endif /* _ASM_X86_CPUID_H */

