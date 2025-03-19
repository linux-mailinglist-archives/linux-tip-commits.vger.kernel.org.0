Return-Path: <linux-tip-commits+bounces-4354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149FA68AA4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF71C7A3E3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D825A330;
	Wed, 19 Mar 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKlSFc8K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNt9DwcS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BB259C89;
	Wed, 19 Mar 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382229; cv=none; b=rnKIPa1CUayW40kzScSYbPGMWg+7GzRXFRKo5a4zGjHegD87WT4ci6HvlADKtGEHAhvQguhF2cs5xNn+qwOpYQWp7aj37VwRdgGYf5uOJwKdZRl1YwwQI4K7qlD8tUvOD/fo5gK+aRVCWDUBU7/CQ/ETd/Mmc1Z/fNSjuU5eKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382229; c=relaxed/simple;
	bh=Bzr5iUpNFSWZcevi7IsFDktHJwwlMF9u9EMqBkziGeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=czeH1GSs7cvMYL53Hxkxwab1NYLarH29nH4EXyzAZpwcoLGJACVjMhj8qpsKgZEkwiX7rVQmKT0By5ADSMZNRhF3FqYtfYOZ2+4NMkmlptrtT2FsH8qztcV39RSTvcFK7/tY55FSpEnbIU4S8gcEg6hyC7EEIri4W3U9Im96K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKlSFc8K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNt9DwcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+y3jel6eq1ao/U8bHEHkC3oDFEZdhn7eS44KXxeiZA=;
	b=ZKlSFc8KnAowBju5lScSIeLMoQSqF4WDPQsWiP9upyh8P3+wyqwxqERtJL5Opg62QeUttD
	bAdPAJcMApR62/0ro2jxtsAY05QIAJRuzqwGg9CP3H2knc+aqIFCcnvCs8vaR53vNf7x1p
	DNTUbfh3b4KiyEK7nMjilkaFjUlO7FwF78i8RSOuP02hlgpvscSDySHtAwNgTdk9WCa9T1
	vdBnauvp+KceNklRhc6YFAuz3sxLFOX1Ls54NQENTHHG+P2uLhBHVDLLvGYmyTIBQ01AG3
	ScCNYXaePaIB+VqoDueck82YdK1D90bGecULosJ1aZbHEnyltvQmnH/XY6JCQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+y3jel6eq1ao/U8bHEHkC3oDFEZdhn7eS44KXxeiZA=;
	b=PNt9DwcS5weOiBKPY8RrrhJvuCq1HEfaiizuMs31d2+YUdJvlYV7LNoCDtADtzsrQ8LiEw
	YixRfBJ8VgTZjDAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-6-mingo@kernel.org>
References: <20250317221824.3738853-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222478.14745.17077013245719326242.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a46f322661857d58b93f557bcb708260f18c18fd
Gitweb:        https://git.kernel.org/tip/a46f322661857d58b93f557bcb708260f18c18fd
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:28 +01:00

x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>

Use u32 instead of uint32_t in hypervisor_cpuid_base().

Yes, uint32_t is used in Xen code et al, but this is a core x86
architecture header and we should standardize on the type that
is being used overwhelmingly in related x86 architecture code.

The two types are the same so there should be no build warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-6-mingo@kernel.org
---
 arch/x86/include/asm/cpuid/api.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 356db18..9c180c9 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -187,9 +187,9 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 #define for_each_possible_hypervisor_cpuid_base(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
 {
-	uint32_t base, eax, signature[3];
+	u32 base, eax, signature[3];
 
 	for_each_possible_hypervisor_cpuid_base(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);

