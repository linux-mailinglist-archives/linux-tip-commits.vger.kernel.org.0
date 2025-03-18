Return-Path: <linux-tip-commits+bounces-4302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AEA67351
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936FF3B65A1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0456920C480;
	Tue, 18 Mar 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVhYMU78";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaeeY6tw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569820B81B;
	Tue, 18 Mar 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299210; cv=none; b=HF1Ce3ZzU75XvzZRgNWs+KAoVyVhe0jmx4YjR7aLRvlSJcJAWB15ZxQ1GIDucVEVj/38eyxGxtfgFMBNJI1RcFBwoRvMlaDWJFXORNxv8syZgMPsZeJTpx/773iPvrhUpW0wExyDkdi5JXVfk0y3dbq612s0E5zttB0FLiH3yA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299210; c=relaxed/simple;
	bh=S2vAjC9fBCvpYH8lJSRyWp3zahy5VhyvT7zwkt/cTmE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gAJu56KI4Egmzd3JMcIutxGWdmC7+yqAOOiz5f2cQ9DXtt/6on1MA3HnulB+2yfTZKB59anWZM7eNAUZ91J2UsQUDTtkLSUkKVsryybRNdzJ/ATrAP1aDaViF43vjYg/DGzJOqreT6mzICuLNqMqT6Nw50H9LKeW0p1CWphdSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kVhYMU78; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaeeY6tw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 12:00:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742299207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDHfK2NEQRmjhmKvdiCY8ZFis81FKVXtt++yTkzUzzU=;
	b=kVhYMU78pIG/+fxBeaOcK1V8kfHMHlnAXWgJiRfhang0s+0dNvdCznDzUpe8iejkHnfxIv
	bWI019U/WheVtTPq6oc/5v5gWkY3wzXiD+rWV9Z4Qdh7gAjBo6wgKspyM/ZhGZabb8XE8+
	Lu97YhbNoU8qDST0Y9ef6jMhxwsxThjoOXJ5qIlQ0xzFs0KhujDzg8QLSyEzNn4QUYd/5w
	QLApcObA5nUiAjVJHSbhOOGuOaoErc9iZbtJs1VLk+xbRSJF/uVaJ+ujmcGkAeyA1eLTTI
	vL+Y3Y8WBcVgY0pT2yvJwNUvuVqoTA50+8NSTBD1TL6k/Th5/xC8mQzxYg4PqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742299207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDHfK2NEQRmjhmKvdiCY8ZFis81FKVXtt++yTkzUzzU=;
	b=OaeeY6twbZ8jNH9TUEP2DMoyvHIMlY08mWzxpHxyzfNrxzzf+4uLa6JyjMVIeOs6ppJT5b
	rarKmgvONy9QZCBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>
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
Message-ID: <174229920086.14745.17963109516803386627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ba501f14e1e6dcc94ff0276301e997ae28e3f4b3
Gitweb:        https://git.kernel.org/tip/ba501f14e1e6dcc94ff0276301e997ae28e3f4b3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 09:35:58 +01:00

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

